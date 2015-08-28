.vim/.vimrc
==========

I am trying to have one development environment for all of my computers.  This
would be a lot easier if I were running unix everywhere.  In addition to this,
the home drive on my work computer (**xp**) is not on a local drive.  This means
that I can not make hardlinks from my home drive using windows command line tools.

# To setup up a new unix machine
Clone all of the contents of the `.vim` directory into your home directory:

    git clone https://github.com/aleph2c/vim_tmux.git ~/.vim

Create symbolic links for your rc files:

    ln -s ~/.vim/vimrc ~/.vimrc

# To setup up on a windows box ( home drive on different computer )
Create a jumper .vimrc file which will call the file that is tracked in this
repository.  I call it a jumper .vimrc since it's only purpose is to jump the
vim configuration into the directory we care about.

    cd ~
    edit .vimrc

   set runtimepath+=~/.vim
   call pathogen#infect('~/.vim/bundle')
   call pathogen#helptags()
   source ~/.vim/.vimrc 

Add this repository's files and directories to your machine.

    cd ~
    mkdir .vim
    cd    .vim 
    git clone https://github.com/aleph2c/vim_tmux.git ~/.vim

Make sure you have a tmp directory set up on your machine.  This will ensure
that Fugative will work.  If this is not done, Gdiff will fail and you will
spend hours trying to figure out what is going on.

    cd c:
    mkdir tmp

# To get your tmux environment from your .vim/.tmux.conf

    ln -s ~/.vim/.tmux.conf ~/.tmux.conf
