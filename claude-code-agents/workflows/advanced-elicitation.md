# Advanced Elicitation Workflow

## Overview
Provide structured reflective and brainstorming actions to enhance content quality through systematic elicitation techniques supporting iterative refinement with multiple analytical perspectives.

## Use Cases
- Template-driven document creation enhancement
- General chat content improvement  
- Post-section review and refinement
- Deep exploration of ideas and concepts

## Workflow Steps

### 1. Context Analysis and Method Selection
**Actions:**
- Analyze content type (technical specs, user stories, architecture, requirements)
- Assess complexity level (simple, moderate, complex)
- Identify stakeholder needs and risk level
- Evaluate creative potential and innovation opportunities

**Method Selection Strategy:**
- **Always Include Core Methods** (3-4):
  - Expand or Contract for Audience
  - Critique and Refine
  - Identify Potential Risks
  - Assess Alignment with Goals
- **Context-Specific Methods** (4-5):
  - Technical Content: Tree of Thoughts, ReWOO, Meta-Prompting
  - User-Facing Content: Agile Team Perspective, Stakeholder Roundtable
  - Creative Content: Innovation Tournament, Escape Room Challenge
  - Strategic Content: Red Team vs Blue Team, Hindsight Reflection

### 2. Section Context and Review Setup
**When invoked after outputting content:**
- Provide 1-2 sentence context summary of what user should look for
- Explain visual elements (diagrams, charts) if present
- Clarify scope options for multi-item sections:
  - Entire section as whole
  - Individual items within section
  - Specific components or elements

### 3. Present Elicitation Options
**Review Request Process:**
- Ask user to review drafted content
- Inform they can suggest direct changes OR select elicitation method
- Present 9 intelligently selected methods (0-8) plus "Proceed" (9)
- Use concise method names only
- Await simple numeric selection

**Action List Presentation Format:**
```
**Advanced Elicitation Options**
Choose a number (0-8) or 9 to proceed:

0. [Method Name]
1. [Method Name]
2. [Method Name]
3. [Method Name]
4. [Method Name]
5. [Method Name]
6. [Method Name]
7. [Method Name]
8. [Method Name]
9. Proceed / No Further Actions
```

### 4. Method Execution Framework
**Execution Process:**
1. Retrieve specific method from elicitation-methods data file
2. Apply method from current role's perspective
3. Provide results with actionable insights and critiques
4. Re-offer same 9 options until user selects 9 or gives direct feedback

**Response Handling:**
- **Numbers 0-8**: Execute selected method, then re-offer choices
- **Number 9**: Proceed to next section or continue conversation
- **Direct Feedback**: Apply user's suggested changes and continue

### 5. Execution Guidelines
**Quality Standards:**
- Be concise with focus on actionable insights
- Stay relevant to specific content being analyzed
- Clearly identify personas for multi-persona methods
- Maintain efficient process flow
- Tie all elicitation back to content analysis

## Interactive Elements

### Method Selection Interface
Present numbered elicitation options based on content analysis:
0-8. [Intelligently selected methods from elicitation-methods.md]
9. Proceed / No Further Actions

### Post-Elicitation Options
After method execution, offer:
1. Apply insights and update content
2. Return to elicitation menu
3. Continue exploring current method
4. Ask questions about elicitation results

## Template Integration
**For Template Document Creation:**
- After outputting each section, automatically trigger elicitation
- Present context summary for section review
- Offer elicitation methods for refinement
- Loop until user selects "Proceed"

**For General Chat Usage:**
- User requests "do advanced elicitation" or similar
- Select 9 relevant methods for current context
- Same 0-9 selection process applies

## Quality Assurance
- Never ask yes/no questions - always use 1-9 format
- Select methods only from approved elicitation-methods data
- Provide detailed rationale for all decisions and trade-offs
- Maintain content relevance throughout process
- Ensure user controls flow and progression

## Success Metrics
- Enhanced content quality through iterative refinement
- User engagement and satisfaction with elicitation process
- Actionable insights generated from selected methods
- Improved alignment with user objectives and requirements