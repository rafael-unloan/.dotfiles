FROM manjarolinux/base

RUN pacman -Syu --needed vim ripgrep fd git base-devel sudo go --noconfirm

RUN useradd builduser -m # Create the builduser
RUN passwd -d builduser # Delete the buildusers password
# Allow the builduser passwordless sudo
RUN printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers
USER builduser

RUN git clone https://aur.archlinux.org/yay.git ~/yay
RUN cd ~/yay && makepkg -si --noconfirm
RUN yay -Syu emacs-git --noconfirm

RUN echo 'set -o vi' >> ~/.bashrc
RUN echo 'export LSP_USE_PLISTS=true' >> ~/.bashrc
RUN echo 'export PATH=${PATH}:${HOME}/.config/yarn/global/node_modules/typescript/bin:${HOME}/.config/emacs/bin' >> ~/.bashrc
RUN echo 'export COLORTERM=truecolor' >> ~/.bashrc

RUN git clone git@github.com:rafael-unloan/.doom.d.git ~/.config/doom
RUN git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
RUN doom install --force
RUN doom sync

RUN mkdir -p ~/Dropbox/emacs/excalidraw

CMD ["bash"]
