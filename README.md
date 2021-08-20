## Requirements

- Rd: search files by regrex.
- fzf: search files.
- npx.
- Ubersicht.
- Font: MesloLGS NF, Hack.
- Kitty: fd (brew install fd).
- Install prettier as global for autoformat.

## Installation

```bash
# install tmux package management
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s ~/Projects/dotfiles/.tmux.conf ~/.tmux.conf
# <ctrl> b - I


# install fisher package
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher update
```

- ln -s ${DOTS_FILES_PATH} ~/.config

For example

```
ln -s /Applications/kitty.app/Contents/MacOS/kitty /usr/local/bin/kitty
ln -s ~/Projects/dotfiles/nvim ~/.config/nvim
ln -s ~/Projects/dotfiles/yabai ~/.config/yabai
ln -s ~/Projects/dotfiles/skhd ~/.config/skhd
ln -s ~/Projects/dotfiles/limelight ~/.config/limelight
ln -s ~/Projects/dotfiles/kitty ~/.config/kitty
ln -s ~/Projects/dotfiles/Ubersicht/widgets ~/Library/Application\ Support/Übersicht/widgets

```

## Feature

**1. Customize desktop**

- quote
- calendar
- space management

![https://raw.githubusercontent.com/tomzaku/dotfiles/master/showcase/desktop.png](https://raw.githubusercontent.com/tomzaku/dotfiles/master/showcase/desktop.png)

**2. Editor**

- Nvim - Focus on Front-end environment
- Shortcut keys

  leader = `<space>`

  - Windows/Panes

    `<ctrl> h/j/k/l`: Navigate to left/right/top/bottom

    `ss`: Split Horizontally

    `sv`: Split Vertically

    `st`: Toggle vertially view to Horizontally

    `<leader>g`: open lazygit

    `<F1>`: Toggle floatterm hidden/show

    `<F5>`: Open current directory terminal

  - Navigate lsp

    `gd`: Go to definition file

    `<shift>K`: definition popup

  - Search

    `<leader>s`: search & replace current word

    `<leader>S`: search at this current directory

  - Quicklist

    `<ctrl>q`: add to Quicklist

    `<leader>l`: move to next quicklist

    `<leader>j`: move to previous quicklist

  - Files

    `<leader>ff`: open file explorer

    `<leader>fa`: search words projects

![https://raw.githubusercontent.com/tomzaku/dotfiles/master/showcase/editor.png](https://raw.githubusercontent.com/tomzaku/dotfiles/master/showcase/editor.png)

**3. Window Managerment**

- Yabai & skhd & limelight

- Shortcut keys: Check skhd/skhdrc

- Tmux

  leader = `<ctrl> + b`

  Create another tab: `<leader> c`

  Switch next/previous tab: `<leader> n` or `<leader> p`

![https://raw.githubusercontent.com/tomzaku/dotfiles/master/showcase/window.png](https://raw.githubusercontent.com/tomzaku/dotfiles/master/showcase/window.png)

**4. Shell**

- Fish

  - Using **tide** theme: async rendering

Special thank to the open source community: kkga(nibar), Raphael(nvim)
