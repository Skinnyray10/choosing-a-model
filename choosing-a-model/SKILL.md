---
name: "choosing-a-model"
description: "Pick the right Claude model and effort level for a task, agent, or multi-agent system, and decide what to delegate to subagents. Use when the user asks which Claude model to use, how to cut cost or latency, whether to upgrade or downgrade a model, or how to split work between an orchestrator and worker/subagent models. Not for general prompting help or non-Claude models."
---

# Choosing a Claude model (agents, subagents, delegation)

Recommend a model, an effort level and a delegation layout, and say how to
validate the choice. This file holds the rules only. Current model facts (names,
IDs, defaults) live in `references/models.md`, each with a source URL and a
last-verified date.

## Before answering

1. Read `references/models.md`. If its last-verified date is more than 30 days
   old, or the user needs exact current values (IDs, defaults, prices), check
   the source URL first. If you cannot verify, say so.
2. Gather inputs, asking only what is missing: task type, latency and cost
   limits, autonomy horizon (minutes or hours), and whether an eval set exists.

## Pick a model

Match the need to a model with the table in `references/models.md`, then pick a
starting strategy:

- **Efficiency first:** build on the cheapest model, test hard, move up only for
  concrete gaps. Fits prototypes, tight latency, simple high-volume work.
- **Capability first:** build on the guide's usual starting model, tune prompts,
  evaluate, then lower effort or move to cheaper models over time. If the
  highest effort levels still fall short on demanding or long-horizon work, move
  to the top model.

## Effort

Effort trades intelligence against latency and cost inside one model, and is
usually more effective than switching models. Start at the model's documented
default, or at the workload-specific starting point in `references/models.md`
when one exists. Raise it only when evals show a gap; lower it to save cost when evals
pass. Any level above the default is a judgment call to test, not a rule.

## Multi-model designs (from the guide)

- **Executor with advisor:** one model does the task and escalates hard
  decisions to a stronger one.
- **Orchestrator with workers:** one model coordinates and delegates bulk work
  to lower-cost models. The guide lists the smallest model for subagent tasks.

If you use Anthropic's advisor tool (beta), check the pairings in
`references/models.md` first: the advisor must be at least as capable as the
executor, and some pairings return a 400 error. The pattern can also be built
with your own escalation logic.

The guide gives no detailed subagent rules; it points to Anthropic's cost and
intelligence optimization guide for measured examples.

### Delegation heuristics (author's guidance, not from the docs)

- Delegate narrow, well-specified, parallelizable steps (search, extraction,
  classification, formatting) to the cheapest model that passes your evals.
- Keep planning, ambiguous judgment calls and final synthesis on the stronger
  model.
- Give each subagent a self-contained brief and a fixed output format; return
  summaries to the orchestrator, not raw transcripts.
- Re-evaluate the split when models change.

In Claude Code, `agents/` has optional subagent definitions (lookup, coder,
reviewer) with a model and effort preset. They are starting points to adjust
with evals.

## Validate, do not guess

1. Build task-specific benchmarks. A good eval set is the most important step.
2. Run them on real prompts and data.
3. Compare accuracy, response quality and edge cases.
4. Weigh performance against cost, then decide.

## Output format

At most 10 lines, no tables, no preamble: **model**, **effort**, **delegation**
(if any), **why** (2-3 lines), **what to evaluate**. Mark anything that is your
judgment rather than the guide's.
