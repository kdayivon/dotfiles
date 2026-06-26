source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
    neofetch 
end
starship init fish | source
zoxide init fish | source
