import { execFile, execFileSync } from "node:child_process"
import { Plugin } from "@opencode/plugin/tui"

// Writes the state of the session shown in this TUI to the tmux window option
// @agent_status (working, waiting, done, error). tmux.conf renders it in the tab.
export default Plugin.define({
  id: "peder.tmux-status",
  setup(context) {
    const pane = process.env.TMUX_PANE
    if (!pane) return

    const running = new Set<string>()
    const outcome = new Map<string, "done" | "error">()
    const pending = new Map<string, string>()
    let written: string | undefined

    const root = (sessionID: string) => context.data.session.root(sessionID) ?? sessionID

    const current = () => {
      const route = context.ui.router.current() as { type: string; sessionID?: string }
      return route.type === "session" ? route.sessionID : undefined
    }

    const status = () => {
      const sessionID = current()
      if (!sessionID) return ""
      for (const owner of pending.values()) if (root(owner) === sessionID) return "waiting"
      if (running.has(sessionID)) return "working"
      return outcome.get(sessionID) ?? ""
    }

    const update = () => {
      const next = status()
      if (next === written) return
      written = next
      const args = next
        ? ["set-option", "-w", "-t", pane, "@agent_status", next]
        : ["set-option", "-w", "-u", "-t", pane, "@agent_status"]
      execFile("tmux", args, () => {})
    }

    const start = (sessionID: string) => {
      running.add(sessionID)
      outcome.delete(sessionID)
      update()
    }
    const finish = (sessionID: string, result?: "done" | "error") => {
      running.delete(sessionID)
      if (result) outcome.set(sessionID, result)
      else outcome.delete(sessionID)
      update()
    }
    const ask = (id: string, sessionID: string) => {
      pending.set(id, sessionID)
      update()
    }
    const answer = (id: string) => {
      pending.delete(id)
      update()
    }

    const clear = () => {
      try {
        execFileSync("tmux", ["set-option", "-w", "-u", "-t", pane, "@agent_status"])
      } catch {}
    }
    process.on("exit", clear)

    const stops = [
      context.data.on("session.execution.started", (e) => start(e.data.sessionID)),
      context.data.on("session.execution.succeeded", (e) => finish(e.data.sessionID, "done")),
      context.data.on("session.execution.failed", (e) => finish(e.data.sessionID, "error")),
      context.data.on("session.execution.interrupted", (e) => finish(e.data.sessionID)),
      context.data.on("permission.asked", (e) => ask(e.data.id, e.data.sessionID)),
      context.data.on("permission.replied", (e) => answer(e.data.requestID)),
      context.data.on("form.created", (e) => ask(e.data.form.id, e.data.form.sessionID)),
      context.data.on("form.replied", (e) => answer(e.data.id)),
      context.data.on("form.cancelled", (e) => answer(e.data.id)),
    ]
    // The router has no change event; poll so switching sessions updates the tab.
    const timer = setInterval(update, 500)

    return () => {
      clearInterval(timer)
      stops.forEach((stop) => stop())
      process.off("exit", clear)
      clear()
    }
  },
})
