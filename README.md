## Requirements

- Rd: search files by regrex.
- fzf: search files (brew install fzf)
- Ubersicht.
- Kitty: fd (brew install fd).

- Font: Symbol Nerd Font, MesloLGS NF, Hack, Victor Mono, Symbols Nerd Font (Icon)

Font download:
```
https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/VictorMono
https://rubjo.github.io/victor-mono/
3270: https://www.nerdfonts.com/font-downloads
```


## Installation

```
defaults write -g ApplePressAndHoldEnabled -bool false

```

1. Install brew
```
xcode-select --install
sudo xcode-select -switch /Library/Developer/CommandLineTools
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Install some useful packages
```
brew install gnu-sed
brew install ripgrep
brew install fzf

# NVIM Plugin
brew install gnu-sed
brew install fortune
pip3 install neovim-remote # Install nvr (or pip3 install neovim-remote --break-system-packages)


# fnm: node management
curl -fsSL https://fnm.vercel.app/install | bash

# Yabai
brew install koekeishiya/formulae/yabai
brew services start yabai

# Skhd
brew install koekeishiya/formulae/skhd
brew services start skhd

brew install tmux
brew install fish 
brew install autojump
brew install jesseduffield/lazygit/lazygit
brew install --HEAD neovim



brew tap FelixKratz/formulae
brew install borders

```

3. Install shell

```bash
sudo vim /etc/shells
# Add this line '/usr/local/bin/fish'
chsh -s /usr/local/bin/fish
```

```bash
# install tmux package management
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s ~/Projects/dotfiles/.tmux.conf ~/.tmux.conf
# <ctrl> b - I


# install fisher package
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher update
```

4. Link this project to our local config
For example

```
ln -s /Applications/kitty.app/Contents/MacOS/kitty /usr/local/bin/kitty
ln -s ~/Projects/dotfiles/nvim ~/.config/nvim
ln -s ~/Projects/dotfiles/yabai ~/.config/yabai
ln -s ~/Projects/dotfiles/skhd ~/.config/skhd
ln -s ~/Projects/dotfiles/limelight ~/.config/limelight
ln -s ~/Projects/dotfiles/kitty ~/.config/kitty
rm ~/Library/Application\ Support/lazygit/config.yml && ln -s ~/Projects/dotfiles/lazygit/config.yml ~/Library/Application\ Support/lazygit/config.yml
ln -s ~/Projects/dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -s ~/Projects/dotfiles/fish/fish_plugins ~/.config/fish/fish_plugins
```

5. Support image in nvim

Following this [link](https://github.com/3rd/image.nvim/issues/114)

```
brew install imagemagick
luarocks --local install magick
```

6. Install X11

https://kb.thayer.dartmouth.edu/article/336-x11-for-windows-and-mac


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
    
    `<leader>s`: Search menu

  - Quicklist

    `<ctrl>q`: add to Quicklist

    `<leader>l`: move to next quicklist

    `<leader>j`: move to previous quicklist

  - Files

    `<leader>ff`: open file explorer

    `<leader>fw`: search words projects

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

---

if you have an issue about max files in vim: 

sudo launchctl load -w /Library/LaunchDaemons/limit.maxfiles.plist

