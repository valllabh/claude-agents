# Create Next Story Workflow

## Overview
Identify the next logical story based on project progress and epic definitions, then prepare comprehensive, self-contained, and actionable story files with complete technical context for efficient Developer Agent implementation.

## Purpose
Ensure stories are enriched with all necessary technical context, requirements, and acceptance criteria, making them ready for efficient implementation with minimal need for additional research or context finding.

## Prerequisites
- Core configuration file (`.bmad-core/core-config.yaml`) must exist
- Epic files must be available (sharded or monolithic PRD sections)
- Architecture documents must be accessible
- Story template must be available

## Workflow Steps

### 1. Load Core Configuration and Check Workflow
**Configuration Loading:**
- Load `.bmad-core/core-config.yaml` from project root
- If file doesn't exist, HALT and inform user:
  "core-config.yaml not found. This file is required for story creation. You can either:
  1) Copy it from GITHUB bmad-core/core-config.yaml and configure for your project
  2) Run BMad installer against your project to upgrade and add file automatically
  Please add and configure core-config.yaml before proceeding."

**Extract Key Configurations:**
- `devStoryLocation`: Where story files are stored
- `prd.*`: PRD-related configuration settings
- `architecture.*`: Architecture document settings
- `workflow.*`: Workflow-specific configurations

### 2. Identify Next Story for Preparation
**Locate Epic Files and Review Existing Stories:**
- Based on `prdSharded` from config, locate epic files
- If `devStoryLocation` has story files, load highest `{epicNum}.{storyNum}.story.md` file

**If Highest Story Exists:**
- Verify status is 'Done'
- If not Done, alert user: "ALERT: Found incomplete story! File: {lastEpicNum}.{lastStoryNum}.story.md Status: [current status] You should fix this story first, but would you like to accept risk & override to create the next story in draft?"
- If proceeding, select next sequential story in current epic
- If epic complete, prompt: "Epic {epicNum} Complete: All stories in Epic {epicNum} completed. Would you like to:
  1) Begin Epic {epicNum + 1} with story 1
  2) Select specific story to work on  
  3) Cancel story creation"

**CRITICAL**: NEVER automatically skip to another epic. User MUST explicitly instruct which story to create.

**If No Story Files Exist:** Next story is ALWAYS 1.1 (first story of first epic)

**Announce Identified Story:** "Identified next story for preparation: {epicNum}.{storyNum} - {Story Title}"

### 3. Gather Story Requirements and Previous Story Context
**Extract Story Requirements:**
- Load story requirements from identified epic file
- Extract story title, description, and acceptance criteria
- Note any special requirements or constraints

**Previous Story Context Review:**
If previous story exists, review Dev Agent Record sections for:
- **Completion Notes**: Implementation decisions and outcomes
- **Debug Log References**: Technical challenges encountered
- **Implementation Deviations**: Changes from original plan
- **Lessons Learned**: Insights for current story preparation

### 4. Gather Architecture Context
**Determine Architecture Reading Strategy:**
- **If `architectureVersion: >= v4` and `architectureSharded: true`**: Read `{architectureShardedLocation}/index.md` then follow structured reading
- **Else**: Use monolithic `architectureFile` for similar sections

**Read Architecture Documents Based on Story Type:**

**For ALL Stories:** 
- `tech-stack.md`
- `unified-project-structure.md`
- `coding-standards.md`
- `testing-strategy.md`

**For Backend/API Stories, Additionally:**
- `data-models.md`
- `database-schema.md`
- `backend-architecture.md`
- `rest-api-spec.md`
- `external-apis.md`

**For Frontend/UI Stories, Additionally:**
- `frontend-architecture.md`
- `components.md`
- `core-workflows.md`
- `data-models.md`

**For Full-Stack Stories:** Read both Backend and Frontend sections

### 5. Extract Story-Specific Technical Details
**Extract ONLY Information Directly Relevant to Current Story:**
Do NOT invent new libraries, patterns, or standards not in source documents.

**Extract and Document:**
- **Specific Data Models**: Schemas, structures, validation rules the story will use
- **API Endpoints**: Endpoints story must implement or consume
- **Component Specifications**: UI elements and their requirements
- **File Paths**: Naming conventions for new code based on project structure
- **Testing Requirements**: Specific to story's features
- **Security Considerations**: Affecting story implementation
- **Performance Requirements**: Relevant to story scope

