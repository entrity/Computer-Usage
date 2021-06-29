# Remap keys

*NB: for mouse buttons, the comments in my  `/etc/udev/hwdb.d/70-mouse-local.hwdb` advise putting custom changes into `/etc/udev/hwdb.d/71-mouse-local.hwdb`*

## For a specific keyboard
*These instructions are taken from the comments in `/lib/udev/hwdb.d/60-keyboard.hwdb`*

1. Write your own rules to a (possibly new) file `/etc/udev/hwdb.d/70-keyboard.hwdb`, as in the example below.
    - Get event number from `sudo evtest`
    - Get keyboard key codes (hex) from `sudo evtest`
    - Get action names from `/lib/udev/hwdb.d/60-keyboard.hwdb`
    - Get bus code (usb, bluethooth, etc) from `/usr/include/linux/input.h`
    - Get vendor, product, version from `/sys/class/input/event<X>/device/id`
        - NB: You can use a wildcard `*` anywhere you like in these
2. Run bash commands to load the new rules, given below.

### evtest example output
Evtest outputs:
```
Input driver version is 1.0.1
Input device ID: bus 0x19 vendor 0x17aa product 0x5054 version 0x4101
Input device name: "ThinkPad Extra Buttons"
Supported events:
# ...
Event: time 1624935150.368365, type 4 (EV_MSC), code 4 (MSC_SCAN), value 1f
Event: time 1624935150.368365, type 1 (EV_KEY), code 144 (KEY_FILE), value 1
Event: time 1624935150.368365, -------------- SYN_REPORT ------------
```
...and I'll arbitrarily choose the action `file` from `/lib/udev/hwdb.d/60-keyboard.hwdb`, which lets me compose the lines:
```
evdev:input:b0019v17AAp5054e4101*
 KEYBOARD_KEY_1f=file
```

### example bus, vendor, product, version
You can get all of this from the beginning of the output of `evtest`, but if you want to use the file system to get these data:
```bash
cat /sys/class/input/event9/device/id/bustype # => 0019
cat /sys/class/input/event9/device/id/vendor # => 17aa
cat /sys/class/input/event9/device/id/product # => 5054
cat /sys/class/input/event9/device/id/version # => 4101
```
...which lets me compose the line:
```
evdev:input:b0019v17AAp5054e4101*
```

### Example rules file `/lib/udev/hwdb.d/70-keyboard.hwdb`
```bash
# Format is evdev:input:b<BUS>v<VENDOR>p<PRODUCT>e<VERSION>-<MODALIAS>
# The hex codes should be in all caps
# === Apple Magic Keyboard ===
evdev:input:b0005v004Cp0267e0067*
 KEYBOARD_KEY_700e6=rightctrl
 KEYBOARD_KEY_700e3=leftalt
 KEYBOARD_KEY_700e2=leftmeta
 KEYBOARD_KEY_70044=home # f11 => Home
 KEYBOARD_KEY_70045=end # f12 => End
# === same thing over USB ===
evdev:input:b0003v05ACp0267e0110*
 KEYBOARD_KEY_700e6=rightctrl
 KEYBOARD_KEY_700e3=leftalt
 KEYBOARD_KEY_700e2=leftmeta
 KEYBOARD_KEY_70044=home # f11 => Home
 KEYBOARD_KEY_70045=end # f12 => End
```

### Example rules file `/etc/udev/hwdb.d/71-mouse-local.hwdb`
```bash
# === Evoluent vertical mouse ===
# (I'm disabling the 'back' mouse button)
evdev:input:b0003v1A7Cp0191e0110*
  KEYBOARD_KEY_90004=esc
  KEYBOARD_KEY_90006=esc
```


### Commands to load rules
```bash
# Make sure you figure out what eventXX should be for the chosen keyboard. Use `sudo evtest` to find out.
sudo systemd-hwdb update
sudo udevadm trigger /dev/input/event<XX>
```

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE3Njg0MzcyNDgsLTE4NzU3NjY1MjQsLT
c4MTk2MjM4MywtMTEyMjY3NDYwMCwyODE1MTc1NDhdfQ==
-->