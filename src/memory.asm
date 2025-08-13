;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"

SECTION "wram0", WRAM0[$c000]

wOAMBuffer:
    ds 8                                               ;; c000
._08:
    ds 8                                               ;; c008
._10:
    ds 144                                             ;; c010

wMainGameState:
    ds 1                                               ;; c0a0

; bit 0: unknown
; bit 1-2: used by scripts and other events that take control from the player
; bit 3: used to freeze the player by both scripts and scrolling
; bit 4-7: scrolling direction
wMainGameStateFlags:
    ds 1                                               ;; c0a1
.nextFrame:
    ds 1                                               ;; c0a2

wJoypadInput:
    ds 1                                               ;; c0a3

; Free space
    ds 1                                               ;; c0a4

wVideoLCDC:
    ds 1                                               ;; c0a5

wVideoSCX:
    ds 1                                               ;; c0a6

wVideoSCY:
    ds 1                                               ;; c0a7

wVideoWX:
    ds 1                                               ;; c0a8

wVideoWY:
    ds 1                                               ;; c0a9

wVideoBGP:
    ds 1                                               ;; c0aa

wVideoOBP0:
    ds 1                                               ;; c0ab

wVideoOBP1:
    ds 1                                               ;; c0ac

wVBlankDone:
    ds 1                                               ;; c0ad

; Free space
    ds 1                                               ;; c0ae

; Moved to make room for an additional byte of RNG state for the LCG.
;wJoypadInput:

wRndState:
    ds 1                                               ;; c0af

wRndState0:
    ds 1                                               ;; c0b0

wRndState1:
    ds 1                                               ;; c0b1

wScratchBankCallFunctionNumber:
    ds 1                                               ;; c0b2

wScratchBankCallA:
    ds 1                                               ;; c0b3

wScratchBankCallL:
    ds 1                                               ;; c0b4

wScratchBankCallH:
    ds 11                                              ;; c0b5

; Grows upwards, unlike hardware stacks.
wBankStack:
    ds 64                                              ;; c0c0

; START OF AUDIO ENGINE WRAM
wMusicTempoTimeCounter:
    ds 1                                               ;; c100

wMusicTempo:
    ds 1                                               ;; c101

; Sound effects do not use channel
wSoundEffectDurationChannel2:
    ds 1                                               ;; c102

wMusicNoteDurationChannel2:
    ds 1                                               ;; c103

wMusicInstructionPointerChannel2:
    ds 1                                               ;; c104
.high:
    ds 1                                               ;; c105

wMusicVibratoDurationChannel2:
    ds 1                                               ;; c106

wMusicVibratoEnvelopeChannel2:
    ds 1                                               ;; c107
.high:
    ds 1                                               ;; c108

wMusicVibratoEnvelopePointerChannel2:
    ds 1                                               ;; c109
.high:
    ds 1                                               ;; c10a

wMusicOctaveChannel2:
    ds 1                                               ;; c10b

wMusicNR21DutyCycleChannel2:
    ds 1                                               ;; c10c

wMusicCurrentPitchChannel2:
    ds 1                                               ;; c10d
.high:
    ds 1                                               ;; c10e

wMusicLoopCounter1Channel2:
    ds 1                                               ;; c10f

wMusicNR22DefaultVolumeChannel2:
    ds 1                                               ;; c110

wMusicNotePitchChannel2:
    ds 2                                               ;; c111

wMusicEndedOnChannel2:
    ds 1                                               ;; c113

wMusicVolumeDurationChannel2:
    ds 1                                               ;; c114

wMusicVolumeEnvelopeChannel2:
    ds 1                                               ;; c115
.high:
    ds 1                                               ;; c116

wMusicVolumeEnvelopePointerChannel2:
    ds 1                                               ;; c117
.high:
    ds 1                                               ;; c118

wMusicLoopCounter2Channel2:
    ds 1                                               ;; c119

wSoundEffectDurationChannel1:
    ds 1                                               ;; c11a

wMusicNoteDurationChannel1:
    ds 1                                               ;; c11b

wMusicInstructionPointerChannel1:
    ds 1                                               ;; c11c
.high:
    ds 1                                               ;; c11d

wMusicVibratoDurationChannel1:
    ds 1                                               ;; c11e

wMusicVibratoEnvelopeChannel1:
    ds 1                                               ;; c11f
.high:
    ds 1                                               ;; c120

wMusicVibratoEnvelopePointerChannel1:
    ds 1                                               ;; c121
.high:
    ds 1                                               ;; c122

wMusicOctaveChannel1:
    ds 1                                               ;; c123

wMusicNR11DutyCycleChannel1:
    ds 1                                               ;; c124

wMusicCurrentPitchChannel1:
    ds 1                                               ;; c125
.high:
    ds 1                                               ;; c126

wMusicLoopCounter1Channel1:
    ds 1                                               ;; c127

wMusicNR12DefaultVolumeChannel1:
    ds 1                                               ;; c128

wMusicNotePitchChannel1:
    ds 1                                               ;; c129

wMusicStereoPanChannel1:
    ds 1                                               ;; c12a

wMusicEndedOnChannel1:
    ds 1                                               ;; c12b

wMusicVolumeDurationChannel1:
    ds 1                                               ;; c12c

wMusicVolumeEnvelopeChannel1:
    ds 1                                               ;; c12d
.high:
    ds 1                                               ;; c12e

wMusicVolumeEnvelopePointerChannel1:
    ds 1                                               ;; c12f
.high:
    ds 1                                               ;; c130

wMusicLoopCounter2Channel1:
    ds 1                                               ;; c131

; Sound effects do not use channel 3
wSoundEffectDurationChannel3:
    ds 1                                               ;; c132

wMusicNoteDurationChannel3:
    ds 1                                               ;; c133

wMusicInstructionPointerChannel3:
    ds 1                                               ;; c134
.high:
    ds 1                                               ;; c135

wMusicVibratoDurationChannel3:
    ds 1                                               ;; c136

wMusicVibratoEnvelopeChannel3:
    ds 1                                               ;; c137
.high:
    ds 1                                               ;; c138

wMusicVibratoEnvelopePointerChannel3:
    ds 1                                               ;; c139
