# Alias untuk bare repo dotfiles
alias config 'git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
starship init fish | source
source /usr/share/cachyos-fish-config/cachyos-config.fish
fish_add_path -g /home/faatikhriziq/.config/herd-lite/bin
fish_add_path -g -p /home/faatikhriziq/develop/flutter/bin
export DOCKER_HOST=unix:///run/user/1000/podman/podman.sock
alias docker='podman'
# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
    rxfetch
end
