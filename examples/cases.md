# Test cases

Manual checks for the skill. Run them in a fresh conversation with the skill
installed, without naming the skill. Compare the answer with "Pass if" and
"Fail if". Re-run after any change to `SKILL.md` or `references/models.md`.

## Should trigger

### 1. High-volume classification

> I classify 50,000 support tickets a day and escalate the ambiguous ones. Which
> Claude model and effort should I use, and how do I split the work?

Pass if: starts on the smallest model (Haiku 5.5) at its default effort; sends
ambiguous tickets to a stronger model (executor with advisor); asks for evals on
labeled tickets.
Fail if: recommends the largest model for everything, or raises effort without
saying it is a judgment call.

### 2. Long-running coding agent with subagents

> I'm building a coding agent that works for several hours and uses subagents for
> search. Which models and effort?

Pass if: orchestrator on Opus 5.5 at its default effort; Fable 5.2 only if evals
at the highest effort levels fall short; search subagents on Haiku 5.5; says the
role split is author guidance, not the guide's; mentions checking breaking
changes (adaptive thinking).
Fail if: presents the subagent split as official documentation.

### 3. Cheap prototype

> I'm prototyping a simple FAQ chatbot on a tight budget. What model?

Pass if: Haiku 5.5, moving up only for concrete gaps found in tests.
Fail if: starts at the top model without a reason.

### 4. Accuracy over cost

> My task is hard multi-step research and accuracy matters more than cost. Where
> do I start?

Pass if: starts at Opus 5.5 as the guide says; goes to Fable 5.2 only if evals
at `xhigh` or `max` are not enough; notes Mythos 5.2 is for verified
organizations only, if it mentions it.
Fail if: jumps straight to Fable 5.2 with no eval step.

### 5. Missing data

> How much does Opus 5.5 cost per million tokens?

Pass if: says prices are not in the skill's data, and checks the models overview
or says it could not verify.
Fail if: states a price from memory with no source.

### 8. Invalid advisor pairing

> I want a Sonnet 5.5 executor with Haiku 5.5 as the advisor using the advisor
> tool. Will that work?

Pass if: says that pairing is rejected (the advisor must be at least as capable
as the executor, and Sonnet 5.5 does not accept Haiku 5.5 as an advisor), and
suggests an accepted advisor such as Opus 5.5.
Fail if: says it works, or gives no source for the pairing rules.

## Should not trigger

### 6. General prompting help

> Explícame qué es un prompt.

Pass if: the skill does not activate; plain explanation.

### 7. Non-Claude model

> Which GPT model should I use for my chatbot?

Pass if: the skill does not activate, or it says it only covers Claude models.
Fail if: it gives a Claude-based recommendation as if it answered the question.
