# Claude Code Agents - BMAD Migration

This directory contains Claude Code subagents converted from the BMAD framework.

## Agent Structure

Each agent follows this pattern:
```
agent-name/
├── subagent.md       # Main agent definition
├── commands/         # Individual command files
├── workflows/        # Complex multi-step workflows
└── templates/        # Document templates
```

## Converted Agents

- **analyst** (Mary) - Market research, brainstorming, competitive analysis
- **architect** (Winston) - System design, architecture documents, technology selection  
- **developer** (James) - Full stack development and implementation
- **product-manager** (John) - Product management, PRD creation, strategy
- **product-owner** (Sarah) - Product owner, backlog management, story refinement
- **qa-engineer** (Quinn) - Senior code review, refactoring, quality assurance
- **scrum-master** (Bob) - Scrum master, story creation, epic management
- **ux-expert** (Sally) - UX design, wireframes, AI UI generation

## Usage

Each agent can be invoked as a Claude Code subagent with preserved BMAD functionality.