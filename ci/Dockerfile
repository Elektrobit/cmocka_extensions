FROM ubuntu:jammy

ARG USER=ci
ARG UID=1000
ARG GID=1000
ARG ASMCOV_URI="not available"
ARG CAPSTONE_VERSION=4.0.2
ARG TABVIEW_VERSION=1.9

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && apt-get install -y \
    binutils-dev \
    build-essential \
    clang-format \
    clang-tidy \
    cmake \
    curl \
    gdb \
    git \
    git-buildpackage \
    libcmocka-dev \
    libcsv-dev \
    libiberty-dev \
    linux-tools-generic \
    locales \
    ninja-build \
    pandoc \
    pandoc-plantuml-filter \
    pkg-config \
    python-is-python3 \
    python3-pip \
    python3-venv \
    sudo \
    wget \
    zlib1g-dev \
 && rm -rf /var/lib/apt/lists/* \
 && rm /usr/bin/perf \
 && find /usr/lib/linux-tools -name "perf" -executable -exec ln -s {} /usr/bin/perf \;

RUN locale-gen en_US.UTF-8 \
 && locale-gen de_DE.UTF-8 \
 && groupadd -g $GID -o ci \
 && useradd -m -u $UID -g $GID -o -s /bin/bash $USER \
 && echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN git clone --depth 1 --branch $CAPSTONE_VERSION https://github.com/aquynh/capstone.git
RUN cd capstone/ \
 && ./make.sh \
 &&  sudo ./make.sh install

RUN if [ "${ASMCOV_URI}" != "not available" ]; then git clone --depth 1 ${ASMCOV_URI} -b 'integration' \
 && cmake -B build asmcov \
 && make -C build \
 && make -C build install; \
 fi

RUN git clone --depth 1 --branch $TABVIEW_VERSION https://gitlab.com/esr/tapview.git
RUN cd tapview \
 && sed -i '/$(INSTALL) -m 644 $(MANPAGES)/d' Makefile\
 && make install DESTDIR=/ prefix=usr

USER $USER
ENV LC_ALL=en_US.UTF-8
ENV DOCKERBUILD=1

RUN python -m venv /home/$USER/.venv \
  && . /home/$USER/.venv/bin/activate \
  && python -m pip install \
     beautifulsoup4  \
     sphinx \
     sphinx-c-autodoc \
     sphinx-copybutton \
     sphinx-favicon \
     sphinxcontrib-programoutput

# install sphinx-c-autodoc dependedncies
RUN wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | sudo tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc \
  && echo "\n\
# for llvm 16 packages\n\
deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-16 main\n\
deb-src http://apt.llvm.org/jammy/ llvm-toolchain-jammy-16 main\n\
" | sudo tee -a /etc/apt/sources.list \
  && sudo apt-get update \
  && sudo apt-get install -y libclang1-16 \
  && sudo ln -s /usr/lib/x86_64-linux-gnu/libclang-16.so.1 /usr/lib/libclang-16.so

ENV SPHINX_VENV="/home/$USER/.venv/"
ENV LOG4C_RCPATH="/base/elos/src/demo/elos_log4c_demo"

WORKDIR /build

CMD /bin/bash