.high:
    ds 1                                               ;; c13a

wMusicOctaveChannel3:
    ds 2                                               ;; c13b

wMusicCurrentPitchChannel3:
    ds 1                                               ;; c13d
.high:
    ds 1                                               ;; c13e

wMusicLoopCounter1Channel3:
    ds 1                                               ;; c13f

wMusicVolumeChannel3:
    ds 1                                               ;; c140

wMusicNotePitchChannel3:
    ds 2                                               ;; c141

wMusicEndedOnChannel3:
    ds 6                                               ;; c143

wMusicLoopCounter2Channel3:
    ds 1                                               ;; c149

wSoundEffectDurationChannel4:
    ds 17                                              ;; c14a

; One byte long
; Channel 4 is not used for music, only sound effects
wMusicEndedOnChannel4:
    ds 5                                               ;; c15b

; NOTE: we are intentionally using 96 bytes here, overflowing into the unused buffer below
wHPMPTileBuffer:
    ds 2                                               ;; c160

; Used to back up everything from c100 to c161, or it would if the functions were ever called
wMusicDataBackup:
    ds 98                                              ;; c162

wSoundEffectInstructionPointerChannel1:
    ds 1                                               ;; c1c4
.high:
    ds 1                                               ;; c1c5

wSoundEffectInstructionPointerChannel4:
    ds 1                                               ;; c1c6
.high:
    ds 1                                               ;; c1c7

wMusicBrokenDoubleTimeMode:
    ds 1                                               ;; c1c8

; This is another slightly broken music/sound feature.
; This is written to the "rest pitch" (too high to be heard) whenever a rest is encountered on channel 1.
; It is never otherwise written, so it takes on this value at the beginning of the title screen song, and never changes.
; After a sound effect is played which uses channel 1, this value is written as the new pitch of channel 1.
; That means that any note that would otherwise be underway is muted, unless/until the vibrato envelope ticks.
;
; It looks like the code was designed to save all pitch changes to this so the note would restore instantly, but that isn't what happens.
; It may be that there were audible glitches with instant restore, or it may just not have been worth the effort or CPU overhead.
wSoundsMusicRestorePitchChannel1:
    ds 1                                               ;; c1c9
; One byte long
; END OF AUDIO ENGINE WRAM  (c1cb is not included)
.high:
    ds 54                                              ;; c1ca

; 16 bytes per object, or potentially 16x16 sprite?
; 00: Facing and movement.
;   * bit0: East.
;   * bit1: West.
;   * bit2: North.
;   * bit3: South.
;   * bit5: Unknown. Possibly unused.
;   * bit6: Unknown. Used by moveObject.
;   * bit7: Moving. Unaligned to the 8x8 grid.
; 01: Movement speed
; 02: Collision flags:
; bit 0: blocked by walls
; bit 2: walk on water (and not on land)
; bit 4: can be pushed by player or take damage on touch?
; bit 7: blocks player
; 03: Unknown
; 04: Y position
; 05: X position
; 06-07: Meta sprite pointer
; 08-09: Shadow OAM memory location
; 0a: Sliding on ice or in the minecart. If sliding the top nibble is set to 9 and bottom is set to a direction same as offset 00
; 0b-15: Unknown
; The fourth entry is the player.
; The seventh entry is either the first Npc or your follower, if present.
wObjectRuntimeData:
    ds 64                                              ;; c200
.player:
    ds 48                                              ;; c240
.npc1:
    ds 208                                             ;; c270

; This is set to 16 and never changed.
; Room width is hardcoded as 0xa1 for boundary checks, but height is checked as [$c340] * 8 + 1
wRoomHeightInTiles:
    ds 1                                               ;; c340

; 1=west, 2=east, 4=south, 8=north
wScrollDirection:
    ds 1                                               ;; c341

wBackgroundDrawPositionX:
    ds 1                                               ;; c342

wBackgroundDrawPositionY:
    ds 1                                               ;; c343

;Sets the next room to be loaded on a screen transition.
wNextRoomOverride:
    ds 1                                               ;; c344
.x:
    ds 3                                               ;; c345

wScrollPixelCounter:
    ds 1                                               ;; c348

; One byte long
wObjectIDCopy:
    ds 7                                               ;; c349

wRoomTiles:
    ds 80                                              ;; c350

; wRoomTiles is copied to the backup when the minimap is opened
wRoomTilesBackup:
    ds 80                                              ;; c3a0

wMapTableBankNr:
    ds 1                                               ;; c3f0

; There is an unused system for turning on/off the darkness effect via script.
; This can be overridden with two unused items: Torch and Dwarf Lamp.
wScriptDarknessEffect:
    ds 1                                               ;; c3f1

wMapTablePointer:
    ds 1                                               ;; c3f2
.high:
    ds 1                                               ;; c3f3

; bit 0 east, bit 1 west, bit 2 north, bit 3 south.
; bits are set for open doors, cleared for closed.
wDoorStates:
    ds 1                                               ;; c3f4

wMapNumber:
    ds 1                                               ;; c3f5

wRoomX:
    ds 1                                               ;; c3f6

wRoomY:
    ds 1                                               ;; c3f7

; 00 = RLE encoded map
; 01 = Template encoded map
wMapEncodingType:
    ds 1                                               ;; c3f8

wMapTileRLECount:
    ds 1                                               ;; c3f9

wMapHeight:
    ds 1                                               ;; c3fa

wMapWidth:
    ds 1                                               ;; c3fb

; The wRoomTileDataPointer is only used for templated rooms, and stores a pointer to the per room door data/tile overrides
wRoomTileDataPointer:
    ds 1                                               ;; c3fc
.high:
    ds 1                                               ;; c3fd

; Points at the mapXX_roomXX_XX_script label of the current room
wRoomScriptTableLow:
    ds 1                                               ;; c3fe

wRoomScriptTableHigh:
    ds 1                                               ;; c3ff

; Two bytes per room are stored here. First byte is $80 if the room is cleared, 2nd byte is XY position of the room.
; Any room entered will add an entry to this table.
; This is used to set/clear wScriptFlags.7 when entering a room to indicate if all enemies have been defeated.
; First byte of this list is alway "current room status"
; List is cleared when warping?
wRoomClearedStatus:
    ds 128                                             ;; c400

