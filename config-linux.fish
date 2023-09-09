if type -q exa
  alias ll "exa -laFh -g --icons"
  alias lla "ll -a"
else
  alias ll "ls -lAFh"
end

if type -q bat
 alias cat "bat"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

if type -q trash
  alias rm "trash"
end
alias echo "echo -e"
