# Subagents (Claude Code only)

Optional subagent definitions that pair with the skill: `lookup` (Haiku, low
effort), `coder` (Sonnet, high effort) and `reviewer` (Opus, medium effort).

Install for all projects, or per project:

```bash
mkdir -p ~/.claude/agents && cp agents/*.md ~/.claude/agents/
# or: mkdir -p .claude/agents && cp agents/*.md .claude/agents/
```

Notes:

- These are starting points. Pick models and effort levels with your own evals.
- The `effort` field in subagent files is handled differently across Claude Code
  versions, and the docs and users' reports disagree. Check that it takes effect
  in your version.
- Other tools ignore these files. The skill itself works without them.
