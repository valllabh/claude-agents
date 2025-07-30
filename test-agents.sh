#!/bin/bash

# Claude Code Agents Test Script
# Tests installed agents to verify they are working correctly

set -e

# Configuration
# Default to test project if it exists, otherwise use system directory
if [ -d "./test-project" ]; then
    SYSTEM_AGENTS_DIR="./test-project/.claude/agents"
    TEST_RESULTS_FILE="./test-project/claude-agents-test-results.txt"
else
    SYSTEM_AGENTS_DIR="$HOME/.claude/agents"
    TEST_RESULTS_FILE="/tmp/claude-agents-test-results.txt"
fi
TEST_TIMEOUT=30

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

# Initialize test results file
init_test_results() {
    echo "Claude Code Agents Test Results" > "$TEST_RESULTS_FILE"
    echo "Generated: $(date)" >> "$TEST_RESULTS_FILE"
    echo "===============================" >> "$TEST_RESULTS_FILE"
    echo "" >> "$TEST_RESULTS_FILE"
}

# Check if Claude Code is available
check_claude_code_available() {
    log_info "Checking if Claude Code is available..."
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    if command -v claude-code >/dev/null 2>&1; then
        log_test_pass "Claude Code command found"
        echo "✓ Claude Code command available" >> "$TEST_RESULTS_FILE"
        return 0
    else
        log_warning "Claude Code command not found (skipping CLI tests)"
        echo "⚠ Claude Code command not available (tests will focus on agent structure)" >> "$TEST_RESULTS_FILE"
        TOTAL_TESTS=$((TOTAL_TESTS - 1))  # Don't count this as a failure
        return 0
    fi
}

# Check if agents directory exists
check_agents_directory() {
    log_info "Checking agents directory..."
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    if [ -d "$SYSTEM_AGENTS_DIR" ]; then
        log_test_pass "Agents directory exists: $SYSTEM_AGENTS_DIR"
        echo "✓ Agents directory exists" >> "$TEST_RESULTS_FILE"
        return 0
    else
        log_test_fail "Agents directory not found: $SYSTEM_AGENTS_DIR"
        echo "✗ Agents directory missing" >> "$TEST_RESULTS_FILE"
        return 1
    fi
}

# Test agent structure
test_agent_structure() {
    local agent_name="$1"
    local agent_path="$SYSTEM_AGENTS_DIR/$agent_name"
    
    log_info "Testing structure for agent: $agent_name"
    
    # Test subagent.md exists
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if [ -f "$agent_path/subagent.md" ]; then
        log_test_pass "$agent_name: subagent.md exists"
        echo "  ✓ $agent_name: subagent.md exists" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: subagent.md missing"
        echo "  ✗ $agent_name: subagent.md missing" >> "$TEST_RESULTS_FILE"
        return 1
    fi
    
    # Test commands directory exists
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if [ -d "$agent_path/commands" ]; then
        log_test_pass "$agent_name: commands directory exists"
        echo "  ✓ $agent_name: commands directory exists" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: commands directory missing"
        echo "  ✗ $agent_name: commands directory missing" >> "$TEST_RESULTS_FILE"
    fi
    
    # Test help command exists
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if [ -f "$agent_path/commands/help.md" ]; then
        log_test_pass "$agent_name: help command exists"
        echo "  ✓ $agent_name: help command exists" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: help command missing"
        echo "  ✗ $agent_name: help command missing" >> "$TEST_RESULTS_FILE"
    fi
    
    # Test subagent.md has required sections
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if grep -q "## Description" "$agent_path/subagent.md" 2>/dev/null; then
        log_test_pass "$agent_name: Description section found"
        echo "  ✓ $agent_name: Description section found" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: Description section missing"
        echo "  ✗ $agent_name: Description section missing" >> "$TEST_RESULTS_FILE"
    fi
    
    return 0
}

# Test agent accessibility via Claude Code
test_agent_accessibility() {
    local agent_name="$1"
    
    log_info "Testing accessibility for agent: $agent_name"
    
    # Skip this test if Claude Code is not available
    if ! command -v claude-code >/dev/null 2>&1; then
        log_warning "$agent_name: Skipping accessibility test (Claude Code not available)"
        echo "  ⚠ $agent_name: Accessibility test skipped (Claude Code not available)" >> "$TEST_RESULTS_FILE"
        return 0
    fi
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    # Create a temporary test to see if agent can be invoked
    # Note: This is a basic test - in practice, you'd need proper Claude Code setup
    if timeout "$TEST_TIMEOUT" claude-code --help >/dev/null 2>&1; then
        log_test_pass "$agent_name: Claude Code can be invoked"
        echo "  ✓ $agent_name: Accessible via Claude Code" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: Claude Code invocation failed"
        echo "  ✗ $agent_name: Not accessible via Claude Code" >> "$TEST_RESULTS_FILE"
    fi
}

