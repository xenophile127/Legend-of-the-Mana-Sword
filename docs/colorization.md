# Colorizing Legend of the Mana Sword

Every fan-made Game Boy Color (GBC) conversion has gotten criticism about color choices. Legend of the Mana Sword (LotMS) is being colorized with the goal of allowing relatively non-technical people to make whatever changes they like. However, colorization is currently at an early stage--currently all background graphics use a single palette.

## Setup
You *will* need to be able to assemble the source. The main requirements are [RGBDS](https://rgbds.gbdev.io/) and `make`. The color version of Legend of the Mana Sword is built with `make color`.

## Game Boy Color Picker

The `pal` directory contains all the palettes used, stored in `.pal` files. The `.pal` files each contain four sixteen-bit little-endian BGR colors. That format is also used by [Game Boy Color Picker](https://github.com/xenophile127/GameBoyColorPicker)'s `.sav` files.

You can use Game Boy Color Picker anywhere Legend of the Mana Sword's color port can run to choose colors, or to view the colors in a `.pal` file. Viewing is hopefully as easy as renaming `<something>.pal` to `GBColorPicker.sav` and replacing the existing `GBColorPicker.sav` before running `GBColorPicker.gb`. Colors can then be edited, `GBColorPicker.gb` closed, and `GBColorPicker.sav` can be moved (or copied) over whichever `.pal` file you like.

Color palettes can also be transferred to or from Game Boy Color Picker by using a hex editor to copy the first eight bytes of of a `.pal` file to or from `GBColorPicker.sav`.

> 💡**Note:** Most emulators and flash cartridges will create `.sav` files that are much larger than necessary. Only the first eight bytes are used, but it is safe to add `.pal` files of any size--everything after the first eight bytes will be ignored.

You may also be able to use the (unsuported) Windows utility [GBC Palette Editor](https://www.romhacking.net/utilities/1743/) to view and edit `.pal` files, however GBC Palette Editor seems to expect `.pal` files to contain at least 32 colors and will give an error if any of the LotMS's included `.pal` files are opened. The `.pal` files created by GBC Palette Editor should work correctly with LotMS but only the first four colors will be loaded.

After changing `.pal` files you will need to run `make color` to build a file named `rom.gb` which can be run on any Game Boy Color or Game Boy Advance emulator, or on real hardware using a Game Boy flash cartridge.

> 💡**Note:** Game Boy Advance flash cartridges that use Goomba Color to run Game Boy Color games are unlikely to work. While Goomba Color is an impressive piece of engineering, it makes accuracy compromises.

## Palette sets
Palettes almost always come in sets of four: `blind`, `damage`, `flash`, and `main`. Most of the time what is used will be the `main` palettes, but the other three are there to support special visual effects that LotMS uses:
- **`blind` -** Used when inflicted with the status effect Blind (shortened to "Dark" in the original Final Fantasy Adventure and Mystic Quest localizations).
      
    On the original Gameboy this effect affected the background and NPC sprites. For the backgrounds black was replaced with white and all other shades were replaced with black. For NPC sprites black was replaced with dark gray and the other shades were replaced with black.

    With GBC's BIOS compatibility colorization and Legend of the Mana Sword's chosen palette, the NPC sprites would use a blue instead of dark gray.

    The palette used by the player, attacks (by player, companions, and enemies) would be unaffected.

    When colorizing these choices can be made that affect not only aesthetics, but also the game's difficulty. For instance, enemy projectiles could also be given a dark palette making them much harder to track.
- **`damage` -** Used for the flash that indicates when a boss takes damage. For most palette sets these won't ever be used, but for palette sets used during bosses they are very important.

    Any number of boss flash effects could be done by changing these: for instance, Secret of Mana's white flash. Background palettes are also included in case a full screen flash is desired when a boss is hit.
- **`flash` -** Used for full screen flashes, triggered either by a script command or as a part of some bosses' death effect. Currently these are usually patterned off the original Gameboy effect: black becomes white and all other colors become black. Some bosses use customized palettes for their flashing effects.
    These could be changed in any number of ways, including making them less contrasting, or eliminating them for a "no flash" patch by copying the files from `pal/normal`.
- **`main` -** What is displayed most of the time. If you aren't afflicted by the Blind effect, and the screen isn't flashing due to a cutscene or boss, then these are the palettes used.

## Organization of the `pal` directory

Currently there are these subdirectories within `pal`:
1. **`00` -** The main palette(s), loaded at startup. Contains four sub directories, each of which contains eight background (`bgp`) `.pal` files (only `bgp0.pal` is currently used) and eight sprite (`obj`) `.pal` files. Most palette loading is now done dynamically so currently the only portions of this that should have any effect are the `bgp0.pal` files.

    The file `pal/palette_list.inc` has an entry that causes this to be compiled in. Originally most colorization was going to be done with full palette sets like this loaded with script commands, but that is no longer the plan.
2. **`attack`-** Contains palettes for each spell, item, and weapon that Hero can have. The file `pal/attack/palette_map.inc` needs to have an entry for each. Each entry specifies the directory that contains the palettes needed: `blind.pal`, `damage.pal`, `flash.pal`, and `main.pal`.

    These are also used by the `sCREATE_EFFECT` script command.
3. **`boss`-** Complete palette sets for each boss, including both sprites and backgrounds. Currently the `obj0.pal` files are not loaded, and the `obj1.pal` will be overwritten by any player attack. If a companion is present for a boss fight then the colors in `obj3.pal` will be used for them. Other than those, all other sprite palettes (`obj2.pal`, `obj4.pal`, `obj5.pal`, `obj6.pal`, and `obj7.pal`) can be used.

    Bosses are mapped to palettes in `src/data/boss/metasprites.asm`. It shouldn't be necessary to edit that but more advanced custom boss colorizations can be achieved by doing so.
4. **`hero`-** Palettes for each of the negative status effects that Hero can get, except Blind which is handled very differently. It contains four directories:
    - **`hero` -** Used when you have no negative status effect.
    - **`moogle` -** Used when you have the Moogle status effect. This is the lowest priority of the three.
    - **`poison` -** Poison is the highest priority of the three status effects. It will be used even if you have Stone or Moogle.
    - **`stone` -** Used when you are petrified with Stone. Higher priority than Moogle but lower than Poison.
  
    Each of these directories contains four `.pal` files: `blind.pal`, `damage.pal`, `flash.pal`, and `main.pal`. They are covered in more detail by the section on the `npc` folder. To match the original behavior, all except `flash.pal` must be identical.
    
    The colors used when riding Chocobo or Chocobot use palettes from their companion NPCs in the `pal/npc` directory.
    > 💡**Note:** There is no `.inc` list in this directory because these cannot be moved without editting assembly.
5. **`line-effects` -** Contains a small number of palettes used for special effects:
    * New Game intro scroll "vignette" fade effect. These can be replaced to change the three steps of the fade. For instance, the fade can be disabled completely by copying `pal/init/normal/bgp0.pal` over all three of the `intro-scroll?.pal` files.
    * Ending credits "letterbox" effect. This serves to black out the top 16 pixels of the screen for the ending credits. Recommended to keep this as is.
    * Shutter effect. Used when selecting a save game to continue, to transition from one map to another, and when displaying the in-game maps. This can be used to change the effect from white to black, or any other color you may like.
      > 💡**Note:** All four colors in this palette should be the same as it uses the area of memory that contains the status bar.
    * Status bar effect. Used by the status bar at the bottom of the screen that shows HP, MP, Lucre, and the stamina gauge. At this point there are some visual glitches related to changing this.
6. **`map/obj` -** Contains palettes for the flashing marker in the in-game map.
7. **`menu/obj` -** Contains palettes shared by both the menu hand pointers, and to the trashcan used in the `ITEM` and `EQUIP` menus.
8. **`npc` -** The file `pal/npc/palette_map.inc` has an entry for every distinct NPC in the game, though some NPCs (like shop keepers) are internally identical. Each entry indicates which palette set directory to load when that NPC is loaded. Palette sets can be reused for multiple NPCs but there is no space savings to doing so. Each line in this file is commented to indicate which NPC it affects, but when in doubt, test.

   Each palette set directory within `pal/npc` contains four `.pal` files:
    * `main.pal` are the colors you will see most of the time.
    * `blind.pal` is used when the player is afflicted with the Blind effect. If you do not wish an NPC to change appearance under the Blind status effect, make this identical to the `main.pal`.
    * `damage.pal` is used whenever a boss takes damage. This should only ever be used for companions (Watts, Lester, etc.) who accompany you to boss fights. Originally these characters would blink when the boss was damaged, but unless duplicating the original behavior is your goal this should be the same as `main.pal`.
    * `flash.pal` are the colors shown when the full screen flash effect is used.
  
    > 💡**Note:** Companion's projectile attacks will use the same color palette set they do. That includes the when the Blind effect is active.
    
    > 💡**Note:** For enemies the color palette is also used for the explosion effect when defeated and for any chests dropped. Chest colors especially may be worth considering when choosing a palette for enemies.
    
    > 💡**Note:** Objects are restricted by hardware to three colors. The first color in each of these `.pal` files is unused (transparent).
9. **`projectile` -** Projectiles are what any attacks--including melee attacks like swords--used by NPCs (including enemies and companions) and bosses are called. However, only non-boss enemy projectiles have palettes here. The file `pal/projectile/palette_map.inc` needs an entry for each enemy projectile with the directory to load `.pal` files from.
    > ⚠️ **Note:** Technical limitations make supporting two types of enemy projectiles on one screen challenging. At the moment there are times where both are mapped to the same palette.
10. **`sgb` -**  Contains palettes used during the credits and end screen on Super Game Boy.
    > 💡**Note:** Aside from loading a border at startup Super Game Boy support is disabled when assembling with Game Boy Color/Advance support with `make color`.
