# /agents-update - Update Claude Code Agents

Check for and install the latest version of Claude Code agents from GitHub releases.

## Description

This command checks GitHub for the latest release of Claude Code agents and offers to update your current installation if a newer version is available. It provides a seamless way to keep your agents up-to-date with the latest enhancements and bug fixes.

## Usage

```bash
/agents-update
```

## Features

- **Version Checking**: Compares your current installation with the latest GitHub release
- **Automatic Download**: Downloads and installs the latest release package
- **Backup Protection**: Creates backups of existing agents before updating
- **Safe Installation**: Verifies download integrity and installation success
- **Version Tracking**: Maintains version information for future update checks

## What It Does

1. **Check Current Version**: Reads your currently installed version
2. **Fetch Latest Release**: Queries GitHub API for the latest release
3. **Compare Versions**: Determines if an update is available
4. **Download Package**: Downloads the latest agents package from GitHub
5. **Backup Existing**: Creates a timestamped backup of current agents
6. **Install Update**: Extracts and installs the new agents
7. **Verify Installation**: Confirms all agents were installed correctly
8. **Cleanup**: Removes temporary download files

## Output Examples

### When Up to Date
```
[INFO] Checking for agent updates...
[INFO] Current version: v1.2.0
[INFO] Latest version: v1.2.0
[SUCCESS] You have the latest version of Claude Code agents!

Installed agents:
  analyst: Strategic analyst specializing in market research, brainstorming, competitive analysis
  architect: Holistic system architect specializing in comprehensive application design
  developer: Expert senior software engineer focused on code implementation
  product-manager: Investigative product strategist specialized in creating PRDs
  product-owner: Technical product owner specializing in backlog management
  qa-engineer: Senior developer and test architect specializing in code review
  scrum-master: Technical scrum master and story preparation specialist
  ux-expert: User experience designer and UI specialist
```

### When Update Available
```
[INFO] Checking for agent updates...
[INFO] Current version: v1.1.0
[INFO] Latest version: v1.2.0
[INFO] Update available: v1.1.0 → v1.2.0

[INFO] Downloading release v1.2.0 from GitHub...
[INFO] Backing up existing agents to: ~/.claude/agents-backup-20241130-143022
[SUCCESS] Backup created successfully
[INFO] Installing agents from downloaded release to ~/.claude/agents
[INFO] Installing agent: analyst.md
[SUCCESS] Successfully installed: analyst
[INFO] Installing agent: architect.md
[SUCCESS] Successfully installed: architect
...
[SUCCESS] 8 agents installed successfully!

[SUCCESS] GitHub installation completed successfully!
[INFO] You can now use these agents with Claude Code
[INFO] Example: claude "use analyst agent: help"
```

### When Installation Fails
```
[INFO] Checking for agent updates...
[ERROR] Failed to get latest release information
[INFO] Please check your internet connection and try again
```

## Technical Details

This command essentially runs the `install-agents.sh --from-github` functionality but:
- Provides a more user-friendly interface
- Integrates seamlessly with Claude Code's command system
- Gives clearer feedback about the update process
- Handles edge cases gracefully

## Prerequisites

- Internet connection to access GitHub API and releases
- One of: `curl` or `wget` for downloading
- `unzip` command for extracting release packages
- Write permissions to your Claude Code agents directory

## Error Handling

The command handles various error scenarios:

- **Network Issues**: Clear messages when GitHub is unreachable
- **Permission Problems**: Guidance when write access is denied
- **Missing Tools**: Instructions to install required tools
- **Corrupted Downloads**: Automatic retry and verification
- **Partial Updates**: Safe rollback if installation fails partway

## Files Modified

When updating, this command:
- **Backs up**: `~/.claude/agents/` → `~/.claude/agents-backup-[timestamp]/`
- **Updates**: All `.md` files in `~/.claude/agents/`
- **Creates**: `~/.claude/VERSION` with the new version number

## Integration

This command works seamlessly with:
- The main `install-agents.sh` script
- GitHub Actions release workflow
- Claude Code's command system
- Version tracking and backup systems

## Security

- Downloads only from official GitHub releases
- Verifies file integrity before installation
- Creates backups to prevent data loss
- Uses secure HTTPS connections for all downloads

Run `/agents-update` anytime to ensure you have the latest and greatest Claude Code agents!