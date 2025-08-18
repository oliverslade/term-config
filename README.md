# My Terminal Configuration

A clean and minimal terminal configuration based on my practices.

## Structure

```
├── tmux.conf              # Tmux configuration
├── hammerspoon/
│   └── init.lua           # Hammerspoon configuration for app launching
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

### Prerequisites

Before setting up the configurations, ensure you have the required applications installed:

```bash
# Install Neovim
brew install neovim

# Install Tmux
brew install tmux

# Install Hammerspoon
brew install --cask hammerspoon
```

Alternatively, you can download Hammerspoon directly from [hammerspoon.org](http://www.hammerspoon.org/).

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

### Hammerspoon Configuration

1. Backup your existing Hammerspoon configuration (if it exists):
   ```bash
   mv ~/.hammerspoon ~/.hammerspoon.backup
   ```

2. Create the Hammerspoon config directory and copy the hammerspoon folder contents:
   ```bash
   mkdir -p ~/.hammerspoon
   cp -r hammerspoon/* ~/.hammerspoon/
   ```

3. Launch Hammerspoon and ensure it has the necessary accessibility permissions:
   - Open Hammerspoon from Applications
   - Grant accessibility permissions when prompted (System Preferences → Security & Privacy → Accessibility)
   - The configuration will automatically reload when you save changes

   **Note**: The configuration provides Alt+1-5 hotkeys for launching applications. The defaults are set to Firefox, Slack, VS Code, Terminal, Microsoft Teams.

## Neovim Key Mappings

### General
- `<Space>` - Leader key
- `<leader>pv` - Toggle file explorer (nvim-tree)
- `<leader>e` - Toggle file explorer (alternative)
- `<leader>ef` - Find current file in explorer
- `<leader>ec` - Collapse file explorer
- `<leader>ff` - Find files (Telescope)
- `<C-p>` - Git files (Telescope)

### LSP
- `gd` - Go to definition
- `gD` - Go to declaration  
- `gi` - Go to implementation
- `go` - Go to type definition
- `gr` - Go to references
- `gs` - Signature help
- `K` - Hover documentation
- `<F2>` - Rename symbol
- `<F4>` - Code actions
- `<leader>ld` - Find definitions (Telescope)
- `<leader>lr` - Find references (Telescope)
- `<leader>li` - Find implementations (Telescope)
- `<leader>ls` - Document symbols (Telescope)
- `<leader>lw` - Workspace symbols (Telescope)
- `<leader>lf` - Find current word in workspace (Telescope)

### Git
- `<leader>gs` - Git status
- `<leader>p` - Git push (in fugitive buffer)
- `<leader>P` - Git pull --rebase (in fugitive buffer)

### Utilities
- `<leader>u` - Toggle undo tree
- `<leader>zz` - Toggle zen mode
- `<leader>tt` - Toggle trouble (diagnostics)
