# OpenCode Docker sandbox kit

This docker sandbox kit packages a ready-to-use OpenCode sandbox with your local OpenCode config and agent configs.

## Create a Docker sandbox with this kit in current directory

```sh
sbx run --kit "$HOME/dotfiles/openbox" opencode .
```

## Authentication
To make provider credentials available inside the sandbox the following commands are available:

```
sbx secret set -g openai
sbx secret set -g anthropic
sbx secret set -g google
sbx secret set -g xai
sbx secret set -g groq
sbx secret set -g aws
```

## Sync config on local machine

Run from this directory:

```sh
./scripts/sync-opencode-and-skills.sh
```

## Notes
- OpenCode reads config at startup; restart OpenCode after config changes.
- External skills are discovered from `~/.agents/skills` in the sandbox home.
