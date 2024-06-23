# Colorizing Legend of the Mana Sword

Every fan-made Game Boy Color (GBC) conversion has gotten criticism about color choices. Legend of the Mana Sword (LotMS) is being colorized with the goal of allowing relatively non-technical people to make whatever changes they like. However, colorization is currently at a very early stage.

## Setup
You *will* need to be able to assemble the source. The main requirements are [RGBDS](https://rgbds.gbdev.io/) and `make`. The color version of Legend of the Mana Sword is built with `make color`.
> 💡**Note:** LotMS is in the `lotms` branch of this fork of `FFA-Disassembly`.

## Game Boy Color Picker

The `pal` directory contains all the palettes used, stored in `.pal` files. The `.pal` files each contain four sixteen-bit little-endian BGR colors. That format is also used by [Game Boy Color Picker](https://github.com/xenophile127/GameBoyColorPicker)'s `.sav` files.

You can use Game Boy Color Picker anywhere Legend of the Mana Sword's color port can run to choose colors, or to view the colors in a `.pal` file. Viewing is hopefully as easy as renaming `<something>.pal` to `GBColorPicker.sav` and replacing the existing `GBColorPicker.sav` before running `GBColorPicker.gb`. Colors can then be edited, `GBColorPicker.gb` closed, and `GBColorPicker.sav` can be moved (or copied) over whichever `.pal` file you like.

> 💡**Note:** Most emulators and flash cartridges will create `.sav` files that are much larger than necessary. Only the first eight bytes are used, but it is safe to add `.pal` files of any size--everything after the first eight bytes will be ignored.

You may also be able to use the (unsuported) Windows utility [url=https://www.romhacking.net/utilities/1743/]GBC Palette Editor[/url] to view and edit `.pal` files, however GBC Palette Editor seems to expect `.pal` files to contain at least 32 colors and will give an error if any of the LotMS's included `.pal` files are opened, but `.pal` files created by GBC Palette Editor should work correctly with LotMS.

After changing `.pal` files you will need to run `make color` to build a file named `rom.gb` which can be run on any Game Boy Color or Game Boy Advance emulator, or on real hardware using a Game Boy flash cartridge.

> 💡**Note:** Game Boy Advance flash cartridges that use Goomba Color to run Game Boy Color games are unlikely to work. While Goomba Color is an impressive piece of engineering, it makes accuracy compromises.

## Organization of the `pal` directory

Currently there are five directories within `pal`:
1. **`00` -** The main palette(s), loaded at startup. Contains four sub directories, each of which contains eight background (`bgp`) `.pal` files (only `bgp0.pal` is currently used) and eight sprite (`obj`) `.pal` files.:
    - **`blind` -** Used when inflicted with the status effect Blind (shortened to "Dark" in the original Final Fantasy Adventure and Mystic Quest localizations).
      
        These palettes mimic the effect as rendered on GBC's BIOS compatibility colorization, with Legend of the Mana Sword's chosen palette. That means backgrounds are all black except normally black areas are white, and sprites are either unmodified (such as the player) or all black except normally black areas are replaced with either dark red or dark blue (depending on the usually used palette).

        These could be customized with dark gray or white used instead of dark blue/red for sprites, or the background could have all colors dimmed instead of made completely black.
    - **`damage` -** Used for the flash that indicates when a boss takes damage. Most of these are identical to the default palettes with the exception or `obj5.pal`, `obj6.pal`, and `obj7.pal`. Only `obj5.pal` is currently used for bosses, but bosses will be free to use all three of these, and some bosses will use more.

        Currently these mimic GBC auto-colorization of Legend of the Mana Sword, with dark blue where black would normally be, and the other colors black.

        Any number of boss flash effects could be done by changing these: for instance, Secret of Mana's white flash. Background palettes are also included in case a full screen flash is desired when a boss is hit.
    - **`flash` -** Used for full screen flashes, triggered either by a script command or as a part of some bosses' death effect. Once again, currently patterned off how Legend of the Mana Sword looks when playing on GBC with auto-colorization.

        These could be changed in any number of ways, including making them less contrasting, or eliminating them for a "no flash" patch by copying the files from `pal/normal`.
    - **`normal` -** What is used most of the time. In addition to `bgp0.pal` these sprite palettes are used:
        * `obj0.pal` is used for the player, some NPCs, and enemies.
        * `obj1.pal` is used for the player's attacks, including spells (except for Ice).
        * `obj2.pal` is used for the snowmen created by using the Ice spell and similar items, and ice attacks by the player and enemies. This palette is replaced from the `pal/npc/000/` directory when a snowman is created.
        * `obj3.pal` is used for most companions/followers that join you and their attacks. This palette is replaced with an entry from the `pal/npc/` directory whenever a companion joins (including when loading a game).
        * `obj4.pal` is used for enemies' attacks.
        * The last three sprite palettes are used for NPCs, enemies, and bosses. They are replaced with entries from the `pal/npc/` directory whenever NPCs are spawned. Bosses (except for Red Dragon) do not yet initialize palettes when they spawn so it may be possible for some bosses colors to be affected by recently encountered enemies.
2. **`01` -** Identical to `00` except `blind/obj05.pal`, `damage/obj05.pal`, and `normal/obj05.pal` use red instead of blue. This is used for the Red Dragon boss. (Blind is unused so far.)
3. **`line-effects` -** Contains a small number of palettes used for special effects:
    * New Game intro scroll "vignette" fade effect. These can be replaced to change the three steps of the fade. For instance, the fade can be disabled completely by copying `pal/init/normal/bgp0.pal` over all three of the `intro-scroll?.pal` files.
    * Ending credits "letterbox" effect. This serves to black out the top 16 pixels of the screen for the ending credits. Recommended to keep this as is.
    * Shutter effect. Used when selecting a save game to continue, to transition from one map to another, and when displaying the in-game maps. This can be used to change the effect from white to black, or any other color you may like.
      > 💡**Note:** All four colors in this palette should be the same as it uses the area of memory that contains the status bar.
    * Status bar effect. Used by the status bar at the bottom of the screen that shows HP, MP, Lucre, and the stamina gauge. At this point there are some visual glitches related to changing this.
4. **`npc` -** The file `pal/npc/palette_list.inc` has an entry for every distinct NPC in the game, though some NPCs (like shop keepers) are internally identical. Each entry indicates which palette set directory inside of `pal/npc/` to load when that NPC is loaded. Palette sets can be reused for multiple NPCs but there is no space savings to doing so. Each line in this file is commented to indicate which NPC it affects, but when in doubt, test.

   Each palette set directory within `pal/npc` contains four `.pal` files:
    * `main.pal` are the colors you will see most of the time.
    * `blind.pal` is used when the player is afflicted with the Blind effect. If you do not wish an NPC to change appearance under the Blind status effect, make this identical to the `main.pal`.
    * `damage.pal` is used whenever a boss takes damage. This should only ever be used for companions (Watts, Lester, etc.) who accompany you to boss fights. Originally these characters would blink when the boss was damaged, but unless duplicating the original behavior is your goal this should be the same as `main.pal`.
    * `flash.pal` are the colors shown when the full screen flash effect is used.
    > 💡**Note:** For enemies the color palette is also used for the explosion effect when defeated and for any chests dropped. Chest colors especially may be worth considering when choosing a palette for enemies.
    
    > 💡**Note:** Objects are restricted by hardware to three colors. The first color in each of these `.pal` files is unused (transparent).
6. **`sgb` -**  Contains palettes used during the credits and end screen on Super Game Boy.
    > 💡**Note:** Super Game Boy support is disabled when assembling with Game Boy Color/Advance support with `make color`.

## Changing palettes used

Adding palettes (instead of just changing the colors in an existing palette) is possible, but at an early stage. At this point most palettes are intended to load dynamically so palettes added and used by this message may be replaced with other palettes, such as when loading an NPC.

To add a Palettes:
1. Add a directory to `pal`. It is easiest to copy an existing one to get all the needed files and structure.
2. Add an entry to the end of `pal/palette_list.inc`. Copy the last entry, and use the directory name as the argument. This is a plain text file that gets included in the build. Comments can be added by using a semicolon (';').
> 💡**Note:** These directories do not need to be numbered, however when they are used they are reffered to by number according to their order in `pal/palette_list.inc`, so naming them with sequential numbers may be helpful.

Using a palette, either an existing one or one you just added, is done through the game's scripting system. The scripting system is a simple but powerful method of coding things that is used for everything from cutscenes, dialog, doors and teleporters that transport you to other rooms, and spawning NPCs, enemies, and bosses. You can change the colors of NPCs, enemies, or a boss by adding one command to the script that spawns them.

All scripts are contained in `src/scripts.asm`. The command `sLOAD_PALETTE` is used to change which palette is used. It takes one argument--a number that specifies which palette to load. This number corresponds with the order palettes are listed in `pal/palette_list.inc`.

To use `pal/01/` for Red Dragon three `sLOAD_PALETTE` commands were added:
1. `sLOAD_PALETTE 1` in `script_01a3` just before Red Dragon is spawned with `sSPAWN_BOSS 20`.
2. `sLOAD_PALETTE 0` `script_01a4` which is the script that runs when you leave the room, to restore the main palette.
3. `sLOAD_PALETTE 0` `script_01a5` which is run when Red Dragon is killed to, to restore the main palette right after the "Defeated Red Dragon!" message that is displayed to the player.

 > 💡**Note:** Scripts for rooms are always arranged sequentially in this order: entry, exit, last enemy killed.
