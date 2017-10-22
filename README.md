# To setup up a new nix machine
Clone all of the contents of the `.vim` directory into your home directory:

    git clone git@github.com:aleph2c/vimrc.git ~/.vim

Create symbolic links for your rc files:

    ln -s ~/.vim/.vimrc ~/.vimrc
    ln -s ~/.vim/.tmux.conf ~/.tmux.conf
    ln -s ~/.vim/snippets ~/snippets

The vim config has been tested on the WSL and it works, the TMUX setup hasn't
been modernized.  I haven't touched tmux for year.
