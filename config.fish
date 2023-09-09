set fish_greeting ""
# function fish_greeting
# figlet "Theweak1"
# end

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

#aliases
alias g git
alias c clear
command -qv nvim && alias vim nvim

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

function user
  command pass show $argv | grep "user" | cut -d " " -f2 | wl-copy
end

function email
  command pass show $argv | grep "email" | cut -d " " -f2 | wl-copy
end

function mkcd
    mkdir -p $argv; and cd $argv[-1]
end

# Cargo
set -gx PATH $HOME/.cargo/bin $PATH

switch (uname)
  case Linux
    source (dirname (status --current-filename))/config-linux.fish
  case '*'
    source (dirname (status --current-filename))/config-windows.fish
end

function system-updater
  sudo apt-get update -y &&
  sudo apt-get upgrade -y &&
  sudo apt-get clean -y &&
  sudo apt-get autoclean -y &&
  sudo apt-get autoremove -y --purge
  sudo snap refresh
end

#n (node version manager)
set -x N_PREFIX "$HOME/.n"; contains "$N_PREFIX/bin" $PATH; or set -a PATH "$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
