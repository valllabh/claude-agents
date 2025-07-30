#!/bin/bash

# Claude Code Agents Installation Script
# Installs agents from local folder or GitHub releases to Claude Code agents directory

set -e

# Configuration
GITHUB_REPO="valllabh/claude-agents"
LOCAL_AGENTS_DIR="./claude/agents"
DOWNLOAD_DIR="/tmp/claude-agents-download"

# Installation directories will be set by user choice
CLAUDE_DIR=""
BACKUP_DIR=""
SYSTEM_AGENTS_DIR=""

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
        curl -s "$api_url" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
    elif command -v wget >/dev/null 2>&1; then
        wget -qO- "$api_url" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
    else
        log_error "Neither curl nor wget is available for downloading"
        return 1
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
        if ! curl -L -o "$DOWNLOAD_DIR/claude-agents.zip" "$download_url"; then
            log_error "Failed to download release from $download_url"
            return 1
        fi
    elif command -v wget >/dev/null 2>&1; then
        if ! wget -O "$DOWNLOAD_DIR/claude-agents.zip" "$download_url"; then
            log_error "Failed to download release from $download_url"
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
    if ! unzip -q "$DOWNLOAD_DIR/claude-agents.zip" -d "$DOWNLOAD_DIR"; then
        log_error "Failed to extract downloaded file"
        return 1
    fi
    
    # Verify agents directory exists in extracted content
    if [ ! -d "$DOWNLOAD_DIR/agents" ]; then
        log_error "agents directory not found in downloaded release"
        return 1
    fi
    
    log_success "Successfully downloaded and extracted release $tag"
    return 0
}

get_installed_version() {
    local version_file="$CLAUDE_DIR/VERSION"
    if [ -f "$version_file" ]; then
        cat "$version_file"
    else
        echo "unknown"
    fi
}

# Prompt user for installation location
prompt_installation_location() {
    local project_claude_dir="./.claude"
    local user_claude_dir="$HOME/.claude"
    
    echo ""
    log_info "Choose installation location for Claude Code agents:"
    echo ""
    echo "1. Current project directory: $project_claude_dir/agents"
    echo "   - Agents available only in this project"
    echo "   - Good for project-specific agent configurations"
    echo ""
    echo "2. User system directory: $user_claude_dir/agents"
    echo "   - Agents available globally for all Claude Code sessions"
    echo "   - Recommended for general use"
    echo ""
    
    while true; do
        printf "Enter your choice (1 or 2): "
        read -r choice
        
        case "$choice" in
            1)
                CLAUDE_DIR="$project_claude_dir"
                SYSTEM_AGENTS_DIR="$CLAUDE_DIR/agents"
                BACKUP_DIR="$CLAUDE_DIR/agents-backup-$(date +%Y%m%d-%H%M%S)"
                log_info "Selected: Project directory ($CLAUDE_DIR)"
                break
                ;;
            2)
                CLAUDE_DIR="$user_claude_dir"
                SYSTEM_AGENTS_DIR="$CLAUDE_DIR/agents"
                BACKUP_DIR="$CLAUDE_DIR/agents-backup-$(date +%Y%m%d-%H%M%S)"
                log_info "Selected: User system directory ($CLAUDE_DIR)"
                break
                ;;
            *)
                log_warning "Invalid choice. Please enter 1 or 2."
                ;;
        esac
    done
    
    echo ""
}

# Check if local agents directory exists
check_local_agents() {
    if [ ! -d "$LOCAL_AGENTS_DIR" ]; then
        log_error "Local agents directory not found: $LOCAL_AGENTS_DIR"
        log_info "Please ensure you're running this script from the project root directory"
        return 1
    fi
    
    local agent_count=$(find "$LOCAL_AGENTS_DIR" -name "*.md" | wc -l)
    if [ "$agent_count" -eq 0 ]; then
        log_error "No agent files found in $LOCAL_AGENTS_DIR"
        return 1
    fi
    
    log_info "Found $agent_count agent files to install"
    return 0
}

# Create system directories if they don't exist
setup_system_directory() {
    if [ ! -d "$CLAUDE_DIR" ]; then
        log_info "Creating Claude directory: $CLAUDE_DIR"
        mkdir -p "$CLAUDE_DIR"
    fi
    
    if [ ! -d "$SYSTEM_AGENTS_DIR" ]; then
        log_info "Creating agents directory: $SYSTEM_AGENTS_DIR"
        mkdir -p "$SYSTEM_AGENTS_DIR"
    else
        log_info "Agents directory exists: $SYSTEM_AGENTS_DIR"
    fi
}

# Backup existing agents if they exist
backup_existing_agents() {
    if [ -d "$SYSTEM_AGENTS_DIR" ] && [ "$(ls -A "$SYSTEM_AGENTS_DIR" 2>/dev/null)" ]; then
        log_info "Backing up existing agents to: $BACKUP_DIR"
        cp -r "$SYSTEM_AGENTS_DIR" "$BACKUP_DIR"
        log_success "Backup created successfully"
    else
        log_info "No existing agents to backup"
    fi
}

