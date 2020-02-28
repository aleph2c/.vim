# To build Vim
Follow the instructions in [Valloric's YouCompleteMe wiki](https://github.com/ycm-core/YouCompleteMe/wiki/Building-Vim-from-source)

# To setup up a new debian machine
Install tmux:
```bash
sudo apt-get -y install tmux
```
Clone all of the contents of the `.vim` directory into your home directory:
```bash
git clone git@github.com:aleph2c/vim_tmux.git ~/.vim
```
Create symbolic links for your rc files:
```bash
ln -s ~/.vim/.vimrc ~/.vimrc
ln -s ~/.vim/.tmux.conf ~/.tmux.conf
ln -s ~/.vim/snippets ~/snippets
ln -s ~/.vim/.pdbrc ~/.pdbrc
ln -s ~/.vim/.pdbrc.py ~/.pdbrc.py
```
Install pdbpp:
```bash
pip3 install pdbpp
```

Open Vim, ignore the errors and type:
```
:PlugInstall
:PlugUpgrade
```
To get [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) to work:
```bash
sudo apt-get -y install build-essential cmake
sudo apt-get -y install python-dev python3-dev
cd ~/.vim/plugged/YouCompleteMe
python3 ./install.py
```
If you are on a raspberry pi (<=3) or beagle bone, replace the last line with:
```bash
YCM_CORES=1 ./install.py
```
# To setup VIM on Windows 10 (outside of WSL)
Download a copy of vim that is compiled properly.  Don't use the default
installer from the main vim.org site, since it is missing python3 support.  Use
the builds from the tuxproject:

[https://tuxproject.de/projects/vim/](https://tuxproject.de/projects/vim/)

Decompress the files and move them to where you want Vim installed.  Do not
place them in the "program files" directories.

Copy the [Plug.vim](https://github.com/junegunn/vim-plug) plugin into the autostart directory of vim folder.

Open Gvim.  

Confirm that it has been built with python3 support:  `:echo has('python3')` The
output should be 1.

Type `:echo $VIM` and take note of the output, this is the `<Install Root>`.

Now, navigate to `<Install Root>` and type:
```bash
git clone git@github.com:aleph2c/vim_tmux.git .vim
```

Open the `<Install Root>` folder in windows explorer.  Edit `_vimrc` and add the
following to the end of the file:
```
source $VIM/.vim/.vimrc
```
Restart VIM, press ctrl-C to get past the errors.  Then type:
```
:PluginInstall 
```
After this VIM is mostly ready.

Now if you would like (to waste about 3 hours of your life) to get
[YouCompleteMe](https://github.com/Valloric/YouCompleteMe) working, download:

 * Virtual Studio Community Addition (5Gigs download, C++)
 * Virtual Studio Build Tools        (2Gigs download, Only works after first download)
 * Cmake

Adjust your path so that the following can be found:

 * Cmake
 * MsBuild.exe

Restart your shell so your path is updated, then:
```bash
cd <Install Root>\plugged\YouCompleteMe
python install.py --msvc 15
```
Restart Vim.
