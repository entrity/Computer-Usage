## Mouse config with xinput

<details><summary>Invert axes, remap buttons</summary>

```bash
# Get id of device
xinput list # ...we learn the device id is 18
# Get device details (fluff)
xinput list 18
# Get properties
xinput list-props 18
xinput list-props 18 | grep Matrix
# 1 0 0 0 1 0 0 0 1 # case normal
# -1 0 1 0 -1 1 0 0 1 # case inverted
xinput set-prop 18 144 -1 0 1 0 -1 1 0 0 1

# Figure out which button ids are left and right clicks
xinput test 18 # ...then click and watch the terminal
# Swap my left and right buttons
xinput set-button-map 18 3 2 1 4 5 6 7
```
</details>
