# Nvidia GPU sleep fixes

I have experienced my PC wont wake from sleep when I have a Nvidia GPU. This happened on Ubuntu 25.x and Arch. 

This fix should (Not sure yet on 31.08.2025) Fix it 

## Arch using System-d boot

Open the config file for system-d boot

```shell
sudo nano /boot/loader/entries/<some-config-name>.conf
# Example: 2025-08-30_13-40-20_linux.conf
```

Add the following to the options

```shell
mem_sleep_default=s2idle nvidia.NVreg_PreserveVideoMemoryAllocations=1
# s2idle [deep] was the original value and doesn't work
# NVreg_PreserveVideoMemoryAllocations uses more power during sleep
```

Reboot, Profit 
