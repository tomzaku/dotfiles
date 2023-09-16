
# Autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

function shopeeTmux
  tmux new-session -d -s $argv[1] > /dev/null

  # tmux new-window -t $argv[1]
  tmux rename-window -t $argv[1]:0 'toC'
  tmux send-keys -t $argv[1]:0.0 'cd ~/Projects/shopee_react_native && clear && v' Enter
  tmux splitw -v -p 10 -t $argv[1]:0.0
  tmux send-keys -t $argv[1]:0.1 'cd ~/Projects/shopee_react_native && clear' Enter
  tmux select-window -t $argv[1]:0.0

  # tmux new-window -t $argv[1]
  # tmux rename-window -t $argv[1]:2 'toB'
  # tmux send-keys -t $argv[1]:2.0 'cd ~/Projects/account-business-web && clear && v' Enter
  # tmux splitw -v -p 10 -t $argv[1]:2.0
  # tmux send-keys -t $argv[1]:2.1 'cd ~/Projects/account-business-web && clear' Enter

  
  tmux new-window -t $argv[1]
  tmux rename-window -t $argv[1]:1 'isfe'
  tmux send-keys -t $argv[1]:1.0 'cd ~/Projects/user-isfe && clear && v' Enter
  tmux splitw -v -p 10 -t $argv[1]:1.0
  tmux send-keys -t $argv[1]:1.1 'cd ~/Projects/user-isfe && clear' Enter

  tmux new-window -t $argv[1]
  tmux rename-window -t $argv[1]:2 'user-mfe'
  tmux send-keys -t $argv[1]:2.0 'cd ~/Projects/user-spfe && clear && v' Enter
  tmux splitw -v -p 10 -t $argv[1]:2.0
  tmux send-keys -t $argv[1]:2.1 'cd ~/Projects/user-spfe && clear' Enter

  tmux new-window -t $argv[1]
  tmux rename-window -t $argv[1]:3 'ccms'
  tmux send-keys -t $argv[1]:3.0 'cd ~/Projects/shopee-ccms-dev && clear' Enter
  tmux splitw -h -p 50 -t $argv[1]:3.0
  tmux send-keys -t $argv[1]:3.1 'cd ~/Projects/shopee-ccms && clear' Enter

  # tmux rename-window -t $argv[1]:0 'dashboard'
  # tmux send-keys -t $argv[1]:0.0 'wtfutil' Enter

  tmux a -t $argv[1]
end

# Alias
# if test -n "$NVIM_LISTEN_ADDRESS"
#     function nvim
#         nvr -cc split --remote-wait +'set bufhidden=wipe' $argv
#     end
# end
# if test -n "$NVIM_LISTEN_ADDRESS"
#     set -x VISUAL "nvr -cc split --remote-wait +'set bufhidden=wipe'"
#     set -x EDITOR "nvr -cc split --remote-wait +'set bufhidden=wipe'"
# else
#     set -x VISUAL "nvim"
#     set -x EDITOR "nvim"
# end
# alias v="nvim"
# alias vi="nvim"

alias v='nvim --listen /tmp/nvim-server.pipe'
alias vi='nvim --listen /tmp/nvim-server.pipe'
alias l="lazygit"
alias st="tmux attach -t base || tmux new -s base"
alias sts="tmux attach -t shopee || shopeeTmux shopee"

# Fish
# Change ls colors
set -Ux LSCOLORS gxfxbEaEBxxEhEhBaDaCaD
set EDITOR "/usr/local/bin/fish"

set fish_greeting


# Fix duplicated text command line
set LANG "en_US.UTF-8"
set LC_ALL "en_US.UTF-8"
set EDITOR "nvim"


# store password for environment variable
function storeVpnEnv
  security 2>&1 >/dev/null find-generic-password -ga VPN_USERNAME | ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/' | read -g VPN_USERNAME 
  security 2>&1 >/dev/null find-generic-password -ga VPN_DOMAIN | ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/' | read -g VPN_DOMAIN 
  # get password in keychain and pass to  ST_PASSWORD
  security 2>&1 >/dev/null find-generic-password -ga VPN_PASSWORD | ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/' | read -g VPN_PASSWORD 
end

function removeVpnEnv
  set -e VPN_USERNAME
  set -e VPN_PASSWORD
  set -e VPN_DOMAIN
end

function vw
  storeVpnEnv
  set -l info "$VPN_USERNAME\n$VPN_PASSWORD\n$1"
  printf $info | /opt/cisco/secureclient/bin/vpn -s connect $VPN_DOMAIN
  removeVpnEnv
end
 
function vd
  /opt/cisco/secureclient/bin/vpn disconnect
end


set -x GOPATH ~/Projects/golang/


# Node manager

# Option 1
# status is-interactive && fnm env --use-on-cd | source

# Option 2
status is-interactive && fnm env --use-on-cd | source
alias nv="cat package.json | grep '\"node\":' | grep -o '[0-9.]*' 2>&1"
function _fnm_autoload_package_hook --on-variable PWD --description 'Change Node version on directory change'
  status --is-command-substitution; and return
  if test -f package.json
    # nv # Run to check if the version is exist
    if test $(nv)
      fnm use $(nv) --silent-if-unchanged
    end
  end
end

_fnm_autoload_package_hook




# Created by `pipx` on 2023-02-13 07:33:49
set PATH $PATH /Users/tom.levt/.local/bin

# pnpm
set -gx PNPM_HOME "/Users/tom.levt/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end


# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH


# rust
set --export PATH $HOME/.cargo/bin $PATH
