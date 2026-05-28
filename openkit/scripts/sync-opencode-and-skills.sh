#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SANDBOX_DIR="$ROOT_DIR/files/home"

SRC_OPENCODE_DIR="${HOME}/.config/opencode"
SRC_SKILLS_DIR="${HOME}/.agents/skills"

DST_OPENCODE_DIR="$SANDBOX_DIR/.config/opencode"
DST_SKILLS_DIR="$SANDBOX_DIR/.agents/skills"

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    printf 'Error: required command not found: %s\n' "$1" >&2
    exit 1
  }
}

require_file() {
  [ -f "$1" ] || {
    printf 'Error: required file not found: %s\n' "$1" >&2
    exit 1
  }
}

require_dir() {
  [ -d "$1" ] || {
    printf 'Error: required directory not found: %s\n' "$1" >&2
    exit 1
  }
}

require_cmd rsync
require_file "$SRC_OPENCODE_DIR/opencode.jsonc"
require_file "$SRC_OPENCODE_DIR/tui.json"
require_dir "$SRC_SKILLS_DIR"

mkdir -p "$DST_OPENCODE_DIR" "$DST_SKILLS_DIR"

printf 'Syncing opencode config...\n'
rsync -av --delete \
  "$SRC_OPENCODE_DIR/opencode.jsonc" \
  "$SRC_OPENCODE_DIR/tui.json" \
  "$DST_OPENCODE_DIR/"

printf 'Syncing skills...\n'
rsync -av --delete \
  "$SRC_SKILLS_DIR/" \
  "$DST_SKILLS_DIR/"

skill_dirs_count="$(find "$DST_SKILLS_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')"
skill_files_count="$(find "$DST_SKILLS_DIR" -type f | wc -l | tr -d ' ')"

printf '\nSync complete.\n'
printf 'Sandbox root: %s\n' "$SANDBOX_DIR"
printf 'Opencode files: %s, %s\n' \
  "$DST_OPENCODE_DIR/opencode.jsonc" \
  "$DST_OPENCODE_DIR/tui.json"
printf 'Skill directories: %s\n' "$skill_dirs_count"
printf 'Skill files: %s\n' "$skill_files_count"
