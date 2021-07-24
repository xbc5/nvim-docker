FROM fedora:rawhide

ENV PATH "$PATH:/usr/bin/"

RUN sed --in-place 's|^metalink=.*$|&\&protocol=https|g' /etc/yum.repos.d/*
RUN dnf install --assumeyes neovim npm python3-pip python3

RUN useradd --create-home --shell /bin/bash user

RUN echo "export PATH=/home/user/.npm-packages/bin:$(python3 -m site --user-site | sed 's|^/root|/home/user|'):/usr/bin:/usr/sbin:/bin" > /etc/profile.d/container.sh

USER user
RUN source /etc/profile.d/container.sh

RUN echo -e "prefix=${HOME}/.npm-packages\nloglevel=verbose" > ${HOME}/.npmrc
RUN pip3 install --user pynvim
RUN npm install --global yarn

RUN mkdir --parents /home/user/.config/nvim
WORKDIR /home/user/.config/nvim
ENTRYPOINT ["nvim"]
