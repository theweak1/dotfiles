# dotfiles_wsl
dotfiles for WSL

I'm learning about dotfiles at [dotfiles.eieio.xyz](http://dotfiles.eieio.xyz).


## TODO
- Terminal Preferences
- Git (config and SSH)

## Tmux
To finish tmux setup you need to run the following command in a tmux session
```bash
tmux source ~/.config/tmux/tmux.conf
```

## n
When installing `n` very the enviromental variable that is created in the `config.fish` has the change of directory.
### Original
```set -x N_PREFIX "$HOME/n"; contains "$N_PREFIX/bin" $PATH; or set -a PATH "$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).```
### modified
```set -x N_PREFIX "$HOME/.n"; contains "$N_PREFIX/bin" $PATH; or set -a PATH "$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).```
