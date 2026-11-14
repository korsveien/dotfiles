#!/bin/sh
# Writes the state of the Claude Code session in this pane to the tmux window
# option @agent_status. tmux.conf shows the state in the tab.
# Claude Code hooks in ~/.claude/settings.json call this script.
#
# Usage: claude-status.sh working|waiting|done|error|clear|tool|spin
#   tool: read the PreToolUse JSON on stdin. A tool that asks the user a
#         question sets "waiting". All other tools set "working".
#   spin: animate the global option @agent_frame while a window is "working".
#         "working" starts it in the background. It stops when no window is
#         "working".

FRAMES='· ✢ ✳ ✶ ✻ ✽ ✻ ✶ ✳ ✢'
LOCK="${TMPDIR:-/tmp}/tmux-agent-spinner-$(id -u)"

any_working() {
  tmux list-windows -a -F '#{@agent_status}' 2>/dev/null | grep -qx working
}

spin() {
  # Only one spinner runs. A lock from a process that no longer runs is stale.
  if ! mkdir "$LOCK" 2>/dev/null; then
    pid=$(cat "$LOCK/pid" 2>/dev/null)
    [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null && exit 0
    rm -rf "$LOCK"
    mkdir "$LOCK" 2>/dev/null || exit 0
  fi
  echo $$ >"$LOCK/pid"
  trap 'rm -rf "$LOCK"' EXIT INT TERM

  while any_working; do
    clients=$(tmux list-clients -F '#{client_name}' 2>/dev/null)
    for frame in $FRAMES; do
      # One tmux call per frame: set the frame and redraw the status line of each client.
      set -- set-option -g @agent_frame "$frame"
      for client in $clients; do
        set -- "$@" \; refresh-client -S -t "$client"
      done
      tmux "$@" 2>/dev/null
      sleep 0.12
    done
  done
  tmux set-option -g @agent_frame '✻' 2>/dev/null
}

state=$1
if [ "$state" = spin ]; then
  spin
  exit 0
fi

[ -n "$TMUX_PANE" ] || exit 0

if [ "$state" = tool ]; then
  if grep -Eq '"tool_name": *"(AskUserQuestion|ExitPlanMode)"'; then
    state=waiting
  else
    state=working
  fi
fi

if [ "$state" = clear ]; then
  tmux set-option -w -u -t "$TMUX_PANE" @agent_status 2>/dev/null
else
  tmux set-option -w -t "$TMUX_PANE" @agent_status "$state" 2>/dev/null
fi

if [ "$state" = working ] && [ ! -d "$LOCK" ]; then
  nohup "$0" spin </dev/null >/dev/null 2>&1 &
fi
exit 0
