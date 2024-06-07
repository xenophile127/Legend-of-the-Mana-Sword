# Colorizing Legend of the Mana Sword

Every fan-made Game Boy Color (GBC) conversion has gotten criticism about color choices. Legend of the Mana Sword (LotMS) is being colorized with the goal of allowing relatively non-technical people to make whatever changes they like. However, colorization is currently at a very early stage.

## Setup
You *will* need to be able to assemble the source. The main requirements are a *nix style CLI with `make`, and [RGBDS](https://rgbds.gbdev.io/).

## Game Boy Color Picker

The `pal` directory contains all the palettes used, stored in `.pal` files. The `.pal` files each contain four sixteen-bit little-endian BGR colors. That format is also used by [Game Boy Color Picker](https://github.com/xenophile127/GameBoyColorPicker)'s `.sav` files.

You can use Game Boy Color Picker anywhere Legend of the Mana Sword's color port can run to choose colors, or to view the colors in a `.pal` file. Viewing is hopefully as easy as renaming `<something>.pal` to `GBColorPicker.sav` and replacing the existing `GBColorPicker.sav` before running `GBColorPicker.gb`. Colors can then be edited, `GBColorPicker.gb` closed, and `GBColorPicker.sav` can be moved (or copied) over whichever `.pal` file you like.

> **Note:** Most emulators and flash cartridges will create `.sav` files that are much larger than necessary. Only the first eight bytes are used, but it is safe to add `.pal` files of any size--everything after the first eight bytes will be ignored.

After changing `.pal` files you will need to run `make color` to build a file named `rom.gb` which can be run on any Game Boy Color or Game Boy Advance emulator, or on real hardware using a Game Boy flash cartridge.

> **Note:** Game Boy Advance flash cartridges that use Goomba Color to run Game Boy Color games are unlikely to work. While Goomba Color is an impressive piece of engineering, it makes accuracy compromises.

## Organization of the `pal` directory

Currently there are three directories within `pal`:
1. **`init` -** The main palette(s). Contains four sub directories, each of which contains eight background (`bgp`) `.pal` files (only `bgp0.pal` is currently used) and eight sprite (`obj`) `.pal` files.:
    - **`blind` -** Used when inflicted with the status effect Blind (shortened to "Dark" in the original Final Fantasy Adventure and Mystic Quest localizations). These palettes mimic the effect as rendered on GBC's BIOS compatability colorization, with Legend of the Mana Sword's chosen palette. That means backgrounds are all black except normally black areas are white, and sprites are either unmodified (such as the player) or all black except normally black areas are replaced with either dark red or dark blue (depending on the usually used palette). These could be customized with dark gray or white used instead of dark blue/red for sprites, or the background could have all colors dimmed instead of made completely black.
    - **`damage` -** Used for boss' flash that indicates when they take damage. Most of these are identical to the default palettes with the exception or `obj5.pal`, `obj6.pal`, and `obj7.pal`. Only `obj5.pal` is currently used for bosses, but bosses will be free to use all three of these, and some bosses will use other ones. Currently these mimic GBC auto-colorization of Legend of the Mana Sword, with dark blue where black would normally be, and the other colors black. Any number of boss flash effects could be done by changing these: for instance, Secret of Mana's white flash. Background palettes are also included in case a full screen flash is desired when a boss is hit.
    - **`flash` -** Used for full screen flashes, triggered either by a script command or as a part of some bosses' death effect. Once again, currently patterned off how Legend of the Mana Sword looks when playing on GBC with auto-colorization. These could be changed in any number of ways, including making them less contrasting, or eliminating them for a "no flash" patch by copying the files from `pal/normal`.
    - **`normal` -** What is used most of the time. Currently--in addition to `bgp0.pal`:
        * `obj0.pal` is used for the player, some NPCs, and enemies.
        * `obj1.pal` is used for the player's attacks, including spells (except for Ice).
        * `obj2.pal` is used for the snowmen created by using the Ice spell and similar items, and ice attacks by the player and enemies. Right now this is the sprite palette with the most consistency: very few things use it, and all of them are ice/snow related. Changing it to use dark blue instead of black--or something else that fits ice/snow--is possible.
        * `obj3.pal` is used for most companions/followers that join you and their attacks.
        * `obj4.pal` is used for enemies' attacks.
        * The last three sprite palettes are used for NPCs, enemies, and bosses.
2. **`line-effects` -** Contains a small number of palettes used for special effects:
    * New Game intro scroll "vignette" fade effect. These can be replaced to change the three steps of the fade. For instance, the fade can be disabled completely by copying `pal/init/normal/bgp0.pal` over all three of the `intro-scroll?.pal` files.
    * Ending credits "letterbox" effect. This serves to black out the top 16 pixels of the screen for the ending credits. Recommended to keep this as is.
    * Shutter effect. Used when selecting a save game to continue, to transition from one map to another, and when displaying the in-game maps. All four colors in this palette should be the same, but it can be used to change the effect from white to black, or any other color you may like.
    * Status bar effect. Used by the status bar at the bottom of the screen that shows HP, MP, Lucre, and the stamina gauge. At this point there are some visual glitches related to changing this.
3. **`sgb` -**  Contains palettes used during the credits and end screen on Super Game Boy.
> **Note:** Super Game Boy support is disabled when assembling with Game Boy Color/Advance support with `make color`.
