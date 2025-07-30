# Claude Code Agents Usage Guide

This guide shows you how to use the enhanced Claude Code agents in this project. **All 8 agents have been fully enhanced with sophisticated task implementations.**

## Quick Start

### Basic Agent Usage
```bash
# Use an agent for a task
claude --print "use analyst agent to help with market research"

# Start an interactive session with an agent
claude "I need the analyst agent to facilitate a brainstorming session"

# Get help from a specific agent
claude --print "use analyst agent: show me your available commands"
```

### Key Enhanced Features

All enhanced agents include these powerful capabilities:
- **Interactive Elicitation**: 1-9 numbered options format with "Select 1-9 or type your feedback:"
- **Sequential Workflows**: Step-by-step execution with validation checkpoints
- **Document Generation**: Structured outputs with comprehensive details
- **Quality Validation**: Systematic validation and review processes
- **Brownfield Support**: Specialized workflows for existing project enhancement
- **AI Integration**: Optimized for AI consumption and generation

---

## Complete Agent Reference

### 1. **Analyst Agent (Mary)** 📊
*Strategic analyst specializing in market research, brainstorming, competitive analysis, and project briefing*

#### Commands Available

**`help`** - Show numbered list of available commands

**`create-doc [template]`** - **🚀 Enhanced** Template-driven document creation with interactive elicitation
```bash
claude "use analyst agent: I need to create a project brief document"
```
- **Features**: Mandatory step-by-step execution, 1-9 elicitation format, detailed rationale
- **Templates**: project-brief, market-research, competitor-analysis, brainstorming-output
- **Process**: Parse template → Set preferences → Process each section → Interactive elicitation → Save document

**`brainstorm [topic]`** - **🚀 Enhanced** Interactive brainstorming sessions
```bash
claude "use analyst agent: brainstorm ways to improve our development process"
```
- **4-Step Process**: Session setup → Approach selection → Technique execution → Document output
- **8 Techniques**: Classic Brainstorming, Mind Mapping, SCAMPER, Six Thinking Hats, Brainwriting, Reverse Brainstorming, Starbursting, Nominal Group Technique
- **Session Flow**: Warm-up → Divergent → Convergent → Synthesis
- **Output**: Executive summary, technique sections, idea categorization, action planning

**`research-prompt [topic]`** - Create deep research prompts for architectural decisions and analysis

---

### 2. **Scrum Master Agent (Bob)** 🏃
*Technical scrum master and story preparation specialist focused on creating crystal-clear stories*

#### Commands Available

**`help`** - Show numbered list of available commands

**`create-story [epic]`** - **🚀 Enhanced** Create implementation-ready brownfield stories
```bash
claude "use scrum-master agent: create a story for user authentication epic"
```
- **Purpose**: Bridge gap between documentation formats and executable stories
- **Workflow**: Documentation context check → Story identification → Technical context extraction → Story construction → Validation
- **Features**: Brownfield project support, context gathering, implementation details

**`validate-story [story]`** - **🚀 Enhanced** Comprehensive story validation
```bash
claude "use scrum-master agent: validate the user registration story"
```
- **Process**: Load configuration → Template completeness → File structure validation → UI/Frontend validation → Acceptance criteria assessment → Risk assessment

**`review-story [story]`** - **🚀 Enhanced** Senior developer code review
```bash
claude "use scrum-master agent: review the completed authentication story"
```
- **Prerequisites**: Story status "Review", all tasks completed, tests passing
- **Process**: Read story → Verify implementation → Focus on file list → Senior code review

**`break-down-epic [epic]`** - Break down large epics into manageable, implementable user stories

**`facilitate-ceremony [ceremony]`** - Facilitate agile ceremonies with structured agenda and outcomes

**`remove-impediment [issue]`** - Identify solutions for team impediments and obstacles

**`coach-team [topic]`** - Provide agile coaching on specific practices or challenges

**`retrospective-analysis [sprint]`** - Facilitate retrospective and identify improvement actions

---

### 3. **Developer Agent (James)** 💻
*Expert senior software engineer focused on code implementation, debugging, and development best practices*

#### Commands Available

**`help`** - Show numbered list of available commands

