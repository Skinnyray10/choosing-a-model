# Claude model facts

- **Sources:** the selection guide (watched by the monthly check),
  https://platform.claude.com/docs/en/about-claude/models/choosing-a-model
  Not watched: the models overview (Sonnet 5.5 and Haiku 5.5 IDs),
  https://platform.claude.com/docs/en/models/overview ; the Sonnet 5.5
  what's-new page (effort starting points, breaking changes),
  https://platform.claude.com/docs/en/models/sonnet-5-5/whats-new-sonnet-5-5 ; and the
  advisor tool page (pairings),
  https://platform.claude.com/docs/en/agents-and-tools/tool-use/advisor-tool
- **Last verified:** 2026-11-10 (guide and IDs); 2026-11-11 (sections marked below)
- Update this file, and the date, whenever the source changes. Keep rules out of
  here; they belong in `SKILL.md`.

## Need to model

| Need | Model | ID | Typical use |
|---|---|---|---|
| Maximum capability | Fable 5.2 | `claude-fable-5-2` | Hours-long agent sessions, deep multi-step research, final documents/decks |
| Complex agentic coding, enterprise work | Opus 5.5 | `claude-opus-5-5` | Multi-hour coding agents, large refactors, computer use |
| Speed and capability for daily use | Sonnet 5.5 | `claude-sonnet-5-5` | Code generation, data analysis, content, tool use in agents |
| Lowest latency and price | Haiku 5.5 | `claude-haiku-5-5` | Real-time, bulk processing, cost-sensitive work, subagent tasks |

The guide page does not list the Sonnet 5.5 and Haiku 5.5 IDs; they come from
the models overview. Prices, context windows and output limits are not kept
here: check the models overview for them.

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

## Effort starting points by workload (Sonnet 5.5 page, verified 2026-11-11)

Effort levels on Sonnet 5.5 are recalibrated versus Sonnet 5, so re-run your
effort sweep instead of carrying a setting over. Starting points: `high` unless
the workload is agentic or latency-sensitive; for agentic coding and multistep
tool use, `medium` for well-specified tasks and `high` for harder or longer
ones; for chat and other latency-sensitive work, `medium` or `low`.

## Advisor tool pairings (beta; verified 2026-11-11)

The advisor tool lets an executor consult a stronger advisor mid-generation in
one request. The advisor must be at least as capable as the executor. Beta
header `advisor-tool-2026-03-01`. Available in beta on the Claude API, Claude
Platform on AWS and Claude Models on Google Cloud (Anthropic managed).

Accepted advisors per executor. The table is partial: the source text was cut
before the Fable 5.1 and Mythos 5.1 executor rows.

| Executor | Accepted advisors |
|---|---|
| Fable 5.2 | Mythos 5.2, Fable 5.2 |
| Opus 5.5 | Mythos and Fable 5.2, 5.1 and 5; Opus 5.5, Opus 5 |
| Sonnet 5.5 | Mythos and Fable 5.2, 5.1 and 5; Opus 5.5, Opus 5; Sonnet 5.5 |
| Haiku 5.5 | Mythos and Fable 5.2, 5.1 and 5; Opus 5.5, Opus 5, Opus 4.8, Opus 4.7; Sonnet 5.5, Sonnet 5; Haiku 5.5 |

A Sonnet 5.5 executor rejects Opus 4.8, Opus 4.7, Sonnet 5 and Haiku 5.5 as
advisors with a 400 error, and the advisors it accepts return their advice
encrypted, so your client cannot read it. The executor-with-advisor pattern can
also be built with your own escalation logic, without this tool.

## Sonnet 5.5 breaking changes (verified 2026-11-11)

- `thinking: {"type": "disabled"}` returns a 400. Use `between_tools`, which is
  accepted at `low`, `medium` and `high` effort but not at `xhigh` or `max`.
- Forced tool use (`tool_choice` of `any` or `tool`) returns a 400. `auto` and
  `none` work.
- Thinking blocks are tied to the model that produced them and to the
  conversation. Keep conversations append-only: replaying a block after editing
  `system`, `tools` or earlier messages can return a 400.
- `computer_20251124` is rejected on the Claude API. Use `computer_toolset_20260801`.
- Some advisor pairings are rejected (see above).
