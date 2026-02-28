if type -q eza
  alias ll "eza -la --icons=always --classify=always"
  alias lla "eza -la --icons=always --classify=always"
else if type -q exa
  alias ll "exa -la --icons=always --classify=always"
  alias lla "exa -la --icons=always --classify=always"
else
  alias ll "ls -la"
  alias lla "ls -la"
end

if type -q bat
 alias cat "bat"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

if type trash > /dev/null 2>&1
    alias rm="trash"
end

alias echo "echo -e"

alias tree 'tree -I ".git|node_modules"'

alias g "git"
alias ld "tmuxifier load-session"
alias tk "tmux kill-server"
alias notes "cd $HOME/Documents/notes"
