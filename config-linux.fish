if type -q exa
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
else
  alias ll "ls -lAFh"
end
