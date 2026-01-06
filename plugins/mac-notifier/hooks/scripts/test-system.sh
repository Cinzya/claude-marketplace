#!/bin/bash

# Test script for Claude Code Enhanced Notification System
# This script verifies that all components are working correctly

echo "Testing Claude Code Enhanced Notification System..."

# Source the configuration to get paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/config.sh" ]]; then
    source "$SCRIPT_DIR/config.sh"
else
    echo "ERROR: Config file not found at $SCRIPT_DIR/config.sh"
    exit 1
fi

echo "Plugin directory: $CLAUDE_PLUGIN_ROOT"
echo "Log file: $CLAUDE_NOTIFICATIONS_LOG_FILE"
echo ""

# Test 1: Check if all required files exist
echo "Checking required files..."
required_files=("config.sh" "common.sh" "notify-completion.sh" "notify-handler.sh")
missing_files=()

for file in "${required_files[@]}"; do
    if [[ ! -f "$SCRIPT_DIR/$file" ]]; then
        missing_files+=("$file")
    fi
done

if [[ ${#missing_files[@]} -gt 0 ]]; then
    echo "ERROR: Missing files: ${missing_files[*]}"
    exit 1
else
    echo "OK: All required files present"
fi

# Test 2: Check if scripts are executable
echo "Checking script permissions..."
for file in "${required_files[@]}"; do
    if [[ ! -x "$SCRIPT_DIR/$file" ]]; then
        echo "WARNING: $file is not executable. Making it executable..."
        chmod +x "$SCRIPT_DIR/$file"
    fi
done
echo "OK: All scripts are executable"

# Test 3: Check dependencies
echo "Checking dependencies..."
if ! command -v jq &> /dev/null; then
    echo "ERROR: jq is not installed. Install with: brew install jq"
    exit 1
fi

if ! command -v terminal-notifier &> /dev/null; then
    echo "ERROR: terminal-notifier is not installed. Install with: brew install terminal-notifier"
    exit 1
fi
echo "OK: All dependencies available"

# Test 4: Test notification system
echo "Testing notification scripts..."
test_json='{"session_id":"test-123","transcript_path":"/Users/test/.claude/projects/-Users-test-project/test.jsonl","stop_hook_active":false}'

# Test completion notification (should skip because we're focused)
echo "$test_json" | "$SCRIPT_DIR/notify-completion.sh" 2>/dev/null

# Test handler notification (should skip because we're focused)
test_notification='{"session_id":"test-123","transcript_path":"/Users/test/.claude/projects/-Users-test-project/test.jsonl","title":"Test","message":"System test notification"}'
echo "$test_notification" | "$SCRIPT_DIR/notify-handler.sh" 2>/dev/null

echo "OK: Notification scripts executed (check logs for details)"

# Test 5: Check log file
echo "Checking log file..."
if [[ -f "$CLAUDE_NOTIFICATIONS_LOG_FILE" ]]; then
    echo "OK: Log file exists at: $CLAUDE_NOTIFICATIONS_LOG_FILE"
    line_count=$(wc -l < "$CLAUDE_NOTIFICATIONS_LOG_FILE" 2>/dev/null || echo 0)
    echo "    Log entries: $line_count lines"
else
    echo "INFO: Log file will be created when hooks are triggered"
fi

# Test 6: Send a visible test notification
echo ""
echo "Sending test notification..."
terminal-notifier -title "Mac Notifier Test" -message "System test successful!" -sound "Glass"

echo ""
echo "All tests completed!"
echo ""
echo "Debug logs: tail -f $CLAUDE_NOTIFICATIONS_LOG_FILE"
