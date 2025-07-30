#!/bin/bash

# Test Claude Code Agents Integration
# This script tests that agents are properly integrated with Claude Code in this project

set -e

# Configuration
AGENTS_DIR="./.claude/agents"
TEST_RESULTS_FILE="./claude-agents-integration-test.txt"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

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

log_test_pass() {
    echo -e "${GREEN}[PASS]${NC} $1"
    PASSED_TESTS=$((PASSED_TESTS + 1))
}

log_test_fail() {
    echo -e "${RED}[FAIL]${NC} $1"
    FAILED_TESTS=$((FAILED_TESTS + 1))
}

# Initialize test results
init_test_results() {
    echo "Claude Code Agents Integration Test Results" > "$TEST_RESULTS_FILE"
    echo "Generated: $(date)" >> "$TEST_RESULTS_FILE"
    echo "Project: $(pwd)" >> "$TEST_RESULTS_FILE"
    echo "=========================================" >> "$TEST_RESULTS_FILE"
    echo "" >> "$TEST_RESULTS_FILE"
}

# Test project structure
test_project_structure() {
    log_info "Testing project structure..."
    
    # Test .claude directory exists
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if [ -d "./.claude" ]; then
        log_test_pass "Claude directory exists"
        echo "✓ .claude directory exists" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "Claude directory missing"
        echo "✗ .claude directory missing" >> "$TEST_RESULTS_FILE"
        return 1
    fi
    
    # Test agents directory exists
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if [ -d "$AGENTS_DIR" ]; then
        log_test_pass "Agents directory exists"
        echo "✓ Agents directory exists" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "Agents directory missing"
        echo "✗ Agents directory missing" >> "$TEST_RESULTS_FILE"
        return 1
    fi
    
    # Test CLAUDE.md exists
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if [ -f "./CLAUDE.md" ]; then
        log_test_pass "CLAUDE.md exists"
        echo "✓ CLAUDE.md exists" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "CLAUDE.md missing"
        echo "✗ CLAUDE.md missing" >> "$TEST_RESULTS_FILE"
    fi
    
    # Note: Claude Code doesn't use settings.json in .claude directory
    # Configuration is handled through CLAUDE.md and agent files directly
}

# Test individual agent
test_agent() {
    local agent_name="$1"
    local agent_path="$AGENTS_DIR/$agent_name"
    
    log_info "Testing agent: $agent_name"
    echo "" >> "$TEST_RESULTS_FILE"
    echo "Agent: $agent_name" >> "$TEST_RESULTS_FILE"
    echo "----------------" >> "$TEST_RESULTS_FILE"
    
    # Test agent directory exists
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if [ -d "$agent_path" ]; then
        log_test_pass "$agent_name: Directory exists"
        echo "  ✓ Directory exists" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: Directory missing"
        echo "  ✗ Directory missing" >> "$TEST_RESULTS_FILE"
        return 1
    fi
    
    # Test subagent.md exists
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if [ -f "$agent_path/subagent.md" ]; then
        log_test_pass "$agent_name: subagent.md exists"
        echo "  ✓ subagent.md exists" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: subagent.md missing"
        echo "  ✗ subagent.md missing" >> "$TEST_RESULTS_FILE"
    fi
    
    # Test commands directory exists
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if [ -d "$agent_path/commands" ]; then
        log_test_pass "$agent_name: commands directory exists"
        echo "  ✓ commands directory exists" >> "$TEST_RESULTS_FILE"
        
        # Count commands
        local cmd_count=$(find "$agent_path/commands" -name "*.md" | wc -l)
        echo "  → Found $cmd_count command(s)" >> "$TEST_RESULTS_FILE"
        log_info "$agent_name: Found $cmd_count command(s)"
    else
        log_test_fail "$agent_name: commands directory missing"
        echo "  ✗ commands directory missing" >> "$TEST_RESULTS_FILE"
    fi
    
    # Test help command exists
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if [ -f "$agent_path/commands/help.md" ]; then
        log_test_pass "$agent_name: help command exists"
        echo "  ✓ help command exists" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: help command missing"
        echo "  ✗ help command missing" >> "$TEST_RESULTS_FILE"
    fi
    
    # Validate subagent.md structure
    if [ -f "$agent_path/subagent.md" ]; then
        TOTAL_TESTS=$((TOTAL_TESTS + 1))
        if grep -q "## Description" "$agent_path/subagent.md" && \
           grep -q "## Persona" "$agent_path/subagent.md" && \
           grep -q "## Commands" "$agent_path/subagent.md"; then
            log_test_pass "$agent_name: subagent.md has required sections"
            echo "  ✓ subagent.md has required sections" >> "$TEST_RESULTS_FILE"
        else
            log_test_fail "$agent_name: subagent.md missing required sections"
            echo "  ✗ subagent.md missing required sections" >> "$TEST_RESULTS_FILE"
        fi
    fi
}

