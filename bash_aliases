alias vim='nvim'
alias tree='tree -I ".git|node_modules"'
alias g='git'
alias c='clear'
alias cat="bat"
alias echo="echo -e"
alias ll="exa -laFh -g --icons"
alias exa='exa -laFh -g --icons'


#Adding alias for loading a session
alias ld="tmuxifier load-session"
alias tk='tmux kill-server'

function system-updater {
sudo apt-get update &&
  sudo apt-get upgrade -y &&
  sudo apt-get clean -y &&
  sudo apt-get autoclean -y &&
  sudo apt-get autoremove -y --purge

# Check if 'snap' is a valid command and if so, run 'snap refresh'
if command -v snap >/dev/null 2>&1; then
  sudo snap refresh
fi
}

function mkcd {
  mkdir -p "$@" && cd "$_"
}

export MANPAGER="sh -c 'col -bx | bat -l man -p'"