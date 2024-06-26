# Useful dotfiles and scripts for daily use

### For vim

<div align="center">
  <img src="https://cdn.rawgit.com/Cu7ious/dotfiles/2b87fafc/assets/images/vim.png" alt="Vim as IDE" style="max-width:100%;">
</div>

A bit of inspiration in [Setting up Vim for React](https://drivy.engineering/setting-up-vim-for-react/)

1. Move .vimrc from this dir to the home dir and create `tmp` & `undo` inside ~/.vim

`mv .vimrc ~/ && mkdir -p ~/.vim/tmp && mkdir -p ~/.vim/undo`

2. Inside `.vim` directory make symbolic link to `~/.vim/plugged/vim-colorschemes/colors/`

`cd ~/.vim && ln -s ~/.vim/plugged/vim-colorschemes/colors/ ./colors`

After this step it should work.

### For bash

<div align="center">
  <img src="https://cdn.rawgit.com/Cu7ious/dotfiles/2b87fafc/assets/images/bash.png" alt="Bash It!" style="max-width:100%;">
</div>

1. install bash-it
   `git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it`
2. Add this lines to the end of the `.bashrc`

```
# Path to the bash it configuration
export BASH_IT="/home/vagrant/.bash_it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='cu7ious'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Load Bash It
source "$BASH_IT"/bash_it.sh
```

3. Copy or make the symlink for `cu7ious/cu7ious.theme.bash` to ~/.bash_it/themes

4. To enable it for the current session, use `source ~/.bashrc`

### For zsh

<div align="center">
  <img src="https://cdn.rawgit.com/Cu7ious/dotfiles/2b87fafc/assets/images/zsh.png" alt="Oh-my-ZSH!" style="max-width:100%;">
</div>

1. install zsh with oh-my-zsh

`sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"`

2. Make it your default shell: `chsh -s $(which zsh)`

Note that this will not work if Zsh is not in your authorized shells list `(/etc/shells)` or if you don't have permission to use `chsh`.

3. Log out and login back again to use your new default shell.
4. Test that it worked with echo $SHELL. Expected result: /bin/zsh or similar.
5. Copy or make the symlink for `cu7ious.zsh-theme` to ~/.oh-my-zsh/themes
6. To enable it for the current session, use `source ~/.zshrc`
