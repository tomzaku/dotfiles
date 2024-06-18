# brew
eval "$(/opt/homebrew/bin/brew shellenv)"

set home_directory '~/Projects/dotfiles'


function ta-kitty-session
    # nohub short for no hang up is a command in Linux systems that keep processes running even after exiting the shell or terminal. 
    nohup kitty --session ~/Projects/dotfiles/kitty/ta-session.conf & disown && sleep 1
end

function ka-kitty-session
    # nohub short for no hang up is a command in Linux systems that keep processes running even after exiting the shell or terminal. 
    nohup kitty --session ~/Projects/dotfiles/kitty/kaka-session.conf & disown && sleep 1 && exit
end

function shopee-kitty-session
    # nohub short for no hang up is a command in Linux systems that keep processes running even after exiting the shell or terminal. 
    nohup kitty --session ~/Projects/dotfiles/kitty/shopee-session.conf & disown && exit
end

# Allow edit file for lazygit
alias vim='nvim --listen /tmp/nvimsocket'
alias v='nvim --listen /tmp/nvimsocket'
alias vi='nvim --listen /tmp/nvimsocket'
alias l="lazygit"
alias st="tmux attach -t base || tmux new -s base"
alias sks="shopee-kitty-session"
# Input is the index.
# For example resetTab 0 will reset the tab 0
# Without input it will set by default the tab 0
alias rt='kitty @ send-text -t index:0 "\\x03!!\\n"'


# Fish
# Change ls colors
set -Ux LSCOLORS gxfxbEaEBxxEhEhBaDaCaD
set EDITOR /usr/local/bin/fish

set fish_greeting


# Fix duplicated text command line
set LANG "en_US.UTF-8"
set LC_ALL "en_US.UTF-8"
set EDITOR nvim
set GIT_EDITOR nvim
set VISUAL nvim
set VIMRUNTIME nvim


# store password for environment variable
# function storeVpnEnv
#     security 2>&1 >/dev/null find-generic-password -ga VPN_USERNAME | ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/' | read -g VPN_USERNAME
#     security 2>&1 >/dev/null find-generic-password -ga VPN_DOMAIN | ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/' | read -g VPN_DOMAIN
#     # get password in keychain and pass to  ST_PASSWORD
#     security 2>&1 >/dev/null find-generic-password -ga VPN_PASSWORD | ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/' | read -g VPN_PASSWORD
# end
#
# function removeVpnEnv
#     set -e VPN_USERNAME
#     set -e VPN_PASSWORD
#     set -e VPN_DOMAIN
# end
#
# function vw
#     storeVpnEnv
#     set -l info "$VPN_USERNAME\n$VPN_PASSWORD\n$1"
#     printf $info | /opt/cisco/secureclient/bin/vpn -s connect $VPN_DOMAIN
#     removeVpnEnv
# end
#
# function vd
#     /opt/cisco/secureclient/bin/vpn disconnect
# end


set -x GOPATH ~/Projects/golang/


# Created by `pipx` on 2023-02-13 07:33:49
fish_add_path /Users/tom.levt/.local/bin

# pnpm
set -gx PNPM_HOME "/Users/tom.levt/Library/pnpm"
fish_add_path /Users/tom.levt/Library/pnpm
# pnpm end

# create image
fish_add_path /opt/homebrew/opt/jpeg/bin

# nvim
fish_add_path /Users/tom.levt/Projects/nvim-macos/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH


# rust
set --export PATH $HOME/.cargo/bin $PATH


# autojump
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t -- $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -f backward-delete-char history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
end





# Node manager
# ~/.config/fish/functions/nvm.fish
function nvm
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

# ~/.config/fish/functions/nvm_find_nvmrc.fish
function nvm_find_nvmrc
  bass source ~/.nvm/nvm.sh --no-use ';' nvm_find_nvmrc
end

# ~/.config/fish/functions/load_nvm.fish
function load_nvm --on-variable="PWD"
  set -l default_node_version (nvm version default)
  set -l node_version (nvm version)
  set -l nvmrc_path (nvm_find_nvmrc)
  if test -n "$nvmrc_path"
    set -l nvmrc_node_version (nvm version (cat $nvmrc_path))
    if test "$nvmrc_node_version" = "N/A"
      nvm install (cat $nvmrc_path)
    else if test "$nvmrc_node_version" != "$node_version"
      nvm use $nvmrc_node_version
    end
  else if test "$node_version" != "$default_node_version"
    echo "Reverting to default Node version"
    nvm use default
  end
end

# ~/.config/fish/config.fish
# You must call it on initialization or listening to directory switching won't work
load_nvm > /dev/stderr

# TA
source ~/.config/ta/ta-env.bash
fish_add_path /usr/local/mysql/bin
