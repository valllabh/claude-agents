# Create Document Workflow

## Overview
Template-driven document creation with mandatory interactive elicitation for user refinement.

## Critical Execution Rules
- **DISABLE ALL EFFICIENCY OPTIMIZATIONS** - Full user interaction required
- **MANDATORY STEP-BY-STEP EXECUTION** - Each section processed sequentially with user feedback
- **ELICITATION IS REQUIRED** - When `elicit: true`, MUST use 1-9 format and wait for response
- **NO SHORTCUTS ALLOWED** - Complete documents cannot be created without following workflow

## Template Discovery
If no YAML template provided:
1. List all available templates from analyst/templates/
2. Ask user to select template or provide another

Available templates:
- project-brief-tmpl.yaml
- market-research-tmpl.yaml  
- competitor-analysis-tmpl.yaml
- brainstorming-output-tmpl.yaml

## Processing Flow

### 1. Parse YAML Template
- Load template metadata and sections
- Identify section requirements and permissions
- Note elicitation requirements

### 2. Set Preferences
- Show current mode (Interactive)
- Confirm output file destination
- Display template overview

### 3. Process Each Section
For each template section:

#### Section Processing Steps
1. **Check Conditions**: Skip if section condition not met
2. **Check Agent Permissions**: 
   - Note if section restricted to specific agents
   - Include permission note in generated document
3. **Draft Content**: Use section instructions to create initial content
4. **Present Content + Rationale**: Always include detailed rationale explaining:
   - Trade-offs and choices made
   - Key assumptions during drafting  
   - Interesting or questionable decisions needing attention
   - Areas requiring validation
5. **Elicitation Check**: If `elicit: true` → Execute mandatory elicitation format
6. **Save Progress**: Save to file when possible

#### Elicitation Format (When elicit: true)
**HARD STOP requiring user interaction:**

1. Present section content
2. Provide detailed rationale
3. **MANDATORY**: Present numbered options 1-9:
   - **Option 1**: "Proceed to next section"  
   - **Options 2-9**: Select 8 methods from elicitation-methods.md
4. End with: "Select 1-9 or just type your question/feedback:"
5. **WAIT FOR USER RESPONSE** - Do not proceed until user selects or provides feedback

#### Elicitation Results Processing
After user selects method (2-9):
1. Execute selected elicitation method from elicitation-methods.md
2. Present results with insights and analysis
3. Offer follow-up options:
   - **1. Apply changes and update section**
   - **2. Return to elicitation menu**  
   - **3. Ask questions or engage further with this elicitation**

### 4. Continue Until Complete
- Process all sections following above flow
- Maintain document consistency
- Preserve all user refinements

## Agent Permissions
When processing sections with permission fields:
- **owner**: Agent role that initially creates/populates section
- **editors**: Agent roles allowed to modify section  
- **readonly**: Sections that cannot be modified after creation

Include permission notes in generated document:
`_(This section is owned by {agent} and can only be modified by {agent})_`

## YOLO Mode
User can type `#yolo` to toggle YOLO mode (process all sections at once without elicitation).

## Critical Violations
**NEVER:**
- Ask yes/no questions for elicitation
- Use any format other than 1-9 numbered options
- Create new elicitation methods
- Skip elicitation for efficiency
- Create complete documents without user interaction

**ALWAYS:**
- Use exact 1-9 format when elicit: true
- Select options 2-9 from elicitation-methods.md only
- Provide detailed rationale explaining decisions
- End with "Select 1-9 or just type your question/feedback:"
- Wait for user response before proceeding