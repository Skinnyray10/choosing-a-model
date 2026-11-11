# Claude model facts

- **Source:** https://platform.claude.com/docs/en/about-claude/models/choosing-a-model
- **Last verified:** 2026-11-10
- Update this file, and the date, whenever the source changes. Keep rules out of
  here; they belong in `SKILL.md`.

## Need to model

| Need | Model | ID | Typical use |
|---|---|---|---|
| Maximum capability | Fable 5.2 | `claude-fable-5-2` | Hours-long agent sessions, deep multi-step research, final documents/decks |
| Complex agentic coding, enterprise work | Opus 5.5 | `claude-opus-5-5` | Multi-hour coding agents, large refactors, computer use |
| Speed and capability for daily use | Sonnet 5.5 | `claude-sonnet-5-5`* | Code generation, data analysis, content, tool use in agents |
| Lowest latency and price | Haiku 5.5 | `claude-haiku-5-5`* | Real-time, bulk processing, cost-sensitive work, subagent tasks |

\* The guide page does not list these two IDs. Confirm them in Anthropic's
models overview before relying on them.

Mythos 5.2 (`claude-mythos-5-2`) has Fable 5.2 capability but is only for
organizations verified through programs such as the Cyber Verification Program.
The guide says most workloads start at Opus 5.5.

## Effort defaults (documented)

| Default | Models |
|---|---|
| `high` | Fable 5.2, Fable 5.1, Opus 5, Sonnet 5.5 |
| `medium` | Opus 5.5, Haiku 5.5 |
| `xhigh` is the best point for most coding and agent work | Opus 4.8, Opus 4.7 |

## Compatibility notes

- Opus 5.5 and Fable 5.2 use always-on adaptive thinking. Check breaking changes
  if you force tool use (`tool_choice` of `any` or `tool`), disable thinking, or
  use the `computer_20251124` tool.
- Fable 5.2: also check breaking changes if you edit `system`, `tools` or prior
  messages mid-conversation, switch models mid-conversation, or use the advisor
  tool.
