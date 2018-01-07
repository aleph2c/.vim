# To setup up a new nix machine
Clone all of the contents of the `.vim` directory into your home directory:

    git clone git@github.com:aleph2c/vimrc.git ~/.vim

Create symbolic links for your rc files:

    ln -s ~/.vim/.vimrc ~/.vimrc
    ln -s ~/.vim/.tmux.conf ~/.tmux.conf
    ln -s ~/.vim/snippets ~/snippets

The vim config has been tested on the WSL and it works, the TMUX setup hasn't
been modernized.  I haven't touched tmux for year.


# To setup on window (outside of WLS)
Install Plug.vim into your autoload directory for your VIM installation.

Find root directory of your VIM installation, open VIM and type $VIM.  Take note
of the output, this is your `<Install Root>`.

Open `<Install Root>` in windows explorer.  Edit `_vimrc` with notepad, by
adding the following at the end of the file:

    source $VIM/.vim/.vim

Restart VIM.  Then type:

:PluginInstall 

After this VIM is mostly ready to get.

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