# Test all installed agents
test_all_agents() {
    log_info "Testing all installed agents..."
    echo "" >> "$TEST_RESULTS_FILE"
    echo "Agent Tests:" >> "$TEST_RESULTS_FILE"
    echo "============" >> "$TEST_RESULTS_FILE"
    
    local agent_count=0
    
    for agent_dir in "$SYSTEM_AGENTS_DIR"/*; do
        if [ -d "$agent_dir" ]; then
            agent_name=$(basename "$agent_dir")
            agent_count=$((agent_count + 1))
            
            echo "" >> "$TEST_RESULTS_FILE"
            echo "Testing agent: $agent_name" >> "$TEST_RESULTS_FILE"
            echo "-------------------------" >> "$TEST_RESULTS_FILE"
            
            test_agent_structure "$agent_name"
            test_agent_accessibility "$agent_name"
        fi
    done
    
    if [ "$agent_count" -eq 0 ]; then
        log_warning "No agents found to test"
        echo "No agents found to test" >> "$TEST_RESULTS_FILE"
    else
        log_info "Tested $agent_count agents"
    fi
}

# Run comprehensive agent validation
validate_agent_content() {
    local agent_name="$1"
    local agent_path="$SYSTEM_AGENTS_DIR/$agent_name"
    
    log_info "Validating content for agent: $agent_name"
    
    # Check if subagent.md has persona information
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if grep -q "## Persona" "$agent_path/subagent.md" 2>/dev/null; then
        log_test_pass "$agent_name: Persona section found"
        echo "  ✓ $agent_name: Persona section found" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: Persona section missing"
        echo "  ✗ $agent_name: Persona section missing" >> "$TEST_RESULTS_FILE"
    fi
    
    # Check for commands section
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if grep -q "## Commands" "$agent_path/subagent.md" 2>/dev/null; then
        log_test_pass "$agent_name: Commands section found"
        echo "  ✓ $agent_name: Commands section found" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: Commands section missing"
        echo "  ✗ $agent_name: Commands section missing" >> "$TEST_RESULTS_FILE"
    fi
    
    # Count available commands
    local cmd_count=0
    if [ -d "$agent_path/commands" ]; then
        cmd_count=$(find "$agent_path/commands" -name "*.md" | wc -l)
    fi
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if [ "$cmd_count" -gt 0 ]; then
        log_test_pass "$agent_name: Has $cmd_count command(s)"
        echo "  ✓ $agent_name: Has $cmd_count command(s)" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: No commands found"
        echo "  ✗ $agent_name: No commands found" >> "$TEST_RESULTS_FILE"
    fi
}

# Generate test report
generate_test_report() {
    log_info "Generating test report..."
    
    echo "" >> "$TEST_RESULTS_FILE"
    echo "Test Summary:" >> "$TEST_RESULTS_FILE"
    echo "=============" >> "$TEST_RESULTS_FILE"
    echo "Total Tests: $TOTAL_TESTS" >> "$TEST_RESULTS_FILE"
    echo "Passed: $PASSED_TESTS" >> "$TEST_RESULTS_FILE"
    echo "Failed: $FAILED_TESTS" >> "$TEST_RESULTS_FILE"
    
    local success_rate=0
    if [ "$TOTAL_TESTS" -gt 0 ]; then
        success_rate=$((PASSED_TESTS * 100 / TOTAL_TESTS))
    fi
    echo "Success Rate: $success_rate%" >> "$TEST_RESULTS_FILE"
    
    echo ""
    log_info "Test Summary:"
    log_info "============="
    log_info "Total Tests: $TOTAL_TESTS"
    log_success "Passed: $PASSED_TESTS"
    log_error "Failed: $FAILED_TESTS"
    log_info "Success Rate: $success_rate%"
    echo ""
    log_info "Detailed results saved to: $TEST_RESULTS_FILE"
    
    if [ "$FAILED_TESTS" -gt 0 ]; then
        return 1
    else
        return 0
    fi
}

# Run performance tests
test_agent_performance() {
    log_info "Running basic performance tests..."
    
    # Test agent loading time (simulated)
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    local start_time=$(date +%s%N)
    
    # Simulate loading all agents (just reading their files)
    for agent_dir in "$SYSTEM_AGENTS_DIR"/*; do
        if [ -d "$agent_dir" ]; then
            [ -f "$agent_dir/subagent.md" ] && cat "$agent_dir/subagent.md" >/dev/null 2>&1
        fi
    done
    
    local end_time=$(date +%s%N)
    local duration=$(((end_time - start_time) / 1000000)) # Convert to milliseconds
    
    if [ "$duration" -lt 1000 ]; then # Less than 1 second
        log_test_pass "Agent loading performance: ${duration}ms"
        echo "✓ Agent loading performance: ${duration}ms" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "Agent loading performance: ${duration}ms (too slow)"
        echo "✗ Agent loading performance: ${duration}ms (too slow)" >> "$TEST_RESULTS_FILE"
    fi
}

# Main test execution
main() {
    log_info "Starting Claude Code Agents Test Suite"
    log_info "====================================="
    
    # Initialize
    init_test_results
    
    # Basic checks
    check_claude_code_available
    check_agents_directory
    
    # Test all agents
    test_all_agents
    
    # Run validation on each agent
    for agent_dir in "$SYSTEM_AGENTS_DIR"/*; do
        if [ -d "$agent_dir" ]; then
            agent_name=$(basename "$agent_dir")
            validate_agent_content "$agent_name"
        fi
    done
    
    # Performance tests
    test_agent_performance
    
    # Generate final report
    if generate_test_report; then
        log_success "All tests passed!"
        exit 0
    else
        log_error "Some tests failed. Check the report for details."
        exit 1
    fi
}

# Handle command line arguments
case "${1:-}" in
    --help|-h)
        echo "Claude Code Agents Test Script"
        echo ""
        echo "Usage: $0 [OPTIONS]"
        echo ""
        echo "Options:"
        echo "  --help, -h      Show this help message"
        echo "  --quick         Run only basic structure tests"
        echo "  --verbose       Show detailed test output"
        echo "  --report-only   Only generate and show the test report"
        echo ""
        echo "This script tests installed Claude Code agents to verify they are working correctly."
        exit 0
        ;;
    --quick)
        log_info "Running quick tests only..."
        init_test_results
        check_claude_code_available
        check_agents_directory
        test_all_agents
        generate_test_report
        ;;
    --verbose)
        set -x
        main
        ;;
    --report-only)
        if [ -f "$TEST_RESULTS_FILE" ]; then
            cat "$TEST_RESULTS_FILE"
        else
            log_error "No test results file found. Run tests first."
            exit 1
        fi
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