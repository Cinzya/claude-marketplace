---
description: Show help for the Mac Notifier plugin
---

Show help for the Mac Notifier plugin.

## Mac Notifier Plugin

This plugin sends macOS system notifications when Claude Code completes tasks while you're working in another application.

### How It Works

1. **Notification Hook**: When Claude sends a notification (e.g., permission requests), you get a system notification if you've switched away from the originating app.

2. **Stop Hook**: When Claude finishes running, you get a notification to return to your work.

3. **Smart Detection**: Notifications only appear when you've switched to a different application. If you're still focused on the terminal/IDE where Claude is running, no notification is sent.

4. **Click to Return**: Clicking a notification activates the originating application, bringing you back to Claude.

### Available Commands

- `/mac-notifier-help` - Show this help
- `/mac-notifier-test` - Test notifications and check dependencies

### Supported Applications

The plugin detects and can return you to:

**IDEs:**
- IntelliJ IDEA
- Cursor
- VS Code
- WebStorm
- PHPStorm
- PyCharm
- Sublime Text

**Terminals:**
- Terminal.app
- iTerm2
- Ghostty
- Alacritty
- Warp

### Requirements

- **macOS** (this plugin uses macOS-specific notification APIs)
- **terminal-notifier** - Install with `brew install terminal-notifier`
- **jq** - Install with `brew install jq`

### Debug Logs

Logs are stored in the plugin's `logs/debug.log` file. Check this file if notifications aren't appearing as expected.

### Troubleshooting

If notifications don't appear:

1. Check that `terminal-notifier` is installed: `which terminal-notifier`
2. Verify notification permissions in System Preferences > Notifications
3. Ensure "Do Not Disturb" is disabled
4. Run `/mac-notifier-test` to diagnose issues
