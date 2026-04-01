#!/usr/bin/env bash

# ==============================================================================
#   1. SYSTEM REFRESH & REPOSITORY REQUISITES
# ==============================================================================
# Ensures the system can handle external PPAs and GPG keys
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y \
    software-properties-common \
    wget gpg apt-transport-https \
    ca-certificates

# ==============================================================================
#   2. EXTERNAL REPOS (Native APT over Flatpak/Snap)
# ==============================================================================

# VS Code (Microsoft Official)
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

# Signal Messenger (Official)
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
sudo cat signal-desktop-keyring.gpg > /usr/share/keyrings/signal-desktop-keyring.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee /etc/apt/sources.list.d/signal-messenger.list

# Apptainer & Other PPAs
sudo add-apt-repository -y ppa:apptainer/ppa

sudo apt-get update

# ==============================================================================
#   3. CLI TOOLS & ESSENTIALS
# ==============================================================================

# Core Navigation & System Info
sudo apt-get install -y \
    curl git tree htop btop ranger \
    ncdu duf tlp stow

# Modern CLI Replacements (Rust-based/Fast)
sudo apt-get install -y \
    bat fd-find fzf zoxide \
    jq silversearcher-ag rsync

# Fun & Utility
sudo apt-get install -y \
    figlet sl lolcat cmatrix \
    hollywood rename libaa-bin

# Terminal Multiplexers & Networking
sudo apt-get install -y \
    tmux ssh net-tools ufw \
    pass xclip xsel

# ==============================================================================
#   4. DEVELOPMENT ENVIRONMENTS
# ==============================================================================

# Build Systems & Base Compilers
sudo apt-get install -y \
    build-essential cmake make \
    pkg-config ninja-build valgrind

# Python Environment
sudo apt-get install -y \
    python3 python3-pip python3-venv \
    python3-dev ipython3 jupyter

# C++ / Low-Level
sudo apt-get install -y \
    gcc g++ gfortran clangd \
    libclang-dev gdb cppcheck \
    libc++-dev libfmt-dev

# Java & Scripting
sudo apt-get install -y \
    default-jre default-jdk \
    lua5.1 luarocks luajit

# .NET SDK (C#) — always installs the latest release via Microsoft's official script
curl -fsSL https://dot.net/v1/dotnet-install.sh | sudo bash -s -- --channel LTS --install-dir /usr/share/dotnet
sudo ln -sf /usr/share/dotnet/dotnet /usr/bin/dotnet

# ==============================================================================
#   5. PRODUCTIVITY, SCIENTIFIC & ENGINEERING
# ==============================================================================

# Office & Email
sudo apt-get install -y \
    evolution evolution-ews \
    hunspell hunspell-en-us \
    calcurse todotxt-cli pandoc

# Scientific Computing & Databases
sudo apt-get install -y \
    octave gnuplot doxygen \
    libblas-dev liblapack-dev \
    libatlas-base-dev openmpi-bin \
    libhdf5-dev sqlite3 libsqlite3-dev

# Container Platforms (Native)
sudo apt-get install -y \
    apptainer code signal-desktop

# ==============================================================================
#   6. GRAPHICS, MEDIA & DOCUMENTATION
# ==============================================================================

# Heavy Media Suites
sudo apt-get install -y \
    inkscape gimp kdenlive \
    obs-studio ffmpeg imagemagick

# LaTeX & Technical Writing
sudo apt-get install -y \
    texlive-latex-extra texlive-fonts-extra \
    texlive-science texlive-bibtex-extra \
    biber latexmk texstudio

# ==============================================================================
#   7. WINDOWS-TO-LINUX ESSENTIALS (GUI)
# ==============================================================================

# File Transfer & Maintenance
sudo apt-get install -y \
    filezilla remmina stacer \
    gnome-disk-utility gnome-tweaks \
    extension-manager

# Lightweight Editors & Archivers
sudo apt-get install -y \
    notepadqq geany \
    p7zip-full p7zip-rar unrar

# ==============================================================================
#   8. SANDBOXED APPS (SNAP & FLATPAK)
# ==============================================================================

# Snap Apps (Proprietary/Closed Source)
sudo snap install chromium
sudo snap install spotify
sudo snap install rocketchat-desktop
sudo snap install gitkraken --classic

# Flatpak Apps (Self-Contained)
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub -y \
    org.gnome.World.PikaBackup \
    app.zen_browser.zen \
    org.localsend.localsend_app \
    md.obsidian.Obsidian \
    com.logseq.Logseq \
    com.motrix.Motrix \
    io.github.peazip.PeaZip

# ==============================================================================
#   9. DOCKER ENGINE SETUP
# ==============================================================================
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$UBUNTU_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker ${USER}

# ==============================================================================
#   10. FINAL POLISH & CLEANUP
# ==============================================================================

# Fix 'bat' command name (Ubuntu/Zorin uses 'batcat')
mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat || true

# Cleanup unused packages
sudo apt-get autoremove -y

# ==============================================================================
#   11. FENICSX ENVIRONMENT SETUP
# ==============================================================================
FENICSX_SETUP_URL="https://raw.githubusercontent.com/LavakumarVeludandi/setup-zorin/master/fenicsx/setup_fenicsx_envs.sh"

if [ -n "${SUDO_USER:-}" ] && [ "${SUDO_USER}" != "root" ]; then
    echo "Running FEniCSx environment setup as ${SUDO_USER}..."
    sudo -u "${SUDO_USER}" bash -c "curl --silent \"${FENICSX_SETUP_URL}\" | bash"
else
    echo "Running FEniCSx environment setup..."
    curl --silent "${FENICSX_SETUP_URL}" | bash
fi

echo "----------------------------------------------------------------"
echo "INSTALLATION COMPLETE"
echo "Note: Please REBOOT to apply Docker permissions and TLP settings."
echo "----------------------------------------------------------------"
