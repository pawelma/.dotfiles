Given a Jira ticket's title and description, explore the codebase to understand what needs to be done and ask clarifying questions before implementation begins.

## Input

$ARGUMENTS

A Jira ticket with key, title, and description. If not provided, ask the user or suggest running `/start-jira-work` first.

## Goals

1. **Understand scope** — What needs to change? Does this span multiple systems?
2. **Explore deeply** — Which files, specs, and history are involved?
3. **Reason before asking** — Answer your own questions first, surface only genuine gaps
4. **Align with the user** — Confirm understanding before proposing
5. **Propose simply** — KISS. YAGNI. Minimum that satisfies the ticket.

## When to Abbreviate

If the ticket is unambiguous and single-scoped (typo fix, config value, version bump), skip the full process. Quick exploration, confirm scope, propose directly.

## Steps

### 1. Analyze the Ticket and Assess Scope

Read the ticket carefully. Identify the main objective, requirements, constraints, and acceptance criteria.

**Before exploring in depth**, assess scope:
- Is this one coherent change or does it need decomposition into smaller, independently shippable pieces?
- Does this span multiple systems or repositories? All repos live in `~/projects/` — fire subagents to explore them in parallel. If a needed repo isn't cloned, ask the user to clone it.
- If decomposition is needed, flag it immediately and help break the ticket down before going deeper.

### 2. Explore the Codebase

Search for relevant code:
- Files, classes, or functions mentioned or implied by the ticket
- Related code that might be affected directly or implicitly
- Patterns and conventions in the same area

**Investigate history and specs of affected code:**
- `git log` / `git blame` on files that will change — focus on commits that explain current design decisions or recent regressions
- Read related spec files to understand intended behavior and existing coverage
- Note anything surprising that should inform the proposal

**Exploration is sufficient when you can:**
- Describe the current behavior the ticket wants to change
- Name the specific files that need modification
- Identify the spec files that cover the affected code
- Explain the patterns used in adjacent code

If you can't do all four, keep exploring.

### 3. Socratic Reasoning

Before asking the user anything, ask yourself the questions you would ask them. For each one, attempt to answer it from the ticket, codebase, specs, git history, and domain conventions.

Classify each into:
- **Resolved** — confident answer from evidence
- **Assumption** — plausible but needs user confirmation
- **Unknown** — genuinely can't determine

### 4. Present Phase 1: Understanding + Questions

Present exploration results and Socratic reasoning:

```markdown
## Understanding

<1-2 sentence summary of what the ticket asks for>

## Relevant Code

- `path/to/file.rb` — <why relevant>
- `path/to/spec.rb` — <what it covers>

## Current Behavior

<How things work today in the areas that will change>

## What I Concluded

- <Resolved item with evidence: "X does Y because of Z (see file:line)">

## Assumptions to Confirm

- I'm assuming X because Y — is that right?

## Questions

1. <Genuine unknown, as multiple choice when possible>
2. <"Should X return nil or raise?" over "How should X behave?">
```

**Do not propose an approach yet.** Wait for the user to confirm, correct, or answer.

### 5. Clarify Until Aligned

Loop:
1. Ask the highest-value unresolved questions (batch 3-6, prefer multiple choice).
2. Wait for answers. Do not guess or make silent assumptions.
3. Read answers critically — do they resolve the ambiguity or raise new ones?
4. Restate your updated understanding in 2-4 bullets and ask the user to confirm.
5. Repeat until every open question is answered AND the user explicitly confirms.

Rules:
- Never stop asking just because you have "enough to start." Stop only when nothing material is ambiguous.
- If the user gives a short or unclear answer, follow up.
- If you catch yourself assuming, convert it to a question.
- Surface conflicts: if an answer contradicts the code or another answer, call it out.
- Prefer concrete, decision-forcing questions. Frame as multiple choice when possible.
- One question too many is better than implementing the wrong thing.

**Exit condition:** The user confirms alignment with explicit language ("yes, that's right", "looks good, let's do it"). On ambiguous responses ("go ahead", "sure", "ok") — restate once more: "Just to confirm — [summary]. Ready to proceed?"

### 6. Present Phase 2: Proposed Approach

Only after alignment is confirmed.

**For large/complex tickets**, propose 2-3 approaches: lead with the simplest as your recommendation, include alternatives only when there's a genuine trade-off worth the user's time. For smaller tickets, a single approach is fine.

```markdown
## Proposed Approach

### Steps
1. <First step>
2. <Second step>

### Files to Modify
- `path/to/file.rb` — <what changes>

### Decomposition (if medium/large)
- Suggested order of incremental changes
- Which step is riskiest or should come first
- Whether to split across multiple PRs

### Testing Approach
- Domain-level tests reflecting the business intent behind the changes
- Tests as specifications of intended behavior — context for future readers
- Existing specs that need updating to match new behavior
- Mechanical checks (edge cases, error paths) secondary

### Complexity
<Small/Medium/Large> — <brief justification>

### Risks
- <Anything to watch out for>
```

If proposing the approach surfaces new unknowns, return to step 5.

## Principles

- **Read-only** — this is an exploration phase, do not make changes
- **KISS** — simplest approach that satisfies the ticket
- **YAGNI** — no gold-plating, no speculative abstractions
- **Alignment is the exit condition**, not your own confidence

## Related Commands

- `/start-jira-work` — fetch the ticket and create a branch (run first if you haven't)
- After alignment, use Plan mode or `/superpowers:writing-plans` for complex implementations
