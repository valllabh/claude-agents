# BMAD to Claude Code Migration

Convert BMAD agents to Claude Code subagents through research, analysis, and one-time conversion.

## Setup

Place your BMAD agents in `bmad-commands/` directory.

## Migration Prompt

```bash
claude-code "BMAD to Claude Code Migration

RESEARCH:
1. Study BMAD framework from https://github.com/bmadcode/BMAD-METHOD
   - Understand agent structure, task definitions, configuration format
   - Learn how tasks are organized and executed
   - Identify tools and capabilities used

2. Research Claude Code subagents
   - Learn subagent architecture and file structure
   - Understand command definitions and tool integration
   - Study configuration formats and best practices

ANALYSIS:
3. Analyze all BMAD agents in bmad-commands/ directory
   - Inventory every agent, task, parameter, and tool
   - Document current functionality and dependencies

CONVERSION:
4. Convert all BMAD agents to Claude Code subagents
   - Create equivalent subagents in claude-code-agents/ directory
   - Map every BMAD task to Claude Code command
   - Preserve all parameters and functionality
   - Configure appropriate tools for each command
   - Maintain proper subagent structure

VALIDATION:
5. Generate conversion report comparing BMAD tasks to Claude Code commands
   - Verify all tasks converted
   - Confirm tool mappings
   - Flag any missing functionality"
```

## Output

Converted subagents will be created in `claude-code-agents/` directory, ready for use with Claude Code.