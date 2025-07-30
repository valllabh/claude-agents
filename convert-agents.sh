#!/bin/bash

# Convert BMAD-style agents to proper Claude Code format
# This script converts the multi-file agent structure to single .md files with YAML frontmatter

set -e

# Configuration
SOURCE_DIR="./claude-code-agents/agents"
TARGET_DIR="./test-project/.claude/agents"

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

# Extract description from subagent.md
extract_description() {
    local subagent_file="$1"
    
    if [ -f "$subagent_file" ]; then
        # Look for description after "## Description"
        sed -n '/^## Description$/,/^## /p' "$subagent_file" | sed '1d;$d' | sed 's/^[[:space:]]*//' | tr '\n' ' ' | sed 's/[[:space:]]*$//'
    else
        echo "No description available"
    fi
}

# Extract persona information
extract_persona() {
    local subagent_file="$1"
    
    if [ -f "$subagent_file" ]; then
        sed -n '/^## Persona$/,/^## /p' "$subagent_file" | sed '1d;$d'
    fi
}

# Extract commands information
extract_commands() {
    local subagent_file="$1"
    
    if [ -f "$subagent_file" ]; then
        sed -n '/^## Commands$/,/^## Workflows$/p' "$subagent_file" | sed '$d'
    fi
}

# Extract workflows information
extract_workflows() {
    local subagent_file="$1"
    
    if [ -f "$subagent_file" ]; then
        sed -n '/^## Workflows$/,/^## /p' "$subagent_file" | sed '$d'
    fi
}

# Extract tools information
extract_tools() {
    local subagent_file="$1"
    
    if [ -f "$subagent_file" ]; then
        if grep -q "## Tools Available" "$subagent_file"; then
            sed -n '/^## Tools Available$/,/^## /p' "$subagent_file" | sed '1d;$d' | grep -o '[A-Z][a-zA-Z]*' | tr '\n' ',' | sed 's/,$//'
        else
            echo "Read, Write, Edit, Grep, Glob, WebFetch, WebSearch, TodoWrite, Bash"
        fi
    else
        echo "Read, Write, Edit, Grep, Glob, WebFetch, WebSearch, TodoWrite, Bash"
    fi
}

# Convert a single agent
convert_agent() {
    local agent_name="$1"
    local source_path="$SOURCE_DIR/$agent_name"
    local target_file="$TARGET_DIR/${agent_name}.md"
    
    log_info "Converting agent: $agent_name"
    
    if [ ! -d "$source_path" ]; then
        log_error "Source agent directory not found: $source_path"
        return 1
    fi
    
    local subagent_file="$source_path/subagent.md"
    if [ ! -f "$subagent_file" ]; then
        log_error "subagent.md not found for: $agent_name"
        return 1
    fi
    
    # Extract information
    local description=$(extract_description "$subagent_file")
    local tools=$(extract_tools "$subagent_file")
    
    # Start building the new agent file
    {
        echo "---"
        echo "name: $agent_name"
        echo "description: $description"
        echo "tools: $tools"
        echo "---"
        echo ""
        
        # Extract and format the rest of the content
        cat "$subagent_file"
        
    } > "$target_file"
    
    log_success "Converted: $agent_name -> ${agent_name}.md"
}

# Main conversion function
convert_all_agents() {
    log_info "Starting agent conversion from BMAD format to Claude Code format"
    log_info "================================================================"
    
    # Ensure target directory exists
    mkdir -p "$TARGET_DIR"
    
    # Remove old multi-directory structure
    log_info "Cleaning up old agent directories..."
    for old_dir in "$TARGET_DIR"/*; do
        if [ -d "$old_dir" ] && [ ! "${old_dir##*/}" = "*.md" ]; then
            rm -rf "$old_dir"
            log_info "Removed old directory: $(basename "$old_dir")"
        fi
    done
    
    local converted=0
    local failed=0
    
    # Convert each agent
    for agent_dir in "$SOURCE_DIR"/*; do
        if [ -d "$agent_dir" ]; then
            agent_name=$(basename "$agent_dir")
            
            # Skip template and README
            if [ "$agent_name" = "_template.md" ] || [ "$agent_name" = "README.md" ]; then
                continue
            fi
            
            if convert_agent "$agent_name"; then
                converted=$((converted + 1))
            else
                failed=$((failed + 1))
            fi
        fi
    done
    
    log_info "Conversion Summary:"
    log_success "Converted: $converted agents"
    if [ "$failed" -gt 0 ]; then
        log_error "Failed: $failed agents"
    else
        log_info "Failed: $failed agents"
    fi
    
    echo
    log_info "Converted agents are now available in: $TARGET_DIR"
    log_info "Each agent is now a single .md file with YAML frontmatter"
    echo
    
    # List converted agents
    log_info "Available agents:"
    for agent_file in "$TARGET_DIR"/*.md; do
        if [ -f "$agent_file" ]; then
            agent_name=$(basename "$agent_file" .md)
            echo "  - $agent_name"
        fi
    done
}

# Handle command line arguments
case "${1:-}" in
    --help|-h)
        echo "Claude Code Agent Conversion Script"
        echo ""
        echo "Usage: $0 [OPTIONS]"
        echo ""
        echo "Options:"
        echo "  --help, -h     Show this help message"
        echo "  --dry-run      Show what would be converted without making changes"
        echo ""
        echo "This script converts BMAD-style multi-file agents to Claude Code single-file format."
        exit 0
        ;;
    --dry-run)
        log_info "DRY RUN MODE - No changes will be made"
        log_info "Would convert the following agents:"
        for agent_dir in "$SOURCE_DIR"/*; do
            if [ -d "$agent_dir" ]; then
                agent_name=$(basename "$agent_dir")
                if [ "$agent_name" != "_template.md" ] && [ "$agent_name" != "README.md" ]; then
                    echo "  - $agent_name -> ${agent_name}.md"
                fi
            fi
        done
        exit 0
        ;;
    "")
        convert_all_agents
        ;;
    *)
        log_error "Unknown option: $1"
        log_info "Use --help for usage information"
        exit 1
        ;;
esac