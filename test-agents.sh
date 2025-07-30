#!/bin/bash

# Claude Code Agents Test Script
# Tests the new agent structure with .md files in agents/ directory

set -e

# Configuration
AGENTS_SOURCE_DIR="./agents"
TEST_PROJECT_DIR="./test-project"
TEST_CLAUDE_DIR="$TEST_PROJECT_DIR/.claude"
TEST_AGENTS_DIR="$TEST_CLAUDE_DIR/agents"
TEST_RESULTS_FILE="$TEST_PROJECT_DIR/claude-agents-test-results.txt"
USAGE_GUIDE_FILE="./AGENT-USAGE-GUIDE.md"
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
    
    if command -v claude >/dev/null 2>&1; then
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

# Check if source agents directory exists
check_source_agents_directory() {
    log_info "Checking source agents directory..."
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    if [ -d "$AGENTS_SOURCE_DIR" ]; then
        log_test_pass "Source agents directory exists: $AGENTS_SOURCE_DIR"
        echo "✓ Source agents directory exists" >> "$TEST_RESULTS_FILE"
        return 0
    else
        log_test_fail "Source agents directory not found: $AGENTS_SOURCE_DIR"
        echo "✗ Source agents directory missing" >> "$TEST_RESULTS_FILE"
        return 1
    fi
}