; Sprite shuffling to flash instead of permanently hide is implemented by moving them offscreen in rotation if there are two many on a line.
wSpriteShuffleScratch:
    ds 32                                              ;; c480

wSpriteShuffleHiddenSpriteAddressLow:
    ds 1                                               ;; c4a0

; Unused. Free space.
wSpriteScrollSpeed:
    ds 1                                               ;; c4a1

; Sprites are hidden by moving them offscreen vertically.
; This is used to hide sprites behind windows and to flash sprites when the line limit is exceeded.
hiddenSpritesYPositions:
    ds 46                                              ;; c4a2

wFlyingSwordSpecialOriginalLocationX:
    ds 1                                               ;; c4d0

wFlyingSwordSpecialOriginalLocationY:
    ds 1                                               ;; c4d1

wPlayerDamagedTimer:
    ds 2                                               ;; c4d2

;Bit0: Unused
;Bit1: Dark
;Bit2: Ston
;Bit3: Moog
;Bit4: Player Minecart Sprite
;Bit5: Player Hurt Sprite
;Bit6: Player Down Sprite
;Bit7: Unused
wPlayerSpecialFlags:
    ds 12                                              ;; c4d4

; 08 records of $18 size, related to NPCs
; 00: wObjectRuntimeData entry index
; 01: Delay until next move (initialized from 02)
; 02: Movement speed
; 03: Melee state? Set to 01 on using a melee projectile, 04 while it's active, and ff otherwise. Likely to keep the NPC from moving?
; 04: Current behavior index
; 05: Current behavior counter
; 08: Damage timer
; 09: Backup movement speed during knockback
; 0a: Status (bit7: Slep, bit6: Mute)
; 0c-0d: HP
; 0e-0f: Temporary storage for incoming HP damage.
; 10-11: npcStatsTable entry pointer
; 12-13: npcDataTable entry pointer
wNpcRuntimeData:
    ds 16                                              ;; c4e0
.statsTablePointer:
    ds 176                                             ;; c4f0

; Everything is paused during a script, so if an object needs to move it gets added to this list for processing
wObjectsMovingDuringScript:
    ds 8                                               ;; c5a0

; List of 3 random NPC types, one per entry of the selected NPCSpawnPointers, selected from the 4 options
wNPCSpawnTypes:
    ds 6                                               ;; c5a8

; Current active index into NPCSpawnPointers.
wNPCSpawnTableIndex:
    ds 1                                               ;; c5ae

wNumberOfLivingEnemies:
    ds 1                                               ;; c5af

; One byte long
wNPCDroppingChest:
    ds 16                                              ;; c5b0

; 3 records of $0a size, related to projectiles
; 00: Object ID of the normal object
; 01: Delay until next move (initialized from 02)
; 02: Movement speed
; 03: Current pattern step
; 04: Y coordinate
; 05: X coordinate
; 06-07: NPC runtime data table entry pointer for the spawning NPC
; 08-09: Projectile data table entry pointer
wProjectileRuntimeData:
    ds 32                                              ;; c5c0

wTileCopyRequestData:
    ds 768                                             ;; c5e0

wTileCopyRequestCount:
    ds 1                                               ;; c8e0

wTileCopyRequestMutex:
    ds 1                                               ;; c8e1

wStackPointerBackup:
    ds 2                                               ;; c8e2

wUnused:
    ds 4                                               ;; c8e4

; Blocks of 6 bytes:
;0) Bank number to load from (change is skipped if >= $10)
;1) Amount of bytes to copy (must be multiple of 2)
;2-3) Source address
;4-5) Destination address
wBackgroundRenderRequests:
    ds 1536                                            ;; c8e8

; Unused. Free space.
wBackgroundRenderRequestCount:
    ds 8                                               ;; cee8

; Player attacks can use any of the first eight objects for their animation/hit boxes.
; Each object in use has an associated function that manages it. This tracks the function jumptable indexes.
wAttackFrameFunctions:
    ds 8                                               ;; cef0

wAttackFrameSteps:
    ds 8                                               ;; cef8

wAttackFrameSpeedTimers:
    ds 8                                               ;; cf00

; This stores pointers from the attackFrames table, one for each object that could possible be involved.
wAttackFramePointers:
    ds 16                                              ;; cf08

; This stores a pointer to the individual special/normal facing/walking directional attack type for each object.
wAttackFrameTypePointers:
    ds 16                                              ;; cf18

wCF28:
    ds 32                                              ;; cf28

wCF48:
    ds 8                                               ;; cf48

wCF50:
    ds 8                                               ;; cf50

wEquippedWeaponAnimationType:
    ds 1                                               ;; cf58

wEquippedItemAnimationType:
    ds 1                                               ;; cf59

; Might only be used by player attacks.
; Since attacks can be made up of many objects (such as the four sparkles when casting a spell) this tracks the one code is currently focussing on.
wSelectedObjectID:
    ds 1                                               ;; cf5a

; The current attack's range in pixels.
; Objects are first tested for overlap, then their distance is tested against this.
wAttackRange:
    ds 1                                               ;; cf5b

wPlayerCurrentAttackTypeAndFacing:
    ds 1                                               ;; cf5c

wFireHomingTarget:
    ds 1                                               ;; cf5d

wCF5E:
    ds 1                                               ;; cf5e

wPlayerAttackAnimationFrame:
    ds 1                                               ;; cf5f

wSlepTimerNumber:
    ds 1                                               ;; cf60

wMuteTimerNumber:
    ds 1                                               ;; cf61

wSpecialAttackTimerNumber:
    ds 1                                               ;; cf62

; One byte long
wCurrentPlayerAttackWillCharge:
    ds 157                                             ;; cf63

SECTION "wram1", WRAMX[$d000], BANK[$01]

; Free space
    ds 112                                             ;; d000

; Loopup of graphics tile number -> VRAM tile number
wBackgroundGraphicsTileMapping:
    ds 8                                               ;; d070
._08:
    ds 1                                               ;; d078
._09:
    ds 1                                               ;; d079
