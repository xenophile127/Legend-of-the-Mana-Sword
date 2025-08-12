# Colorizing Legend of the Mana Sword

Every fan-made Game Boy Color (GBC) conversion has gotten criticism about color choices. Legend of the Mana Sword (LotMS) is being colorized with the goal of allowing relatively non-technical people to make whatever changes they like. However, colorization is currently at an early stage.-

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
1. **`00` -** The main palette(s), loaded at startup. Contains four sub directories, each of which contains eight background (`bgp`) `.pal` files and eight sprite (`obj`) `.pal` files. All sprite palette loading is now done dynamically so the `obj` pal files are obsolete. Currently the first four `bgp` files are loaded at startup but will be replaced if a boss is loaded.

    Background palettes are planned to eventually be loaded dynamically as well but for now these palettes are in use:
    - `bgp0.pal` for windows and line effects,
    - `bgp1.pal` is the default if a metatile has not been given specific colors. It is set to the colors that Mystic Quest used when running on a GBC.
    - `bgp2.pal` is two shades of green, black, and white. Currently this is the same as `bgp1.pal` but semantically use of this palette is for objects that should be green even if a different default palette is set.
    - `bgp3.pal` is set to the old LotMS Lazy DX colors, green, blue, black, and white. This is used mostly for things like water and sky that greatly benefitted from having blue in the palette.
    - `bgp4.pal` is set to two shades of brown, black, and white. It is a pretty commonly used palette from the GBC BIOS. This palette is currently used very sparingly with the only two uses being the trees in the Mana Land (including the Mana Tree) and most of the final "The End" screen.
    - `bgp5.pal` is set to two shades of blue, black, and white. The darker shade of blue is the same as `bgp3.pal`. The lighter shade of blue is commonly used by the GBC BIOS for sprites (not backgrounds). This is currently used for waterfalls and snow drifts.
    - `bgp6.pal` is unused.
    - `bgp7.pal` is unused.

    The file `pal/palette_list.inc` has an entry that causes this to be compiled in. Originally most colorization was going to be done with full palette sets like this loaded with script commands, but that is no longer the plan.
3. **`attack`-** Contains palettes for each spell, item, and weapon that Hero can have. The file `pal/attack/palette_map.inc` needs to have an entry for each. Each entry specifies the directory that contains the palettes needed: `blind.pal`, `damage.pal`, `flash.pal`, and `main.pal`.

    These are also used by the `sCREATE_EFFECT` script command.
4. **`boss`-** Complete palette sets for each boss, including both sprites and backgrounds. Currently the `obj0.pal` files are not loaded, and the `obj1.pal` will be overwritten by any player attack. If a companion is present for a boss fight then the colors in `obj3.pal` will be used for them. Other than those, all other sprite palettes (`obj2.pal`, `obj4.pal`, `obj5.pal`, `obj6.pal`, and `obj7.pal`) can be used.

    Bosses are mapped to palettes in `src/data/boss/metasprites.asm`. It shouldn't be necessary to edit that but more advanced custom boss colorizations can be achieved by doing so.
    Each boss directory should have a `comments.txt` file with information specific to that boss, such as which palettes are being used and for what.
5. **`hero`-** Palettes for each of the negative status effects that Hero can get, except Blind which is handled very differently. It contains four directories:
    - **`hero` -** Used when you have no negative status effect.
    - **`moogle` -** Used when you have the Moogle status effect. This is the lowest priority of the three.
    - **`poison` -** Poison is the highest priority of the three status effects. It will be used even if you have Stone or Moogle.
    - **`stone` -** Used when you are petrified with Stone. Higher priority than Moogle but lower than Poison.
  
    Each of these directories contains four `.pal` files: `blind.pal`, `damage.pal`, `flash.pal`, and `main.pal`. They are covered in more detail by the section on the `npc` folder. To match the original behavior, all except `flash.pal` must be identical.
    
    The colors used when riding Chocobo or Chocobot use palettes from their companion NPCs in the `pal/npc` directory.
    > 💡**Note:** There is no `.inc` list in this directory because these cannot be moved without editting assembly.
