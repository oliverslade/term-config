# Neovim Configuration

A clean and minimal Neovim configuration based on modern Lua practices.

## Structure

```
├── tmux.conf              # Tmux configuration
├── nvim/
│   ├── init.lua           # Main configuration entry point
│   └── lua/
│       ├── options.lua    # Neovim options and settings
│       ├── keymaps.lua    # Key mappings
│       ├── lazy-init.lua  # Lazy.nvim plugin manager setup
│       └── plugins/
│           ├── init.lua        # Basic plugins
│           ├── colorscheme.lua # Color scheme configuration
│           ├── lsp.lua         # LSP and completion setup
│           ├── telescope.lua   # Fuzzy finder
│           ├── treesitter.lua  # Syntax highlighting
│           └── utilities.lua   # Git, undo tree, zen mode, etc.
```

## Installation

### Neovim Configuration

1. Backup your existing Neovim configuration (if it exists):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. Create the Neovim config directory and copy the nvim folder contents:
   ```bash
   mkdir -p ~/.config/nvim
   cp -r nvim/* ~/.config/nvim/
   ```

3. Start Neovim and let Lazy.nvim install the plugins:
   ```bash
   nvim
   ```
   
   **Note**: The `lazy-lock.json` file pins specific plugin versions for stability. If you want the latest plugin versions instead, you can delete this file before starting Neovim.

### Tmux Configuration

1. Backup your existing tmux configuration (if it exists):
   ```bash
   mv ~/.tmux.conf ~/.tmux.conf.backup
   ```

2. Copy the tmux configuration to your home directory:
   ```bash
   cp tmux.conf ~/.tmux.conf
   ```

3. Reload tmux configuration (if tmux is already running):
   ```bash
   tmux source-file ~/.tmux.conf
   ```

2. Follow the individual installation steps above to copy files to their respective locations.

## Key Mappings

### General
- `<Space>` - Leader key
- `<leader>pv` - Open file explorer
- `<leader>ff` - Find files (Telescope)
- `<C-p>` - Git files (Telescope)

### LSP
- `gd` - Go to definition
- `K` - Hover documentation
- `<leader>vca` - Code actions
- `<leader>vrr` - Find references
- `<leader>vrn` - Rename symbol

### Git
- `<leader>gs` - Git status
- `<leader>p` - Git push (in fugitive buffer)
- `<leader>P` - Git pull --rebase (in fugitive buffer)

### Utilities
- `<leader>u` - Toggle undo tree
- `<leader>zz` - Toggle zen mode
- `<leader>tt` - Toggle trouble (diagnostics)