# Install agents from local directory
install_agents_local() {
    local source_dir="$LOCAL_AGENTS_DIR"
    log_info "Installing agents from $source_dir to $SYSTEM_AGENTS_DIR"
    
    for agent_file in "$source_dir"/*.md; do
        if [ -f "$agent_file" ]; then
            agent_name=$(basename "$agent_file")
            
            # Skip template files
            if [[ "$agent_name" == "_template.md" ]] || [[ "$agent_name" == "README.md" ]]; then
                continue
            fi
            
            log_info "Installing agent: $agent_name"
            
            # Copy agent file
            cp "$agent_file" "$SYSTEM_AGENTS_DIR/"
            
            # Verify installation
            if [ -f "$SYSTEM_AGENTS_DIR/$agent_name" ]; then
                log_success "Successfully installed: $agent_name"
            else
                log_error "Failed to install: $agent_name"
            fi
        fi
    done
}

# Install agents from GitHub download
install_agents_github() {
    local source_dir="$DOWNLOAD_DIR/agents"
    log_info "Installing agents from downloaded release to $SYSTEM_AGENTS_DIR"
    
    for agent_file in "$source_dir"/*.md; do
        if [ -f "$agent_file" ]; then
            agent_name=$(basename "$agent_file")
            
            log_info "Installing agent: $agent_name"
            
            # Copy agent file
            cp "$agent_file" "$SYSTEM_AGENTS_DIR/"
            
            # Verify installation
            if [ -f "$SYSTEM_AGENTS_DIR/$agent_name" ]; then
                log_success "Successfully installed: $agent_name"
            else
                log_error "Failed to install: $agent_name"
            fi
        fi
    done
    
    # Copy VERSION file if it exists
    if [ -f "$DOWNLOAD_DIR/VERSION" ]; then
        cp "$DOWNLOAD_DIR/VERSION" "$CLAUDE_DIR/"
        log_info "Installed version information"
    fi
}

# Verify installation
verify_installation() {
    log_info "Verifying installation..."
    
    local installed_count=0
    
    if [ -d "$SYSTEM_AGENTS_DIR" ]; then
        for agent_file in "$SYSTEM_AGENTS_DIR"/*.md; do
            if [ -f "$agent_file" ]; then
                agent_name=$(basename "$agent_file" .md)
                installed_count=$((installed_count + 1))
                log_success "✓ $agent_name installed"
            fi
        done
    fi
    
    if [ "$installed_count" -gt 0 ]; then
        log_success "$installed_count agents installed successfully!"
        return 0
    else
        log_error "No agents were installed"
        return 1
    fi
}

# List installed agents
list_agents() {
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

# Main execution for local installation
main_local() {
    log_info "Starting Claude Code Agents Installation (Local)"
    log_info "=============================================="
    
    if ! check_local_agents; then
        log_error "Local installation failed - agents not found"
        exit 1
    fi
    
    prompt_installation_location
    setup_system_directory
    backup_existing_agents
    install_agents_local
    
    if verify_installation; then
        echo
        list_agents
        echo
        log_success "Local installation completed successfully!"
        log_info "You can now use these agents with Claude Code"
        log_info "Example: claude \"use analyst agent: help\""
    else
        log_error "Installation completed with errors"
        exit 1
    fi
}

# Main execution for GitHub installation
main_github() {
    local tag="$1"
    
    log_info "Starting Claude Code Agents Installation (GitHub)"
    log_info "==============================================="
    
    if [ -z "$tag" ]; then
        log_info "Fetching latest release information..."
        tag=$(get_latest_release "$GITHUB_REPO")
        if [ -z "$tag" ]; then
            log_error "Failed to get latest release information"
            exit 1
        fi
        log_info "Latest release: $tag"
    fi
    
    prompt_installation_location
    
    # Check if we already have this version
    local current_version=$(get_installed_version)
    if [ "$current_version" = "$tag" ]; then
        log_info "Version $tag is already installed"
        list_agents
        exit 0
    fi
    
    if ! download_and_extract_release "$GITHUB_REPO" "$tag"; then
        log_error "Failed to download release"
        exit 1
    fi
    
    setup_system_directory
    backup_existing_agents
    install_agents_github
    
    if verify_installation; then
        echo
        list_agents
        echo
        log_success "GitHub installation completed successfully!"
        log_info "You can now use these agents with Claude Code"
        log_info "Example: claude \"use analyst agent: help\""
    else
        log_error "Installation completed with errors"
        exit 1
    fi
    
    # Cleanup
    rm -rf "$DOWNLOAD_DIR"
}

# Check for updates
check_updates() {
    log_info "Checking for updates..."
    
    # Check both possible locations
    local user_version="unknown"
    local project_version="unknown"
    
    if [ -f "$HOME/.claude/VERSION" ]; then
        user_version=$(cat "$HOME/.claude/VERSION")
    fi
    
    if [ -f "./.claude/VERSION" ]; then
        project_version=$(cat "./.claude/VERSION")
    fi
    
    local latest_version=$(get_latest_release "$GITHUB_REPO")
    
    if [ -z "$latest_version" ]; then
        log_error "Failed to check for updates"
        exit 1
    fi
    
    echo "Latest version: $latest_version"
    echo "User system version: $user_version"
    echo "Project version: $project_version"
    
    local needs_update=false
    if [ "$user_version" != "$latest_version" ] && [ "$user_version" != "unknown" ]; then
        log_info "User system update available: $user_version → $latest_version"
        needs_update=true
    fi
    
    if [ "$project_version" != "$latest_version" ] && [ "$project_version" != "unknown" ]; then
        log_info "Project update available: $project_version → $latest_version"
        needs_update=true
    fi
    
    if [ "$needs_update" = true ]; then
        echo ""
        echo "To update, run: $0 --from-github"
    else
        log_success "All installations are up to date!"
    fi
}

# Handle command line arguments
case "${1:-}" in
    --help|-h)
        echo "Claude Code Agents Installation Script"
        echo ""
        echo "Usage: $0 [OPTIONS]"
        echo ""
        echo "Options:"
        echo "  --help, -h         Show this help message"
        echo "  --from-github      Install latest release from GitHub (recommended)"
        echo "  --from-github TAG  Install specific release tag from GitHub"
        echo "  --local            Install from local ./claude/agents directory"
        echo "  --check-updates    Check for updates without installing"
        echo "  --list             List currently installed agents"
        echo "  --dry-run          Show what would be installed without making changes"
        echo ""
        echo "Installation locations (you will be prompted to choose):"
        echo "  Project: ./.claude/agents (current project only)"
        echo "  System: ~/.claude/agents (available globally)"
        echo ""
        echo "Examples:"
        echo "  $0 --from-github              # Install latest release"
        echo "  $0 --from-github v1.2.0       # Install specific version"
        echo "  $0 --local                    # Install from local files"
        echo "  $0 --check-updates            # Check for updates"
        exit 0
        ;;
    --from-github)
        if [ -n "$2" ]; then
            main_github "$2"
        else
            main_github
        fi
        ;;
    --local)
        main_local
        ;;
    --check-updates)
        check_updates
        ;;
    --dry-run)
        log_info "DRY RUN MODE - No changes will be made"
        if check_local_agents; then
            log_info "Would install the following agents from local directory:"
            for agent_file in "$LOCAL_AGENTS_DIR"/*.md; do
                if [ -f "$agent_file" ]; then
                    agent_name=$(basename "$agent_file" .md)
                    echo "  - $agent_name"
                fi
            done
        fi
        
        log_info "Latest release from GitHub:"
        local latest=$(get_latest_release "$GITHUB_REPO")
        if [ -n "$latest" ]; then
            echo "  - $latest"
        else
            echo "  - Unable to fetch release information"
        fi
        exit 0
        ;;
    --list)
        log_info "Checking for installed agents..."
        echo ""
        
        # Check user system directory
        if [ -d "$HOME/.claude/agents" ] && [ -n "$(ls -A "$HOME/.claude/agents" 2>/dev/null)" ]; then
            echo "User system agents (~/.claude/agents):"
            CLAUDE_DIR="$HOME/.claude"
            SYSTEM_AGENTS_DIR="$CLAUDE_DIR/agents"
            list_agents
            echo ""
        fi
        
        # Check project directory  
        if [ -d "./.claude/agents" ] && [ -n "$(ls -A "./.claude/agents" 2>/dev/null)" ]; then
            echo "Project agents (./.claude/agents):"
            CLAUDE_DIR="./.claude"
            SYSTEM_AGENTS_DIR="$CLAUDE_DIR/agents"
            list_agents
            echo ""
        fi
        
        # If no agents found
        if [ ! -d "$HOME/.claude/agents" ] && [ ! -d "./.claude/agents" ]; then
            log_info "No agents installed yet"
        elif [ -z "$(ls -A "$HOME/.claude/agents" 2>/dev/null)" ] && [ -z "$(ls -A "./.claude/agents" 2>/dev/null)" ]; then
            log_info "No agents installed yet"
        fi
        exit 0
        ;;
    "")
        # Default behavior - prefer GitHub if possible, fallback to local
        log_info "No installation method specified. Checking GitHub for latest release..."
        if get_latest_release "$GITHUB_REPO" >/dev/null 2>&1; then
            log_info "GitHub releases available. Using --from-github (recommended)"
            log_info "For local installation, use: $0 --local"
            echo ""
            main_github
        else
            log_warning "GitHub releases not available. Falling back to local installation..."
            main_local
        fi
        ;;
    *)
        log_error "Unknown option: $1"
        log_info "Use --help for usage information"
        exit 1
        ;;
esac