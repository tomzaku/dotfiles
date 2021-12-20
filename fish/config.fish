# Autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish



# Alias
alias v="nvim"
alias vi="nvim"
alias l="lazygit"
alias st="tmux attach -t base || tmux new -s base"

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