**`develop-story [story-id]`** - **🚀 Enhanced** Sequential story execution with comprehensive implementation
```bash
claude "use developer agent: develop story 1.3 for user dashboard"
```
- **Purpose**: Identify next logical story and prepare comprehensive, actionable story file
- **Process**: Load core configuration → Identify next story → Gather requirements → Architecture context → Story construction → Implementation readiness
- **Features**: Epic progression tracking, context gathering, dependency validation

**`execute-checklist [checklist-name]`** - **🚀 Enhanced** Validate documentation against checklists
```bash
claude "use developer agent: execute architecture checklist"
```
- **Process**: Initial assessment → Checklist selection → Execution mode → Document gathering → Validation → Results summary
- **Modes**: Interactive (section-by-section) or YOLO (all at once)

**`debug [issue]`** - Systematic debugging approach to identify and resolve code issues

**`refactor [component]`** - Improve code structure while maintaining functionality

**`review-code [file]`** - Perform comprehensive code review with improvement suggestions

**`setup-tests [component]`** - Create comprehensive test suite for the specified component

---

### 4. **Product Manager Agent (John)** 📋
*Investigative product strategist specialized in creating PRDs, product strategy, and stakeholder communication*

#### Commands Available

**`help`** - Show numbered list of available commands

**`document-project [focus]`** - **🚀 Enhanced** Generate AI-optimized project documentation
```bash
claude "use product-manager agent: document our existing authentication system"
```
- **Purpose**: Create structured reference materials for AI agents to understand project context
- **Process**: Initial project analysis → Codebase analysis → Documentation generation → AI optimization → Validation
- **Features**: PRD-focused documentation, brownfield architecture analysis, technical debt documentation

**`create-doc [template]`** - Execute template-driven document creation with interactive elicitation
- **Templates**: PRD, feature-spec, market-analysis, roadmap

**`research [topic]`** - Conduct comprehensive product research on specified topic

**`prioritize [features]`** - Apply prioritization frameworks to feature sets

**`analyze-market [segment]`** - Perform detailed market analysis for product positioning

---

### 5. **Architect Agent (Winston)** 🏗️
*Holistic system architect specializing in comprehensive application design and technology selection*

#### Commands Available

**`help`** - Show numbered list of available commands

**`design-system [requirements]`** - Create comprehensive system architecture based on requirements

**`select-technology [domain]`** - Analyze and recommend appropriate technologies for specific domains

**`design-api [service]`** - Design RESTful or GraphQL APIs with proper patterns and documentation

**`plan-infrastructure [scale]`** - Design infrastructure architecture for specified scale and requirements

**`review-architecture [system]`** - Perform architectural review and provide improvement recommendations

**`create-adr [decision]`** - Create Architecture Decision Record documenting key architectural choices

---

### 6. **QA Engineer Agent (Quinn)** 🧪
*Senior developer and test architect specializing in code review, refactoring, and comprehensive testing*

#### Commands Available

**`help`** - Show numbered list of available commands

**`review-code [file]`** - Perform comprehensive senior code review with refactoring and improvements

**`refactor [component]`** - Active refactoring with clear explanations and improvements

**`test-strategy [component]`** - Design comprehensive testing strategy for the specified component

**`performance-audit [system]`** - Analyze and improve system performance with specific recommendations

**`security-review [codebase]`** - Conduct security review and implement security improvements

**`mentor-session [topic]`** - Provide mentoring session on specific development or testing topics

---

### 7. **Product Owner Agent (Sarah)** 📝
*Technical product owner specializing in backlog management, story refinement, and acceptance criteria*

#### Commands Available

**`help`** - Show numbered list of available commands

**`refine-backlog [epic]`** - Refine and prioritize backlog items with detailed acceptance criteria

**`create-story [requirement]`** - Create detailed user stories with acceptance criteria and definition of done

**`plan-sprint [capacity]`** - Plan sprint with story selection and capacity considerations

**`review-artifacts [documents]`** - Review project artifacts for consistency and completeness

**`facilitate-ceremony [type]`** - Facilitate agile ceremonies (planning, review, retrospective)

**`prioritize-features [features]`** - Apply prioritization frameworks to determine feature ordering

---

