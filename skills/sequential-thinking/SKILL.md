---
name: sequential-thinking
description: Break down complex problems into explicit sequential reasoning steps with revision, branching, hypothesis generation, and verification
user_invocable: true
---

# Sequential Thinking

## Overview

A structured, reflective problem-solving process that breaks complex problems into numbered thought steps. Each thought can build on, question, or revise previous insights as understanding deepens.

**Core principle:** Think step by step. Revise freely. Verify before concluding.

## When to Use

- Breaking down complex problems into steps
- Planning and design with room for revision
- Analysis that might need course correction
- Problems where the full scope is not clear initially
- Problems that require a multi-step solution
- Tasks that need to maintain context over multiple steps
- Situations where irrelevant information needs to be filtered out
- Decisions that involve weighing competing trade-offs
- Diagnosing a problem where several explanations are possible

The process is domain-independent. It is a generic reasoning sequence that you
transpose onto whatever problem you are facing — research, writing, planning,
operations, design, diagnosis, or a software task — by treating each thought as a
step toward the answer in that domain's own terms.

## The Process

### Step 1: Estimate Scope

Before your first thought, estimate how many thought steps you will need. This estimate can be adjusted up or down as you progress.

### Step 2: Execute Thought Steps

For each thought step, output using this format:

```
**[Thought N/Total]**
[Your current thinking step]
```

Each thought can include:
- Regular analytical steps
- Revisions of previous thoughts
- Questions about previous decisions
- Realizations about needing more analysis
- Changes in approach
- Hypothesis generation
- Hypothesis verification

### Step 3: Revise When Needed

When a previous thought was wrong or incomplete, use:

```
**[Revision: Thought N revises Thought M]**
[Why the previous thought was wrong and the corrected thinking]
```

Do not pretend earlier thoughts were correct. Explicitly mark corrections.

### Step 4: Branch When Needed

When exploring an alternative approach from an earlier point, use:

```
**[Branch from Thought N: branch-name]**
[Alternative reasoning path]
```

You can have multiple branches. Label them clearly so you can compare outcomes.

### Step 5: Generate and Verify Hypotheses

When you have enough reasoning to form a hypothesis:

```
**[Hypothesis]**
[Your proposed solution or conclusion]

**[Verification]**
[Check the hypothesis against your chain of thought steps]
[Does it hold up? Are there contradictions?]
```

If verification fails, return to thought steps. Do not force a broken hypothesis.

### Step 6: Conclude

Only when you are genuinely satisfied with your reasoning:

```
**[Answer]**
[Your final, verified conclusion]
```

## Rules

1. **Start with an initial estimate** of needed thoughts, but adjust freely
2. **Question and revise** previous thoughts whenever warranted
3. **Add more thoughts** if needed, even after reaching your initial estimate
4. **Express uncertainty** when present — do not pretend to know
5. **Mark revisions and branches** explicitly so reasoning is traceable
6. **Ignore irrelevant information** — filter noise at each step
7. **Generate a hypothesis** when you have enough evidence
8. **Verify the hypothesis** against your chain of thought before concluding
9. **Repeat** hypothesis-verification cycles until satisfied
10. **Only conclude** when you have a genuinely verified answer

## Anti-Patterns

| Anti-Pattern | Correction |
|---|---|
| Skipping to answer without steps | Always show your reasoning chain |
| Pretending early thoughts were right | Use revision markers explicitly |
| Never revising | If nothing needs revision, you may not be thinking critically enough |
| Forcing a conclusion when verification fails | Return to thought steps instead |
| Ignoring branches when multiple approaches exist | Explore alternatives explicitly |
| Vague thoughts like "this seems right" | Be specific: what exactly and why |
| Adjusting estimate down to rush to finish | Add thoughts if the problem warrants them |

## Examples

The same sequence is shown below on two different problems. The structure —
estimate, step, revise, hypothesize, verify, conclude — is identical; only the
domain-specific content changes. The second example transposes it onto a software
development task.

