# Enhanced Claude Code Agents

Sophisticated Claude Code subagents with enhanced workflows and interactive capabilities.

## Project Structure

```
claude-agents/
├── agents/                    # Agent definitions
│   ├── analyst.md
│   ├── architect.md
│   ├── developer.md
│   ├── product-manager.md
│   ├── product-owner.md
│   ├── qa-engineer.md
│   ├── scrum-master.md
│   └── ux-expert.md
├── test-project/             # Test environment
└── AGENT-USAGE-GUIDE.md     # Agent usage documentation
```

## Agent Capabilities

Enhanced agents include sophisticated workflows with:
- Interactive elicitation (1-9 numbered options)
- Sequential task execution with validation
- Template-driven document generation
- Comprehensive quality assurance processes
- Brownfield project support
- AI-optimized workflows

## Testing Workflow

1. **Navigate to test project**:
   ```bash
   cd test-project
   ```

2. **Initialize Claude Code**:
   ```bash
   claude init
   ```

3. **Copy agents to test project**:
   ```bash
   cp -r ../agents .claude/
   ```

4. **Copy usage documentation**:
   ```bash
   cp ../AGENT-USAGE-GUIDE.md .
   ```

5. **Invoke agents in optimal sequence**:

## Agent Sequence for New Projects

### Phase 1: Discovery & Planning
1. **Product Manager (John)** 📋
   - Create PRDs and product documentation
   - Conduct market research and feature prioritization
   - Commands: `create-doc`, `research`, `document-project`

2. **Business Analyst (Mary)** 📊
   - Facilitate brainstorming and ideation
   - Create project briefs and competitive analysis
   - Commands: `brainstorm`, `create-doc`, `research-prompt`

### Phase 2: Design & Architecture
3. **UX Expert (Sally)** 🎨
   - Design wireframes and user interfaces
   - Create frontend specifications and accessibility audits
   - Commands: `design-wireframe`, `design-ui`, `ai-ui-prompt`

4. **System Architect (Winston)** 🏗️
   - Design system architecture and infrastructure
   - Select technologies and create ADRs
   - Commands: `design-system`, `select-technology`, `design-api`

### Phase 3: Development Planning
5. **Product Owner (Sarah)** 📝
   - Refine backlog and create user stories
   - Plan sprints and define acceptance criteria
   - Commands: `refine-backlog`, `create-story`, `plan-sprint`

6. **Scrum Master (Bob)** 🏃
   - Break down epics into implementable stories
   - Validate story completeness and clarity
   - Commands: `create-story`, `validate-story`, `break-down-epic`

### Phase 4: Implementation & Quality
7. **Developer (James)** 💻
   - Implement story requirements sequentially
   - Execute comprehensive testing and debugging
   - Commands: `develop-story`, `debug`, `refactor`

8. **QA Engineer (Quinn)** 🧪
   - Perform senior code review and refactoring
   - Design comprehensive testing strategies
   - Commands: `review-code`, `refactor`, `test-strategy`

## Agent Coordination Principles

- **Sequential Flow**: Follow the numbered sequence for new projects
- **Iterative Loops**: Return to earlier phases as needed for refinement
- **Parallel Work**: UX Expert and System Architect can work in parallel after initial planning
- **Handoff Quality**: Each agent prepares clear outputs for the next phase
- **Continuous Validation**: Product Owner and Scrum Master validate throughout