### 8. **UX Expert Agent (Sally)** 🎨
*User experience designer and UI specialist focused on translating user needs into beautiful, functional designs*

#### Commands Available

**`help`** - Show numbered list of available commands

**`ai-ui-prompt [requirements]`** - **🚀 Enhanced** Generate AI frontend prompts using structured framework
```bash
claude "use ux-expert agent: create AI prompt for user registration form"
```
- **Purpose**: Create prompts for AI frontend tools (Vercel v0, Lovable.ai, etc.)
- **4-Part Framework**: High-level goal → Step-by-step instructions → Code examples & constraints → Strict scope definition
- **Features**: Mobile-first approach, tech stack integration, concrete examples

**`design-wireframe [feature]`** - Create detailed wireframes for specified feature or user flow

**`design-ui [component]`** - Design user interface components with detailed specifications

**`user-research [target]`** - Conduct user research and create user personas and journey maps

**`accessibility-audit [interface]`** - Review interface for accessibility compliance and improvements

**`prototype [feature]`** - Create interactive prototypes for user testing and validation

---

## Usage Examples

### Interactive Brainstorming Session
```bash
claude "use analyst agent: I want to brainstorm ways to reduce customer churn"
```
**Expected Flow:**
1. Mary asks 4 context questions (topic, constraints, goal, document output)
2. Presents 4 approach options for technique selection
3. Executes chosen brainstorming technique interactively
4. Generates structured document with categorized results

### Story Creation Workflow
```bash
claude "use scrum-master agent: create a story for mobile app authentication"
```
**Expected Flow:**
1. Bob checks for available documentation (PRD, architecture, epics)
2. Gathers essential context with required information checklist
3. Extracts technical context from available sources
4. Constructs story with implementation details and acceptance criteria
5. Validates completeness against requirements

### AI Frontend Prompt Generation
```bash
claude "use ux-expert agent: create AI prompt for responsive user dashboard"
```
**Expected Flow:**
1. Sally analyzes UI/UX specifications and architecture documents
2. Structures prompt using 4-part framework
3. Includes mobile-first design considerations
4. Provides specific technical constraints and examples
5. Defines clear scope boundaries for AI generation

## Best Practices

### Engaging with Enhanced Agents

1. **Be Specific in Your Requests**
   ```bash
   # Good
   claude "use analyst agent: brainstorm user onboarding improvements for our mobile app"
   
   # Less effective
   claude "use analyst agent: help me brainstorm"
   ```

2. **Engage in the Interactive Process**
   - Answer context questions thoroughly
   - Participate actively in elicitation when prompted
   - Use the 1-9 format when presented with options

3. **Document Your Sessions**
   - Always accept document output when offered
   - Documents are saved for future reference
   - Contains all ideas and insights generated

4. **Follow the Agent's Lead**
   - Trust the enhanced workflow process
   - Don't try to skip steps or rush through
   - Engage with one technique/process at a time

### Common Workflows

## Agent Sequence for New Projects

### Phase 1: Discovery & Planning
1. **Product Manager (John)** 📋
   ```bash
   claude "use product-manager agent: document-project for new user management system"
   claude "use product-manager agent: create-doc prd-template"
   ```
   - Create PRDs and product documentation
   - Conduct market research and feature prioritization
   - Document existing project architecture for AI agents

2. **Business Analyst (Mary)** 📊
   ```bash
   claude "use analyst agent: brainstorm user authentication improvements"
   claude "use analyst agent: create-doc project-brief-tmpl"
   ```
   - Facilitate brainstorming and ideation sessions
   - Create project briefs and competitive analysis
   - Generate research prompts for architectural decisions

### Phase 2: Design & Architecture
3. **UX Expert (Sally)** 🎨
   ```bash
   claude "use ux-expert agent: design-wireframe user registration flow"
   claude "use ux-expert agent: ai-ui-prompt responsive dashboard layout"
   ```
   - Design wireframes and user interfaces
   - Create frontend specifications and accessibility audits
   - Generate AI prompts for frontend development tools

4. **System Architect (Winston)** 🏗️
   ```bash
   claude "use architect agent: design-system user management requirements"
   claude "use architect agent: design-api authentication service"
   ```
   - Design system architecture and infrastructure
   - Select technologies and create Architecture Decision Records
   - Plan scalable infrastructure and API design

