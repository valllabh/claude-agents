# Claude Code Agent Test Project

This test project validates the installation and functionality of Claude Code agents converted from BMAD.

## Available Agents

The following agents have been installed and are available for use:

- **analyst** - Market research, brainstorming, competitive analysis
- **architect** - System design, architecture documents, technology selection  
- **developer** - Full stack development and implementation
- **product-manager** - Product management, PRD creation, strategy
- **product-owner** - Product owner, backlog management, story refinement
- **qa-engineer** - Senior code review, refactoring, quality assurance
- **scrum-master** - Scrum master, story creation, epic management
- **ux-expert** - UX design, wireframes, AI UI generation

## Usage

To use an agent with Claude Code:

```bash
claude-code --agent <agent-name>
```

For example:
```bash
claude-code --agent analyst
claude-code --agent developer
```

## Project Commands

- `npm start` - Run the test application
- `npm test` - Run test suite
- `npm run lint` - Lint code
- `npm run build` - Build project

## Agent Configuration

Agents are configured in `.config/claude-code/agents/` directory with the following structure:

- `subagent.md` - Main agent definition
- `commands/` - Individual command files
- `workflows/` - Complex multi-step workflows
- `templates/` - Document templates