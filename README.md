# @ceartshamus/sequential-thinking

A [Claude Agent Skill](https://agentskills.io) that guides a structured, reflective
problem-solving process: break complex problems into numbered thought steps with
explicit **revision**, **branching**, **hypothesis generation**, and **verification**
before concluding.

This package is distributed as a [skillpm](https://github.com/sbroenne/skillpm)
skill package — an ordinary npm package that exposes `skills/*/SKILL.md`.

## What it does

**Core principle:** Think step by step. Revise freely. Verify before concluding.

Use it for breaking down complex problems, planning and design with room for
revision, debugging where multiple hypotheses exist, and architecture decisions
with trade-offs. See [`skills/sequential-thinking/SKILL.md`](skills/sequential-thinking/SKILL.md)
for the full process and examples.

## Install

With [skillpm](https://github.com/sbroenne/skillpm) (recommended):

```bash
npx skillpm install @ceartshamus/sequential-thinking
```

skillpm resolves the package through npm, scans `node_modules/` for the
`skills/*/SKILL.md` pattern, and wires the skill into your agent directories.

Or add it to your project's `package.json` and let skillpm sync:

```bash
npm install @ceartshamus/sequential-thinking
npx skillpm sync
```

## Package layout

```
.
├── package.json
└── skills/
    └── sequential-thinking/
        └── SKILL.md
```

## License

MIT — see [LICENSE](LICENSE).
