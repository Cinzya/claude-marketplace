#!/bin/bash

# Configuration for Claude Code Enhanced Notification System
# This file defines paths and settings used by all scripts

# Plugin directory - set by Claude Code when running hooks
# Falls back to script directory if not set (for manual testing)
if [[ -z "$CLAUDE_PLUGIN_ROOT" ]]; then
    # Fallback for manual testing: derive from script location
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    CLAUDE_PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
fi

# Log file location - stored within the plugin directory
CLAUDE_NOTIFICATIONS_LOG_DIR="$CLAUDE_PLUGIN_ROOT/logs"
CLAUDE_NOTIFICATIONS_LOG_FILE="$CLAUDE_NOTIFICATIONS_LOG_DIR/debug.log"

# Ensure log directory exists
mkdir -p "$CLAUDE_NOTIFICATIONS_LOG_DIR"

# Log rotation settings
CLAUDE_NOTIFICATIONS_MAX_LOG_LINES=10000  # Maximum lines before rotation
CLAUDE_NOTIFICATIONS_KEEP_LOG_LINES=5000  # Lines to keep after rotation

# Claude settings file (for reference, not used by plugin directly)
CLAUDE_NOTIFICATIONS_SETTINGS_FILE="$HOME/.claude/settings.json"

# Terminal notifier path (try common locations)
if command -v terminal-notifier &> /dev/null; then
    CLAUDE_NOTIFICATIONS_TERMINAL_NOTIFIER_PATH=$(which terminal-notifier)
elif [[ -f "/opt/homebrew/bin/terminal-notifier" ]]; then
    CLAUDE_NOTIFICATIONS_TERMINAL_NOTIFIER_PATH="/opt/homebrew/bin/terminal-notifier"
elif [[ -f "/usr/local/bin/terminal-notifier" ]]; then
    CLAUDE_NOTIFICATIONS_TERMINAL_NOTIFIER_PATH="/usr/local/bin/terminal-notifier"
else
    CLAUDE_NOTIFICATIONS_TERMINAL_NOTIFIER_PATH="terminal-notifier"
fi

# Export configuration variables
export CLAUDE_PLUGIN_ROOT
export CLAUDE_NOTIFICATIONS_LOG_DIR
export CLAUDE_NOTIFICATIONS_LOG_FILE
export CLAUDE_NOTIFICATIONS_MAX_LOG_LINES
export CLAUDE_NOTIFICATIONS_KEEP_LOG_LINES
export CLAUDE_NOTIFICATIONS_SETTINGS_FILE
export CLAUDE_NOTIFICATIONS_TERMINAL_NOTIFIER_PATH

# Function to get script directory (where this config.sh is located)
get_script_dir() {
    local script_path
    if [[ -n "${BASH_SOURCE[0]}" ]]; then
        script_path="${BASH_SOURCE[0]}"
    else
        # Fallback for scripts sourcing this file
        script_path="$CLAUDE_PLUGIN_ROOT/hooks/scripts/config.sh"
    fi
    echo "$(cd "$(dirname "$script_path")" && pwd)"
}

# Export the function
export -f get_script_dir
