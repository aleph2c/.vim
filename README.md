# To setup new Debian based Linux box

## To setup your keys
login to the new machine:
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
Just hit enter for all options.

The copy the output of the following command into [your github keys](https://github.com/settings/keys)
```
cat ~/.ssh/id_rsa.pub
```

## To build Vim
Follow the instructions in [Valloric's YouCompleteMe wiki](https://github.com/ycm-core/YouCompleteMe/wiki/Building-Vim-from-source)

## Install required debian packages and the information in this repo
Install tmux:
```bash
sudo apt-get -y install tmux inotify-tools
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
Install [pdbpp](https://pypi.org/project/pdbpp/) and [tmuxp](http://tmuxp.git-pull.com/en/latest/index.html):
```bash
pip3 install pdbpp tmuxp
```
---
**NOTES on setting up bash**

For years, pdb would trash my shell after I broke out of the Python program I
was debugging.  I would have to type "reset" to get it working again.

One day I had enough and invested 30 seconds into googling how to fix this
issue.  It turns out that bash will run the contents of the ``PROMPT_COMMAND``
variable before it creates its prompt.  The ``stty sane`` command will fix a
broken terminal. So add the following to your ``.bashrc`` or
``.bash_profile``:

```bash
  # fix your terminal after you break of of pdb session
  PROMPT_COMMAND='stty sane'
````

Both ``pdbpp`` and ``tmuxp`` seem to have environment problems (or maybe my
environment has problems with them):


The ``pdbpp`` package causes some debug steps to take ages to render (``pdp``
steps are instantaneous), and ``display`` does not work in the WSL.  A lot of
the core ``pdbpp`` features can be offered by a decent ``.pdbrc`` file.  So I
may remove ``pdbpp`` in the future.

The ``tmuxp`` package creates a very fragile environment.   To make it work you
need to add the following to your ``.bashrc`` or ``.bash_profile``:

```bash
  # fix broken environment assumption needed for tmuxp
  export PATH=$PATH:$HOME/.local/bin
```

The tmuxp's author suggest adding ``eval "$(_TMUX_COMPLETE=source tmuxp)``, to
your ``.bashrc`` for autocompletion, but if you do this you will see a need for
imagemagic and end up with Xwindows errors.  Do not use this feature.

----

I heavily depend on [UMLet](https://www.umlet.com/) for architectural drawings.  UMLet is a great tool, but it has a lot of problems too (it's free like a mattress).

UMLet accepts command line arguments for converting pictures from ``*.uxf`` into ``*.pdf|*.svg|..``.  This means you can construct a make file for your documents and automatically convert any changed ``*.uxf`` file into another format, then have these newly made diagrams built into your pdf/html-pages automatically.

Do not use UMLet via apt-get, it is hopelessly out of date and broken.  If you install UMLet on your computer, say in Windows 10, it will run using a GUI.  UMLet is written in Java, so in theory its code is portable.  To use UMLet, just download it and run it as a GUI in your native OS.  If you are running in Linux/OSX there is ``umlet.sh`` which can be used in your make files included in the UMLet install directory.  Unfortunately, this script has a bug on line 31.  If you go to the UMLet github repo, it has been [fixed](https://github.com/umlet/umlet/blob/master/umlet-standalone/src/exe/umlet.sh), but it has not been fixed in their UMLet download-site, so your local copy is probably broken.  Fix this.

To get the latest version of UMLet working from within the WSL, install the old UMLet, ``sudo apt-get install umlet``.  We will not use this outdated version, but we will use the version of Java (avoiding Java dependency hell) that is installed with it.  Then add pathing the the ``umlet.sh`` to your ``.bashrc`` or ``.bash_profile``:

```bash
  # add umlet.sh to path
  export PATH=$PATH:/c/mnt/Users/lincoln/Desktop/Umlet:
```

The ``umlet.sh`` will crash when called from a headless machine.  To make it work you will need to prepend ``DISPLAY=`` to any command that uses it.  So to convert a ``uxf`` file to an ``svg`` file from within a headless system, you would type:

```bash
  DISPLAY= umlet.sh -action=convert -format=svg -filename=example.uxf
```

If you are using the Windows 10 UMLet GUI, but are building your documents using the WSL **DO NOT USE** ``umlet.sh`` file.  It will work, but it will draw pictures using the Linux fonts and these will mangle all of your rendered pictures.  Instead of using ``umlet.sh``, have your WSL Makefile call to the ``cmd.exe \C <windows_path_to_UMLET>`` followed by the conversion string.

Generally speaking do the following:

1. Add an environmental variable which has a windows path to UMLET.  You will have to use double backslashes:

```bash
  export WINDOWS_UMLET="C:\\Users\\lincoln\\Desktop\\Umlet\\Umlet.exe"
```

2. In a picture making make file:

```bash
CC = "$(WINDOWS_UMLET)"
UXF = $(shell find . -name "*.uxf")
SVG = $(patsubst %.uxf, %.svg, $(UXF))

.RECEPEPREFIX = >
all : $(SVG)
%.svg: %.uxf
> echo $<; \
> cmd.exe /C $(CC) -action=convert -format=svg -filename=$<;
```

---

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
## To setup VIM on Windows 10 (outside of WSL)
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
