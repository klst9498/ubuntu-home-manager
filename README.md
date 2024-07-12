# ubuntu-home-manager

# TLRD
This repo can be used to bootstrap an fresh [wsl2 Ubuntu](https://canonical-ubuntu-wsl.readthedocs-hosted.com/en/latest/guides/install-ubuntu-wsl2/) with [NIX](https://nixos.org),  [home-manager](), [fish shell], and [starship](), ...

# Prerquisites

Login to WSL-Ubuntu

```console
    # install nix package manager
    sh <(curl -L https://nixos.org/nix/install) --no-daemon
    nix run home-manager/master -- init --switch
```
 This will create a flake.nix, flake.lock and home.nix under ~/.config/home-manager

```console
 └─ home-manager
  ├─ flake.nix
  ├─flake.lock
  └─ home.nix
```

Exchange the "home-manager" foler with the home-manager stored in git
```console
    cd ~/.config/
    rm -rf home-manager
    git clone  https://github.com/klst9498/ubuntu-home-manager.git home-manager
    home-manager switch
```

That's it :smile:


