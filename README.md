# setup-Zorin

Zorin OS setup and installation script for apps.

## Installation

Run the following commands to install everything:

```bash
sudo apt-get update && sudo apt-get upgrade --assume-yes
sudo apt-get install --assume-yes curl
curl --silent https://raw.githubusercontent.com/LavakumarVeludandi/setup-zorin/master/iZorin.sh | sudo bash
```

## What gets installed

- **External Repo Apps** – VS Code (Microsoft), Signal Messenger, Apptainer
- **CLI Tools & Essentials** – curl, tree, htop, btop, ranger, ncdu, duf, tlp, stow, bat, fd-find, fzf, zoxide, jq, silversearcher-ag, rsync, figlet, sl, lolcat, cmatrix, hollywood, rename, libaa-bin, tmux, ssh, net-tools, ufw, pass, xclip, xsel
- **Development Environments** – Python 3 (pip, venv, ipython3, jupyter), GCC/G++/GFortran, Clangd, GDB, Cppcheck, libfmt, Valgrind, Java (JRE/JDK), Lua (luarocks, luajit), CMake, Make, Ninja, pkg-config, build-essential
- **Productivity & Scientific** – Evolution (+ EWS), Hunspell, Calcurse, todotxt-cli, Pandoc, Octave, Gnuplot, Doxygen, BLAS/LAPACK, OpenMPI, HDF5, SQLite
- **Graphics, Media & Documentation** – Inkscape, GIMP, Kdenlive, OBS Studio, FFmpeg, ImageMagick, texlive-latex-extra, texlive-fonts-extra, texlive-science, texlive-bibtex-extra, Biber, Latexmk, TeXstudio
- **GUI & Windows-to-Linux Essentials** – FileZilla, Remmina, Stacer, GNOME Disk Utility, GNOME Tweaks, Extension Manager, Notepadqq, Geany, p7zip, unrar
- **Docker Engine** – docker-ce, docker-ce-cli, containerd.io, docker-buildx-plugin, docker-compose-plugin
- **Snap apps** – Chromium, Spotify, RocketChat Desktop, GitKraken
- **Flatpak apps** – Pika Backup, Zen Browser, LocalSend, Obsidian, Logseq, Motrix, PeaZip
