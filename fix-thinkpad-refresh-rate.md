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
