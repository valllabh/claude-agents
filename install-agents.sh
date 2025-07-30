#!/bin/bash

# Claude Code Agents Installation Script
# Installs agents from local folder to system Claude Code agents directory

set -e

# Configuration
LOCAL_AGENTS_DIR="./claude-code-agents/agents"
# Default to test project if it exists, otherwise use system directory
if [ -d "./test-project" ]; then
    SYSTEM_AGENTS_DIR="./test-project/.claude/agents"
    BACKUP_DIR="./test-project/.claude/agents-backup-$(date +%Y%m%d-%H%M%S)"
else
    SYSTEM_AGENTS_DIR="$HOME/.claude/agents"
    BACKUP_DIR="$HOME/.claude/agents-backup-$(date +%Y%m%d-%H%M%S)"
fi

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

# Check if local agents directory exists
check_local_agents() {
    if [ ! -d "$LOCAL_AGENTS_DIR" ]; then
        log_error "Local agents directory not found: $LOCAL_AGENTS_DIR"
        log_info "Please ensure you're running this script from the project root directory"
        exit 1
    fi
    
    local agent_count=$(find "$LOCAL_AGENTS_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l)
    if [ "$agent_count" -eq 0 ]; then
        log_error "No agents found in $LOCAL_AGENTS_DIR"
        exit 1
    fi
    
    log_info "Found $agent_count agents to install"
}

# Create system agents directory if it doesn't exist
setup_system_directory() {
    if [ ! -d "$SYSTEM_AGENTS_DIR" ]; then
        log_info "Creating system agents directory: $SYSTEM_AGENTS_DIR"
        mkdir -p "$SYSTEM_AGENTS_DIR"
    else
        log_info "System agents directory exists: $SYSTEM_AGENTS_DIR"
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

# Install agents
install_agents() {
    log_info "Installing agents from $LOCAL_AGENTS_DIR to $SYSTEM_AGENTS_DIR"
    
    for agent_dir in "$LOCAL_AGENTS_DIR"/*; do
        if [ -d "$agent_dir" ]; then
            agent_name=$(basename "$agent_dir")
            
            # Skip template and README
            if [ "$agent_name" = "_template.md" ] || [ "$agent_name" = "README.md" ]; then
                continue
            fi
            
            log_info "Installing agent: $agent_name"
            
            # Copy agent directory
            cp -r "$agent_dir" "$SYSTEM_AGENTS_DIR/"
            
            # Verify installation
            if [ -d "$SYSTEM_AGENTS_DIR/$agent_name" ]; then
                log_success "Successfully installed: $agent_name"
            else
                log_error "Failed to install: $agent_name"
            fi
        fi
    done
}

# Verify installation
verify_installation() {
    log_info "Verifying installation..."
    
    local installed_count=0
    local total_agents=0
    
    for agent_dir in "$LOCAL_AGENTS_DIR"/*; do
        if [ -d "$agent_dir" ]; then
            agent_name=$(basename "$agent_dir")
            
            # Skip template and README
            if [ "$agent_name" = "_template.md" ] || [ "$agent_name" = "README.md" ]; then
                continue
            fi
            
            total_agents=$((total_agents + 1))
            
            if [ -d "$SYSTEM_AGENTS_DIR/$agent_name" ]; then
                installed_count=$((installed_count + 1))
                log_success "✓ $agent_name installed"
            else
                log_error "✗ $agent_name missing"
            fi
        fi
    done
    
    log_info "Installation summary: $installed_count/$total_agents agents installed"
    
    if [ "$installed_count" -eq "$total_agents" ]; then
        log_success "All agents installed successfully!"
        return 0
    else
        log_error "Some agents failed to install"
        return 1
    fi
}

# List installed agents
list_agents() {
    log_info "Installed agents:"
    for agent_dir in "$SYSTEM_AGENTS_DIR"/*; do
        if [ -d "$agent_dir" ]; then
            agent_name=$(basename "$agent_dir")
            
            # Check if subagent.md exists
            if [ -f "$agent_dir/subagent.md" ]; then
                # Extract agent description from subagent.md
                description=$(grep -A 1 "## Description" "$agent_dir/subagent.md" 2>/dev/null | tail -n 1 | sed 's/^[[:space:]]*//' || echo "No description available")
                echo -e "  ${GREEN}$agent_name${NC}: $description"
            else
                echo -e "  ${YELLOW}$agent_name${NC}: (missing subagent.md)"
            fi
        fi
    done
}

# Main execution
main() {
    log_info "Starting Claude Code Agents Installation"
    log_info "=================================="
    
    check_local_agents
    setup_system_directory
    backup_existing_agents
    install_agents
    
    if verify_installation; then
        echo
        list_agents
        echo
        log_success "Installation completed successfully!"
        log_info "You can now use these agents with Claude Code"
        log_info "Example: claude-code --agent analyst"
    else
        log_error "Installation completed with errors"
        exit 1
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
        echo "  --help, -h     Show this help message"
        echo "  --dry-run      Show what would be installed without making changes"
        echo "  --list         List currently installed agents"
        echo ""
        echo "This script installs Claude Code agents from the local ./claude-code-agents/agents"
        echo "directory to the system Claude Code agents directory at ~/.config/claude-code/agents"
        exit 0
        ;;
    --dry-run)
        log_info "DRY RUN MODE - No changes will be made"
        check_local_agents
        log_info "Would install the following agents:"
        for agent_dir in "$LOCAL_AGENTS_DIR"/*; do
            if [ -d "$agent_dir" ]; then
                agent_name=$(basename "$agent_dir")
                if [ "$agent_name" != "_template.md" ] && [ "$agent_name" != "README.md" ]; then
                    echo "  - $agent_name"
                fi
            fi
        done
        exit 0
        ;;
    --list)
        if [ -d "$SYSTEM_AGENTS_DIR" ]; then
            list_agents
        else
            log_info "No agents installed yet"
        fi
        exit 0
        ;;
    "")
        main
        ;;
    *)
        log_error "Unknown option: $1"
        log_info "Use --help for usage information"
        exit 1
        ;;
esac