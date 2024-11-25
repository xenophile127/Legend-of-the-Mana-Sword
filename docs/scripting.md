# Scripting

The scripting system is a simple but powerful method of coding things that is used for everything from cutscenes, dialog, doors, stairs, teleporters, switches, and spawning NPCs, enemies, and bosses. Legend of the Mana Sword makes very few changes to the scripting system its self, but many of the changes and bug fixes in LotMS are implemented wholly or partially by modifying scripts.

All scripts are contained in `src/scripts.asm`. Although script commands are implemented with [RGBDS](https://rgbds.gbdev.io/) macros no actual assembly knowledge is required to make changes. However, you will need `RGBDS` and `make`. The main details you should know are that everything after a semicolon (`;`) on a line is a comment, and hexadecimal values start with a dollar sign (`$`).

Many of the script commands are for controlling NPCs, the PC, and companion characters. Most of these have essentially identical commands for each. For NPCs there can be up to seven controllable NPCs in a scene. In practice there is only one scene that uses three NPCs and none that use more than that. NPCs are numbered in the order they are spawned.

Originally LotMS used [Mystic Editor](https://github.com/arathron123/mystic-editor) for script editing. Due to other changes--especially related to maps--LotMS is no longer compatible with `ME`.

 > 💡**Note:** Scripts for rooms are always arranged sequentially in this order: entry, exit, last enemy killed.

## Script commands

Internally script commands are a byte (number between zero and 255). They are presented here in that ordering to aid writing this documentation. It is also a fairly good order to learn them.

### 00 - sEND
Used to end each script and to end loops.

### 01 - sELSE
Used in if else logic.

### 02 - sCALL script
Run another script before continuing.

### 03 - sLOOP times
Repeat the code that follows (until the next sEND command) some number of times.

### 04 - sMSG
Starts the dialog system. Dialog windows are 18 characters wide with no auto-wrap. They are double-spaced and used for up to three lines of text at a time (six lines high total). In addition to upper and lower case letters, numbers, punctuation, and symbols used for items and equipment, sMSG lines can contain control codes:
- `<00>` ends the sMSG command. You will also frequently see them ended with a `$00` outside of the quotation marks.
- `<10>` opens the dialog window. It is not opened automatically at the beginning of the sMSG command. Instead you have full control over it.
- `<11>` closes the dialog window. The window can be left open after the sMSG command finishes to be closed by a future sMSG command. This is commonly used for delays, sound effects, and character movement in cutscenes.
- `<12>` pauses and waits until the player pushes any button.
- `<13>` asks the player a yes/no question. See for instance the Battle Axe shop.
- `<BOY>` prints the Hero's name. This can be from one to four characters long.
- `<GIRL>` prints the Heroine's name. One to four characters long.
- `\n` move the insertion point to the beginning of the next (double-spaced) line down.
- `<1b>` clear the dialog window and reset the insertion point back to the top left.
- `<1c>` move insertion point one character to the right.
- `<1d>` move insertion point one character to the left.
- `<1e>` move insertion point one line up. This can be used to print lines single-spaced.
- `<1f>` move insertion point one line down.

### 05 - sLOAD_PALETTE number
Added for colorization. Usage is not finalized.

### 08 - sIF_FLAG
Test one or more true/false flags--the game has 128 boolean variables. If all conditions are matched then the following code--up to the next sENDIF or sELSE--is executed. If not then if there is an sELSE then that is executed. Variables span from `wScriptFlags.0` to `wScriptFlags0F.7`. Their condition can be inverted by prepending an exclamation point (`!`). Multiple variables can be tested by comma (`,`) separating them.

### 09 - sIF_EQUIPED
Check whether one or more items, spells, or equipment are currently selected. This checks weapons equipped to the A button, items and spells selected for B button use, and the Armor, Helmet, and Shield currently equipped.

### 0a - sIF_INVENTORY
Check whether one or more items, spells, or equipment are possessed by the player.

### 0b - sIF_TRIGGERED_ON_BY
Used by scripts for doors, stairs, switch plates and similar. These are called with the "collision flags" for the player, NPC, or enemy (but not projectiles) when they are entered.

These values have a type in the high nibble and the low nibble controls more fine-grained interactions. The types currently in use are:
- 8 - Used for the player traveling between rooms (`$81`) and empty chests dropped by enemies (`$87`). This is also for any NPCs that run a script (rather than enemies which damage the player) when touched.
- 9 - This is for enemies. There are two unused scripts that use this.
- a - Inanimate snowmen and open chests are `$a9`. These are commonly used in pushing puzzles.
- c - The player. Normal state is `$c9` but during damage knock-back/invulnerability it changes to `$c1`. There were bugs in the original releases due to not matching `$c1`.
- e - Chocobo is `$e1`.
- f - Chocobot is `$f1` and Chocoboat (Chocobot on water) is `$f5`.

### 0c - sIF_TRIGGERED_OFF_BY
See sIF_TRIGGERED_ON_BY.

### ?0 - sNPC_1_STEP_FORWARD to sNPC_7_STEP_FORWARD
The character takes a step in the direction they are facing. Their final position is eight pixels forward from their starting position. The engine has a limited ability to continue the script while the animation takes place.

### ?1 - sNPC_1_STEP_BACKWARDS to sNPC_7_STEP_BACKWARDS
The character takes a step away from the direction they are facing. Otherwise similar to the STEP_FORWARD commands.

### ?4 - sSET_NPC_1_DIRECTION_UP to sSET_NPC_7_DIRECTION_UP
Turn the character to face North without moving.

### ?5 - sSET_NPC_1_DIRECTION_DOWN to sSET_NPC_7_DIRECTION_DOWN
Turn the character to face South without moving.

### ?6 - sSET_NPC_1_DIRECTION_RIGHT to sSET_NPC_7_DIRECTION_RIGHT
Turn the character to face East without moving.

### ?7 - sSET_NPC_1_DIRECTION_LEFT to sSET_NPC_7_DIRECTION_LEFT
Turn the character to face West without moving.

### ?8 - sDEL_NPC_1 to sDEL_NPC_7
Remove the character. Its numbered slot is reused for the next character added.

### ?9 - sSET_NPC_1_POSITION x, y to sSET_NPC_7_POSITION x, y
Instantly move the character. Usually used to position characters while the screen is faded to black. The coordinate system used is an eight pixel grid, 20 wide by 16 tall. Characters can be positioned offscreen to walk on smoothly (instead of suddenly appearing) by using negative positions -2 for North or West, 22 East, or 18 West.

### ?a - sNPC_1_WALK_SPEED_4 to sNPC_7_WALK_SPEED_4
Sets the character's walk delay to 4. This means that when walking the engine will move the character once every four frames. Characters normally move two pixels per move, so this means they will move at an average of half a pixel per frame, and complete a walk command in 16 frames.

Whether this makes them faster or slower depends on the default value for the character's in `src/data/stats.asm`.

### ?b - sNPC_1_WALK_SPEED_DEFAULT to sNPC_7_WALK_SPEED_DEFAULT
Sets the character's walk delay back to whatever is in their entry in `src/data/stats.asm`.

### 80 - sPLAYER_STEP_FORWARD
See the NPC command.

### 81 - sPLAYER_STEP_BACKWARDS
See the NPC command.

### 84 - sSET_PLAYER_DIRECTION_UP
See the NPC command.

### 85 - sSET_PLAYER_DIRECTION_DOWN
See the NPC command.

### 86 - sSET_PLAYER_DIRECTION_RIGHT
See the NPC command.

### 87 - sSET_PLAYER_DIRECTION_LEFT
See the NPC command.

### 88 - sSET_FAST_MOVEMENT
Sets the PC's movement speed to two pixels per frame. This is the same speed used when riding a chocobo.

This is the first instance  that the PC's command is different from the commands for NPCs and companions.
NPCs and companions have a delete command instead. There is no way to remove the PC--in cutscenes that do not show the PC it is moved to a position off-screen.

### 89 - sCLEAR_FAST_MOVEMENT
Sets the PC's movement speed to one pixel per frame.

### 8a - sSET_PLAYER_POSITION x, y
See the NPC command.

Since the PC cannot be removed this is commonly used to hide offscreen.

### 8b - sPLAYER_JUMP argument
Used to animate the player jumping in an arc. The argument controls what table values are used for the movement. Values from $20 to $e0 have valid table entries. There is some sort of pattern every $20 values.

Only two argument values are actually used: 104 ($68) and 112 (0x70).

### 8f - sWAIT_WHILE_MOVEMENT
Waits for any character movement to finish. This was originally unused but a script issue in the experimental Legend of the Mana Sword color version has now been fixed by using it.

### 90 - sFOLLOWER_STEP_FORWARD
See the NPC command.

### 91 - sFOLLOWER_STEP_BACKWARDS
See the NPC command.

### 94 - sFOLLOWER_DIRECTION_UP
See the NPC command.

### 95 - sFOLLOWER_DIRECTION_DOWN
See the NPC command.

### 96 - sFOLLOWER_DIRECTION_RIGHT
See the NPC command.

### 97 - sFOLLOWER_DIRECTION_LEFT
See the NPC command.

### 98 - sFOLLOWER_DELETE
Removes the companion not just from the current screen, but as a partner as well.

### 99 - sFOLLOWER_SET_POSITION x, y
See the NPC command.

### 9a - sFOLLOWER_WALK_SPEED_4
See the NPC command.

### 9b - sFOLLOWER_WALK_SPEED_DEFAULT
See the NPC command.

### 9c - sGIVE_FOLLOWER number
A companion NPC joins you. It removes the first NPC (equivalent to sDEL_NPC_1) and spawns the follower specified. The followers are:
- 1 - Fuji
- 2 - Traveler (Mysterious Man)
- 3 - Watts
- 4 - Bogard
- 5 - Duke/Amanda
- 6 - Lester
- 7 - Marcie
- 8 - Chocobot
- 9 - Chocobo

### a0 - sPLAYER_ON_CHOCOBO
The PC is replaced with a controllable chocobo.

### a1 - sPLAYER_ON_CHOCOBOT
The PC is replaced with the Chocobot.

### a2 - sPLAYER_ON_CHOCOBOT_WATER
The PC is replaced with the Chocoboat.

### a3 - sPLAYER_IN_MINECART
The PC is shown in a minecart.

### a4 - sSET_PLAYER_NORMAL_SPRITE
The PC is reverted to the usual form.

### a5 - sSET_PLAYER_HURT_SPRITE
Shows the PC with a surprised/falling sprite. This is only one forward facing frame, not animated.

### a6 - sSET_PLAYER_LAYDOWN_SPRITE
Shows the PC lying on the ground with an injured sprite. This is only one forward facing frame, not animated.

### a9 - sCHECK_ALLOWED_TO_OPEN_MAP
Sets script flag `wScriptFlags0F.7` as long as the current map is not 1, 14, or 15. See sOPEN_MAP.

### aa - sCLEAR_PLAYER_ATTACK
Stops any in-progress attack from the PC and sets the PC to the normal standing frame. This was originally unused but has now been used as part of a fix for confusing animation states at the end of the Jackal battle.

### ab - sCLEAR_ROOM_HISTORY
Used to re-initialize the tracking of which screens have had all the enemies defeated.

### ac - sOPEN_MAP
Opens the in-game map. Used from special script 001f that is run when Map is selected from the menus.

### ad - sWAIT_MAP_CLOSE
Waits until the player dismisses the in-game map. See sOPEN_MAP.

### ae - sCLOSE_MAP
Closes the in-game map. See sOPEN_MAP.

### af - sCHANGE_INTO_EMPTY_CHEST
Treasure chests are implemented as NPCs that run a script when they are touched. The scripts typically attempt to give the player an item and then check `wScriptFlags.5` to see if the player had enough inventory space. If so they run this command before doing anything else.

### b0 - sSET_ROOM_TILE tile, y, x
Replaces a metatile (16x16 pixel area of background graphics)  on the current screen with the new tile. The coordinate system is a 16x16 pixel gird with 0,0 as the upper left and 9,7 as the lower right. This has also been used successfully to fill in offscreen tiles before sSHAKE_SCREEN commands by using y=10 for the right side and y=15 for the left side.

### b6 - sLETTER_BOX_EFFECT
Used during the ending credits to black out the top and bottom 16 pixels of the screen for a more "cinematic" effect. Once you run this the effect cannot be removed.

There is some Super Game Boy code added to run when this command is executed. It loads a palette for the ending, switches to using SGB fades for sFADE_TO_NORMAL and sFADE_TO_BLACK, and starts a counter to load additional color effects for the final End screen.

### b7 - sDEFAULT_EFFECT
This was an unused script command that had most of the code to remove the letterbox effect (see sLETTER_BOX_EFFECT) and return to normal. For Embers of Mana it has been hacked to do just that. Currently not changed in Legend of the Mana Sword.

### ba - sCREATE_EFFECT effect, x, y
Creates a special effect. Known effects are: $08 for the healing pond effect, $2c for a fire effect, and $10 for an explosion effect.

Internally this uses the same data as the player's attacks. As these animate they progress through the table in jumps of 16. $08 is the beginning of the Cure spell. $2c is the third part of the Fire spell. $10 is the second part of an attack animation that normally has one step that does nothing.

### bc - sFADE_TO_NORMAL
Fades back in from a sFADE_TO_BLACK or a sFADE_TO_WHITE.

### bd - sFADE_TO_BLACK
Fades the screen to black. Once faded the next scene can be set up without visual glitches. It is common for a new screen to be loaded with sLOAD_ROOM_INSTANT, and characters to be pre-positioned before executing a sFADE_TO_NORMAL.

### be - sFADE_TO_WHITE
Fades the screen to white (cinematically also called a "washout"). Originally this was used only once when the PC takes a near-fatal fall. In Legend of the Mana Sword it is also used when you reach zero HP since the screen is about to be initialized to all white.

### bf - sFLASH_SCREEN
Flashes the screen dark for four frames and then back to normal for four frames before continuing script execution. This is similar to the Dark/Blind effect that enemies inflict except the PC's palette is also affected.

 > 💡**Note:** Originally this would have been constrained by the original Game Boy's small monochrome screen with low contrast and slow refresh. It tends to be used in tight loops up to ten times in a row. On modern TVs and monitors (and as far back as the Super Game Boy) the effect is more jarring and might be a seizure trigger for epileptics.

### c0 - sFULL_HP
Completely fill the players HP.

### c1 - sFULL_MANA
Completely fill the players MP.

### c2 - sPLAYER_CURE_STATUS bits
Remove one or more status effects specified by bits. The status effects are:
 - 1 - Poison
 - 2 - Blind (Dark)
 - 4 - Stone
 - 8 - Moogle
 - 16 - Fuji's ASK heal over time

To remove more than one status effect at a time add one or more values together.

### c4 - sPLAYER_GIVE_STATUS bits
Inflict one or more status effects specified by bits. See sPLAYER_CURE_STATUS.

### c5 - sUNK_C5 value
Not named yet. Sets a group of six bits (1wScriptFlags0E.2` to `wScriptFlags0E.7`) to a value from 0 to 63, essentially treating them as a small integer. This is used extensively for shops and houses so a map screen can be reused as different rooms.

### c6 - sENTER_PLAYER_AND_GIRL_NAME
This was originally called once to prompt for both names. Now it is called once for Hero's name and then again for Fuji's name, which allows moving sprites to switch between showing the two of them.

### c7 - sRNG
Sets `wScriptFlags0F.6` and `wScriptFlags0F.7` to random values. Used mostly for monsters that drop two possible types of treasure.

Originally the code they used for multiple possible item drops was exploitable by having either your ITEMS or EQUIP inventories full to force a re-randomization until you got the other drop. All cases have been changed so that one sRNG call is made and the value is saved.

### c8 - sRESET_GAME
Reset back to the title screen. Used by the script that runs when you reach zero HP.

### c9 - sSET_CHEST_OPEN_SCRIPT1 script
Set the script to run when opening a chest that is spawned from a script (instead of dropped randomly when defeating an enemy).

### ca - sSET_CHEST_OPEN_SCRIPT2 script
See sSET_CHEST_OPEN_SCRIPT1.

### cb - sSET_CHEST_OPEN_SCRIPT3 script
See sSET_CHEST_OPEN_SCRIPT1.

### cc - sHALT_GAME
Puts the script code into an infinite loop. Used on the final End screen.

### d0 - sGIVE_MONEY amount
Give money in the specified amount. Amount can be zero to 65535. Originally the maximum amount of money you could have was 65535 but in Legend of the Mana Sword that has been increased to 99999.

This command is unused.

### d1 - sTAKE_MONEY amount
Attempt to take the specified amount. Amount can be zero to 65535. If you have less than the amount then `wScriptFlags.6` is set, else it is cleared.

### d2 - sGIVE_XP amount
Give the specified amount from zero to 65535 XP. Unused.

### d3 - sTAKE_XP amount
Take the specified amount from zero 65535 XP. Unused.

### d4 - sGIVE_ITEM item
Give an item that goes into the ITEMS inventory. Sets `wScriptFlags.5` on failure (ITEMS inventory is full) and clears it on success.

### d5 - sTAKE_ITEM item
Take an item from the ITEMS inventory (if present). This will not work for items that are currently set to the B button.

### d6 - sGIVE_MAGIC
Give a spell.

### d7 - sTAKE_MAGIC
Take a spell. This is unused.

### d8 - sGIVE_EQUIPMENT equipment
Give a piece of equipment that goes into the EQUIP inventory. Sets `wScriptFlags.5` on failure (EQUIP inventory is full) and clears it on success.

### d9 - sTAKE_EQUIPMENT equipment
Take a piece of equipment from the EQUIP inventory. This cannot take equipped equipment.

### da - sSET_FLAG flag
Set a flag (boolean variable). See sIF_FLAG for more information.

### db - sCLEAR_FLAG flag
Clear a flag (boolean variable). See sIF_FLAG for more information.

### dc - sLOCK_TEXT_SPEED
Disables speeding up text printing by pressing buttons or the D-pad. This is used during the ending and never disabled. Originally it was also used after the first Jackal fight in a way that seemed to be just to test it.

### dd - sUNLOCK_TEXT_SPEED
Enables speeding up text printing by pressing buttons or the D-pad. Originally this was used after the first Jackal fight in a way that seemed to be just to test it but that call to sLOCK_TEXT_SPEED has now been removed so this is now unused.

### de - sTAKE_EQUIPED_ITEM
Takes one of whatever item is currently equipped to the B button.

### e0 - sOPEN_NORTH_DOOR
In an indoor or cave room this will cause an opening to the north.

### e1 - sCLOSE_NORTH_DOOR
In an indoor or cave room this will cause a door to appear to the north.

### e2 - sOPEN_SOUTH_DOOR
See sOPEN_NORTH_DOOR.

### e3 - sCLOSE_SOUTH_DOOR
See sCLOSE_NORTH_DOOR.

### e4 - sOPEN_EAST_DOOR
See sOPEN_NORTH_DOOR.

### e5 - sCLOSE_EAST_DOOR
See sCLOSE_NORTH_DOOR.

### e6 - sOPEN_WEST_DOOR
See sOPEN_NORTH_DOOR.

### e7 - sCLOSE_WEST_DOOR
See sCLOSE_NORTH_DOOR.

### e8 - sSCROLL_ROOM_DOWN
Scroll to the screen to the South. If there is an override set with sSET_NEXT_ROOM then the scroll will be to that screen.

### e9 - sSCROLL_ROOM_UP
See sSCROLL_ROOM_DOWN.

### ea - sSCROLL_ROOM_LEFT
See sSCROLL_ROOM_DOWN.

### eb - sSCROLL_ROOM_RIGHT
See sSCROLL_ROOM_DOWN.

### ec - sRUN_ROOM_SCRIPT
Runs the entry script for the current screen.

### ed - sRUN_ROOM_EXIT_SCRIPT
Runs the exit script for the current screen.

### ee - sRUN_ROOM_ALL_KILLED_SCRIPT
Runs the all enemies defeated script for the current screen.

### ef - sSET_NEXT_ROOM x, y
Override the normal map layout so regardless of which direction you exit the current screen you will scroll to screen x, y. This is restricted to screens in the current map. See sLOAD_ROOM_INSTANT.

### f0 - sDELAY frames
Wait for a specified number of frames. The Game Boy runs at exactly 60 frames a second (Super Game Boy runs slightly slower).

### f3 - sLOAD_ROOM_INSTANT map, screen, x, y
Changes to the specified screen of the specified map number. This should only be used when the screen is faded with sFADE_TO_BLACK or sFADE_TO_WHITE as the load can take multiple frames.

There are sixteen numbered maps. Map zero is the overworld. Maps two through six are interior temple-like rooms. Maps eight through 13 are interior cave-like rooms. Maps 1, 14, and 15 contain all the other playable screens while map seven contains the title screen, final End screen, and specialized screens used by the in-game map screen.

Which screen in the map is specified by x and y coordinates with the x coordinate in the high nibble of screen and the y coordinate in the low nibble.

The player is shown at the location specified by x,y on the eight pixel grid.

### f4 - sLOAD_ROOM map, screen, x, y
See sLOAD_ROOM_INSTANT. The difference is that this command triggers a "shutter" effect so that it can hide the load process.

### f6 - sOPEN_SHOP number
Open the shop interface for the shop number.

### f8 - sSET_MUSIC number
Start the music number. Songs are numbered from 1 to 31. To stop music specify song zero.

### f9 - sSFX number
Play the sound effect number. There are 36 sound effects number from 1 to 37. Sound number zero should stop the currently playing sound effect but this is unused.

### fb - sSHAKE_SCREEN
Shake the screen to the left and right two pixels. This exposes whatever is offscreen which depends on what screens you have previously been to. Offscreen areas can be explicitly set with sSET_ROOM_TILE to avoid glitches.

### fc - sSET_NPC_TYPES number
Choose NPC group number. These are used for enemies, towns folk, and companions. Each group has (up to) three NPC types. Running this command results in loading the graphics for all of its NPCs and their projectiles into fixed locations. This usually replaces the graphics of any other group.

### fd - sSPAWN_NPC number
Spawn one or more NPCs from the currently set group. The NPC number is specific to the group and can be zero, one, or two.

### fe - sSPAWN_BOSS number
Spawn a boss. There are 20 bosses numbered one to 20. Bosses do not actually appear until the script is finished, however, loading them earlier in the script will prevent glitches by allowing time for their graphics to be transferred into VRAM before they appear.
