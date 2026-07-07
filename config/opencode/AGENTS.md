# Global Agent Guidelines

This file configures AI coding agents across all repositories.

## Commits

**IMPORTANT: Commit as you go.** Do not accumulate changes and commit at the end. Commit immediately after completing each logical step — one fix, one refactoring, one new function, one test addition. Never ask the user "should I commit?" or suggest committing later as a batch. Just commit after each step.

Write concise commit messages without conventional commit prefixes (chore, feat, fix, etc.).
These labels consume screen space without adding reasoning value.

Multiline messages are acceptable when more detail is needed, but keep them easy to scan.

Never use `git add .` or `git add -A`. Only stage specific files by name — both modified and newly created.
Never add files created by other agents or sessions without explicit user instruction.
This prevents accidentally committing files that should not be in the repository (logs, credentials, local config, generated files, etc.).

**NEVER amend or squash commits unless the user explicitly asks for it.** Always create new commits. Amending hides changes from the reviewer and destroys the tracking and review trail — each commit must be independently reviewable. If a previous commit needs a follow-up fix, create a new commit — do not amend the original.

## Pull Request Descriptions

Never modify an existing PR description without reading the current one first (`gh pr view --json body`). It may contain manual edits made outside the session. Fetch the up-to-date description, then decide whether an update is needed — and preserve any manual changes when updating.

## Tooling / Search Conventions

Prefer ripgrep (`rg`) over `grep` for all code searches.

## Cross-Repository References

When a task or conversation references another repository, check if it's available locally under `~/projects/` before resorting to GitHub or other remote sources. Most repositories will be cloned there and can be browsed directly.

## Code Comments

Avoid comments for self-describing code. Prefer no comments at all - commit messages should capture intent.

If a comment is truly necessary, reserve it for ambiguous code that won't become stale.
First, try using descriptive variable and method names to reveal intent.

## File Moves and Git History

When moving files, commit the move immediately before making any other changes.
This preserves git history and enables reviewers to see atomic changes.

Workflow:
1. Move the file
2. Commit the move
3. Update code and references
4. Commit the updates

## Documentation Search

When you need to search documentation for libraries, frameworks, or tools, use the `context7` MCP server.

## Proactive Skill Delegation

Invoke these skills automatically when the context warrants it — do not wait for the user to explicitly name them.

**CI / Code Quality:**
- `/ci-autofix` — The umbrella skill for all CI failures. Invoke proactively when CI fails on the current branch, when you notice a Semaphore/CircleCI failure in conversation context, or after pushing changes that might break CI. Also use when the user shares a failed CI link or mentions "CI is red". It handles Semaphore test failures, Codacy issues, and static analysis (RuboCop) failures — no need to invoke `/fix-semaphore-failures`, `/fix-codacy-issues`, or `/fix-rubocop` separately when `/ci-autofix` is running.
- `/fix-rubocop` — Invoke proactively after making Ruby code changes, before creating a PR, or when RuboCop violations are mentioned. Run it as a cleanup step after implementation work.

**Pull Requests:**
- `/create-pr` — Invoke proactively when implementation work is complete, all tests pass, and the branch is ready. If the user says "I'm done", "ship it", "ready to merge", or similar — create the PR without being asked.

**General rule:** If you've just finished a task and the next logical step is one of these skills, invoke it. Don't ask "should I create a PR?" or "should I run RuboCop?" — just do it.

## CI Debugging

When diagnosing CI failures, remember that CI merges master before running tests — check the merge result, not just the branch HEAD. Before running specs, confirm you're on the correct branch and reproducing the actual CI scenario rather than running unrelated infra/LocalStack checks.

## Jira Tickets

When asked to fetch, retrieve, look up, or start working on a Jira ticket, use the `/start-jira-work` command.

Examples of when to use this command:
- "What is MIND-3061 about?"
- "Fetch the Jira ticket from my branch"
- "Get the description of https://simplybusiness.atlassian.net/browse/MIND-3061"
- "What does my current ticket say?"
- "Start working on my Jira ticket"
- "Pick up my next In Progress ticket"

The command accepts:
- Jira URL (e.g., `https://simplybusiness.atlassian.net/browse/MIND-3061`)
- Ticket key (e.g., `MIND-3061`)
- No input: auto-detects from branch name, or finds your first "In Progress" ticket and creates a new branch from fresh main/master

`/start-jira-work` runs the full pipeline: fetch ticket → plan work (explore + clarify) → implement via ralph loop. No need to manually chain `/plan-work` or `/ralph-loop`.
