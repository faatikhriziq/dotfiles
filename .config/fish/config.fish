# Alias untuk bare repo dotfiles
alias config 'git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
starship init fish | source
fish_add_path -g /home/faatikhriziq/.config/herd-lite/bin
fish_add_path -g -p /home/faatikhriziq/develop/flutter/bin
# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
    rxfetch
end
