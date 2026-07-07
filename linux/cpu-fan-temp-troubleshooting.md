# CPU Fan / Temp Troubleshooting (AMD ThinkPad)

Fans ran loud after a warm reboot even though temps were fine — the EC was stuck. Fixed with `thinkfan`.

## Diagnose

```bash
sensors                                                    # check temps + fan RPM
ps -eo pid,%cpu,%mem,comm --sort=-%cpu | head             # any runaway process?
powerprofilesctl get                                       # power profile
powerprofilesctl set balanced                              # cooler profile
cat /proc/acpi/ibm/fan                                      # fan level (auto = EC-controlled)
sudo dmesg | grep -iE 'thermal|fan' | tail                 # boot showed THM0 at 68C (stuck EC)
cat /sys/module/thinkpad_acpi/parameters/fan_control       # N = manual control off
```

## Fix (thinkfan)

```bash
sudo apt install thinkfan                                                   # install
echo "options thinkpad_acpi fan_control=1" | sudo tee /etc/modprobe.d/thinkfan.conf  # allow manual control
sudo modprobe -r thinkpad_acpi && sudo modprobe thinkpad_acpi               # reload module
for h in /sys/class/hwmon/hwmon*; do echo "$h -> $(cat $h/name)"; done      # find sensor names
```

Config `/etc/thinkfan.conf` (fan off below 55C, full by 75C):

```yaml
sensors:
  - hwmon: /sys/class/hwmon
    name: k10temp
    indices: [1]
  - hwmon: /sys/class/hwmon
    name: amdgpu
    indices: [1]
fans:
  - tpacpi: /proc/acpi/ibm/fan
levels:
  - [0, 0, 55]
  - [1, 50, 60]
  - [2, 55, 65]
  - [3, 60, 70]
  - [4, 65, 75]
  - [5, 70, 80]
  - [7, 75, 32767]
```

```bash
sudo timeout 8 thinkfan -n                          # test in foreground
sudo sed -i 's/^START=no/START=yes/' /etc/default/thinkfan
sudo systemctl enable --now thinkfan                # run persistently
sudo systemctl disable --now thinkfan               # revert to firmware control
```

## Notes

- 50C idle is normal; throttling starts ~90-95C.
- Static noise was the USB-C dock (ground loop), not the laptop.
- `temp3_min/max I/O error` and the `acpi_fan` RPM number are cosmetic — ignore.
