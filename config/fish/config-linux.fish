if type -q exa
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

export (cat $HOME/.dotfiles/.env |xargs -L 1)

alias create-readme "gpt4readability . -f readme -m gpt-4"

alias ld "tmuxifier load-session"
alias tk "tmux kill-server"