._0A:
    ds 1                                               ;; d07a
._0B:
    ds 1                                               ;; d07b
._0C:
    ds 1                                               ;; d07c
._0D:
    ds 1                                               ;; d07d
._0E:
    ds 1                                               ;; d07e
._0F:
    ds 1                                               ;; d07f
._10:
    ds 240                                             ;; d080

; Written to $0F when this graphic tile index is loaded into VRAM
; Decreases by one every screen scroll if unused resulting in the tile eventually "aging out"
wBackgroundGraphicsTileState:
    ds 4                                               ;; d170
._04:
    ds 4                                               ;; d174
._08:
    ds 2                                               ;; d178
._0A:
    ds 2                                               ;; d17a
._0C:
    ds 2                                               ;; d17c
._0E:
    ds 2                                               ;; d17e
._10:
    ds 240                                             ;; d180

; Written to $01 when a VRAM tile is used, starting from tile $80
wBackgroundGraphicsTileUsed:
    ds 128                                             ;; d270

wAnimatedTileWaterfall1:
    ds 16                                              ;; d2f0

wAnimatedTileWaterfall2:
    ds 16                                              ;; d300

wAnimatedTileWaterfallReversed1:
    ds 16                                              ;; d310

wAnimatedTileWaterfallReversed2:
    ds 16                                              ;; d320

wAnimatedTileOcean1:
    ds 16                                              ;; d330

wAnimatedTileOcean2:
    ds 16                                              ;; d340

wAnimatedTileOcean3:
    ds 16                                              ;; d350

wAnimatedTileOcean4:
    ds 16                                              ;; d360

wAnimatedTileRiver:
    ds 16                                              ;; d370

wAnimatedTileScratchpad:
    ds 14                                              ;; d380
._0E:
    ds 1                                               ;; d38e
._0F:
    ds 1                                               ;; d38f

; Points to graphics in bank $0B or $0C as a packed pointer from the map header.
wMapGraphicsPointer:
    ds 1                                               ;; d390
.High:
    ds 1                                               ;; d391

wTileDataTablePointer:
    ds 1                                               ;; d392
.High:
    ds 1                                               ;; d393

; Request a new frame, or set to $ff for no request. Byte past the first are not well understood.
wPlayerAnimation:
    ds 4                                               ;; d394

wTileAnimationCounter_Unused:
    ds 1                                               ;; d398

wTileAnimationCounter:
    ds 7                                               ;; d399

; Buffer containing LCDC effects. 4 bytes per entry:
; 0: rLYC value ($FF for no next)
; 1: rLCDC and MASK
; 2: rLCDC xor MASK
; 3: BGP value
wLCDCEffectBuffer:
    ds 3                                               ;; d3a0
._03:
    ds 63                                              ;; d3a3

; Index into the wLCDCEffectBuffer (as entry number, not byte offset)
wLCDCEffectIndex:
    ds 6                                               ;; d3e2

wBossFirstObjectID:
    ds 1                                               ;; d3e8

wBossSpeedTimer:
    ds 2                                               ;; d3e9

wBossIframes:
    ds 1                                               ;; d3eb

wBossCurrentPatternStep:
    ds 1                                               ;; d3ec

wBossCurrentKeyframeStep:
    ds 1                                               ;; d3ed

wBossCurrentHeadActionStep:
    ds 1                                               ;; d3ee

; The head actions only have one step each, but it looks like they were desinged to have more.
wBossCurrentHeadActionSubstep:
    ds 1                                               ;; d3ef

wBossCurrentKeyframeHoldtime:
    ds 2                                               ;; d3f0

wDamageDoneToBoss:
    ds 1                                               ;; d3f2
.high:
    ds 1                                               ;; d3f3

wCurrentBossHP:
    ds 1                                               ;; d3f4
.high:
    ds 1                                               ;; d3f5

; Used by most bosses to track one head object's location, but also used heavily by Megapede.
wBossCurrentHeadYX:
    ds 66                                              ;; d3f6

wCurrentBossDataPointer:
    ds 1                                               ;; d438
.high:
    ds 1                                               ;; d439

wCurrentBossPatternPointer:
    ds 1                                               ;; d43a
.high:
    ds 1                                               ;; d43b

wBossCurrentKeyframePointer:
    ds 1                                               ;; d43c
.high:
    ds 1                                               ;; d43d

wBossCurrentHeadActionPointer:
    ds 1                                               ;; d43e
.high:
    ds 1                                               ;; d43f

wBossCurrentMetatileListPointer:
    ds 1                                               ;; d440
.high:
    ds 1                                               ;; d441

; Six bytes each, 14 total, but the largest boss only uses 11.
; 0: Object ID of the normal object
; 1-2: Stats pointer
; 3: Unknown
; 4: Probably always zero. Used as an index into d3f6.
; 5: Unknown
wBossObjectsStatsRuntimeData:
    ds 4                                               ;; d442
.XYSaveIndex:
    ds 82                                              ;; d446

wPlayerJumpArg:
    ds 1                                               ;; d498

; Counter used in various script opcodes, left at 0 after opcode is done.
wScriptOpCounter:
    ds 1                                               ;; d499

wScriptOpCounter2:
    ds 1                                               ;; d49a

; This is the track that will play if not prempted by level up fanfare or status effect
wMusic:
    ds 1                                               ;; d49b

wVideoLCDCBackup:
    ds 1                                               ;; d49c

; Current map number, copied from wMapNumber, used during minimap drawing
wMapNumberTmp:
    ds 1                                               ;; d49d

; Room XY number, copied from wRoomX and wRoomY, used during minimap drawing
wRoomXYTmp:
    ds 1                                               ;; d49e

; Current map width, copied from wMapWidth, used during minimap drawing
wMapWidthTmp:
    ds 1                                               ;; d49f

; Current map bank number, copied from wMapBankNr, used during minimap drawing
wMapTableBankNrTmp:
    ds 1                                               ;; d4a0

wDynamicMinimapMapTablePointer:
    ds 1                                               ;; d4a1
.high:
    ds 1                                               ;; d4a2

; Used while afflicted with Pois, Dark, Ston, or Moog
wCurrentMusicStatusEffectBackup:
    ds 1                                               ;; d4a3

