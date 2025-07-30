# Create Brownfield Story Workflow

## Overview
Create detailed, implementation-ready stories for brownfield projects where traditional sharded PRD/architecture documents may not exist, bridging the gap between various documentation formats and executable stories.

## When to Use This Workflow
**Use for:**
- Working on brownfield projects with non-standard documentation
- Stories need creation from document-project output
- Working from brownfield epics without full PRD/architecture
- Existing project documentation doesn't follow standard structure
- Need to gather additional context from user during story creation

**Use create-next-story for:**
- Working with properly sharded PRD and architecture documents
- Following standard greenfield or well-documented brownfield workflow
- All technical context available in structured format

## Workflow Steps

### 1. Documentation Context Assessment
**Check for Available Documentation (Priority Order):**
1. **Sharded PRD/Architecture** (`docs/prd/`, `docs/architecture/`)
   - If found, recommend using create-next-story workflow instead
2. **Brownfield Architecture Document** (`docs/brownfield-architecture.md`)
   - Created by document-project task
   - Contains actual system state, technical debt, workarounds
3. **Brownfield PRD** (`docs/prd.md`)
   - May contain embedded technical details
4. **Epic Files** (`docs/epics/`)
   - Created by brownfield-create-epic task
5. **User-Provided Documentation**
   - Ask user to specify location and format

### 2. Story Identification and Context Gathering
**Identify Story Source:**
Based on available documentation:
- **From Brownfield PRD**: Extract stories from epic sections
- **From Epic Files**: Read epic definition and story list
- **From User Direction**: Ask user which specific enhancement to implement
- **No Clear Source**: Work with user to define story scope

**Gather Essential Context (CRITICAL for Brownfield):**
MUST gather sufficient context for safe implementation:
- [ ] What existing functionality might be affected?
- [ ] What are the integration points with current code?
- [ ] What patterns should be followed (with examples)?
- [ ] What technical constraints exist?
- [ ] Are there any "gotchas" or workarounds to know about?

**If missing information identified**: List missing information and ask user to provide it.

### 3. Extract Technical Context from Sources
**From Document-Project Output (brownfield-architecture.md):**
- **Technical Debt Section**: Note workarounds affecting this story
- **Key Files Section**: Identify files needing modification
- **Integration Points**: Find existing integration patterns
- **Known Issues**: Check if story touches problematic areas
- **Actual Tech Stack**: Verify versions and constraints

**From Brownfield PRD:**
- **Technical Constraints Section**: Extract all relevant constraints
- **Integration Requirements**: Note compatibility requirements
- **Code Organization**: Follow specified patterns
- **Risk Assessment**: Understand potential impacts

**From User Documentation:**
Ask user to help identify:
- Relevant technical specifications
- Existing code examples to follow
- Integration requirements
- Testing approaches used in project

### 4. Story Creation with Progressive Detail Gathering
**Initial Story Structure:**
```markdown
# Story {{Enhancement Title}}

## Status: Draft

## Story
As a {{user_type}},
I want {{enhancement_capability}},
so that {{value_delivered}}.

## Context Source
- Source Document: {{document name/type}}
- Enhancement Type: {{single feature/bug fix/integration/etc}}
- Existing System Impact: {{brief assessment}}
```

**Develop Acceptance Criteria:**
CRITICAL: For brownfield, ALWAYS include criteria about maintaining existing functionality

Standard structure:
1. New functionality works as specified
2. Existing {{affected feature}} continues to work unchanged
3. Integration with {{existing system}} maintains current behavior
4. No regression in {{related area}}
5. Performance remains within acceptable bounds

### 5. Gather Technical Guidance
**Create Dev Technical Guidance Section:**
```markdown
## Dev Technical Guidance

### Existing System Context
[Extract from available documentation]

### Integration Approach
[Based on patterns found or ask user]

### Technical Constraints
[From documentation or user input]

### Missing Information
[Critical: List anything dev will need that couldn't be found]
```

**Interactive Information Gathering:**
When information is missing, be interactive with user to gather:
- Specific integration patterns
- Technical constraints and gotchas
- Example files or code patterns
- Testing approaches

### 6. Task Generation with Safety Checks
**Generate Implementation Tasks:**
Create tasks that:
- Include exploration tasks if system understanding incomplete
- Add verification tasks for existing functionality
- Include rollback considerations
- Reference specific files/patterns when known

