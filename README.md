# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

# Lazygit Edit Same NeoVim Session

Snacks opens lazygit and auto-generates its config. By default snacks sets
`editPreset = "nvim-remote"`, whose `edit` command uses `nvim --remote-tab` —
so editing a file (e.g. a merge conflict) opens a **new tab** instead of the
current window.

Override the `os` commands to use `--remote` (current window). Configured in
`lua/plugins/snacks.lua` under `opts.lazygit.config`:

```lua
lazygit = {
  config = {
    os = {
      editPreset = "",
      edit = 'nvim --server "$NVIM" --remote-send "<C-\\><C-n><cmd>close<cr>" && nvim --server "$NVIM" --remote "{{filename}}"',
      editAtLine = 'nvim --server "$NVIM" --remote-send "<C-\\><C-n><cmd>close<cr>" && nvim --server "$NVIM" --remote "{{filename}}" && nvim --server "$NVIM" --remote-send ":{{line}}<CR>"',
      editAtLineAndWait = 'nvim "{{filename}}" +{{line}}',
      openDirInEditor = 'nvim --server "$NVIM" --remote-send "<C-\\><C-n><cmd>close<cr>" && nvim --server "$NVIM" --remote "{{dir}}"',
    },
  },
},
```

`editPreset = ""` clears the default preset so snacks does not re-inject the
`--remote-tab` variant. Restart nvim after changing (snacks regenerates the
lazygit config file on startup).
