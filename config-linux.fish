if type -q exa
  alias ll "exa -laFh -g --icons"
else
  alias ll "ls -lAFh"
end

if type -q batcat
 alias cat "batcat"
set -x MANPAGER "sh -c 'col -bx | batcat  -l man -p'"
end

alias echo "echo -e"
