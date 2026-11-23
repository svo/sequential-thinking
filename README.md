# @ceartshamus/sequential-thinking

A [Claude Agent Skill](https://agentskills.io) that guides a structured, reflective
problem-solving process: work through complex problems in sequential steps with
**revision**, **branching**, **hypothesis generation**, and **verification**, then
report the verified conclusion and the evidence behind it.

This package is distributed as a [skillpm](https://github.com/sbroenne/skillpm)
skill package — an ordinary npm package that exposes `skills/*/SKILL.md`.

## What it does

**Core principle:** Think step by step. Revise freely. Verify before concluding.

Use it for breaking down complex problems, planning and design with room for
revision, debugging where multiple hypotheses exist, and architecture decisions
with trade-offs. See [`skills/sequential-thinking/SKILL.md`](skills/sequential-thinking/SKILL.md)
for the full process and examples.

The steps are the model's working and stay in its own reasoning. The response
reports the result: the answer, the evidence it rests on, the alternatives set
aside, the checks it passed, and any open questions.

The skill deliberately does not ask the model to write its reasoning steps into the
response. Recent Claude models decline such prompts with a `reasoning_extraction`
refusal — see
[Keep reasoning in thinking blocks](https://platform.claude.com/docs/en/build-with-claude/refusals-and-fallback#keep-reasoning-in-thinking-blocks).
To see a summary of the model's reasoning, read its summarized `thinking` blocks
instead (`thinking: {"type": "adaptive", "display": "summarized"}` on the Claude
API).

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

### Infrastructure images

The `infrastructure/` Packer + Ansible setup builds two multi-arch Docker images,
published to Docker Hub under `svanosselaer/`:

- `sequential-thinking-builder` — the containerised toolchain (Packer, Ansible,
  Docker, Go, Node) used by CI to build images and publish the package. Its
  default entrypoint (`bin/test`) runs `ansible-lint` and `shellcheck`.
- `sequential-thinking-development` — the Vagrant development box image.

Each image has a workflow that rebuilds it (per-arch matrix plus a `latest`
manifest) on changes to the infrastructure, on a weekly schedule, or manually:

- [`.github/workflows/builder.yml`](.github/workflows/builder.yml)
- [`.github/workflows/development.yml`](.github/workflows/development.yml)

Both build inside the builder image via `./build.sh <image> <arch>` →
`bin/create-image` → `packer build`, then `./push.sh` / `./create-latest.sh`.

### Publishing to npm

[`.github/workflows/service.yml`](.github/workflows/service.yml) packs and
publishes the package to npm. It runs `./publish.sh`, which executes
`bin/publish` (`npm publish`) inside the builder image. It triggers on a
version tag push (`v*`) or manually:

```bash
npm version patch   # or minor / major — commits and creates the vX.Y.Z tag
git push --follow-tags
```

### Required CI secrets

| Secret | Used by | Purpose |
|---|---|---|
| `NPM_TOKEN` | `service.yml` | npm automation token for publishing under `ceartshamus`. |
| `DOCKER_USERNAME` | all three | Docker Hub user for pushing/pulling the images. |
| `DOCKER_TOKEN` | all three | Docker Hub access token. |

Create the `NPM_TOKEN` as an **Automation** token at
<https://www.npmjs.com/settings/ceartshamus/tokens>, then add all three under the
repository's **Settings → Secrets and variables → Actions**.

## License

MIT — see [LICENSE](LICENSE).
