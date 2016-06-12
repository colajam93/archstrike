FROM colajam93/archlinux:latest
MAINTAINER colajam93 <https://github.com/colajam93>

# archstrike
USER root
RUN echo -e "\
\n\
[archstrike]\n\
Server = https://mirror.archstrike.org/\$arch/\$repo\n\
\n\
[archstrike-testing]\n\
Server = https://mirror.archstrike.org/\$arch/\$repo"\
                >> /etc/pacman.conf
RUN pacman -Syy
RUN pacman-key --init
RUN dirmngr < /dev/null
RUN pacman-key -r 7CBC0D51
RUN pacman-key --lsign-key 7CBC0D51
RUN pacman -Syu --noconfirm archstrike-keyring
USER test