6. **`line-effects` -** Contains a small number of palettes used for special effects:
    * New Game intro scroll "vignette" fade effect. These can be replaced to change the three steps of the fade. For instance, the fade can be disabled completely by copying `pal/init/normal/bgp0.pal` over all three of the `intro-scroll?.pal` files.
    * Ending credits "letterbox" effect. This serves to black out the top 16 pixels of the screen for the ending credits. Recommended to keep this as is.
    * Shutter effect. Used when selecting a save game to continue, to transition from one map to another, and when displaying the in-game maps. This can be used to change the effect from white to black, or any other color you may like.
      > 💡**Note:** All four colors in this palette should be the same as it uses the area of memory that contains the status bar.
    * Status bar effect. Used by the status bar at the bottom of the screen that shows HP, MP, Lucre, and the stamina gauge. At this point there are some visual glitches related to changing this.
7. **`map/obj` -** Contains palettes for the flashing marker in the in-game map.
8. **`menu/obj` -** Contains palettes shared by both the menu hand pointers, and to the trashcan used in the `ITEM` and `EQUIP` menus.
9. **`npc` -** The file `pal/npc/palette_map.inc` has an entry for every distinct NPC in the game, though some NPCs (like shop keepers) are internally identical. Each entry indicates which palette set directory to load when that NPC is loaded. Palette sets can be reused for multiple NPCs but there is no space savings to doing so. Each line in this file is commented to indicate which NPC it affects, but when in doubt, test.

   Each palette set directory within `pal/npc` contains four `.pal` files:
    * `main.pal` are the colors you will see most of the time.
    * `blind.pal` is used when the player is afflicted with the Blind effect. If you do not wish an NPC to change appearance under the Blind status effect, make this identical to the `main.pal`.
    * `damage.pal` is used whenever a boss takes damage. This should only ever be used for companions (Watts, Lester, etc.) who accompany you to boss fights. Originally these characters would blink when the boss was damaged, but unless duplicating the original behavior is your goal this should be the same as `main.pal`.
    * `flash.pal` are the colors shown when the full screen flash effect is used.
  
    > 💡**Note:** Companion's projectile attacks will use the same color palette set they do. That includes the when the Blind effect is active.
    
    > 💡**Note:** For enemies the color palette is also used for the explosion effect when defeated and for any chests dropped. Chest colors especially may be worth considering when choosing a palette for enemies.
    
    > 💡**Note:** Objects are restricted by hardware to three colors. The first color in each of these `.pal` files is unused (transparent).
10. **`projectile` -** Projectiles are what any attacks--including melee attacks like swords--used by NPCs (including enemies and companions) and bosses are called. However, only non-boss enemy projectiles have palettes here. The file `pal/projectile/palette_map.inc` needs an entry for each enemy projectile with the directory to load `.pal` files from.
    > ⚠️ **Note:** Technical limitations make supporting two types of enemy projectiles on one screen challenging. At the moment there are times where both are mapped to the same palette.
11. **`sgb` -**  Contains palettes used during the credits and end screen on Super Game Boy.
    > 💡**Note:** Aside from loading a border at startup Super Game Boy support is disabled when assembling with Game Boy Color/Advance support with `make color`.

## Backgrounds
Background colorization is currently very primative. The palettes that have been added are documented in the `pal` section of this document under `00`. Currently there is a limit of seven palettes for colorizing bagrounds (with one of the eight hardware palettes reserved for windows and line effects, and line effects will cause visual glitches if you use this). The list is also in `src/include/bgp_attributes.inc` where constants are defined.

Mapping background graphics to those palettes is done in `src/data/metatiles.asm`. Each entry in that file is for a metatile which ties four 8x8 pixel tiles--each of which can be given their own palette-into a logical 16x16 pixel tile. For convenience sake the macro that assembles this file will accept one palette constant (which will be duplicated four times) or four.

End-to-end adding and using a background palette should start in `pal/00` (with the new palette(s) copied into bosses in the `boss` directory), touch `src/include/bgp_attributes.inc`, and then can be used by adding or changing constants in `src/data/metatiles.asm`.
