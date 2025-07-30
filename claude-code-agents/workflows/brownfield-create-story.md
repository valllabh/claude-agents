# Brownfield Story Creation Workflow

## Overview
Create single user stories for very small brownfield enhancements completable in one focused development session, designed for minimal additions or bug fixes requiring existing system integration awareness.

## When to Use This Workflow
**Use for:**
- Enhancement completable in single story
- No new architecture or significant design required
- Change follows existing patterns exactly
- Integration is straightforward with minimal risk
- Change is isolated with clear boundaries

**Use brownfield-create-epic for:**
- Enhancement requires 2-3 coordinated stories
- Some design work needed
- Multiple integration points involved

**Use full brownfield PRD/Architecture for:**
- Multiple coordinated stories required
- Architectural planning needed
- Significant integration work required

## Workflow Steps

### 1. Quick Project Assessment
**Current System Context Analysis:**
- [ ] Relevant existing functionality identified
- [ ] Technology stack for this area noted
- [ ] Integration point(s) clearly understood
- [ ] Existing patterns for similar work identified

**Change Scope Definition:**
- [ ] Specific change clearly defined
- [ ] Impact boundaries identified
- [ ] Success criteria established

### 2. Story Creation Structure
**Story Title Format:**
`{{Specific Enhancement}} - Brownfield Addition`

**User Story Template:**
```
As a {{user type}},
I want {{specific action/capability}},
So that {{clear benefit/value}}.
```

**Story Context Section:**
- **Existing System Integration:**
  - Integrates with: {{existing component/system}}
  - Technology: {{relevant tech stack}}
  - Follows pattern: {{existing pattern to follow}}
  - Touch points: {{specific integration points}}

### 3. Acceptance Criteria Definition
**Functional Requirements:**
1. {{Primary functional requirement}}
2. {{Secondary functional requirement (if any)}}
3. {{Integration requirement}}

**Integration Requirements:**
4. Existing {{relevant functionality}} continues to work unchanged
5. New functionality follows existing {{pattern}} pattern
6. Integration with {{system/component}} maintains current behavior

**Quality Requirements:**
7. Change is covered by appropriate tests
8. Documentation is updated if needed
9. No regression in existing functionality verified

### 4. Technical Implementation Notes
**Technical Context:**
- **Integration Approach**: How it connects to existing system
- **Existing Pattern Reference**: Link or description of pattern to follow
- **Key Constraints**: Important limitations or requirements

### 5. Definition of Done
**Completion Criteria:**
- [ ] Functional requirements met
- [ ] Integration requirements verified
- [ ] Existing functionality regression tested
- [ ] Code follows existing patterns and standards
- [ ] Tests pass (existing and new)
- [ ] Documentation updated if applicable

### 6. Risk and Compatibility Assessment
**Minimal Risk Assessment:**
- **Primary Risk**: Main risk to existing system
- **Mitigation**: Simple mitigation approach
- **Rollback**: How to undo if needed

**Compatibility Verification:**
- [ ] No breaking changes to existing APIs
- [ ] Database changes (if any) are additive only
- [ ] UI changes follow existing design patterns
- [ ] Performance impact is negligible

### 7. Validation Checklist
**Scope Validation:**
- [ ] Story completable in one development session
- [ ] Integration approach is straightforward
- [ ] Follows existing patterns exactly
- [ ] No design or architecture work required

**Clarity Check:**
- [ ] Story requirements are unambiguous
- [ ] Integration points are clearly specified
- [ ] Success criteria are testable
- [ ] Rollback approach is simple

## Decision Gates

### Complexity Assessment Gate
Before proceeding, confirm:
- Change is truly minimal and isolated
- Integration complexity is manageable
- No architectural decisions required

### Quality Gate
Before finalization:
- All requirements are testable
- Integration approach is clear
- Risk level is acceptable

## Escalation Criteria
**Escalate to brownfield-create-epic when:**
- Complexity grows during analysis
- Multiple integration points discovered
- Design decisions become necessary
- Implementation time exceeds 4 hours

## Interactive Elements

### Scope Validation
Present options when scope uncertainty exists:
1. Proceed with single story approach
2. Escalate to epic creation
3. Request additional requirements clarification
4. Break into smaller components

### Risk Assessment
When risk factors identified:
1. Proceed with documented mitigation
2. Escalate for additional review
3. Simplify scope to reduce risk
4. Request stakeholder input

## Success Criteria
1. Enhancement clearly defined and scoped for single session
2. Integration approach is straightforward and low-risk
3. Existing system patterns identified and will be followed
4. Rollback plan is simple and feasible
5. Acceptance criteria include existing functionality verification

## Quality Assurance
- Always prioritize existing system integrity
- Ensure change isolation and clear boundaries
- Verify pattern compliance before implementation
- Validate rollback feasibility
- Confirm single-session completability

## Output Deliverables
- Complete user story with acceptance criteria
- Technical implementation notes
- Risk assessment and mitigation plan
- Compatibility verification checklist
- Definition of done criteria

## Important Notes
- This workflow is for VERY SMALL brownfield changes only
- Stories should take no more than 4 hours of focused development work
- When in doubt about integration complexity, escalate to epic creation
- Always prioritize existing system integrity over new functionality