set home_directory '~/Projects/dotfiles'

# Autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

function shopee-tmux
    tmux new-session -d -s $argv[1] >/dev/null

    # tmux new-window -t $argv[1]
    tmux rename-window -t $argv[1]:0 toC
    tmux send-keys -t $argv[1]:0.0 'cd ~/Projects/shopee_react_native && clear && v' Enter
    tmux splitw -v -p 10 -t $argv[1]:0.0
    tmux send-keys -t $argv[1]:0.1 'cd ~/Projects/shopee_react_native && clear' Enter
    tmux select-window -t $argv[1]:0.0

    tmux new-window -t $argv[1]
    tmux rename-window -t $argv[1]:1 isfe
    tmux send-keys -t $argv[1]:1.0 'cd ~/Projects/user-isfe && clear && v' Enter
    tmux splitw -v -p 10 -t $argv[1]:1.0
    tmux send-keys -t $argv[1]:1.1 'cd ~/Projects/user-isfe && clear' Enter

    tmux new-window -t $argv[1]
    tmux rename-window -t $argv[1]:2 user-mfe
    tmux send-keys -t $argv[1]:2.0 'cd ~/Projects/user-spfe && clear && v' Enter
    tmux splitw -v -p 10 -t $argv[1]:2.0
    tmux send-keys -t $argv[1]:2.1 'cd ~/Projects/user-spfe && clear' Enter

    tmux new-window -t $argv[1]
    tmux rename-window -t $argv[1]:3 ccms
    tmux send-keys -t $argv[1]:3.0 'cd ~/Projects/shopee-ccms-dev && clear' Enter
    tmux splitw -h -p 50 -t $argv[1]:3.0
    tmux send-keys -t $argv[1]:3.1 'cd ~/Projects/shopee-ccms && clear' Enter

    # tmux rename-window -t $argv[1]:0 'dashboard'
    # tmux send-keys -t $argv[1]:0.0 'wtfutil' Enter

    tmux a -t $argv[1]
end

function shopee-kitty-session
    # nohub short for no hang up is a command in Linux systems that keep processes running even after exiting the shell or terminal. 
    nohup kitty --session ~/Projects/dotfiles/kitty/shopee-session.conf & disown
end

# Allow edit file for lazygit
alias vim='nvim --listen /tmp/nvimsocket'
alias v='nvim --listen /tmp/nvimsocket'
alias vi='nvim --listen /tmp/nvimsocket'
alias l="lazygit"
alias st="tmux attach -t base || tmux new -s base"
alias sts="tmux attach -t shopee || shopee-tmux shopee"
alias sks="shopee-kitty-session"

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
function find-up-node-version
    # Set the initial directory to the current directory
    set current_directory (pwd)

    # Loop through parent directories until the root directory is reached
    while test -n "$current_directory"
        set found_path "$current_directory/$argv[1]"
        # Check if the specified file exists in the current directory
        if test -e "$found_path"
            set node_version (cat $found_path | grep '\"node\":' | grep -o '[0-9.]*' | head -n 1 2>&1)
            if test $node_version
                echo "$node_version"
                return 0
            end
        end
        
        set new_current_directory (dirname $current_directory)

        if test "$current_directory" = "$new_current_directory"
            return 1
        end
        # Move up to the parent directory
        set current_directory $new_current_directory
    end

    # If the loop completes without finding the file, return failure
    return 1
end
status is-interactive && fnm env --use-on-cd | source
function _fnm_autoload_package_hook --on-variable PWD --description 'Change Node version on directory change'
    status --is-command-substitution; and return
    set node_version (find-up-node-version "package.json")
    if test $node_version
        fnm use $node_version --silent-if-unchanged
    end
end
_fnm_autoload_package_hook




# Created by `pipx` on 2023-02-13 07:33:49
fish_add_path /Users/tom.levt/.local/bin

# pnpm
set -gx PNPM_HOME "/Users/tom.levt/Library/pnpm"
fish_add_path /Users/tom.levt/Library/pnpm
# pnpm end

# nvim
fish_add_path /Users/tom.levt/Projects/nvim-macos/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH


# rust
set --export PATH $HOME/.cargo/bin $PATH