wDoorStatesMinimapBackup:
    ds 3                                               ;; d4a4

wDialogX:
    ds 1                                               ;; d4a7

wDialogY:
    ds 1                                               ;; d4a8

wDialogW:
    ds 1                                               ;; d4a9

wDialogH:
    ds 1                                               ;; d4aa

; 360 (SCRN_X_B * SCRN_Y_B) bytes long so it can store the full screen
; This is used to store tile ids while wWindowBackupAttributes in bank 2 is used to store attribtues.
wWindowBackgroundSaveBuffer:
    ds 360                                             ;; d4ab
.end:

; Script that is run when you open a chest. Actual script code is stored in here,
; but with only 3 bytes storage, it just calls an actual script in one of the script banks.
wOpenChestScript1:
    ds 3                                               ;; d613
._3:
    ds 1                                               ;; d616
._4:
    ds 12                                              ;; d617

; Script that is run when you open a chest. Actual script code is stored in here,
; it just calls an actual script in one of the script banks.
wOpenChestScript2:
    ds 16                                              ;; d623

wOpenChestScript3:
    ds 4                                               ;; d633
._4:
    ds 12                                              ;; d637

; Bottom of the script stack, used by script call/loop operations
; 4 bytes are pushed onto this at a time. Stack grows stack grows from the top downwards.
wScriptStack:
    ds 64                                              ;; d643
.top:

; Used to backup the first three metasprites while windows are up.
; They might be used for the two hand pointers and the trashcan.
wOAMBufferBackup:
    ds 24                                              ;; d683

; START OF SRAM PART 3
; Amount of the same type of item in inventory. wItemInventory indicates the type, wItemInventoryAmount indicates the amount
wItemInventoryAmount:
    ds SAVE_ITEM_INVENTORY_SIZE                        ;; d69b

; END OF SRAM PART 3 (d6ab is not saved)
; Technically these are quantities, but since you can only ever have one of any spell, it's just whether you have it
wKnownMagicSpells:
    ds SAVE_MAGIC_INVENTORY_SIZE                       ;; d6ab

wEquipmentInventoryPowers:
    ds SAVE_EQUIP_INVENTORY_SIZE                       ;; d6b3

; START OF SRAM PART 2
wEquippedWeaponPower:
    ds 1                                               ;; d6bf

wEquippedHelmetDefense:
    ds 1                                               ;; d6c0

;Alternative totalAP location?
wDupTotalAP:
    ds 1                                               ;; d6c1

wEquippedArmorDefense:
    ds 1                                               ;; d6c2

;Alternative totalDP location?
wDupTotalDP:
    ds 2                                               ;; d6c3

; List of item IDs in your current inventory. ItemID has $80 added to it if it has a usage counter.
wItemInventory:
    ds SAVE_ITEM_INVENTORY_SIZE                        ;; d6c5

wMagicInventory:
    ds SAVE_MAGIC_INVENTORY_SIZE                       ;; d6d5

wEquipmentInventory:
    ds SAVE_EQUIP_INVENTORY_SIZE                       ;; d6dd

wEquippedWeapon:
    ds 1                                               ;; d6e9

wEquippedHelm:
    ds 2                                               ;; d6ea

wEquippedArmor:
    ds 2                                               ;; d6ec

wEquippedShield:
    ds 1                                               ;; d6ee

wEquippedItem:
    ds 1                                               ;; d6ef

wEquippedItemAmount:
    ds 1                                               ;; d6f0

; END OF SRAM PART 2 (d6f1 is not saved)
wEquippedItemAndWeaponCopy:
    ds 2                                               ;; d6f1

wVendorBuyIDs:
    ds 7                                               ;; d6f3

wVendorBuyQuantities:
    ds 7                                               ;; d6fa

wVendorBuyPrices:
    ds 14                                              ;; d701

wVendorSellIDs:
    ds 32                                              ;; d70f

wVendorSellQuantities:
    ds 32                                              ;; d72f

wVendorSellPrices:
    ds 64                                              ;; d74f

wStatStaminaLevelUpTmp:
    ds 1                                               ;; d78f

wStatPowerLevelUpTmp:
    ds 1                                               ;; d790

wStatWisdomLevelUpTmp:
    ds 2                                               ;; d791

wStatusHPMPCurrentAndMax:
    ds 10                                              ;; d793

wBoyName:
    ds 5                                               ;; d79d

wGirlName:
    ds 5                                               ;; d7a2

; START OF SRAM PART 1
; Used as 49 bytes when writing a save to SRAM
; Used as one byte to store the "magic number" before writing a save to SRAM
; Used as four bytes to store the name during naming entry
; Used as one byte to store a save file's current level between showing the level and E to next level on the Save/Load screen
wSRAMSaveHeader:
    ds 1                                               ;; d7a7
; Used as two bytes to store the checksum before writing a save to SRAM
; Used as eight bytes for BCD conversion of Experience values for display
._1:
    ds 2                                               ;; d7a8
; Used as eight bytes to load and save the names in SRAM
; Between loading and saving, names are copied to d79d and d7a2, and this space may be used for scratch
._3:
    ds 7                                               ;; d7aa
; Used to save and restore the finger position on the naming screen when you press the B button
._a:
    ds 1                                               ;; d7b1

wHPLow:
    ds 1                                               ;; d7b2

wHPHigh:
    ds 1                                               ;; d7b3

wMaxHPLow:
    ds 1                                               ;; d7b4

wMaxHPHigh:
    ds 1                                               ;; d7b5

wManaLow:
    ds 1                                               ;; d7b6

wManaHigh:
    ds 1                                               ;; d7b7

wMaxManaLow:
    ds 1                                               ;; d7b8

wMaxManaHigh:
    ds 1                                               ;; d7b9

wLevel:
    ds 1                                               ;; d7ba

wXPLow:
    ds 1                                               ;; d7bb

wXPHigh:
    ds 1                                               ;; d7bc

wXPHighExt:
    ds 1                                               ;; d7bd

wMoneyLow:
    ds 1                                               ;; d7be

wMoneyHigh:
    ds 1                                               ;; d7bf