### Phase 3: Development Planning
5. **Product Owner (Sarah)** 📝
   ```bash
   claude "use product-owner agent: refine-backlog user authentication epic"
   claude "use product-owner agent: create-story user registration requirement"
   ```
   - Refine backlog and create detailed user stories
   - Plan sprints and define acceptance criteria
   - Review project artifacts for consistency

6. **Scrum Master (Bob)** 🏃
   ```bash
   claude "use scrum-master agent: create-story user authentication epic"
   claude "use scrum-master agent: validate-story user-registration-story"
   ```
   - Break down epics into implementable stories
   - Validate story completeness and clarity
   - Facilitate agile ceremonies and process guidance

### Phase 4: Implementation & Quality
7. **Developer (James)** 💻
   ```bash
   claude "use developer agent: develop-story 1.1"
   claude "use developer agent: execute-checklist architecture-checklist"
   ```
   - Implement story requirements sequentially
   - Execute comprehensive testing and debugging
   - Validate documentation against established checklists

8. **QA Engineer (Quinn)** 🧪
   ```bash
   claude "use qa-engineer agent: review-code authentication-module"
   claude "use qa-engineer agent: test-strategy user-management-system"
   ```
   - Perform senior code review and refactoring
   - Design comprehensive testing strategies
   - Conduct performance and security audits

## Agent Coordination Principles

- **Sequential Flow**: Follow the numbered sequence for new projects
- **Iterative Loops**: Return to earlier phases as needed for refinement
- **Parallel Work**: UX Expert and System Architect can work in parallel after initial planning
- **Handoff Quality**: Each agent prepares clear outputs for the next phase
- **Continuous Validation**: Product Owner and Scrum Master validate throughout

#### Legacy Workflow Examples
#### Full Development Cycle
1. **Planning**: `product-manager agent: document-project` → `analyst agent: create-doc`
2. **Story Creation**: `scrum-master agent: create-story` → `scrum-master agent: validate-story`
3. **Development**: `developer agent: develop-story` → `qa-engineer agent: review-code`
4. **Review**: `scrum-master agent: review-story` → `product-owner agent: review-artifacts`

#### Design to Development
1. **Research**: `ux-expert agent: user-research` → `ux-expert agent: design-wireframe`
2. **UI Generation**: `ux-expert agent: ai-ui-prompt` → Use with AI tools
3. **Architecture**: `architect agent: design-system` → `architect agent: design-api`
4. **Implementation**: `developer agent: develop-story`

## Quick Reference

### Agent Specializations
| Agent | Primary Focus | Key Enhanced Tasks |
|-------|---------------|----------------|
| **Analyst** | Research & Brainstorming | `brainstorm`, `create-doc` |
| **Scrum Master** | Story Management | `create-story`, `validate-story`, `review-story` |
| **Developer** | Implementation | `develop-story`, `execute-checklist` |
| **Product Manager** | Documentation | `document-project` |
| **Architect** | System Design | `design-system`, `review-architecture` |
| **QA Engineer** | Quality Assurance | `review-code`, `test-strategy` |
| **Product Owner** | Backlog Management | `refine-backlog`, `create-story` |
| **UX Expert** | Design & UI | `ai-ui-prompt`, `design-wireframe` |

### Enhanced Interactive Format
When agents need your input during enhanced workflows:
```
[Content and detailed rationale]

1. Proceed to next section
2. [Specific elicitation method]
3. [Specific elicitation method]
...
9. [Specific elicitation method]

Select 1-9 or just type your question/feedback:
```

## Troubleshooting

### Agent Not Responding as Expected
- Make sure you're in the test-project directory
- Verify the agent exists: `ls .claude/agents/`
- Try: `claude --print "list available subagents"`

### Interactive Sessions Timing Out
- Use shorter, more focused requests
- Break complex tasks into smaller steps
- Save progress frequently during long sessions

### Elicitation Format Issues
- Always respond with a number (1-9) or provide specific feedback
- Don't try to skip the interactive process
- Engage with the questions and options provided

The enhanced agents now provide sophisticated workflows within Claude Code, enabling advanced development processes with proper user interaction, document generation, and quality assurance!