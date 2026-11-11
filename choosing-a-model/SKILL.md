---
name: "choosing-a-model"
description: "Pick the right Claude model and effort level for a task, agent, or multi-agent system, and decide what to delegate to subagents. Use when the user asks which Claude model to use, how to cut cost or latency, whether to upgrade or downgrade a model, or how to split work between an orchestrator and worker/subagent models. Not for general prompting help or non-Claude models."
---

# Choosing a Claude model (agents, subagents, delegation)

Recommend a model, an effort level, and a delegation layout, and say how to
validate the choice. Based on Anthropic's guide:
https://platform.claude.com/docs/en/about-claude/models/choosing-a-model

**Freshness:** written from that page as of 2026-11-10. Model names, defaults and
IDs change. If the user's task depends on exact current details, check the page
(or the models overview) before answering.

## 1. Gather inputs (ask only what is missing)

- Task type: coding, agentic/long-horizon, data/content, high-volume simple work
- Latency and cost constraints
- Autonomy: minutes, or hours of unattended agent work
- Whether an eval set exists

## 2. Match the need to a model

| Need | Model | Typical use |
|---|---|---|
| Maximum capability | Fable 5.2 (`claude-fable-5-2`) | Hours-long agent sessions, deep multi-step research, final documents/decks |
| Complex agentic coding, enterprise work | Opus 5.5 (`claude-opus-5-5`) | Multi-hour coding agents, large refactors, computer use |
| Speed + capability, daily use | Sonnet 5.5 (`claude-sonnet-5-5`) | Code generation, data analysis, content, tool use in agents |
| Lowest latency and price | Haiku 5.5 (`claude-haiku-5-5`) | Real-time, bulk processing, cost-sensitive, subagent tasks |

Mythos 5.2 has Fable 5.2 capability but is only for verified organizations.
Most workloads start at Opus 5.5 per the guide.

## 3. Tune effort before switching models

The `effort` parameter trades intelligence against latency and cost within one
model, and is usually more effective than changing models. Documented defaults:
`high` for Fable 5.2, Fable 5.1, Opus 5 and Sonnet 5.5; `medium` for Opus 5.5 and
Haiku 5.5; for Opus 4.8/4.7, `xhigh` is the best point for most coding and agent
work.

## 4. Pick a starting strategy

- **Efficiency first:** build on Haiku 5.5, test hard, move up only for concrete
  gaps. Fits prototypes, tight latency, simple high-volume tasks.
- **Capability first:** build on Opus 5.5, tune prompts for it, evaluate, then lower
  effort or move to cheaper models over time. If `xhigh`/`max` evals still fall
  short on demanding reasoning or long-horizon agent work, go to Fable 5.2.

## 5. Multi-model designs (from the guide)

Combine a cheap model with a frontier one so most tokens bill at the low rate:

- **Executor with advisor:** one model does the task and escalates hard decisions
  to a stronger model.
- **Orchestrator with workers:** one model coordinates and delegates bulk work to
  lower-cost models. The guide lists Haiku 5.5 for subagent tasks.

The guide gives no detailed subagent rules; it points to Anthropic's cost and
intelligence optimization guide for measured examples.

### Delegation heuristics (author's guidance, not from the docs)

- Delegate narrow, well-specified, parallelizable steps (search, extraction,
  classification, formatting) to the cheapest model that passes your evals.
- Keep planning, ambiguous judgment calls and final synthesis on the stronger model.
- Give each subagent a self-contained brief and a fixed output format; return
  summaries to the orchestrator, not raw transcripts.
- Re-evaluate the split when models change.

## 6. Validate, do not guess

1. Build task-specific benchmarks. A good eval set is the most important step.
2. Run them on real prompts and data.
3. Compare accuracy, response quality and edge cases.
4. Weigh performance against cost, then decide.

## 7. Compatibility notes

- Opus 5.5 and Fable 5.2 use always-on adaptive thinking. Check breaking changes if
  you force tool use (`tool_choice` of `any`/`tool`), disable thinking, or use the
  `computer_20251124` tool.
- Fable 5.2: also check breaking changes if you edit `system`, `tools` or prior
  messages mid-conversation, switch models mid-conversation, or use the advisor tool.

## Output format

Reply with: **model**, **effort**, **delegation layout** (if any), **why** in 2-3
lines, and **what to evaluate** before committing. Keep it short.
