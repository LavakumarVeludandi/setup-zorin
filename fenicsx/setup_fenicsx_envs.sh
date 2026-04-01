#!/usr/bin/env bash
set -euo pipefail

MINICONDA_DIR="$HOME/miniconda3"
MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
MINICONDA_INSTALLER="$HOME/Miniconda3-latest-Linux-x86_64.sh"

ENV_09_NAME="fenicsx-0.9-py312"
ENV_10_NAME="fenicsx-0.10-py313"
PY_09="3.12"
PY_10="3.13"

CONDA_COMMON_PKGS=(
  mpich
  pyvista
  meshio
  dolfinx_mpc
  numpy
  scipy
  matplotlib
)

PIP_PKGS=(
  gmsh
  gurobipy
  jax
  tqdm
  dependency-injector
  psutil
  pandas
  h5py
  mosek
  numba
  llvmlite
)

ensure_curl() {
  if command -v curl >/dev/null 2>&1; then
    return 0
  fi

  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y curl
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y curl
  elif command -v yum >/dev/null 2>&1; then
    sudo yum install -y curl
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Sy --noconfirm curl
  elif command -v zypper >/dev/null 2>&1; then
    sudo zypper install -y curl
  else
    echo "Error: curl is required to download Miniconda. Install it and rerun." >&2
    exit 1
  fi
}

ensure_conda_init() {
  local bashrc="$HOME/.bashrc"

  if [[ -f "$bashrc" ]] && grep -q "conda initialize" "$bashrc"; then
    return 0
  fi

  "$MINICONDA_DIR/bin/conda" init bash
}

install_miniconda() {
  if [[ -x "$MINICONDA_DIR/bin/conda" ]]; then
    return 0
  fi

  echo "Installing Miniconda into $MINICONDA_DIR"
  ensure_curl
  if [[ ! -f "$MINICONDA_INSTALLER" ]]; then
    (cd "$HOME" && curl -fsSLO "$MINICONDA_URL")
  fi

  bash "$MINICONDA_INSTALLER" -b -p "$MINICONDA_DIR"
}

init_conda() {
  if command -v conda >/dev/null 2>&1; then
    # shellcheck source=/dev/null
    source "$(conda info --base)/etc/profile.d/conda.sh"
  else
    install_miniconda
    ensure_conda_init
    # shellcheck source=/dev/null
    source "$MINICONDA_DIR/etc/profile.d/conda.sh"
  fi
}

accept_conda_tos() {
  conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
  conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r
}

env_exists() {
  conda env list | awk 'NF && $1 !~ /^#/ {print $1}' | grep -Fxq "$1"
}

create_env() {
  local env_name="$1"
  local py_ver="$2"
  local fenics_ver="$3"

  if env_exists "$env_name"; then
    echo "Environment $env_name already exists. Skipping create."
  else
    conda create -y -n "$env_name" -c conda-forge "python=$py_ver"
  fi

  conda activate "$env_name"

  conda install -y -c conda-forge \
    "fenics-dolfinx=$fenics_ver" \
    fenics-ufl \
    "${CONDA_COMMON_PKGS[@]}"

  pip install --upgrade pip
  pip install --upgrade "${PIP_PKGS[@]}"

  conda deactivate
}

init_conda
accept_conda_tos
create_env "$ENV_09_NAME" "$PY_09" "0.9.*"
create_env "$ENV_10_NAME" "$PY_10" "0.10.*"

echo "Done. Activate with:"
echo "  conda activate $ENV_09_NAME"
echo "  conda activate $ENV_10_NAME"
