# Install GE PROTON
--------------------

Installation instructions:

https://github.com/GloriousEggroll/proton-ge-custom?tab=readme-ov-file#native


# Steam
---------

Open Steam, find the game you want:

Set Properties -> Command for Games to use Locale (Norway) and gamemode on Ubuntu

> Note: Using Arch, you first need to install gamemode and gamescope (Not sure about gamescope?)
> More information here: [Arch Wiki - GameMode](https://wiki.archlinux.org/title/GameMode)
> 

```shell
HOST_LC_ALL=nb_NO.UTF-8 gamemoderun %command%
```

## Controller Issues

If Steam can see you controller but games can not, it might be a permission issue. Set correct permission for your inputs

```shell
sudo chmod 666 /dev/uinput
```

## BashRC 

Update `~/.bashrc` with the following two lines:

```shell
export PROTON_ENABLE_NVAPI=1
export PROTON_ENABLE_NGX_UPDATER=1
```
### PROTON_ENABLE_NVAPI=1

- Enables NVIDIA API support in Proton (Steam's Windows compatibility layer)
- Allows Windows games to access NVIDIA-specific features through Wine/Proton
- Enables DLSS, NVIDIA Reflex, and other RTX features in Windows games on Linux

### PROTON_ENABLE_NGX_UPDATER=1

- Enables automatic updates for NVIDIA NGX (DLSS/AI) libraries
- Allows Proton to download and use the latest DLSS models
- Keeps AI upscaling features current