# Test all agents
test_all_agents() {
    log_info "Testing all installed agents..."
    echo "" >> "$TEST_RESULTS_FILE"
    echo "Individual Agent Tests:" >> "$TEST_RESULTS_FILE"
    echo "======================" >> "$TEST_RESULTS_FILE"
    
    local agent_count=0
    
    for agent_dir in "$AGENTS_DIR"/*; do
        if [ -d "$agent_dir" ]; then
            agent_name=$(basename "$agent_dir")
            agent_count=$((agent_count + 1))
            test_agent "$agent_name"
        fi
    done
    
    log_info "Tested $agent_count agents total"
    echo "" >> "$TEST_RESULTS_FILE"
    echo "Total agents tested: $agent_count" >> "$TEST_RESULTS_FILE"
}

# Test Claude Code integration (if available)
test_claude_integration() {
    log_info "Testing Claude Code integration..."
    echo "" >> "$TEST_RESULTS_FILE"
    echo "Claude Code Integration:" >> "$TEST_RESULTS_FILE"
    echo "========================" >> "$TEST_RESULTS_FILE"
    
    # Check if Claude Code is available
    if command -v claude-code >/dev/null 2>&1; then
        log_success "Claude Code CLI is available"
        echo "✓ Claude Code CLI is available" >> "$TEST_RESULTS_FILE"
        
        TOTAL_TESTS=$((TOTAL_TESTS + 1))
        # Test basic help command
        if claude-code --help >/dev/null 2>&1; then
            log_test_pass "Claude Code help command works"
            echo "✓ Claude Code help command works" >> "$TEST_RESULTS_FILE"
        else
            log_test_fail "Claude Code help command failed"
            echo "✗ Claude Code help command failed" >> "$TEST_RESULTS_FILE"
        fi
        
        # Test if agents are discoverable (this would need specific Claude Code commands)
        log_info "Note: Agent discoverability requires specific Claude Code setup"
        echo "→ Agent discoverability requires specific Claude Code setup" >> "$TEST_RESULTS_FILE"
        
    else
        log_warning "Claude Code CLI not available (install Claude Code to test integration)"
        echo "⚠ Claude Code CLI not available" >> "$TEST_RESULTS_FILE"
        echo "  Install Claude Code CLI to test full integration" >> "$TEST_RESULTS_FILE"
    fi
}

# Test project functionality
test_project_functionality() {
    log_info "Testing project functionality..."
    echo "" >> "$TEST_RESULTS_FILE"
    echo "Project Functionality:" >> "$TEST_RESULTS_FILE"
    echo "=====================" >> "$TEST_RESULTS_FILE"
    
    # Test npm commands
    if [ -f "./package.json" ]; then
        TOTAL_TESTS=$((TOTAL_TESTS + 1))
        if npm test >/dev/null 2>&1; then
            log_test_pass "Project tests pass"
            echo "✓ Project tests pass" >> "$TEST_RESULTS_FILE"
        else
            log_test_fail "Project tests failed"
            echo "✗ Project tests failed" >> "$TEST_RESULTS_FILE"
        fi
        
        TOTAL_TESTS=$((TOTAL_TESTS + 1))
        if node src/index.js >/dev/null 2>&1; then
            log_test_pass "Project runs successfully"
            echo "✓ Project runs successfully" >> "$TEST_RESULTS_FILE"
        else
            log_test_fail "Project failed to run"
            echo "✗ Project failed to run" >> "$TEST_RESULTS_FILE"
        fi
    else
        log_warning "No package.json found, skipping npm tests"
        echo "⚠ No package.json found, skipping npm tests" >> "$TEST_RESULTS_FILE"
    fi
}

# Generate final report
generate_final_report() {
    echo "" >> "$TEST_RESULTS_FILE"
    echo "Final Test Summary:" >> "$TEST_RESULTS_FILE"
    echo "==================" >> "$TEST_RESULTS_FILE"
    echo "Total Tests: $TOTAL_TESTS" >> "$TEST_RESULTS_FILE"
    echo "Passed: $PASSED_TESTS" >> "$TEST_RESULTS_FILE"
    echo "Failed: $FAILED_TESTS" >> "$TEST_RESULTS_FILE"
    
    local success_rate=0
    if [ "$TOTAL_TESTS" -gt 0 ]; then
        success_rate=$((PASSED_TESTS * 100 / TOTAL_TESTS))
    fi
    echo "Success Rate: $success_rate%" >> "$TEST_RESULTS_FILE"
    
    echo ""
    log_info "Final Test Summary:"
    log_info "=================="
    log_info "Total Tests: $TOTAL_TESTS"
    log_success "Passed: $PASSED_TESTS"
    if [ "$FAILED_TESTS" -gt 0 ]; then
        log_error "Failed: $FAILED_TESTS"
    else
        log_info "Failed: $FAILED_TESTS"
    fi
    log_info "Success Rate: $success_rate%"
    echo ""
    log_info "Detailed results saved to: $TEST_RESULTS_FILE"
    
    if [ "$FAILED_TESTS" -eq 0 ]; then
        log_success "All tests passed! Agents are properly installed and configured."
        return 0
    else
        log_error "Some tests failed. Check the detailed report."
        return 1
    fi
}

# Main execution
main() {
    log_info "Starting Claude Code Agents Integration Test"
    log_info "==========================================="
    
    init_test_results
    test_project_structure
    test_all_agents
    test_claude_integration
    test_project_functionality
    
    if generate_final_report; then
        exit 0
    else
        exit 1
    fi
}

# Handle command line arguments
case "${1:-}" in
    --help|-h)
        echo "Claude Code Agents Integration Test"
        echo ""
        echo "Usage: $0 [OPTIONS]"
        echo ""
        echo "Options:"
        echo "  --help, -h     Show this help message"
        echo "  --quick        Run only basic structure tests"
        echo "  --agents-only  Test only agent structure (skip project tests)"
        echo ""
        echo "This script tests that Claude Code agents are properly integrated in this project."
        exit 0
        ;;
    --quick)
        log_info "Running quick tests only..."
        init_test_results
        test_project_structure
        generate_final_report
        ;;
    --agents-only)
        log_info "Testing agents only..."
        init_test_results
        test_project_structure
        test_all_agents
        generate_final_report
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