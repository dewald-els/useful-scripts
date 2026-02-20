# Wifi 

I encountered an issue where my WiFi would not work after restarting Omarchy (Arch). 

## Inital steps

I used the following command to print out the network devices:

```shell
networkctl list
```

This resulted in the following output:

```shell
IDX LINK    TYPE     OPERATIONAL SETUP
  1 lo      loopback carrier     unmanaged
  2 docker0 bridge   no-carrier  unmanaged
  4 wlan0   wlan     off    configuring
```

## Solution

I was able to fix it by restarting the IWD service 

```shell
sudo systemctl restart iwd.service
```

After running `networkctl list` again, this was now the output and WiFi was connected

```shell
IDX LINK    TYPE     OPERATIONAL SETUP
  1 lo      loopback carrier     unmanaged
  2 docker0 bridge   no-carrier  unmanaged
  4 wlan0   wlan     routable    configured
```
