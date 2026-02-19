# Fix ThinkPad T14S refresh rate

### open grub config

```shell
sudo nano /etc/default/grub
```

#### add amdgpu.dcdebugmask=0x8000 like so:

```shell
GRUB_CMDLINE_LINUX="rd.luks.uuid=luks-<uuid> rhgb quiet amdgpu.dcdebugmask=0x8000"
```

#### make grub config
```
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

#### restart system

```shell
sudo reboot
```

### When using systemd

```shell
sudo nano /boot/loader/entries/<some-file-name>.conf
```

#### Edit the file with the options
```
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=UUID=your-root-uuid rw amdgpu.dcdebugmask=0x8000 # <-- Add debug mask here 
```

Finally, Reboot

## Side notes 

Using Linux Mint caused a crash. This could have been due to the PSR (Panel Self Refresh Rate)

### Check for DMUB Error

Command to check for errors since last boot:

```shell
sudo journalctl -b -k | grep -i dmub
```

Command to monitor for errors in real time:

```shell
sudo journalctl -f -k | grep -i dmub
```

### The Fix

Change the setting above to the following: 

Follow the same process above to update the boot flags:

```shell
GRUB_CMDLINE_LINUX="amdgpu.dcdebugmask=0x8010"
```
This combines the Refresh rate fix above with the DMUB fix: 

```shell
0x8000 (90Hz fix) + 0x10 (DMUB fix) = 0x8010
```

