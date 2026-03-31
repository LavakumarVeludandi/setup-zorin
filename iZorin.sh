#!/usr/bin/env bash

# ==============================================================================
#   Initial System Refresh
# ==============================================================================
sudo apt-get update && sudo apt-get upgrade -y

# ==============================================================================
#   CLI Tools & Essentials
# ==============================================================================
sudo apt-get install -y \
    curl xclip tree htop btop ranger figlet sl ncdu rename \
    libaa-bin lolcat tlp tmux ssh net-tools pass xsel stow \
    fontconfig silversearcher-ag jq git build-essential cmake make

# ==============================================================================
#   Productivity & Utilities
# ==============================================================================
sudo apt-get install -y \
    calcurse todotxt-cli pandoc librsvg2-common \
    cmatrix hollywood vim vim-gtk3 obs-studio \
    evolution evolution-ews hunspell hunspell-en-us

# ==============================================================================
#   Development Environments
# ==============================================================================
# Python
sudo apt-get install -y \
    python3 python3-pip python3-venv python3-dev ipython3 python3-ipykernel jupyter
# C++ / Compilers
sudo apt-get install -y \
    gcc g++ gfortran clangd libclang-dev gdb cppcheck \
    libc++-dev libfmt-dev libstdc++5 libjpeg62
# Java & Others
sudo apt-get install -y \
    default-jre default-jdk lua5.1 luarocks luajit

# ==============================================================================
#   Scientific & Engineering (Apt Versions)
# ==============================================================================
# Note: I removed the "*" wildcards to prevent pulling in broken dependencies
sudo apt-get install -y \
    octave gnuplot doxygen libblas-dev liblapack-dev \
    libatlas-base-dev openmpi-bin libopenmpi-dev \
    libhdf5-dev sqlite3 libsqlite3-dev pugixml-doc

# ==============================================================================
#   Graphics & Media (Heavy Apps)
# ==============================================================================
sudo apt-get install -y \
    inkscape gimp ffmpeg imagemagick kdenlive

# ==============================================================================
#   LaTeX & Documentation
# ==============================================================================
sudo apt-get install -y \
    texlive-latex-extra texlive-fonts-extra texlive-science \
    texlive-bibtex-extra biber latexmk texstudio

# ==============================================================================
#   Snap & Flatpak Apps (Non-OS level)
# ==============================================================================
# Zorin comes with Flatpak pre-configured, no need for the Kubuntu-specific backend fixes.

# Snaps
sudo snap install chromium
sudo snap install jabref
sudo snap install spotify

# Flatpaks
flatpak install flathub org.gnome.World.PikaBackup -y
flatpak install flathub app.zen_browser.zen -y

# ==============================================================================
#   Final Cleanup
# ==============================================================================
sudo apt-get autoremove -y
echo "Installation complete. Please reboot for TLP and system paths to update."
