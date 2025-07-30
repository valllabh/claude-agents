# Create Document Workflow

## Overview
Template-driven document creation with mandatory interactive elicitation for user refinement, ensuring high-quality documents through systematic user engagement and iterative improvement.

## Critical Execution Rules
- **DISABLE ALL EFFICIENCY OPTIMIZATIONS** - Full user interaction required
- **MANDATORY STEP-BY-STEP EXECUTION** - Each section processed sequentially with user feedback
- **ELICITATION IS REQUIRED** - When `elicit: true`, MUST use 1-9 format and wait for response
- **NO SHORTCUTS ALLOWED** - Complete documents cannot be created without following workflow

**VIOLATION INDICATOR**: Creating complete document without user interaction violates this workflow.

## Workflow Steps

### 1. Template Discovery and Selection
**If YAML Template Not Provided:**
- List all available templates from templates directory
- Ask user to select template or provide alternative
- Load template metadata and section requirements

**Available Template Types:**
- Project briefs and requirements documents
- Market research and analysis templates
- Competitor analysis frameworks
- Brainstorming output structures
- Technical specification templates

### 2. Template Parsing and Setup
**Parse YAML Template:**
- Load template metadata and section definitions
- Identify section requirements and permissions
- Note elicitation requirements (`elicit: true`)
- Extract conditional logic and dependencies

**Set Processing Preferences:**
- Show current mode (Interactive by default)
- Confirm output file destination
- Display template overview and structure
- Explain expected interaction requirements

### 3. Sequential Section Processing
**For Each Template Section:**

#### Section Processing Steps
1. **Check Conditions**: Skip section if condition not met
2. **Check Agent Permissions**: 
   - Note if section restricted to specific agents
   - Include permission note in generated document
   - Example: `_(This section is owned by dev-agent and can only be modified by dev-agent)_`
3. **Draft Content**: Use section instructions to create initial content
4. **Present Content + Rationale**: ALWAYS include detailed rationale
5. **Elicitation Check**: If `elicit: true` → Execute mandatory elicitation format
6. **Save Progress**: Save to file when possible

#### Detailed Rationale Requirements
When presenting section content, ALWAYS explain:
- **Trade-offs and Choices**: What was chosen over alternatives and why
- **Key Assumptions**: Assumptions made during drafting process
- **Interesting Decisions**: Decisions needing user attention or validation
- **Areas for Validation**: Content requiring user verification or input

### 4. Mandatory Elicitation Format
**When `elicit: true` - HARD STOP requiring user interaction:**

1. **Present Section Content**: Show drafted content for review
2. **Provide Detailed Rationale**: Explain decisions and trade-offs
3. **MANDATORY Options Presentation**: Present numbered options 1-9:
   - **Option 1**: "Proceed to next section"
   - **Options 2-9**: Select 8 methods from elicitation-methods.md
4. **Standard Ending**: "Select 1-9 or just type your question/feedback:"
5. **WAIT FOR USER RESPONSE**: Do not proceed until user selects or provides feedback

**Example Format:**
```
**Advanced Elicitation Options**
Choose a number (0-8) or 9 to proceed:

0. [Method Name from elicitation-methods.md]
1. [Method Name from elicitation-methods.md]
2. [Method Name from elicitation-methods.md]
3. [Method Name from elicitation-methods.md]
4. [Method Name from elicitation-methods.md]
5. [Method Name from elicitation-methods.md]
6. [Method Name from elicitation-methods.md]
7. [Method Name from elicitation-methods.md]
8. [Method Name from elicitation-methods.md]
9. Proceed / No Further Actions

Select 1-9 or just type your question/feedback:
```

### 5. Elicitation Results Processing
**After User Selects Method (2-9):**
1. **Execute Selected Method**: Access method from elicitation-methods.md
2. **Apply from Current Role**: Execute method from current agent's perspective
3. **Present Results**: Deliver insights, critiques, or alternatives
4. **Offer Follow-up Options**:
   - **1. Apply changes and update section**
   - **2. Return to elicitation menu**
   - **3. Ask questions or engage further with this elicitation**

**Response Handling:**
- **Numbers 0-8**: Execute selected method, then re-offer choices
- **Number 9**: Proceed to next section or continue conversation
- **Direct Feedback**: Apply user's suggested changes and continue

### 6. Agent Permission Management
**When Processing Sections with Permission Fields:**
- **owner**: Agent role that initially creates/populates section
- **editors**: Agent roles allowed to modify section
- **readonly**: Sections that cannot be modified after creation

**Include Permission Notes in Document:**
Format: `_(This section is owned by {agent} and can only be modified by {agent})_`

### 7. Continue Until Complete
**Processing Flow:**
- Process all sections following above methodology
- Maintain document consistency throughout
- Preserve all user refinements and feedback
- Ensure no section skipped without justification

### 8. YOLO Mode Option
**User Can Toggle Modes:**
- User types `#yolo` to toggle YOLO mode
- YOLO mode processes all sections at once without elicitation
- Default remains Interactive mode with full elicitation

## Interactive Elements

### Template Selection
When multiple templates available:
1. List all available templates with descriptions
2. Allow user to select by number or name
3. Provide template preview if requested
4. Confirm selection before proceeding

### Section Review Process
For each section with `elicit: true`:
1. Present drafted content
2. Explain rationale and decisions
3. Offer elicitation methods (0-8) or proceed (9)
4. Process user selection
5. Loop until user chooses to proceed

### Mode Management
Present mode options:
1. Continue in Interactive mode (with elicitation)
2. Switch to YOLO mode (batch processing)
3. Pause and save progress
4. Exit and resume later

## Critical Violations
**NEVER:**
- Ask yes/no questions for elicitation
- Use any format other than 1-9 numbered options
- Create new elicitation methods
- Skip elicitation for efficiency reasons
- Create complete documents without user interaction

**ALWAYS:**
- Use exact 1-9 format when `elicit: true`
- Select options 2-9 from elicitation-methods.md only
- Provide detailed rationale explaining decisions
- End with "Select 1-9 or just type your question/feedback:"
- Wait for user response before proceeding

## Quality Assurance
- Ensure every section with `elicit: true` receives proper elicitation
- Validate user feedback incorporation
- Maintain document structure and consistency
- Preserve agent permission requirements
- Document all user decisions and refinements

## Success Criteria
1. Document created following template structure completely
2. All sections with `elicit: true` received proper user interaction
3. User refinements and feedback incorporated effectively
4. Agent permissions respected and documented
5. Final document meets quality standards and user requirements

## Output Deliverables
- Complete document following template specifications
- Record of user interactions and refinements
- Agent permission documentation
- Quality assurance validation confirmation

## Important Notes
- This is an EXECUTABLE WORKFLOW requiring strict adherence to interaction rules
- Quality depends on user engagement through elicitation process
- Template-driven approach ensures consistency and completeness
- Agent permissions maintain appropriate document control