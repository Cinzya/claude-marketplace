---
description: Update the current development session
---

Update the current development session by:

1. Check if `.claude/sessions/.current-session` exists to find the active session
2. If no active session, inform user to start one with `/session-start`
3. If session exists, append to the session file with:
   - Current timestamp
   - The update: $ARGUMENTS (or if no arguments, summarize recent activities)
   - Git status summary:
     - Files added/modified/deleted (from `git status --porcelain`)
     - Current branch and last commit
   - Todo list status:
     - Number of completed/in-progress/pending tasks
     - List any newly completed tasks
   - **Explanations & Rationale**:
     - Why certain implementation decisions were made
     - Why specific approaches were chosen over alternatives
   - **Sources & References**:
     - Documentation links consulted
     - Stack Overflow answers or articles referenced
     - Framework/library documentation used
   - **Problems Encountered**:
     - Issues that came up during implementation
     - Error messages or unexpected behavior
     - How each problem was resolved (or if still open)
   - Solutions implemented
   - Code changes made

Keep updates concise but comprehensive for future reference.

Example format:

```
### Update - 2025-06-16 12:15 PM

**Summary**: Implemented user authentication

**Git Changes**:
- Modified: app/middleware.ts, lib/auth.ts
- Added: app/login/page.tsx
- Current branch: main (commit: abc123)

**Todo Progress**: 3 completed, 1 in progress, 2 pending
- ✓ Completed: Set up auth middleware
- ✓ Completed: Create login page
- ✓ Completed: Add logout functionality

**Explanations & Rationale**:
- Used JWT tokens instead of sessions for stateless auth (better for API scaling)
- Chose middleware approach to centralize auth checks rather than per-route guards

**Sources & References**:
- Next.js middleware docs: https://nextjs.org/docs/app/building-your-application/routing/middleware
- JWT best practices: https://auth0.com/blog/jwt-authentication-best-practices/

**Problems Encountered**:
- Issue: Middleware was running on static assets causing 401 errors
  - Resolution: Added matcher config to exclude _next/static paths
- Issue: Token refresh causing race conditions
  - Resolution: Implemented token refresh queue with mutex lock

**Details**: [user's update or automatic summary]
```
