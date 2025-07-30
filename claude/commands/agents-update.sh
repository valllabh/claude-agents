#!/bin/bash

# /agents-update command implementation
# Updates Claude Code agents from GitHub releases

set -e

# Configuration
GITHUB_REPO="valllabh/claude-agents"
DOWNLOAD_DIR="/tmp/claude-agents-download"
CLAUDE_DIR="$HOME/.claude"
SYSTEM_AGENTS_DIR="$CLAUDE_DIR/agents"
BACKUP_DIR="$CLAUDE_DIR/agents-backup-$(date +%Y%m%d-%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# GitHub functions
get_latest_release() {
    local repo="$1"
    local api_url="https://api.github.com/repos/$repo/releases/latest"
    
    if command -v curl >/dev/null 2>&1; then
        curl -s "$api_url" 2>/dev/null | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' || return 1
    elif command -v wget >/dev/null 2>&1; then
        wget -qO- "$api_url" 2>/dev/null | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' || return 1
    else
        log_error "Neither curl nor wget is available for downloading"
        return 1
    fi
}

get_installed_version() {
    local version_file="$CLAUDE_DIR/VERSION"
    if [ -f "$version_file" ]; then
        cat "$version_file"
    else
        echo "unknown"
    fi
}

download_and_extract_release() {
    local repo="$1"
    local tag="$2"
    local download_url="https://github.com/$repo/releases/download/$tag/claude-agents-$tag.zip"
    
    log_info "Downloading release $tag from GitHub..."
    
    # Clean and create download directory
    rm -rf "$DOWNLOAD_DIR"
    mkdir -p "$DOWNLOAD_DIR"
    
    # Download the release
    if command -v curl >/dev/null 2>&1; then
        if ! curl -L -o "$DOWNLOAD_DIR/claude-agents.zip" "$download_url" 2>/dev/null; then
            log_error "Failed to download release from GitHub"
            return 1
        fi
    elif command -v wget >/dev/null 2>&1; then
        if ! wget -O "$DOWNLOAD_DIR/claude-agents.zip" "$download_url" 2>/dev/null; then
            log_error "Failed to download release from GitHub"
            return 1
        fi
    else
        log_error "Neither curl nor wget is available for downloading"
        return 1
    fi
    
    # Check if unzip is available
    if ! command -v unzip >/dev/null 2>&1; then
        log_error "unzip command not found. Please install unzip to continue."
        return 1
    fi
    
    # Extract the zip file
    log_info "Extracting downloaded release..."
    if ! unzip -q "$DOWNLOAD_DIR/claude-agents.zip" -d "$DOWNLOAD_DIR" 2>/dev/null; then
        log_error "Failed to extract downloaded file"
        return 1
    fi
    
    # Verify agents directory exists in extracted content
    if [ ! -d "$DOWNLOAD_DIR/agents" ]; then
        log_error "agents directory not found in downloaded release"
        return 1
    fi
    
    return 0
}

setup_system_directory() {
    if [ ! -d "$CLAUDE_DIR" ]; then
        log_info "Creating Claude directory: $CLAUDE_DIR"
        mkdir -p "$CLAUDE_DIR"
    fi
    
    if [ ! -d "$SYSTEM_AGENTS_DIR" ]; then
        log_info "Creating agents directory: $SYSTEM_AGENTS_DIR"
        mkdir -p "$SYSTEM_AGENTS_DIR"
    fi
}

backup_existing_agents() {
    if [ -d "$SYSTEM_AGENTS_DIR" ] && [ "$(ls -A "$SYSTEM_AGENTS_DIR" 2>/dev/null)" ]; then
        log_info "Backing up existing agents to: $BACKUP_DIR"
        if cp -r "$SYSTEM_AGENTS_DIR" "$BACKUP_DIR" 2>/dev/null; then
            log_success "Backup created successfully"
        else
            log_error "Failed to create backup"
            return 1
        fi
    else
        log_info "No existing agents to backup"
    fi
}

install_agents_from_download() {
    local source_dir="$DOWNLOAD_DIR/agents"
    log_info "Installing updated agents..."
    
    local installed_count=0
    
    for agent_file in "$source_dir"/*.md; do
        if [ -f "$agent_file" ]; then
            agent_name=$(basename "$agent_file")
            
            log_info "Installing agent: $agent_name"
            
            # Copy agent file
            if cp "$agent_file" "$SYSTEM_AGENTS_DIR/" 2>/dev/null; then
                installed_count=$((installed_count + 1))
                log_success "Successfully installed: $(basename "$agent_name" .md)"
            else
                log_error "Failed to install: $agent_name"
                return 1
            fi
        fi
    done
    
    # Copy VERSION file if it exists
    if [ -f "$DOWNLOAD_DIR/VERSION" ]; then
        if cp "$DOWNLOAD_DIR/VERSION" "$CLAUDE_DIR/" 2>/dev/null; then
            log_info "Updated version information"
        fi
    fi
    
    if [ "$installed_count" -gt 0 ]; then
        log_success "$installed_count agents updated successfully!"
        return 0
    else
        log_error "No agents were installed"
        return 1
    fi
}

list_installed_agents() {
    log_info "Installed agents:"
    
    if [ ! -d "$SYSTEM_AGENTS_DIR" ] || [ -z "$(ls -A "$SYSTEM_AGENTS_DIR" 2>/dev/null)" ]; then
        log_warning "No agents installed"
        return 1
    fi
    
    for agent_file in "$SYSTEM_AGENTS_DIR"/*.md; do
        if [ -f "$agent_file" ]; then
            agent_name=$(basename "$agent_file" .md)
            
            # Try to extract description from the agent file
            description=$(grep -m1 "^*.*specialist" "$agent_file" 2>/dev/null | sed 's/^\*//; s/^[[:space:]]*//' || echo "Claude Code agent")
            echo -e "  ${GREEN}$agent_name${NC}: $description"
        fi
    done
    
    # Show version if available
    local version=$(get_installed_version)
    if [ "$version" != "unknown" ]; then
        echo -e "\n${BLUE}Installed version:${NC} $version"
    fi
}

# Main update function
main() {
    log_info "Checking for agent updates..."
    
    # Get current and latest versions
    local current_version=$(get_installed_version)
    local latest_version=$(get_latest_release "$GITHUB_REPO")
    
    if [ -z "$latest_version" ]; then
        log_error "Failed to get latest release information"
        log_info "Please check your internet connection and try again"
        exit 1
    fi
    
    log_info "Current version: $current_version"
    log_info "Latest version: $latest_version"
    
    # Check if update is needed
    if [ "$current_version" = "$latest_version" ]; then
        log_success "You have the latest version of Claude Code agents!"
        echo ""
        list_installed_agents
        exit 0
    fi
    
    # Update needed
    log_info "Update available: $current_version → $latest_version"
    echo ""
    
    # Download and install update
    if ! download_and_extract_release "$GITHUB_REPO" "$latest_version"; then
        log_error "Failed to download update"
        exit 1
    fi
    
    setup_system_directory
    
    if ! backup_existing_agents; then
        log_error "Failed to backup existing agents"
        exit 1
    fi
    
    if ! install_agents_from_download; then
        log_error "Failed to install updated agents"
        exit 1
    fi
    
    echo ""
    list_installed_agents
    echo ""
    log_success "Agent update completed successfully!"
    log_info "You can now use the updated agents with Claude Code"
    log_info "Example: claude \"use analyst agent: help\""
    
    # Cleanup
    rm -rf "$DOWNLOAD_DIR" 2>/dev/null || true
}

# Execute main function
main "$@"