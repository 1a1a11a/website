#!/bin/bash

export INSTALL_DIR=$HOME/software
export SHELL_CONFIG=$HOME/.zshrc

sudo swapoff -a

sudo apt-get update >/dev/null
sudo apt-get install -yqq htop bmon iotop tmux zsh git screen parallel g++ libglib2.0-dev autojump make mosh >/dev/null 2>&1
sudo apt-get install -yqq nfs-kernel-server nfs-common libconfig-dev libconfig++-dev mdadm pv zstd >/dev/null 2>&1
sudo apt-get install -yqq google-perftools libgoogle-perftools-dev >/dev/null 2>&1
sudo apt-get install -yqq libboost-all-dev libglib2.0-dev >/dev/null 2>&1
sudo apt-get install -yqq ninja-build clang clang-format libclang-dev >/dev/null 2>&1

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

if [ ! -d ${INSTALL_DIR}/cmake ]; then
    wget -q https://github.com/Kitware/CMake/releases/download/v3.27.0/cmake-3.27.0-linux-x86_64.sh -O /tmp/cmake-3.27.0-linux-x86_64.sh || true
    mkdir -p ${INSTALL_DIR}/cmake 2>/dev/null || true
    bash /tmp/cmake-3.27.0-linux-x86_64.sh --prefix=${INSTALL_DIR}/cmake/ --skip-license >/dev/null
    echo 'PATH='${INSTALL_DIR}'/cmake/bin/:$PATH' >> ${SHELL_CONFIG}
fi

if [ ! -d ${INSTALL_DIR}/miniconda3/ ]; then
    wget -q https://repo.anaconda.com/miniconda/Miniconda3-py311_23.5.2-0-Linux-x86_64.sh -O /tmp/mini.sh || true
    bash /tmp/mini.sh -b -p ${INSTALL_DIR}/miniconda3/ >/dev/null
    ${INSTALL_DIR}/miniconda3/bin/conda init bash >/dev/null
    ${INSTALL_DIR}/miniconda3/bin/python3 -m pip install redis psutil >/dev/null
fi

# if [ ! -d ${HOME}/.cargo/ ]; then
#     curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y >/dev/null
# fi

git config --global user.name "Juncheng Yang"
git config --global user.email "peter.waynechina@gmail.com"

echo 'export EDITOR=vi' >>${SHELL_CONFIG}
echo "export OMP_NUM_THREADS=1" >>${SHELL_CONFIG}
echo "export RUST_BACKTRACE=1" >>${SHELL_CONFIG}
echo "export TCMALLOC_LARGE_ALLOC_REPORT_THRESHOLD=1000000000" >>${SHELL_CONFIG}
echo '. /usr/share/autojump/autojump.sh' >>${SHELL_CONFIG}


installZstd() {
    cd /tmp/
    wget -q https://github.com/facebook/zstd/releases/download/v1.5.0/zstd-1.5.0.tar.gz
    tar xvf zstd-1.5.0.tar.gz >/dev/null 2>&1 || true
    cd zstd-1.5.0/build/cmake/
    mkdir _build >/dev/null 2>&1 || true
    cd _build/
    ${INSTALL_DIR}/cmake/bin/cmake .. >/dev/null 2>&1
    make -j >/dev/null 2>&1
    sudo make install >/dev/null 2>&1
    echo "######## $(date +%H:%M:%S) ${NODE_NAME} Zstd install finished"
}

installZstd