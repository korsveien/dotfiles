-- Claude Code IDE integration: diffs, selection and diagnostics over the /ide protocol.
-- Run `claude` in a split with <leader>ac, or run `claude` in another tmux pane and pick nvim with /ide.
require("claudecode").setup({
    terminal = {
        provider = "native",
        split_side = "right",
        split_width_percentage = 0.4,
    },
    diff_opts = {
        layout = "vertical",
        open_in_new_tab = false,
    },
})

local map = vim.keymap.set
map("n", "<leader>ac", "<Cmd>ClaudeCode<CR>", { desc = "Toggle Claude" })
map("n", "<leader>af", "<Cmd>ClaudeCodeFocus<CR>", { desc = "Focus Claude" })
map("n", "<leader>ar", "<Cmd>ClaudeCode --resume<CR>", { desc = "Resume Claude" })
map("n", "<leader>ab", "<Cmd>ClaudeCodeAdd %<CR>", { desc = "Add buffer to Claude" })
map("v", "<leader>as", "<Cmd>ClaudeCodeSend<CR>", { desc = "Send selection to Claude" })
map("n", "<leader>aa", "<Cmd>ClaudeCodeDiffAccept<CR>", { desc = "Accept Claude diff" })
map("n", "<leader>ad", "<Cmd>ClaudeCodeDiffDeny<CR>", { desc = "Deny Claude diff" })
