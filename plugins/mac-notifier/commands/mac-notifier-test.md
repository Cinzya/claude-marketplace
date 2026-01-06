---
description: Test the mac-notifier plugin installation and send a test notification
---

Test the Mac Notifier plugin by checking dependencies and sending a test notification.

## Testing Steps

Run these checks to verify the plugin is working:

### 1. Check Dependencies

First, verify that the required dependencies are installed:

```bash
# Check for jq (JSON processor)
command -v jq &> /dev/null && echo "jq: OK" || echo "jq: MISSING - install with 'brew install jq'"

# Check for terminal-notifier
command -v terminal-notifier &> /dev/null && echo "terminal-notifier: OK" || echo "terminal-notifier: MISSING - install with 'brew install terminal-notifier'"
```

### 2. Send Test Notification

Send a test notification to verify permissions:

```bash
terminal-notifier -title "Mac Notifier Test" -message "If you see this, notifications are working!" -sound "Hero"
```

### 3. Check Log File

If notifications aren't appearing, check the debug log for errors. The log is stored in the plugin's `logs/` directory.

## Troubleshooting

If notifications don't appear:

1. **Check System Preferences** > **Notifications** > **terminal-notifier**
   - Ensure notifications are allowed
   - Check that "Do Not Disturb" is off

2. **Install missing dependencies:**
   ```bash
   brew install jq terminal-notifier
   ```

3. **Grant notification permissions:**
   - The first time terminal-notifier runs, macOS may ask for permission
   - If denied, go to System Preferences > Notifications to enable

## Expected Behavior

When working correctly:
- You'll receive a notification when Claude finishes a task
- Notifications only appear when you've switched away from the originating app
- Clicking a notification returns you to the app where Claude was running