**Source Citation Requirement:** ALWAYS cite source documents: `[Source: architecture/{filename}.md#{section}]`

### 6. Verify Project Structure Alignment
**Cross-Reference with Project Structure:**
- Reference story requirements with Project Structure Guide from `docs/architecture/unified-project-structure.md`
- Ensure file paths, component locations, module names align with defined structures
- Document any structural conflicts in "Project Structure Notes" section

### 7. Populate Story Template with Full Context
**Create New Story File:** `{devStoryLocation}/{epicNum}.{storyNum}.story.md`

**Fill Story Template Sections:**
- **Basic Information**: Title, Status (Draft), Story statement
- **Acceptance Criteria**: From Epic requirements

**Dev Notes Section (CRITICAL):**
MUST contain ONLY information extracted from architecture documents. NEVER invent or assume technical details.

**Organize by Category:**
- **Previous Story Insights**: Key learnings from previous story
- **Data Models**: Specific schemas, validation rules, relationships [with source references]
- **API Specifications**: Endpoint details, request/response formats, auth requirements [with source references]
- **Component Specifications**: UI component details, props, state management [with source references]
- **File Locations**: Exact paths for new code based on project structure
- **Testing Requirements**: Specific test cases from testing-strategy.md
- **Technical Constraints**: Version requirements, performance, security rules

**Source Reference Requirement:** Every technical detail MUST include source reference: `[Source: architecture/{filename}.md#{section}]`

**If Information Missing:** Explicitly state: "No specific guidance found in architecture docs"

**Tasks / Subtasks Section:**
- Generate detailed, sequential technical tasks based ONLY on: Epic Requirements, Story AC, Reviewed Architecture Information
- Each task must reference relevant architecture documentation
- Include unit testing as explicit subtasks based on Testing Strategy
- Link tasks to ACs: `Task 1 (AC: 1, 3)`

### 8. Story Draft Completion and Review
**Review for Completeness:**
- Verify all sections completed accurately
- Ensure all source references included for technical details
- Confirm tasks align with epic requirements and architecture constraints
- Update status to "Draft" and save story file

**Execute Validation:**
- Run `.bmad-core/tasks/execute-checklist` with `.bmad-core/checklists/story-draft-checklist`
- Document checklist results

**Provide Summary to User:**
```
Story created: {devStoryLocation}/{epicNum}.{storyNum}.story.md
Status: Draft
Key technical components included from architecture docs
Any deviations or conflicts noted between epic and architecture
Checklist Results: [Summary]
Next steps: For Complex stories, suggest user carefully review story draft and optionally have PO run validate-next-story task
```

## Interactive Elements

### Story Selection Confirmation
When multiple options available:
1. Proceed with identified next story
2. Select different story manually
3. Skip to different epic
4. Cancel story creation

### Epic Completion Handling
When epic is complete:
1. Begin next epic with story 1
2. Select specific story to work on
3. Cancel story creation and review epic status

### Architecture Context Loading
Present loading progress:
1. Reading core architecture documents
2. Loading story-type specific documents  
3. Extracting relevant technical details
4. Cross-referencing with project structure

## Decision Gates

### Configuration Validation Gate
Before proceeding:
- Core configuration file exists and is valid
- All required configuration values present
- Architecture document locations accessible

### Story Identification Gate
Before story creation:
- Next story clearly identified
- Epic requirements accessible
- No blocking incomplete stories (unless override accepted)

### Technical Context Gate
Before finalizing:
- All relevant architecture information extracted
- Source references complete and accurate
- No invented technical details included

## Quality Assurance
- Ensure story is self-contained for developer implementation
- Verify all technical details have source references
- Confirm alignment with project structure guidelines
- Validate testing requirements inclusion
- Check security and performance considerations

## Success Criteria
1. Story created with complete technical context from architecture documents
2. All technical details properly sourced and referenced
3. Implementation tasks align with epic requirements and architecture
4. Story ready for developer implementation without additional research
5. Project structure alignment verified and documented

## Output Deliverables
- Complete story file following template structure
- Dev Notes section with comprehensive technical guidance
- Tasks breakdown linked to acceptance criteria
- Project structure alignment documentation
- Validation checklist results

## Important Notes
- NEVER invent technical details not found in source documents
- Always include source references for technical information
- Story must be self-contained for developer agent
- Previous story context should inform current story preparation
- User must explicitly direct which story to create - no automatic progression