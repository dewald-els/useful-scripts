# Set display panel to max brightness

```shell
echo 255 | sudo tee /sys/class/backlight/amdgpu_bl0/brightness
# Force the internal brightness to max
```

### Why?

Sometimes KDE Plasma on Debian 13 goes out of sync with the actual brightness of the display :(
