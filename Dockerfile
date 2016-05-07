FROM nfnty/arch-mini:latest
MAINTAINER colajam93 <https://github.com/colajam93>

# pacman
RUN rm -f /etc/pacman.d/mirrorlist /etc/pacman.conf
COPY mirrorlist /etc/pacman.d/mirrorlist
COPY pacman.conf /etc/pacman.conf
RUN pacman --noconfirm --needed -Syu \
    abs \
    base-devel \
    gdb \
    git \
    man \
    man-pages \
    openssh \
    python \
    rsync \
    unzip \
    vim \
    yaourt \
        > /dev/null
RUN echo -e '\ny\ny\n' | pacman -S multilib-devel && echo -e '\r'

# abs
RUN timeout 5 abs > /dev/null 2>&1 || true
RUN abs > /dev/null 2>&1

# archstrike
RUN pacman-key --init
RUN dirmngr < /dev/null
RUN pacman-key -r F32D93DA
RUN pacman-key --lsign-key F32D93DA
RUN pacman -Syu --noconfirm archstrike-keyring

# user
RUN useradd -m -d /home/test test
RUN echo "test:test" | chpasswd
RUN echo 'test ALL=(ALL) ALL' >> /etc/sudoers
COPY .bashrc /home/test/.bashrc
COPY .vimrc /home/test/.vimrc
COPY .gdbinit /home/test/.gdbinit
RUN chown -R test:test /home/test