### Example 1: a general problem

Given: "Our team keeps missing delivery dates. What should we change?"

```
**[Thought 1/6]**
First, I need to find the actual bottleneck rather than guess. Candidate causes:
too much work started at once, unclear requirements, or slow review and approval.
I should look for evidence of each before proposing a change.

**[Thought 2/6]**
Looking at recent cycles: most items sit "in progress" for days with little
movement, and several are started before earlier ones finish. That points to too
much work in progress, not slow individual effort.

**[Thought 3/6]**
But requirements also change mid-cycle on roughly half the items. That could be
the real driver — rework, not work-in-progress.

**[Revision: Thought 4 revises Thought 2]**
I attributed the delay to work-in-progress, but Thought 3 shows heavy mid-cycle
rework. The two interact: with many items in flight, a single change ripples
across all of them. The primary lever is reducing rework by settling requirements
before work starts; limiting work-in-progress is secondary.

**[Thought 5/6]**
Constraint: the team cannot add people and cannot extend the cycle length. So the
change has to be a process change, not more capacity.

**[Hypothesis]**
Require a short, agreed "ready" check before any item is started, and cap the
number of items in progress. This attacks rework first and work-in-progress
second, within the no-extra-capacity constraint.

**[Verification]**
- Addresses rework (the main driver from Thought 4): a readiness check reduces
  mid-cycle changes ✓
- Addresses work-in-progress (Thought 2): an explicit cap limits in-flight items ✓
- Respects the constraint (no new people, fixed cycle): both are process changes ✓
- No contradictions with the reasoning chain.

**[Answer]**
Introduce a lightweight "definition of ready" gate before starting any item, and
set an explicit limit on work in progress. This targets rework as the primary
cause and work-in-progress as the secondary one, without needing more people or a
longer cycle.
```

### Example 2: the same sequence, transposed onto software development

Given: "Users intermittently get logged out. Why?"

```
**[Thought 1/5]**
Intermittent suggests state or timing, not a hard logic error. Candidate causes:
tokens expiring early, requests reaching an instance that never saw the login, or
a race during token refresh. I'll look for evidence for each before committing.

**[Thought 2/5]**
Logs show logouts cluster right after deploys and during traffic spikes — both
moments when more than one app instance is serving requests. That points away from
token expiry (which would be uniform over time) and toward instances not sharing
session state.

**[Thought 3/5]**
Sessions are held in per-instance memory, and routing is not pinned to an instance.
A request can land on an instance that never recorded the login — which would look
exactly this intermittent.

**[Revision: Thought 4 revises Thought 1]**
I listed a token-refresh race as a likely cause, but the clustering around
multi-instance conditions in Thoughts 2–3 makes unshared session state the far
stronger explanation. I'm setting the refresh-race hypothesis aside unless shared
state is ruled out.

**[Hypothesis]**
Logouts occur because sessions live in per-instance memory while requests are not
pinned to the instance holding the session. Moving sessions to a shared store (or
enabling sticky routing) will resolve it.

**[Verification]**
- Explains intermittency (depends on which instance a request hits) ✓
- Explains clustering after deploys and spikes (more instances in play) ✓
- Fits the evidence better than uniform token expiry ✓
- No contradiction with the reasoning chain.

**[Answer]**
The cause is per-instance in-memory sessions with no shared store and no sticky
routing. Move session state to a shared store so any instance can serve any
request; sticky routing is a weaker stopgap.
```

## After Concluding

Sequential thinking produces a verified conclusion — it does not carry out the work.
Once you reach an `[Answer]`, move to acting on it:

- Translate the conclusion into concrete next actions in the terms of your domain.
- Where the conclusion chose an approach or identified a cause, carry it out.
- Verify the conclusion holds in practice before considering it done.

What "carrying it out" means depends on the domain — enacting a plan, producing the
writing, applying the fix, building the chosen design. If your environment provides
dedicated skills for those follow-on steps, use them.
