#!/usr/bin/env bash
# This script sets up a convenient environment
# Set of useful CLI programs and configs

if [[ $OSTYPE =~ "darwin" ]] ; then
# If the os is macOS
    echo "Setting up the environment for macOS..."
    # XCode magic
        xcode-select --install

    # Bash magic
        # installs bash-it framework
        git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it

        # check if .bash_profile is there
        if [ -f ~/.bash_profile ]; then
            if ! grep -Fq "source ~/.bashrc" ~/.bash_profile; then
                cat >> ~/.bash_profile <<- EOM
if [ -r ~/.bashrc ]; then
    # shellcheck source=/dev/null
    source ~/.bashrc
fi
EOM
            fi
        else
            cat > ~/.bash_profile <<- EOM
if [ -r ~/.bashrc ]; then
    # shellcheck source=/dev/null
    source ~/.bashrc
fi
EOM
        fi

        # Symlink .bashrc and .bash_aliases
        ln -s "$(pwd)/.bashrc" ~/
        ln -s "$(pwd)/.bash_aliases" ~/

        # link theme
        ln -s "$(pwd)/themes/bash_it/cu7ious/" ~/.bash_it/themes

        # Test and apply it
        #shellcheck source=/dev/null
        source ~/.bash_profile

    # Homebrew magic
        # install homebrew
        /usr/bin/ruby -e "$(curl -fsSL \
            https://raw.githubusercontent.com/Homebrew/install/master/install)"

        # install required formulas
        while read -r formula; do
            brew install "$formula"
        done < brew/formulas.txt

    # Vim magic
        # create symlink to the .vimrc in user home folder
        ln -s "$(pwd)/.vimrc" ~/

        # install Vim plugin manager
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

        # create folders for .swp files
        mkdir -p ~/.vim/tmp
        mkdir -p ~/.vim/undo

        # install vim plugins via vim-plug
        vim +PlugInstall +qall

        # links colorschemes from bundle to vim root folder
        ln -s ~/.vim/bundle/vim-colorschemes/colors ~/.vim/

    # bin magic
        osToExclude="_Ubuntu."
        toTrim="_macOS"
        mkdir ~/bin

        for script in ./bin/*; do
            if [[ $script != *"$osToExclude"* ]]; then
                script=${script#"./bin/"}
                ln -s "$PWD/bin/$script" "$HOME/bin/${script//$toTrim/}"
            fi
        done

    # mc magic
    ln -s "$(pwd)/themes/mc/skins" ~/.local/share/mc

    # TypeScript magic
    npm i -g typescript

    # VSCode magic
    curl -Lo VSCode-darwin-stable.zip \
        https://go.microsoft.com/fwlink/?LinkID=620882
    VSCode-darwin-stable.zip
    unzip VSCode-darwin-stable.zip -d /Applications
    rm -rf VSCode-darwin-stable.zip

    #Alacritty magic
    # @TODO: download & install latest release
    ln -s "$(pwd)/alacritty.yml" ~/

elif [[ $OSTYPE =~ "linux-gnu" ]] ; then
# If the os is Ubuntu
    echo "Ubuntu is in beta"

    # Rust magic
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    # Apt magic
        # install required formulas
        while read -r dependency; do
            sudo apt install "$dependency" -y
        done < apt/dependencies.txt
	# cleaning just in case
	sudo apt autoremove -y

    # VS Code magic
    sudo snap install code --classic

    # @TODO double-check it
    # Bash magic
        # installs bash-it framework
        git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it

        # check if .bash_profile is there
        if [ -f ~/.bash_profile ]; then
            if ! grep -Fq "source ~/.bashrc" ~/.bash_profile; then
                cat >> ~/.bash_profile <<- EOM
if [ -r ~/.bashrc ]; then
    # shellcheck source=/dev/null
    source ~/.bashrc
fi
EOM
            fi
        else
            cat > ~/.bash_profile <<- EOM
if [ -r ~/.bashrc ]; then
    # shellcheck source=/dev/null
    source ~/.bashrc
fi
EOM
        fi

        # Symlink .bashrc and .bash_aliases
        ln -s "$(pwd)/.bashrc" ~/
        ln -s "$(pwd)/.bash_aliases" ~/

        # link theme
        ln -s "$(pwd)/themes/bash_it/cu7ious/" ~/.bash_it/themes

        # Test and apply it
        #shellcheck source=/dev/null
        source ~/.bash_profile
else
    echo "Your operating system, $OSTYPE, is not supported"
    exit 0
fi