; Status that the player currently has
;Bit0: Pois
;Bit1: Dark
;Bit2: Ston
;Bit3: Moog
;Bit4: Fuji's ASK
;Bit5: ?
;Bit6: ?
;Bit7: Rich (used for money above 65535)
wStatusEffect:
    ds 1                                               ;; d7c0

wStatStamina:
    ds 1                                               ;; d7c1

wStatPower:
    ds 1                                               ;; d7c2

wStatWisdom:
    ds 1                                               ;; d7c3

wStatWill:
    ds 2                                               ;; d7c4

; Script flags bits are numbered from high to low. So Bit0 = $80, Bit7 = $01
; Bit5: Set by sGIVE_ITEM, sGIVE_EQUIPMENT and sGIVE_MAGIC when there is not enough room in your inventory
; Bit6: Set by money script code when you do not have enough money
; Bit7: Set when all enemies in the room haven't been defeated yet.
wScriptFlags:
    ds 1                                               ;; d7c6

wScriptFlags01:
    ds 1                                               ;; d7c7

wScriptFlags02:
    ds 1                                               ;; d7c8

wScriptFlags03:
    ds 1                                               ;; d7c9

wScriptFlags04:
    ds 1                                               ;; d7ca

wScriptFlags05:
    ds 1                                               ;; d7cb

wScriptFlags06:
    ds 1                                               ;; d7cc

wScriptFlags07:
    ds 1                                               ;; d7cd

wScriptFlags08:
    ds 1                                               ;; d7ce

wScriptFlags09:
    ds 1                                               ;; d7cf

wScriptFlags0A:
    ds 1                                               ;; d7d0

wScriptFlags0B:
    ds 1                                               ;; d7d1

wScriptFlags0C:
    ds 1                                               ;; d7d2

wScriptFlags0D:
    ds 1                                               ;; d7d3

wScriptFlags0E:
    ds 1                                               ;; d7d4

;.7 set when awnsered NO on a YES/NO question dialog
wScriptFlags0F:
    ds 1                                               ;; d7d5

; Unused. Free space.
wCurrentMagicPower:
    ds 1                                               ;; d7d6

wEquippedWeaponElements:
    ds 1                                               ;; d7d7

; END OF SRAM PART 1 (d7d8 is not saved)
wStatStaminaBuffBackup:
    ds 5                                               ;; d7d8

; Two blank lines before AP and DP
wStatusScreenAPDP:
    ds 2                                               ;; d7dd

;Attack power, depending on stats and equiped weapon
wTotalAP:
    ds 1                                               ;; d7df

;Defence, depending on stats and equiped armor
wTotalDP:
    ds 1                                               ;; d7e0

;Each timer is five bytes
; offset 0:
; bit 0: unknown
; bit 1: expired
; bit 7: active
; offset 1-2: time remaining
; offset 3-4: starting time
wTimers:
    ds 80                                              ;; d7e1

wLevelUpStatChoicesCopy:
    ds 17                                              ;; d831

; Used during the level up fanfare
wCurrentMusicLevelUpBackup:
    ds 1                                               ;; d842

wD843:
    ds 1                                               ;; d843

wWindowFingerBlinkTimerNumber:
    ds 1                                               ;; d844

wWindowNumberOfSelections:
    ds 1                                               ;; d845

wD846:
    ds 2                                               ;; d846

wD848:
    ds 1                                               ;; d848

; bit 0: seems related to having multiple columns, but it's set on the START menu
; bit 1: has trash can
; bit 3: button pressed
; bit 4: scrolling down
; bit 5: scrolling up
; bit 7: showing trash can
wMenuFlags:
    ds 1                                               ;; d849

; Indicates which dialog is being opened. For example $11 = select menu (save/map/status)
wDialogType:
    ds 1                                               ;; d84a

; Selection index in menus, after selection.
; Or $FF when pressing B to exit a menu
wSelectedMenuIndex:
    ds 1                                               ;; d84b

; Second selection, when swapping items in the inventory menu.
wSelectedMenuIndex2:
    ds 1                                               ;; d84c

wScriptDelayOpCodeTimerNumber:
    ds 1                                               ;; d84d

wMenuFlagsBackup:
    ds 1                                               ;; d84e

wD84F:
    ds 1                                               ;; d84f

wMenuStateFunctionNew:
    ds 1                                               ;; d850

wEquippedItemElements:
    ds 2                                               ;; d851

; bit 7 is used as a flag
wMenuStateCurrentFunction:
    ds 1                                               ;; d853

wDrawWindowStep:
    ds 2                                               ;; d854

wD856:
    ds 1                                               ;; d856

wMenuSelectionMoveRepeatDelay:
    ds 1                                               ;; d857

; Amount of special attack charge, from $00 to $40.
wWillCharge:
    ds 1                                               ;; d858

wWindowCloseStep:
    ds 1                                               ;; d859

wScriptCommand:
    ds 2                                               ;; d85a

wD85C:
    ds 1                                               ;; d85c

wVendorPurchaseID:
    ds 1                                               ;; d85d

wD85E:
    ds 1                                               ;; d85e

; Used when a status is inflicted in combat. If the effect is not Fuji's, it is nibble swaped.
wStatusEffectNew:
    ds 1                                               ;; d85f

wD860:
    ds 2                                               ;; d860

wWindowMainGameStateBackup:
    ds 1                                               ;; d862

; Dialog border tile, depending on it if it drawing the top or bottom row, different tile numbers are stored here
wDialogBorderTile:
    ds 1                                               ;; d863

wTextSpeedTimer:
    ds 1                                               ;; d864

; Amount of pushes done on the script stack
wScriptStackCount:
    ds 1                                               ;; d865

wCursorColumns:
    ds 1                                               ;; d866

wCursorColumnWidth:
    ds 1                                               ;; d867

wD868:
    ds 1                                               ;; d868

wD869:
    ds 1                                               ;; d869

wScriptBank:
    ds 1                                               ;; d86a

wVirtualScriptOpCodeFFArgument:
    ds 1                                               ;; d86b

wScriptSavedNextOpcode:
    ds 1                                               ;; d86c

wVendorNumber:
    ds 1                                               ;; d86d

