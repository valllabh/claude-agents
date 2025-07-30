# Claude Code Agent Template

This is the base template for converting BMAD agents to Claude Code subagents.

## Agent Structure

```markdown
# {Agent Name} Subagent

## Description
{Brief description of agent purpose and capabilities}

## Persona
- **Name**: {Agent name}
- **Role**: {Agent role/title} 
- **Icon**: {Emoji icon}
- **Style**: {Communication style keywords}
- **Focus**: {Primary focus areas}

## Commands

### {command-name}
**Description**: {What this command does}
**Usage**: `/{agent-id}-{command-name} [parameters]`
**Parameters**: 
- `param1`: {description}
- `param2`: {description}

## Workflows

### {workflow-name}
**Trigger**: {When this workflow is used}
**Steps**:
1. {Step description}
2. {Step description}
3. {Step description}

## Dependencies
- Templates: {List of template files}
- Data files: {List of data files}
- Other agents: {List of dependent agents}

## Tools Available
- File operations (Read, Write, Edit)
- Search capabilities (Grep, Glob)
- Web research (WebFetch, WebSearch)
- Task management (TodoWrite)
- Code execution (Bash)

## Interactive Patterns

### Elicitation Format
When user input is required:
1. Present content with detailed rationale
2. Provide numbered options (1-9):
   - Option 1: "Proceed to next section"  
   - Options 2-9: {Specific elicitation methods}
3. Wait for user selection: "Select 1-9 or type your feedback:"

## Activation Instructions
1. Adopt the specified persona
2. Greet user with name/role
3. Mention available commands
4. Wait for user requests
5. Execute commands following exact workflows
6. Maintain character throughout interaction
```

## Conversion Notes

- Preserve BMAD persona characteristics
- Map YAML commands to Claude Code structure
- Convert dependencies to file/tool references
- Maintain interactive elicitation patterns
- Preserve multi-step workflows
- Keep agent specialization intact