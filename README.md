# To setup up a new debian machine
Clone all of the contents of the `.vim` directory into your home directory:

    > git clone git@github.com:aleph2c/vim_tmux.git ~/.vim

Create symbolic links for your rc files:

    > ln -s ~/.vim/.vimrc ~/.vimrc
    > ln -s ~/.vim/.tmux.conf ~/.tmux.conf
    > ln -s ~/.vim/snippets ~/snippets

To get [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) to work:

    > sudo apt-get install build-essential cmake
    > sudo apt-get install python-dev python3-dev
    > cd ~/.vim/bundle/YouCompleteMe
    > ./install.py

If you are on a raspberry pi or beagle bone, replace the last line with:

    > YCM_CORES=1 ./install.py

# To setup on window (outside of WLS)
Find root directory of your VIM installation, open VIM and type `:echo $VIM`.  Take note
of the output, this is your `<Install Root>`.

Now, navigate to `<Install Root>` and type:

    > git clone git@github.com:aleph2c/vim_tmux.git .vim

Open `<Install Root>` in windows explorer.  Edit `_vimrc` with notepad, by
adding the following at the end of the file:

    source $VIM/.vim/.vimrc

Restart VIM.  Then type:

    :PluginInstall 

After this VIM is mostly ready.

Now if you would like (to waste about 3 hours of your life to get)
[YouCompleteMe](https://github.com/Valloric/YouCompleteMe) to work, download:

 * Virtual Studio Community Addition (5Gigs download, C++)
 * Virtual Studio Build Tools        (2Gigs download, Only works after first download)
 * Cmake

Adjust your path (rapid path editor) so that the following can by found:

 * Cmake is found
 * MsBuild.exe can be found

Restart your shell so your path is updated, then:

    > cd <Install Root>\plugged\YouCompleteMe
    > python install.py --msvc 15

Restart Vim.