wScriptMainGameStateBackup:
    ds 1                                               ;; d86e

; bit 0: unknown
; bit 1: cant carry (and maybe not enough money)
; bit 6: attacking with spell/item (not weapon)
; bit 7: used as a temporary in drawNumber24bitOnDialog
wMiscFlags:
    ds 1                                               ;; d86f

; Used by the two script opcodes that search player posessions
wSearchInventoryLength:
    ds 1                                               ;; d870

wScriptTriggerCollisionFlags:
    ds 1                                               ;; d871

; bit 0: unknown
; bit 1: unknown
; bit 2: trash can tiles are loaded
; bit 5: unknown
; bit 6: unknown
; bit 7: unknown
wWindowSecondaryFlags:
    ds 1                                               ;; d872

wScriptPlayerFacingDirection:
    ds 1                                               ;; d873

; bit 1: text speed lock
; bit 2: Load screen (instead of Save)
; bit 3: Save 1
; bit 4: Save 2
; bit 5: naming screen Girl (instead of Boy)
; bit 6: Uknown
; bit 7: running script
wWindowFlags:
    ds 2                                               ;; d874

wWindowVendorSellItemIndex:
    ds 1                                               ;; d876

wPoisStatusEffectTimeBeforeNextTick:
    ds 1                                               ;; d877

wFujiStatusEffectTimeBeforeNextTick:
    ds 1                                               ;; d878

wPoisStatusEffectTimerNumber:
    ds 1                                               ;; d879

wDarkStatusEffectTimerNumber:
    ds 1                                               ;; d87a

wStonStatusEffectTimerNumber:
    ds 1                                               ;; d87b

wMoogStatusEffectTimerNumber:
    ds 1                                               ;; d87c

wFujiStatusEffectTimerNumber:
    ds 1                                               ;; d87d

wNectarStaminaTimerNumber:
    ds 1                                               ;; d87e

; On level up, wait a number of frames while the fanfare music plays.
wLevelUpFanfareDelay:
    ds 1                                               ;; d87f

; Whenever this passes 150 wWillCharge is incremented.
wWillChargeSubPoint:
    ds 1                                               ;; d880

wLightStatusEffectTimerNumber:
    ds 1                                               ;; d881

wMoogleSavedDp:
    ds 1                                               ;; d882

wDualCharacterPosition:
    ds 1                                               ;; d883

wVideoWYBackup:
    ds 1                                               ;; d884

wNameEntryNameLength:
    ds 1                                               ;; d885

wTitleScreenState:
    ds 1                                               ;; d886

wIntroScrollCounter2:
    ds 1                                               ;; d887

wIntroScrollSCYBackup:
    ds 1                                               ;; d888

wIntroScrollCounter1:
    ds 1                                               ;; d889

; Initialized with the number of possible status effects (five), then decremented until the newly inflicted is found.
wStatusEffectLabelIndex:
    ds 1                                               ;; d88a

wCurrentItemOrSpellInUse:
    ds 1                                               ;; d88b

; On the title screen, wait a number of frames before the new game and continue options are shown.
wTitleScreenDelay:
    ds 1                                               ;; d88c

wD88D:
    ds 1                                               ;; d88d

wIntroScrollTextPointer:
    ds 1                                               ;; d88e
.high:
    ds 1                                               ;; d88f

; Used to point to inventory/equipment/equipped for the two script opcodes that search player posessions.
wItemSearchList:
    ds 1                                               ;; d890
.high:
    ds 1                                               ;; d891

wWindowFirstPointer:
    ds 1                                               ;; d892
.high:
    ds 1                                               ;; d893

wWindowSecondPointer:
    ds 1                                               ;; d894
.high:
    ds 1                                               ;; d895

wWindowThirdPointer:
    ds 1                                               ;; d896
.high:
    ds 1                                               ;; d897

wD898:
    ds 1                                               ;; d898

wD899:
    ds 1                                               ;; d899

wWindowTextRows:
    ds 1                                               ;; d89a

wWindowTextLength:
    ds 1                                               ;; d89b

wD89C:
    ds 1                                               ;; d89c

wD89D:
    ds 1                                               ;; d89d

wD89E:
    ds 1                                               ;; d89e

; One byte long
wD89F:
    ds 3                                               ;; d89f

wRegisterSave1:
    ds 1                                               ;; d8a2
.H:
    ds 1                                               ;; d8a3
.E:
    ds 1                                               ;; d8a4
.D:
    ds 1                                               ;; d8a5
.C:
    ds 1                                               ;; d8a6
.B:
    ds 1                                               ;; d8a7
.F:
    ds 1                                               ;; d8a8
.A:
    ds 1                                               ;; d8a9

wRegisterSave2:
    ds 1                                               ;; d8aa
.H:
    ds 1                                               ;; d8ab
.E:
    ds 1                                               ;; d8ac
.D:
    ds 1                                               ;; d8ad
.C:
    ds 1                                               ;; d8ae
.B:
    ds 1                                               ;; d8af
.F:
    ds 1                                               ;; d8b0
.A:
    ds 1                                               ;; d8b1

wWindowClearX:
    ds 1                                               ;; d8b2

wWindowClearY:
    ds 1                                               ;; d8b3

wWindowClearW:
    ds 1                                               ;; d8b4

wWindowClearH:
    ds 1                                               ;; d8b5

wScriptPointerLow:
    ds 1                                               ;; d8b6

wScriptPointerHigh:
    ds 1                                               ;; d8b7

wWindowTextInsertionPointX:
    ds 1                                               ;; d8b8

wWindowTextInsertionPointY:
    ds 1                                               ;; d8b9

wWindowTextSpaceLeftOnLine:
    ds 1                                               ;; d8ba

wWindowTextLinesLeft:
    ds 1                                               ;; d8bb

; Pointer to the script stack.
wScriptStackPointer:
    ds 1                                               ;; d8bc
.high:
    ds 1                                               ;; d8bd

; Unused. Free space.
wStackBackup:
    ds 2                                               ;; d8be

wNextXPLevelLow:
    ds 1                                               ;; d8c0

wNextXPLevelHigh:
    ds 1                                               ;; d8c1

