# MAME

Ubuntu repositories come with a mame.

_NB:_ The version of MAME you have is important. Roms for a different version may work but are less likely to work. Run `mame -help` to see the **version** of your MAME. Look for roms with the same version.

## Run a ROM

Put a rom zip file `$FILE` in dir `$DIR`.
Start mame with any of the following

```bash
mame -rompath $DIR $FILE
mame -rompath $DIR $DIR/$FILE
mame -rompath $DIR $ROMNAME
mame -rompath $DIR
```

## Commands (in game)
- add coins <kbd>5</kbd>, <kbd>6</kbd>
- close <kbd>Esc</kbd>
- Some controls, like volume <kbd>`</kbd>
- Menu <kbd>Ctrl</kbd>+<kbd>Tab</kbd>
- Pause <kbd>p</kbd>
- Save <kbd>Shift</kbd>+<kbd>F7</kbd>
- load  <kbd>F7</kbd>

## Configure controls

Run `mame` with no arguments. Then choose the menu **Configure Options > General Inputs > Player 1 Controls**

Or edit `$HOME/.mame/cfg/default.cfg`
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTc3ODE2NDU4NywtMzI1MzEwOTYyLDE0Mj
MzNTU5NTQsMTA2MDI2ODkyOSw2ODE3MzIyNzFdfQ==
-->

## Help

	https://gaming.stackexchange.com/questions/263921/mame-shows-the-selected-game-is-missing-one-or-more-required-rom-or-chd-image

> MAME will show a lot of games as "available" that aren't really. I think they mean "compatible" more than "available" here. You can run MAME with the name of a ROM to start right into that game, or fail immediately if it isn't present.

> You might start with one of the publicly available ROMS on the MAME website, since those are pretty much guaranteed to work. Files you find on ROM sites are a bit more suspect.

> For some games (like Street Fighter 3 Third Strike), a .CHD file is required in addition to the ROM. There are rules about where this CHD file lives, you can read up on this at the FAQ.

> NeoGeo games (Like King of Fighters '97) require neogeo.zip in your roms folder, but it seems like you've done that already.

> Note that MAME is very picky about ROM file names - they must match exactly what MAME expects them to be. If you've renamed the files, or they downloaded with the wrong names, you'll need to fix them. mame -listfull can tell you the game name and the expected ROM name that matches, although you'll probably want to pipe this to grep or similar due to the large number of supported ROMs.
