---
description: Load a session by name
---

Upload the current session by performing the following steps:

1. Take the input argument `$ARGUMENT` and check if a file exists at `.claude/sessions/$ARGUMENT.md` at the root of the project. If `$ARGUMENT` already ends with `.md`, also check for a file without the extra "m" (e.g., handle a case like `session.mmd` by checking `session.md`).
2. If the session file does **not** exist:
   - Notify the user that the session was not found.
   - List all available `.md` session files located in the `.claude/sessions/` directory.
   - Prompt the user to choose from the list.
3. If the session file **does** exist:
   - Update the current session pointer by writing the `$ARGUMENT.md` filename to `.claude/sessions/.current-session`.

I've loaded the session [$ARGUMENT]. Would you like to continue where you left off?
