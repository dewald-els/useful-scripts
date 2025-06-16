# open grub config
sudo nano /etc/default/grub

# add amdgpu.dcdebugmask=0x8000 like so:
GRUB_CMDLINE_LINUX="rd.luks.uuid=luks-<uuid> rhgb quiet amdgpu.dcdebugmask=0x8000"

# make grub config
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# restart system
sudo reboot
