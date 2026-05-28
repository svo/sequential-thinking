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

## Development

### Linting

```bash
npm install
npm run lint
```

`npm run lint` runs four checks:

- `lint:md` — [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2) on the Markdown.
- `lint:spec` — [`skills-ref`](https://www.npmjs.com/package/skills-ref) frontmatter and
  naming validation against the Agent Skills spec (the same check `skillpm publish` enforces).
- `lint:skill` — [`skill-validator`](https://github.com/agent-ecosystem/skill-validator) static
  analysis of the skill (structure, frontmatter, token budget, content density,
  link integrity, and cross-language contamination), run in `--strict` mode.
- `lint:pkg` — [publint](https://github.com/bluwy/publint) for npm publish hygiene.

`skill-validator` is a Go binary, not an npm dependency, so install it once:

```bash
brew tap agent-ecosystem/tap && brew install skill-validator
# or:
go install github.com/agent-ecosystem/skill-validator/cmd/skill-validator@latest
```

CI runs the same checks on every push and pull request (see
[`.github/workflows/lint.yml`](.github/workflows/lint.yml)).

## License

MIT — see [LICENSE](LICENSE).
