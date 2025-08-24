# Disable motherboard bluetooth

> NB! Plug out your Bluetooth Dongle BEFORE starting.

### Find your wireless 

Run the following command:

```shell
lsusb
# Will list USB Devices
```

### Example:

```shell
Bus 001 Device 005: ID 0e8d:0616 MediaTek Inc. Wireless_Device
# MediaTek Bluetooth on motherboard
```

### Create the following file

```
 sudo nano /etc/udev/rules.d/motherboard-bluetooth-hci.rules
# Create a file to disable adapter
```

### Add the following

```shell
SUBSYSTEM=="usb", ATTRS{idVendor}=="0e8d", ATTRS{idProduct}=="0616", ATTR{authorized}="0"
# Note from the previous output 0e8d:0616 -> idVendor:idProduct
```

### Reboot

Reboot the system and bluetooth should no longer be available. It is now safe to plug in your USB Bluetooth Dongle
