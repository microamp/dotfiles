- [dotfiles](#org57d39dd)
  - [Requirements](#org22ab68b)
    - [Misc](#orgcbbc2df)
  - [QuickStart](#org266a307)
  - [Screenshots](#orgedf8df9)


<a id="org57d39dd"></a>

# dotfiles


<a id="org22ab68b"></a>

## Requirements

```sh
lsb_release -a
```

```text
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 22.04.1 LTS
Release:        22.04
Codename:       jammy
```

-   `sway`

    ```sh
    apt install sway
    ```

-   `emacs`

    ```sh
    git clone git://git.sv.gnu.org/emacs.git
    cd emacs
    git checkout -b emacs-29 origin/emacs-29
    ```

    ```sh
    # apt built-dep -y emacs
    apt install \
        imagemagick \
        imagemagick-common \
        libgccjit-10-dev \
        libgccjit0 \
        libjansson-dev \
        libjansson4 \
        libmagickwand-dev \
        librsvg2-common \
        librsvg2-dev \
        libtree-sitter-dev \
        libtree-sitter0 \
        libxml2 \
        libxml2-dev
    ```

    ```sh
    ./configure \
        --with-imagemagick \
        --with-json \
        --with-tree-sitter \
        --with-pgtk \
        --with-native-compilation
    make -j 8
    make install
    ```

    ```sh
    mkdir ~/zettel # where org-roam notes will be located
    ```

-   `tmux`

    ```sh
    apt install tmux
    ```

-   `vim`

    ```sh
    apt install vim
    ```

-   `stow`

    ```sh
    apt install stow
    ```


<a id="orgcbbc2df"></a>

### Misc

-   `pandoc`

    ```sh
    apt install pandoc
    ```

-   `ripgrep`

    ```sh
    apt install ripgrep
    ```

-   `fzf`

    ```sh
    apt install fzf
    ```

-   `slurp` and `grim`

    ```sh
    apt install slurp grim
    ```

    (to replace `scrot` from Xorg)

-   `fonts-ibm-plex`

    ```sh
    apt install fonts-ibm-plex
    ```

-   `pfetch`

    [pfetch](https://github.com/dylanaraps/pfetch)

    ```sh
    mkdir -p ~/src/github.com/dylanaraps/pfetch
    git clone https://github.com/dylanaraps/pfetch.git ~/src/github.com/dylanaraps/pfetch
    ln -s ~/src/github.com/dylanaraps/pfetch/pfetch ~/bin/pfetch
    ```

-   `wlsunset`

    [wlsunset](https://sr.ht/~kennylevinsen/wlsunset/)

    e.g.

    ```sh
    wlsunset -l 36.8509 -L 174.7645 & # NZ
    ```

-   `pass`

    ```sh
    apt install pass
    ```

    -   `dmenu-wl`

        TODO: Build from source

    -   `passmenu`

        ```sh
        wget https://git.zx2c4.com/password-store/plain/contrib/dmenu/passmenu
        chmod u+x passmenu
        mv passmenu ~/bin
        which passmenu
        ```

-   `wl-clipboard`

    ```sh
    apt install wl-clipboard
    ```

-   `chatgpt-shell`

    ```sh
    mkdir -p ~/.emacs.d/src/xenodium
    cd ~/.emacs.d/src/xenodium
    git clone git@github.com:xenodium/chatgpt-shell.git
    ```

-   `chat.el`

    ```sh
    mkdir -p ~/.emacs.d/src/iwahbe
    cd ~/.emacs.d/src/iwahbe
    git clone git@github.com:iwahbe/chat.el.git
    ```


<a id="org266a307"></a>

## QuickStart

```sh
stow bash
stow config
stow emacs
stow tmux
stow vim
```


<a id="orgedf8df9"></a>

## Screenshots

![clean](clean.png)

![dirty](dirty.png)
