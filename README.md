# dotfiles
My dotfile for WSL or Ubuntu.

I'm learning about dotfiles at [dotfiles.eieio.xyz](http://dotfiles.eieio.xyz).


## TODO
- Terminal Preferences
- Git (config and SSH)

## Tmux
To finish tmux setup you need to run the following command in a tmux session
```bash
tmux source ~/.config/tmux/tmux.conf
```
## gitconfig
If you fork this project, Update the `gitconfig` file with your own user information.
By this i mean to change the `name` and the `email`. You can find your own non-reply email in the following path on GitHub.
`setting -> Emails` and under your primary email, you'll see this message.

![no-reply image message](/assets/no-reply-email.png)

Additionally, since you are in the `Emails` section of your settings, ensure you have this options marked as well.

![protect email options](/assets/email-options.png)
