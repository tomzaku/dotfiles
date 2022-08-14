# Autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

function shopeeTmux
  tmux new-session -d -s $argv[1] > /dev/null

  tmux new-window -t $argv[1]
  tmux rename-window -t $argv[1]:1 'toC'
  tmux send-keys -t $argv[1]:1.0 'cd /Users/tomzaku/Projects/shopee_react_native && clear && v' Enter
  tmux splitw -v -p 10 -t $argv[1]:1.0
  tmux send-keys -t $argv[1]:1.1 'cd /Users/tomzaku/Projects/shopee_react_native && clear' Enter
  tmux select-window -t $argv[1]:1.0

  tmux new-window -t $argv[1]
  tmux rename-window -t $argv[1]:2 'toB'
  tmux send-keys -t $argv[1]:2.0 'cd /Users/tomzaku/Projects/account-business-web && clear && v' Enter
  tmux splitw -v -p 10 -t $argv[1]:2.0
  tmux send-keys -t $argv[1]:2.1 'cd /Users/tomzaku/Projects/account-business-web && clear' Enter

  
  tmux new-window -t $argv[1]
  tmux rename-window -t $argv[1]:3 'user-isfe'
  tmux send-keys -t $argv[1]:3.0 'cd /Users/tomzaku/Projects/user-isfe && clear && v' Enter
  tmux splitw -v -p 10 -t $argv[1]:3.0
  tmux send-keys -t $argv[1]:3.1 'cd /Users/tomzaku/Projects/user-isfe && clear' Enter

  tmux new-window -t $argv[1]
  tmux rename-window -t $argv[1]:4 'user-mfe'
  tmux send-keys -t $argv[1]:4.0 'cd /Users/tomzaku/Projects/user-web-fe && clear && v' Enter
  tmux splitw -v -p 10 -t $argv[1]:4.0
  tmux send-keys -t $argv[1]:4.1 'cd /Users/tomzaku/Projects/user-web-fe && clear' Enter

  tmux rename-window -t $argv[1]:0 'dashboard'
  tmux send-keys -t $argv[1]:0.0 'wtfutil' Enter

  tmux a -t $argv[1]
end

# Alias
alias v="nvim"
alias vi="nvim"
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
  set -e VPN_PASSWORD
end

function vw
  storeVpnEnv
  set -l info "$VPN_USERNAME\n$VPN_PASSWORD\n$1"
  printf $info | /opt/cisco/anyconnect/bin/vpn -s connect $VPN_DOMAIN
  removeVpnEnv
end
 
function vd
  /opt/cisco/anyconnect/bin/vpn disconnect
end

