if type -q eza
  alias ll "eza -lFh -g --icons"
  alias lla "eza -lFah -g --icons"
else if type -q exa
  alias ll "exa -lFh -g --icons"
  alias lla "exa -lFah -g --icons"
else
  alias ll "ls -lFh"
  alias lla "ls -laFh"
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