**Example Task Structure:**
```markdown
## Tasks / Subtasks

- [ ] Task 1: Analyze existing {{component/feature}} implementation
  - [ ] Review {{specific files}} for current patterns
  - [ ] Document integration points
  - [ ] Identify potential impacts

- [ ] Task 2: Implement {{new functionality}}
  - [ ] Follow pattern from {{example file}}
  - [ ] Integrate with {{existing component}}
  - [ ] Maintain compatibility with {{constraint}}

- [ ] Task 3: Verify existing functionality
  - [ ] Test {{existing feature 1}} still works
  - [ ] Verify {{integration point}} behavior unchanged
  - [ ] Check performance impact

- [ ] Task 4: Add tests
  - [ ] Unit tests following {{project test pattern}}
  - [ ] Integration test for {{integration point}}
  - [ ] Update existing tests if needed
```

### 7. Risk Assessment and Mitigation
**CRITICAL: Always include risk assessment for brownfield**
```markdown
## Risk Assessment

### Implementation Risks
- **Primary Risk**: {{main risk to existing system}}
- **Mitigation**: {{how to address}}
- **Verification**: {{how to confirm safety}}

### Rollback Plan
- {{Simple steps to undo changes if needed}}

### Safety Checks
- [ ] Existing {{feature}} tested before changes
- [ ] Changes can be feature-flagged or isolated
- [ ] Rollback procedure documented
```

### 8. Final Story Validation
**Completeness Check:**
- [ ] Story has clear scope and acceptance criteria
- [ ] Technical context sufficient for implementation
- [ ] Integration approach defined
- [ ] Risks identified with mitigation

**Safety Check:**
- [ ] Existing functionality protection included
- [ ] Rollback plan feasible
- [ ] Testing covers both new and existing features

**Information Gaps:**
- [ ] All critical missing information gathered from user
- [ ] Remaining unknowns documented for dev agent
- [ ] Exploration tasks added where needed

### 9. Story Output and Handoff
**Story File Naming:**
- If from epic: `docs/stories/epic-{n}-story-{m}.md`
- If standalone: `docs/stories/brownfield-{feature-name}.md`
- If sequential: Follow existing story numbering

**Story Header:**
```markdown
# Story: {{Title}}

<!-- Source: {{documentation type used}} -->
<!-- Context: Brownfield enhancement to {{existing system}} -->

## Status: Draft
[Rest of story content...]
```

**Handoff Communication:**
```
Brownfield story created: {{story title}}

Source Documentation: {{what was used}}
Story Location: {{file path}}

Key Integration Points Identified:
- {{integration point 1}}
- {{integration point 2}}

Risks Noted:
- {{primary risk}}

{{If missing info}}: 
Note: Some technical details were unclear. The story includes exploration tasks to gather needed information during implementation.

Next Steps:
1. Review story for accuracy
2. Verify integration approach aligns with your system
3. Approve story or request adjustments
4. Dev agent can then implement with safety checks
```

## Interactive Elements

### Documentation Discovery
When documentation unclear:
1. Use existing documentation as-is
2. Request specific documentation from user
3. Proceed with user-guided context gathering
4. Escalate to document-project workflow

### Context Validation
Present options when context gaps identified:
1. Proceed with exploration tasks in story
2. Gather additional context before proceeding
3. Request user input on specific technical details
4. Simplify story scope to reduce unknowns

## Decision Gates

### Documentation Adequacy Gate
Before story creation:
- Sufficient documentation identified for story context
- User input available for missing information
- Integration approach can be determined

### Story Completeness Gate
Before finalization:
- All acceptance criteria address both new and existing functionality
- Technical guidance sufficient for implementation
- Risk assessment complete with mitigation strategies

## Success Criteria
1. Story can be implemented without requiring dev to search multiple documents
2. Integration approach is clear and safe for existing system
3. All available technical context extracted and organized
4. Missing information identified and addressed
5. Risks documented with mitigation strategies
6. Story includes verification of existing functionality
7. Rollback approach defined

## Quality Assurance
- Always prioritize existing system stability over new features
- When in doubt, add exploration and verification tasks
- Better to ask user for clarification than make assumptions
- Each story should be self-contained for dev agent
- Include references to existing code patterns when available

## Output Deliverables
- Complete user story with comprehensive context
- Technical guidance section with implementation details
- Risk assessment and mitigation plan
- Task breakdown with safety considerations
- Handoff documentation with key insights