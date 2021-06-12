ARG TAG=34
FROM registry.fedoraproject.org/fedora:${TAG}

RUN dnf -y update && \
  dnf -y install gcc-c++ cmake wget fftw-devel && \
  dnf clean all

RUN useradd -m -G wheel -u 1001 user
RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER user
WORKDIR /home/user
RUN wget https://ftp.gromacs.org/pub/gromacs/gromacs-2019.6.tar.gz
RUN tar -xvf gromacs-2019.6.tar.gz
WORKDIR gromacs-2019.6
RUN cmake -B builddir .
RUN cmake --build builddir
