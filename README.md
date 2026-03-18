# nvim-config
Dot files of my NeoVim Setup

## Getting Started
To install NeoVim, we will use snap instead of apt. Most of the configuration is based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim?tab=readme-ov-file#linux-install), so we need `make gcc ripgrep fd-find tree-sitter-cli unzip git xclip curl` and most language servers need `npm` and ansible-lint needs `python3 python3-venv`.

```
sudo apt install make gcc ripgrep fd-find tree-sitter-cli unzip git xclip curl npm python3 python3-venv
```

Import the configuration files from this repo with a git clone.

```
mkdir ~/.config && cd ~/.config 
git clone https://github.com/bethsay/nvim-config.git
mv nvim-config/ nvim && cd ~/.config/nvim
```

> [!WARNING]
> There is an issue with loading lua/plugins/telescope.lua. As a workaround comment lines 6-9 and 11-24.

And now install nvim.

```
snap install nvim --classic
nvim --version
nvim
```

<!--
```
# Now we install nvim
mkdir ~/Downloads && cd ~/Downloads
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
cd ~/.config 
nvim --version
nvim
```
-->

To exit type `:qa!`.

> [!Note]
> If you have commented out lines in lua/plugins/telescope.lua; then one at a time, uncomment lines 6-9, saving, re-Opening Nvim each time. After that uncomment lines 11-24 all at once, then save and re-open.

### Nerd Font
<details><summary>On Windows PowerShell</summary>

Browse [NerdFonts](https://www.nerdfonts.com/) for the one you like. I chose to download [Hack](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip).
+ After Downloading &rarr; Unzip/Extract it &rarr; Select all `ttf` files &rarr; Right Click &rarr; Install
+ Re-Open PowerShell &rarr; Open Setting from Tab-Dropdown &rarr; Profiles &rarr; Select Any (Ubuntu) &rarr; AdditionalSettings &rarr; Appearance &rarr; FontFace &rarr; HackMono
Re-Open PowerShell
</details>

<details><summary>On Ubuntu Konsole or Terminal</summary>

Im choosing Hack Font. You can pick any other from [Nerd-Fonts](https://github.com/ryanoasis/nerd-fonts/releases/)

```
wget -O ~/Downloads/nerdfont-Hack.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip
unzip ~/Downloads/nerdfont-Hack.zip -d ~/.local/share/fonts/
fc-cache -fv
fc-list | grep -i hack
```

Re-Open Konsole or Terminal
</details>