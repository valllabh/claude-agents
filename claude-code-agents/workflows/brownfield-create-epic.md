# Brownfield Epic Creation Workflow

## Overview
Create focused epics for smaller brownfield enhancements that don't require full PRD and Architecture documentation processes, designed for isolated features completable within 1-3 stories.

## When to Use This Workflow
**Use for:**
- Enhancement completable in 1-3 stories
- No significant architectural changes required
- Enhancement follows existing project patterns
- Minimal integration complexity
- Low risk to existing system

**Use full brownfield PRD/Architecture process for:**
- Multiple coordinated stories required
- Architectural planning needed
- Significant integration work required
- Risk assessment and mitigation planning necessary

## Workflow Steps

### 1. Project Analysis Phase
**Gather Essential Project Context:**
- **Project Purpose**: Understand current functionality
- **Technology Stack**: Identify existing technologies
- **Architecture Patterns**: Note current patterns and structures
- **Integration Points**: Map connections with existing system

**Enhancement Scope Analysis:**
- **Clear Definition**: Precisely define enhancement scope
- **Impact Assessment**: Evaluate effect on existing functionality
- **Integration Requirements**: Identify required integration points
- **Success Criteria**: Establish measurable outcomes

### 2. Epic Creation Structure
**Epic Title Format:**
`{{Enhancement Name}} - Brownfield Enhancement`

**Epic Goal:**
1-2 sentences describing accomplishment and value delivery

**Epic Description Components:**
- **Existing System Context**:
  - Current relevant functionality brief description
  - Technology stack relevant existing technologies
  - Integration points where new work connects to existing system
- **Enhancement Details**:
  - Clear description of additions/changes
  - Integration approach explanation
  - Success criteria with measurable outcomes

### 3. Story Planning
**Define 1-3 Focused Stories:**
1. **Story 1**: Title and brief description
2. **Story 2**: Title and brief description  
3. **Story 3**: Title and brief description

**Story Requirements:**
- Each story must be self-contained
- Clear acceptance criteria defined
- Logical implementation sequence
- Minimal cross-story dependencies

### 4. Compatibility and Risk Assessment
**Compatibility Requirements Validation:**
- [ ] Existing APIs remain unchanged
- [ ] Database schema changes are backward compatible
- [ ] UI changes follow existing patterns
- [ ] Performance impact is minimal

**Risk Mitigation Planning:**
- **Primary Risk**: Main risk to existing system
- **Mitigation Strategy**: How risk will be addressed
- **Rollback Plan**: How to undo changes if needed

### 5. Definition of Done
**Epic Completion Criteria:**
- [ ] All stories completed with acceptance criteria met
- [ ] Existing functionality verified through testing
- [ ] Integration points working correctly
- [ ] Documentation updated appropriately
- [ ] No regression in existing features

### 6. Validation Checklist
**Scope Validation:**
- [ ] Epic completable in 1-3 stories maximum
- [ ] No architectural documentation required
- [ ] Enhancement follows existing patterns
- [ ] Integration complexity is manageable

**Risk Assessment:**
- [ ] Risk to existing system is low
- [ ] Rollback plan is feasible
- [ ] Testing approach covers existing functionality
- [ ] Team has sufficient knowledge of integration points

**Completeness Check:**
- [ ] Epic goal is clear and achievable
- [ ] Stories are properly scoped
- [ ] Success criteria are measurable
- [ ] Dependencies are identified

### 7. Story Manager Handoff
**Handoff Information Package:**
"Please develop detailed user stories for this brownfield epic. Key considerations:
- Enhancement to existing system running {{technology stack}}
- Integration points: {{list key integration points}}
- Existing patterns to follow: {{relevant existing patterns}}
- Critical compatibility requirements: {{key requirements}}
- Each story must include verification that existing functionality remains intact
- Epic maintains system integrity while delivering {{epic goal}}"

## Decision Gates

### Scope Assessment Gate
Before proceeding, confirm:
- Enhancement scope is appropriate for this workflow
- Risk level is acceptable for streamlined process
- Integration complexity is manageable

### Quality Gate
Before finalization:
- Epic can be completed within story limit
- Risk mitigation is adequate
- Success criteria are testable

## Escalation Criteria
**Escalate to full brownfield planning when:**
- Scope grows beyond 3 stories during analysis
- Architectural changes become necessary
- Integration complexity increases significantly
- Risk level exceeds acceptable thresholds

## Success Criteria
1. Enhancement scope clearly defined and appropriately sized
2. Integration approach respects existing system architecture
3. Risk to existing functionality minimized
4. Stories logically sequenced for safe implementation
5. Compatibility requirements clearly specified
6. Rollback plan feasible and documented

## Output Deliverables
- Complete epic definition with all required sections
- 1-3 properly scoped user stories
- Risk assessment and mitigation plan
- Compatibility requirements checklist
- Handoff package for story development