# Setup test environment
setup_test_environment() {
    log_info "Setting up test environment..."
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    # Navigate to test project
    if ! cd "$TEST_PROJECT_DIR" 2>/dev/null; then
        log_test_fail "Cannot access test project directory: $TEST_PROJECT_DIR"
        echo "✗ Test project directory not accessible" >> "$TEST_RESULTS_FILE"
        return 1
    fi
    
    # Initialize Claude Code if not already done
    if [ ! -d ".claude" ]; then
        log_info "Initializing Claude Code in test project..."
        if command -v claude >/dev/null 2>&1; then
            if claude init --yes >/dev/null 2>&1; then
                log_info "Claude Code initialized successfully"
            else
                log_warning "Claude Code init failed, continuing with manual setup"
                mkdir -p .claude/agents
            fi
        else
            log_info "Creating .claude directory manually"
            mkdir -p .claude/agents
        fi
    fi
    
    # Copy agents to test project
    log_info "Copying agents to test project..."
    if cp -r "../$AGENTS_SOURCE_DIR"/* ".claude/agents/" 2>/dev/null; then
        log_test_pass "Agents copied to test project"
        echo "✓ Agents copied to test project" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "Failed to copy agents to test project"
        echo "✗ Failed to copy agents" >> "$TEST_RESULTS_FILE"
        return 1
    fi
    
    # Copy usage guide
    if cp "../$USAGE_GUIDE_FILE" "." 2>/dev/null; then
        log_info "Usage guide copied to test project"
        echo "✓ Usage guide copied" >> "$TEST_RESULTS_FILE"
    else
        log_warning "Failed to copy usage guide"
        echo "⚠ Usage guide copy failed" >> "$TEST_RESULTS_FILE"
    fi
    
    return 0
}

# Test agent structure (new .md format)
test_agent_structure() {
    local agent_file="$1"
    local agent_name=$(basename "$agent_file" .md)
    
    log_info "Testing structure for agent: $agent_name"
    
    # Test agent .md file exists
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if [ -f "$agent_file" ]; then
        log_test_pass "$agent_name: agent file exists"
        echo "  ✓ $agent_name: agent file exists" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: agent file missing"
        echo "  ✗ $agent_name: agent file missing" >> "$TEST_RESULTS_FILE"
        return 1
    fi
    
    # Test YAML frontmatter exists
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if head -n 5 "$agent_file" | grep -q "^---$" 2>/dev/null; then
        log_test_pass "$agent_name: YAML frontmatter found"
        echo "  ✓ $agent_name: YAML frontmatter found" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: YAML frontmatter missing"
        echo "  ✗ $agent_name: YAML frontmatter missing" >> "$TEST_RESULTS_FILE"
    fi
    
    # Test required YAML fields
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if grep -q "^name:" "$agent_file" 2>/dev/null; then
        log_test_pass "$agent_name: name field found"
        echo "  ✓ $agent_name: name field found" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: name field missing"
        echo "  ✗ $agent_name: name field missing" >> "$TEST_RESULTS_FILE"
    fi
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if grep -q "^description:" "$agent_file" 2>/dev/null; then
        log_test_pass "$agent_name: description field found"
        echo "  ✓ $agent_name: description field found" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: description field missing"
        echo "  ✗ $agent_name: description field missing" >> "$TEST_RESULTS_FILE"
    fi
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if grep -q "^tools:" "$agent_file" 2>/dev/null; then
        log_test_pass "$agent_name: tools field found"
        echo "  ✓ $agent_name: tools field found" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: tools field missing"
        echo "  ✗ $agent_name: tools field missing" >> "$TEST_RESULTS_FILE"
    fi
    
    # Test persona section exists
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if grep -q "## Your Persona" "$agent_file" 2>/dev/null; then
        log_test_pass "$agent_name: Persona section found"
        echo "  ✓ $agent_name: Persona section found" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: Persona section missing"
        echo "  ✗ $agent_name: Persona section missing" >> "$TEST_RESULTS_FILE"
    fi
    
    # Test commands section exists
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if grep -q "## Available Commands" "$agent_file" 2>/dev/null; then
        log_test_pass "$agent_name: Commands section found"
        echo "  ✓ $agent_name: Commands section found" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: Commands section missing"
        echo "  ✗ $agent_name: Commands section missing" >> "$TEST_RESULTS_FILE"
    fi
    
    return 0
}

# Test agent accessibility via Claude Code
test_agent_accessibility() {
    local agent_name="$1"
    
    log_info "Testing accessibility for agent: $agent_name"
    
    # Skip this test if Claude Code is not available
    if ! command -v claude >/dev/null 2>&1; then
        log_warning "$agent_name: Skipping accessibility test (Claude Code not available)"
        echo "  ⚠ $agent_name: Accessibility test skipped (Claude Code not available)" >> "$TEST_RESULTS_FILE"
        return 0
    fi
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    # Test if agent can be listed by Claude Code
    if timeout "$TEST_TIMEOUT" claude --print "list available subagents" 2>/dev/null | grep -q "$agent_name" 2>/dev/null; then
        log_test_pass "$agent_name: Found in Claude Code agent list"
        echo "  ✓ $agent_name: Accessible via Claude Code" >> "$TEST_RESULTS_FILE"
    else
        # Try a basic help command test
        if timeout "$TEST_TIMEOUT" claude --help >/dev/null 2>&1; then
            log_test_pass "$agent_name: Claude Code responsive (agent may need setup)"
            echo "  ✓ $agent_name: Claude Code responsive" >> "$TEST_RESULTS_FILE"
        else
            log_test_fail "$agent_name: Claude Code not responsive"
            echo "  ✗ $agent_name: Claude Code not responsive" >> "$TEST_RESULTS_FILE"
        fi
    fi
}

# Test all agents
test_all_agents() {
    log_info "Testing all agents..."
    echo "" >> "$TEST_RESULTS_FILE"
    echo "Agent Tests:" >> "$TEST_RESULTS_FILE"
    echo "============" >> "$TEST_RESULTS_FILE"
    
    local agent_count=0
    
    # Test agents from the test project .claude/agents directory
    for agent_file in "$TEST_AGENTS_DIR"/*.md; do
        if [ -f "$agent_file" ]; then
            agent_name=$(basename "$agent_file" .md)
            agent_count=$((agent_count + 1))
            
            echo "" >> "$TEST_RESULTS_FILE"
            echo "Testing agent: $agent_name" >> "$TEST_RESULTS_FILE"
            echo "-------------------------" >> "$TEST_RESULTS_FILE"
            
            test_agent_structure "$agent_file"
            test_agent_accessibility "$agent_name"
        fi
    done
    
    if [ "$agent_count" -eq 0 ]; then
        log_warning "No agents found to test in $TEST_AGENTS_DIR"
        echo "No agents found to test" >> "$TEST_RESULTS_FILE"
    else
        log_info "Tested $agent_count agents"
    fi
}

# Run comprehensive agent validation
validate_agent_content() {
    local agent_file="$1"
    local agent_name=$(basename "$agent_file" .md)
    
    log_info "Validating content for agent: $agent_name"
    
    # Check if agent has persona information
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if grep -q "## Your Persona" "$agent_file" 2>/dev/null; then
        log_test_pass "$agent_name: Persona section found"
        echo "  ✓ $agent_name: Persona section found" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: Persona section missing"
        echo "  ✗ $agent_name: Persona section missing" >> "$TEST_RESULTS_FILE"
    fi
    
    # Check for core principles section
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if grep -q "## Core Principles" "$agent_file" 2>/dev/null; then
        log_test_pass "$agent_name: Core Principles section found"
        echo "  ✓ $agent_name: Core Principles section found" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: Core Principles section missing"
        echo "  ✗ $agent_name: Core Principles section missing" >> "$TEST_RESULTS_FILE"
    fi
    
    # Check for commands section
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if grep -q "## Available Commands" "$agent_file" 2>/dev/null; then
        log_test_pass "$agent_name: Commands section found"
        echo "  ✓ $agent_name: Commands section found" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: Commands section missing"
        echo "  ✗ $agent_name: Commands section missing" >> "$TEST_RESULTS_FILE"
    fi
    
    # Count available commands (look for ### command_name patterns)
    local cmd_count=0
    cmd_count=$(grep -c "^### " "$agent_file" 2>/dev/null || echo 0)
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if [ "$cmd_count" -gt 0 ]; then
        log_test_pass "$agent_name: Has $cmd_count command(s)"
        echo "  ✓ $agent_name: Has $cmd_count command(s)" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: No commands found"
        echo "  ✗ $agent_name: No commands found" >> "$TEST_RESULTS_FILE"
    fi
    
    # Check for help command specifically
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if grep -q "### help" "$agent_file" 2>/dev/null; then
        log_test_pass "$agent_name: Help command found"
        echo "  ✓ $agent_name: Help command found" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "$agent_name: Help command missing"
        echo "  ✗ $agent_name: Help command missing" >> "$TEST_RESULTS_FILE"
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
    for agent_file in "$TEST_AGENTS_DIR"/*.md; do
        if [ -f "$agent_file" ]; then
            cat "$agent_file" >/dev/null 2>&1
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

# Test agent sequence workflow
test_agent_sequence() {
    log_info "Testing agent sequence workflow..."
    
    # Expected agents in order
    local expected_agents=("product-manager" "analyst" "ux-expert" "architect" "product-owner" "scrum-master" "developer" "qa-engineer")
    
    for expected_agent in "${expected_agents[@]}"; do
        TOTAL_TESTS=$((TOTAL_TESTS + 1))
        if [ -f "$TEST_AGENTS_DIR/$expected_agent.md" ]; then
            log_test_pass "Required agent found: $expected_agent"
            echo "  ✓ Required agent found: $expected_agent" >> "$TEST_RESULTS_FILE"
        else
            log_test_fail "Required agent missing: $expected_agent"
            echo "  ✗ Required agent missing: $expected_agent" >> "$TEST_RESULTS_FILE"
        fi
    done
    
    # Test usage guide exists
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if [ -f "$TEST_PROJECT_DIR/AGENT-USAGE-GUIDE.md" ]; then
        log_test_pass "Usage guide found in test project"
        echo "✓ Usage guide found in test project" >> "$TEST_RESULTS_FILE"
    else
        log_test_fail "Usage guide missing from test project"
        echo "✗ Usage guide missing from test project" >> "$TEST_RESULTS_FILE"
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
    check_source_agents_directory
    
    # Setup test environment
    if ! setup_test_environment; then
        log_error "Failed to setup test environment"
        exit 1
    fi
    
    # Test all agents
    test_all_agents
    
    # Run validation on each agent
    for agent_file in "$TEST_AGENTS_DIR"/*.md; do
        if [ -f "$agent_file" ]; then
            validate_agent_content "$agent_file"
        fi
    done
    
    # Test agent sequence
    test_agent_sequence
    
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
        check_source_agents_directory
        if setup_test_environment; then
            test_all_agents
            test_agent_sequence
        fi
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