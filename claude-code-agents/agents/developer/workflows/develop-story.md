# Develop Story Workflow

## Purpose
Execute comprehensive story development following strict order of execution with quality gates and testing requirements.

## Prerequisites
- Story file must not be in draft mode
- Story must contain complete requirements and acceptance criteria
- Development environment must be configured

## Order of Execution

### 1. Task Reading Phase
- Read first or next pending task from story
- Understand task requirements and subtasks
- Identify any dependencies or prerequisites
- Clarify ambiguous requirements before proceeding

### 2. Implementation Phase
- Implement task and all associated subtasks
- Follow coding standards and best practices
- Write clean, maintainable, well-documented code
- Consider edge cases and error handling

### 3. Testing Phase
- Write comprehensive unit tests for new functionality
- Create integration tests where appropriate
- Test edge cases and error conditions
- Ensure test coverage meets project standards

### 4. Validation Phase
- Execute all tests (unit, integration, linting)
- Run any story-specific validations
- Verify functionality meets acceptance criteria
- Check for regressions in existing functionality

### 5. Completion Gate
- **CRITICAL**: Only if ALL validations pass:
  - Mark task checkbox with [x]
  - Update story File List with any new/modified/deleted source files
  - Add completion notes if significant decisions were made

### 6. Iteration
- Repeat entire process for next task
- Continue until all story tasks are complete

## Final Completion Process

### When All Tasks Complete:
1. Execute full regression test suite
2. Confirm all validations pass
3. Ensure File List is complete and accurate
4. Run execute-checklist with story-dod-checklist
5. Set story status to 'Ready for Review'
6. HALT and await further instructions

## Blocking Conditions

Immediately halt execution for:
- **Unapproved Dependencies**: New dependencies needed that weren't planned
- **Ambiguous Requirements**: Requirements unclear after story review
- **Repeated Failures**: 3 consecutive failures on same implementation
- **Missing Configuration**: Required configuration files or settings missing
- **Failing Regression**: Existing functionality broken by changes

## Story File Update Authorization

**ONLY AUTHORIZED TO UPDATE:**
- Tasks/Subtasks checkboxes
- Dev Agent Record section and all subsections
- Agent Model Used field
- Debug Log References
- Completion Notes List
- File List
- Change Log
- Status field

**NEVER MODIFY:**
- Story description
- Acceptance Criteria
- Dev Notes
- Testing sections (except completion status)
- Any other sections not explicitly authorized

## Quality Standards

### Code Quality
- Follow project coding standards
- Include comprehensive error handling
- Write self-documenting code with clear variable names
- Add comments for complex business logic

### Testing Standards
- Minimum test coverage as defined by project
- Test happy path, edge cases, and error conditions
- Mock external dependencies appropriately
- Tests must be maintainable and readable

### Documentation Standards
- Update File List immediately when files change
- Document significant architectural decisions
- Record any deviations from original plan
- Maintain change log with clear descriptions