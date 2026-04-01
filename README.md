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

- **CLI Tools & Essentials** – curl, git, htop, btop, tmux, ranger, tree, jq, stow, lolcat, figlet, and more
- **Productivity & Utilities** – vim, obs-studio, evolution, calcurse, pandoc, cmatrix, hollywood, and more
- **Development Environments** – Python 3, GCC/G++/GFortran, Clang, GDB, Java (JRE/JDK), Lua, CMake, and more
- **Scientific & Engineering** – Octave, Gnuplot, Doxygen, BLAS/LAPACK, OpenMPI, HDF5, SQLite, and more
- **Graphics & Media** – Inkscape, GIMP, FFmpeg, ImageMagick, Kdenlive
- **LaTeX & Documentation** – texlive-latex-extra, texlive-science, Biber, Latexmk, TeXstudio
- **Snap apps** – Chromium, JabRef, Spotify
- **Flatpak apps** – Pika Backup, Zen Browser