wNextXPLevelHighExt:
    ds 1                                               ;; d8c2

; Unused. Free space.
wD8C3:
    ds 1                                               ;; d8c3

; Unused. Free space.
wD8C4:
    ds 1                                               ;; d8c4

; Used only by the vendor buy message
wWindowTextInsertionPointFinalX:
    ds 1                                               ;; d8c5

; Used only by the vendor buy message
wWindowTextInsertionPointFinalY:
    ds 1                                               ;; d8c6

; Used to stage SGB palette packets for fade effects.
wSGBPacket:
    ds 16                                              ;; d8c7

; Used by the code that opens to the same place in the menu after selling once to the vendor.
wWindowVendorSellPointerSavedX:
    ds 1                                               ;; d8d7

; Used by the code that opens to the same place in the menu after selling once to the vendor.
wWindowVendorSellPointerSavedY:
    ds 1                                               ;; d8d8

wD8D9:
    ds 1                                               ;; d8d9

wD8DA:
    ds 1                                               ;; d8da

wDualCharacterScratch:
    ds 3                                               ;; d8db

; 2-byte pairs of all 80 metatiles, pulled from the metatile data
; and cached for faster access
wMetatileAttributeCache:
    ds 160                                             ;; d8de

; Used as scratch space for the spawnNpcsFromTable routine in bank03
; First byte holds number of options (up to 165)
; Subsequent 2-byte pairs provide a spawn location option (x followed by y).
; This space can be reused for scratch space in its entirety outside of the spawnNpcsFromTable function.
wSpawnPlacementScratch:
    ds 331                                             ;; d97e

wSGBEndingCounter:
    ds 1                                               ;; dac9

; Free space.
;In order to 16 byte align the RAM tiles following.
wPadding:
    ds 6                                               ;; daca

wAnimatedTileRiverCorners:
    ds 64                                              ;; dad0

wColorPalettes:
.main:
.normal:
.normal_bgp0:
.bgp_normal:
    ds 64                                              ;; db10

.obj_main:
.obj_normal:
    ds 64                                              ;; db50

.blind:
.blind_bgp0:
.bgp_blind:
    ds 64                                              ;; db90

.obj_blind:
    ds 64                                              ;; dbd0

.damage:
    ds 64                                              ;; dc10

.obj_damage:
    ds 64                                              ;; dc50

.flash:
    ds 64                                              ;; dc90

.obj_flash:
    ds 64                                              ;; dcd0

.active:
.bgp_active:
.active_bgp0:
    ds 64                                              ;; dd10

.obj_active:
    ds 64                                              ;; dd50

; Stores faded color BGP0 during fades when the letterbox effect is enabled.
wPaletteBackground0LCDC:
    ds 8                                               ;; dd90

; Used on Super Game Boy to track whether the last fade was to white or black.
; Normal (not faded) = $00, Black = $01, White = $02.
wLastFade:
    ds 1                                               ;; dd91

wCurrentProjectilePalette:
    ds 1                                               ;; dd99

wCurrentFollowerPalette:
    ds 1                                               ;; dd9a

; After this is RAM code--currently the logging code--and the stack.
; The stack is placed at the end of wram. It is unknown how far down it can grow.

SECTION "wram2", WRAMX[$d000], BANK[$02]

    ds 1191                                            ;; d000

wWindowBackupAttributes:
.header:
    ds 4                                               ;; d4a7

; Placed in the same location as wWindowBackgroundSaveBuffer but in WRAM bank 2.
; Used to store tile attributes, whereas wWindowBackgroundSaveBuffer is used to store tile ids.
.buffer:
    ds 360                                             ;; d4ab
.end:

SECTION "hram", HRAM[$ff80]

hOAM_DMA_Routine:
    ds 10                                              ;; ff80

hBankStackPointer:
    ds 6                                               ;; ff8a

; START OF AUDIO ENGINE HRAM
hCurrentMusic:
    ds 1                                               ;; ff90

; Unused feature.
; Would have allowed things like status condition music to continue the interrupted track instead of restarting.
hMusicSpecialSongRequest:
    ds 1                                               ;; ff91

hSFX:
    ds 1                                               ;; ff92

hPlayingMusic:
    ds 1                                               ;; ff93

; Only one of the three channels is checked for vibrato and volume updates each frame
hVibratoVolumeChannelSelection:
    ds 1                                               ;; ff94

hMusicNoteDurationChannel2Copy:
    ds 1                                               ;; ff95

hMusicNoteDurationChannel1Copy:
    ds 1                                               ;; ff96

hMusicNoteDurationChannel3Copy:
    ds 2                                               ;; ff97

; Unused feature.
hMusicSpecialSongPlaying:
    ds 1                                               ;; ff99

hWaveTablePointer:
    ds 1                                               ;; ff9a
.high:
    ds 1                                               ;; ff9b

hSoundEffectLoopCounterChannel1:
    ds 1                                               ;; ff9c

; END OF AUDIO ENGINE HRAM (ff9e is not included)
; One byte long
hSoundEffectLoopCounterChannel4:
    ds 1                                               ;; ff9d

; Scratch space, up to programmer to ensure use collisions
; Current uses: scanRoomForNpcPlacementOptions
hScratch:
    ds 2

; If this is set then VBlank loads all palettes.
hPalettesDirty:
    ds 1

; Unused and ready for future features
hUnused:
    ds 91

; These are used to store the inital values for later identification of the Game Boy model.
; They are not cleared during reset intitialization.
; Their addresses are hard coded in a debug message in include/debug_messages.inc.
SECTION "hram_uncleared", HRAM[$fffc]
hBootup:
.a:
    ds 1                                               ;; fffc
.b:
    ds 1                                               ;; fffd
.c:
    ds 1                                               ;; fffe

; ffff is the Interrup Enable register (rIE)

SECTION "vram", VRAM[$8000]
    ds 8192                                            ;; 8000

SECTION "sram", SRAM[$a000]

sSave1Header:
    ds 6                                               ;; a000

sSave1Body:
    ds 250                                             ;; a006

sSave2Header:
    ds 6                                               ;; a100

sSave2Body:
    ds 7930                                            ;; a106
