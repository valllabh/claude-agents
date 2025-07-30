# Correct Course Workflow

## Overview
Guide structured response to change triggers using systematic change analysis, impact assessment, and solution exploration to produce actionable Sprint Change Proposals with specific artifact updates.

## Purpose
- Analyze impacts of changes on epics, project artifacts, and MVP
- Explore potential solutions (adjust scope, rollback elements, re-scope features)
- Draft specific, actionable proposed updates to affected project artifacts
- Produce consolidated Sprint Change Proposal for user review and approval
- Ensure clear handoff path for fundamental replanning needs

## Workflow Steps

### 1. Initial Setup and Mode Selection
**Acknowledge Task and Inputs:**
- Confirm Change Navigation & Integration task initiation
- Verify change trigger and user's initial explanation
- Ensure access to relevant project artifacts:
  - PRD, Epics/Stories, Architecture Documents
  - UI/UX Specifications
  - Change checklist from `.bmad-core/checklists/change-checklist`

**Establish Interaction Mode:**
Present mode options to user:
- **Incremental (Default & Recommended)**: Work through change-checklist section by section, discussing findings and collaboratively drafting proposed changes before moving to next section
- **YOLO Mode (Batch Processing)**: Conduct batched analysis based on checklist and present consolidated findings and proposed changes for broader review

Confirm selected mode and inform user: "We will now use the change-checklist to analyze the change and draft proposed updates."

### 2. Execute Checklist Analysis
**Systematic Checklist Processing:**
Work through Sections 1-4 of change-checklist:
- **Section 1**: Change Context Analysis
- **Section 2**: Epic/Story Impact Analysis  
- **Section 3**: Artifact Conflict Resolution
- **Section 4**: Path Evaluation/Recommendation

**For Each Checklist Section (based on interaction mode):**
- Present relevant prompts/considerations from checklist
- Request necessary information and analyze relevant project artifacts
- Discuss findings with user
- Record checklist item status: `[x] Addressed`, `[N/A]`, `[!] Further Action Needed`
- Collaboratively agree on "Recommended Path Forward" from Section 4

### 3. Draft Proposed Changes
**Based on Completed Checklist Analysis:**
- Identify specific project artifacts requiring updates
- Draft proposed changes directly and explicitly for each artifact:
  - Revise user story text, acceptance criteria, priority
  - Add, remove, reorder, or split user stories within epics
  - Propose modified architecture diagram snippets
  - Update technology lists, configuration details, PRD sections
  - Draft new supporting artifacts if necessary

**Change Documentation Format:**
- **For Stories**: "Change Story X.Y from: [old text] To: [new text]"
- **For Architecture**: "Update Section 3.2 of Architecture Document as follows: [new/modified text or diagram description]"
- **For Acceptance Criteria**: "Add new Acceptance Criterion to Story A.B: [new AC]"

**Interaction Mode Handling:**
- **Incremental Mode**: Discuss and refine proposed edits for each artifact as drafted
- **YOLO Mode**: Compile all drafted edits for presentation in next step

### 4. Generate Sprint Change Proposal
**Synthesis into Single Document:**
Create "Sprint Change Proposal" aligning with Section 5 of change-checklist structure:

**Analysis Summary:**
- Concise overview of original issue
- Analyzed impact on epics, artifacts, MVP scope
- Rationale for chosen path forward

**Specific Proposed Edits:**
- For each affected artifact, clearly show exact changes
- Include before/after text where applicable
- Reference specific files, sections, diagrams
- Maintain change traceability

**Present Complete Draft:**
- Show full Sprint Change Proposal to user
- Explain key elements and rationale
- Highlight any assumptions made
- Incorporate user feedback and final adjustments

### 5. Finalize and Determine Next Steps
**User Approval Process:**
- Obtain explicit user approval for Sprint Change Proposal
- Include approval for all specific edits documented within
- Provide finalized document to user

**Next Steps Determination:**
Based on approved changes nature:

**If Direct Implementation Possible:**
- State "Correct Course Task" complete regarding analysis and change proposal
- Suggest user proceed with implementing or logging changes
- Recommend handoff to PO/SM agent for backlog organization if appropriate

**If Fundamental Replan Required:**
- Clearly state conclusion based on checklist analysis
- Advise engaging primary PM or Architect agents
- Provide Sprint Change Proposal as critical input for deeper replanning effort

## Interactive Elements

### Mode Selection
Present numbered options:
1. Incremental Mode (Recommended) - Section by section collaboration
2. YOLO Mode - Batch processing with consolidated review

### Checklist Processing Options
During analysis, offer:
1. Continue with current checklist section
2. Deep dive into specific finding
3. Adjust analysis focus or criteria
4. Move to proposed changes drafting
5. Escalate complexity level

### Change Validation
Before finalization:
1. Approve proposed changes as documented
2. Request modifications to specific edits
3. Add additional artifact updates
4. Escalate to fundamental replanning

## Decision Gates

### Analysis Completeness Gate
Before drafting changes:
- All checklist sections 1-4 completed
- Impact analysis sufficient for decision making
- Recommended path forward agreed upon

### Proposal Quality Gate
Before finalization:
- All affected artifacts identified
- Proposed changes are specific and actionable
- Rationale is clear and well-documented
- User feedback incorporated

## Escalation Criteria
**Escalate to PM/Architect when:**
- Analysis indicates fundamental replan needed
- Architectural changes exceed incremental scope
- Multiple epics/major artifacts require restructuring
- Risk level exceeds acceptable thresholds for incremental changes

## Success Criteria
1. Change impact thoroughly analyzed using structured checklist
2. All affected project artifacts identified
3. Specific, actionable proposed edits documented
4. Sprint Change Proposal provides clear implementation guidance
5. Next steps clearly defined with appropriate handoffs

## Output Deliverables
- **Primary**: Sprint Change Proposal document (markdown format)
  - Summary of change-checklist analysis
  - Specific proposed edits for all affected artifacts
- **Implicit**: Annotated change-checklist record of completion
- Clear next steps recommendation with handoff information

## Quality Assurance
- Ensure all changes trace back to original change trigger
- Verify proposed edits address root cause
- Confirm rollback procedures where applicable
- Validate impact assessment completeness
- Ensure handoff clarity for next phase