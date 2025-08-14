;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"
INCLUDE "include/oam_attributes.inc"
INCLUDE "include/debug.inc"

SECTION "bank00", ROM0[$0000]
ds 64 ; Free space for RSTs.

SECTION "isrVBlank", ROM0[$0040]

isrVBlank:
    jr VBlankInterruptHandler

SECTION "isrLCDC", ROM0[$0048]

isrLCDC:
    jp LCDCInterrupt

SECTION "isrTimer", ROM0[$0050]

isrTimer:
    reti

SECTION "isrSerial", ROM0[$0058]

isrSerial:
    reti

SECTION "isrJoypad", ROM0[$0060]

isrJoypad:
    reti

VBlankInterruptHandler:
    push AF                                            ;; 00:0064 $f5
    push BC                                            ;; 00:0065 $c5
    push DE                                            ;; 00:0066 $d5
    push HL                                            ;; 00:0067 $e5
    ld a, HIGH(wOAMBuffer)
    call hOAM_DMA_Routine                              ;; 00:006b $cd $80 $ff
; Update video registers
    ld hl, wVideoLCDC
    ld a, [hl+]    ; wVideoLCDC
    ldh [rLCDC], a
    ld a, [hl+]    ; wVideoSCX
    ldh [rSCX], a
    ld a, [hl+]    ; wVideoSCY
    ldh [rSCY], a
    ld a, [hl+]    ; wVideoWX
    ldh [rWX], a
    ld a, [hl+]    ; wVideoWY
    ldh [rWY], a
IF DEF(COLOR)
; If palettes have been changed then set all background and object palettes.
    ldh a, [hPalettesDirty]
    or a
    jr z, .restoreFirstBackgroundPalette
    call loadPalettesToCRAM
    jr .finish
; The first background palette (and only the first) is used by line effects.
.restoreFirstBackgroundPalette:
    ld hl, wColorPalettes.active_bgp0
    ld a, BCPSF_AUTOINC
    ld c, LOW(rBCPS)
    ldh [c], a
    inc c
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
ELSE
    ld a, [hl+]    ; wVideoBGP
    ldh [rBGP], a
    ld a, [hl+]    ; wVideoOBP0
    ldh [rOBP0], a
    ld a, [hl+]    ; wVideoOBP1
    ldh [rOBP1], a
ENDC
.finish:
    call vblankGraphicsVRAMCopy                        ;; 00:0071 $cd $57 $2d
    call getRandomByte                                 ;; 00:0074 $cd $1e $2b
    ld   HL, wVBlankDone                               ;; 00:007e $21 $ad $c0
    ld a, [hl]
    inc  [HL]                                          ;; 00:0081 $34
    pop  HL                                            ;; 00:0082 $e1
    pop  DE                                            ;; 00:0083 $d1
    pop  BC                                            ;; 00:0084 $c1
; If wVBlankDone was zero then the main loop has reached an infinite halt loop.
; The only way out of that infinite loop is to muck with the stack.
; This is to avoid the z80 halt bug(s).
    or a
    jr nz, .return
; In this case it's safe to clobber af.
    pop af
.return
    pop af
    reti

lotmsInit:
; Set the stack pointer to its final location before any calls.
    ld sp, STARTOF("wram0") + $2000
; Capture the state of registers that can be used to detect the model of Game Boy.
    ldh [hBootup.a], a
    ld a, b
    ldh [hBootup.b], a
    ld a, c
    ldh [hBootup.c], a
; Do some cold boot initialization including Super Game Boy border.
    ld a, BANK(early_init)
    ld [rROMB0], a
    jp early_init

SECTION "entry", ROM0[$0100]

entry:
    nop                                                ;; 00:0100 $00
    jp lotmsInit

Header:
    ds   $30                                           ;; 00:0104
; This title matches the GBC hash to select the red and blue sprite palettes and a white, green, blue, black background palette.
    db   "FFA-->LOTMS", $00, $00, $00, $00             ;; 00:0134
IF DEF(COLOR)
    db   CART_COMPATIBLE_DMG_GBC                       ;; 00:0143
ELSE
    db   CART_COMPATIBLE_DMG                           ;; 00:0143
ENDC
    db   "01"                                          ;; 00:0144
    db   CART_INDICATOR_SGB                            ;; 00:0146
; Use MBC5 instead of MBC2.
    db   CART_ROM_MBC5_RAM_BAT                         ;; 00:0147 $1b
    db   CART_ROM_512KB                                ;; 00:0148 $04
    db   CART_SRAM_8KB                                 ;; 00:0149 $02
    db   CART_DEST_NON_JAPANESE, $33, $00              ;; 00:014a $01 $33 $00
    ds   3                                             ;; 00:014d

SECTION "bank00_0150", ROM0[$0150]

FullReset:
IF DEF(COLOR)
    jp colorInit
ELSE
    jp   Init                                          ;; 00:0150 $c3 $ca $1f
ENDC

scriptOpCodeSetFastMovement:
    push HL                                            ;; 00:0153 $e5
    ld   A, $02                                        ;; 00:0154 $3e $02
    call setPlayerSpeed                                ;; 00:0156 $cd $a5 $02
    pop  HL                                            ;; 00:0159 $e1
    call getNextScriptInstruction                      ;; 00:015a $cd $27 $37
    ret                                                ;; 00:015d $c9

scriptOpCodeClearFastMovement:
    push HL                                            ;; 00:015e $e5
    ld   A, $01                                        ;; 00:015f $3e $01
    call setPlayerSpeed                                ;; 00:0161 $cd $a5 $02
    pop  HL                                            ;; 00:0164 $e1
    call getNextScriptInstruction                      ;; 00:0165 $cd $27 $37
    ret                                                ;; 00:0168 $c9

getPlayerNearestTilePosition:
    ld   C, $04                                        ;; 00:0169 $0e $04
    call getObjectNearestTilePosition                  ;; 00:016b $cd $ef $05
    ret                                                ;; 00:016e $c9

getPlayerForm:
    call getPlayerCollisionFlags                       ;; 00:016f $cd $b7 $02
    cp   A, $e1                                        ;; 00:0172 $fe $e1
    jr   Z, .chocobo                                   ;; 00:0174 $28 $12
    cp   A, $f1                                        ;; 00:0176 $fe $f1
    jr   Z, .chocobot                                  ;; 00:0178 $28 $11
    cp   A, $f5                                        ;; 00:017a $fe $f5
    jr   Z, .chocoboat                                 ;; 00:017c $28 $10
    ld   A, [wPlayerSpecialFlags]                      ;; 00:017e $fa $d4 $c4
    bit  4, A                                          ;; 00:0181 $cb $67
    jr   NZ, .minecart                                 ;; 00:0183 $20 $0c
    ld   A, $00                                        ;; 00:0185 $3e $00
    ret                                                ;; 00:0187 $c9
.chocobo:
    ld   A, $01                                        ;; 00:0188 $3e $01
    ret                                                ;; 00:018a $c9
.chocobot:
    ld   A, $02                                        ;; 00:018b $3e $02
    ret                                                ;; 00:018d $c9
.chocoboat:
    ld   A, $03                                        ;; 00:018e $3e $03
    ret                                                ;; 00:0190 $c9
.minecart:
    ld   A, $04                                        ;; 00:0191 $3e $04
    ret                                                ;; 00:0193 $c9

scriptOpCodePlayerOnChocobo:
    push HL                                            ;; 00:0194 $e5
    call setPlayerOnChocobo_trampoline                 ;; 00:0195 $cd $9d $01
    pop  HL                                            ;; 00:0198 $e1
    call getNextScriptInstruction                      ;; 00:0199 $cd $27 $37
    ret                                                ;; 00:019c $c9

setPlayerOnChocobo_trampoline:
    jp_to_bank 01, setPlayerOnChocobo                  ;; 00:019d $f5 $3e $09 $c3 $d7 $1e

scriptOpCodePlayerOnChocobot:
    push HL                                            ;; 00:01a3 $e5
    call setPlayerOnChocobot_trampoline                ;; 00:01a4 $cd $ac $01
    pop  HL                                            ;; 00:01a7 $e1
    call getNextScriptInstruction                      ;; 00:01a8 $cd $27 $37
    ret                                                ;; 00:01ab $c9

setPlayerOnChocobot_trampoline:
    jp_to_bank 01, setPlayerOnChocobot                 ;; 00:01ac $f5 $3e $0a $c3 $d7 $1e

scriptOpCodePlayerOnChocobotWater:
    push HL                                            ;; 00:01b2 $e5
    call setPlayerOnChocoboat_trampoline               ;; 00:01b3 $cd $bb $01
    pop  HL                                            ;; 00:01b6 $e1
    call getNextScriptInstruction                      ;; 00:01b7 $cd $27 $37
    ret                                                ;; 00:01ba $c9

setPlayerOnChocoboat_trampoline:
    jp_to_bank 01, setPlayerOnChocoboat                ;; 00:01bb $f5 $3e $0b $c3 $d7 $1e

scriptOpCodeSetPlayerNormalSprite:
    push HL                                            ;; 00:01c1 $e5
    call setPlayerNormalSprite_trampoline              ;; 00:01c2 $cd $ca $01
    pop  HL                                            ;; 00:01c5 $e1
    call getNextScriptInstruction                      ;; 00:01c6 $cd $27 $37
    ret                                                ;; 00:01c9 $c9

setPlayerNormalSprite_trampoline:
    jp_to_bank 01, setPlayerNormalSprite               ;; 00:01ca $f5 $3e $08 $c3 $d7 $1e

scriptOpCodePlayerInMinecart:
    ld   A, [wPlayerSpecialFlags]                      ;; 00:01d0 $fa $d4 $c4
    set  4, A                                          ;; 00:01d3 $cb $e7
    ld   [wPlayerSpecialFlags], A                      ;; 00:01d5 $ea $d4 $c4
    call getNextScriptInstruction                      ;; 00:01d8 $cd $27 $37
    ret                                                ;; 00:01db $c9

scriptOpCodeSetPlayerHurtSprite:
    ld   A, [wPlayerSpecialFlags]                      ;; 00:01dc $fa $d4 $c4
    set  5, A                                          ;; 00:01df $cb $ef
    ld   [wPlayerSpecialFlags], A                      ;; 00:01e1 $ea $d4 $c4
    call getNextScriptInstruction                      ;; 00:01e4 $cd $27 $37
    ret                                                ;; 00:01e7 $c9

scriptOpCodeSetPlayerLaydownSprite:
    ld   A, [wPlayerSpecialFlags]                      ;; 00:01e8 $fa $d4 $c4
    set  6, A                                          ;; 00:01eb $cb $f7
    ld   [wPlayerSpecialFlags], A                      ;; 00:01ed $ea $d4 $c4
    call getNextScriptInstruction                      ;; 00:01f0 $cd $27 $37
    ret                                                ;; 00:01f3 $c9

setDarkGraphicEffect:
IF DEF(COLOR)
    ; Load the blind background palettes into the active palette RAM.
    ld hl, wColorPalettes.blind
    call setPalettes
ELSE
    ld   A, $3f                                        ;; 00:01f4 $3e $3f
    ld   [wVideoBGP], A                                ;; 00:01f6 $ea $aa $c0
    ld   A, $bf                                        ;; 00:01f9 $3e $bf
    ld   [wVideoOBP1], A                               ;; 00:01fb $ea $ac $c0
ENDC
    ld   HL, wPlayerSpecialFlags                       ;; 00:01fe $21 $d4 $c4
    set  1, [HL]                                       ;; 00:0201 $cb $ce
    ret                                                ;; 00:0203 $c9

removeDarkGraphicEffect:
IF DEF(COLOR)
    ; Load the normal background palettes into the active palette RAM.
    ld hl, wColorPalettes.normal
    call setPalettes
ELSE
    ld   A, $e4                                        ;; 00:0204 $3e $e4
    ld   [wVideoBGP], A                                ;; 00:0206 $ea $aa $c0
    ld   A, $d0                                        ;; 00:0209 $3e $d0
    ld   [wVideoOBP1], A                               ;; 00:020b $ea $ac $c0
ENDC
    ld   HL, wPlayerSpecialFlags                       ;; 00:020e $21 $d4 $c4
    res  1, [HL]                                       ;; 00:0211 $cb $8e
    ret                                                ;; 00:0213 $c9

SECTION "bank00_align_0214", ROM0[$0214]

setStonEffectFlag:
    ld   HL, wPlayerSpecialFlags                       ;; 00:0214 $21 $d4 $c4
    set  2, [HL]                                       ;; 00:0217 $cb $d6
    ret                                                ;; 00:0219 $c9

removeStonEffectFlag:
    ld   HL, wPlayerSpecialFlags                       ;; 00:021a $21 $d4 $c4
    res  2, [HL]                                       ;; 00:021d $cb $96
    ret                                                ;; 00:021f $c9

setMoogEffectFlag:
    ld   HL, wPlayerSpecialFlags                       ;; 00:0220 $21 $d4 $c4
    set  3, [HL]                                       ;; 00:0223 $cb $de
    ret                                                ;; 00:0225 $c9

removeMoogEffectFlag:
    ld   HL, wPlayerSpecialFlags                       ;; 00:0226 $21 $d4 $c4
    res  3, [HL]                                       ;; 00:0229 $cb $9e
    ret                                                ;; 00:022b $c9

runMainInputHandler_trampoline:
    jp_to_bank 01, runMainInputHandler                 ;; 00:022c $f5 $3e $00 $c3 $d7 $1e

playerSpritesLoadPlayerSpriteTiles_trampoline:
    jp_to_bank 01, playerSpritesLoadPlayerSpriteTiles  ;; 00:0232 $f5 $3e $01 $c3 $d7 $1e

processPhysicsForPlayer_trampoline:
    jp_to_bank 01, processPhysicsForPlayer             ;; 00:0238 $f5 $3e $02 $c3 $d7 $1e

updatePlayerPostion_trampoline:
    jp_to_bank 01, updatePlayerPostion                 ;; 00:023e $f5 $3e $03 $c3 $d7 $1e

playerCollisionHandling_trampoline:
    jp_to_bank 01, playerCollisionHandling             ;; 00:0244 $f5 $3e $05 $c3 $d7 $1e

doSwordFlyingAttack_trampoline:
    jp_to_bank 01, doSwordFlyingAttack                 ;; 00:024a $f5 $3e $06 $c3 $d7 $1e

createPlayerObject_trampoline:
    jp_to_bank 01, createPlayerObject                  ;; 00:0250 $f5 $3e $04 $c3 $d7 $1e

playerHit_trampoline:
    jp_to_bank 01, playerHit                           ;; 00:0256 $f5 $3e $07 $c3 $d7 $1e

setGameStateFireAutoTarget:
    ld   A, $06                                        ;; 00:025c $3e $06
    ld   [wMainGameState], A                           ;; 00:025e $ea $a0 $c0
    ret                                                ;; 00:0261 $c9

clearPlayerDamaged:
    ld   A, $00                                        ;; 00:0262 $3e $00
    ld   [wPlayerDamagedTimer], A                      ;; 00:0264 $ea $d2 $c4
    ld   A, $c9                                        ;; 00:0267 $3e $c9
    ld   C, $04                                        ;; 00:0269 $0e $04
    call setObjectCollisionFlags                       ;; 00:026b $cd $86 $0c
    ld   A, $01                                        ;; 00:026e $3e $01
    ld   C, $04                                        ;; 00:0270 $0e $04
    call setObjectSpeed                                ;; 00:0272 $cd $5d $0c
    ret                                                ;; 00:0275 $c9

setGameStateSpecialAttack:
    call clearPlayerDamaged                            ;; 00:0276 $cd $62 $02
    ld   A, $05                                        ;; 00:0279 $3e $05
    ld   [wMainGameState], A                           ;; 00:027b $ea $a0 $c0
    ret                                                ;; 00:027e $c9
    db   $f5, $3e, $0e, $c3, $d7, $1e                  ;; 00:027f ??????

playerObjectDestroy:
    ld   C, $04                                        ;; 00:0285 $0e $04
    call destroyObject                                 ;; 00:0287 $cd $e3 $0a
    ret                                                ;; 00:028a $c9

; Add helper functions for getting both X and Y coordinates.
; Variations on this pattern occur a lot in the original code:
;    push BC
;    call GetObjectY
;    ld   D, A
;    pop  BC
;    push DE
;    call GetObjectX
;    pop  DE
;    ld   E, A

getPlayerXY:
    ld c, $04
    ; Fall through to getObjectXY

; c = object number
; Return: de = YX pixel coordinate of the object
getObjectXY:
    call GetObjectY
    ld d, a
; Take advantage of hl being left set by the get function.
    inc hl
    ld e, [hl]
    ret

getPlayerX:
    ld   C, $04                                        ;; 00:0293 $0e $04
    jp GetObjectX

getPlayerY:
    ld   C, $04                                        ;; 00:0299 $0e $04
    jp GetObjectY

ds 1 ; Free space

setPlayerSliding:
    ld C, $04
    call setObjectSliding
    ret

setPlayerSpeed:
    ld   C, $04                                        ;; 00:02a5 $0e $04
    call setObjectSpeed                                ;; 00:02a7 $cd $5d $0c
    ret                                                ;; 00:02aa $c9

getPlayerDirection:
    ld   C, $04                                        ;; 00:02ab $0e $04
    call getObjectDirection                            ;; 00:02ad $cd $99 $0c
    ret                                                ;; 00:02b0 $c9

setPlayerDirection:
    ld   C, $04                                        ;; 00:02b1 $0e $04
    call setObjectDirection                            ;; 00:02b3 $cd $a6 $0c
    ret                                                ;; 00:02b6 $c9

getPlayerCollisionFlags:
    ld   C, $04                                        ;; 00:02b7 $0e $04
    call getObjectCollisionFlags                       ;; 00:02b9 $cd $6d $0c
    ret                                                ;; 00:02bc $c9

setPlayerCollisionFlags:
    ld   C, $04                                        ;; 00:02bd $0e $04
    call setObjectCollisionFlags                       ;; 00:02bf $cd $86 $0c
    ret                                                ;; 00:02c2 $c9

movePlayerDuringScript_trampoline:
    jp_to_bank 01, movePlayerDuringScript              ;; 00:02c3 $f5 $3e $0c $c3 $d7 $1e

runScriptAndStopKnockback_trampoline:
    jp_to_bank 01, runScriptAndStopKnockback           ;; 00:02c9 $f5 $3e $0d $c3 $d7 $1e

getMainGameStateForPlayerForm:
    call getPlayerCollisionFlags                       ;; 00:02cf $cd $b7 $02
    cp   A, $e1                                        ;; 00:02d2 $fe $e1
    jr   Z, .chocobo                                   ;; 00:02d4 $28 $0b
    cp   A, $f1                                        ;; 00:02d6 $fe $f1
    jr   Z, .chocobot                                  ;; 00:02d8 $28 $0a
    cp   A, $f5                                        ;; 00:02da $fe $f5
    jr   Z, .chocoboat                                 ;; 00:02dc $28 $09
    ld   A, $00                                        ;; 00:02de $3e $00
    ret                                                ;; 00:02e0 $c9
.chocobo:
    ld   A, $0c                                        ;; 00:02e1 $3e $0c
    ret                                                ;; 00:02e3 $c9
.chocobot:
    ld   A, $0d                                        ;; 00:02e4 $3e $0d
    ret                                                ;; 00:02e6 $c9
.chocoboat:
    ld   A, $0e                                        ;; 00:02e7 $3e $0e
    ret                                                ;; 00:02e9 $c9
    db   $c9                                           ;; 00:02ea ?

initLCDCEffect:
    ld   A, STATF_LYC                                  ;; 00:02eb $3e $40
    ldh  [rSTAT], A                                    ;; 00:02ed $e0 $41
    call setDefaultLCDCEffect                          ;; 00:02ef $cd $13 $03
    ret                                                ;; 00:02f2 $c9

; Load a new effect.
; Disable interrupts while this happens because recent testing has shown lockups
; due to the STAT interrupt firing while this is running.
; hl = buffer address
; b = buffer length
loadLCDCEffectBuffer:
    ld de, wLCDCEffectBuffer
; Fix a one frame white flash at the beginning of the shutter effect by setting the index to the status bar effect.
    ld a, b
    srl a
    srl a
    dec a
    di
    ld [wLCDCEffectIndex], a
.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ei
    ret

INCLUDE "code/line-effects/default.asm"

; Manages line effects.
LCDCInterrupt:
    push af
    push bc
    push de
    push hl
IF DEF(COLOR)
; Save the target line to write.
    ld a, [rLYC]
    inc a
    ld b, a
ENDC
; Each entry in the line effect buffer is four bytes long.
    ld   A, [wLCDCEffectIndex]                         ;; 00:032d $fa $e2 $d3
    add  A, A                                          ;; 00:0330 $87
    add  A, A                                          ;; 00:0331 $87
    ld   E, A                                          ;; 00:0332 $5f
    ld   D, $00                                        ;; 00:0333 $16 $00
    ld   HL, wLCDCEffectBuffer                         ;; 00:0335 $21 $a0 $d3
    add  HL, DE                                        ;; 00:0338 $19
; The second and third bytes are for ANDing and XORing with the current LCDC state.
    inc  HL                                            ;; 00:0339 $23
    ld   A, [wVideoLCDC]                               ;; 00:033a $fa $a5 $c0
    and  A, [HL]                                       ;; 00:033d $a6
    inc  HL                                            ;; 00:033e $23
    xor  A, [HL]                                       ;; 00:033f $ae
    ld   D, A                                          ;; 00:0340 $57
; The third byte is a BGP.
    inc  HL                                            ;; 00:0341 $23
    ld   E, [HL]                                       ;; 00:0342 $5e
; The first byte of each entry is the line number to trigger an interrupt.
; Or $ff to loop to the begining.
    inc  HL                                            ;; 00:0343 $23
    ld   A, [HL]                                       ;; 00:0344 $7e
    cp   A, $ff                                        ;; 00:0345 $fe $ff
    ld hl, wLCDCEffectIndex
    jr   NZ, .set_next_interrupt                       ;; 00:0347 $20 $06
    ld [hl], a
    ld   A, [wLCDCEffectBuffer]                        ;; 00:034c $fa $a0 $d3
.set_next_interrupt:
    ldh  [rLYC], A                                     ;; 00:034f $e0 $45
    inc  [HL]                                          ;; 00:0354 $34
IF DEF(COLOR)
; For color use the DMG BGP value as a key to look up the address of the real color palette.
    ld hl, .lookup_table - 1
.loop:
    inc hl
    ld a, [hl+]
    cp e
; Speculatively load the first byte of the address because it is the same speed as an increment.
    ld a, [hl+]
    jr nz, .loop
    ld h, [hl]
    ld l, a
; Reset the address and set autoinc before waiting for time to write.
    ld a, BCPSF_AUTOINC
    ldh [rBCPS], a
; With the color lookup table it's possible to get here earlier than intended so guard and check.
; It may also be possible to get here too late.
.loop_until_target_line:
    ldh a, [rLY]
    cp b
    jr c, .loop_until_target_line
    jr z, .ready
    DBG_MSG_LABEL debugMsgLCDCInterruptLate
.ready:
; Save one cycle in mode 0 by pre-loading this address.
    ld b, LOW(rBCPD)
ENDC
; Nothing should ever turn off the LCD/PPU with this interrupt on, but guard against it anyway.
; This condition will now trigger a debug message.
; If it is not seen in testing this check will be removed.
    ldh  A, [rLCDC]                                    ;; 00:0358 $f0 $40
    and LCDCF_ON
    jr z, .debug
; The LYC values used are two before the target scanline, so wait a bit.
    ld   C, LOW(rSTAT)                                 ;; 00:035e $0e $41
.loop_while_mode_0:
    ldh  A, [C]                                        ;; 00:0360 $f2
    and  A, $03                                        ;; 00:0361 $e6 $03
    jr   Z, .loop_while_mode_0                         ;; 00:0363 $28 $fb
.loop_until_mode_0:
    ldh  A, [C]                                        ;; 00:0365 $f2
    and  A, $03                                        ;; 00:0366 $e6 $03
    jr   NZ, .loop_until_mode_0                        ;; 00:0368 $20 $fb
.ready_to_write:
; Write the new LCDC value.
    ld a, d
    ldh [rLCDC], a
IF DEF(COLOR)
; Write the first background palette.
    ld c, b
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
ELSE
; Write the new BGP value
    ld   A, E                                          ;; 00:036b $7b
    ldh  [rBGP], A                                     ;; 00:036c $e0 $47
ENDC
    pop hl
    pop de
    pop bc
    pop af
    reti

; Almost certainly dead code but this will be tested before being removed.
.debug:
    DBG_MSG_LABEL debugMsgInteruptWithScreenOff
    jr .ready_to_write

; Lookup table for line effect palettes. BGP values are used as keys.
.lookup_table:
    db $00 ; Final step of the intro text scroll fading away.
    dw colorPalettes.intro_white
    db $2a ; Magic value used for fades when the letterbox effect is on.
    dw wPaletteBackground0LCDC
    db $3f ; Used by the Blind effect.
    dw wColorPalettes.blind_bgp0
    db $40 ; Second step of the intro text scroll fading away.
    dw colorPalettes.intro_light
    db $90 ; First step of the intro text scroll fading away.
    dw colorPalettes.intro_dark
    db $e0 ; Used for the status bar. Looks the same as $e4 when running in black and white.
    dw colorPalettes.statusbar
    db $e4 ; Default.
    dw wColorPalettes.normal_bgp0
    db $fc ; Used for the blank part of shutter effects (both normal and Blind).
    dw colorPalettes.shutter
    db $ff ; The top 16 lines of the ending letterbox effect are blacked out.
    dw colorPalettes.letterbox

; Color palettes used by line effects.
colorPalettes:
.intro_white:
    INCBIN "pal/line-effects/intro-scroll0.pal",0,8 ; $00
.intro_light:
    INCBIN "pal/line-effects/intro-scroll1.pal",0,8 ; $40
.intro_dark:
    INCBIN "pal/line-effects/intro-scroll2.pal",0,8 ; $90
.statusbar:
    INCBIN "pal/line-effects/statusbar.pal",0,8 ; $e0
.shutter:
    INCBIN "pal/line-effects/shutter.pal",0,8 ; $fc
.letterbox:
    INCBIN "pal/line-effects/letterbox.pal",0,8 ; $ff

checkPlayfieldBoundaryCollision_trampoline:
    jp_to_bank 04, checkPlayfieldBoundaryCollision     ;; 00:036f $f5 $3e $06 $c3 $64 $1f

; Calls destoryObject on most objects, except the player, companion, their attacks, and reserved (0 to 6) objects.
; Fails to identify the player riding a Chcobo
removeNpcObjects:
    ld   C, $00                                        ;; 00:0375 $0e $00
    ld   B, $14                                        ;; 00:0377 $06 $14
.loop:
    push BC                                            ;; 00:0379 $c5
    call getObjectCollisionFlags                       ;; 00:037a $cd $6d $0c
    and  A, $f0                                        ;; 00:037d $e6 $f0
    cp   A, $c0                                        ;; 00:037f $fe $c0
    jr   Z, .next                                      ;; 00:0381 $28 $11
    cp   A, $d0                                        ;; 00:0383 $fe $d0
    jr   Z, .next                                      ;; 00:0385 $28 $0d
    cp   A, $40                                        ;; 00:0387 $fe $40
    jr   Z, .next                                      ;; 00:0389 $28 $09
    cp   A, $50                                        ;; 00:038b $fe $50
    jr   Z, .next                                      ;; 00:038d $28 $05
    pop  BC                                            ;; 00:038f $c1
    push BC                                            ;; 00:0390 $c5
    call destroyObject                                 ;; 00:0391 $cd $e3 $0a
.next:
    pop  BC                                            ;; 00:0394 $c1
    inc  C                                             ;; 00:0395 $0c
    dec  B                                             ;; 00:0396 $05
    jr   NZ, .loop                                     ;; 00:0397 $20 $e0
    ret                                                ;; 00:0399 $c9

; B = object number b
; C = object number c
; Return: DE = Y and X distances between the two objects.
; Return: A = direction bits b would travel to reach c, including diagonals.
checkObjectsCollisionDirection:
    push BC                                            ;; 00:039a $c5
    call GetObjectY                                    ;; 00:039b $cd $3e $0c
    ld   D, A                                          ;; 00:039e $57
    pop  BC                                            ;; 00:039f $c1
    push DE                                            ;; 00:03a0 $d5
    push BC                                            ;; 00:03a1 $c5
    call GetObjectX                                    ;; 00:03a2 $cd $2d $0c
    pop  BC                                            ;; 00:03a5 $c1
    pop  DE                                            ;; 00:03a6 $d1
    ld   E, A                                          ;; 00:03a7 $5f
    push DE                                            ;; 00:03a8 $d5
    ld   A, C                                          ;; 00:03a9 $79
    ld   C, B                                          ;; 00:03aa $48
    ld   B, A                                          ;; 00:03ab $47
    push BC                                            ;; 00:03ac $c5
    call GetObjectY                                    ;; 00:03ad $cd $3e $0c
    pop  BC                                            ;; 00:03b0 $c1
    pop  DE                                            ;; 00:03b1 $d1
    sub  A, D                                          ;; 00:03b2 $92
    ld   D, A                                          ;; 00:03b3 $57
    push BC                                            ;; 00:03b4 $c5
    push DE                                            ;; 00:03b5 $d5
    call GetObjectX                                    ;; 00:03b6 $cd $2d $0c
    pop  DE                                            ;; 00:03b9 $d1
    pop  BC                                            ;; 00:03ba $c1
    sub  A, E                                          ;; 00:03bb $93
    ld   E, A                                          ;; 00:03bc $5f
    bit  7, D                                          ;; 00:03bd $cb $7a
    jr   NZ, .c_n_of_b                                 ;; 00:03bf $20 $2b
    bit  7, E                                          ;; 00:03c1 $cb $7b
    jr   NZ, .c_w_of_b                                 ;; 00:03c3 $20 $19
    ld   A, D                                          ;; 00:03c5 $7a
    cp   A, E                                          ;; 00:03c6 $bb
    jr   Z, .c_exactly_se_of_b                         ;; 00:03c7 $28 $05
    jr   NC, .ret_south                                ;; 00:03c9 $30 $1b
.ret_east:
    ld   A, $01                                        ;; 00:03cb $3e $01
    ret                                                ;; 00:03cd $c9
.c_exactly_se_of_b:
    cp   A, $00                                        ;; 00:03ce $fe $00
    jr   Z, .c_same_location_of_b                      ;; 00:03d0 $28 $03
;.ret_southeast:
    ld   A, $09                                        ;; 00:03d2 $3e $09
    ret                                                ;; 00:03d4 $c9
; If the two objects share the exact same coordinates, return object b's facing direction
.c_same_location_of_b:
    push DE                                            ;; 00:03d5 $d5
    ld   C, B                                          ;; 00:03d6 $48
    call getObjectDirection                            ;; 00:03d7 $cd $99 $0c
    and  A, $0f                                        ;; 00:03da $e6 $0f
    pop  DE                                            ;; 00:03dc $d1
    ret                                                ;; 00:03dd $c9
.c_w_of_b:
    ld   A, E                                          ;; 00:03de $7b
    cpl                                                ;; 00:03df $2f
    inc  A                                             ;; 00:03e0 $3c
    cp   A, D                                          ;; 00:03e1 $ba
    jr   Z, .ret_southwest                             ;; 00:03e2 $28 $05
    jr   NC, .ret_west                                 ;; 00:03e4 $30 $1e
.ret_south:
    ld   A, $08                                        ;; 00:03e6 $3e $08
    ret                                                ;; 00:03e8 $c9
.ret_southwest:
    ld   A, $0a                                        ;; 00:03e9 $3e $0a
    ret                                                ;; 00:03eb $c9
.c_n_of_b:
    bit  7, E                                          ;; 00:03ec $cb $7b
    jr   NZ, .c_nw_of_b                                ;; 00:03ee $20 $0e
    ld   A, D                                          ;; 00:03f0 $7a
    cpl                                                ;; 00:03f1 $2f
    inc  A                                             ;; 00:03f2 $3c
    cp   A, E                                          ;; 00:03f3 $bb
    jr   Z, .ret_northeast                             ;; 00:03f4 $28 $05
    jr   C, .ret_east                                  ;; 00:03f6 $38 $d3
.ret_north:
    ld   A, $04                                        ;; 00:03f8 $3e $04
    ret                                                ;; 00:03fa $c9
.ret_northeast:
    ld   A, $05                                        ;; 00:03fb $3e $05
    ret                                                ;; 00:03fd $c9
.c_nw_of_b:
    ld   A, E                                          ;; 00:03fe $7b
    cp   A, D                                          ;; 00:03ff $ba
    jr   Z, .ret_northwest                             ;; 00:0400 $28 $05
    jr   NC, .ret_north                                ;; 00:0402 $30 $f4
.ret_west:
    ld   A, $02                                        ;; 00:0404 $3e $02
    ret                                                ;; 00:0406 $c9
.ret_northwest:
    ld   A, $06                                        ;; 00:0407 $3e $06
    ret                                                ;; 00:0409 $c9
    db   $f5, $c5, $3e, $03, $cd, $fb, $29, $c1        ;; 00:040a ????????
    db   $f1, $cd, $95, $06, $f5, $cd, $0a, $2a        ;; 00:0412 ????????
    db   $f1, $c9                                      ;; 00:041a ??

checkNpcsForCollisions_trampoline:
    ld   L, A                                          ;; 00:041c $6f
    bit  3, A                                          ;; 00:041d $cb $5f
    ld   A, $00                                        ;; 00:041f $3e $00
    ret  Z                                             ;; 00:0421 $c8
    ld   A, L                                          ;; 00:0422 $7d
    jp_to_bank 02, checkNpcsForCollisions              ;; 00:0423 $f5 $3e $07 $c3 $06 $1f

scrollMoveSprites_trampoline:
    jp_to_bank 02, scrollMoveSprites                   ;; 00:0429 $f5 $3e $06 $c3 $06 $1f

hideSpritesBehindWindow_trampoline:
    jp_to_bank 02, hideSpritesBehindWindow             ;; 00:042f $f5 $3e $04 $c3 $06 $1f

showSpritesBehindWindow_trampoline:
    jp_to_bank 02, showSpritesBehindWindow             ;; 00:0435 $f5 $3e $05 $c3 $06 $1f

spriteShuffleDoFlash_trampoline:
    ld   A, [wBossFirstObjectID]                       ;; 00:043b $fa $e8 $d3
    cp   A, $ff                                        ;; 00:043e $fe $ff
    ret  NZ                                            ;; 00:0440 $c0
    jp_to_bank 02, spriteShuffleDoFlash                ;; 00:0441 $f5 $3e $02 $c3 $06 $1f

spriteShuffleShowHidden_trampoline:
    jp_to_bank 02, spriteShuffleShowHidden             ;; 00:0447 $f5 $3e $03 $c3 $06 $1f

getBackgroundDrawAddress:
    ld   A, [wBackgroundDrawPositionY]                 ;; 00:045d $fa $43 $c3
    add  A, D                                          ;; 00:0460 $82
    and  A, $1f                                        ;; 00:0461 $e6 $1f
    ld   D, A                                          ;; 00:0463 $57
    ld   L, A                                          ;; 00:0464 $6f
    ld   H, $00                                        ;; 00:0465 $26 $00
    add  HL, HL                                        ;; 00:0467 $29
    add  HL, HL                                        ;; 00:0468 $29
    add  HL, HL                                        ;; 00:0469 $29
    add  HL, HL                                        ;; 00:046a $29
    add  HL, HL                                        ;; 00:046b $29
    ld   A, [wBackgroundDrawPositionX]                 ;; 00:046c $fa $42 $c3
    add  A, E                                          ;; 00:046f $83
    and  A, $1f                                        ;; 00:0470 $e6 $1f
    ld   E, A                                          ;; 00:0472 $5f
    ld   C, A                                          ;; 00:0473 $4f
    ld   B, $00                                        ;; 00:0474 $06 $00
    add  HL, BC                                        ;; 00:0476 $09
    ld   BC, _SCRN0 ;@=ptr _SCRN0                      ;; 00:0477 $01 $00 $98
    add  HL, BC                                        ;; 00:047a $09
    ret                                                ;; 00:047b $c9

storeAatBackgroundDrawPosition:
    push AF                                            ;; 00:047c $f5
    call getBackgroundDrawAddress                      ;; 00:047d $cd $5d $04
    pop  AF                                            ;; 00:0480 $f1
    call storeAatHLinVRAM                              ;; 00:0481 $cd $5e $1d
    ret                                                ;; 00:0484 $c9

drawRoomWithGuardOnTileTransfer:
    ld   A, [wTileCopyRequestCount]
    and  A, A
    jr   NZ, drawRoomWithGuardOnTileTransfer
    jr   drawRoom_trampoline

scrollRoom_trampoline:
    jp_to_bank 01, scrollRoom                          ;; 00:049e $f5 $3e $18 $c3 $d7 $1e

drawRoom_trampoline:
    jp_to_bank 01, drawRoom                            ;; 00:04a4 $f5 $3e $19 $c3 $d7 $1e

bossUpdate:
; If no boss is active then this is set to $ff.
    ld   A, [wBossFirstObjectID]                       ;; 00:04aa $fa $e8 $d3
    inc a
    ret  Z                                             ;; 00:04af $c8
; If the bosscurrently invincible from having prevously taken damage then process that.
    ld hl, wBossIframes
    ld a, [hl]
    or a
    jr   Z, .tick_boss_speed                           ;; 00:04b5 $28 $20
; Tick the counter.
    dec [hl]
    ld   C, A                                          ;; 00:04b7 $4f
IF DEF(COLOR)
; Set palettes for the damage flash.
; Background palettes are set as well in case a full-screen flash is wanted.
    ld hl, wColorPalettes.normal
    bit 3, c
    jr z, .set_palette
    ld hl, wColorPalettes.damage
.set_palette:
    call setPalettes
ELSE
; Do the damage flash.
    ld   A, $d0                                        ;; 00:04b8 $3e $d0
    bit  3, C                                          ;; 00:04ba $cb $59
    jr   Z, .jr_00_04c0                                ;; 00:04bc $28 $02
    ld   A, $bf                                        ;; 00:04be $3e $bf
.jr_00_04c0:
    ld   [wVideoOBP1], A                               ;; 00:04c0 $ea $ac $c0
ENDC
    ld   A, C                                          ;; 00:04c3 $79
    dec  A                                             ;; 00:04c4 $3d
    jr   NZ, .tick_boss_speed                          ;; 00:04c8 $20 $0d
; On the final tick run the damage routine if bit 7 of [wDamageDoneToBoss] is set.
    ld   A, [wDamageDoneToBoss.high]                   ;; 00:04ca $fa $f3 $d3
    rla
    call c, bossTakeDamage_trampoline
.tick_boss_speed:
    ld   HL, wBossSpeedTimer                           ;; 00:04d7 $21 $e9 $d3
    dec  [HL]                                          ;; 00:04da $35
    ret  NZ                                            ;; 00:04db $c0
    jp_to_bank 04, bossRunLogic                        ;; 00:04dc $f5 $3e $00 $c3 $64 $1f

spawnBoss_trampoline:
    jp_to_bank 04, spawnBoss                           ;; 00:04e2 $f5 $3e $01 $c3 $64 $1f

bossClearStatsObjects_trampoline:
    ld   A, [wBossFirstObjectID]                       ;; 00:04e8 $fa $e8 $d3
    cp   A, $ff                                        ;; 00:04eb $fe $ff
    ret  Z                                             ;; 00:04ed $c8
    jp_to_bank 04, bossClearStatsObjects               ;; 00:04ee $f5 $3e $02 $c3 $64 $1f

bossTakeDamage_trampoline:
    jp_to_bank 04, bossTakeDamage                      ;; 00:04f4 $f5 $3e $03 $c3 $64 $1f

bossClearObjectsTracking:
    ld   A, $ff                                        ;; 00:04fa $3e $ff
    ld   [wBossFirstObjectID], A                       ;; 00:04fc $ea $e8 $d3
    ld   HL, wBossObjectsStatsRuntimeData              ;; 00:04ff $21 $42 $d4
    ld   DE, $06                                       ;; 00:0502 $11 $06 $00
    ld   B, $0e                                        ;; 00:0505 $06 $0e
.loop:
    ld   [HL], A                                       ;; 00:0507 $77
    add  HL, DE                                        ;; 00:0508 $19
    dec  B                                             ;; 00:0509 $05
    jr   NZ, .loop                                     ;; 00:050a $20 $fb
    ret                                                ;; 00:050c $c9
    db   $21, $00, $00, $c9                            ;; 00:050d ????

bossCollisionHandling_trampoline:
    jp_to_bank 04, bossCollisionHandling               ;; 00:0511 $f5 $3e $05 $c3 $64 $1f

processPhysicsForObject_4_trampoline:
    jp_to_bank 04, processPhysicsForObject_4           ;; 00:0517 $f5 $3e $04 $c3 $64 $1f

; Draw the meta tile A (metatile index) at DE (YX tile number)
; Transfers the bytes during HBlank
; Drawing a metatile means writing four tile ids.
; On the color target it also means writing four tile attributes.
drawMetatile:
    sla  D
    sla  E
    push AF
    call getBackgroundDrawAddress
    pop  AF
    push HL
    call getTileInfoPointer
    push HL
    ld   A, BANK(metatilesOutdoor) ;@=bank metatilesOutdoor ;; 00:0571 $3e $08
    call pushBankNrAndSwitch                           ;; 00:0573 $cd $fb $29
    pop  HL                                            ;; 00:0576 $e1
IF DEF(COLOR)
; Start by loading and pushing the attributes
    pop de
; Metatiles are aligned 16 and the attributes are at that plus eight so use a set.
    set 3, l

    ld a, [hl+]
    ld b, a
    ld a, [hl+]
    ld c, a
    push bc
    ld a, [hl+]
    ld b, a
    ld c, [hl]
    push bc

; Reset back to the beginning of the metatile entry.
    ld a, l
    and $f0
    ld l, a
    push de
ENDC
    ld   A, [HL+]
    ld   B, A
    ld   A, [HL+]
    ld   C, A
    ld   A, [HL+]
    ld   D, $00
    ld   E, [HL]
    push BC
    ld   HL, wBackgroundGraphicsTileMapping
    add  HL, DE
    ld   C, [HL]
    ld   HL, wBackgroundGraphicsTileMapping
    ld   E, A
    add  HL, DE
    ld   B, [HL]
    pop  DE
    push BC
    ld   A, D
    ld   D, $00
    ld   HL, wBackgroundGraphicsTileMapping
    add  HL, DE
    ld   C, [HL]
    ld   HL, wBackgroundGraphicsTileMapping
    ld   E, A
    add  HL, DE
    ld   B, [HL]
    pop  DE
    pop  HL
    call storeMetatileInVRAM
IF DEF(COLOR)
; storeMetatileInVRAM returns hl += $20 and always starts with bit 5 clear so use a reset to restore.
    res 5, l
    pop de
    pop bc
; Switch to the VRAM bank with the attributes.
    ld a, $01
    ldh  [rVBK], a
    call storeMetatileInVRAM
    xor a
    ldh  [rVBK], a
ENDC
    call popBankNrAndSwitch                            ;; 00:05b7 $cd $0a $2a
    ret                                                ;; 00:05ba $c9

; Store BCDE at metatile with upper left corner at HL.
; Waits until PPU mode 0 (HBlank) or 1 (VBlank).
; The writing to VRAM will worst case occur right during
; the transition from mode 0 (HBlank) to mode 2 (OAM). In
; that case, this code will take at most 19 cycles or 76 dots.
; This will always be under the 80 dot period of mode 2 (OAM).
; Return: a = e, bc = bc, de = de, hl = hl + $20
storeMetatileInVRAM:
    ldh a, [rLCDC]
    and LCDCF_ON
    jr z, .write
.loop:
    ldh a, [rSTAT]
    and STATF_BUSY
    jr nz, .loop
.write:
    ld a, b
    ld [hl+], a
    ld [hl], c
    set 5, l ; adds $20, this works with metatiles since L will always start a multiple of $40
    ld a, e
    ld [hl-], a
    ld [hl], d
    ret

ds 11 ; Free space

hideMinimapFlashingMarker:
    ld   L, C                                          ;; 00:05cd $69
    ld   H, $00                                        ;; 00:05ce $26 $00
    add  HL, HL                                        ;; 00:05d0 $29
    add  HL, HL                                        ;; 00:05d1 $29
    add  HL, HL                                        ;; 00:05d2 $29
    add  HL, HL                                        ;; 00:05d3 $29
    ld   BC, wObjectRuntimeData                        ;; 00:05d4 $01 $00 $c2
    add  HL, BC                                        ;; 00:05d7 $09
    ld   DE, $f8                                       ;; 00:05d8 $11 $f8 $00
    ld   BC, $08                                       ;; 00:05db $01 $08 $00
    add  HL, BC                                        ;; 00:05de $09
    ld   A, [HL+]                                      ;; 00:05df $2a
    ld   H, [HL]                                       ;; 00:05e0 $66
    ld   L, A                                          ;; 00:05e1 $6f
    ld   A, E                                          ;; 00:05e2 $7b
    add  A, $08                                        ;; 00:05e3 $c6 $08
    ld   [HL], D                                       ;; 00:05e5 $72
    inc  HL                                            ;; 00:05e6 $23
    ld   [HL], E                                       ;; 00:05e7 $73
    inc  HL                                            ;; 00:05e8 $23
    inc  HL                                            ;; 00:05e9 $23
    inc  HL                                            ;; 00:05ea $23
    ld   [HL], D                                       ;; 00:05eb $72
    inc  HL                                            ;; 00:05ec $23
    ld   [HL], A                                       ;; 00:05ed $77
    ret                                                ;; 00:05ee $c9

getObjectNearestTilePosition:
    ld   L, C                                          ;; 00:05ef $69
    ld   H, $00                                        ;; 00:05f0 $26 $00
    add  HL, HL                                        ;; 00:05f2 $29
    add  HL, HL                                        ;; 00:05f3 $29
    add  HL, HL                                        ;; 00:05f4 $29
    add  HL, HL                                        ;; 00:05f5 $29
    ; Swapped out use of BC since it was unnecessary
    ; Callers can now avoid push/pop of BC if desired
    ld   DE, wObjectRuntimeData
    add  HL, DE
    ld   DE, $04                                       ;; 00:05fa $11 $04 $00
    add  HL, DE                                        ;; 00:05fd $19
    ld   A, [HL+]                                      ;; 00:05fe $2a
    srl  A                                             ;; 00:05ff $cb $3f
    srl  A                                             ;; 00:0601 $cb $3f
    srl  A                                             ;; 00:0603 $cb $3f
    dec  A                                             ;; 00:0605 $3d
    dec  A                                             ;; 00:0606 $3d
    ld   D, A                                          ;; 00:0607 $57
    ld   E, [HL]                                       ;; 00:0608 $5e
    srl  E                                             ;; 00:0609 $cb $3b
    srl  E                                             ;; 00:060b $cb $3b
    srl  E                                             ;; 00:060d $cb $3b
    dec  E                                             ;; 00:060f $1d
    ret                                                ;; 00:0610 $c9

; Update the object at index C to the position at D,E
; Object orientation/flags set to A & 7f
; Also does something with B
updateObjectPosition:
    ld   L, A                                          ;; 00:0611 $6f
    ld   A, C                                          ;; 00:0612 $79
    cp   A, $14                                        ;; 00:0613 $fe $14
    ret  NC                                            ;; 00:0615 $d0
    ld   [wObjectIDCopy], A                            ;; 00:0616 $ea $49 $c3
    ld   A, L                                          ;; 00:0619 $7d
    push BC                                            ;; 00:061a $c5
    ld   L, C                                          ;; 00:061b $69
    ld   H, $00                                        ;; 00:061c $26 $00
    add  HL, HL                                        ;; 00:061e $29
    add  HL, HL                                        ;; 00:061f $29
    add  HL, HL                                        ;; 00:0620 $29
    add  HL, HL                                        ;; 00:0621 $29
    ld   BC, wObjectRuntimeData                        ;; 00:0622 $01 $00 $c2
    add  HL, BC                                        ;; 00:0625 $09
    pop  BC                                            ;; 00:0626 $c1
    ld   C, A                                          ;; 00:0627 $4f
    ld   A, [HL]                                       ;; 00:0628 $7e
    cp   A, $ff                                        ;; 00:0629 $fe $ff
    ret  Z                                             ;; 00:062b $c8
    ld   [HL], C                                       ;; 00:062c $71
    res  7, [HL]                                       ;; 00:062d $cb $be
    push HL                                            ;; 00:062f $e5
    push DE                                            ;; 00:0630 $d5
    push HL                                            ;; 00:0631 $e5
    push BC                                            ;; 00:0632 $c5
    ld   A, C                                          ;; 00:0633 $79
    bit  5, A                                          ;; 00:0634 $cb $6f
    call NZ, objectReverseDirection                    ;; 00:0636 $c4 $e4 $29
    call getBitNumber                                  ;; 00:0639 $cd $82 $29
    pop  BC                                            ;; 00:063c $c1
    push BC                                            ;; 00:063d $c5
    sla  B                                             ;; 00:063e $cb $20
    sla  B                                             ;; 00:0640 $cb $20
    add  A, B                                          ;; 00:0642 $80
    ld   L, A                                          ;; 00:0643 $6f
    ld   H, $00                                        ;; 00:0644 $26 $00
    ld   E, L                                          ;; 00:0646 $5d
    ld   D, H                                          ;; 00:0647 $54
    add  HL, HL                                        ;; 00:0648 $29
    add  HL, DE                                        ;; 00:0649 $19
    ld   E, L                                          ;; 00:064a $5d
    ld   D, H                                          ;; 00:064b $54
    pop  BC                                            ;; 00:064c $c1
    pop  HL                                            ;; 00:064d $e1
    ld   A, B                                          ;; 00:064e $78
    cp   A, $ff                                        ;; 00:064f $fe $ff
    call NZ, setMetaspriteForObject                    ;; 00:0651 $c4 $8a $08
    pop  DE                                            ;; 00:0654 $d1
    ld   BC, $04                                       ;; 00:0655 $01 $04 $00
    add  HL, BC                                        ;; 00:0658 $09
    ld   [HL], D                                       ;; 00:0659 $72
    inc  HL                                            ;; 00:065a $23
    ld   [HL], E                                       ;; 00:065b $73
    cp   A, $ff                                        ;; 00:065c $fe $ff
    jr   NZ, .jr_00_0663                               ;; 00:065e $20 $03
    ld   DE, $f8                                       ;; 00:0660 $11 $f8 $00
.jr_00_0663:
    pop  HL                                            ;; 00:0663 $e1
    ld   BC, $08                                       ;; 00:0664 $01 $08 $00
    add  HL, BC                                        ;; 00:0667 $09
    ld   A, [HL+]                                      ;; 00:0668 $2a
    ld   H, [HL]                                       ;; 00:0669 $66
    ld   L, A                                          ;; 00:066a $6f
    ld   A, E                                          ;; 00:066b $7b
    add  A, $08                                        ;; 00:066c $c6 $08
    ld   [HL], D                                       ;; 00:066e $72
    inc  HL                                            ;; 00:066f $23
    ld   [HL], E                                       ;; 00:0670 $73
    inc  HL                                            ;; 00:0671 $23
    inc  HL                                            ;; 00:0672 $23
    inc  HL                                            ;; 00:0673 $23
    ld   [HL], D                                       ;; 00:0674 $72
    inc  HL                                            ;; 00:0675 $23
    ld   [HL], A                                       ;; 00:0676 $77
    ret                                                ;; 00:0677 $c9

; HL = pointer to an object's runtime data
; Return: A = x position ored with y position
; Return: B object's collision flags
; Return: D = (y / 8) - 2
; Return: E = (x / 8) - 1
getObjectPositionAndCollisionInfo:
    ld   BC, $04                                       ;; 00:0678 $01 $04 $00
    add  HL, BC                                        ;; 00:067b $09
    ld   A, [HL+]                                      ;; 00:067c $2a
    ld   D, A                                          ;; 00:067d $57
    ld   E, [HL]                                       ;; 00:067e $5e
    or   A, E                                          ;; 00:067f $b3
    ld   BC, -3 ;@=value signed=True                   ;; 00:0680 $01 $fd $ff
    add  HL, BC                                        ;; 00:0683 $09
    ld   B, [HL]                                       ;; 00:0684 $46
    srl  D                                             ;; 00:0685 $cb $3a
    srl  D                                             ;; 00:0687 $cb $3a
    srl  D                                             ;; 00:0689 $cb $3a
    dec  D                                             ;; 00:068b $15
    dec  D                                             ;; 00:068c $15
    srl  E                                             ;; 00:068d $cb $3b
    srl  E                                             ;; 00:068f $cb $3b
    srl  E                                             ;; 00:0691 $cb $3b
    dec  E                                             ;; 00:0693 $1d
    ret                                                ;; 00:0694 $c9

; A = 00 if not moving. Direction byte, upper niblle is 9 if requesting move
; B = metasprite table row
; C = Object ID for the changed/checked object
processPhysicsForObject:
    ld   D, A                                          ;; 00:0695 $57
    ld   E, B                                          ;; 00:0696 $58
    ld   A, C                                          ;; 00:0697 $79
    cp   A, $14                                        ;; 00:0698 $fe $14
    ret  NC                                            ;; 00:069a $d0
    ld   [wObjectIDCopy], A                            ;; 00:069b $ea $49 $c3
    ld   L, C                                          ;; 00:069e $69
    ld   H, $00                                        ;; 00:069f $26 $00
    add  HL, HL                                        ;; 00:06a1 $29
    add  HL, HL                                        ;; 00:06a2 $29
    add  HL, HL                                        ;; 00:06a3 $29
    add  HL, HL                                        ;; 00:06a4 $29
    ld   BC, wObjectRuntimeData                        ;; 00:06a5 $01 $00 $c2
    add  HL, BC                                        ;; 00:06a8 $09
    ld   A, [HL]                                       ;; 00:06a9 $7e
    cp   A, $ff                                        ;; 00:06aa $fe $ff
    ret  Z                                             ;; 00:06ac $c8
    bit  7, A                                          ;; 00:06ad $cb $7f
    jr   NZ, .jr_00_06df                               ;; 00:06af $20 $2e
    push HL                                            ;; 00:06b1 $e5
    ld   A, [wMainGameStateFlags]                      ;; 00:06b2 $fa $a1 $c0
    bit  3, A                                          ;; 00:06b5 $cb $5f
    jr   NZ, .normal_movement                          ;; 00:06b7 $20 $1f
    ld   BC, $0a                                       ;; 00:06b9 $01 $0a $00
    add  HL, BC                                        ;; 00:06bc $09
    ld   A, [HL+]                                      ;; 00:06bd $2a
    bit  7, A                                          ;; 00:06be $cb $7f
    jr   Z, .normal_movement                           ;; 00:06c0 $28 $16
; .sliding:
    ld   C, A                                          ;; 00:06c2 $4f
    ld   B, [HL]                                       ;; 00:06c3 $46
    pop  HL                                            ;; 00:06c4 $e1
    ld   A, D                                          ;; 00:06c5 $7a
    and  A, $0f                                        ;; 00:06c6 $e6 $0f
    jr   NZ, .jr_00_06cd                               ;; 00:06c8 $20 $03
    ld   A, [HL]                                       ;; 00:06ca $7e
    and  A, $0f                                        ;; 00:06cb $e6 $0f
.jr_00_06cd:
    ld   [HL], A                                       ;; 00:06cd $77
    ld   E, $00                                        ;; 00:06ce $1e $00
    push BC                                            ;; 00:06d0 $c5
    ld   B, A                                          ;; 00:06d1 $47
    call setFrameForObject                             ;; 00:06d2 $cd $28 $08
    pop  BC                                            ;; 00:06d5 $c1
    jr   .jr_00_06fc                                   ;; 00:06d6 $18 $24
.normal_movement:
    pop  HL                                            ;; 00:06d8 $e1
    ld   A, D                                          ;; 00:06d9 $7a
    or   A, D                                          ;; 00:06da $b2
    jp   Z, .jp_00_0803                                ;; 00:06db $ca $03 $08
    ld   A, D                                          ;; 00:06de $7a
.jr_00_06df:
    ld   C, A                                          ;; 00:06df $4f
    ld   B, [HL]                                       ;; 00:06e0 $46
    ld   A, [wMainGameStateFlags]                      ;; 00:06e1 $fa $a1 $c0
    bit  0, A                                          ;; 00:06e4 $cb $47
    jr   NZ, .jr_00_06ef                               ;; 00:06e6 $20 $07
    ld   [HL], C                                       ;; 00:06e8 $71
    ld   A, C                                          ;; 00:06e9 $79
    and  A, $0f                                        ;; 00:06ea $e6 $0f
    jr   Z, .jr_00_06ef                                ;; 00:06ec $28 $01
    ld   B, C                                          ;; 00:06ee $41
.jr_00_06ef:
    push BC                                            ;; 00:06ef $c5
    call setFrameForObject                             ;; 00:06f0 $cd $28 $08
    pop  BC                                            ;; 00:06f3 $c1
    bit  4, C                                          ;; 00:06f4 $cb $61
    jp   Z, .jp_00_0803                                ;; 00:06f6 $ca $03 $08
    inc  HL                                            ;; 00:06f9 $23
    ld   A, [HL-]                                      ;; 00:06fa $3a
    ld   B, A                                          ;; 00:06fb $47
.jr_00_06fc:
    bit  0, C                                          ;; 00:06fc $cb $41
    jr   NZ, .east                                     ;; 00:06fe $20 $3f
    bit  1, C                                          ;; 00:0700 $cb $49
    jr   NZ, .west                                     ;; 00:0702 $20 $70
    bit  2, C                                          ;; 00:0704 $cb $51
    jp   NZ, .north                                    ;; 00:0706 $c2 $ab $07
; .south:
    ld   D, B                                          ;; 00:0709 $50
    ld   E, $00                                        ;; 00:070a $1e $00
    ld   A, [wMainGameStateFlags]                      ;; 00:070c $fa $a1 $c0
    bit  3, A                                          ;; 00:070f $cb $5f
    jp   NZ, .jp_00_073b                               ;; 00:0711 $c2 $3b $07
    push HL                                            ;; 00:0714 $e5
    push DE                                            ;; 00:0715 $d5
    call getObjectPositionAndCollisionInfo             ;; 00:0716 $cd $78 $06
    inc  D                                             ;; 00:0719 $14
    and  A, $07                                        ;; 00:071a $e6 $07
    ld   A, B                                          ;; 00:071c $78
    call Z, checkObjectTileCollisions                  ;; 00:071d $cc $c0 $18
    jp   Z, .blocked                                   ;; 00:0720 $ca $e0 $07
    call ifPlayerThen_A_Equal_B_Minus_1_And_F0         ;; 00:0723 $cd $1d $08
    jp   Z, .blocked                                   ;; 00:0726 $ca $e0 $07
    ld   A, [wObjectIDCopy]                            ;; 00:0729 $fa $49 $c3
    ld   C, A                                          ;; 00:072c $4f
    call checkPlayfieldBoundaryCollision_trampoline    ;; 00:072d $cd $6f $03
    jr   NZ, .jr_00_0739                               ;; 00:0730 $20 $07
    bit  3, B                                          ;; 00:0732 $cb $58
    ld   B, $00                                        ;; 00:0734 $06 $00
    jp   NZ, .blocked                                  ;; 00:0736 $c2 $e0 $07
.jr_00_0739:
    pop  DE                                            ;; 00:0739 $d1
    pop  HL                                            ;; 00:073a $e1
.jp_00_073b:
    call moveObject                                    ;; 00:073b $cd $61 $09
    ret                                                ;; 00:073e $c9
.east:
    ld   E, B                                          ;; 00:073f $58
    ld   D, $00                                        ;; 00:0740 $16 $00
    ld   A, [wMainGameStateFlags]                      ;; 00:0742 $fa $a1 $c0
    bit  3, A                                          ;; 00:0745 $cb $5f
    jr   NZ, .jr_00_0770                               ;; 00:0747 $20 $27
    push HL                                            ;; 00:0749 $e5
    push DE                                            ;; 00:074a $d5
    call getObjectPositionAndCollisionInfo             ;; 00:074b $cd $78 $06
    inc  E                                             ;; 00:074e $1c
    and  A, $07                                        ;; 00:074f $e6 $07
    ld   A, B                                          ;; 00:0751 $78
    call Z, checkObjectTileCollisions                  ;; 00:0752 $cc $c0 $18
    jp   Z, .blocked                                   ;; 00:0755 $ca $e0 $07
    call ifPlayerThen_A_Equal_B_Minus_1_And_F0         ;; 00:0758 $cd $1d $08
    jp   Z, .blocked                                   ;; 00:075b $ca $e0 $07
    ld   A, [wObjectIDCopy]                            ;; 00:075e $fa $49 $c3
    ld   C, A                                          ;; 00:0761 $4f
    call checkPlayfieldBoundaryCollision_trampoline    ;; 00:0762 $cd $6f $03
    jr   NZ, .jr_00_076e                               ;; 00:0765 $20 $07
    bit  0, B                                          ;; 00:0767 $cb $40
    ld   B, $00                                        ;; 00:0769 $06 $00
    jp   NZ, .blocked                                  ;; 00:076b $c2 $e0 $07
.jr_00_076e:
    pop  DE                                            ;; 00:076e $d1
    pop  HL                                            ;; 00:076f $e1
.jr_00_0770:
    call moveObject                                    ;; 00:0770 $cd $61 $09
    ret                                                ;; 00:0773 $c9
.west:
    ld   A, B                                          ;; 00:0774 $78
    cpl                                                ;; 00:0775 $2f
    inc  A                                             ;; 00:0776 $3c
    ld   E, A                                          ;; 00:0777 $5f
    ld   D, $00                                        ;; 00:0778 $16 $00
    ld   A, [wMainGameStateFlags]                      ;; 00:077a $fa $a1 $c0
    bit  3, A                                          ;; 00:077d $cb $5f
    jr   NZ, .jr_00_07a7                               ;; 00:077f $20 $26
    push HL                                            ;; 00:0781 $e5
    push DE                                            ;; 00:0782 $d5
    call getObjectPositionAndCollisionInfo             ;; 00:0783 $cd $78 $06
    dec  E                                             ;; 00:0786 $1d
    and  A, $07                                        ;; 00:0787 $e6 $07
    ld   A, B                                          ;; 00:0789 $78
    call Z, checkObjectTileCollisions                  ;; 00:078a $cc $c0 $18
    jp   Z, .blocked                                   ;; 00:078d $ca $e0 $07
    call ifPlayerThen_A_Equal_B_Minus_1_And_F0         ;; 00:0790 $cd $1d $08
    jp   Z, .blocked                                   ;; 00:0793 $ca $e0 $07
    ld   A, [wObjectIDCopy]                            ;; 00:0796 $fa $49 $c3
    ld   C, A                                          ;; 00:0799 $4f
    call checkPlayfieldBoundaryCollision_trampoline    ;; 00:079a $cd $6f $03
    jr   NZ, .jr_00_07a5                               ;; 00:079d $20 $06
    bit  1, B                                          ;; 00:079f $cb $48
    ld   B, $00                                        ;; 00:07a1 $06 $00
    jr   NZ, .blocked                                  ;; 00:07a3 $20 $3b
.jr_00_07a5:
    pop  DE                                            ;; 00:07a5 $d1
    pop  HL                                            ;; 00:07a6 $e1
.jr_00_07a7:
    call moveObject                                    ;; 00:07a7 $cd $61 $09
    ret                                                ;; 00:07aa $c9
.north:
    ld   A, B                                          ;; 00:07ab $78
    cpl                                                ;; 00:07ac $2f
    inc  A                                             ;; 00:07ad $3c
    ld   D, A                                          ;; 00:07ae $57
    ld   E, $00                                        ;; 00:07af $1e $00
    ld   A, [wMainGameStateFlags]                      ;; 00:07b1 $fa $a1 $c0
    bit  3, A                                          ;; 00:07b4 $cb $5f
    jr   NZ, .jr_00_07dc                               ;; 00:07b6 $20 $24
    push HL                                            ;; 00:07b8 $e5
    push DE                                            ;; 00:07b9 $d5
    call getObjectPositionAndCollisionInfo             ;; 00:07ba $cd $78 $06
    dec  D                                             ;; 00:07bd $15
    and  A, $07                                        ;; 00:07be $e6 $07
    ld   A, B                                          ;; 00:07c0 $78
    call Z, checkObjectTileCollisions                  ;; 00:07c1 $cc $c0 $18
    jr   Z, .blocked                                   ;; 00:07c4 $28 $1a
    call ifPlayerThen_A_Equal_B_Minus_1_And_F0         ;; 00:07c6 $cd $1d $08
    jr   Z, .blocked                                   ;; 00:07c9 $28 $15
    ld   A, [wObjectIDCopy]                            ;; 00:07cb $fa $49 $c3
    ld   C, A                                          ;; 00:07ce $4f
    call checkPlayfieldBoundaryCollision_trampoline    ;; 00:07cf $cd $6f $03
    jr   NZ, .jr_00_07da                               ;; 00:07d2 $20 $06
    bit  2, B                                          ;; 00:07d4 $cb $50
    ld   B, $00                                        ;; 00:07d6 $06 $00
    jr   NZ, .blocked                                  ;; 00:07d8 $20 $06
.jr_00_07da:
    pop  DE                                            ;; 00:07da $d1
    pop  HL                                            ;; 00:07db $e1
.jr_00_07dc:
    call moveObject                                    ;; 00:07dc $cd $61 $09
    ret                                                ;; 00:07df $c9
.blocked:
    pop  DE                                            ;; 00:07e0 $d1
    pop  HL                                            ;; 00:07e1 $e1
    push HL                                            ;; 00:07e2 $e5
    ld   DE, $0a                                       ;; 00:07e3 $11 $0a $00
    add  HL, DE                                        ;; 00:07e6 $19
    ld   [HL], $00                                     ;; 00:07e7 $36 $00
    pop  HL                                            ;; 00:07e9 $e1
    res  7, [HL]                                       ;; 00:07ea $cb $be
    ld   A, [wMainGameStateFlags]                      ;; 00:07ec $fa $a1 $c0
    bit  1, A                                          ;; 00:07ef $cb $4f
    jr   NZ, .jp_00_0803                               ;; 00:07f1 $20 $10
    ld   A, B                                          ;; 00:07f3 $78
    cp   A, $00                                        ;; 00:07f4 $fe $00
    jr   Z, .jp_00_0803                                ;; 00:07f6 $28 $0b
    inc  HL                                            ;; 00:07f8 $23
    inc  HL                                            ;; 00:07f9 $23
    ld   A, [HL-]                                      ;; 00:07fa $3a
    dec  HL                                            ;; 00:07fb $2b
    and  A, $f0                                        ;; 00:07fc $e6 $f0
    cp   A, $c0                                        ;; 00:07fe $fe $c0
    call Z, runScriptAndStopKnockback_trampoline       ;; 00:0800 $cc $c9 $02
.jp_00_0803:
    ld   DE, $00                                       ;; 00:0803 $11 $00 $00
    ld   A, [wMainGameStateFlags]                      ;; 00:0806 $fa $a1 $c0
    push AF                                            ;; 00:0809 $f5
    set  1, A                                          ;; 00:080a $cb $cf
    ld   [wMainGameStateFlags], A                      ;; 00:080c $ea $a1 $c0
    call moveObject                                    ;; 00:080f $cd $61 $09
    ld   A, [wMainGameStateFlags.nextFrame]            ;; 00:0812 $fa $a2 $c0
    ld   C, A                                          ;; 00:0815 $4f
    pop  AF                                            ;; 00:0816 $f1
    or   A, C                                          ;; 00:0817 $b1
    ld   [wMainGameStateFlags], A                      ;; 00:0818 $ea $a1 $c0
    xor  A, A                                          ;; 00:081b $af
    ret                                                ;; 00:081c $c9

; This is used to check collision flags.
; Return: Z if testing player and either:
; 1) top nibble 0 and bottom nibble != 0
; 2) collision flags equal to $10
ifPlayerThen_A_Equal_B_Minus_1_And_F0:
    ld   A, [wObjectIDCopy]                            ;; 00:081d $fa $49 $c3
    cp   A, $04                                        ;; 00:0820 $fe $04
    ret  NZ                                            ;; 00:0822 $c0
    ld   A, B                                          ;; 00:0823 $78
    dec  A                                             ;; 00:0824 $3d
    and  A, $f0                                        ;; 00:0825 $e6 $f0
    ret                                                ;; 00:0827 $c9

; Used for the player, follower, and NPCs.
; B = object direction
; E = metasprite table row
; HL = object runtime pointer
setFrameForObject:
    push HL                                            ;; 00:0828 $e5
    ld   A, B                                          ;; 00:0829 $78
    bit  5, A                                          ;; 00:082a $cb $6f
    call NZ, objectReverseDirection                    ;; 00:082c $c4 $e4 $29
    and  A, $0f                                        ;; 00:082f $e6 $0f
    ld   D, A                                          ;; 00:0831 $57
    ld   A, [wMainGameStateFlags]                      ;; 00:0832 $fa $a1 $c0
    bit  3, A                                          ;; 00:0835 $cb $5f
    jr   NZ, .jr_00_085d                               ;; 00:0837 $20 $24
    push DE                                            ;; 00:0839 $d5
    ld   DE, $04                                       ;; 00:083a $11 $04 $00
    add  HL, DE                                        ;; 00:083d $19
    ld   A, [HL+]                                      ;; 00:083e $2a
    srl  A                                             ;; 00:083f $cb $3f
    srl  A                                             ;; 00:0841 $cb $3f
    srl  A                                             ;; 00:0843 $cb $3f
    dec  A                                             ;; 00:0845 $3d
    ld   D, A                                          ;; 00:0846 $57
    ld   A, [HL+]                                      ;; 00:0847 $2a
    srl  A                                             ;; 00:0848 $cb $3f
    srl  A                                             ;; 00:084a $cb $3f
    srl  A                                             ;; 00:084c $cb $3f
    ld   E, A                                          ;; 00:084e $5f
    call getRoomMetatileAttributes                     ;; 00:084f $cd $af $16
    ld   DE, $800                                      ;; 00:0852 $11 $00 $08
    call HLandDE                                       ;; 00:0855 $cd $b2 $29
    pop  DE                                            ;; 00:0858 $d1
    jr   Z, .jr_00_085d                                ;; 00:0859 $28 $02
; If on a vine, then face north
    ld   D, $04                                        ;; 00:085b $16 $04
.jr_00_085d:
    bit  0, D                                          ;; 00:085d $cb $42
    jr   NZ, .east                                     ;; 00:085f $20 $0c
    bit  1, D                                          ;; 00:0861 $cb $4a
    jr   NZ, .west                                     ;; 00:0863 $20 $0c
    bit  2, D                                          ;; 00:0865 $cb $52
    jr   NZ, .north                                    ;; 00:0867 $20 $0c
; .south:
    ld   A, $03                                        ;; 00:0869 $3e $03
    jr   .jr_00_0877                                   ;; 00:086b $18 $0a
.east:
    ld   A, $00                                        ;; 00:086d $3e $00
    jr   .jr_00_0877                                   ;; 00:086f $18 $06
.west:
    ld   A, $01                                        ;; 00:0871 $3e $01
    jr   .jr_00_0877                                   ;; 00:0873 $18 $02
.north:
    ld   A, $02                                        ;; 00:0875 $3e $02
.jr_00_0877:
    sla  E                                             ;; 00:0877 $cb $23
    sla  E                                             ;; 00:0879 $cb $23
    add  A, E                                          ;; 00:087b $83
    ld   L, A                                          ;; 00:087c $6f
    ld   H, $00                                        ;; 00:087d $26 $00
    ld   D, H                                          ;; 00:087f $54
    ld   E, L                                          ;; 00:0880 $5d
    add  HL, HL                                        ;; 00:0881 $29
    add  HL, DE                                        ;; 00:0882 $19
    ld   E, L                                          ;; 00:0883 $5d
    ld   D, H                                          ;; 00:0884 $54
    pop  HL                                            ;; 00:0885 $e1
    call setMetaspriteForObject                        ;; 00:0886 $cd $8a $08
    ret                                                ;; 00:0889 $c9

; HL = object base address (c2X0)
; DE = offset from the object's base metasprite tile address (should be a multiple of three)
setMetaspriteForObject:
    push HL                                            ;; 00:088a $e5
    ld   BC, $06                                       ;; 00:088b $01 $06 $00
    add  HL, BC                                        ;; 00:088e $09
    push HL                                            ;; 00:088f $e5
    ld   A, [HL+]                                      ;; 00:0890 $2a
    ld   H, [HL]                                       ;; 00:0891 $66
    ld   L, A                                          ;; 00:0892 $6f
    add  HL, DE                                        ;; 00:0893 $19
    ld   A, [HL+]                                      ;; 00:0894 $2a
    ld   E, [HL]                                       ;; 00:0895 $5e
    inc  HL                                            ;; 00:0896 $23
    ld   D, [HL]                                       ;; 00:0897 $56
    pop  HL                                            ;; 00:0898 $e1
    ld   C, A                                          ;; 00:0899 $4f
    inc  HL                                            ;; 00:089a $23
    inc  HL                                            ;; 00:089b $23
    ld   A, [HL+]                                      ;; 00:089c $2a
    ld   H, [HL]                                       ;; 00:089d $66
    ld   L, A                                          ;; 00:089e $6f
    inc  HL                                            ;; 00:089f $23
    inc  HL                                            ;; 00:08a0 $23
    ld   [HL], E                                       ;; 00:08a1 $73
    inc  HL                                            ;; 00:08a2 $23
    ld   [HL], C                                       ;; 00:08a3 $71
    inc  HL                                            ;; 00:08a4 $23
    inc  HL                                            ;; 00:08a5 $23
    inc  HL                                            ;; 00:08a6 $23
    ld   [HL], D                                       ;; 00:08a7 $72
    inc  HL                                            ;; 00:08a8 $23
    ld   [HL], C                                       ;; 00:08a9 $71
    pop  HL                                            ;; 00:08aa $e1
    ld   A, $00                                        ;; 00:08ab $3e $00
    ret                                                ;; 00:08ad $c9
    db   $11, $08, $00, $19, $e5, $2a, $66, $6f        ;; 00:08ae ????????
    db   $11, $02, $00, $19, $5e, $23, $23, $23        ;; 00:08b6 ????????
    db   $23, $56, $e1, $23, $23, $c9                  ;; 00:08be ??????

; Convert a position of a sprite X/Y into a tile position X/Y
pixelToTilePosition:
    srl  D                                             ;; 00:08c4 $cb $3a
    srl  D                                             ;; 00:08c6 $cb $3a
    srl  D                                             ;; 00:08c8 $cb $3a
    dec  D                                             ;; 00:08ca $15
    dec  D                                             ;; 00:08cb $15
    srl  E                                             ;; 00:08cc $cb $3b
    srl  E                                             ;; 00:08ce $cb $3b
    srl  E                                             ;; 00:08d0 $cb $3b
    dec  E                                             ;; 00:08d2 $1d
    ret                                                ;; 00:08d3 $c9

; Deals with anything unconstrained by the 8x8 grid: projectiles, player attacks, and also jumping objects.
; A = object direction
; B = metasprite table row. Each row has four entries, one for each of the four directions.
; C = object ID
; DE = yx object distance and direction to move
; Return: Z = collision
moveGridlessObject:
    ld   L, A                                          ;; 00:08d4 $6f
    ld   A, C                                          ;; 00:08d5 $79
    cp   A, $14                                        ;; 00:08d6 $fe $14
    ret  NC                                            ;; 00:08d8 $d0
    ld   [wObjectIDCopy], A                            ;; 00:08d9 $ea $49 $c3
    ld   A, L                                          ;; 00:08dc $7d
    push BC                                            ;; 00:08dd $c5
    ld   L, C                                          ;; 00:08de $69
    ld   H, $00                                        ;; 00:08df $26 $00
    add  HL, HL                                        ;; 00:08e1 $29
    add  HL, HL                                        ;; 00:08e2 $29
    add  HL, HL                                        ;; 00:08e3 $29
    add  HL, HL                                        ;; 00:08e4 $29
    ld   BC, wObjectRuntimeData                        ;; 00:08e5 $01 $00 $c2
    add  HL, BC                                        ;; 00:08e8 $09
    pop  BC                                            ;; 00:08e9 $c1
    ld   C, A                                          ;; 00:08ea $4f
    ld   A, [HL]                                       ;; 00:08eb $7e
    cp   A, $ff                                        ;; 00:08ec $fe $ff
    ret  Z                                             ;; 00:08ee $c8
; C = direction
    ld   [HL], C                                       ;; 00:08ef $71
    res  7, [HL]                                       ;; 00:08f0 $cb $be
    push DE                                            ;; 00:08f2 $d5
    push HL                                            ;; 00:08f3 $e5
    push BC                                            ;; 00:08f4 $c5
    ld   A, C                                          ;; 00:08f5 $79
    bit  5, A                                          ;; 00:08f6 $cb $6f
    call NZ, objectReverseDirection                    ;; 00:08f8 $c4 $e4 $29
    call getBitNumber                                  ;; 00:08fb $cd $82 $29
    pop  BC                                            ;; 00:08fe $c1
    push BC                                            ;; 00:08ff $c5
    sla  B                                             ;; 00:0900 $cb $20
    sla  B                                             ;; 00:0902 $cb $20
    add  A, B                                          ;; 00:0904 $80
    ld   L, A                                          ;; 00:0905 $6f
    ld   H, $00                                        ;; 00:0906 $26 $00
    ld   E, L                                          ;; 00:0908 $5d
    ld   D, H                                          ;; 00:0909 $54
    add  HL, HL                                        ;; 00:090a $29
    add  HL, DE                                        ;; 00:090b $19
    ld   E, L                                          ;; 00:090c $5d
    ld   D, H                                          ;; 00:090d $54
    pop  BC                                            ;; 00:090e $c1
    pop  HL                                            ;; 00:090f $e1
    push BC                                            ;; 00:0910 $c5
    call setMetaspriteForObject                        ;; 00:0911 $cd $8a $08
    pop  BC                                            ;; 00:0914 $c1
    pop  DE                                            ;; 00:0915 $d1
    ld   A, [wMainGameStateFlags]                      ;; 00:0916 $fa $a1 $c0
    bit  3, A                                          ;; 00:0919 $cb $5f
    jr   NZ, .jr_00_0944                               ;; 00:091b $20 $27
    push DE                                            ;; 00:091d $d5
    push HL                                            ;; 00:091e $e5
    inc  HL                                            ;; 00:091f $23
    inc  HL                                            ;; 00:0920 $23
    ld   A, [HL+]                                      ;; 00:0921 $2a
    ld   B, A                                          ;; 00:0922 $47
; B = collision flags
    inc  HL                                            ;; 00:0923 $23
    ld   A, [HL+]                                      ;; 00:0924 $2a
    add  A, D                                          ;; 00:0925 $82
    ld   D, A                                          ;; 00:0926 $57
    ld   A, [HL+]                                      ;; 00:0927 $2a
    add  A, E                                          ;; 00:0928 $83
    ld   E, A                                          ;; 00:0929 $5f
    push DE                                            ;; 00:092a $d5
    push BC                                            ;; 00:092b $c5
    ld   A, $08                                        ;; 00:092c $3e $08
    add  A, D                                          ;; 00:092e $82
    ld   D, A                                          ;; 00:092f $57
    ld   A, $08                                        ;; 00:0930 $3e $08
    add  A, E                                          ;; 00:0932 $83
    ld   E, A                                          ;; 00:0933 $5f
    call pixelToTilePosition                           ;; 00:0934 $cd $c4 $08
    ld   A, B                                          ;; 00:0937 $78
    call checkProjectileTileCollisions                 ;; 00:0938 $cd $dd $18
    jr   Z, .collision                                 ;; 00:093b $28 $1f
    call attackTile_trampoline                         ;; 00:093d $cd $76 $2f
    pop  BC                                            ;; 00:0940 $c1
    pop  DE                                            ;; 00:0941 $d1
    pop  HL                                            ;; 00:0942 $e1
    pop  DE                                            ;; 00:0943 $d1
.jr_00_0944:
    ld   A, [wMainGameStateFlags]                      ;; 00:0944 $fa $a1 $c0
    push AF                                            ;; 00:0947 $f5
    set  1, A                                          ;; 00:0948 $cb $cf
    ld   [wMainGameStateFlags], A                      ;; 00:094a $ea $a1 $c0
    call moveObject                                    ;; 00:094d $cd $61 $09
    ld   A, [wMainGameStateFlags.nextFrame]            ;; 00:0950 $fa $a2 $c0
    ld   C, A                                          ;; 00:0953 $4f
    pop  AF                                            ;; 00:0954 $f1
    or   A, C                                          ;; 00:0955 $b1
    ld   [wMainGameStateFlags], A                      ;; 00:0956 $ea $a1 $c0
    xor  A, A                                          ;; 00:0959 $af
    inc  A                                             ;; 00:095a $3c
    ret                                                ;; 00:095b $c9
.collision:
    pop  BC                                            ;; 00:095c $c1
    pop  DE                                            ;; 00:095d $d1
    pop  HL                                            ;; 00:095e $e1
    pop  DE                                            ;; 00:095f $d1
    ret                                                ;; 00:0960 $c9

; DE = yx object distance and direction to move
; HL = object runtime data pointer for selected object
; Return: Carry flag set if object is unmoved, either due to de == 0 or collision.
moveObject:
    push HL                                            ;; 00:0961 $e5
    push DE                                            ;; 00:0962 $d5
; Load object position and add distances to move.
    ld   BC, $04                                       ;; 00:0963 $01 $04 $00
    add  HL, BC                                        ;; 00:0966 $09
    ld   A, [HL+]                                      ;; 00:0967 $2a
    add  A, D                                          ;; 00:0968 $82
    ld   D, A                                          ;; 00:0969 $57
    ld   A, [HL-]                                      ;; 00:096a $3a
    add  A, E                                          ;; 00:096b $83
    ld   E, A                                          ;; 00:096c $5f
; Pop move vectors into BC.
    pop  BC                                            ;; 00:096d $c1
; Skip collision handling if in a script or otherwise non-interactive.
    ld   A, [wMainGameStateFlags]                      ;; 00:096e $fa $a1 $c0
    bit  2, A                                          ;; 00:0971 $cb $57
    jr   NZ, .jr_00_099f                               ;; 00:0973 $20 $2a
; Calculate the object id from hl, which currently points to the object's y position.
    push BC                                            ;; 00:0975 $c5
    push DE                                            ;; 00:0976 $d5
    push HL                                            ;; 00:0977 $e5
; $3dfc = -$c204
    ld   DE, $3dfc                                     ;; 00:0978 $11 $fc $3d
    add  HL, DE                                        ;; 00:097b $19
    ld   A, L                                          ;; 00:097c $7d
    or   A, H                                          ;; 00:097d $b4
    swap A                                             ;; 00:097e $cb $37
    ld   C, A                                          ;; 00:0980 $4f
; C = object id
    pop  HL                                            ;; 00:0981 $e1
    ld   DE, -2 ;@=value signed=True                   ;; 00:0982 $11 $fe $ff
    add  HL, DE                                        ;; 00:0985 $19
    ld   A, [HL]                                       ;; 00:0986 $7e
; A = object collision flags
    pop  DE                                            ;; 00:0987 $d1
    call checkNpcsForCollisions_trampoline             ;; 00:0988 $cd $1c $04
    pop  HL                                            ;; 00:098b $e1
    cp   A, $00                                        ;; 00:098c $fe $00
    call NZ, secondaryCollisionHandling                ;; 00:098e $c4 $33 $0a
    ld   D, H                                          ;; 00:0991 $54
    ld   E, L                                          ;; 00:0992 $5d
    pop  HL                                            ;; 00:0993 $e1
    push HL                                            ;; 00:0994 $e5
    ld   BC, $04                                       ;; 00:0995 $01 $04 $00
    add  HL, BC                                        ;; 00:0998 $09
    ld   A, [HL+]                                      ;; 00:0999 $2a
    add  A, D                                          ;; 00:099a $82
    ld   D, A                                          ;; 00:099b $57
    ld   A, [HL-]                                      ;; 00:099c $3a
    add  A, E                                          ;; 00:099d $83
    ld   E, A                                          ;; 00:099e $5f
.jr_00_099f:
; Move the object to the new position and calculate the move vectors.
    ld   A, D                                          ;; 00:099f $7a
    ld   B, [HL]                                       ;; 00:09a0 $46
    ld   [HL+], A                                      ;; 00:09a1 $22
    sub  A, B                                          ;; 00:09a2 $90
    ld   B, A                                          ;; 00:09a3 $47
    ld   A, E                                          ;; 00:09a4 $7b
    ld   C, [HL]                                       ;; 00:09a5 $4e
    ld   [HL], A                                       ;; 00:09a6 $77
    sub  A, C                                          ;; 00:09a7 $91
    ld   C, A                                          ;; 00:09a8 $4f
; Load the shadow OAM address for this object.
    pop  HL                                            ;; 00:09a9 $e1
    push BC                                            ;; 00:09aa $c5
    push HL                                            ;; 00:09ab $e5
    ld   BC, $08                                       ;; 00:09ac $01 $08 $00
    add  HL, BC                                        ;; 00:09af $09
    ld   A, [HL+]                                      ;; 00:09b0 $2a
    ld   H, [HL]                                       ;; 00:09b1 $66
    ld   L, A                                          ;; 00:09b2 $6f
; HL = sprite shadow OAM address for the first sprite of this object
; Write YX locations for both sprites.
    ld   A, E                                          ;; 00:09b3 $7b
    add  A, $08                                        ;; 00:09b4 $c6 $08
    ld   [HL], D                                       ;; 00:09b6 $72
    inc  HL                                            ;; 00:09b7 $23
    ld   [HL], E                                       ;; 00:09b8 $73
    inc  HL                                            ;; 00:09b9 $23
    inc  HL                                            ;; 00:09ba $23
    inc  HL                                            ;; 00:09bb $23
    ld   [HL], D                                       ;; 00:09bc $72
    inc  HL                                            ;; 00:09bd $23
    ld   [HL], A                                       ;; 00:09be $77
; If bit 6 of the orientation byte is set then reset it and return.
    pop  HL                                            ;; 00:09bf $e1
    pop  BC                                            ;; 00:09c0 $c1
    bit  6, [HL]                                       ;; 00:09c1 $cb $76
    jr   NZ, .jr_00_0a30                               ;; 00:09c3 $20 $6b
    ld   A, E                                          ;; 00:09c5 $7b
    or   A, D                                          ;; 00:09c6 $b2
    and  A, $07                                        ;; 00:09c7 $e6 $07
; return if not aligned to the eight pixel grid
    ret  NZ                                            ;; 00:09c9 $c0
; Reset the moving/unaligned bit.
    res  7, [HL]                                       ;; 00:09ca $cb $be
; Calculate the object id again.
    push BC                                            ;; 00:09cc $c5
    push DE                                            ;; 00:09cd $d5
    push HL                                            ;; 00:09ce $e5
    ld   DE, wObjectRuntimeData                        ;; 00:09cf $11 $00 $c2
    call sub_HL_DE                                     ;; 00:09d2 $cd $ab $2b
    ld   A, L                                          ;; 00:09d5 $7d
    and  A, $f0                                        ;; 00:09d6 $e6 $f0
    swap A                                             ;; 00:09d8 $cb $37
    ld   L, A                                          ;; 00:09da $6f
    ld   A, H                                          ;; 00:09db $7c
    and  A, $0f                                        ;; 00:09dc $e6 $0f
    swap A                                             ;; 00:09de $cb $37
    or   A, L                                          ;; 00:09e0 $b5
    ld   B, A                                          ;; 00:09e1 $47
; b = object id.
; Get the object's collision flags.
    pop  HL                                            ;; 00:09e2 $e1
    pop  DE                                            ;; 00:09e3 $d1
    inc  HL                                            ;; 00:09e4 $23
    inc  HL                                            ;; 00:09e5 $23
    ld   A, [HL-]                                      ;; 00:09e6 $3a
    ld   C, A                                          ;; 00:09e7 $4f
; c = object collision flags.
    pop  HL                                            ;; 00:09e8 $e1
    ld   A, $00                                        ;; 00:09e9 $3e $00
    cp   A, H                                          ;; 00:09eb $bc
    jr   Z, .jr_00_0a0e                                ;; 00:09ec $28 $20
    bit  7, H                                          ;; 00:09ee $cb $7c
    jr   Z, .jr_00_0a01                                ;; 00:09f0 $28 $0f
    ld   A, H                                          ;; 00:09f2 $7c
    and  A, $f0                                        ;; 00:09f3 $e6 $f0
    cp   A, $f0                                        ;; 00:09f5 $fe $f0
    jr   Z, .jr_00_09fd                                ;; 00:09f7 $28 $04
    bit  3, H                                          ;; 00:09f9 $cb $5c
    jr   NZ, .jr_00_0a0a                               ;; 00:09fb $20 $0d
.jr_00_09fd:
    ld   A, $04                                        ;; 00:09fd $3e $04
    jr   .jr_00_0a1b                                   ;; 00:09ff $18 $1a
.jr_00_0a01:
    ld   A, H                                          ;; 00:0a01 $7c
    and  A, $f0                                        ;; 00:0a02 $e6 $f0
    jr   Z, .jr_00_0a0a                                ;; 00:0a04 $28 $04
    bit  3, H                                          ;; 00:0a06 $cb $5c
    jr   Z, .jr_00_09fd                                ;; 00:0a08 $28 $f3
.jr_00_0a0a:
    ld   A, $08                                        ;; 00:0a0a $3e $08
    jr   .jr_00_0a1b                                   ;; 00:0a0c $18 $0d
.jr_00_0a0e:
    cp   A, L                                          ;; 00:0a0e $bd
    jr   Z, .jr_00_0a2a                                ;; 00:0a0f $28 $19
    bit  7, L                                          ;; 00:0a11 $cb $7d
    jr   Z, .jr_00_0a19                                ;; 00:0a13 $28 $04
    ld   A, $02                                        ;; 00:0a15 $3e $02
    jr   .jr_00_0a1b                                   ;; 00:0a17 $18 $02
.jr_00_0a19:
    ld   A, $01                                        ;; 00:0a19 $3e $01
.jr_00_0a1b:
    ld   HL, wMainGameStateFlags                       ;; 00:0a1b $21 $a1 $c0
    bit  1, [HL]                                       ;; 00:0a1e $cb $4e
    jr   NZ, .jr_00_0a25                               ;; 00:0a20 $20 $03
    call call_00_1815                                  ;; 00:0a22 $cd $15 $18
.jr_00_0a25:
    call call_00_177e                                  ;; 00:0a25 $cd $7e $17
    xor  A, A                                          ;; 00:0a28 $af
    ret                                                ;; 00:0a29 $c9
.jr_00_0a2a:
    call call_00_177e                                  ;; 00:0a2a $cd $7e $17
    xor  A, A                                          ;; 00:0a2d $af
    scf                                                ;; 00:0a2e $37
    ret                                                ;; 00:0a2f $c9
.jr_00_0a30:
    res  6, [HL]                                       ;; 00:0a30 $cb $b6
    ret                                                ;; 00:0a32 $c9

; This only gets run if a collision has already been found and checked.
; Return: hl = yx position delta.
secondaryCollisionHandling:
    push AF                                            ;; 00:0a33 $f5
    and  A, $f0                                        ;; 00:0a34 $e6 $f0
    cp   A, $c0                                        ;; 00:0a36 $fe $c0
    jr   Z, .player                                    ;; 00:0a38 $28 $21
    cp   A, $40                                        ;; 00:0a3a $fe $40
    jr   Z, .playerOrFollowerAttack                    ;; 00:0a3c $28 $22
    cp   A, $30                                        ;; 00:0a3e $fe $30
    jr   Z, .playerOrFollowerAttack                    ;; 00:0a40 $28 $1e
    cp   A, $50                                        ;; 00:0a42 $fe $50
    jr   Z, .playerOrFollowerAttack                    ;; 00:0a44 $28 $1a
    pop af
    ld hl, $0000
    ret
; These all just set hl to $0000.
;    cp   A, $90                                        ;; 00:0a46 $fe $90
;    jr   Z, .enemy                                     ;; 00:0a48 $28 $1b
;    cp   A, $a0                                        ;; 00:0a4a $fe $a0
;    jr   Z, .friendly                                  ;; 00:0a4c $28 $1c
;    cp   A, $b0                                        ;; 00:0a4e $fe $b0
;    jr   Z, .friendly                                  ;; 00:0a50 $28 $18
; This relied on never being passed a value less than $30, equal to $80, or >= $d0.
; If that was ever false then it would have returned to something that wasn't intended as an address.
;    cp   A, $60                                        ;; 00:0a52 $fe $60
;    jr   Z, .enemyProjectile                           ;; 00:0a54 $28 $19
;    cp   A, $70                                        ;; 00:0a56 $fe $70
;    jr   Z, .enemyProjectile                           ;; 00:0a58 $28 $15
;    ret                                                ;; 00:0a5a $c9
.player:
    pop  AF                                            ;; 00:0a5b $f1
    call playerCollisionHandling_trampoline            ;; 00:0a5c $cd $44 $02
    ret                                                ;; 00:0a5f $c9
.playerOrFollowerAttack:
    pop  AF                                            ;; 00:0a60 $f1
    call playerOrFriendlyAttackCollisionHandling_trampoline ;; 00:0a61 $cd $fd $2e
    ret                                                ;; 00:0a64 $c9

createObject_speed2:
    ld a, $02

; A  = movement speed
; C  = object type ("collision flags")
; DE = position in tiles
; HL = metatile pointer
; Return: a, c = object id (or $ff on failure).
createObject:
    push DE                                            ;; 00:0a74 $d5
    push HL                                            ;; 00:0a75 $e5
    push AF                                            ;; 00:0a76 $f5
    ld   HL, wObjectRuntimeData                        ;; 00:0a77 $21 $00 $c2
    ld   DE, $10                                       ;; 00:0a7a $11 $10 $00
    ld   A, $ff                                        ;; 00:0a7d $3e $ff
; A max of 20 objects because the GB only allows 40 hardware sprites and each object needs two.
    ld   B, $14                                        ;; 00:0a7f $06 $14
.loop:
    cp   A, [HL]                                       ;; 00:0a81 $be
    jr   Z, .create                                    ;; 00:0a82 $28 $0a
    add  HL, DE                                        ;; 00:0a84 $19
    dec  B                                             ;; 00:0a85 $05
    jr   NZ, .loop                                     ;; 00:0a86 $20 $f9
; No space.
    pop  AF                                            ;; 00:0a88 $f1
    pop  HL                                            ;; 00:0a89 $e1
    pop  DE                                            ;; 00:0a8a $d1
    jr .failed
.create:
    pop  AF                                            ;; 00:0a8e $f1
    pop  DE                                            ;; 00:0a8f $d1
    push HL                                            ;; 00:0a90 $e5
; Orientation (objects are always created facing south).
    ld   [HL], DIRECTIONF_SOUTH                        ;; 00:0a91 $36 $08
    inc  HL                                            ;; 00:0a93 $23
; Movement speed (delay until action).
    ld   [HL], A                                       ;; 00:0a94 $77
    inc  HL                                            ;; 00:0a95 $23
; Collision flags.
    ld   [HL], C                                       ;; 00:0a96 $71
    inc  HL                                            ;; 00:0a97 $23
    xor a
; Unknown.
    ld [hl+], a
; Initialize Y position to zero for now.
    ld [hl+], a
; Initialize X position to zero for now.
    ld [hl+], a
; Metasprite table pointer.
    ld   [HL], E                                       ;; 00:0aa1 $73
    inc  HL                                            ;; 00:0aa2 $23
    ld   [HL], D                                       ;; 00:0aa3 $72
    pop  HL                                            ;; 00:0aa4 $e1
    push BC                                            ;; 00:0aa5 $c5
; Set initial animation frame to south facing.
    ld   DE, $09                                       ;; 00:0aa6 $11 $09 $00
    call setMetaspriteForObject                        ;; 00:0aa9 $cd $8a $08
    pop  BC                                            ;; 00:0aac $c1
; Calculate the object position in pixels given the requested position in tiles.
    pop  DE                                            ;; 00:0aad $d1
    ld   A, D                                          ;; 00:0aae $7a
    add  A, $02                                        ;; 00:0aaf $c6 $02
    add  A, A                                          ;; 00:0ab1 $87
    add  A, A                                          ;; 00:0ab2 $87
    add  A, A                                          ;; 00:0ab3 $87
    ld   D, A                                          ;; 00:0ab4 $57
    ld   A, E                                          ;; 00:0ab5 $7b
    inc a
    add  A, A                                          ;; 00:0ab8 $87
    add  A, A                                          ;; 00:0ab9 $87
    add  A, A                                          ;; 00:0aba $87
    ld   E, A                                          ;; 00:0abb $5f
; The purpose of this flag is unknown, but the script system  also uses it.
    ld   A, [wMainGameStateFlags]                      ;; 00:0abc $fa $a1 $c0
    push AF                                            ;; 00:0abf $f5
    set  1, A                                          ;; 00:0ac0 $cb $cf
    ld   [wMainGameStateFlags], A                      ;; 00:0ac2 $ea $a1 $c0
; Set the object postion.
    push BC                                            ;; 00:0ac5 $c5
    call moveObject                                    ;; 00:0ac6 $cd $61 $09
    pop  BC                                            ;; 00:0ac9 $c1
    ld   A, $14                                        ;; 00:0aca $3e $14
    jr   C, .move_failed                               ;; 00:0acc $38 $08
    sub  A, B                                          ;; 00:0ace $90
    ld   C, A                                          ;; 00:0acf $4f
    pop  AF                                            ;; 00:0ad0 $f1
    ld   [wMainGameStateFlags], A                      ;; 00:0ad1 $ea $a1 $c0
    ld   A, C                                          ;; 00:0ad4 $79
    ret                                                ;; 00:0ad5 $c9
.move_failed:
; Destroy the object if it could not be reposistioned from 0,0.
; This is likely dead code but it is difficult to prove.
    sub  A, B                                          ;; 00:0ad6 $90
    ld   C, A                                          ;; 00:0ad7 $4f
    call destroyObject                                 ;; 00:0ad8 $cd $e3 $0a
    pop  AF                                            ;; 00:0adb $f1
    ld   [wMainGameStateFlags], A                      ;; 00:0adc $ea $a1 $c0
.failed:
    DBG_MSG_LABEL debugMsgCreateObjectFail
    ld   A, $ff                                        ;; 00:0adf $3e $ff
    ld   C, A                                          ;; 00:0ae1 $4f
    ret                                                ;; 00:0ae2 $c9

; c = Object ID
destroyObject:
    ld   A, C                                          ;; 00:0ae3 $79
    cp   A, $ff                                        ;; 00:0ae4 $fe $ff
    ret  Z                                             ;; 00:0ae6 $c8
    push BC                                            ;; 00:0ae7 $c5
    ld   L, C                                          ;; 00:0ae8 $69
    ld   H, $00                                        ;; 00:0ae9 $26 $00
    add  HL, HL                                        ;; 00:0aeb $29
    add  HL, HL                                        ;; 00:0aec $29
    add  HL, HL                                        ;; 00:0aed $29
    add  HL, HL                                        ;; 00:0aee $29
    ld   BC, wObjectRuntimeData                        ;; 00:0aef $01 $00 $c2
    add  HL, BC                                        ;; 00:0af2 $09
    pop  BC                                            ;; 00:0af3 $c1
    ld   A, [HL]                                       ;; 00:0af4 $7e
    cp   A, $ff                                        ;; 00:0af5 $fe $ff
    ret  Z                                             ;; 00:0af7 $c8
    push BC                                            ;; 00:0af8 $c5
    ld   D, H                                          ;; 00:0af9 $54
    ld   E, L                                          ;; 00:0afa $5d
    ld   HL, $04                                       ;; 00:0afb $21 $04 $00
    add  HL, DE                                        ;; 00:0afe $19
    ld   A, $00                                        ;; 00:0aff $3e $00
    ld   B, [HL]                                       ;; 00:0b01 $46
    ld   [HL+], A                                      ;; 00:0b02 $22
    ld   C, [HL]                                       ;; 00:0b03 $4e
    ld   [HL+], A                                      ;; 00:0b04 $22
    push BC                                            ;; 00:0b05 $c5
    ld   HL, $08                                       ;; 00:0b06 $21 $08 $00
    add  HL, DE                                        ;; 00:0b09 $19
    ld   A, [HL+]                                      ;; 00:0b0a $2a
    ld   H, [HL]                                       ;; 00:0b0b $66
    ld   L, A                                          ;; 00:0b0c $6f
    push DE                                            ;; 00:0b0d $d5
    ld   B, $08                                        ;; 00:0b0e $06 $08
    xor  A, A                                          ;; 00:0b10 $af
    call fillMemory                                    ;; 00:0b11 $cd $5d $2b
    pop  DE                                            ;; 00:0b14 $d1
    ld   A, $ff                                        ;; 00:0b15 $3e $ff
    ld   [DE], A                                       ;; 00:0b17 $12
    ld   HL, $02                                       ;; 00:0b18 $21 $02 $00
    add  HL, DE                                        ;; 00:0b1b $19
    pop  DE                                            ;; 00:0b1c $d1
    pop  BC                                            ;; 00:0b1d $c1
    ld   B, [HL]                                       ;; 00:0b1e $46
    ld   A, B                                          ;; 00:0b1f $78
    and  A, $f0                                        ;; 00:0b20 $e6 $f0
    cp   A, $40                                        ;; 00:0b22 $fe $40
    jr   Z, .playerAttack                              ;; 00:0b24 $28 $35
    cp   A, $50                                        ;; 00:0b26 $fe $50
    jr   Z, .playerAttack                              ;; 00:0b28 $28 $31
    cp   A, $60                                        ;; 00:0b2a $fe $60
    jr   Z, .enemyProjectile                           ;; 00:0b2c $28 $39
    cp   A, $70                                        ;; 00:0b2e $fe $70
    jr   Z, .enemyProjectile                           ;; 00:0b30 $28 $35
    cp   A, $30                                        ;; 00:0b32 $fe $30
    jr   Z, .enemyProjectile                           ;; 00:0b34 $28 $31
    cp   A, $90                                        ;; 00:0b36 $fe $90
    jr   Z, .npc                                       ;; 00:0b38 $28 $25
    cp   A, $10                                        ;; 00:0b3a $fe $10
    jr   Z, .npc                                       ;; 00:0b3c $28 $21
    cp   A, $20                                        ;; 00:0b3e $fe $20
    jr   Z, .boss                                      ;; 00:0b40 $28 $21
    cp   A, $80                                        ;; 00:0b42 $fe $80
    jr   Z, .npc                                       ;; 00:0b44 $28 $19
    cp   A, $a0                                        ;; 00:0b46 $fe $a0
    jr   Z, .pushable                                  ;; 00:0b48 $28 $21
    cp   A, $b0                                        ;; 00:0b4a $fe $b0
    jr   Z, .pushable                                  ;; 00:0b4c $28 $1d
    cp   A, $d0                                        ;; 00:0b4e $fe $d0
    jr   Z, .npc                                       ;; 00:0b50 $28 $0d
    cp   A, $c0                                        ;; 00:0b52 $fe $c0
    jr   Z, .player                                    ;; 00:0b54 $28 $01
    ret                                                ;; 00:0b56 $c9
.player:
    call playerObjectDestroy                           ;; 00:0b57 $cd $85 $02
    ret                                                ;; 00:0b5a $c9
.playerAttack:
    call playerAttackDestroy_trampoline                ;; 00:0b5b $cd $f7 $2e
    ret                                                ;; 00:0b5e $c9
.npc:
    call destroyNPC_trampoline                         ;; 00:0b5f $cd $e3 $27
    ret                                                ;; 00:0b62 $c9
.boss:
    call bossClearStatsObjects_trampoline              ;; 00:0b63 $cd $e8 $04
    ret                                                ;; 00:0b66 $c9
.enemyProjectile:
    call projectileDestroy_trampoline                  ;; 00:0b67 $cd $e6 $2b
    ret                                                ;; 00:0b6a $c9
.pushable:
    call destroyPushableObject                         ;; 00:0b6b $cd $13 $2d
    ret                                                ;; 00:0b6e $c9

; C = object id
objectCheckTriggerScriptOrSpikeTile:
    push BC                                            ;; 00:0b6f $c5
    call getFacingOrSlidingDirection                   ;; 00:0b70 $cd $aa $0b
    ld   HL, $04                                       ;; 00:0b73 $21 $04 $00
    add  HL, DE                                        ;; 00:0b76 $19
    ld   D, [HL]                                       ;; 00:0b77 $56
    inc  HL                                            ;; 00:0b78 $23
    ld   E, [HL]                                       ;; 00:0b79 $5e
    or   A, $80                                        ;; 00:0b7a $f6 $80
    ld   L, A                                          ;; 00:0b7c $6f
    pop  BC                                            ;; 00:0b7d $c1
    bit  2, L                                          ;; 00:0b7e $cb $55
    jr   Z, .jr_00_0b86                                ;; 00:0b80 $28 $04
    ld   A, $07                                        ;; 00:0b82 $3e $07
    add  A, D                                          ;; 00:0b84 $82
    ld   D, A                                          ;; 00:0b85 $57
.jr_00_0b86:
    bit  1, L                                          ;; 00:0b86 $cb $4d
    jr   Z, .jr_00_0b8e                                ;; 00:0b88 $28 $04
    ld   A, $07                                        ;; 00:0b8a $3e $07
    add  A, E                                          ;; 00:0b8c $83
    ld   E, A                                          ;; 00:0b8d $5f
.jr_00_0b8e:
    srl  D                                             ;; 00:0b8e $cb $3a
    srl  D                                             ;; 00:0b90 $cb $3a
    srl  D                                             ;; 00:0b92 $cb $3a
    dec  D                                             ;; 00:0b94 $15
    srl  E                                             ;; 00:0b95 $cb $3b
    srl  E                                             ;; 00:0b97 $cb $3b
    srl  E                                             ;; 00:0b99 $cb $3b
    dec  E                                             ;; 00:0b9b $1d
    push DE                                            ;; 00:0b9c $d5
    ld   C, B                                          ;; 00:0b9d $48
    ld   B, L                                          ;; 00:0b9e $45
    push BC                                            ;; 00:0b9f $c5
    call tileScriptOrSpikeDamage                       ;; 00:0ba0 $cd $00 $17
    pop  BC                                            ;; 00:0ba3 $c1
    pop  DE                                            ;; 00:0ba4 $d1
    inc  E                                             ;; 00:0ba5 $1c
    call tileScriptOrSpikeDamage                       ;; 00:0ba6 $cd $00 $17
    ret                                                ;; 00:0ba9 $c9

; C = object id
; Return: A = facing direction, unless sliding
; Return: DE = object runtime data address
getFacingOrSlidingDirection:
    ld   L, C                                          ;; 00:0baa $69
    ld   H, $00                                        ;; 00:0bab $26 $00
    add  HL, HL                                        ;; 00:0bad $29
    add  HL, HL                                        ;; 00:0bae $29
    add  HL, HL                                        ;; 00:0baf $29
    add  HL, HL                                        ;; 00:0bb0 $29
    ld   BC, wObjectRuntimeData                        ;; 00:0bb1 $01 $00 $c2
    add  HL, BC                                        ;; 00:0bb4 $09
    ld   D, H                                          ;; 00:0bb5 $54
    ld   E, L                                          ;; 00:0bb6 $5d
    ld   C, [HL]                                       ;; 00:0bb7 $4e
    ld   HL, $0a                                       ;; 00:0bb8 $21 $0a $00
    add  HL, DE                                        ;; 00:0bbb $19
    ld   A, [HL]                                       ;; 00:0bbc $7e
    bit  7, A                                          ;; 00:0bbd $cb $7f
    jr   NZ, .jr_00_0bc2                               ;; 00:0bbf $20 $01
    ld   A, C                                          ;; 00:0bc1 $79
.jr_00_0bc2:
    and  A, $0f                                        ;; 00:0bc2 $e6 $0f
    ret                                                ;; 00:0bc4 $c9

; Initializes all 20 objects and then reserves the first seven
initObjects:
    ld   HL, wObjectRuntimeData                        ;; 00:0bd1 $21 $00 $c2
    ld   DE, wOAMBuffer                                ;; 00:0bd4 $11 $00 $c0
    ld   A, $ff                                        ;; 00:0bd7 $3e $ff
    ld   B, $14                                        ;; 00:0bd9 $06 $14
.loop_1:
    push HL                                            ;; 00:0bdb $e5
    ld   [HL], $ff                                     ;; 00:0bdc $36 $ff
    inc  HL                                            ;; 00:0bde $23
    inc  HL                                            ;; 00:0bdf $23
    inc  HL                                            ;; 00:0be0 $23
    inc  HL                                            ;; 00:0be1 $23
    inc  HL                                            ;; 00:0be2 $23
    inc  HL                                            ;; 00:0be3 $23
    inc  HL                                            ;; 00:0be4 $23
    inc  HL                                            ;; 00:0be5 $23
    ld   [HL], E                                       ;; 00:0be6 $73
    inc  HL                                            ;; 00:0be7 $23
    ld   [HL], D                                       ;; 00:0be8 $72
    ld   HL, $08                                       ;; 00:0be9 $21 $08 $00
    add  HL, DE                                        ;; 00:0bec $19
    pop  DE                                            ;; 00:0bed $d1
    push HL                                            ;; 00:0bee $e5
    ld   HL, $10                                       ;; 00:0bef $21 $10 $00
    add  HL, DE                                        ;; 00:0bf2 $19
    pop  DE                                            ;; 00:0bf3 $d1
    dec  B                                             ;; 00:0bf4 $05
    jr   NZ, .loop_1                                   ;; 00:0bf5 $20 $e4
    ld   B, $07                                        ;; 00:0bf7 $06 $07
    ld   C, $40                                        ;; 00:0bf9 $0e $40
.loop_2:
    push BC                                            ;; 00:0bfb $c5
    ld   A, $01                                        ;; 00:0bfc $3e $01
    ld   DE, $fefe                                     ;; 00:0bfe $11 $fe $fe
    ld   HL, playerMetaspriteTable                     ;; 00:0c01 $21 $c5 $0b
    call createObject                                  ;; 00:0c04 $cd $74 $0a
    pop  BC                                            ;; 00:0c07 $c1
    dec  B                                             ;; 00:0c08 $05
    jr   NZ, .loop_2                                   ;; 00:0c09 $20 $f0
    ret                                                ;; 00:0c0b $c9

; When moving between two eight pixel tiles, the middle four pixels use the other walking frame.
; Returns NZ if x or y & 7 is 2,3,4,5 but Z if it is 0,1,6,7.
checkStepAnimation:
    ld   L, C                                          ;; 00:0c0c $69
    ld   H, $00                                        ;; 00:0c0d $26 $00
    add  HL, HL                                        ;; 00:0c0f $29
    add  HL, HL                                        ;; 00:0c10 $29
    add  HL, HL                                        ;; 00:0c11 $29
    add  HL, HL                                        ;; 00:0c12 $29
    ld   BC, wObjectRuntimeData                        ;; 00:0c13 $01 $00 $c2
    add  HL, BC                                        ;; 00:0c16 $09
    ld   BC, $04                                       ;; 00:0c17 $01 $04 $00
    add  HL, BC                                        ;; 00:0c1a $09
    ld   A, [HL+]                                      ;; 00:0c1b $2a
    add  A, [HL]                                       ;; 00:0c1c $86
    ld   C, A                                          ;; 00:0c1d $4f
    add  A, A                                          ;; 00:0c1e $87
    xor  A, C                                          ;; 00:0c1f $a9
    ld   C, A                                          ;; 00:0c20 $4f
    ld   A, [wMainGameStateFlags]                      ;; 00:0c21 $fa $a1 $c0
    bit  0, A                                          ;; 00:0c24 $cb $47
    jr   Z, .jr_00_0c2a                                ;; 00:0c26 $28 $02
    ld   C, $00                                        ;; 00:0c28 $0e $00
.jr_00_0c2a:
    bit  2, C                                          ;; 00:0c2a $cb $51
    ret                                                ;; 00:0c2c $c9

GetObjectX:
    ld   L, C                                          ;; 00:0c2d $69
    ld   H, $00                                        ;; 00:0c2e $26 $00
    add  HL, HL                                        ;; 00:0c30 $29
    add  HL, HL                                        ;; 00:0c31 $29
    add  HL, HL                                        ;; 00:0c32 $29
    add  HL, HL                                        ;; 00:0c33 $29
    ld bc, wObjectRuntimeData + $0005
    add  HL, BC                                        ;; 00:0c37 $09
    ld   A, [HL]                                       ;; 00:0c3c $7e
    ret                                                ;; 00:0c3d $c9

GetObjectY:
    ld   L, C                                          ;; 00:0c3e $69
    ld   H, $00                                        ;; 00:0c3f $26 $00
    add  HL, HL                                        ;; 00:0c41 $29
    add  HL, HL                                        ;; 00:0c42 $29
    add  HL, HL                                        ;; 00:0c43 $29
    add  HL, HL                                        ;; 00:0c44 $29
    ld bc, wObjectRuntimeData + $0004
    add  HL, BC                                        ;; 00:0c48 $09
    ld   A, [HL]                                       ;; 00:0c4d $7e
    ret                                                ;; 00:0c4e $c9

; c = object number
; Return: hl = metsprite table pointer
getObjectMetaspriteTablePointer:
    ld l, c
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, wObjectRuntimeData + $0006
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret

setObjectSpeed:
    ld   L, C                                          ;; 00:0c5d $69
    ld   H, $00                                        ;; 00:0c5e $26 $00
    add  HL, HL                                        ;; 00:0c60 $29
    add  HL, HL                                        ;; 00:0c61 $29
    add  HL, HL                                        ;; 00:0c62 $29
    add  HL, HL                                        ;; 00:0c63 $29
    ld   BC, wObjectRuntimeData                        ;; 00:0c64 $01 $00 $c2
    add  HL, BC                                        ;; 00:0c67 $09
    inc  HL                                            ;; 00:0c68 $23
    ld   C, [HL]                                       ;; 00:0c69 $4e
    ld   [HL-], A                                      ;; 00:0c6a $32
    ld   A, C                                          ;; 00:0c6b $79
    ret                                                ;; 00:0c6c $c9

getObjectCollisionFlags:
    ld   L, C                                          ;; 00:0c6d $69
    ld   H, $00                                        ;; 00:0c6e $26 $00
    add  HL, HL                                        ;; 00:0c70 $29
    add  HL, HL                                        ;; 00:0c71 $29
    add  HL, HL                                        ;; 00:0c72 $29
    add  HL, HL                                        ;; 00:0c73 $29
    ld   BC, wObjectRuntimeData                        ;; 00:0c74 $01 $00 $c2
    add  HL, BC                                        ;; 00:0c77 $09
    ld   A, [HL]                                       ;; 00:0c78 $7e
    cp   A, $ff                                        ;; 00:0c79 $fe $ff
    jr   Z, .jr_00_0c83                                ;; 00:0c7b $28 $06
    ld   DE, $02                                       ;; 00:0c7d $11 $02 $00
    add  HL, DE                                        ;; 00:0c80 $19
    ld   A, [HL]                                       ;; 00:0c81 $7e
    ret                                                ;; 00:0c82 $c9
.jr_00_0c83:
    ld   A, $00                                        ;; 00:0c83 $3e $00
    ret                                                ;; 00:0c85 $c9

; A = flags
; C = object number
setObjectCollisionFlags:
    ld   L, C                                          ;; 00:0c86 $69
    ld   H, $00                                        ;; 00:0c87 $26 $00
    add  HL, HL                                        ;; 00:0c89 $29
    add  HL, HL                                        ;; 00:0c8a $29
    add  HL, HL                                        ;; 00:0c8b $29
    add  HL, HL                                        ;; 00:0c8c $29
    ld   BC, wObjectRuntimeData                        ;; 00:0c8d $01 $00 $c2
    add  HL, BC                                        ;; 00:0c90 $09
    ld   DE, $02                                       ;; 00:0c91 $11 $02 $00
    add  HL, DE                                        ;; 00:0c94 $19
    ld   C, [HL]                                       ;; 00:0c95 $4e
    ld   [HL], A                                       ;; 00:0c96 $77
    ld   A, C                                          ;; 00:0c97 $79
    ret                                                ;; 00:0c98 $c9

getObjectDirection:
    ld   L, C                                          ;; 00:0c99 $69
    ld   H, $00                                        ;; 00:0c9a $26 $00
    add  HL, HL                                        ;; 00:0c9c $29
    add  HL, HL                                        ;; 00:0c9d $29
    add  HL, HL                                        ;; 00:0c9e $29
    add  HL, HL                                        ;; 00:0c9f $29
    ld   BC, wObjectRuntimeData                        ;; 00:0ca0 $01 $00 $c2
    add  HL, BC                                        ;; 00:0ca3 $09
    ld   A, [HL]                                       ;; 00:0ca4 $7e
    ret                                                ;; 00:0ca5 $c9

setObjectDirection:
    ld   L, C                                          ;; 00:0ca6 $69
    ld   H, $00                                        ;; 00:0ca7 $26 $00
    add  HL, HL                                        ;; 00:0ca9 $29
    add  HL, HL                                        ;; 00:0caa $29
    add  HL, HL                                        ;; 00:0cab $29
    add  HL, HL                                        ;; 00:0cac $29
    ld   BC, wObjectRuntimeData                        ;; 00:0cad $01 $00 $c2
    add  HL, BC                                        ;; 00:0cb0 $09
    ld   C, [HL]                                       ;; 00:0cb1 $4e
    ld   [HL], A                                       ;; 00:0cb2 $77
    ld   A, C                                          ;; 00:0cb3 $79
    cp   A, $ff                                        ;; 00:0cb4 $fe $ff
    ret  NZ                                            ;; 00:0cb6 $c0
    ld   [HL], $ff                                     ;; 00:0cb7 $36 $ff
    ret                                                ;; 00:0cb9 $c9

; For object C set the metasprite pointer to DE
setObjectMetaspritePointer:
    push HL                                            ;; 00:0cba $e5
    ld   L, C                                          ;; 00:0cbb $69
    ld   H, $00                                        ;; 00:0cbc $26 $00
    add  HL, HL                                        ;; 00:0cbe $29
    add  HL, HL                                        ;; 00:0cbf $29
    add  HL, HL                                        ;; 00:0cc0 $29
    add  HL, HL                                        ;; 00:0cc1 $29
    ld   BC, wObjectRuntimeData                        ;; 00:0cc2 $01 $00 $c2
    add  HL, BC                                        ;; 00:0cc5 $09
    ld   A, [HL]                                       ;; 00:0cc6 $7e
    cp   A, $ff                                        ;; 00:0cc7 $fe $ff
    pop  DE                                            ;; 00:0cc9 $d1
    ret  Z                                             ;; 00:0cca $c8
    ld   BC, $06                                       ;; 00:0ccb $01 $06 $00
    add  HL, BC                                        ;; 00:0cce $09
    ld   [HL], E                                       ;; 00:0ccf $73
    inc  HL                                            ;; 00:0cd0 $23
    ld   [HL], D                                       ;; 00:0cd1 $72
    ret                                                ;; 00:0cd2 $c9

getObjectSliding:
    ld   L, C                                          ;; 00:0cd3 $69
    ld   H, $00                                        ;; 00:0cd4 $26 $00
    add  HL, HL                                        ;; 00:0cd6 $29
    add  HL, HL                                        ;; 00:0cd7 $29
    add  HL, HL                                        ;; 00:0cd8 $29
    add  HL, HL                                        ;; 00:0cd9 $29
    ld   BC, wObjectRuntimeData                        ;; 00:0cda $01 $00 $c2
    add  HL, BC                                        ;; 00:0cdd $09
    ld   DE, $0a                                       ;; 00:0cde $11 $0a $00
    add  HL, DE                                        ;; 00:0ce1 $19
    ld   A, [HL-]                                      ;; 00:0ce2 $3a
    ret                                                ;; 00:0ce3 $c9

setObjectSliding:
    ld   L, C                                          ;; 00:0ce4 $69
    ld   H, $00                                        ;; 00:0ce5 $26 $00
    add  HL, HL                                        ;; 00:0ce7 $29
    add  HL, HL                                        ;; 00:0ce8 $29
    add  HL, HL                                        ;; 00:0ce9 $29
    add  HL, HL                                        ;; 00:0cea $29
    ld   BC, wObjectRuntimeData                        ;; 00:0ceb $01 $00 $c2
    add  HL, BC                                        ;; 00:0cee $09
    ld   DE, $0a                                       ;; 00:0cef $11 $0a $00
    add  HL, DE                                        ;; 00:0cf2 $19
    ld   C, [HL]                                       ;; 00:0cf3 $4e
    ld   [HL-], A                                      ;; 00:0cf4 $32
    ld   A, C                                          ;; 00:0cf5 $79
    ret                                                ;; 00:0cf6 $c9

; Move the follower to the position of the player
moveFollowerToPlayer:
    call checkForFollower
    ret nz
    call getPlayerY
    ld D, A
    call getPlayerX
    ld E, A
    ld C, $00
    jp updateNpcPosition_trampoline

setObjectOffset0b:
    ld   L, C                                          ;; 00:0d08 $69
    ld   H, $00                                        ;; 00:0d09 $26 $00
    add  HL, HL                                        ;; 00:0d0b $29
    add  HL, HL                                        ;; 00:0d0c $29
    add  HL, HL                                        ;; 00:0d0d $29
    add  HL, HL                                        ;; 00:0d0e $29
    ld   BC, wObjectRuntimeData                        ;; 00:0d0f $01 $00 $c2
    add  HL, BC                                        ;; 00:0d12 $09
    ld   DE, $0b                                       ;; 00:0d13 $11 $0b $00
    add  HL, DE                                        ;; 00:0d16 $19
    ld   C, [HL]                                       ;; 00:0d17 $4e
    ld   [HL-], A                                      ;; 00:0d18 $32
    ld   A, C                                          ;; 00:0d19 $79
    ret                                                ;; 00:0d1a $c9

scriptOpCodePlayerJump:
    ld   A, [wScriptOpCounter]                         ;; 00:0d1b $fa $99 $d4
    cp   A, $00                                        ;; 00:0d1e $fe $00
    call Z, playerJumpInit                             ;; 00:0d20 $cc $51 $0d
    ld   B, A                                          ;; 00:0d23 $47
    ld   A, [wScriptOpCounter2]                        ;; 00:0d24 $fa $9a $d4
    dec  A                                             ;; 00:0d27 $3d
    ld   [wScriptOpCounter2], A                        ;; 00:0d28 $ea $9a $d4
    ret  NZ                                            ;; 00:0d2b $c0
    push HL                                            ;; 00:0d2c $e5
    ld   C, $04                                        ;; 00:0d2d $0e $04
    push BC                                            ;; 00:0d2f $c5
    call getObjectDirection                            ;; 00:0d30 $cd $99 $0c
    ld   D, A                                          ;; 00:0d33 $57
    pop  BC                                            ;; 00:0d34 $c1
    ld   A, [wPlayerJumpArg]                           ;; 00:0d35 $fa $98 $d4
    ld   E, A                                          ;; 00:0d38 $5f
    ld   A, B                                          ;; 00:0d39 $78
    ld   B, $00                                        ;; 00:0d3a $06 $00
    call objectJumpHandler_trampoline                  ;; 00:0d3c $cd $27 $2c
    pop  HL                                            ;; 00:0d3f $e1
    ld   [wScriptOpCounter], A                         ;; 00:0d40 $ea $99 $d4
    cp   A, $00                                        ;; 00:0d43 $fe $00
    jr   Z, .done                                      ;; 00:0d45 $28 $06
    ld   A, $08                                        ;; 00:0d47 $3e $08
    ld   [wScriptOpCounter2], A                        ;; 00:0d49 $ea $9a $d4
    ret                                                ;; 00:0d4c $c9
.done:
    call getNextScriptInstruction                      ;; 00:0d4d $cd $27 $37
    ret                                                ;; 00:0d50 $c9

playerJumpInit:
    ld   A, [HL+]                                      ;; 00:0d51 $2a
    sub  A, $20                                        ;; 00:0d52 $d6 $20
    ld   [wPlayerJumpArg], A                           ;; 00:0d54 $ea $98 $d4
    ld   A, $01                                        ;; 00:0d57 $3e $01
    ld   [wScriptOpCounter2], A                        ;; 00:0d59 $ea $9a $d4
    ld   A, $00                                        ;; 00:0d5c $3e $00
    ret                                                ;; 00:0d5e $c9

scriptOpCodeCheckIfCanOpenMap:
    push HL                                            ;; 00:0d5f $e5
    ld a, [wMapNumber]
    cp   A, $01                                        ;; 00:0d63 $fe $01
    jr   Z, .no_minimap                                ;; 00:0d65 $28 $12
    cp   A, $0e                                        ;; 00:0d67 $fe $0e
    jr   Z, .no_minimap                                ;; 00:0d69 $28 $0e
    cp   A, $0f                                        ;; 00:0d6b $fe $0f
    jr   Z, .no_minimap                                ;; 00:0d6d $28 $0a
    ld   A, $7f                                        ;; 00:0d6f $3e $7f
    call setScriptFlag                                 ;; 00:0d71 $cd $e4 $3b
    pop  HL                                            ;; 00:0d74 $e1
    call getNextScriptInstruction                      ;; 00:0d75 $cd $27 $37
    ret                                                ;; 00:0d78 $c9
.no_minimap:
    ld   A, $7f                                        ;; 00:0d79 $3e $7f
    call clearScriptFlag                               ;; 00:0d7b $cd $ee $3b
    pop  HL                                            ;; 00:0d7e $e1
    call getNextScriptInstruction                      ;; 00:0d7f $cd $27 $37
    ret                                                ;; 00:0d82 $c9

scriptOpCodeClearRoomHistory:
    push HL                                            ;; 00:0d83 $e5
    call clearRoomStatusHistory                        ;; 00:0d84 $cd $b4 $21
    pop  HL                                            ;; 00:0d87 $e1
    call getNextScriptInstruction                      ;; 00:0d88 $cd $27 $37
    ret                                                ;; 00:0d8b $c9

; On SGB the letterbox routine used during the ending will now black out the border
scriptOpCodeSetLetterboxGraphicEffect:
    call enhancedLetterbox_trampoline
    ret nz
    call getNextScriptInstruction
    ret

    nop

prepareLetterboxEffect_trampoline:
    jp_to_bank 01, prepareLetterboxEffect              ;; 00:0d95 $f5 $3e $16 $c3 $d7 $1e

scriptOpCodeSetNormalGraphicEffect:
    push HL                                            ;; 00:0d9b $e5
    call prepareDefaultEffect_trampoline               ;; 00:0d9c $cd $a4 $0d
    pop  HL                                            ;; 00:0d9f $e1
    call getNextScriptInstruction                      ;; 00:0da0 $cd $27 $37
    ret                                                ;; 00:0da3 $c9

prepareDefaultEffect_trampoline:
    jp_to_bank 01, prepareDefaultEffect                ;; 00:0da4 $f5 $3e $17 $c3 $d7 $1e

prepareIntroScrollEffect_trampoline:
    jp_to_bank 01, prepareIntroScrollEffect            ;; 00:0daa $f5 $3e $13 $c3 $d7 $1e

introScrollEffectUpdateLCDEffect_trampoline:
    jp_to_bank 01, introScrollEffectUpdateLCDEffect    ;; 00:0db0 $f5 $3e $14 $c3 $d7 $1e

setDefaultLCDEffectAndBGP_trampoline:
    jp_to_bank 01, setDefaultLCDEffectAndBGP           ;; 00:0db6 $f5 $3e $15 $c3 $d7 $1e

scriptOpCodeWaitMapClose:
    push HL                                            ;; 00:0dbc $e5
; Joypad input is in d.
    ld a, d
    or a
    jr   NZ, .button_pressed                           ;; 00:0dc2 $20 $1d
; Each blink cycle lasts 64 frames.
    ld hl, wScriptOpCounter2
    inc [hl]
    bit 5, [hl]
    jr   NZ, .hide_marker                              ;; 00:0dcd $20 $0b
    xor a
    ld b, a
    ld c, a
IF DEF(COLOR)
; Set a color palette.
    call processPhysicsForObject                       ;; 00:0dd5 $cd $95 $06
    ld a, PALETTE_SET_MAP_OBJ
    ld b, PAL_ATTACK
    call loadSinglePaletteBank2
ENDC
    pop  HL                                            ;; 00:0dd8 $e1
    ret                                                ;; 00:0dd9 $c9
.hide_marker:
    ld   C, $00                                        ;; 00:0dda $0e $00
    call hideMinimapFlashingMarker                     ;; 00:0ddc $cd $cd $05
    pop  HL                                            ;; 00:0ddf $e1
    ret                                                ;; 00:0de0 $c9
.button_pressed:
    pop  HL                                            ;; 00:0de1 $e1
    call getNextScriptInstruction                      ;; 00:0de2 $cd $27 $37
    ret                                                ;; 00:0de5 $c9

drawMinimap:
    ld   A, [wMapTableBankNrTmp]                       ;; 00:0de6 $fa $a0 $d4
    call pushBankNrAndSwitch                           ;; 00:0de9 $cd $fb $29
    ld   A, [wMapNumberTmp]                            ;; 00:0dec $fa $9d $d4
    ld   D, A                                          ;; 00:0def $57
    ld   E, $00                                        ;; 00:0df0 $1e $00
    ld   B, $08                                        ;; 00:0df2 $06 $08
.loop_outer:
    ld   C, $08                                        ;; 00:0df4 $0e $08
.loop_inner:
    push BC                                            ;; 00:0df6 $c5
    call checkRoomVisited                              ;; 00:0df7 $cd $f6 $21
    call Z, drawMinimapRoomTile                        ;; 00:0dfa $cc $0f $0e
    inc  E                                             ;; 00:0dfd $1c
    pop  BC                                            ;; 00:0dfe $c1
    dec  C                                             ;; 00:0dff $0d
    jr   NZ, .loop_inner                               ;; 00:0e00 $20 $f4
    ld   A, E                                          ;; 00:0e02 $7b
    and  A, $f0                                        ;; 00:0e03 $e6 $f0
    add  A, $10                                        ;; 00:0e05 $c6 $10
    ld   E, A                                          ;; 00:0e07 $5f
    dec  B                                             ;; 00:0e08 $05
    jr   NZ, .loop_outer                               ;; 00:0e09 $20 $e9
    call popBankNrAndSwitch                            ;; 00:0e0b $cd $0a $2a
    ret                                                ;; 00:0e0e $c9

drawMinimapRoomTile:
    push DE                                            ;; 00:0e0f $d5
    ld   A, E                                          ;; 00:0e10 $7b
    and  A, $0f                                        ;; 00:0e11 $e6 $0f
    ld   D, A                                          ;; 00:0e13 $57
    ld   A, E                                          ;; 00:0e14 $7b
    swap A                                             ;; 00:0e15 $cb $37
    and  A, $0f                                        ;; 00:0e17 $e6 $0f
    ld   E, A                                          ;; 00:0e19 $5f
    push DE                                            ;; 00:0e1a $d5
    call getRoomPointers                               ;; 00:0e1b $cd $44 $0e
    ld   C, $00                                        ;; 00:0e1e $0e $00
    ld   B, $04                                        ;; 00:0e20 $06 $04
.loop:
    ld   A, [HL+]                                      ;; 00:0e22 $2a
    bit  1, A                                          ;; 00:0e23 $cb $4f
    jr   NZ, .jr_00_0e29                               ;; 00:0e25 $20 $02
    set  4, C                                          ;; 00:0e27 $cb $e1
.jr_00_0e29:
    srl  C                                             ;; 00:0e29 $cb $39
    dec  B                                             ;; 00:0e2b $05
    jr   NZ, .loop                                     ;; 00:0e2c $20 $f4
    ld   A, $11                                        ;; 00:0e2e $3e $11
    add  A, C                                          ;; 00:0e30 $81
    call loadMinimapTile                               ;; 00:0e31 $cd $3b $1a
    ld   C, A                                          ;; 00:0e34 $4f
    pop  DE                                            ;; 00:0e35 $d1
    ld   A, D                                          ;; 00:0e36 $7a
    add  A, $04                                        ;; 00:0e37 $c6 $04
    ld   D, A                                          ;; 00:0e39 $57
    ld   A, E                                          ;; 00:0e3a $7b
    add  A, $06                                        ;; 00:0e3b $c6 $06
    ld   E, A                                          ;; 00:0e3d $5f
    ld   A, C                                          ;; 00:0e3e $79
    call storeAatBackgroundDrawPosition                ;; 00:0e3f $cd $7c $04
    pop  DE                                            ;; 00:0e42 $d1
    ret                                                ;; 00:0e43 $c9

; DE = room yx coordinate
; Returns: DE = entry script pointer
; Returns: HL = room door initial states pointer
getRoomPointers:
    push DE                                            ;; 00:0e44 $d5
    ld   L, D                                          ;; 00:0e45 $6a
    ld   H, $00                                        ;; 00:0e46 $26 $00
    ld   A, [wMapWidthTmp]                             ;; 00:0e48 $fa $9f $d4
    call MultiplyHL_by_A                               ;; 00:0e4b $cd $7b $2b
    pop  DE                                            ;; 00:0e4e $d1
    ld   D, $00                                        ;; 00:0e4f $16 $00
    add  HL, DE                                        ;; 00:0e51 $19
    add  HL, HL                                        ;; 00:0e52 $29
    add  HL, HL                                        ;; 00:0e53 $29
    ld   A, [wDynamicMinimapMapTablePointer.high]      ;; 00:0e54 $fa $a2 $d4
    ld   D, A                                          ;; 00:0e57 $57
    ld   A, [wDynamicMinimapMapTablePointer]           ;; 00:0e58 $fa $a1 $d4
    ld   E, A                                          ;; 00:0e5b $5f
    add  HL, DE                                        ;; 00:0e5c $19
    ld   DE, $1a                                       ;; 00:0e5d $11 $1a $00
    add  HL, DE                                        ;; 00:0e60 $19
    ld   E, [HL]                                       ;; 00:0e61 $5e
    inc  HL                                            ;; 00:0e62 $23
    ld   D, [HL]                                       ;; 00:0e63 $56
    inc  HL                                            ;; 00:0e64 $23
    ld   A, [HL+]                                      ;; 00:0e65 $2a
    ld   H, [HL]                                       ;; 00:0e66 $66
    ld   L, A                                          ;; 00:0e67 $6f
    ret                                                ;; 00:0e68 $c9

scriptOpCodeSpawnBoss:
    ld   A, [HL+]                                      ;; 00:0e69 $2a
    push HL                                            ;; 00:0e6a $e5
    call spawnBoss_trampoline                          ;; 00:0e6b $cd $e2 $04
    pop  HL                                            ;; 00:0e6e $e1
    call getNextScriptInstruction                      ;; 00:0e6f $cd $27 $37
    ret                                                ;; 00:0e72 $c9

scriptOpCodeRunRoomScript:
    call runRoomScript                                 ;; 00:0e73 $cd $d4 $24
    ret                                                ;; 00:0e76 $c9

scriptOpCodeRunRoomExitScript:
    call runRoomExitScript                             ;; 00:0e77 $cd $f9 $24
    ret                                                ;; 00:0e7a $c9

scriptOpCodeRunRoomAllKilledScript:
    call runRoomAllKilledScript                        ;; 00:0e7b $cd $1f $25
    ret                                                ;; 00:0e7e $c9

scriptOpCodeSetNextRoom:
    ld a, [hl+]
    ld [wNextRoomOverride], a
    ld a, [hl+]
    ld [wNextRoomOverride.x], a
    call getNextScriptInstruction
    ret

scriptOpCodeShakeScreen:
    ld   A, [wVideoSCX]                                ;; 00:0e8c $fa $a6 $c0
    ld   C, A                                          ;; 00:0e8f $4f
    ld   A, [wScriptOpCounter]                         ;; 00:0e90 $fa $99 $d4
    and  A, $07                                        ;; 00:0e93 $e6 $07
    sub  A, $02                                        ;; 00:0e95 $d6 $02
    cp   A, $04                                        ;; 00:0e97 $fe $04
    jr   NC, .jr_00_0e9f                               ;; 00:0e99 $30 $04
    inc  C                                             ;; 00:0e9b $0c
    inc  C                                             ;; 00:0e9c $0c
    jr   .jr_00_0ea1                                   ;; 00:0e9d $18 $02
.jr_00_0e9f:
    dec  C                                             ;; 00:0e9f $0d
    dec  C                                             ;; 00:0ea0 $0d
.jr_00_0ea1:
    ld   A, C                                          ;; 00:0ea1 $79
    ld   [wVideoSCX], A                                ;; 00:0ea2 $ea $a6 $c0
    ld   A, [wScriptOpCounter]                         ;; 00:0ea5 $fa $99 $d4
    inc  A                                             ;; 00:0ea8 $3c
    and  A, $3f                                        ;; 00:0ea9 $e6 $3f
    ld   [wScriptOpCounter], A                         ;; 00:0eab $ea $99 $d4
    call Z, getNextScriptInstruction                   ;; 00:0eae $cc $27 $37
    ret                                                ;; 00:0eb1 $c9

; 08 = Recovery effect used at the ponds
; 10 = Explosion effect
; 2c = Fire effect used by Julius at the airship
; These use the player's attacks with $08 being Cure and $2c being the Fire spell after targeting.
scriptOpCodeCreateEffect:
    ld   D, H                                          ;; 00:0eb2 $54
    ld   E, L                                          ;; 00:0eb3 $5d
    ld   A, [wScriptOpCounter]                         ;; 00:0eb4 $fa $99 $d4
    ld   HL, specialEffectJumptable ;@=ptr specialEffectJumptable ;; 00:0eb7 $21 $ca $0e
    call callJumptable                                 ;; 00:0eba $cd $70 $2b
    ret                                                ;; 00:0ebd $c9

INCLUDE "data/metasprites_effects.asm"

;@jumptable amount=2
specialEffectJumptable:
    dw   specialEffectInit                             ;; 00:0eca ?? $00
    dw   specialEffectAnimate                          ;; 00:0ecc ?? $01

; For the color target this also loads a palette.
specialEffectInit:
    ld   H, D                                          ;; 00:0ece $62
    ld   L, E                                          ;; 00:0ecf $6b
    ld   A, [HL+]                                      ;; 00:0ed0 $2a
    ld   E, [HL]                                       ;; 00:0ed1 $5e
    inc  HL                                            ;; 00:0ed2 $23
    ld   D, [HL]                                       ;; 00:0ed3 $56
    inc  HL                                            ;; 00:0ed4 $23
; A palette id has been added to these script commands.
    inc hl
    push HL                                            ;; 00:0ed5 $e5
    push AF                                            ;; 00:0ed6 $f5
IF DEF(COLOR)
; Load a palette to the player's attack palette.
    dec hl
    ld a, [hl]
    ld b, PAL_ATTACK
    call loadSinglePaletteBank2
ENDC
    ld   HL, specialEffectMetaspriteTable              ;; 00:0ed7 $21 $be $0e
    ld   C, $07                                        ;; 00:0eda $0e $07
    xor a
    call createObject                                  ;; 00:0ede $cd $74 $0a
    ld   [wScriptOpCounter2], A                        ;; 00:0ee1 $ea $9a $d4
    ld   C, A                                          ;; 00:0ee4 $4f
    pop  AF                                            ;; 00:0ee5 $f1
    call call_00_2f03                                  ;; 00:0ee6 $cd $03 $2f
    ld   HL, wScriptOpCounter                          ;; 00:0ee9 $21 $99 $d4
    inc  [HL]                                          ;; 00:0eec $34
    pop  HL                                            ;; 00:0eed $e1
    ret                                                ;; 00:0eee $c9

specialEffectAnimate:
    push DE                                            ;; 00:0eef $d5
    call runPlayerAttackObjectFunctions_trampoline     ;; 00:0ef0 $cd $d3 $2e
    pop  HL                                            ;; 00:0ef3 $e1
    ret  NZ                                            ;; 00:0ef4 $c0
    push HL                                            ;; 00:0ef5 $e5
    ld   A, [wScriptOpCounter2]                        ;; 00:0ef6 $fa $9a $d4
    ld   C, A                                          ;; 00:0ef9 $4f
    call destroyObject                                 ;; 00:0efa $cd $e3 $0a
    ld   A, $00                                        ;; 00:0efd $3e $00
    ld   [wScriptOpCounter], A                         ;; 00:0eff $ea $99 $d4
    ld   [wScriptOpCounter2], A                        ;; 00:0f02 $ea $9a $d4
    pop  HL                                            ;; 00:0f05 $e1
    call getNextScriptInstruction                      ;; 00:0f06 $cd $27 $37
    ret                                                ;; 00:0f09 $c9

scriptOpCodeGiveFollower:
    ld   A, [HL+]                                      ;; 00:0f0a $2a
    push HL                                            ;; 00:0f0b $e5
    call giveFollower_trampoline                       ;; 00:0f0c $cd $95 $28
    pop  HL                                            ;; 00:0f0f $e1
    call getNextScriptInstruction                      ;; 00:0f10 $cd $27 $37
    ret                                                ;; 00:0f13 $c9

scriptOpCodeGiveFollower_Dup:
    ld   A, [HL+]                                      ;; 00:0f14 $2a
    push HL                                            ;; 00:0f15 $e5
    call giveFollower_trampoline                       ;; 00:0f16 $cd $95 $28
    pop  HL                                            ;; 00:0f19 $e1
    call getNextScriptInstruction                      ;; 00:0f1a $cd $27 $37
    ret                                                ;; 00:0f1d $c9

scriptOpCodeSetRoomTile:
    ld   A, [HL+]                                      ;; 00:0f1e $2a
    ld   E, [HL]                                       ;; 00:0f1f $5e
    inc  HL                                            ;; 00:0f20 $23
    ld   D, [HL]                                       ;; 00:0f21 $56
    inc  HL                                            ;; 00:0f22 $23
    push HL                                            ;; 00:0f23 $e5
    call setRoomTile                                   ;; 00:0f24 $cd $00 $24
    pop  HL                                            ;; 00:0f27 $e1
    call getNextScriptInstruction                      ;; 00:0f28 $cd $27 $37
    ret                                                ;; 00:0f2b $c9

scriptOpCodeScrollRoomLeft:
    push HL                                            ;; 00:0f2c $e5
    ld   B, $00                                        ;; 00:0f2d $06 $00
    ld   A, $82                                        ;; 00:0f2f $3e $82
    call playerSpritesLoadPlayerSpriteTiles_trampoline ;; 00:0f31 $cd $32 $02
    ld   D, ROOM_SCROLL_SPEED                          ;; 00:0f34 $16 $04
    ld   A, DIRECTIONF_EAST                            ;; 00:0f36 $3e $01
    call scrollRoom_trampoline                         ;; 00:0f38 $cd $9e $04
    pop  HL                                            ;; 00:0f3b $e1
    cp   A, $00                                        ;; 00:0f3c $fe $00
    ret  NZ                                            ;; 00:0f3e $c0
    call getNextScriptInstruction                      ;; 00:0f3f $cd $27 $37
    ret                                                ;; 00:0f42 $c9

scriptOpCodeScrollRoomRight:
    push HL                                            ;; 00:0f43 $e5
    ld   B, $00                                        ;; 00:0f44 $06 $00
    ld   A, $81                                        ;; 00:0f46 $3e $81
    call playerSpritesLoadPlayerSpriteTiles_trampoline ;; 00:0f48 $cd $32 $02
    ld   D, ROOM_SCROLL_SPEED                          ;; 00:0f4b $16 $04
    ld   A, DIRECTIONF_WEST                            ;; 00:0f4d $3e $02
    call scrollRoom_trampoline                         ;; 00:0f4f $cd $9e $04
    pop  HL                                            ;; 00:0f52 $e1
    cp   A, $00                                        ;; 00:0f53 $fe $00
    ret  NZ                                            ;; 00:0f55 $c0
    call getNextScriptInstruction                      ;; 00:0f56 $cd $27 $37
    ret                                                ;; 00:0f59 $c9

scriptOpCodeScrollRoomDown:
    push HL                                            ;; 00:0f5a $e5
    ld   B, $00                                        ;; 00:0f5b $06 $00
    ld   A, $88                                        ;; 00:0f5d $3e $88
    call playerSpritesLoadPlayerSpriteTiles_trampoline ;; 00:0f5f $cd $32 $02
    ld   D, ROOM_SCROLL_SPEED                          ;; 00:0f62 $16 $04
    ld   A, DIRECTIONF_NORTH                           ;; 00:0f64 $3e $04
    call scrollRoom_trampoline                         ;; 00:0f66 $cd $9e $04
    pop  HL                                            ;; 00:0f69 $e1
    cp   A, $00                                        ;; 00:0f6a $fe $00
    ret  NZ                                            ;; 00:0f6c $c0
    call getNextScriptInstruction                      ;; 00:0f6d $cd $27 $37
    ret                                                ;; 00:0f70 $c9

scriptOpCodeScrollRoomUp:
    push HL                                            ;; 00:0f71 $e5
    ld   B, $00                                        ;; 00:0f72 $06 $00
    ld   A, $84                                        ;; 00:0f74 $3e $84
    call playerSpritesLoadPlayerSpriteTiles_trampoline ;; 00:0f76 $cd $32 $02
    ld   D, ROOM_SCROLL_SPEED                          ;; 00:0f79 $16 $04
    ld   A, DIRECTIONF_SOUTH                           ;; 00:0f7b $3e $08
    call scrollRoom_trampoline                         ;; 00:0f7d $cd $9e $04
    pop  HL                                            ;; 00:0f80 $e1
    cp   A, $00                                        ;; 00:0f81 $fe $00
    ret  NZ                                            ;; 00:0f83 $c0
    call getNextScriptInstruction                      ;; 00:0f84 $cd $27 $37
    ret                                                ;; 00:0f87 $c9

scriptOpCodeOpenEastDoor:
    push HL                                            ;; 00:0f88 $e5
    ld   A, $01                                        ;; 00:0f89 $3e $01
    call openDoor                                      ;; 00:0f8b $cd $5b $23
    pop  HL                                            ;; 00:0f8e $e1
    call getNextScriptInstruction                      ;; 00:0f8f $cd $27 $37
    ret                                                ;; 00:0f92 $c9

scriptOpCodeCloseEastDoor:
    push HL                                            ;; 00:0f93 $e5
    ld   A, $01                                        ;; 00:0f94 $3e $01
    call closeDoor                                     ;; 00:0f96 $cd $fe $22
    pop  HL                                            ;; 00:0f99 $e1
    call getNextScriptInstruction                      ;; 00:0f9a $cd $27 $37
    ret                                                ;; 00:0f9d $c9

scriptOpCodeOpenWestDoor:
    push HL                                            ;; 00:0f9e $e5
    ld   A, $02                                        ;; 00:0f9f $3e $02
    call openDoor                                      ;; 00:0fa1 $cd $5b $23
    pop  HL                                            ;; 00:0fa4 $e1
    call getNextScriptInstruction                      ;; 00:0fa5 $cd $27 $37
    ret                                                ;; 00:0fa8 $c9

scriptOpCodeCloseWestDoor:
    push HL                                            ;; 00:0fa9 $e5
    ld   A, $02                                        ;; 00:0faa $3e $02
    call closeDoor                                     ;; 00:0fac $cd $fe $22
    pop  HL                                            ;; 00:0faf $e1
    call getNextScriptInstruction                      ;; 00:0fb0 $cd $27 $37
    ret                                                ;; 00:0fb3 $c9

scriptOpCodeOpenNorthDoor:
    push HL                                            ;; 00:0fb4 $e5
    ld   A, $04                                        ;; 00:0fb5 $3e $04
    call openDoor                                      ;; 00:0fb7 $cd $5b $23
    pop  HL                                            ;; 00:0fba $e1
    call getNextScriptInstruction                      ;; 00:0fbb $cd $27 $37
    ret                                                ;; 00:0fbe $c9

scriptOpCodeCloseNorthDoor:
    push HL                                            ;; 00:0fbf $e5
    ld   A, $04                                        ;; 00:0fc0 $3e $04
    call closeDoor                                     ;; 00:0fc2 $cd $fe $22
    pop  HL                                            ;; 00:0fc5 $e1
    call getNextScriptInstruction                      ;; 00:0fc6 $cd $27 $37
    ret                                                ;; 00:0fc9 $c9

scriptOpCodeOpenSouthDoor:
    push HL                                            ;; 00:0fca $e5
    ld   A, $08                                        ;; 00:0fcb $3e $08
    call openDoor                                      ;; 00:0fcd $cd $5b $23
    pop  HL                                            ;; 00:0fd0 $e1
    call getNextScriptInstruction                      ;; 00:0fd1 $cd $27 $37
    ret                                                ;; 00:0fd4 $c9

scriptOpCodeCloseSouthDoor:
    push HL                                            ;; 00:0fd5 $e5
    ld   A, $08                                        ;; 00:0fd6 $3e $08
    call closeDoor                                     ;; 00:0fd8 $cd $fe $22
    pop  HL                                            ;; 00:0fdb $e1
    call getNextScriptInstruction                      ;; 00:0fdc $cd $27 $37
    ret                                                ;; 00:0fdf $c9

; Flashes the screen once quickly.
scriptOpCodeFlashScreen:
    ld   A, [wScriptOpCounter]                         ;; 00:0fe0 $fa $99 $d4
    inc a
    ld [wScriptOpCounter], a
    cp   A, $05                                        ;; 00:0fe3 $fe $05
    jr   C, .dark                                      ;; 00:0fe5 $38 $20
IF DEF(COLOR)
    ; Use the normal palettes.
    push hl
; Check whether the Blind/Dark effect is active.
    ld hl, wPlayerSpecialFlags
    bit 1, [hl]
    ld hl, wColorPalettes.main
    jr z, .activate
    ld hl, wColorPalettes.blind
.activate:
    call setPalettes
    pop hl
ELSE
    ld   A, $e4                                        ;; 00:0fe7 $3e $e4
    ld   [wVideoBGP], A                                ;; 00:0fe9 $ea $aa $c0
    ld   A, $d0                                        ;; 00:0fec $3e $d0
    ld   [wVideoOBP0], A                               ;; 00:0fee $ea $ab $c0
    ld   [wVideoOBP1], A                               ;; 00:0ff1 $ea $ac $c0
ENDC
    ld   A, [wScriptOpCounter]                         ;; 00:0ff4 $fa $99 $d4
    cp   A, $0a                                        ;; 00:0ffb $fe $0a
    ret  C                                             ;; 00:0ffd $d8
    xor a
    ld   [wScriptOpCounter], A                         ;; 00:1000 $ea $99 $d4
    call getNextScriptInstruction                      ;; 00:1003 $cd $27 $37
    ret                                                ;; 00:1006 $c9
.dark:
IF DEF(COLOR)
    ; Use the flash palettes.
    push hl
    ld hl, wColorPalettes.flash
    call setPalettes
    pop hl
ELSE
    ld   A, $3f                                        ;; 00:1007 $3e $3f
    ld   [wVideoBGP], A                                ;; 00:1009 $ea $aa $c0
    ld   [wVideoOBP0], A                               ;; 00:100c $ea $ab $c0
    ld   [wVideoOBP1], A                               ;; 00:100f $ea $ac $c0
ENDC
    ret                                                ;; 00:1019 $c9

; One trampoline shared by the three fade commands.
; They are differentiated by their opcode in the call.
; This saves space in bank 0 at a slight expense in speed.
enhancedFade_trampoline:
    jp_to_bank 11, enhancedFade

fadeToBlackBGP:
    db   $e4, $e5, $e5, $e5, $e5, $f5, $f5, $f5        ;; 00:101a ........
    db   $f5, $f9, $f9, $f9, $f9, $fa, $fa, $fa        ;; 00:1022 ........
    db   $fa, $fe, $fe, $fe, $fe, $ff                  ;; 00:102a ......

fadeToBlackOBP:
    db   $d3, $d7, $d7, $d7, $d7, $d7, $d7, $e7        ;; 00:1030 ........
    db   $e7, $e7, $e7, $eb, $eb, $eb, $eb, $fb        ;; 00:1038 ........
    db   $fb, $fb, $fb, $fb, $fb, $ff                  ;; 00:1040 ......

; Fades the screen to black.
; When a SGB palette is loaded this uses a SGB enhanced fade using SNES palettes.
scriptOpCodeFadeToBlack:
    call enhancedFade_trampoline
    jr nz, .finish
    push HL                                            ;; 00:1046 $e5
    ld hl, wScriptOpCounter
    ld a, [hl+]
    add  A, A                                          ;; 00:104a $87
    ld   E, A                                          ;; 00:104b $5f
    ld a, [hl] ; wScriptOpCounter2
    and  A, $01                                        ;; 00:104f $e6 $01
    add  A, E                                          ;; 00:1051 $83
    ld   E, A                                          ;; 00:1052 $5f
    ld   D, $00                                        ;; 00:1053 $16 $00
    ld   HL, fadeToBlackBGP                            ;; 00:1055 $21 $1a $10
    add  HL, DE                                        ;; 00:1058 $19
    ld   A, [wLCDCEffectBuffer]                        ;; 00:105a $fa $a0 $d3
    cp   A, $7e                                        ;; 00:105d $fe $7e
    ld a, [hl]
    jr z, .fullscreen
; This is important for the letterbox effect during the ending. Possibly other places.
    ld   [wLCDCEffectBuffer._03], A                    ;; 00:1062 $ea $a3 $d3
    jr .sprites
.fullscreen:
    ld   [wVideoBGP], A                                ;; 00:1068 $ea $aa $c0
.sprites:
    ld   HL, fadeToBlackOBP                            ;; 00:106b $21 $30 $10
    add  HL, DE                                        ;; 00:106e $19
    ld   A, [HL]                                       ;; 00:106f $7e
    ld hl, wVideoOBP0
    ld [hl+], a
    ld [hl], a
    pop  HL                                            ;; 00:1076 $e1
.finish:
    jp fadeEffectAdjustCounters
;    call fadeEffectAdjustCounters                      ;; 00:1077 $cd $42 $11
;    ret                                                ;; 00:107a $c9

fadeToWhiteBGP:
    db   $e4, $a4, $a4, $a4, $a4, $a0, $a0, $a0        ;; 00:107b ????????
    db   $a0, $90, $90, $90, $90, $50, $50, $50        ;; 00:1083 ????????
    db   $50, $40, $40, $40, $40, $00                  ;; 00:108b ??????

fadeToWhiteOBP:
    db   $d0, $90, $90, $90, $90, $90, $50, $50        ;; 00:1091 ????????
    db   $50, $50, $50, $40, $50, $40, $40, $40        ;; 00:1099 ????????
    db   $40, $40, $40, $00, $40, $00                  ;; 00:10a1 ??????

; Fades the screen to white.
scriptOpCodeFadeToWhite:
    call enhancedFade_trampoline
    jr nz, .finished
    push HL                                            ;; 00:10a7 $e5
    ld hl, wScriptOpCounter
    ld a, [hl+]
    add  A, A                                          ;; 00:10ab $87
    ld   E, A                                          ;; 00:10ac $5f
    ld a, [hl] ; wScriptOpCounter2
    and  A, $01                                        ;; 00:10b0 $e6 $01
    add  A, E                                          ;; 00:10b2 $83
    ld   E, A                                          ;; 00:10b3 $5f
    ld   D, $00                                        ;; 00:10b4 $16 $00
    ld   HL, fadeToWhiteBGP                            ;; 00:10b6 $21 $7b $10
    add  HL, DE                                        ;; 00:10b9 $19
    ld   A, [wLCDCEffectBuffer]                        ;; 00:10bb $fa $a0 $d3
    cp   A, $7e                                        ;; 00:10be $fe $7e
    ld a, [hl]
    jr z, .fullscreen
; This is important for the letterbox effect during the ending. Possibly other places.
; For fade-to-white it is dead code.
    ld   [wLCDCEffectBuffer._03], A                    ;; 00:10c3 $ea $a3 $d3
    jr .sprites
.fullscreen:
    ld   [wVideoBGP], A                                ;; 00:10c9 $ea $aa $c0
.sprites:
    ld   HL, fadeToWhiteOBP                            ;; 00:10cc $21 $91 $10
    add  HL, DE                                        ;; 00:10cf $19
    ld   A, [HL]                                       ;; 00:10d0 $7e
    ld hl, wVideoOBP0
    ld [hl+], a
    ld [hl], a
    pop  HL                                            ;; 00:10d7 $e1
.finished:
    call fadeEffectAdjustCounters                      ;; 00:10d8 $cd $42 $11
    ret                                                ;; 00:10db $c9

; Fades in from either black or white.
; When a SGB palette is loaded this uses a SGB enhanced fade using SNES palettes.
scriptOpCodeFadeToNormal:
    call enhancedFade_trampoline
    jr nz, .finished
    push HL                                            ;; 00:10dc $e5
    ld hl, wScriptOpCounter
    ld a, [hl+]
    add  A, A                                          ;; 00:10e0 $87
    ld   E, A                                          ;; 00:10e1 $5f
    ld a, [hl] ; wScriptOpCounter2
    and  A, $01                                        ;; 00:10e5 $e6 $01
    add  A, E                                          ;; 00:10e7 $83
    ld   E, A                                          ;; 00:10e8 $5f
    ld   A, $15                                        ;; 00:10e9 $3e $15
    sub  A, E                                          ;; 00:10eb $93
    ld   E, A                                          ;; 00:10ec $5f
    ld   D, $00                                        ;; 00:10ed $16 $00
    ld   A, [wVideoOBP0]                               ;; 00:10ef $fa $ab $c0
    bit  0, A                                          ;; 00:10f2 $cb $47
    jr   Z, .fade_from_white                           ;; 00:10f4 $28 $26
    ld   HL, fadeToBlackBGP                            ;; 00:10f6 $21 $1a $10
    add  HL, DE                                        ;; 00:10f9 $19
    ld   A, [wLCDCEffectBuffer]                        ;; 00:10fb $fa $a0 $d3
    cp   A, $7e                                        ;; 00:10fe $fe $7e
    ld a, [hl]
    jr z, .fullscreen_black
; This is important for the letterbox effect during the ending. Possibly other places.
    ld   [wLCDCEffectBuffer._03], A                    ;; 00:1103 $ea $a3 $d3
    jr .sprites_black
.fullscreen_black:
    ld   [wVideoBGP], A                                ;; 00:1109 $ea $aa $c0
.sprites_black:
    ld   HL, fadeToBlackOBP                            ;; 00:110c $21 $30 $10
    add  HL, DE                                        ;; 00:110f $19
    ld   A, [HL]                                       ;; 00:1110 $7e
    ld hl, wVideoOBP0
    ld [hl+], a
    ld [hl], a
    pop  HL                                            ;; 00:1117 $e1
    call fadeEffectAdjustCounters                      ;; 00:1118 $cd $42 $11
    ret                                                ;; 00:111b $c9
.fade_from_white:
    ld   HL, fadeToWhiteBGP                            ;; 00:111c $21 $7b $10
    add  HL, DE                                        ;; 00:111f $19
    ld   A, [wLCDCEffectBuffer]                        ;; 00:1121 $fa $a0 $d3
    cp   A, $7e                                        ;; 00:1124 $fe $7e
    ld a, [hl]
    jr z, .fullscreen_white
; This is important for the letterbox effect during the ending. Possibly other places.
; For fade-from-white it is dead code.
    ld   [wLCDCEffectBuffer._03], A                    ;; 00:1129 $ea $a3 $d3
    jr .sprites_white
.fullscreen_white:
    ld   [wVideoBGP], A                                ;; 00:112f $ea $aa $c0
.sprites_white:
    ld   HL, fadeToWhiteOBP                            ;; 00:1132 $21 $91 $10
    add  HL, DE                                        ;; 00:1135 $19
    ld   A, [HL]                                       ;; 00:1136 $7e
    ld hl, wVideoOBP0
    ld [hl+], a
    ld [hl], a
    pop  HL                                            ;; 00:113d $e1
.finished:
    call fadeEffectAdjustCounters                      ;; 00:113e $cd $42 $11
    ret                                                ;; 00:1141 $c9

; wScriptOpCounter2 counts from zero to five.
; wScriptOpCounter counts from zero to 10, incrementing every time the first counter rolls back to zero.
fadeEffectAdjustCounters:
    ld   A, [wScriptOpCounter2]                        ;; 00:1142 $fa $9a $d4
    inc  A                                             ;; 00:1145 $3c
    ld   [wScriptOpCounter2], A                        ;; 00:1146 $ea $9a $d4
    cp   A, $06                                        ;; 00:1149 $fe $06
    ret  C                                             ;; 00:114b $d8
    ld   A, $00                                        ;; 00:114c $3e $00
    ld   [wScriptOpCounter2], A                        ;; 00:114e $ea $9a $d4
    ld   A, [wScriptOpCounter]                         ;; 00:1151 $fa $99 $d4
    inc  A                                             ;; 00:1154 $3c
    ld   [wScriptOpCounter], A                         ;; 00:1155 $ea $99 $d4
    cp   A, $0b                                        ;; 00:1158 $fe $0b
    ret  C                                             ;; 00:115a $d8
    ld   A, $00                                        ;; 00:115b $3e $00
    ld   [wScriptOpCounter], A                         ;; 00:115d $ea $99 $d4
; Store the current fade type.
    dec hl
    ld a, [hl+]
    sub $bc ; scriptOpCodeFadeToNormal
    ld [wLastFade], a
    call getNextScriptInstruction                      ;; 00:1160 $cd $27 $37
    ret                                                ;; 00:1163 $c9

conditionallyClearDarkGraphicEffect:
    ld   HL, wScriptDarknessEffect                     ;; 00:1164 $21 $f1 $c3
    bit  0, [HL]                                       ;; 00:1167 $cb $46
    ret  Z                                             ;; 00:1169 $c8
    call removeDarkGraphicEffect                       ;; 00:116a $cd $04 $02
    ret                                                ;; 00:116d $c9

conditionallySetDarkGraphicEffect:
    ld   HL, wScriptDarknessEffect                     ;; 00:116e $21 $f1 $c3
    bit  0, [HL]                                       ;; 00:1171 $cb $46
    ret  Z                                             ;; 00:1173 $c8
    call setDarkGraphicEffect                          ;; 00:1174 $cd $f4 $01
    ret                                                ;; 00:1177 $c9

scriptOpCodeSetDarkGraphicEffect:
    push HL                                            ;; 00:1178 $e5
    ld   HL, wScriptDarknessEffect                     ;; 00:1179 $21 $f1 $c3
    set  0, [HL]                                       ;; 00:117c $cb $c6
    call setDarkGraphicEffect                          ;; 00:117e $cd $f4 $01
    pop  HL                                            ;; 00:1181 $e1
    call getNextScriptInstruction                      ;; 00:1182 $cd $27 $37
    ret                                                ;; 00:1185 $c9

scriptOpCodeClearDarkGraphicEffect:
    push HL                                            ;; 00:1186 $e5
    ld   HL, wScriptDarknessEffect                     ;; 00:1187 $21 $f1 $c3
    res  0, [HL]                                       ;; 00:118a $cb $86
    call removeDarkGraphicEffect                       ;; 00:118c $cd $04 $02
    pop  HL                                            ;; 00:118f $e1
    call getNextScriptInstruction                      ;; 00:1190 $cd $27 $37
    ret                                                ;; 00:1193 $c9

scriptOpCodeSFX:
    ld   A, [HL+]                                      ;; 00:1194 $2a
    ldh  [hSFX], A                                     ;; 00:1195 $e0 $92
    call getNextScriptInstruction                      ;; 00:1197 $cd $27 $37
    ret                                                ;; 00:119a $c9

scriptOpCodeSetMusic:
    ld   A, [HL+]                                      ;; 00:119b $2a
    ldh  [hCurrentMusic], A                            ;; 00:119c $e0 $90
    ld   [wMusic], A                                   ;; 00:119e $ea $9b $d4
    ld   [wCurrentMusicStatusEffectBackup], A          ;; 00:11a1 $ea $a3 $d4
    call getNextScriptInstruction                      ;; 00:11a4 $cd $27 $37
    ret                                                ;; 00:11a7 $c9

setTemporaryMusic:
    ldh  [hCurrentMusic], A                            ;; 00:11a8 $e0 $90
    ld   A, [wMusic]                                   ;; 00:11aa $fa $9b $d4
    ld   [wCurrentMusicStatusEffectBackup], A          ;; 00:11ad $ea $a3 $d4
    ret                                                ;; 00:11b0 $c9

clearTemporaryMusic:
    ld   A, [wCurrentMusicStatusEffectBackup]          ;; 00:11b1 $fa $a3 $d4
    ldh  [hCurrentMusic], A                            ;; 00:11b4 $e0 $90
    ret                                                ;; 00:11b6 $c9

scriptOpCodeLoadRoom:
    ld   A, [HL+]                                      ;; 00:11b7 $2a
    ld   B, A                                          ;; 00:11b8 $47
    ld   A, [HL-]                                      ;; 00:11b9 $3a
    ld   C, A                                          ;; 00:11ba $4f
    call loadMapWithShutterEffectSequence_trampoline   ;; 00:11bb $cd $c8 $11
    ld   A, [wScriptOpCounter]                         ;; 00:11be $fa $99 $d4
    cp   A, $00                                        ;; 00:11c1 $fe $00
    ret  NZ                                            ;; 00:11c3 $c0
    call getNextScriptInstruction                      ;; 00:11c4 $cd $27 $37
    ret                                                ;; 00:11c7 $c9

loadMapWithShutterEffectSequence_trampoline:
    jp_to_bank 01, loadMapWithShutterEffectSequence    ;; 00:11c8 $f5 $3e $0f $c3 $d7 $1e

scriptOpCodeLoadRoomInstant:
    ld   A, [HL+]                                      ;; 00:11ce $2a
    ld   B, A                                          ;; 00:11cf $47
    ld   A, [HL-]                                      ;; 00:11d0 $3a
    ld   C, A                                          ;; 00:11d1 $4f
    call loadMapInstantSequence_trampoline             ;; 00:11d2 $cd $df $11
    ld   A, [wScriptOpCounter]                         ;; 00:11d5 $fa $99 $d4
    cp   A, $00                                        ;; 00:11d8 $fe $00
    ret  NZ                                            ;; 00:11da $c0
    call getNextScriptInstruction                      ;; 00:11db $cd $27 $37
    ret                                                ;; 00:11de $c9

loadMapInstantSequence_trampoline:
    jp_to_bank 01, loadMapInstantSequence              ;; 00:11df $f5 $3e $10 $c3 $d7 $1e

scriptOpCodeOpenMap:
    call openMinimap_trampoline                        ;; 00:11e5 $cd $f2 $11
    ld   A, [wScriptOpCounter]                         ;; 00:11e8 $fa $99 $d4
    cp   A, $00                                        ;; 00:11eb $fe $00
    ret  NZ                                            ;; 00:11ed $c0
    call getNextScriptInstruction                      ;; 00:11ee $cd $27 $37
    ret                                                ;; 00:11f1 $c9

openMinimap_trampoline:
    jp_to_bank 01, openMinimap                         ;; 00:11f2 $f5 $3e $11 $c3 $d7 $1e

scriptOpCodeCloseMap:
    call closeMinimap_trampoline                       ;; 00:11f8 $cd $05 $12
    ld   A, [wScriptOpCounter]                         ;; 00:11fb $fa $99 $d4
    cp   A, $00                                        ;; 00:11fe $fe $00
    ret  NZ                                            ;; 00:1200 $c0
    call getNextScriptInstruction                      ;; 00:1201 $cd $27 $37
    ret                                                ;; 00:1204 $c9

closeMinimap_trampoline:
    jp_to_bank 01, closeMinimap                        ;; 00:1205 $f5 $3e $12 $c3 $d7 $1e

scriptPlayerSetPosition:
    ld   A, [HL+]                                      ;; 00:120b $2a
    add  A, A                                          ;; 00:120c $87
    add  A, A                                          ;; 00:120d $87
    add  A, A                                          ;; 00:120e $87
    add  A, $08                                        ;; 00:120f $c6 $08
    ld   E, A                                          ;; 00:1211 $5f
    ld   A, [HL+]                                      ;; 00:1212 $2a
    push HL                                            ;; 00:1213 $e5
    add  A, A                                          ;; 00:1214 $87
    add  A, A                                          ;; 00:1215 $87
    add  A, A                                          ;; 00:1216 $87
    add  A, $10                                        ;; 00:1217 $c6 $10
    ld   D, A                                          ;; 00:1219 $57
    ld   A, [wMainGameStateFlags]                      ;; 00:121a $fa $a1 $c0
    push AF                                            ;; 00:121d $f5
    set  3, A                                          ;; 00:121e $cb $df
    ld   [wMainGameStateFlags], A                      ;; 00:1220 $ea $a1 $c0
    push DE                                            ;; 00:1223 $d5
    call getPlayerDirection                            ;; 00:1224 $cd $ab $02
    ld   B, $00                                        ;; 00:1227 $06 $00
    and  A, $0f                                        ;; 00:1229 $e6 $0f
    push AF                                            ;; 00:122b $f5
    call playerSpritesLoadPlayerSpriteTiles_trampoline ;; 00:122c $cd $32 $02
    pop  AF                                            ;; 00:122f $f1
    pop  DE                                            ;; 00:1230 $d1
    ld   B, $00                                        ;; 00:1231 $06 $00
    or   A, $10                                        ;; 00:1233 $f6 $10
    call updatePlayerPostion_trampoline                ;; 00:1235 $cd $3e $02
    pop  AF                                            ;; 00:1238 $f1
    ld   [wMainGameStateFlags], A                      ;; 00:1239 $ea $a1 $c0
    pop  HL                                            ;; 00:123c $e1
    ret                                                ;; 00:123d $c9

; C = npc number (object number - 7)
scriptNpcSetPosition:
    push HL                                            ;; 00:123e $e5
    push BC                                            ;; 00:123f $c5
    call checkForMovingObjects                         ;; 00:1240 $cd $9b $28
    pop  BC                                            ;; 00:1243 $c1
    pop  HL                                            ;; 00:1244 $e1
    ret  NZ                                            ;; 00:1245 $c0
    ld   A, [HL+]                                      ;; 00:1246 $2a
    inc  A                                             ;; 00:1247 $3c
    add  A, A                                          ;; 00:1248 $87
    add  A, A                                          ;; 00:1249 $87
    add  A, A                                          ;; 00:124a $87
    ld   E, A                                          ;; 00:124b $5f
    ld   A, [HL+]                                      ;; 00:124c $2a
    push HL                                            ;; 00:124d $e5
    inc  A                                             ;; 00:124e $3c
    inc  A                                             ;; 00:124f $3c
    add  A, A                                          ;; 00:1250 $87
    add  A, A                                          ;; 00:1251 $87
    add  A, A                                          ;; 00:1252 $87
    ld   D, A                                          ;; 00:1253 $57
    call updateNpcPosition_trampoline                  ;; 00:1254 $cd $aa $28
    pop  HL                                            ;; 00:1257 $e1
    call getNextScriptInstruction                      ;; 00:1258 $cd $27 $37
    ret                                                ;; 00:125b $c9

scriptOpCodeNpc1StepForward:
    call checkForFollower                              ;; 00:125c $cd $c2 $28
    add  A, $00                                        ;; 00:125f $c6 $00
    ld   C, A                                          ;; 00:1261 $4f
    ld   A, $04                                        ;; 00:1262 $3e $04
    call scriptObjectBehaviorMove                      ;; 00:1264 $cd $79 $28
    ret                                                ;; 00:1267 $c9

scriptOpCodeNpc1StepBackwards:
    call checkForFollower                              ;; 00:1268 $cd $c2 $28
    add  A, $00                                        ;; 00:126b $c6 $00
    ld   C, A                                          ;; 00:126d $4f
    ld   A, $05                                        ;; 00:126e $3e $05
    call scriptObjectBehaviorMove                      ;; 00:1270 $cd $79 $28
    ret                                                ;; 00:1273 $c9

scriptOpCodeNpc1DirectionRight:
    call checkForFollower                              ;; 00:1274 $cd $c2 $28
    add  A, $00                                        ;; 00:1277 $c6 $00
    ld   C, A                                          ;; 00:1279 $4f
    ld   A, $1c                                        ;; 00:127a $3e $1c
    call scriptObjectBehaviorMove                      ;; 00:127c $cd $79 $28
    ret                                                ;; 00:127f $c9

scriptOpCodeNpc1DirectionLeft:
    call checkForFollower                              ;; 00:1280 $cd $c2 $28
    add  A, $00                                        ;; 00:1283 $c6 $00
    ld   C, A                                          ;; 00:1285 $4f
    ld   A, $1d                                        ;; 00:1286 $3e $1d
    call scriptObjectBehaviorMove                      ;; 00:1288 $cd $79 $28
    ret                                                ;; 00:128b $c9

scriptOpCodeNpc1DirectionUp:
    call checkForFollower                              ;; 00:128c $cd $c2 $28
    add  A, $00                                        ;; 00:128f $c6 $00
    ld   C, A                                          ;; 00:1291 $4f
    ld   A, $1e                                        ;; 00:1292 $3e $1e
    call scriptObjectBehaviorMove                      ;; 00:1294 $cd $79 $28
    ret                                                ;; 00:1297 $c9

scriptOpCodeNpc1DirectionDown:
    call checkForFollower                              ;; 00:1298 $cd $c2 $28
    add  A, $00                                        ;; 00:129b $c6 $00
    ld   C, A                                          ;; 00:129d $4f
    ld   A, $1f                                        ;; 00:129e $3e $1f
    call scriptObjectBehaviorMove                      ;; 00:12a0 $cd $79 $28
    ret                                                ;; 00:12a3 $c9

scriptOpCodeNpc1Delete:
    call checkForFollower                              ;; 00:12a4 $cd $c2 $28
    add  A, $00                                        ;; 00:12a7 $c6 $00
    ld   C, A                                          ;; 00:12a9 $4f
    call scriptNpcDelete                               ;; 00:12aa $cd $59 $28
    ret                                                ;; 00:12ad $c9

scriptOpCodeNpc1SetPosition:
    call checkForFollower                              ;; 00:12ae $cd $c2 $28
    add  A, $00                                        ;; 00:12b1 $c6 $00
    ld   C, A                                          ;; 00:12b3 $4f
    call scriptNpcSetPosition                          ;; 00:12b4 $cd $3e $12
    ret                                                ;; 00:12b7 $c9

scriptOpCodeNpc1WalkSpeed4:
    call checkForFollower                              ;; 00:12b8 $cd $c2 $28
    add  A, $00                                        ;; 00:12bb $c6 $00
    ld   C, A                                          ;; 00:12bd $4f
    ld   A, $0e                                        ;; 00:12be $3e $0e
    call scriptObjectBehaviorMove                      ;; 00:12c0 $cd $79 $28
    ret                                                ;; 00:12c3 $c9

scriptOpCodeNpc1WalkSpeedDefault:
    call checkForFollower                              ;; 00:12c4 $cd $c2 $28
    add  A, $00                                        ;; 00:12c7 $c6 $00
    ld   C, A                                          ;; 00:12c9 $4f
    ld   A, $0f                                        ;; 00:12ca $3e $0f
    call scriptObjectBehaviorMove                      ;; 00:12cc $cd $79 $28
    ret                                                ;; 00:12cf $c9

scriptOpCodeNpc2StepForward:
    call checkForFollower                              ;; 00:12d0 $cd $c2 $28
    add  A, $01                                        ;; 00:12d3 $c6 $01
    ld   C, A                                          ;; 00:12d5 $4f
    ld   A, $04                                        ;; 00:12d6 $3e $04
    call scriptObjectBehaviorMove                      ;; 00:12d8 $cd $79 $28
    ret                                                ;; 00:12db $c9

scriptOpCodeNpc2StepBackwards:
    call checkForFollower                              ;; 00:12dc $cd $c2 $28
    add  A, $01                                        ;; 00:12df $c6 $01
    ld   C, A                                          ;; 00:12e1 $4f
    ld   A, $05                                        ;; 00:12e2 $3e $05
    call scriptObjectBehaviorMove                      ;; 00:12e4 $cd $79 $28
    ret                                                ;; 00:12e7 $c9

scriptOpCodeNpc2DirectionRight:
    call checkForFollower                              ;; 00:12e8 $cd $c2 $28
    add  A, $01                                        ;; 00:12eb $c6 $01
    ld   C, A                                          ;; 00:12ed $4f
    ld   A, $1c                                        ;; 00:12ee $3e $1c
    call scriptObjectBehaviorMove                      ;; 00:12f0 $cd $79 $28
    ret                                                ;; 00:12f3 $c9

scriptOpCodeNpc2DirectionLeft:
    call checkForFollower                              ;; 00:12f4 $cd $c2 $28
    add  A, $01                                        ;; 00:12f7 $c6 $01
    ld   C, A                                          ;; 00:12f9 $4f
    ld   A, $1d                                        ;; 00:12fa $3e $1d
    call scriptObjectBehaviorMove                      ;; 00:12fc $cd $79 $28
    ret                                                ;; 00:12ff $c9

scriptOpCodeNpc2DirectionUp:
    call checkForFollower                              ;; 00:1300 $cd $c2 $28
    add  A, $01                                        ;; 00:1303 $c6 $01
    ld   C, A                                          ;; 00:1305 $4f
    ld   A, $1e                                        ;; 00:1306 $3e $1e
    call scriptObjectBehaviorMove                      ;; 00:1308 $cd $79 $28
    ret                                                ;; 00:130b $c9

scriptOpCodeNpc2DirectionDown:
    call checkForFollower                              ;; 00:130c $cd $c2 $28
    add  A, $01                                        ;; 00:130f $c6 $01
    ld   C, A                                          ;; 00:1311 $4f
    ld   A, $1f                                        ;; 00:1312 $3e $1f
    call scriptObjectBehaviorMove                      ;; 00:1314 $cd $79 $28
    ret                                                ;; 00:1317 $c9

scriptOpCodeNpc2Delete:
    call checkForFollower                              ;; 00:1318 $cd $c2 $28
    add  A, $01                                        ;; 00:131b $c6 $01
    ld   C, A                                          ;; 00:131d $4f
    call scriptNpcDelete                               ;; 00:131e $cd $59 $28
    ret                                                ;; 00:1321 $c9

scriptOpCodeNpc2SetPosition:
    call checkForFollower                              ;; 00:1322 $cd $c2 $28
    add  A, $01                                        ;; 00:1325 $c6 $01
    ld   C, A                                          ;; 00:1327 $4f
    call scriptNpcSetPosition                          ;; 00:1328 $cd $3e $12
    ret                                                ;; 00:132b $c9

scriptOpCodeNpc2WalkSpeed4:
    call checkForFollower                              ;; 00:132c $cd $c2 $28
    add  A, $01                                        ;; 00:132f $c6 $01
    ld   C, A                                          ;; 00:1331 $4f
    ld   A, $0e                                        ;; 00:1332 $3e $0e
    call scriptObjectBehaviorMove                      ;; 00:1334 $cd $79 $28
    ret                                                ;; 00:1337 $c9

scriptOpCodeNpc2WalkSpeedDefault:
    call checkForFollower                              ;; 00:1338 $cd $c2 $28
    add  A, $01                                        ;; 00:133b $c6 $01
    ld   C, A                                          ;; 00:133d $4f
    ld   A, $0f                                        ;; 00:133e $3e $0f
    call scriptObjectBehaviorMove                      ;; 00:1340 $cd $79 $28
    ret                                                ;; 00:1343 $c9

scriptOpCodeNpc3StepForward:
    call checkForFollower                              ;; 00:1344 $cd $c2 $28
    add  A, $02                                        ;; 00:1347 $c6 $02
    ld   C, A                                          ;; 00:1349 $4f
    ld   A, $04                                        ;; 00:134a $3e $04
    call scriptObjectBehaviorMove                      ;; 00:134c $cd $79 $28
    ret                                                ;; 00:134f $c9

scriptOpCodeNpc3StepBackwards:
    call checkForFollower                              ;; 00:1350 $cd $c2 $28
    add  A, $02                                        ;; 00:1353 $c6 $02
    ld   C, A                                          ;; 00:1355 $4f
    ld   A, $05                                        ;; 00:1356 $3e $05
    call scriptObjectBehaviorMove                      ;; 00:1358 $cd $79 $28
    ret                                                ;; 00:135b $c9

scriptOpCodeNpc3DirectionRight:
    call checkForFollower                              ;; 00:135c $cd $c2 $28
    add  A, $02                                        ;; 00:135f $c6 $02
    ld   C, A                                          ;; 00:1361 $4f
    ld   A, $1c                                        ;; 00:1362 $3e $1c
    call scriptObjectBehaviorMove                      ;; 00:1364 $cd $79 $28
    ret                                                ;; 00:1367 $c9

scriptOpCodeNpc3DirectionLeft:
    call checkForFollower                              ;; 00:1368 $cd $c2 $28
    add  A, $02                                        ;; 00:136b $c6 $02
    ld   C, A                                          ;; 00:136d $4f
    ld   A, $1d                                        ;; 00:136e $3e $1d
    call scriptObjectBehaviorMove                      ;; 00:1370 $cd $79 $28
    ret                                                ;; 00:1373 $c9

scriptOpCodeNpc3DirectionUp:
    call checkForFollower                              ;; 00:1374 $cd $c2 $28
    add  A, $02                                        ;; 00:1377 $c6 $02
    ld   C, A                                          ;; 00:1379 $4f
    ld   A, $1e                                        ;; 00:137a $3e $1e
    call scriptObjectBehaviorMove                      ;; 00:137c $cd $79 $28
    ret                                                ;; 00:137f $c9

scriptOpCodeNpc3DirectionDown:
    call checkForFollower                              ;; 00:1380 $cd $c2 $28
    add  A, $02                                        ;; 00:1383 $c6 $02
    ld   C, A                                          ;; 00:1385 $4f
    ld   A, $1f                                        ;; 00:1386 $3e $1f
    call scriptObjectBehaviorMove                      ;; 00:1388 $cd $79 $28
    ret                                                ;; 00:138b $c9

scriptOpCodeNpc3Delete:
    call checkForFollower                              ;; 00:138c $cd $c2 $28
    add  A, $02                                        ;; 00:138f $c6 $02
    ld   C, A                                          ;; 00:1391 $4f
    call scriptNpcDelete                               ;; 00:1392 $cd $59 $28
    ret                                                ;; 00:1395 $c9

scriptOpCodeNpc3SetPosition:
    call checkForFollower                              ;; 00:1396 $cd $c2 $28
    add  A, $02                                        ;; 00:1399 $c6 $02
    ld   C, A                                          ;; 00:139b $4f
    call scriptNpcSetPosition                          ;; 00:139c $cd $3e $12
    ret                                                ;; 00:139f $c9

scriptOpCodeNpc3WalkSpeed4:
    call checkForFollower                              ;; 00:13a0 $cd $c2 $28
    add  A, $02                                        ;; 00:13a3 $c6 $02
    ld   C, A                                          ;; 00:13a5 $4f
    ld   A, $0e                                        ;; 00:13a6 $3e $0e
    call scriptObjectBehaviorMove                      ;; 00:13a8 $cd $79 $28
    ret                                                ;; 00:13ab $c9

scriptOpCodeNpc3WalkSpeedDefault:
    call checkForFollower                              ;; 00:13ac $cd $c2 $28
    add  A, $02                                        ;; 00:13af $c6 $02
    ld   C, A                                          ;; 00:13b1 $4f
    ld   A, $0f                                        ;; 00:13b2 $3e $0f
    call scriptObjectBehaviorMove                      ;; 00:13b4 $cd $79 $28
    ret                                                ;; 00:13b7 $c9

scriptOpCodeNpc4StepForward:
    call checkForFollower                              ;; 00:13b8 $cd $c2 $28
    add  A, $03                                        ;; 00:13bb $c6 $03
    ld   C, A                                          ;; 00:13bd $4f
    ld   A, $04                                        ;; 00:13be $3e $04
    call scriptObjectBehaviorMove                      ;; 00:13c0 $cd $79 $28
    ret                                                ;; 00:13c3 $c9

scriptOpCodeNpc4StepBackwards:
    call checkForFollower                              ;; 00:13c4 $cd $c2 $28
    add  A, $03                                        ;; 00:13c7 $c6 $03
    ld   C, A                                          ;; 00:13c9 $4f
    ld   A, $05                                        ;; 00:13ca $3e $05
    call scriptObjectBehaviorMove                      ;; 00:13cc $cd $79 $28
    ret                                                ;; 00:13cf $c9

scriptOpCodeNpc4DirectionRight:
    call checkForFollower                              ;; 00:13d0 $cd $c2 $28
    add  A, $03                                        ;; 00:13d3 $c6 $03
    ld   C, A                                          ;; 00:13d5 $4f
    ld   A, $1c                                        ;; 00:13d6 $3e $1c
    call scriptObjectBehaviorMove                      ;; 00:13d8 $cd $79 $28
    ret                                                ;; 00:13db $c9

scriptOpCodeNpc4DirectionLeft:
    call checkForFollower                              ;; 00:13dc $cd $c2 $28
    add  A, $03                                        ;; 00:13df $c6 $03
    ld   C, A                                          ;; 00:13e1 $4f
    ld   A, $1d                                        ;; 00:13e2 $3e $1d
    call scriptObjectBehaviorMove                      ;; 00:13e4 $cd $79 $28
    ret                                                ;; 00:13e7 $c9

scriptOpCodeNpc4DirectionUp:
    call checkForFollower                              ;; 00:13e8 $cd $c2 $28
    add  A, $03                                        ;; 00:13eb $c6 $03
    ld   C, A                                          ;; 00:13ed $4f
    ld   A, $1e                                        ;; 00:13ee $3e $1e
    call scriptObjectBehaviorMove                      ;; 00:13f0 $cd $79 $28
    ret                                                ;; 00:13f3 $c9

scriptOpCodeNpc4DirectionDown:
    call checkForFollower                              ;; 00:13f4 $cd $c2 $28
    add  A, $03                                        ;; 00:13f7 $c6 $03
    ld   C, A                                          ;; 00:13f9 $4f
    ld   A, $1f                                        ;; 00:13fa $3e $1f
    call scriptObjectBehaviorMove                      ;; 00:13fc $cd $79 $28
    ret                                                ;; 00:13ff $c9

scriptOpCodeNpc4Delete:
    call checkForFollower                              ;; 00:1400 $cd $c2 $28
    add  A, $03                                        ;; 00:1403 $c6 $03
    ld   C, A                                          ;; 00:1405 $4f
    call scriptNpcDelete                               ;; 00:1406 $cd $59 $28
    ret                                                ;; 00:1409 $c9

scriptOpCodeNpc4SetPosition:
    call checkForFollower                              ;; 00:140a $cd $c2 $28
    add  A, $03                                        ;; 00:140d $c6 $03
    ld   C, A                                          ;; 00:140f $4f
    call scriptNpcSetPosition                          ;; 00:1410 $cd $3e $12
    ret                                                ;; 00:1413 $c9

scriptOpCodeNpc4WalkSpeed4:
    call checkForFollower                              ;; 00:1414 $cd $c2 $28
    add  A, $03                                        ;; 00:1417 $c6 $03
    ld   C, A                                          ;; 00:1419 $4f
    ld   A, $0e                                        ;; 00:141a $3e $0e
    call scriptObjectBehaviorMove                      ;; 00:141c $cd $79 $28
    ret                                                ;; 00:141f $c9

scriptOpCodeNpc4WalkSpeedDefault:
    call checkForFollower                              ;; 00:1420 $cd $c2 $28
    add  A, $03                                        ;; 00:1423 $c6 $03
    ld   C, A                                          ;; 00:1425 $4f
    ld   A, $0f                                        ;; 00:1426 $3e $0f
    call scriptObjectBehaviorMove                      ;; 00:1428 $cd $79 $28
    ret                                                ;; 00:142b $c9

scriptOpCodeNpc5StepForward:
    call checkForFollower                              ;; 00:142c $cd $c2 $28
    add  A, $04                                        ;; 00:142f $c6 $04
    ld   C, A                                          ;; 00:1431 $4f
    ld   A, $04                                        ;; 00:1432 $3e $04
    call scriptObjectBehaviorMove                      ;; 00:1434 $cd $79 $28
    ret                                                ;; 00:1437 $c9

scriptOpCodeNpc5StepBackwards:
    call checkForFollower                              ;; 00:1438 $cd $c2 $28
    add  A, $04                                        ;; 00:143b $c6 $04
    ld   C, A                                          ;; 00:143d $4f
    ld   A, $05                                        ;; 00:143e $3e $05
    call scriptObjectBehaviorMove                      ;; 00:1440 $cd $79 $28
    ret                                                ;; 00:1443 $c9

scriptOpCodeNpc5DirectionRight:
    call checkForFollower                              ;; 00:1444 $cd $c2 $28
    add  A, $04                                        ;; 00:1447 $c6 $04
    ld   C, A                                          ;; 00:1449 $4f
    ld   A, $1c                                        ;; 00:144a $3e $1c
    call scriptObjectBehaviorMove                      ;; 00:144c $cd $79 $28
    ret                                                ;; 00:144f $c9

scriptOpCodeNpc5DirectionLeft:
    call checkForFollower                              ;; 00:1450 $cd $c2 $28
    add  A, $04                                        ;; 00:1453 $c6 $04
    ld   C, A                                          ;; 00:1455 $4f
    ld   A, $1d                                        ;; 00:1456 $3e $1d
    call scriptObjectBehaviorMove                      ;; 00:1458 $cd $79 $28
    ret                                                ;; 00:145b $c9

scriptOpCodeNpc5DirectionUp:
    call checkForFollower                              ;; 00:145c $cd $c2 $28
    add  A, $04                                        ;; 00:145f $c6 $04
    ld   C, A                                          ;; 00:1461 $4f
    ld   A, $1e                                        ;; 00:1462 $3e $1e
    call scriptObjectBehaviorMove                      ;; 00:1464 $cd $79 $28
    ret                                                ;; 00:1467 $c9

scriptOpCodeNpc5DirectionDown:
    call checkForFollower                              ;; 00:1468 $cd $c2 $28
    add  A, $04                                        ;; 00:146b $c6 $04
    ld   C, A                                          ;; 00:146d $4f
    ld   A, $1f                                        ;; 00:146e $3e $1f
    call scriptObjectBehaviorMove                      ;; 00:1470 $cd $79 $28
    ret                                                ;; 00:1473 $c9

scriptOpCodeNpc5Delete:
    call checkForFollower                              ;; 00:1474 $cd $c2 $28
    add  A, $04                                        ;; 00:1477 $c6 $04
    ld   C, A                                          ;; 00:1479 $4f
    call scriptNpcDelete                               ;; 00:147a $cd $59 $28
    ret                                                ;; 00:147d $c9

scriptOpCodeNpc5SetPosition:
    call checkForFollower                              ;; 00:147e $cd $c2 $28
    add  A, $04                                        ;; 00:1481 $c6 $04
    ld   C, A                                          ;; 00:1483 $4f
    call scriptNpcSetPosition                          ;; 00:1484 $cd $3e $12
    ret                                                ;; 00:1487 $c9

scriptOpCodeNpc5WalkSpeed4:
    call checkForFollower                              ;; 00:1488 $cd $c2 $28
    add  A, $04                                        ;; 00:148b $c6 $04
    ld   C, A                                          ;; 00:148d $4f
    ld   A, $0e                                        ;; 00:148e $3e $0e
    call scriptObjectBehaviorMove                      ;; 00:1490 $cd $79 $28
    ret                                                ;; 00:1493 $c9

scriptOpCodeNpc5WalkSpeedDefault:
    call checkForFollower                              ;; 00:1494 $cd $c2 $28
    add  A, $04                                        ;; 00:1497 $c6 $04
    ld   C, A                                          ;; 00:1499 $4f
    ld   A, $0f                                        ;; 00:149a $3e $0f
    call scriptObjectBehaviorMove                      ;; 00:149c $cd $79 $28
    ret                                                ;; 00:149f $c9

scriptOpCodeNpc6StepForward:
    call checkForFollower                              ;; 00:14a0 $cd $c2 $28
    add  A, $05                                        ;; 00:14a3 $c6 $05
    ld   C, A                                          ;; 00:14a5 $4f
    ld   A, $04                                        ;; 00:14a6 $3e $04
    call scriptObjectBehaviorMove                      ;; 00:14a8 $cd $79 $28
    ret                                                ;; 00:14ab $c9

scriptOpCodeNpc6StepBackwards:
    call checkForFollower                              ;; 00:14ac $cd $c2 $28
    add  A, $05                                        ;; 00:14af $c6 $05
    ld   C, A                                          ;; 00:14b1 $4f
    ld   A, $05                                        ;; 00:14b2 $3e $05
    call scriptObjectBehaviorMove                      ;; 00:14b4 $cd $79 $28
    ret                                                ;; 00:14b7 $c9

scriptOpCodeNpc6DirectionRight:
    call checkForFollower                              ;; 00:14b8 $cd $c2 $28
    add  A, $05                                        ;; 00:14bb $c6 $05
    ld   C, A                                          ;; 00:14bd $4f
    ld   A, $1c                                        ;; 00:14be $3e $1c
    call scriptObjectBehaviorMove                      ;; 00:14c0 $cd $79 $28
    ret                                                ;; 00:14c3 $c9

scriptOpCodeNpc6DirectionLeft:
    call checkForFollower                              ;; 00:14c4 $cd $c2 $28
    add  A, $05                                        ;; 00:14c7 $c6 $05
    ld   C, A                                          ;; 00:14c9 $4f
    ld   A, $1d                                        ;; 00:14ca $3e $1d
    call scriptObjectBehaviorMove                      ;; 00:14cc $cd $79 $28
    ret                                                ;; 00:14cf $c9

scriptOpCodeNpc6DirectionUp:
    call checkForFollower                              ;; 00:14d0 $cd $c2 $28
    add  A, $05                                        ;; 00:14d3 $c6 $05
    ld   C, A                                          ;; 00:14d5 $4f
    ld   A, $1e                                        ;; 00:14d6 $3e $1e
    call scriptObjectBehaviorMove                      ;; 00:14d8 $cd $79 $28
    ret                                                ;; 00:14db $c9

scriptOpCodeNpc6DirectionDown:
    call checkForFollower                              ;; 00:14dc $cd $c2 $28
    add  A, $05                                        ;; 00:14df $c6 $05
    ld   C, A                                          ;; 00:14e1 $4f
    ld   A, $1f                                        ;; 00:14e2 $3e $1f
    call scriptObjectBehaviorMove                      ;; 00:14e4 $cd $79 $28
    ret                                                ;; 00:14e7 $c9

scriptOpCodeNpc6Delete:
    call checkForFollower                              ;; 00:14e8 $cd $c2 $28
    add  A, $05                                        ;; 00:14eb $c6 $05
    ld   C, A                                          ;; 00:14ed $4f
    call scriptNpcDelete                               ;; 00:14ee $cd $59 $28
    ret                                                ;; 00:14f1 $c9

scriptOpCodeNpc6SetPosition:
    call checkForFollower                              ;; 00:14f2 $cd $c2 $28
    add  A, $05                                        ;; 00:14f5 $c6 $05
    ld   C, A                                          ;; 00:14f7 $4f
    call scriptNpcSetPosition                          ;; 00:14f8 $cd $3e $12
    ret                                                ;; 00:14fb $c9

scriptOpCodeNpc6WalkSpeed4:
    call checkForFollower                              ;; 00:14fc $cd $c2 $28
    add  A, $05                                        ;; 00:14ff $c6 $05
    ld   C, A                                          ;; 00:1501 $4f
    ld   A, $0e                                        ;; 00:1502 $3e $0e
    call scriptObjectBehaviorMove                      ;; 00:1504 $cd $79 $28
    ret                                                ;; 00:1507 $c9

scriptOpCodeNpc6WalkSpeedDefault:
    call checkForFollower                              ;; 00:1508 $cd $c2 $28
    add  A, $05                                        ;; 00:150b $c6 $05
    ld   C, A                                          ;; 00:150d $4f
    ld   A, $0f                                        ;; 00:150e $3e $0f
    call scriptObjectBehaviorMove                      ;; 00:1510 $cd $79 $28
    ret                                                ;; 00:1513 $c9

scriptOpCodeNpc7StepForward:
    call checkForFollower                              ;; 00:1514 $cd $c2 $28
    add  A, $06                                        ;; 00:1517 $c6 $06
    ld   C, A                                          ;; 00:1519 $4f
    ld   A, $04                                        ;; 00:151a $3e $04
    call scriptObjectBehaviorMove                      ;; 00:151c $cd $79 $28
    ret                                                ;; 00:151f $c9

scriptOpCodeNpc7StepBackwards:
    call checkForFollower                              ;; 00:1520 $cd $c2 $28
    add  A, $06                                        ;; 00:1523 $c6 $06
    ld   C, A                                          ;; 00:1525 $4f
    ld   A, $05                                        ;; 00:1526 $3e $05
    call scriptObjectBehaviorMove                      ;; 00:1528 $cd $79 $28
    ret                                                ;; 00:152b $c9

scriptOpCodeNpc7DirectionRight:
    call checkForFollower                              ;; 00:152c $cd $c2 $28
    add  A, $06                                        ;; 00:152f $c6 $06
    ld   C, A                                          ;; 00:1531 $4f
    ld   A, $1c                                        ;; 00:1532 $3e $1c
    call scriptObjectBehaviorMove                      ;; 00:1534 $cd $79 $28
    ret                                                ;; 00:1537 $c9

scriptOpCodeNpc7DirectionLeft:
    call checkForFollower                              ;; 00:1538 $cd $c2 $28
    add  A, $06                                        ;; 00:153b $c6 $06
    ld   C, A                                          ;; 00:153d $4f
    ld   A, $1d                                        ;; 00:153e $3e $1d
    call scriptObjectBehaviorMove                      ;; 00:1540 $cd $79 $28
    ret                                                ;; 00:1543 $c9

scriptOpCodeNpc7DirectionUp:
    call checkForFollower                              ;; 00:1544 $cd $c2 $28
    add  A, $06                                        ;; 00:1547 $c6 $06
    ld   C, A                                          ;; 00:1549 $4f
    ld   A, $1e                                        ;; 00:154a $3e $1e
    call scriptObjectBehaviorMove                      ;; 00:154c $cd $79 $28
    ret                                                ;; 00:154f $c9

scriptOpCodeNpc7DirectionDown:
    call checkForFollower                              ;; 00:1550 $cd $c2 $28
    add  A, $06                                        ;; 00:1553 $c6 $06
    ld   C, A                                          ;; 00:1555 $4f
    ld   A, $1f                                        ;; 00:1556 $3e $1f
    call scriptObjectBehaviorMove                      ;; 00:1558 $cd $79 $28
    ret                                                ;; 00:155b $c9

scriptOpCodeNpc7Delete:
    call checkForFollower                              ;; 00:155c $cd $c2 $28
    add  A, $06                                        ;; 00:155f $c6 $06
    ld   C, A                                          ;; 00:1561 $4f
    call scriptNpcDelete                               ;; 00:1562 $cd $59 $28
    ret                                                ;; 00:1565 $c9

scriptOpCodeNpc7SetPosition:
    call checkForFollower                              ;; 00:1566 $cd $c2 $28
    add  A, $06                                        ;; 00:1569 $c6 $06
    ld   C, A                                          ;; 00:156b $4f
    call scriptNpcSetPosition                          ;; 00:156c $cd $3e $12
    ret                                                ;; 00:156f $c9

scriptOpCodeNpc7WalkSpeed4:
    call checkForFollower                              ;; 00:1570 $cd $c2 $28
    add  A, $06                                        ;; 00:1573 $c6 $06
    ld   C, A                                          ;; 00:1575 $4f
    ld   A, $0e                                        ;; 00:1576 $3e $0e
    call scriptObjectBehaviorMove                      ;; 00:1578 $cd $79 $28
    ret                                                ;; 00:157b $c9

scriptOpCodeNpc7WalkSpeedDefault:
    call checkForFollower                              ;; 00:157c $cd $c2 $28
    add  A, $06                                        ;; 00:157f $c6 $06
    ld   C, A                                          ;; 00:1581 $4f
    ld   A, $0f                                        ;; 00:1582 $3e $0f
    call scriptObjectBehaviorMove                      ;; 00:1584 $cd $79 $28
    ret                                                ;; 00:1587 $c9

; I'm not sure why, but the player script actions start normally but then use this to finish the action.
scriptPlayerFinishAction:
    push HL                                            ;; 00:1588 $e5
    call getPlayerDirection                            ;; 00:1589 $cd $ab $02
    pop  HL                                            ;; 00:158c $e1
    bit  7, A                                          ;; 00:158d $cb $7f
    ret  Z                                             ;; 00:158f $c8
    push HL                                            ;; 00:1590 $e5
    ld   A, $ff                                        ;; 00:1591 $3e $ff
    call getEmptyObjectsMovingDuringScriptSlot_trampoline ;; 00:1593 $cd $38 $29
    jr   Z, .jr_00_15a0                                ;; 00:1596 $28 $08
    call getPlayerDirection                            ;; 00:1598 $cd $ab $02
    ld   C, $ff                                        ;; 00:159b $0e $ff
    call scriptObjectBehaviorMove                      ;; 00:159d $cd $79 $28
.jr_00_15a0:
    pop  HL                                            ;; 00:15a0 $e1
    xor  A, A                                          ;; 00:15a1 $af
    dec  A                                             ;; 00:15a2 $3d
    ret                                                ;; 00:15a3 $c9

scriptOpCodePlayerStepForward:
    call scriptPlayerFinishAction                      ;; 00:15a4 $cd $88 $15
    ret  NZ                                            ;; 00:15a7 $c0
    push HL                                            ;; 00:15a8 $e5
    call getPlayerDirection                            ;; 00:15a9 $cd $ab $02
    pop  HL                                            ;; 00:15ac $e1
    and  A, $0f                                        ;; 00:15ad $e6 $0f
    add  A, $90                                        ;; 00:15af $c6 $90
    ld   C, $ff                                        ;; 00:15b1 $0e $ff
    call scriptObjectBehaviorMove                      ;; 00:15b3 $cd $79 $28
    ret                                                ;; 00:15b6 $c9

scriptOpCodePlayerStepBackwards:
    call scriptPlayerFinishAction                      ;; 00:15b7 $cd $88 $15
    ret  NZ                                            ;; 00:15ba $c0
    push HL                                            ;; 00:15bb $e5
    call getPlayerDirection                            ;; 00:15bc $cd $ab $02
    call objectReverseDirection                        ;; 00:15bf $cd $e4 $29
    pop  HL                                            ;; 00:15c2 $e1
    or   A, $b0                                        ;; 00:15c3 $f6 $b0
    ld   C, $ff                                        ;; 00:15c5 $0e $ff
    call scriptObjectBehaviorMove                      ;; 00:15c7 $cd $79 $28
    ret                                                ;; 00:15ca $c9

scriptOpCodePlayerDirectionRight:
    call scriptPlayerFinishAction                      ;; 00:15cb $cd $88 $15
    ret  NZ                                            ;; 00:15ce $c0
    ld   A, $01                                        ;; 00:15cf $3e $01
    ld   C, $ff                                        ;; 00:15d1 $0e $ff
    call scriptObjectBehaviorMove                      ;; 00:15d3 $cd $79 $28
    ret                                                ;; 00:15d6 $c9

scriptOpCodePlayerDirectionLeft:
    call scriptPlayerFinishAction                      ;; 00:15d7 $cd $88 $15
    ret  NZ                                            ;; 00:15da $c0
    ld   A, $02                                        ;; 00:15db $3e $02
    ld   C, $ff                                        ;; 00:15dd $0e $ff
    call scriptObjectBehaviorMove                      ;; 00:15df $cd $79 $28
    ret                                                ;; 00:15e2 $c9

scriptOpCodePlayerDirectionUp:
    call scriptPlayerFinishAction                      ;; 00:15e3 $cd $88 $15
    ret  NZ                                            ;; 00:15e6 $c0
    ld   A, $04                                        ;; 00:15e7 $3e $04
    ld   C, $ff                                        ;; 00:15e9 $0e $ff
    call scriptObjectBehaviorMove                      ;; 00:15eb $cd $79 $28
    ret                                                ;; 00:15ee $c9

scriptOpCodePlayerDirectionDown:
    call scriptPlayerFinishAction                      ;; 00:15ef $cd $88 $15
    ret  NZ                                            ;; 00:15f2 $c0
    ld   A, $08                                        ;; 00:15f3 $3e $08
    ld   C, $ff                                        ;; 00:15f5 $0e $ff
    call scriptObjectBehaviorMove                      ;; 00:15f7 $cd $79 $28
    ret                                                ;; 00:15fa $c9

scriptOpCodePlayerSetPosition:
    call scriptPlayerFinishAction                      ;; 00:15fb $cd $88 $15
    ret  NZ                                            ;; 00:15fe $c0
    call scriptPlayerSetPosition                       ;; 00:15ff $cd $0b $12
    call getNextScriptInstruction                      ;; 00:1602 $cd $27 $37
    ret                                                ;; 00:1605 $c9

scriptOpCodeFollowerStepForward:
    call checkForFollower                              ;; 00:1606 $cd $c2 $28
    jr   NZ, noFollower                                ;; 00:1609 $20 $54
    ld   A, $04                                        ;; 00:160b $3e $04
    ld   C, $00                                        ;; 00:160d $0e $00
    call scriptObjectBehaviorMove                      ;; 00:160f $cd $79 $28
    ret                                                ;; 00:1612 $c9

scriptOpCodeFollowerStepBackwards:
    call checkForFollower                              ;; 00:1613 $cd $c2 $28
    jr   NZ, noFollower                                ;; 00:1616 $20 $47
    ld   A, $05                                        ;; 00:1618 $3e $05
    ld   C, $00                                        ;; 00:161a $0e $00
    call scriptObjectBehaviorMove                      ;; 00:161c $cd $79 $28
    ret                                                ;; 00:161f $c9

scriptOpCodeFollowerDirectionRight:
    call checkForFollower                              ;; 00:1620 $cd $c2 $28
    jr   NZ, noFollower                                ;; 00:1623 $20 $3a
    ld   A, $1c                                        ;; 00:1625 $3e $1c
    ld   C, $00                                        ;; 00:1627 $0e $00
    call scriptObjectBehaviorMove                      ;; 00:1629 $cd $79 $28
    ret                                                ;; 00:162c $c9

scriptOpCodeFollowerDirectionLeft:
    call checkForFollower                              ;; 00:162d $cd $c2 $28
    jr   NZ, noFollower                                ;; 00:1630 $20 $2d
    ld   A, $1d                                        ;; 00:1632 $3e $1d
    ld   C, $00                                        ;; 00:1634 $0e $00
    call scriptObjectBehaviorMove                      ;; 00:1636 $cd $79 $28
    ret                                                ;; 00:1639 $c9

scriptOpCodeFollowerDirectionUp:
    call checkForFollower                              ;; 00:163a $cd $c2 $28
    jr   NZ, noFollower                                ;; 00:163d $20 $20
    ld   A, $1e                                        ;; 00:163f $3e $1e
    ld   C, $00                                        ;; 00:1641 $0e $00
    call scriptObjectBehaviorMove                      ;; 00:1643 $cd $79 $28
    ret                                                ;; 00:1646 $c9

scriptOpCodeFollowerDirectionDown:
    call checkForFollower                              ;; 00:1647 $cd $c2 $28
    jr   NZ, noFollower                                ;; 00:164a $20 $13
    ld   A, $1f                                        ;; 00:164c $3e $1f
    ld   C, $00                                        ;; 00:164e $0e $00
    call scriptObjectBehaviorMove                      ;; 00:1650 $cd $79 $28
    ret                                                ;; 00:1653 $c9

scriptOpCodeFollowerDelete:
    call checkForFollower                              ;; 00:1654 $cd $c2 $28
    jr   NZ, noFollower                                ;; 00:1657 $20 $06
    ld   C, $00                                        ;; 00:1659 $0e $00
    call scriptNpcDelete                               ;; 00:165b $cd $59 $28
    ret                                                ;; 00:165e $c9

noFollower:
    call getNextScriptInstruction                      ;; 00:165f $cd $27 $37
    ret                                                ;; 00:1662 $c9

scriptOpCodeFollowerSetPosition:
    call checkForFollower                              ;; 00:1663 $cd $c2 $28
    jr   NZ, .no_follower                              ;; 00:1666 $20 $06
    ld   C, $00                                        ;; 00:1668 $0e $00
    call scriptNpcSetPosition                          ;; 00:166a $cd $3e $12
    ret                                                ;; 00:166d $c9
.no_follower:
    inc  HL                                            ;; 00:166e $23
    inc  HL                                            ;; 00:166f $23
    call getNextScriptInstruction                      ;; 00:1670 $cd $27 $37
    ret                                                ;; 00:1673 $c9

scriptOpCodeFollowerWalkSpeed4:
    call checkForFollower                              ;; 00:1674 $cd $c2 $28
    jr   NZ, noFollower                                ;; 00:1677 $20 $e6
    ld   A, $0e                                        ;; 00:1679 $3e $0e
    ld   C, $00                                        ;; 00:167b $0e $00
    call scriptObjectBehaviorMove                      ;; 00:167d $cd $79 $28
    ret                                                ;; 00:1680 $c9

scriptOpCodeFollowerWalkSpeedDefault:
    call checkForFollower                              ;; 00:1681 $cd $c2 $28
    jr   NZ, noFollower                                ;; 00:1684 $20 $d9
    ld   A, $0f                                        ;; 00:1686 $3e $0f
    ld   C, $00                                        ;; 00:1688 $0e $00
    call scriptObjectBehaviorMove                      ;; 00:168a $cd $79 $28
    ret                                                ;; 00:168d $c9

; Unused script opcode.
scriptOpWaitWhileMovement:
    push HL                                            ;; 00:168e $e5
    ld   HL, wObjectsMovingDuringScript                ;; 00:168f $21 $a0 $c5
    ld   B, $08                                        ;; 00:1692 $06 $08
.loop:
    ld   A, [HL+]                                      ;; 00:1694 $2a
    cp   A, $00                                        ;; 00:1695 $fe $00
    jr   NZ, .wait                                     ;; 00:1697 $20 $08
    dec  B                                             ;; 00:1699 $05
    jr   NZ, .loop                                     ;; 00:169a $20 $f8
    pop  HL                                            ;; 00:169c $e1
    call getNextScriptInstruction                      ;; 00:169d $cd $27 $37
    ret                                                ;; 00:16a0 $c9
.wait:
    pop  HL                                            ;; 00:16a1 $e1
    ret                                                ;; 00:16a2 $c9
    db   $4f, $2a, $b9, $c8, $fe, $ff, $20, $f9        ;; 00:16a3 ????????
    db   $79, $fe, $ff, $c9                            ;; 00:16ab ????

; Get the attributes for the metatile at a location.
; If the requested location is not on screen then use the closest on-screen location's metatile.
; D = object y tile coordinate
; E = object x tile coordinate
; Return: HL = tile attributes
getRoomMetatileAttributes:
    ; Account for requests outside the current screen
    ; This can happen for projectiles in particular
    ld   A, E                                          ;; 00:16b6 $7b
    cp   A, SCRN_X_B                                   ;; 00:16b7 $fe $14
    jr   C, .x_pos_on_screen                           ;; 00:16b9 $38 $0a
    bit  7, E                                          ;; 00:16bb $cb $7b
    jr   NZ, .tile_left_of_screen                      ;; 00:16bd $20 $04
; use the right-most tile position
    ld   E, SCRN_X_B - 1                               ;; 00:16bf $1e $13
    jr   .x_pos_on_screen                              ;; 00:16c1 $18 $02
.tile_left_of_screen:
    ld   E, $00 ; use the left-most tile position      ;; 00:16c3 $1e $00
.x_pos_on_screen:
    ld   A, D                                          ;; 00:16c5 $7a
    cp   A, SCRN_Y_B - 2                               ;; 00:16c6 $fe $10
    jr   C, .y_pos_on_screen                           ;; 00:16c8 $38 $0a
    bit  7, D                                          ;; 00:16ca $cb $7a
    jr   NZ, .tile_above_screen                        ;; 00:16cc $20 $04
; use the bottom-most tile position
    ld   D, SCRN_Y_B - 3                               ;; 00:16ce $16 $0f
    jr   .y_pos_on_screen                              ;; 00:16d0 $18 $02
.tile_above_screen:
    ld   D, $00 ; use the top-most tile position       ;; 00:16d2 $16 $00
.y_pos_on_screen:

    ; Metatiles are on 16px boundaries vs the 8px position grid
    srl  D                                             ;; 00:16d4 $cb $3a
    srl  E                                             ;; 00:16d6 $cb $3b

    ; Read the attributes from the cache into HL
    call getMetatileAttributeCacheIndex
    ld A, [HL+]
    ld H, [HL]
    ld L, A
    ret

; Input: DE (yx) metatile (16px grid) position
; Output: HL pointer to first byte in metatile attributes
;         BC, DE unchanged, A=L, F varies
getMetatileAttributeCacheIndex:
    ; Index into the wMetatileAttributeCache with 2*(10*D+E)
    ld HL, wMetatileAttributeCache
    ld A, D
    add A, A
    add A, A
    add A, A
    add A, D
    add A, D
    add A, E
    add A, A

    ; At this point the max value in A is 2*(10*7+9)=158
    add A, L
    ld L, A
    ret NC
    inc H
    ret

; B = object direction bits. If bit 7 is set then the player will not take spike damage.
; C = object collision flags
; DE = object metatile location
; If the metatile being checked has the script bit set, run any associated script.
; Otherwise, run the spike damage routine. Spike damage is bits and $30, swapped, multiplied by the player level.
tileScriptOrSpikeDamage:
    push BC                                            ;; 00:1700 $c5
    push DE                                            ;; 00:1701 $d5
    call getRoomMetatileAttributes                     ;; 00:1702 $cd $af $16
    pop  DE                                            ;; 00:1705 $d1
    pop  BC                                            ;; 00:1706 $c1
    bit  7, H                                          ;; 00:1707 $cb $7c
    jr   Z, .no_script_bit                             ;; 00:1709 $28 $3b
    ld   A, [wMainGameStateFlags]                      ;; 00:170b $fa $a1 $c0
    bit  1, A                                          ;; 00:170e $cb $4f
    ret  NZ                                            ;; 00:1710 $c0
    srl  D                                             ;; 00:1711 $cb $3a
    srl  E                                             ;; 00:1713 $cb $3b
    ld   A, D                                          ;; 00:1715 $7a
    swap A                                             ;; 00:1716 $cb $37
    or   A, E                                          ;; 00:1718 $b3
    ld   D, A                                          ;; 00:1719 $57
    push BC                                            ;; 00:171a $c5
    push DE                                            ;; 00:171b $d5
    ld   A, $00                                        ;; 00:171c $3e $00
    call call_00_2617                                  ;; 00:171e $cd $17 $26
    ld   HL, $02                                       ;; 00:1721 $21 $02 $00
    add  HL, DE                                        ;; 00:1724 $19
    push HL                                            ;; 00:1725 $e5
    ld   A, [wMapTableBankNr]                          ;; 00:1726 $fa $f0 $c3
    call pushBankNrAndSwitch                           ;; 00:1729 $cd $fb $29
    pop  HL                                            ;; 00:172c $e1
    pop  DE                                            ;; 00:172d $d1
    pop  BC                                            ;; 00:172e $c1
.loop:
    ld   A, [HL+]                                      ;; 00:172f $2a
    cp   A, $ff                                        ;; 00:1730 $fe $ff
    jr   Z, .pop_bank_and_return                       ;; 00:1732 $28 $0e
    cp   A, D                                          ;; 00:1734 $ba
    jr   Z, .break                                     ;; 00:1735 $28 $04
    inc  HL                                            ;; 00:1737 $23
    inc  HL                                            ;; 00:1738 $23
    jr   .loop                                         ;; 00:1739 $18 $f4
.break:
    ld   A, [HL+]                                      ;; 00:173b $2a
    ld   H, [HL]                                       ;; 00:173c $66
    ld   L, A                                          ;; 00:173d $6f
    ld   A, B                                          ;; 00:173e $78
    call runScriptByIndex                              ;; 00:173f $cd $ad $31
.pop_bank_and_return:
    call popBankNrAndSwitch                            ;; 00:1742 $cd $0a $2a
    ret                                                ;; 00:1745 $c9
.no_script_bit:
    ld   A, [wMainGameStateFlags]                      ;; 00:1746 $fa $a1 $c0
    bit  3, A                                          ;; 00:1749 $cb $5f
    ret  NZ                                            ;; 00:174b $c0
    ld   A, [wPlayerDamagedTimer]                      ;; 00:174c $fa $d2 $c4
    cp   A, $00                                        ;; 00:174f $fe $00
    ret  NZ                                            ;; 00:1751 $c0
    ld   A, B                                          ;; 00:1752 $78
    and  A, $80                                        ;; 00:1753 $e6 $80
    cp   A, $80                                        ;; 00:1755 $fe $80
    ret  Z                                             ;; 00:1757 $c8
    bit  6, H                                          ;; 00:1758 $cb $74
    ret  NZ                                            ;; 00:175a $c0
    ld   A, C                                          ;; 00:175b $79
    and  A, $f0                                        ;; 00:175c $e6 $f0
    cp   A, $c0                                        ;; 00:175e $fe $c0
    ret  NZ                                            ;; 00:1760 $c0
    ld   A, H                                          ;; 00:1761 $7c
    swap A                                             ;; 00:1762 $cb $37
    and  A, $03                                        ;; 00:1764 $e6 $03
    ret  Z                                             ;; 00:1766 $c8
    ld   L, A                                          ;; 00:1767 $6f
    ld   H, $00                                        ;; 00:1768 $26 $00
    ld   A, [wLevel]                                   ;; 00:176a $fa $ba $d7
    call MultiplyHL_by_A                               ;; 00:176d $cd $7b $2b
    call subHP                                         ;; 00:1770 $cd $25 $3e
    ld   A, $0d                                        ;; 00:1773 $3e $0d
    call playSFX                                       ;; 00:1775 $cd $7d $29
    ld   A, $33                                        ;; 00:1778 $3e $33
    ld   [wPlayerDamagedTimer], A                      ;; 00:177a $ea $d2 $c4
    ret                                                ;; 00:177d $c9

; b = object id
; c = object collision flags
; de = yy pixel coordinate
call_00_177e:
; Convert pixel coordinate to tile coordinate.
    srl  D                                             ;; 00:177e $cb $3a
    srl  D                                             ;; 00:1780 $cb $3a
    srl  D                                             ;; 00:1782 $cb $3a
    dec  D                                             ;; 00:1784 $15
    srl  E                                             ;; 00:1785 $cb $3b
    srl  E                                             ;; 00:1787 $cb $3b
    srl  E                                             ;; 00:1789 $cb $3b
    dec  E                                             ;; 00:178b $1d
; Load the metatile bank.
    push DE                                            ;; 00:178c $d5
    push BC                                            ;; 00:178d $c5
    ld   A, BANK(metatilesOutdoor) ;@=bank metatilesOutdoor ;; 00:178e $3e $08
    call pushBankNrAndSwitch                           ;; 00:1790 $cd $fb $29
    pop  BC                                            ;; 00:1793 $c1
; Init sliding (ice and minecart tracks) to zero and save the previous value in L.
    push BC                                            ;; 00:1794 $c5
    ld   A, $00                                        ;; 00:1795 $3e $00
    ld   C, B                                          ;; 00:1797 $48
    call setObjectSliding                              ;; 00:1798 $cd $e4 $0c
    ld   L, A                                          ;; 00:179b $6f
; Check for sprites frozen by a script or screen scroll and return if so.
    pop  BC                                            ;; 00:179c $c1
    pop  DE                                            ;; 00:179d $d1
    ld   A, [wMainGameStateFlags]                      ;; 00:179e $fa $a1 $c0
    bit  3, A                                          ;; 00:17a1 $cb $5f
    jr   NZ, .pop_bank_and_return                      ;; 00:17a3 $20 $5d
    ld   A, C                                          ;; 00:17a5 $79
    and  A, $07                                        ;; 00:17a6 $e6 $07
    cp   A, $01                                        ;; 00:17a8 $fe $01
    jr   Z, .jr_00_17b4                                ;; 00:17aa $28 $08
    cp   A, $04                                        ;; 00:17ac $fe $04
    jr   Z, .jr_00_17b4                                ;; 00:17ae $28 $04
    cp   A, $05                                        ;; 00:17b0 $fe $05
    jr   NZ, .pop_bank_and_return                      ;; 00:17b2 $20 $4e
.jr_00_17b4:
    ld   C, B                                          ;; 00:17b4 $48
    ld   B, L                                          ;; 00:17b5 $45
    push BC                                            ;; 00:17b6 $c5
    push DE                                            ;; 00:17b7 $d5
    call getRoomMetatileAttributes                     ;; 00:17b8 $cd $af $16
    pop  DE                                            ;; 00:17bb $d1
    pop  BC                                            ;; 00:17bc $c1
    bit  6, H                                          ;; 00:17bd $cb $74
    jr   Z, .pop_bank_and_return                       ;; 00:17bf $28 $41
    inc  E                                             ;; 00:17c1 $1c
    push BC                                            ;; 00:17c2 $c5
    push HL                                            ;; 00:17c3 $e5
    call getRoomMetatileAttributes                     ;; 00:17c4 $cd $af $16
    pop  DE                                            ;; 00:17c7 $d1
    pop  BC                                            ;; 00:17c8 $c1
    bit  6, H                                          ;; 00:17c9 $cb $74
    jr   Z, .pop_bank_and_return                       ;; 00:17cb $28 $35
    ld   A, H                                          ;; 00:17cd $7c
    swap A                                             ;; 00:17ce $cb $37
    and  A, $03                                        ;; 00:17d0 $e6 $03
    ld   L, A                                          ;; 00:17d2 $6f
    ld   A, D                                          ;; 00:17d3 $7a
    swap A                                             ;; 00:17d4 $cb $37
    and  A, $03                                        ;; 00:17d6 $e6 $03
    cp   A, L                                          ;; 00:17d8 $bd
    jr   NZ, .jr_00_1806                               ;; 00:17d9 $20 $2b
    cp   A, $00                                        ;; 00:17db $fe $00
    jr   Z, .jr_00_17eb                                ;; 00:17dd $28 $0c
    cp   A, $01                                        ;; 00:17df $fe $01
    jr   Z, .jr_00_17ef                                ;; 00:17e1 $28 $0c
    cp   A, $02                                        ;; 00:17e3 $fe $02
    jr   Z, .jr_00_17f3                                ;; 00:17e5 $28 $0c
    ld   B, $08                                        ;; 00:17e7 $06 $08
    jr   .finish                                       ;; 00:17e9 $18 $0a
.jr_00_17eb:
    ld   B, $01                                        ;; 00:17eb $06 $01
    jr   .finish                                       ;; 00:17ed $18 $06
.jr_00_17ef:
    ld   B, $02                                        ;; 00:17ef $06 $02
    jr   .finish                                       ;; 00:17f1 $18 $02
.jr_00_17f3:
    ld   B, $04                                        ;; 00:17f3 $06 $04
.finish:
    ld   A, $90                                        ;; 00:17f5 $3e $90
    or   A, B                                          ;; 00:17f7 $b0
    push BC                                            ;; 00:17f8 $c5
    call setObjectSliding                              ;; 00:17f9 $cd $e4 $0c
    pop  BC                                            ;; 00:17fc $c1
    ld   A, $02                                        ;; 00:17fd $3e $02
    call setObjectOffset0b                             ;; 00:17ff $cd $08 $0d
.pop_bank_and_return:
    call popBankNrAndSwitch                            ;; 00:1802 $cd $0a $2a
    ret                                                ;; 00:1805 $c9
.jr_00_1806:
    ld   A, B                                          ;; 00:1806 $78
    cp   A, $00                                        ;; 00:1807 $fe $00
    jr   NZ, .finish                                   ;; 00:1809 $20 $ea
    push BC                                            ;; 00:180b $c5
    call getObjectDirection                            ;; 00:180c $cd $99 $0c
    pop  BC                                            ;; 00:180f $c1
    and  A, $0f                                        ;; 00:1810 $e6 $0f
    ld   B, A                                          ;; 00:1812 $47
    jr   .finish                                       ;; 00:1813 $18 $e0

call_00_1815:
    push DE                                            ;; 00:1815 $d5
    push AF                                            ;; 00:1816 $f5
    push BC                                            ;; 00:1817 $c5
    push DE                                            ;; 00:1818 $d5
    ld   A, $08                                        ;; 00:1819 $3e $08
    call pushBankNrAndSwitch                           ;; 00:181b $cd $fb $29
    pop  DE                                            ;; 00:181e $d1
    pop  BC                                            ;; 00:181f $c1
    pop  AF                                            ;; 00:1820 $f1
    push BC                                            ;; 00:1821 $c5
    srl  D                                             ;; 00:1822 $cb $3a
    srl  D                                             ;; 00:1824 $cb $3a
    srl  D                                             ;; 00:1826 $cb $3a
    dec  D                                             ;; 00:1828 $15
    srl  E                                             ;; 00:1829 $cb $3b
    srl  E                                             ;; 00:182b $cb $3b
    srl  E                                             ;; 00:182d $cb $3b
    dec  E                                             ;; 00:182f $1d
    push DE                                            ;; 00:1830 $d5
    bit  0, A                                          ;; 00:1831 $cb $47
    jr   NZ, .jr_00_1843                               ;; 00:1833 $20 $0e
    bit  1, A                                          ;; 00:1835 $cb $4f
    jr   NZ, .jr_00_1857                               ;; 00:1837 $20 $1e
    bit  2, A                                          ;; 00:1839 $cb $57
    jr   NZ, .jr_00_186b                               ;; 00:183b $20 $2e
    bit  3, A                                          ;; 00:183d $cb $5f
    jr   NZ, .jr_00_1892                               ;; 00:183f $20 $51
    jr   .jr_00_18b9                                   ;; 00:1841 $18 $76
.jr_00_1843:
    bit  0, E                                          ;; 00:1843 $cb $43
    jr   NZ, .jr_00_184f                               ;; 00:1845 $20 $08
    dec  E                                             ;; 00:1847 $1d
    ld   B, $81                                        ;; 00:1848 $06 $81
    call tileScriptOrSpikeDamage                       ;; 00:184a $cd $00 $17
    jr   .jr_00_18b9                                   ;; 00:184d $18 $6a
.jr_00_184f:
    inc  E                                             ;; 00:184f $1c
    ld   B, $01                                        ;; 00:1850 $06 $01
    call tileScriptOrSpikeDamage                       ;; 00:1852 $cd $00 $17
    jr   .jr_00_18b9                                   ;; 00:1855 $18 $62
.jr_00_1857:
    bit  0, E                                          ;; 00:1857 $cb $43
    jr   NZ, .jr_00_1864                               ;; 00:1859 $20 $09
    inc  E                                             ;; 00:185b $1c
    inc  E                                             ;; 00:185c $1c
    ld   B, $82                                        ;; 00:185d $06 $82
    call tileScriptOrSpikeDamage                       ;; 00:185f $cd $00 $17
    jr   .jr_00_18b9                                   ;; 00:1862 $18 $55
.jr_00_1864:
    ld   B, $02                                        ;; 00:1864 $06 $02
    call tileScriptOrSpikeDamage                       ;; 00:1866 $cd $00 $17
    jr   .jr_00_18b9                                   ;; 00:1869 $18 $4e
.jr_00_186b:
    bit  0, D                                          ;; 00:186b $cb $42
    jr   Z, .jr_00_18b9                                ;; 00:186d $28 $4a
    bit  0, E                                          ;; 00:186f $cb $43
    jr   Z, .jr_00_1883                                ;; 00:1871 $28 $10
    push DE                                            ;; 00:1873 $d5
    inc  E                                             ;; 00:1874 $1c
    push DE                                            ;; 00:1875 $d5
    ld   B, $04                                        ;; 00:1876 $06 $04
    call tileScriptOrSpikeDamage                       ;; 00:1878 $cd $00 $17
    pop  DE                                            ;; 00:187b $d1
    inc  D                                             ;; 00:187c $14
    ld   B, $84                                        ;; 00:187d $06 $84
    call tileScriptOrSpikeDamage                       ;; 00:187f $cd $00 $17
    pop  DE                                            ;; 00:1882 $d1
.jr_00_1883:
    push DE                                            ;; 00:1883 $d5
    ld   B, $04                                        ;; 00:1884 $06 $04
    call tileScriptOrSpikeDamage                       ;; 00:1886 $cd $00 $17
    pop  DE                                            ;; 00:1889 $d1
    inc  D                                             ;; 00:188a $14
    ld   B, $84                                        ;; 00:188b $06 $84
    call tileScriptOrSpikeDamage                       ;; 00:188d $cd $00 $17
    jr   .jr_00_18b9                                   ;; 00:1890 $18 $27
.jr_00_1892:
    bit  0, D                                          ;; 00:1892 $cb $42
    jr   NZ, .jr_00_18b9                               ;; 00:1894 $20 $23
    bit  0, E                                          ;; 00:1896 $cb $43
    jr   Z, .jr_00_18aa                                ;; 00:1898 $28 $10
    push DE                                            ;; 00:189a $d5
    inc  E                                             ;; 00:189b $1c
    push DE                                            ;; 00:189c $d5
    ld   B, $08                                        ;; 00:189d $06 $08
    call tileScriptOrSpikeDamage                       ;; 00:189f $cd $00 $17
    pop  DE                                            ;; 00:18a2 $d1
    dec  D                                             ;; 00:18a3 $15
    ld   B, $88                                        ;; 00:18a4 $06 $88
    call tileScriptOrSpikeDamage                       ;; 00:18a6 $cd $00 $17
    pop  DE                                            ;; 00:18a9 $d1
.jr_00_18aa:
    push DE                                            ;; 00:18aa $d5
    ld   B, $08                                        ;; 00:18ab $06 $08
    call tileScriptOrSpikeDamage                       ;; 00:18ad $cd $00 $17
    pop  DE                                            ;; 00:18b0 $d1
    dec  D                                             ;; 00:18b1 $15
    ld   B, $88                                        ;; 00:18b2 $06 $88
    call tileScriptOrSpikeDamage                       ;; 00:18b4 $cd $00 $17
    jr   .jr_00_18b9                                   ;; 00:18b7 $18 $00
.jr_00_18b9:
    call popBankNrAndSwitch                            ;; 00:18b9 $cd $0a $2a
    pop  DE                                            ;; 00:18bc $d1
    pop  BC                                            ;; 00:18bd $c1
    pop  DE                                            ;; 00:18be $d1
    ret                                                ;; 00:18bf $c9

; Used for player, NPCs, enemies, and companions
; A = object collision flags
; D = object y tile coordinate
; E = object x tile coordinate
checkObjectTileCollisions:
    inc  D                                             ;; 00:18c0 $14
    push AF                                            ;; 00:18c1 $f5
    and  A, $07                                        ;; 00:18c2 $e6 $07
    jr   Z, noCollision                                ;; 00:18c4 $28 $43
    push DE                                            ;; 00:18c6 $d5
    call getRoomMetatileAttributes                     ;; 00:18c7 $cd $af $16
    pop  DE                                            ;; 00:18ca $d1
    pop  AF                                            ;; 00:18cb $f1
    push DE                                            ;; 00:18cc $d5
    push AF                                            ;; 00:18cd $f5
    push HL                                            ;; 00:18ce $e5
    inc  E                                             ;; 00:18cf $1c
    call getRoomMetatileAttributes                     ;; 00:18d0 $cd $af $16
    pop  DE                                            ;; 00:18d3 $d1
    call HLandDE                                       ;; 00:18d4 $cd $b2 $29
    pop  AF                                            ;; 00:18d7 $f1
    pop  DE                                            ;; 00:18d8 $d1
    call checkTileCollision                            ;; 00:18d9 $cd $0f $19
    ret                                                ;; 00:18dc $c9

; Used for enemy projectiles, player attacks, and spells
; A = object collision flags
; D = object y tile coordinate
; E = object x tile coordinate
; Return: Z = collision, B = ?, A = unused?
checkProjectileTileCollisions:
    push AF                                            ;; 00:18dd $f5
    ld   C, A                                          ;; 00:18de $4f
    and  A, $f0                                        ;; 00:18df $e6 $f0
    cp   A, $40                                        ;; 00:18e1 $fe $40
    ld   A, C                                          ;; 00:18e3 $79
    jr   Z, .jr_00_18f6                                ;; 00:18e4 $28 $10
    and  A, $07                                        ;; 00:18e6 $e6 $07
    jr   Z, noCollision                                ;; 00:18e8 $28 $1f
    push DE                                            ;; 00:18ea $d5
    call getRoomMetatileAttributes                     ;; 00:18eb $cd $af $16
    pop  DE                                            ;; 00:18ee $d1
    pop  AF                                            ;; 00:18ef $f1
    call checkTileCollision                            ;; 00:18f0 $cd $0f $19
    ld   A, $00                                        ;; 00:18f3 $3e $00
    ret                                                ;; 00:18f5 $c9
.jr_00_18f6:
    push DE                                            ;; 00:18f6 $d5
    call getRoomMetatileAttributes                     ;; 00:18f7 $cd $af $16
    pop  DE                                            ;; 00:18fa $d1
    ld   A, L                                          ;; 00:18fb $7d
    and  A, $07                                        ;; 00:18fc $e6 $07
    ld   B, A                                          ;; 00:18fe $47
    pop  AF                                            ;; 00:18ff $f1
    push DE                                            ;; 00:1900 $d5
    push BC                                            ;; 00:1901 $c5
    call checkTileCollision                            ;; 00:1902 $cd $0f $19
    pop  BC                                            ;; 00:1905 $c1
    pop  DE                                            ;; 00:1906 $d1
    ld   A, B                                          ;; 00:1907 $78
    ret                                                ;; 00:1908 $c9

noCollision:
    pop  AF                                            ;; 00:1909 $f1
    xor  A, A                                          ;; 00:190a $af
    ld   B, A                                          ;; 00:190b $47
    cp   A, $01                                        ;; 00:190c $fe $01
    ret                                                ;; 00:190e $c9

; A = object collision flags
; D = y tile coordinate
; E = x tile coordinate
; HL = tile attributes
; Return: Z = collision, B = ?, A = unused?
checkTileCollision:
    push DE                                            ;; 00:190f $d5
    push HL                                            ;; 00:1910 $e5
    and  A, $07                                        ;; 00:1911 $e6 $07
    cp   A, $00                                        ;; 00:1913 $fe $00
    jr   Z, .collisionless                             ;; 00:1915 $28 $18
    cp   A, $03                                        ;; 00:1917 $fe $03
    jr   Z, .air                                       ;; 00:1919 $28 $1b
    cp   A, $04                                        ;; 00:191b $fe $04
    jr   Z, .jr_00_1941                                ;; 00:191d $28 $22
    cp   A, $02                                        ;; 00:191f $fe $02
    jr   Z, .projectile                                ;; 00:1921 $28 $29
    cp   A, $05                                        ;; 00:1923 $fe $05
    jr   Z, .water                                     ;; 00:1925 $28 $30
    cp   A, $01                                        ;; 00:1927 $fe $01
    jr   Z, .land                                      ;; 00:1929 $28 $58
    pop  HL                                            ;; 00:192b $e1
    pop  DE                                            ;; 00:192c $d1
    xor  A, A                                          ;; 00:192d $af
    ret                                                ;; 00:192e $c9
.collisionless:
    pop  HL                                            ;; 00:192f $e1
    pop  DE                                            ;; 00:1930 $d1
    xor  A, A                                          ;; 00:1931 $af
    inc  A                                             ;; 00:1932 $3c
    ld   B, $00                                        ;; 00:1933 $06 $00
    ret                                                ;; 00:1935 $c9
.air:
    pop  HL                                            ;; 00:1936 $e1
    ld   DE, $400                                      ;; 00:1937 $11 $00 $04
    call HLandDE                                       ;; 00:193a $cd $b2 $29
    pop  DE                                            ;; 00:193d $d1
    ld   B, $00                                        ;; 00:193e $06 $00
    ret                                                ;; 00:1940 $c9
.jr_00_1941:
    pop  HL                                            ;; 00:1941 $e1
    ld   DE, $200                                      ;; 00:1942 $11 $00 $02
    call HLandDE                                       ;; 00:1945 $cd $b2 $29
    pop  DE                                            ;; 00:1948 $d1
    ld   B, $00                                        ;; 00:1949 $06 $00
    ret                                                ;; 00:194b $c9
.projectile:
    pop  HL                                            ;; 00:194c $e1
    ld   DE, $100                                      ;; 00:194d $11 $00 $01
    call HLandDE                                       ;; 00:1950 $cd $b2 $29
    pop  DE                                            ;; 00:1953 $d1
    ld   B, $00                                        ;; 00:1954 $06 $00
    ret                                                ;; 00:1956 $c9
.water:
    pop  HL                                            ;; 00:1957 $e1
    ld   DE, $c0                                       ;; 00:1958 $11 $c0 $00
    call HLandDE                                       ;; 00:195b $cd $b2 $29
    pop  DE                                            ;; 00:195e $d1
    ld   B, $00                                        ;; 00:195f $06 $00
    ret  Z                                             ;; 00:1961 $c8
    push DE                                            ;; 00:1962 $d5
    ld   DE, $80                                       ;; 00:1963 $11 $80 $00
    push HL                                            ;; 00:1966 $e5
    call HLandDE                                       ;; 00:1967 $cd $b2 $29
    pop  HL                                            ;; 00:196a $e1
    jr   Z, .water_check_top                           ;; 00:196b $28 $10
    ld   DE, $40                                       ;; 00:196d $11 $40 $00
    call HLandDE                                       ;; 00:1970 $cd $b2 $29
    pop  DE                                            ;; 00:1973 $d1
    ld   B, $00                                        ;; 00:1974 $06 $00
    ret  NZ                                            ;; 00:1976 $c0
    inc  D                                             ;; 00:1977 $14
    bit  0, D                                          ;; 00:1978 $cb $42
    ld   B, $00                                        ;; 00:197a $06 $00
    ret                                                ;; 00:197c $c9
.water_check_top:
    pop  DE                                            ;; 00:197d $d1
    bit  0, D                                          ;; 00:197e $cb $42
    ld   B, $00                                        ;; 00:1980 $06 $00
    ret                                                ;; 00:1982 $c9
.land:
    pop  HL                                            ;; 00:1983 $e1
    ld   DE, $30                                       ;; 00:1984 $11 $30 $00
    call HLandDE                                       ;; 00:1987 $cd $b2 $29
    pop  DE                                            ;; 00:198a $d1
    jr   Z, .jr_00_1991                                ;; 00:198b $28 $04
    call call_00_1a0b                                  ;; 00:198d $cd $0b $1a
    ret                                                ;; 00:1990 $c9
.jr_00_1991:
    push DE                                            ;; 00:1991 $d5
    sra  D                                             ;; 00:1992 $cb $2a
    sra  E                                             ;; 00:1994 $cb $2b
    call getDoorStatus                                 ;; 00:1996 $cd $b9 $23
    pop  DE                                            ;; 00:1999 $d1
    jr   Z, .jr_00_19d8                                ;; 00:199a $28 $3c
    push DE                                            ;; 00:199c $d5
    call getRoomMetatileAttributes                     ;; 00:199d $cd $af $16
    pop  DE                                            ;; 00:19a0 $d1
    push DE                                            ;; 00:19a1 $d5
    call call_00_1a0b                                  ;; 00:19a2 $cd $0b $1a
    pop  DE                                            ;; 00:19a5 $d1
    jr   Z, .jr_00_19ee                                ;; 00:19a6 $28 $46
    inc  E                                             ;; 00:19a8 $1c
    push DE                                            ;; 00:19a9 $d5
    sra  D                                             ;; 00:19aa $cb $2a
    sra  E                                             ;; 00:19ac $cb $2b
    call getDoorStatus                                 ;; 00:19ae $cd $b9 $23
    pop  DE                                            ;; 00:19b1 $d1
    jr   NZ, .jr_00_19ee                               ;; 00:19b2 $20 $3a
    bit  2, C                                          ;; 00:19b4 $cb $51
    jr   NZ, .jr_00_19ee                               ;; 00:19b6 $20 $36
    bit  3, C                                          ;; 00:19b8 $cb $59
    jr   NZ, .jr_00_19ee                               ;; 00:19ba $20 $32
.jr_00_19bc:
    ld   A, C                                          ;; 00:19bc $79
    rlca                                               ;; 00:19bd $07
    xor  A, D                                          ;; 00:19be $aa
    and  A, $01                                        ;; 00:19bf $e6 $01
    jr   NZ, .jr_00_19ee                               ;; 00:19c1 $20 $2b
    res  7, C                                          ;; 00:19c3 $cb $b9
    push BC                                            ;; 00:19c5 $c5
    inc  E                                             ;; 00:19c6 $1c
    bit  0, C                                          ;; 00:19c7 $cb $41
    jr   NZ, .jr_00_19cd                               ;; 00:19c9 $20 $02
    dec  E                                             ;; 00:19cb $1d
    dec  E                                             ;; 00:19cc $1d
.jr_00_19cd:
    call getRoomMetatileAttributes                     ;; 00:19cd $cd $af $16
    ld   DE, $08                                       ;; 00:19d0 $11 $08 $00
    call HLandDE                                       ;; 00:19d3 $cd $b2 $29
    pop  BC                                            ;; 00:19d6 $c1
    ret                                                ;; 00:19d7 $c9
.jr_00_19d8:
    push BC                                            ;; 00:19d8 $c5
    inc  E                                             ;; 00:19d9 $1c
    push DE                                            ;; 00:19da $d5
    sra  D                                             ;; 00:19db $cb $2a
    sra  E                                             ;; 00:19dd $cb $2b
    call getDoorStatus                                 ;; 00:19df $cd $b9 $23
    pop  DE                                            ;; 00:19e2 $d1
    pop  BC                                            ;; 00:19e3 $c1
    jr   Z, .jr_00_19f1                                ;; 00:19e4 $28 $0b
    bit  0, C                                          ;; 00:19e6 $cb $41
    jr   NZ, .jr_00_19bc                               ;; 00:19e8 $20 $d2
    bit  1, C                                          ;; 00:19ea $cb $49
    jr   NZ, .jr_00_19bc                               ;; 00:19ec $20 $ce
.jr_00_19ee:
    xor  A, A                                          ;; 00:19ee $af
    ld   B, A                                          ;; 00:19ef $47
    ret                                                ;; 00:19f0 $c9
.jr_00_19f1:
    bit  0, C                                          ;; 00:19f1 $cb $41
    jr   NZ, .jr_00_19bc                               ;; 00:19f3 $20 $c7
    bit  1, C                                          ;; 00:19f5 $cb $49
    jr   NZ, .jr_00_19bc                               ;; 00:19f7 $20 $c3
    bit  0, E                                          ;; 00:19f9 $cb $43
    jr   NZ, .jr_00_19ee                               ;; 00:19fb $20 $f1
    res  7, C                                          ;; 00:19fd $cb $b9
    push BC                                            ;; 00:19ff $c5
    call getRoomMetatileAttributes                     ;; 00:1a00 $cd $af $16
    ld   DE, $08                                       ;; 00:1a03 $11 $08 $00
    call HLandDE                                       ;; 00:1a06 $cd $b2 $29
    pop  BC                                            ;; 00:1a09 $c1
    ret                                                ;; 00:1a0a $c9

call_00_1a0b:
    push DE                                            ;; 00:1a0b $d5
    ld   DE, $20                                       ;; 00:1a0c $11 $20 $00
    push HL                                            ;; 00:1a0f $e5
    call HLandDE                                       ;; 00:1a10 $cd $b2 $29
    pop  HL                                            ;; 00:1a13 $e1
    jr   Z, .jr_00_1a28                                ;; 00:1a14 $28 $12
    ld   DE, $10                                       ;; 00:1a16 $11 $10 $00
    call HLandDE                                       ;; 00:1a19 $cd $b2 $29
    pop  DE                                            ;; 00:1a1c $d1
    ld   B, $00                                        ;; 00:1a1d $06 $00
    ret  NZ                                            ;; 00:1a1f $c0
    inc  D                                             ;; 00:1a20 $14
    ld   A, D                                          ;; 00:1a21 $7a
    and  A, E                                          ;; 00:1a22 $a3
    bit  0, A                                          ;; 00:1a23 $cb $47
    ld   B, $00                                        ;; 00:1a25 $06 $00
    ret                                                ;; 00:1a27 $c9
.jr_00_1a28:
    pop  DE                                            ;; 00:1a28 $d1
    ld   A, D                                          ;; 00:1a29 $7a
    and  A, E                                          ;; 00:1a2a $a3
    bit  0, A                                          ;; 00:1a2b $cb $47
    ld   B, $00                                        ;; 00:1a2d $06 $00
    ret                                                ;; 00:1a2f $c9

clearPlayerAnimation:
    ld   HL, wPlayerAnimation                          ;; 00:1a30 $21 $94 $d3
    ld   B, $04                                        ;; 00:1a33 $06 $04
    ld   A, $ff                                        ;; 00:1a35 $3e $ff
    call fillMemory                                    ;; 00:1a37 $cd $5d $2b
    ret                                                ;; 00:1a3a $c9

; A = tile number
; Return: A = VRAM tile number of the loaded tile
loadMinimapTile:
    call loadRoomTile                                  ;; 00:1a3b $cd $a1 $1b
; The array for tile mapping immediately preceeds the array for tile load state and both are 256 bytes.
    dec h
    ld   A, [HL]                                       ;; 00:1a42 $7e
    ret                                                ;; 00:1a43 $c9

; Checks the tile state cache for each tile in a metatile, refreshing it if it is already cached
; A = metatile number
; Return: Z if all tiles are already cached, NZ if not
mapGraphicsStateCheckCache:
    push AF                                            ;; 00:1a44 $f5
    ld   A, BANK(metatilesOutdoor) ;@=bank metatilesOutdoor ;; 00:1a45 $3e $08
    call pushBankNrAndSwitch                           ;; 00:1a47 $cd $fb $29
    pop  AF                                            ;; 00:1a4a $f1
    call getTileInfoPointer                            ;; 00:1a4b $cd $19 $1b
    ld   B, $04                                        ;; 00:1a4e $06 $04
    ld   C, $04                                        ;; 00:1a50 $0e $04
.loop:
    ld   A, [HL+]                                      ;; 00:1a52 $2a
    push HL                                            ;; 00:1a53 $e5
    ld   E, A                                          ;; 00:1a54 $5f
    ld   D, $00                                        ;; 00:1a55 $16 $00
    ld   HL, wBackgroundGraphicsTileState              ;; 00:1a57 $21 $70 $d1
    add  HL, DE                                        ;; 00:1a5a $19
    ld   A, [HL]                                       ;; 00:1a5b $7e
    cp   A, $00                                        ;; 00:1a5c $fe $00
    jr   Z, .jr_00_1a63                                ;; 00:1a5e $28 $03
    ld   [HL], $0f                                     ;; 00:1a60 $36 $0f
    dec  C                                             ;; 00:1a62 $0d
.jr_00_1a63:
    pop  HL                                            ;; 00:1a63 $e1
    dec  B                                             ;; 00:1a64 $05
    jr   NZ, .loop                                     ;; 00:1a65 $20 $eb
    ld   A, C                                          ;; 00:1a67 $79
    cp   A, $00                                        ;; 00:1a68 $fe $00
    push AF                                            ;; 00:1a6a $f5
    call popBankNrAndSwitch                            ;; 00:1a6b $cd $0a $2a
    pop  AF                                            ;; 00:1a6e $f1
    ret                                                ;; 00:1a6f $c9

animateTiles_trampoline:
    jp_to_bank 11, animateTiles                        ;; 00:1a70

; Loads two tiles (for one 8*16 sprite) from bank 8.
; Used to load in the player and player attack graphics.
; The first 16 tiles of the sprite VRAM are loaded with this.
; B = VRAM offset from $8000
; DE = base address for tile data
; HL = index into tile data (multiplied by 16)
; Return: HL = HL + 2 (index to the next tiles)
playerSpritesLoadDoubleTile:
    push HL                                            ;; 00:1a76 $e5
    ld   C, B                                          ;; 00:1a77 $48
    call playerSpritesLoadTile                         ;; 00:1a7a $cd $8c $1a
    ld   A, $10                                        ;; 00:1a7d $3e $10
    add  A, C                                          ;; 00:1a7f $81
    ld   C, A                                          ;; 00:1a80 $4f
    call playerSpritesLoadTile                         ;; 00:1a83 $cd $8c $1a
    pop  HL                                            ;; 00:1a86 $e1
    inc hl
    inc hl
    ret                                                ;; 00:1a8b $c9

; Loads a tile from bank 8. Has a fallback for non-tile sized chunks that is never used.
; C = VRAM offset from $8000
; DE = base address for tile data
; HL = index into tile data (multiplied by $10)
playerSpritesLoadTile:
    ld   A, [HL+]                                      ;; 00:1a8c $2a
    cp   A, $ff                                        ;; 00:1a8d $fe $ff
    push DE                                            ;; 00:1a92 $d5
    push HL                                            ;; 00:1a93 $e5
    jr z, .blank
    swap A                                             ;; 00:1a94 $cb $37
    ld   L, A                                          ;; 00:1a96 $6f
    and  A, $0f                                        ;; 00:1a97 $e6 $0f
    ld   H, A                                          ;; 00:1a99 $67
    ld   A, L                                          ;; 00:1a9a $7d
    and  A, $f0                                        ;; 00:1a9b $e6 $f0
    ld   L, A                                          ;; 00:1a9d $6f
    ld   A, C                                          ;; 00:1a9e $79
    and  A, $0f                                        ;; 00:1a9f $e6 $0f
    or   A, L                                          ;; 00:1aa1 $b5
    ld   L, A                                          ;; 00:1aa2 $6f
    add  HL, DE                                        ;; 00:1aa3 $19
    push HL                                            ;; 00:1aa4 $e5
    ld   B, $00                                        ;; 00:1aa6 $06 $00
    ld   HL, _VRAM8000                                 ;; 00:1aa8 $21 $00 $80
    add  HL, BC                                        ;; 00:1aab $09
    ld   D, H                                          ;; 00:1aac $54
    ld   E, L                                          ;; 00:1aad $5d
    pop  HL                                            ;; 00:1aae $e1
    ld   A, BANK(gfxPlayer)                            ;; 00:1abb $3e $08
    call addTileGraphicCopyRequest                     ;; 00:1abd $cd $f5 $2d
    pop  HL                                            ;; 00:1ac0 $e1
    pop  DE                                            ;; 00:1ac1 $d1
    ret                                                ;; 00:1ac3 $c9
.blank:
    ld   B, $00                                        ;; 00:1acf $06 $00
    ld   HL, _VRAM8000                                 ;; 00:1ad1 $21 $00 $80
    add  HL, BC                                        ;; 00:1ad4 $09
    ld   D, H                                          ;; 00:1ad5 $54
    ld   E, L                                          ;; 00:1ad6 $5d
    ld   HL, gfxBlankTiles08                           ;; 00:1ad7 $21 $00 $5a
    ld   A, BANK(gfxBlankTiles08)                      ;; 00:1aea $3e $08
    call addTileGraphicCopyRequest                     ;; 00:1aec $cd $f5 $2d
    pop  HL                                            ;; 00:1af0 $e1
    pop  DE                                            ;; 00:1af1 $d1
    ret                                                ;; 00:1af2 $c9

SECTION "bank00_align_1af3", ROM0[$1af3]

initMapGraphicsState:
    ld   A, H                                          ;; 00:1af3 $7c
    ld   [wMapGraphicsPointer.High], A                 ;; 00:1af4 $ea $91 $d3
    ld   A, L                                          ;; 00:1af7 $7d
    ld   [wMapGraphicsPointer], A                      ;; 00:1af8 $ea $90 $d3
    ld   A, D                                          ;; 00:1afb $7a
    ld   [wTileDataTablePointer.High], A               ;; 00:1afc $ea $93 $d3
    ld   A, E                                          ;; 00:1aff $7b
    ld   [wTileDataTablePointer], A                    ;; 00:1b00 $ea $92 $d3
    ld   A, $00                                        ;; 00:1b03 $3e $00
    ld   B, $ff                                        ;; 00:1b05 $06 $ff
    ld   HL, wBackgroundGraphicsTileState              ;; 00:1b07 $21 $70 $d1
    ld   [HL+], A                                      ;; 00:1b0a $22
    call fillMemory                                    ;; 00:1b0b $cd $5d $2b
    ld   A, $00                                        ;; 00:1b0e $3e $00
    ld   B, $80                                        ;; 00:1b10 $06 $80
    ld   HL, wBackgroundGraphicsTileUsed               ;; 00:1b12 $21 $70 $d2
    call fillMemory                                    ;; 00:1b15 $cd $5d $2b
    ret                                                ;; 00:1b18 $c9

; a = metatile number
; Return: hl = pointer to the metatile entry
getTileInfoPointer:
; Get the base pointer for the current metatile data table.
    ld hl, wTileDataTablePointer
    ld e, [hl]
    inc hl
    ld d, [hl]
; Calculate the offset for the metatile entry (a * 16).
    ld   L, A                                          ;; 00:1b19 $6f
    ld   H, $00                                        ;; 00:1b1a $26 $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
; Add the two together.
    add  HL, DE                                        ;; 00:1b29 $19
    ret                                                ;; 00:1b2a $c9

ds 3 ; Free space

; Any tile that are already cached have their timer refreshed.
; HL = wRoomTiles
mapGraphicsStateRefreshTiles:
    ld   B, $50                                        ;; 00:1b2b $06 $50
    ld de, wBackgroundGraphicsTileState
.loop_outer:
    ld   A, [HL+]                                      ;; 00:1b2d $2a
    push HL                                            ;; 00:1b2e $e5
    call getTileInfoPointer                            ;; 00:1b2f $cd $19 $1b
    ld   C, $04                                        ;; 00:1b32 $0e $04
.loop_inner:
    ld   A, [HL+]                                      ;; 00:1b34 $2a
    push HL                                            ;; 00:1b35 $e5
    ld l, a
; Set a to $00 so it can be used with an or [hl].
    xor a
    ld h, a
    add  HL, DE                                        ;; 00:1b3c $19
    or [hl]
    jr   Z, .next                                      ;; 00:1b40 $28 $03
    ld [hl], $10
.next:
    pop  HL                                            ;; 00:1b45 $e1
    dec  C                                             ;; 00:1b46 $0d
    jr   NZ, .loop_inner                               ;; 00:1b47 $20 $eb
    pop  HL                                            ;; 00:1b49 $e1
    dec  B                                             ;; 00:1b4a $05
    jr   NZ, .loop_outer                               ;; 00:1b4b $20 $e0
    ret                                                ;; 00:1b4d $c9

ds 3 ; Free space

; Decrement each active tile cache timer.
mapGraphicsStateUpdateCache:
    ld   HL, wBackgroundGraphicsTileState              ;; 00:1b4e $21 $70 $d1
    ld   B, $00                                        ;; 00:1b51 $06 $00
.loop:
    ld   A, [HL]                                       ;; 00:1b53 $7e
    or a
    jr   Z, .next                                      ;; 00:1b56 $28 $17
    dec  A                                             ;; 00:1b58 $3d
    jr   NZ, .next                                     ;; 00:1b59 $20 $14
; The tile has just aged out of the cache.
    push HL                                            ;; 00:1b5b $e5
; This load is $ff00, which could be considered -256.
; In reality it's using its offset in one table to find the entry in the previous table.
; Another alternative would be to reverse its use of B and use that as an index, but it isn't important.
    ld de, (wBackgroundGraphicsTileMapping - wBackgroundGraphicsTileState)
    add  HL, DE                                        ;; 00:1b5f $19
    ld   A, $80                                        ;; 00:1b60 $3e $80
    add  A, [HL]                                       ;; 00:1b62 $86
    ld   E, A                                          ;; 00:1b63 $5f
    xor a
    ld d, a
    ld   HL, wBackgroundGraphicsTileUsed               ;; 00:1b66 $21 $70 $d2
    add  HL, DE                                        ;; 00:1b69 $19
; a is $00.
    ld [hl], a
    pop  HL                                            ;; 00:1b6c $e1
.next:
    ld   [HL+], A                                      ;; 00:1b6f $22
    dec  B                                             ;; 00:1b70 $05
    jr   NZ, .loop                                     ;; 00:1b71 $20 $e0
    ret                                                ;; 00:1b73 $c9

ds 4 ; Free space

; Ensures all needed tiles are loaded for the room's metatiles
loadRoomTiles:
    push HL                                            ;; 00:1b74 $e5
    ld   A, BANK(metatilesOutdoor) ;@=bank metatilesOutdoor ;; 00:1b75 $3e $08
    call pushBankNrAndSwitch                           ;; 00:1b77 $cd $fb $29
    pop  HL                                            ;; 00:1b7a $e1
    push HL                                            ;; 00:1b7b $e5
    call mapGraphicsStateRefreshTiles                  ;; 00:1b7c $cd $2b $1b
    call mapGraphicsStateUpdateCache                   ;; 00:1b7f $cd $4e $1b
    pop  HL                                            ;; 00:1b82 $e1
    ld   B, $50                                        ;; 00:1b83 $06 $50
.loop_outer:
    ld   A, [HL+]                                      ;; 00:1b85 $2a
    push HL                                            ;; 00:1b86 $e5
    call getTileInfoPointer                            ;; 00:1b87 $cd $19 $1b
    ld   C, $04                                        ;; 00:1b8a $0e $04
.loop_inner:
    ld   A, [HL+]                                      ;; 00:1b8c $2a
    push HL                                            ;; 00:1b8d $e5
    push BC                                            ;; 00:1b8e $c5
    call loadRoomTile                                  ;; 00:1b8f $cd $a1 $1b
    pop  BC                                            ;; 00:1b92 $c1
    pop  HL                                            ;; 00:1b93 $e1
    dec  C                                             ;; 00:1b94 $0d
    jp   NZ, .loop_inner                               ;; 00:1b95 $c2 $8c $1b
    pop  HL                                            ;; 00:1b98 $e1
    dec  B                                             ;; 00:1b99 $05
    jp   NZ, .loop_outer                               ;; 00:1b9a $c2 $85 $1b
    call popBankNrAndSwitch                            ;; 00:1b9d $cd $0a $2a
    ret                                                ;; 00:1ba0 $c9

; Loads one tile and updates caching records. Has some extra logic for animated tiles.
; A = tile number
; Return: HL = wBackgroundGraphicsTileState address
loadRoomTile:
    ld   E, A                                          ;; 00:1ba1 $5f
    ld   D, $00                                        ;; 00:1ba2 $16 $00
    ld   HL, wBackgroundGraphicsTileState              ;; 00:1ba4 $21 $70 $d1
    add  HL, DE                                        ;; 00:1ba7 $19
    ld   A, [HL]                                       ;; 00:1ba8 $7e
    cp   A, $00                                        ;; 00:1ba9 $fe $00
    jr   Z, .tile_not_loaded                           ;; 00:1bab $28 $03
    ld   [HL], $0f                                     ;; 00:1bad $36 $0f
    ret                                                ;; 00:1baf $c9
.tile_not_loaded:
    ld   A, $00                                        ;; 00:1bb0 $3e $00
    push HL                                            ;; 00:1bb2 $e5
    ld   D, $70                                        ;; 00:1bb3 $16 $70
    ld   HL, wBackgroundGraphicsTileUsed               ;; 00:1bb5 $21 $70 $d2
.loop:
    cp   A, [HL]                                       ;; 00:1bb8 $be
    jr   Z, .space_found                               ;; 00:1bb9 $28 $0c
    inc  HL                                            ;; 00:1bbb $23
    dec  D                                             ;; 00:1bbc $15
    jr   NZ, .loop                                     ;; 00:1bbd $20 $f9
    push DE                                            ;; 00:1bbf $d5
    call mapGraphicsStateUpdateCache                   ;; 00:1bc0 $cd $4e $1b
    pop  DE                                            ;; 00:1bc3 $d1
    pop  HL                                            ;; 00:1bc4 $e1
    jr   .tile_not_loaded                              ;; 00:1bc5 $18 $e9
.space_found:
    ld   [HL], $01                                     ;; 00:1bc7 $36 $01
    ld   A, $f0                                        ;; 00:1bc9 $3e $f0
    sub  A, D                                          ;; 00:1bcb $92
    pop  HL                                            ;; 00:1bcc $e1
    push HL                                            ;; 00:1bcd $e5
    ld   [HL], $0f                                     ;; 00:1bce $36 $0f
    ld   DE, -256 ;@=value signed=True                 ;; 00:1bd0 $11 $00 $ff
    add  HL, DE                                        ;; 00:1bd3 $19
    ld   [HL], A                                       ;; 00:1bd4 $77
    ld   L, A                                          ;; 00:1bd5 $6f
    ld   H, $00                                        ;; 00:1bd6 $26 $00
    add  HL, HL                                        ;; 00:1bd8 $29
    add  HL, HL                                        ;; 00:1bd9 $29
    add  HL, HL                                        ;; 00:1bda $29
    add  HL, HL                                        ;; 00:1bdb $29
    ld   DE, _VRAM8000 ;@=ptr _VRAM8000                ;; 00:1bdc $11 $00 $80
    add  HL, DE                                        ;; 00:1bdf $19
    pop  DE                                            ;; 00:1be0 $d1
    push DE                                            ;; 00:1be1 $d5
    push HL                                            ;; 00:1be2 $e5
; $2e90 == $10000 - $d170, so (HL + DE) is equal to the index in wBackgroundGraphicsTileState
    ld   HL, $2e90                                     ;; 00:1be3 $21 $90 $2e
    add  HL, DE                                        ;; 00:1be6 $19
    add  HL, HL                                        ;; 00:1be7 $29
    add  HL, HL                                        ;; 00:1be8 $29
    add  HL, HL                                        ;; 00:1be9 $29
    add  HL, HL                                        ;; 00:1bea $29
    ld   A, [wMapGraphicsPointer.High]                 ;; 00:1beb $fa $91 $d3
    ld   D, A                                          ;; 00:1bee $57
    ld   A, [wMapGraphicsPointer]                      ;; 00:1bef $fa $90 $d3
    ld   E, A                                          ;; 00:1bf2 $5f
    add  HL, DE                                        ;; 00:1bf3 $19
    pop  DE                                            ;; 00:1bf4 $d1
; Background tile graphics start at the beginning of bank c, then continue into bank b
    ld   A, BANK(tilesetGfxOutdoor) ;@=bank tilesetGfxOutdoor ;; 00:1bf5 $3e $0c
    push HL                                            ;; 00:1bf7 $e5
    bit  7, H                                          ;; 00:1bf8 $cb $7c
    jr   Z, .jr_00_1c01                                ;; 00:1bfa $28 $05
    dec  A                                             ;; 00:1bfc $3d
    res  7, H                                          ;; 00:1bfd $cb $bc
    set  6, H                                          ;; 00:1bff $cb $f4
.jr_00_1c01:
    call addTileGraphicCopyRequest                     ;; 00:1c01 $cd $f5 $2d
    pop  HL                                            ;; 00:1c04 $e1
    push HL                                            ;; 00:1c05 $e5
    ld   DE, -128 ;@=value signed=True                 ;; 00:1c06 $11 $80 $ff
    add  HL, DE                                        ;; 00:1c09 $19
    ld   A, [wMapGraphicsPointer.High]                 ;; 00:1c0a $fa $91 $d3
    ld   D, A                                          ;; 00:1c0d $57
    ld   A, [wMapGraphicsPointer]                      ;; 00:1c0e $fa $90 $d3
    ld   E, A                                          ;; 00:1c11 $5f
    call sub_HL_DE                                     ;; 00:1c12 $cd $ab $2b
    pop  BC                                            ;; 00:1c15 $c1
    ld   A, H                                          ;; 00:1c16 $7c
    cp   A, $00                                        ;; 00:1c17 $fe $00
    jr   NZ, .done                                     ;; 00:1c19 $20 $1f
    ld   A, L                                          ;; 00:1c1b $7d
    cp   A, $90                                        ;; 00:1c1c $fe $90
    jr   NC, .done                                     ;; 00:1c1e $30 $1a
; If the tile should be animated, also copy it into SRAM
    ld   DE, wAnimatedTileWaterfall1                   ;; 00:1c20 $11 $f0 $d2
    add  HL, DE                                        ;; 00:1c23 $19
    push BC                                            ;; 00:1c24 $c5
    push HL                                            ;; 00:1c25 $e5
; Background tile graphics start at the beginning of bank 1c, then continue into bank 1b
    ld   A, BANK(tilesetGfxOutdoor) ;@=bank tilesetGfxOutdoor ;; 00:1c26 $3e $0c
    bit  7, B                                          ;; 00:1c28 $cb $78
    jr   Z, .jr_00_1c2d                                ;; 00:1c2a $28 $01
    dec  A                                             ;; 00:1c2c $3d
.jr_00_1c2d:
    call pushBankNrAndSwitch                           ;; 00:1c2d $cd $fb $29
    pop  DE                                            ;; 00:1c30 $d1
    pop  HL                                            ;; 00:1c31 $e1
; Animated graphics originally only worked in one of the two banks used so to fix
; if address >= $8000 then sub $4000
    bit 7, h
    jr z, .copyToSRAM
    res 7, h
    set 6, h
.copyToSRAM:
    ld   B, $10                                        ;; 00:1c32 $06 $10
    call copyHLtoDE                                    ;; 00:1c34 $cd $49 $2b
    call popBankNrAndSwitch                            ;; 00:1c37 $cd $0a $2a
.done:
    pop  HL                                            ;; 00:1c3a $e1
    ret                                                ;; 00:1c3b $c9

; Get a uniform random number on [0,C)
; Output:
;  A = pseudo-uniform random value from [0,C)
;  DE = uniform random value on [0, 65536) correlated with A
;  B = 0
;  C unchanged
;  HL lower bits of DE*C
getRandomInRange:
    call getRandomByte
    ld E, A
    call getRandomByte
    ld D, A
    ; Intentionally let fall into MultiplyDE_by_C_24bit

; Input DE and C
; Output:
;  A = bits 23-16 of DE*C
;  HL = bits 15-0 of DE*C
;  B = 0
;  C, DE unchanged
MultiplyDE_by_C_24bit:
    ld B, $08
    xor A, A
    ld H, A
    ld L, A
.loop:
    add HL, HL
    adc A, A
    rlc C
    jr NC, .continue
    add HL, DE
    adc A, $00
.continue:
    dec B
    jr NZ, .loop
    ret

; This function updates a specific metatile in the attribute cache
; before calling drawMetatile
; A = metatile index
; DE = YX metatile position
updateMetatileAttributeCacheAndDrawImmediate:
    ld B, A

    ; Check range in X direction to allow drawing tiles offscreen for the shake effect without bugs.
    ld A, E
    cp (SCRN_X_B / 2)
    ld A, B
    jr nc, .draw_metatile

    ld A, BANK(metatilesOutdoor)
    call pushBankNrAndSwitch
    ld A, B ; need A restored for getTileInfoPointer
    push AF

    ; Load metatile attributes from the new tile
    push DE
    call getTileInfoPointer
    ld DE, $04
    add HL, DE
    ld A, [HL+]
    ld B, [HL]
    ld C, A
    pop DE

    ; Write the attributes into the correct location in the cache
    call getMetatileAttributeCacheIndex
    ld A, C
    ld [HL+], A
    ld [HL], B

    call popBankNrAndSwitch
    pop AF

.draw_metatile:
    ld HL, wRoomTiles
    jp drawMetatile

; This function caches the metatile attributes for the
; entire room before loading the tiles used in drawing.
; It relies on wRoomTiles being properly populated before this
; function is called. Otherwise there are no inputs or outputs.
cacheMetatileAttributesAndLoadRoomTiles:
    ld A, BANK(metatilesOutdoor)
    call pushBankNrAndSwitch

    ; Disable interrupts for stack pointer reuse
    ; This may be unnecessary now, but is put here
    ; as a precaution in case this function is interrupted
    ; after other code changes.
    di
    ld [wStackPointerBackup], SP

    ; Start at the end of the arrays and work backwards
    ; due to how push is implemented
    ld SP, wMetatileAttributeCache+160
    ld BC, wRoomTiles+80
    ld HL, wTileDataTablePointer
    ld A, [HL+]
    ld D, [HL]
    ld E, A
.loop:
    ; Load metatile index
    dec BC
    ld A, [BC]

    ; Locate the metatile attributes
    ; Instead of calling getTileInfoPointer optimize this to:
    ; HL=4*((4*A)+1)+DE=DE+16*A+4
    ld L, A
    ld H, $00
    add HL, HL
    add HL, HL
    inc HL
    add HL, HL
    add HL, HL
    add HL, DE

    ; Read the metatile attributes
    ld A, [HL+]
    ld H, [HL]
    ld L, A

    push HL ; write attributes to wMetatileAttributeCache

    ; Break the loop when we reach the correct low byte of wRoomTiles
    ; This works since the number of iterations is less than 256
    ld A, C
    cp A, LOW(wRoomTiles)
    jr NZ, .loop

    ; Restore the stack pointer and enable interrupts 
    ld HL, wStackPointerBackup
    ld A, [HL+]
    ld H, [HL]
    ld L, A
    ld SP, HL
    ei

    call popBankNrAndSwitch
    ld HL, wRoomTiles
    jp loadRoomTiles

scanRoomForNpcPlacementOptions_trampoline:
    jp_to_bank 11, scanRoomForNpcPlacementOptions

ds 31 ; Free space

; Speeds up script execution by whitelisting certain opcodes to ignore the limit of one opcode per frame.
speedUpScripts:
.loop:
; Check that a script is running.
    ld a, [wMainGameState]
    cp $10
    ret nz
; Check that there is still time left in the current frame.
    ldh a, [rLY]
    cp $50
    ret nc
; Check that nothing is currently moving. Bug fix for player misalignment before Shadow Knight's push.
    call checkForMovingObjects
    ret nz
; Check that the next command is in the whitelist.
    ld a, [wScriptCommand]
    ld b, a
    ld hl, .speedupList
.search:
    ld a, [hl+]
    cp b
    jr z, .run
    inc a
    jr nz, .search
    ret
.run:
    call gameStateScript.run_script_opcode
    jr .loop

.speedupList:
    db $00 ; End
    db $01 ; JR
    db $02 ; Call
    db $08 ; IfFlags
    db $0b ; IfTriggeredOnBy
    db $0c ; IfTriggeredOffBy
    db $99 ; FollowerSetPosition
    db $9c ; GiveFollower
    db $a0 ; PlayerOnChocobo
    db $a1 ; PlayerOnChocobot
    db $a2 ; PlayerOnChocobot
    db $b0 ; SetRoomTile
    db $c7 ; RNG
    db $da ; SetFlag
    db $db ; ClearFlag
    db $ec ; RunRoomScript
    db $f8 ; SetMusic
    db $ff ; Terminate list

; checks for death, increases charge bar, and handles expiring Nectar/Stamina buffs
playerHousekeeping:
    push HL                                            ;; 00:1d1b $e5
    call checkForPlayerDeath                           ;; 00:1d1c $cd $46 $3e
    pop  HL                                            ;; 00:1d1f $e1
    ld   A, [wMainGameState]                           ;; 00:1d20 $fa $a0 $c0
    or a
    ret  NZ                                            ;; 00:1d25 $c0
    push HL                                            ;; 00:1d26 $e5
    ld   HL, wWillChargeSubPoint                       ;; 00:1d27 $21 $80 $d8
    ld   A, [wStatWill]                                ;; 00:1d2a $fa $c4 $d7
    add  A, [HL]                                       ;; 00:1d2d $86
    ld   [HL], A                                       ;; 00:1d2e $77
    cp   A, $96                                        ;; 00:1d2f $fe $96
    jr   C, .jr_00_1d39                                ;; 00:1d31 $38 $06
    sub  A, $96                                        ;; 00:1d33 $d6 $96
    ld   [HL], A                                       ;; 00:1d35 $77
    call increaseWillCharge                            ;; 00:1d36 $cd $e0 $3e
.jr_00_1d39:
    pop  HL                                            ;; 00:1d39 $e1
    ld   A, [wNectarStaminaTimerNumber]                ;; 00:1d3a $fa $7e $d8
    cp   A, $ff                                        ;; 00:1d3d $fe $ff
    ret  Z                                             ;; 00:1d3f $c8
    call timerCheckExpiredOrTickAllTimers              ;; 00:1d40 $cd $0a $30
    ret  NZ                                            ;; 00:1d43 $c0

clearItemBuff:
    ld   HL, wStatStaminaBuffBackup                    ;; 00:1d44 $21 $d8 $d7
    ld   DE, wStatStamina                              ;; 00:1d47 $11 $c1 $d7
    ld   B, $04                                        ;; 00:1d4a $06 $04
.loop:
    ld   A, [HL+]                                      ;; 00:1d4c $2a
    ld   [DE], A                                       ;; 00:1d4d $12
    inc  DE                                            ;; 00:1d4e $13
    dec  B                                             ;; 00:1d4f $05
    jr   NZ, .loop                                     ;; 00:1d50 $20 $fa
    ld   A, [wNectarStaminaTimerNumber]                ;; 00:1d52 $fa $7e $d8
    call timerFree                                     ;; 00:1d55 $cd $ca $2f
    ld   A, $ff                                        ;; 00:1d58 $3e $ff
    ld   [wNectarStaminaTimerNumber], A                ;; 00:1d5a $ea $7e $d8
    ret                                                ;; 00:1d5d $c9

ds 1 ; Free space

; Store a hl and return the overridden value in a.
; Waits until PPU mode 0 (HBlank) or 1 (VBlank)
; Worst case, mode 2 (OAM scan) has enough time to finish.
; During mode 2 OAM ($fe00 to $fe9f) is inaccessible so do not use this for sprites.
; Return: a = previous value at hl, b = value written, hl = hl
storeAatHLinVRAM:
    ld b, a
    ldh a, [rLCDC]
    and LCDCF_ON
    jr z, .write
.loop:
    ldh a, [rSTAT]
    and STATF_BUSY
    jr nz, .loop
.write:
    ld a, [hl]
    ld [hl], b
    ret

ds 6 ; Free space

; Store de at hl. Waits until PPU mode 0 (HBlank) or 1 (VBlank).
; Worst case, mode 2 (OAM scan) has enough time to finish.
; During mode 2 OAM ($fe00 to $fe9f) is inaccessible so do not use this for sprites.
; Return: de = de, hl = hl + 2
storeDEinVRAM:
    ldh a, [rLCDC]
    and LCDCF_ON
    jr z, .write
.loop:
    ldh a, [rSTAT]
    and STATF_BUSY
    jr nz, .loop
.write:
    ld a, d
    ld [hl+], a
    ld [hl], e
    inc hl
    ret

ds 5 ; Free space

; Enables trampoline calls in the expansion code bank.
    CALL_FUNCTION_IN_BANK 11

ds 243 ; Free space

; This returns the currently hold joypad inputs in A and the newly pressed inputs in B
; Moved here from bank 02 to save at least one bank swap each frame.
; updateJoypadInput:
INCLUDE "code/joypad.asm"

; Enable trampoline calls in the expansion code banks.
    CALL_FUNCTION_IN_BANK 01
    CALL_FUNCTION_IN_BANK 02
    CALL_FUNCTION_IN_BANK 03
    CALL_FUNCTION_IN_BANK 04
    CALL_FUNCTION_IN_BANK 09


returnFromBankCall:
    push AF                                            ;; 00:1fc2 $f5
    push HL                                            ;; 00:1fc3 $e5
    call popBankNrAndSwitch                            ;; 00:1fc4 $cd $0a $2a
    pop  HL                                            ;; 00:1fc7 $e1
    pop  AF                                            ;; 00:1fc8 $f1
    ret                                                ;; 00:1fc9 $c9

Init:
    di                                                 ;; 00:1fca $f3
    ld sp, STARTOF("wram0") + $2000
    call DisableLCD
    call InitPreIntEnable                              ;; 00:1fce $cd $f0 $1f
    ei                                                 ;; 00:1fd1 $fb
    call titleScreenInit_trampoline                    ;; 00:1fd2 $cd $53 $31

MainLoop:
    call mainLoopPreInput                              ;; 00:1fde $cd $7b $21
    call runMainInputHandler_trampoline                ;; 00:1fe1 $cd $2c $02
    call speedUpScripts
    call mainLoopPostInput                             ;; 00:1fe4 $cd $90 $21
    call HaltLoop
    jr MainLoop

; To work around z80 halt bug(s), if wVBlankDone is zero then
; the VBlank handler pops this function's return address from the stack
; to exit the infinite halt loop.
HaltLoop:
    ld hl, wVBlankDone
    dec [hl]
    ret nz
.loop:
; Explicitly add a halt and only a halt (no nop) so that older and newer versions of rgbasm
; produce the same output.
    db $76                                             ;; halt
    jr .loop

; Do various initialization before interrupts are enabled.
InitPreIntEnable:
; Disable all interrups with the Interrupt Enable register.
    xor a
    ldh [rIE], a
; Clear RAM, except for the portion currently used by the stack.
    call clearRAM
; Clear HRAM, except for the portion currently used to save the values of registers at boot.
    call clearHRAM
; Initialize the bank stack used by trampoline calls.
    ld   HL, wBankStack                                ;; 00:2011 $21 $c0 $c0
    ld   [HL], $01                                     ;; 00:2014 $36 $01
    ld   A, L                                          ;; 00:2016 $7d
    ldh  [hBankStackPointer], A                        ;; 00:2017 $e0 $8a
; Initialize the debug logger.
    call loggerInit_trampoline
    ld   A, BANK(gfxStatusBar) ;@=bank gfxStatusBar    ;; 00:2019 $3e $08
    ld   [rROMB0], A                                   ;; 00:201b $ea $00 $20
    ld   HL, gfxStatusBar                              ;; 00:201e $21 $00 $67
    ld   DE, $8f00                                     ;; 00:2021 $11 $00 $8f
    ld   BC, $900                                      ;; 00:2024 $01 $00 $09
    call CopyHL_to_DE_size_BC                          ;; 00:2027 $cd $40 $2b
    call copyInitialVRAMTiles                          ;; 00:202a $cd $40 $21
    ld   A, $7f                                        ;; 00:202d $3e $7f
    ld   HL, _SCRN0 ;@=ptr _SCRN0                      ;; 00:202f $21 $00 $98
    ld   BC, $800                                      ;; 00:2032 $01 $00 $08
    call FillHL_with_A_times_BC                        ;; 00:2035 $cd $54 $2b
    ld   A, $00                                        ;; 00:2038 $3e $00
    ld   HL, _OAMRAM ;@=ptr _OAMRAM                    ;; 00:203a $21 $00 $fe
    ld   B, $a0                                        ;; 00:203d $06 $a0
    call fillMemory                                    ;; 00:203f $cd $5d $2b
    ld   HL, OAM_DMA_Routine                           ;; 00:2047 $21 $60 $21
    ld   DE, hOAM_DMA_Routine                          ;; 00:204a $11 $80 $ff
    ld   B, $08                                        ;; 00:204d $06 $08
    call copyHLtoDE                                    ;; 00:204f $cd $49 $2b
    ld   A, BANK(initSoundEngine) ;@=bank initSoundEngine ;; 00:2052 $3e $0f
    ld   [rROMB0], A                                   ;; 00:2054 $ea $00 $20
    call initSoundEngine                               ;; 00:2057 $cd $03 $40
IF DEF(COLOR)
    call initPalettes
ELSE
    ld   A, $e4                                        ;; 00:205a $3e $e4
    ldh  [rBGP], A                                     ;; 00:205c $e0 $47
    ld   [wVideoBGP], A                                ;; 00:205e $ea $aa $c0
    ld   A, $d0                                        ;; 00:2061 $3e $d0
    ldh  [rOBP0], A                                    ;; 00:2063 $e0 $48
    ldh  [rOBP1], A                                    ;; 00:2065 $e0 $49
    ld   [wVideoOBP0], A                               ;; 00:2067 $ea $ab $c0
    ld   [wVideoOBP1], A                               ;; 00:206a $ea $ac $c0
ENDC
    xor a
    ldh  [rIF], A                                      ;; 00:206f $e0 $0f
    ld a, P1F_GET_NONE                                 ;; 00:2071 $3e $30
    ldh [rP1], a
; Due to the halt bug(s) workaround, wVblankDone must be non-zero when the first VBlank interupt happens.
    ld a, $01
    ld   [wVBlankDone], A                              ;; 00:2078 $ea $ad $c0
    ld   [rROMB0], A                                   ;; 00:207d $ea $00 $20
    ld   A, $87                                        ;; 00:2080 $3e $87
    ld   [wVideoLCDC], A                               ;; 00:2082 $ea $a5 $c0
    call initMisc                                      ;; 00:2085 $cd $92 $20
    ld   A, IEF_VBLANK | IEF_LCDC                      ;; 00:2088 $3e $03
    ldh  [rIE], A                                      ;; 00:208a $e0 $ff
    ld   A, [wVideoLCDC]                               ;; 00:208c $fa $a5 $c0
    ldh  [rLCDC], A                                    ;; 00:208f $e0 $40
    ret                                                ;; 00:2091 $c9

IF DEF(COLOR)
; Init GBC palettes to match bios colorization.
initPalettes:
    ld a, BANK(gbc_init)
    call pushBankNrAndSwitch
    call gbc_init
    call popBankNrAndSwitch
    ret
ENDC

ds 29 ; Free space

SECTION "bank00_align_2092", ROM0[$2092]

initMisc:
    ld   A, [wVideoLCDC]                               ;; 00:2092 $fa $a5 $c0
    or   A, LCDCF_WINON | LCDCF_WIN9C00                ;; 00:2095 $f6 $60
    ld   [wVideoLCDC], A                               ;; 00:2097 $ea $a5 $c0
    call initLCDCEffect                                ;; 00:209a $cd $eb $02
    ld   A, WX_OFS                                     ;; 00:209d $3e $07
    ld   [wVideoWX], A                                 ;; 00:209f $ea $a8 $c0
    ld   A, $80                                        ;; 00:20a2 $3e $80
    ld   [wVideoWY], A                                 ;; 00:20a4 $ea $a9 $c0
    ld   A, SCRN_Y_B - 2                               ;; 00:20a7 $3e $10
    ld   [wRoomHeightInTiles], A                       ;; 00:20a9 $ea $40 $c3
    call initTimerIDsNamesAndScriptFlags               ;; 00:20ac $cd $88 $2f
    call initObjects                                   ;; 00:20af $cd $d1 $0b
    call initSpecialAttackTimer                        ;; 00:20b2 $cd $c9 $2e
    call initNpcRuntimeData                            ;; 00:20b5 $cd $e9 $27
    call initProjectileRuntimeData                     ;; 00:20b8 $cd $f2 $2b
    call bossClearObjectsTracking                      ;; 00:20bb $cd $fa $04
    call clearRoomStatusHistory                        ;; 00:20be $cd $b4 $21
    ld   DE, $fefe                                     ;; 00:20c1 $11 $fe $fe
    call createPlayerObject_trampoline                 ;; 00:20c4 $cd $50 $02
    ld   A, $00                                        ;; 00:20c7 $3e $00
    call getEquippedWeaponAnimationType_trampoline     ;; 00:20c9 $cd $d9 $2e
    call initStartingStatsAndTimers_trampoline         ;; 00:20cc $cd $bd $30
    ret                                                ;; 00:20cf $c9

;@bank 8 size=112
;@data format=pp amount=28
; List graphics to load into VRAM at startup. Copies 1 tile from 2nd pointer in bank8 to VRAM first pointer
initialVRAMLoad:
    dw   $8040, gfxBlankTiles08                        ;; 00:20d0 pP.. $00
    dw   $8050, gfxBlankTiles08                        ;; 00:20d4 pP.. $01
    dw   $8060, gfxBlankTiles08                        ;; 00:20d8 pP.. $02
    dw   $8070, gfxBlankTiles08                        ;; 00:20dc pP.. $03
    dw   $8100, gfxBlankTiles08                        ;; 00:20e0 pP.. $04
    dw   $8110, gfxBlankTiles08                        ;; 00:20e4 pP.. $05
    dw   $8120, gfxHand                                ;; 00:20e8 pP.. $06
    dw   $8130, gfxHand + $20                          ;; 00:20ec pP.. $07
    dw   $8140, gfxHand + $10                          ;; 00:20f0 pP.. $08
    dw   $8150, gfxHand + $30                          ;; 00:20f4 pP.. $09
    dw   $8160, gfxHand + $40                          ;; 00:20f8 pP.. $0a
    dw   $8170, gfxHand + $30                          ;; 00:20fc pP.. $0b
    dw   $8700, gfxHand + $50                          ;; 00:2100 .P.. $0c
    dw   $8710, gfxHand + $70                          ;; 00:2104 pP.. $0d
    dw   $8720, gfxHand + $60                          ;; 00:2108 pP.. $0e
    dw   $8730, gfxHand + $80                          ;; 00:210c pP.. $0f
    dw   $8740, gfxSnowman                             ;; 00:2110 pP.. $10
    dw   $8750, gfxSnowman + $20                       ;; 00:2114 pP.. $11
    dw   $8760, gfxSnowman + $10                       ;; 00:2118 pP.. $12
    dw   $8770, gfxSnowman + $30                       ;; 00:211c pP.. $13
    dw   $8780, gfxChest                               ;; 00:2120 pP.. $14
    dw   $8790, gfxChest + $20                         ;; 00:2124 pP.. $15
    dw   $87a0, gfxChest + $10                         ;; 00:2128 pP.. $16
    dw   $87b0, gfxChest + $30                         ;; 00:212c pP.. $17
    dw   $87c0, gfxChest + $40                         ;; 00:2130 pP.. $18
    dw   $87d0, gfxChest + $20                         ;; 00:2134 pP.. $19
    dw   $87e0, gfxChest + $50                         ;; 00:2138 pP.. $1a
    dw   $87f0, gfxChest + $30                         ;; 00:213c pP.. $1b

copyInitialVRAMTiles:
    ld   A, BANK(gfxHand) ;@=bank gfxHand              ;; 00:2140 $3e $08
    ld   [rROMB0], A                                   ;; 00:2142 $ea $00 $20
    ld   HL, initialVRAMLoad                           ;; 00:2145 $21 $d0 $20
    ld   B, $1c                                        ;; 00:2148 $06 $1c
.loop:
    push BC                                            ;; 00:214a $c5
    ld   E, [HL]                                       ;; 00:214b $5e
    inc  HL                                            ;; 00:214c $23
    ld   D, [HL]                                       ;; 00:214d $56
    inc  HL                                            ;; 00:214e $23
    push HL                                            ;; 00:214f $e5
    ld   A, [HL+]                                      ;; 00:2150 $2a
    ld   H, [HL]                                       ;; 00:2151 $66
    ld   L, A                                          ;; 00:2152 $6f
    ld   B, $10                                        ;; 00:2153 $06 $10
    call copyHLtoDE                                    ;; 00:2155 $cd $49 $2b
    pop  HL                                            ;; 00:2158 $e1
    inc  HL                                            ;; 00:2159 $23
    inc  HL                                            ;; 00:215a $23
    pop  BC                                            ;; 00:215b $c1
    dec  B                                             ;; 00:215c $05
    jr   NZ, .loop                                     ;; 00:215d $20 $eb
    ret                                                ;; 00:215f $c9

OAM_DMA_Routine:
    db   $e0, $46, $3e, $28, $3d, $20, $fd, $c9        ;; 00:2160 ........

DisableLCD:
    ldh  A, [rLY]                                      ;; 00:2168 $f0 $44
    cp   A, $92                                        ;; 00:216a $fe $92
    jr   NC, DisableLCD                                ;; 00:216c $30 $fa
.loop:
    ldh  A, [rLY]                                      ;; 00:216e $f0 $44
    cp   A, $92                                        ;; 00:2170 $fe $92
    jr   C, .loop                                      ;; 00:2172 $38 $fa
    ldh  A, [rLCDC]                                    ;; 00:2174 $f0 $40
    and  A, $7f                                        ;; 00:2176 $e6 $7f
    ldh  [rLCDC], A                                    ;; 00:2178 $e0 $40
    ret                                                ;; 00:217a $c9

mainLoopPreInput:
    ld   A, BANK(runSoundEngine) ;@=bank runSoundEngine ;; 00:217b $3e $0f
    call pushBankNrAndSwitch                           ;; 00:217d $cd $fb $29
    call runSoundEngine                                ;; 00:2180 $cd $00 $40
    call popBankNrAndSwitch                            ;; 00:2183 $cd $0a $2a
    call spriteShuffleShowHidden_trampoline            ;; 00:2186 $cd $47 $04
    ld   A, [wMainGameStateFlags.nextFrame]            ;; 00:2189 $fa $a2 $c0
    ld   [wMainGameStateFlags], A                      ;; 00:218c $ea $a1 $c0
    ret                                                ;; 00:218f $c9

mainLoopPostInput:
    call spriteShuffleDoFlash_trampoline               ;; 00:2192 $cd $3b $04
    call animateTiles_trampoline                       ;; 00:2195 $cd $70 $1a
    call runRoomScriptIfAllEnemiesDefeated_trampoline  ;; 00:2198 $cd $1a $29
    call startScriptIfRequested                        ;; 00:219b $cd $8f $31
    call playerHousekeeping                            ;; 00:219e $cd $1b $1d
; Stop leveling at 99.
    ld a, [wLevel]
    cp a, $63
    call nz, checkForLevelUp
    call updateStatusEffects_trampoline                ;; 00:21a4 $cd $3b $31
    ld   A, $ff                                        ;; 00:21a7 $3e $ff
    call timerCheckExpiredOrTickAllTimers              ;; 00:21a9 $cd $0a $30
    ret

ds 4 ; Free space

clearRoomStatusHistory:
    ld   HL, wRoomClearedStatus                        ;; 00:21b4 $21 $00 $c4
    ld   B, $80                                        ;; 00:21b7 $06 $80
    ld   A, $ff                                        ;; 00:21b9 $3e $ff
    call fillMemory                                    ;; 00:21bb $cd $5d $2b
    ret                                                ;; 00:21be $c9

getRoomClearedStatusAndUpdateList:
    ld   C, A                                          ;; 00:21bf $4f
    ld   E, A                                          ;; 00:21c0 $5f
    ld   HL, wRoomClearedStatus                        ;; 00:21c1 $21 $00 $c4
    ld   B, $40                                        ;; 00:21c4 $06 $40
    ld   A, [wMapNumber]                               ;; 00:21c6 $fa $f5 $c3
    ld   D, A                                          ;; 00:21c9 $57
.loop:
    ld   A, D                                          ;; 00:21ca $7a
    ld   D, [HL]                                       ;; 00:21cb $56
    ld   [HL+], A                                      ;; 00:21cc $22
    ld   A, E                                          ;; 00:21cd $7b
    ld   E, [HL]                                       ;; 00:21ce $5e
    ld   [HL+], A                                      ;; 00:21cf $22
    ld   A, [wMapNumber]                               ;; 00:21d0 $fa $f5 $c3
    xor  A, D                                          ;; 00:21d3 $aa
    and  A, $7f                                        ;; 00:21d4 $e6 $7f
    jr   NZ, .jr_00_21dc                               ;; 00:21d6 $20 $04
    ld   A, C                                          ;; 00:21d8 $79
    cp   A, E                                          ;; 00:21d9 $bb
    jr   Z, .jr_00_21e0                                ;; 00:21da $28 $04
.jr_00_21dc:
    dec  B                                             ;; 00:21dc $05
    jr   NZ, .loop                                     ;; 00:21dd $20 $eb
    ret                                                ;; 00:21df $c9
.jr_00_21e0:
    ld   A, D                                          ;; 00:21e0 $7a
    ld   [wRoomClearedStatus], A                       ;; 00:21e1 $ea $00 $c4
    bit  7, A                                          ;; 00:21e4 $cb $7f
    ret  Z                                             ;; 00:21e6 $c8
    ld   A, B                                          ;; 00:21e7 $78
    cp   A, $3d                                        ;; 00:21e8 $fe $3d
    jr   NC, .jr_00_21f3                               ;; 00:21ea $30 $07
    ld   HL, wRoomClearedStatus                        ;; 00:21ec $21 $00 $c4
    res  7, [HL]                                       ;; 00:21ef $cb $be
    xor  A, A                                          ;; 00:21f1 $af
    ret                                                ;; 00:21f2 $c9
.jr_00_21f3:
    xor  A, A                                          ;; 00:21f3 $af
    dec  A                                             ;; 00:21f4 $3d
    ret                                                ;; 00:21f5 $c9

checkRoomVisited:
    ld   B, $40                                        ;; 00:21f6 $06 $40
    ld   HL, wRoomClearedStatus                        ;; 00:21f8 $21 $00 $c4
.loop:
    ld   A, [HL+]                                      ;; 00:21fb $2a
    and  A, $7f                                        ;; 00:21fc $e6 $7f
    cp   A, D                                          ;; 00:21fe $ba
    jr   NZ, .next                                     ;; 00:21ff $20 $03
    ld   A, [HL]                                       ;; 00:2201 $7e
    cp   A, E                                          ;; 00:2202 $bb
    ret  Z                                             ;; 00:2203 $c8
.next:
    inc  HL                                            ;; 00:2204 $23
    dec  B                                             ;; 00:2205 $05
    jr   NZ, .loop                                     ;; 00:2206 $20 $f3
    dec  B                                             ;; 00:2208 $05
    ret                                                ;; 00:2209 $c9

ds 4 ; Free space

LoadRoomXY_to_A:
    ld   A, [wRoomX]                                   ;; 00:220e $fa $f6 $c3
    and  A, $0f                                        ;; 00:2211 $e6 $0f
    swap A                                             ;; 00:2213 $cb $37
    ld   C, A                                          ;; 00:2215 $4f
    ld   A, [wRoomY]                                   ;; 00:2216 $fa $f7 $c3
    and  A, $0f                                        ;; 00:2219 $e6 $0f
    or   A, C                                          ;; 00:221b $b1
    ret                                                ;; 00:221c $c9

; Offsets into wRoomTiles for door metatiles, and the xy  coordinates of each
;@data amount=4 format=ppbbbb
doorMetatileLocation:
    data_ppbbbb $c39b, $c39a, $05, $07, $04, $07       ;; 00:221d pPpP.... $00
.north:
    data_ppbbbb $c355, $c354, $05, $00, $04, $00       ;; 00:2225 pPpP.... $01
.west:
    data_ppbbbb $c378, $c36e, $00, $04, $00, $03       ;; 00:222d pPpP.... $02
.east:
    data_ppbbbb $c381, $c377, $09, $04, $09, $03       ;; 00:2235 pPpP.... $03
    db   $9b, $c3, $9a, $c3, $05, $08, $04, $08        ;; 00:223d ????....
    db   $55, $c3, $54, $c3, $05, $ff, $04, $ff        ;; 00:2245 ????....
    db   $78, $c3, $6e, $c3, $ff, $04, $ff, $03        ;; 00:224d ????.?.?
    db   $81, $c3, $77, $c3, $0a, $04, $0a, $03        ;; 00:2255 ????...?

; A is direction, E=1, W=2, N=4, S=8
; Return: HL = pointer to offsets into wRoomTiles for door metatiles:
; Return: C = direction bit number
getDoorLocationPointers:
    ld   HL, doorMetatileLocation                      ;; 00:225d $21 $1d $22
    bit  0, A                                          ;; 00:2260 $cb $47
    jr   NZ, .east                                     ;; 00:2262 $20 $0b
    bit  1, A                                          ;; 00:2264 $cb $4f
    jr   NZ, .west                                     ;; 00:2266 $20 $0d
    bit  2, A                                          ;; 00:2268 $cb $57
    jr   NZ, .north                                    ;; 00:226a $20 $0f
    ld   C, $03                                        ;; 00:226c $0e $03
    ret                                                ;; 00:226e $c9
.east:
    ld   HL, doorMetatileLocation.east                 ;; 00:226f $21 $35 $22
    ld   C, $00                                        ;; 00:2272 $0e $00
    ret                                                ;; 00:2274 $c9
.west:
    ld   HL, doorMetatileLocation.west                 ;; 00:2275 $21 $2d $22
    ld   C, $01                                        ;; 00:2278 $0e $01
    ret                                                ;; 00:227a $c9
.north:
    ld   HL, doorMetatileLocation.north                ;; 00:227b $21 $25 $22
    ld   C, $02                                        ;; 00:227e $0e $02
    ret                                                ;; 00:2280 $c9

; Draws a door open or closed
; DE = pointer to offsets into wRoomTiles for door metatiles
; HL = offset into the map's door metatile data
drawDoorMetatiles:
    push DE                                            ;; 00:2281 $d5
    ld   A, [wMapTablePointer.high]                    ;; 00:2282 $fa $f3 $c3
    ld   D, A                                          ;; 00:2285 $57
    ld   A, [wMapTablePointer]                         ;; 00:2286 $fa $f2 $c3
    ld   E, A                                          ;; 00:2289 $5f
    inc  DE                                            ;; 00:228a $13
    inc  DE                                            ;; 00:228b $13
    add  HL, DE                                        ;; 00:228c $19
    ld   A, [HL+]                                      ;; 00:228d $2a
    ld   B, A                                          ;; 00:228e $47
    ld   C, [HL]                                       ;; 00:228f $4e
    pop  HL                                            ;; 00:2290 $e1
    ld   E, [HL]                                       ;; 00:2291 $5e
    inc  HL                                            ;; 00:2292 $23
    ld   D, [HL]                                       ;; 00:2293 $56
    inc  HL                                            ;; 00:2294 $23
    ld   A, C                                          ;; 00:2295 $79
    ld   [DE], A                                       ;; 00:2296 $12
    ld   E, [HL]                                       ;; 00:2297 $5e
    inc  HL                                            ;; 00:2298 $23
    ld   D, [HL]                                       ;; 00:2299 $56
    inc  HL                                            ;; 00:229a $23
    ld   A, B                                          ;; 00:229b $78
    ld   [DE], A                                       ;; 00:229c $12
    push HL                                            ;; 00:229d $e5
    push BC                                            ;; 00:229e $c5
    ld   HL, wRoomTiles                                ;; 00:229f $21 $50 $c3
    call loadRoomTiles                                 ;; 00:22a2 $cd $74 $1b
    pop  BC                                            ;; 00:22a5 $c1
    pop  HL                                            ;; 00:22a6 $e1
    ld   E, [HL]                                       ;; 00:22a7 $5e
    inc  HL                                            ;; 00:22a8 $23
    ld   D, [HL]                                       ;; 00:22a9 $56
    inc  HL                                            ;; 00:22aa $23
    ld   A, C                                          ;; 00:22ab $79
    push HL                                            ;; 00:22ac $e5
    push BC                                            ;; 00:22ad $c5
    call updateMetatileAttributeCacheAndDrawImmediate
    pop  BC                                            ;; 00:22b1 $c1
    pop  HL                                            ;; 00:22b2 $e1
    ld   E, [HL]                                       ;; 00:22b3 $5e
    inc  HL                                            ;; 00:22b4 $23
    ld   D, [HL]                                       ;; 00:22b5 $56
    ld   A, B                                          ;; 00:22b6 $78
    call updateMetatileAttributeCacheAndDrawImmediate
    ret                                                ;; 00:22ba $c9

call_00_22bb:
    push BC                                            ;; 00:22bb $c5
    call GetObjectY                                    ;; 00:22bc $cd $3e $0c
    ld   D, A                                          ;; 00:22bf $57
    pop  BC                                            ;; 00:22c0 $c1
    push BC                                            ;; 00:22c1 $c5
    push DE                                            ;; 00:22c2 $d5
    call GetObjectX                                    ;; 00:22c3 $cd $2d $0c
    pop  DE                                            ;; 00:22c6 $d1
    ld   E, A                                          ;; 00:22c7 $5f
    pop  BC                                            ;; 00:22c8 $c1
    bit  0, B                                          ;; 00:22c9 $cb $40
    jr   NZ, .jr_00_22de                               ;; 00:22cb $20 $11
    bit  1, B                                          ;; 00:22cd $cb $48
    jr   NZ, .jr_00_22e7                               ;; 00:22cf $20 $16
    bit  2, B                                          ;; 00:22d1 $cb $50
    jr   NZ, .jr_00_22f0                               ;; 00:22d3 $20 $1b
    ld   A, D                                          ;; 00:22d5 $7a
    cp   A, $18                                        ;; 00:22d6 $fe $18
    jr   NC, .jr_00_22f9                               ;; 00:22d8 $30 $1f
    ld   D, $18                                        ;; 00:22da $16 $18
    jr   .jr_00_22fc                                   ;; 00:22dc $18 $1e
.jr_00_22de:
    ld   A, E                                          ;; 00:22de $7b
    cp   A, $18                                        ;; 00:22df $fe $18
    jr   NC, .jr_00_22f9                               ;; 00:22e1 $30 $16
    ld   E, $18                                        ;; 00:22e3 $1e $18
    jr   .jr_00_22fc                                   ;; 00:22e5 $18 $15
.jr_00_22e7:
    ld   A, E                                          ;; 00:22e7 $7b
    cp   A, $89                                        ;; 00:22e8 $fe $89
    jr   C, .jr_00_22f9                                ;; 00:22ea $38 $0d
    ld   E, $88                                        ;; 00:22ec $1e $88
    jr   .jr_00_22fc                                   ;; 00:22ee $18 $0c
.jr_00_22f0:
    ld   A, D                                          ;; 00:22f0 $7a
    cp   A, $71                                        ;; 00:22f1 $fe $71
    jr   C, .jr_00_22f9                                ;; 00:22f3 $38 $04
    ld   D, $70                                        ;; 00:22f5 $16 $70
    jr   .jr_00_22fc                                   ;; 00:22f7 $18 $03
.jr_00_22f9:
    xor  A, A                                          ;; 00:22f9 $af
    dec  A                                             ;; 00:22fa $3d
    ret                                                ;; 00:22fb $c9
.jr_00_22fc:
    xor  A, A                                          ;; 00:22fc $af
    ret                                                ;; 00:22fd $c9

; A is direction, E=1, W=2, N=4, S=8
closeDoor:
    push AF                                            ;; 00:22fe $f5
    ld   A, [wMapEncodingType]                         ;; 00:22ff $fa $f8 $c3
    cp   A, $00                                        ;; 00:2302 $fe $00
    jr   Z, .unsupported                               ;; 00:2304 $28 $53
    ld   A, [wMapTableBankNr]                          ;; 00:2306 $fa $f0 $c3
    call pushBankNrAndSwitch                           ;; 00:2309 $cd $fb $29
    pop  AF                                            ;; 00:230c $f1
    push AF                                            ;; 00:230d $f5
    cpl                                                ;; 00:230e $2f
    ld   C, A                                          ;; 00:230f $4f
    ld   A, [wDoorStates]                              ;; 00:2310 $fa $f4 $c3
    and  A, C                                          ;; 00:2313 $a1
    ld   [wDoorStates], A                              ;; 00:2314 $ea $f4 $c3
    ld   A, C                                          ;; 00:2317 $79
    cpl                                                ;; 00:2318 $2f
    call getDoorLocationPointers                       ;; 00:2319 $cd $5d $22
    push HL                                            ;; 00:231c $e5
    ld   A, [wRoomTileDataPointer.high]                ;; 00:231d $fa $fd $c3
    ld   H, A                                          ;; 00:2320 $67
    ld   A, [wRoomTileDataPointer]                     ;; 00:2321 $fa $fc $c3
    ld   L, A                                          ;; 00:2324 $6f
    ld   B, $00                                        ;; 00:2325 $06 $00
    add  HL, BC                                        ;; 00:2327 $09
    ld   A, [HL]                                       ;; 00:2328 $7e
    and  A, $03                                        ;; 00:2329 $e6 $03
    add  A, A                                          ;; 00:232b $87
    add  A, A                                          ;; 00:232c $87
    add  A, A                                          ;; 00:232d $87
    ld   L, A                                          ;; 00:232e $6f
    ld   H, $00                                        ;; 00:232f $26 $00
    add  HL, BC                                        ;; 00:2331 $09
    add  HL, BC                                        ;; 00:2332 $09
    pop  DE                                            ;; 00:2333 $d1
    call drawDoorMetatiles                             ;; 00:2334 $cd $81 $22
    pop  AF                                            ;; 00:2337 $f1
    call objectReverseDirection                        ;; 00:2338 $cd $e4 $29
    ld   B, A                                          ;; 00:233b $47
    ld   C, $04                                        ;; 00:233c $0e $04
    call call_00_22bb                                  ;; 00:233e $cd $bb $22
    ld   A, B                                          ;; 00:2341 $78
    push BC                                            ;; 00:2342 $c5
    call Z, updatePlayerPostion_trampoline             ;; 00:2343 $cc $3e $02
    call checkForFollower                              ;; 00:2346 $cd $c2 $28
    pop  BC                                            ;; 00:2349 $c1
    ld   C, $07                                        ;; 00:234a $0e $07
    call Z, call_00_22bb                               ;; 00:234c $cc $bb $22
    ld   A, B                                          ;; 00:234f $78
    ld   B, $00                                        ;; 00:2350 $06 $00
    call Z, updateObjectPosition_3_trampoline          ;; 00:2352 $cc $8f $28
    call popBankNrAndSwitch                            ;; 00:2355 $cd $0a $2a
    ret                                                ;; 00:2358 $c9
.unsupported:
    pop  AF                                            ;; 00:2359 $f1
    ret                                                ;; 00:235a $c9

; A is direction, E=1, W=2, N=4, S=8
openDoor:
    push AF                                            ;; 00:235b $f5
    ld   A, [wMapEncodingType]                         ;; 00:235c $fa $f8 $c3
    cp   A, $00                                        ;; 00:235f $fe $00
    jr   Z, .unsupported                               ;; 00:2361 $28 $20
    ld   A, [wMapTableBankNr]                          ;; 00:2363 $fa $f0 $c3
    call pushBankNrAndSwitch                           ;; 00:2366 $cd $fb $29
    pop  AF                                            ;; 00:2369 $f1
    ld   C, A                                          ;; 00:236a $4f
    ld   A, [wDoorStates]                              ;; 00:236b $fa $f4 $c3
    or   A, C                                          ;; 00:236e $b1
    ld   [wDoorStates], A                              ;; 00:236f $ea $f4 $c3
    ld   A, C                                          ;; 00:2372 $79
    call getDoorLocationPointers                       ;; 00:2373 $cd $5d $22
    ld   E, L                                          ;; 00:2376 $5d
    ld   D, H                                          ;; 00:2377 $54
    ld   L, C                                          ;; 00:2378 $69
    ld   H, $00                                        ;; 00:2379 $26 $00
    add  HL, HL                                        ;; 00:237b $29
    call drawDoorMetatiles                             ;; 00:237c $cd $81 $22
    call popBankNrAndSwitch                            ;; 00:237f $cd $0a $2a
    ret                                                ;; 00:2382 $c9
.unsupported:
    pop  AF                                            ;; 00:2383 $f1
    ret                                                ;; 00:2384 $c9

; D = y metatile coordinate
; E = x metatile coordinate
; Return: If true, Z, A = direction bit number (0 = e, 1 = w, 2 = n, 3 = s), C = bit 7 set if second metatile and lower nibble direction value
; Return: if false, NZ, A = $ff, C = 8
checkMovingInPossibleDoorLocation:
    ld   C, $08                                        ;; 00:2385 $0e $08
    ld   B, $08                                        ;; 00:2387 $06 $08
    ld   HL, doorMetatileLocation + $04                ;; 00:2389 $21 $21 $22
.loop:
    ld   A, [HL+]                                      ;; 00:238c $2a
    cp   A, E                                          ;; 00:238d $bb
    jr   NZ, .jr_00_2394                               ;; 00:238e $20 $04
    ld   A, [HL]                                       ;; 00:2390 $7e
    cp   A, D                                          ;; 00:2391 $ba
    jr   Z, .true                                      ;; 00:2392 $28 $1e
.jr_00_2394:
    inc  HL                                            ;; 00:2394 $23
    set  7, C                                          ;; 00:2395 $cb $f9
    ld   A, [HL+]                                      ;; 00:2397 $2a
    cp   A, E                                          ;; 00:2398 $bb
    jr   NZ, .jr_00_239f                               ;; 00:2399 $20 $04
    ld   A, [HL]                                       ;; 00:239b $7e
    cp   A, D                                          ;; 00:239c $ba
    jr   Z, .true                                      ;; 00:239d $28 $13
.jr_00_239f:
    inc  HL                                            ;; 00:239f $23
    inc  HL                                            ;; 00:23a0 $23
    inc  HL                                            ;; 00:23a1 $23
    inc  HL                                            ;; 00:23a2 $23
    inc  HL                                            ;; 00:23a3 $23
    res  7, C                                          ;; 00:23a4 $cb $b9
    srl  C                                             ;; 00:23a6 $cb $39
    jr   NC, .jr_00_23ac                               ;; 00:23a8 $30 $02
    ld   C, $08                                        ;; 00:23aa $0e $08
.jr_00_23ac:
    dec  B                                             ;; 00:23ac $05
    jr   NZ, .loop                                     ;; 00:23ad $20 $dd
    xor  A, A                                          ;; 00:23af $af
    inc  A                                             ;; 00:23b0 $3c
    ret                                                ;; 00:23b1 $c9
.true:
    ld   A, B                                          ;; 00:23b2 $78
    dec  A                                             ;; 00:23b3 $3d
    and  A, $03                                        ;; 00:23b4 $e6 $03
    bit  7, A                                          ;; 00:23b6 $cb $7f
    ret                                                ;; 00:23b8 $c9

; D = y metatile coordinate
; E = x metatile coordinate
; Return:
; If not a possible door location: NZ, A = 1, B = 0, C = 8
; If it is listed as open: Z, A = 0, B = 0, C = bit 7 set if second metatile and lower nibble direction value
; Otherwise: Z, A = 0, B = initial value from map data, C = bit 7 set if second metatile and lower nibble direction value
getDoorStatus:
    ld   A, [wMapEncodingType]                         ;; 00:23b9 $fa $f8 $c3
    cp   A, $00                                        ;; 00:23bc $fe $00
    ld   B, $00                                        ;; 00:23be $06 $00
    ret  Z                                             ;; 00:23c0 $c8
    push DE                                            ;; 00:23c1 $d5
    ld   A, [wMapTableBankNr]                          ;; 00:23c2 $fa $f0 $c3
    call pushBankNrAndSwitch                           ;; 00:23c5 $cd $fb $29
    pop  DE                                            ;; 00:23c8 $d1
    call checkMovingInPossibleDoorLocation             ;; 00:23c9 $cd $85 $23
    jr   NZ, .not_possible_door_location               ;; 00:23cc $20 $1c
    ld   E, A                                          ;; 00:23ce $5f
    ld   D, $00                                        ;; 00:23cf $16 $00
    ld   B, $00                                        ;; 00:23d1 $06 $00
    ld   A, [wDoorStates]                              ;; 00:23d3 $fa $f4 $c3
    and  A, C                                          ;; 00:23d6 $a1
    jr   NZ, .jr_00_23e3                               ;; 00:23d7 $20 $0a
; If it's not marked as open in door states, get its initial value from the map.
    ld   A, [wRoomTileDataPointer.high]                ;; 00:23d9 $fa $fd $c3
    ld   H, A                                          ;; 00:23dc $67
    ld   A, [wRoomTileDataPointer]                     ;; 00:23dd $fa $fc $c3
    ld   L, A                                          ;; 00:23e0 $6f
    add  HL, DE                                        ;; 00:23e1 $19
    ld   B, [HL]                                       ;; 00:23e2 $46
.jr_00_23e3:
    push BC                                            ;; 00:23e3 $c5
    call popBankNrAndSwitch                            ;; 00:23e4 $cd $0a $2a
    pop  BC                                            ;; 00:23e7 $c1
    xor  A, A                                          ;; 00:23e8 $af
    ret                                                ;; 00:23e9 $c9
.not_possible_door_location:
    call popBankNrAndSwitch                            ;; 00:23ea $cd $0a $2a
    xor  A, A                                          ;; 00:23ed $af
    ld   B, A                                          ;; 00:23ee $47
    inc  A                                             ;; 00:23ef $3c
    ret                                                ;; 00:23f0 $c9

; Param: DE = XY position
; Return: HL = pointer to metatile
getRoomMetatilePointer:
    ld   HL, wRoomTiles                                ;; 00:23f1 $21 $50 $c3
    ld   A, D                                          ;; 00:23f4 $7a
    add  A, A                                          ;; 00:23f5 $87
    ld   C, A                                          ;; 00:23f6 $4f
    add  A, A                                          ;; 00:23f7 $87
    add  A, A                                          ;; 00:23f8 $87
    add  A, C                                          ;; 00:23f9 $81
    add  A, E                                          ;; 00:23fa $83
    ld   E, A                                          ;; 00:23fb $5f
    ld   D, $00                                        ;; 00:23fc $16 $00
    add  HL, DE                                        ;; 00:23fe $19
    ret                                                ;; 00:23ff $c9

; Set room tile:
; A = meta tile number
; DE = XY position
setRoomTile:
    push AF                                            ;; 00:2400 $f5
    push DE                                            ;; 00:2401 $d5
    ld   A, [wMapTableBankNr]                          ;; 00:2402 $fa $f0 $c3
    call pushBankNrAndSwitch                           ;; 00:2405 $cd $fb $29
    pop  DE                                            ;; 00:2408 $d1
    push DE                                            ;; 00:2409 $d5
    call getRoomMetatilePointer                        ;; 00:240a $cd $f1 $23
    pop  DE                                            ;; 00:240d $d1
    pop  AF                                            ;; 00:240e $f1
    ld   [HL], A                                       ;; 00:240f $77
    push AF                                            ;; 00:2410 $f5
    push DE                                            ;; 00:2411 $d5
    call mapGraphicsStateCheckCache                    ;; 00:2412 $cd $44 $1a
    jr   Z, .jr_00_241d                                ;; 00:2415 $28 $06
    ld   HL, wRoomTiles                                ;; 00:2417 $21 $50 $c3
    call loadRoomTiles                                 ;; 00:241a $cd $74 $1b
.jr_00_241d:
    pop  DE                                            ;; 00:241d $d1
    pop  AF                                            ;; 00:241e $f1
    call updateMetatileAttributeCacheAndDrawImmediate
    call popBankNrAndSwitch                            ;; 00:2422 $cd $0a $2a
    ret                                                ;; 00:2425 $c9

; Param: DE = XY position
; Return: A = meta tile number
getRoomMetatile:
    call getRoomMetatilePointer                        ;; 00:2426 $cd $f1 $23
    ld   A, [HL]                                       ;; 00:2429 $7e
    ret                                                ;; 00:242a $c9

; Load the metatiles from run-length encoding (RLE) data at HL into wRoomTiles.
; hl = address of the RLE compressed room metatiles
; Return: hl = address of the room tile array
loadRoomMetatilesRLE:
    push HL                                            ;; 00:242b $e5
    ld   A, $07                                        ;; 00:242c $3e $07
    call clearScriptFlag                               ;; 00:242e $cd $ee $3b
    call LoadRoomXY_to_A                               ;; 00:2431 $cd $0e $22
    call getRoomClearedStatusAndUpdateList             ;; 00:2434 $cd $bf $21
    ld   A, $07                                        ;; 00:2437 $3e $07
    call NZ, setScriptFlag                             ;; 00:2439 $c4 $e4 $3b
    pop  DE                                            ;; 00:243c $d1
    ld   HL, wRoomTiles                                ;; 00:243d $21 $50 $c3
    ld   B, $50                                        ;; 00:2440 $06 $50
; Maps (aside from caves and indoors) are RLE compressed.
; Even with rom expansion this is needed for the worldmap because it is too large to fit in one bank.
; The original compression limited the maximum number of metatiles to 128.
; The new compression increases this limit to 247 (or all the way to 255 if you are very careful).

; Maps are compressed in ten byte chunks of metatile ids.
; One or more bytes of literal metatile ids may be followed by a repeat value.
; Repeat values must either be followed by a literal or end at a ten byte boundary.
; Repeat values are any byte following a literal which is greater than $f7.
; They repeat the previous literal two to nine times (creating a run from three to ten bytes total).
; The value $f8 repeats the previously output literal two times (for a run of three bytes total).
; The value $ff repeats the previously output literal nine times (for a run of ten bytes total).
    ld a, [de]
    jr .literal
.loop:
    ld a, [de]
    cp $f8
    jr c, .literal
    sub $f7
    ld c, a
    ; Adjust the loop counter all at once for repetitions.
    ld a, b
    sub c
    ld b, a
    ; Reload the previous littoral value.
    dec hl
    ld a, [hl+]
.repeat:
    ld [hl+], a
    dec c
    jr nz, .repeat
.literal:
    inc de
    ld [hl+], a
    dec b
    jr nz, .loop
    ld   HL, wRoomTiles                                ;; 00:245c $21 $50 $c3
    ret                                                ;; 00:245f $c9

runRoomScriptOnRoomEnter:
    ld   A, [wMapTableBankNr]                          ;; 00:2460 $fa $f0 $c3
    call pushBankNrAndSwitch                           ;; 00:2463 $cd $fb $29
    ld   A, [wRoomScriptTableHigh]                     ;; 00:2466 $fa $ff $c3
    ld   H, A                                          ;; 00:2469 $67
    ld   A, [wRoomScriptTableLow]                      ;; 00:246a $fa $fe $c3
    ld   L, A                                          ;; 00:246d $6f
    ld   A, [HL+]                                      ;; 00:246e $2a
    ld   H, [HL]                                       ;; 00:246f $66
    ld   L, A                                          ;; 00:2470 $6f
    push HL                                            ;; 00:2471 $e5
    call getPlayerDirection                            ;; 00:2472 $cd $ab $02
    and  A, $0f                                        ;; 00:2475 $e6 $0f
    or   A, $00                                        ;; 00:2477 $f6 $00
    ld   C, $c9                                        ;; 00:2479 $0e $c9
    pop  HL                                            ;; 00:247b $e1
    call runScriptByIndex                              ;; 00:247c $cd $ad $31
    call popBankNrAndSwitch                            ;; 00:247f $cd $0a $2a
    ret                                                ;; 00:2482 $c9

runRoomScriptOnRoomExit:
    ld   A, [wMapTableBankNr]                          ;; 00:2483 $fa $f0 $c3
    call pushBankNrAndSwitch                           ;; 00:2486 $cd $fb $29
    ld   A, [wRoomScriptTableHigh]                     ;; 00:2489 $fa $ff $c3
    ld   H, A                                          ;; 00:248c $67
    ld   A, [wRoomScriptTableLow]                      ;; 00:248d $fa $fe $c3
    ld   L, A                                          ;; 00:2490 $6f
    ld   A, [HL+]                                      ;; 00:2491 $2a
    ld   H, [HL]                                       ;; 00:2492 $66
    ld   L, A                                          ;; 00:2493 $6f
    inc  HL                                            ;; 00:2494 $23
    push HL                                            ;; 00:2495 $e5
    call getPlayerDirection                            ;; 00:2496 $cd $ab $02
    and  A, $0f                                        ;; 00:2499 $e6 $0f
    or   A, $00                                        ;; 00:249b $f6 $00
    ld   C, $c9                                        ;; 00:249d $0e $c9
    pop  HL                                            ;; 00:249f $e1
    call runScriptByIndex                              ;; 00:24a0 $cd $ad $31
    call popBankNrAndSwitch                            ;; 00:24a3 $cd $0a $2a
    ret                                                ;; 00:24a6 $c9

runRoomScriptOnAllEnemiesDefeated:
    ld   A, [wRoomClearedStatus]                       ;; 00:24a7 $fa $00 $c4
    set  7, A                                          ;; 00:24aa $cb $ff
    ld   [wRoomClearedStatus], A                       ;; 00:24ac $ea $00 $c4
    ld   A, [wMapTableBankNr]                          ;; 00:24af $fa $f0 $c3
    call pushBankNrAndSwitch                           ;; 00:24b2 $cd $fb $29
    ld   A, [wRoomScriptTableHigh]                     ;; 00:24b5 $fa $ff $c3
    ld   H, A                                          ;; 00:24b8 $67
    ld   A, [wRoomScriptTableLow]                      ;; 00:24b9 $fa $fe $c3
    ld   L, A                                          ;; 00:24bc $6f
    ld   A, [HL+]                                      ;; 00:24bd $2a
    ld   H, [HL]                                       ;; 00:24be $66
    ld   L, A                                          ;; 00:24bf $6f
    inc  HL                                            ;; 00:24c0 $23
    inc  HL                                            ;; 00:24c1 $23
    push HL                                            ;; 00:24c2 $e5
    call getPlayerDirection                            ;; 00:24c3 $cd $ab $02
    and  A, $0f                                        ;; 00:24c6 $e6 $0f
    or   A, $00                                        ;; 00:24c8 $f6 $00
    ld   C, $c9                                        ;; 00:24ca $0e $c9
    pop  HL                                            ;; 00:24cc $e1
    call runScriptByIndex                              ;; 00:24cd $cd $ad $31
    call popBankNrAndSwitch                            ;; 00:24d0 $cd $0a $2a
    ret                                                ;; 00:24d3 $c9

runRoomScript:
    ld   A, [wMapTableBankNr]                          ;; 00:24d4 $fa $f0 $c3
    call pushBankNrAndSwitch                           ;; 00:24d7 $cd $fb $29
    ld   A, [wRoomScriptTableHigh]                     ;; 00:24da $fa $ff $c3
    ld   H, A                                          ;; 00:24dd $67
    ld   A, [wRoomScriptTableLow]                      ;; 00:24de $fa $fe $c3
    ld   L, A                                          ;; 00:24e1 $6f
    ld   A, [HL+]                                      ;; 00:24e2 $2a
    ld   H, [HL]                                       ;; 00:24e3 $66
    ld   L, A                                          ;; 00:24e4 $6f
    push HL                                            ;; 00:24e5 $e5
    call getPlayerDirection                            ;; 00:24e6 $cd $ab $02
    and  A, $0f                                        ;; 00:24e9 $e6 $0f
    or   A, $00                                        ;; 00:24eb $f6 $00
    ld   C, $c9                                        ;; 00:24ed $0e $c9
    pop  HL                                            ;; 00:24ef $e1
    call runSubScriptFromScriptByIndex                 ;; 00:24f0 $cd $13 $32
    push HL                                            ;; 00:24f3 $e5
    call popBankNrAndSwitch                            ;; 00:24f4 $cd $0a $2a
    pop  HL                                            ;; 00:24f7 $e1
    ret                                                ;; 00:24f8 $c9

runRoomExitScript:
    ld   A, [wMapTableBankNr]                          ;; 00:24f9 $fa $f0 $c3
    call pushBankNrAndSwitch                           ;; 00:24fc $cd $fb $29
    ld   A, [wRoomScriptTableHigh]                     ;; 00:24ff $fa $ff $c3
    ld   H, A                                          ;; 00:2502 $67
    ld   A, [wRoomScriptTableLow]                      ;; 00:2503 $fa $fe $c3
    ld   L, A                                          ;; 00:2506 $6f
    ld   A, [HL+]                                      ;; 00:2507 $2a
    ld   H, [HL]                                       ;; 00:2508 $66
    ld   L, A                                          ;; 00:2509 $6f
    inc  HL                                            ;; 00:250a $23
    push HL                                            ;; 00:250b $e5
    call getPlayerDirection                            ;; 00:250c $cd $ab $02
    and  A, $0f                                        ;; 00:250f $e6 $0f
    or   A, $00                                        ;; 00:2511 $f6 $00
    ld   C, $c9                                        ;; 00:2513 $0e $c9
    pop  HL                                            ;; 00:2515 $e1
    call runSubScriptFromScriptByIndex                 ;; 00:2516 $cd $13 $32
    push HL                                            ;; 00:2519 $e5
    call popBankNrAndSwitch                            ;; 00:251a $cd $0a $2a
    pop  HL                                            ;; 00:251d $e1
    ret                                                ;; 00:251e $c9

runRoomAllKilledScript:
    ld   A, [wMapTableBankNr]                          ;; 00:251f $fa $f0 $c3
    call pushBankNrAndSwitch                           ;; 00:2522 $cd $fb $29
    ld   A, [wRoomScriptTableHigh]                     ;; 00:2525 $fa $ff $c3
    ld   H, A                                          ;; 00:2528 $67
    ld   A, [wRoomScriptTableLow]                      ;; 00:2529 $fa $fe $c3
    ld   L, A                                          ;; 00:252c $6f
    ld   A, [HL+]                                      ;; 00:252d $2a
    ld   H, [HL]                                       ;; 00:252e $66
    ld   L, A                                          ;; 00:252f $6f
    inc  HL                                            ;; 00:2530 $23
    inc  HL                                            ;; 00:2531 $23
    push HL                                            ;; 00:2532 $e5
    call getPlayerDirection                            ;; 00:2533 $cd $ab $02
    and  A, $0f                                        ;; 00:2536 $e6 $0f
    or   A, $00                                        ;; 00:2538 $f6 $00
    ld   C, $c9                                        ;; 00:253a $0e $c9
    pop  HL                                            ;; 00:253c $e1
    call runSubScriptFromScriptByIndex                 ;; 00:253d $cd $13 $32
    push HL                                            ;; 00:2540 $e5
    call popBankNrAndSwitch                            ;; 00:2541 $cd $0a $2a
    pop  HL                                            ;; 00:2544 $e1
    ret                                                ;; 00:2545 $c9

; A = YX tile location (Y in top nibble, X in bottom nibble)
; Return: HL pointer to the metatile in wRoomTiles
getRoomMetatilePointerYXinA:
    ld   D, A                                          ;; 00:2546 $57
    and  A, $0f                                        ;; 00:2547 $e6 $0f
    ld   E, A                                          ;; 00:2549 $5f
    ld   A, D                                          ;; 00:254a $7a
    swap A                                             ;; 00:254b $cb $37
    and  A, $0f                                        ;; 00:254d $e6 $0f
    add  A, A                                          ;; 00:254f $87
    ld   D, A                                          ;; 00:2550 $57
    add  A, A                                          ;; 00:2551 $87
    add  A, A                                          ;; 00:2552 $87
    add  A, D                                          ;; 00:2553 $82
    add  A, E                                          ;; 00:2554 $83
    ld   E, A                                          ;; 00:2555 $5f
    ld   D, $00                                        ;; 00:2556 $16 $00
    ld   HL, wRoomTiles                                ;; 00:2558 $21 $50 $c3
    add  HL, DE                                        ;; 00:255b $19
    ret                                                ;; 00:255c $c9

loadRoomMetatilesTemplated:
    push DE                                            ;; 00:255d $d5
    push HL                                            ;; 00:255e $e5
    call objectReverseDirection                        ;; 00:255f $cd $e4 $29
    push AF                                            ;; 00:2562 $f5
    ld   A, [HL+]                                      ;; 00:2563 $2a
    ld   H, [HL]                                       ;; 00:2564 $66
    ld   L, A                                          ;; 00:2565 $6f
    call loadRoomMetatilesRLE                          ;; 00:2566 $cd $2b $24
    pop  AF                                            ;; 00:2569 $f1
    ld   C, A                                          ;; 00:256a $4f
    pop  DE                                            ;; 00:256b $d1
    inc  DE                                            ;; 00:256c $13
    inc  DE                                            ;; 00:256d $13
    pop  HL                                            ;; 00:256e $e1
    ld   B, $04                                        ;; 00:256f $06 $04
    ld   A, $00                                        ;; 00:2571 $3e $00
    ld   [wDoorStates], A                              ;; 00:2573 $ea $f4 $c3
.loadDoorTilesLoop:
    ld   A, [HL+]                                      ;; 00:2576 $2a
    bit  7, A                                          ;; 00:2577 $cb $7f
    jr   NZ, .jr_00_25a9                               ;; 00:2579 $20 $2e
    srl  C                                             ;; 00:257b $cb $39
    jr   C, .jr_00_25ab                                ;; 00:257d $38 $2c
    push HL                                            ;; 00:257f $e5
    push DE                                            ;; 00:2580 $d5
    and  A, $03                                        ;; 00:2581 $e6 $03
    add  A, A                                          ;; 00:2583 $87
    add  A, A                                          ;; 00:2584 $87
    add  A, $04                                        ;; 00:2585 $c6 $04
    sub  A, B                                          ;; 00:2587 $90
    add  A, A                                          ;; 00:2588 $87
    ld   L, A                                          ;; 00:2589 $6f
    ld   H, $00                                        ;; 00:258a $26 $00
    add  HL, DE                                        ;; 00:258c $19
    ld   A, [HL+]                                      ;; 00:258d $2a
    push AF                                            ;; 00:258e $f5
    ld   A, [HL]                                       ;; 00:258f $7e
    ld   L, B                                          ;; 00:2590 $68
    dec  L                                             ;; 00:2591 $2d
    ld   H, $00                                        ;; 00:2592 $26 $00
    add  HL, HL                                        ;; 00:2594 $29
    add  HL, HL                                        ;; 00:2595 $29
    add  HL, HL                                        ;; 00:2596 $29
    ld   DE, doorMetatileLocation                      ;; 00:2597 $11 $1d $22
    add  HL, DE                                        ;; 00:259a $19
    ld   E, [HL]                                       ;; 00:259b $5e
    inc  HL                                            ;; 00:259c $23
    ld   D, [HL]                                       ;; 00:259d $56
    ld   [DE], A                                       ;; 00:259e $12
    inc  HL                                            ;; 00:259f $23
    ld   E, [HL]                                       ;; 00:25a0 $5e
    inc  HL                                            ;; 00:25a1 $23
    ld   D, [HL]                                       ;; 00:25a2 $56
    pop  AF                                            ;; 00:25a3 $f1
    ld   [DE], A                                       ;; 00:25a4 $12
    pop  DE                                            ;; 00:25a5 $d1
    pop  HL                                            ;; 00:25a6 $e1
    jr   .jr_00_25bb                                   ;; 00:25a7 $18 $12
.jr_00_25a9:
    srl  C                                             ;; 00:25a9 $cb $39
.jr_00_25ab:
    ld   A, $04                                        ;; 00:25ab $3e $04
    sub  A, B                                          ;; 00:25ad $90
    call getBitValue                                   ;; 00:25ae $cd $9a $29
    push DE                                            ;; 00:25b1 $d5
    ld   E, A                                          ;; 00:25b2 $5f
    ld   A, [wDoorStates]                              ;; 00:25b3 $fa $f4 $c3
    or   A, E                                          ;; 00:25b6 $b3
    ld   [wDoorStates], A                              ;; 00:25b7 $ea $f4 $c3
    pop  DE                                            ;; 00:25ba $d1
.jr_00_25bb:
    dec  B                                             ;; 00:25bb $05
    jr   NZ, .loadDoorTilesLoop                        ;; 00:25bc $20 $b8
; Load the remaining tile overrides
.tileOverrideLoop:
    ld   A, [HL+]                                      ;; 00:25be $2a
    cp   A, $ff                                        ;; 00:25bf $fe $ff
    jr   Z, .tileOverrideFinished                      ;; 00:25c1 $28 $0a
    ld   C, A                                          ;; 00:25c3 $4f
    ld   A, [HL+]                                      ;; 00:25c4 $2a
    push HL                                            ;; 00:25c5 $e5
    call getRoomMetatilePointerYXinA                   ;; 00:25c6 $cd $46 $25
    ld   [HL], C                                       ;; 00:25c9 $71
    pop  HL                                            ;; 00:25ca $e1
    jr   .tileOverrideLoop                             ;; 00:25cb $18 $f1
.tileOverrideFinished:
    ld   HL, wRoomTiles                                ;; 00:25cd $21 $50 $c3
    ret                                                ;; 00:25d0 $c9

; Get the pointer to the map data. Difference with getRoomPointerRLE is that this adds a 0x001A offset to skip the template pointer and door data
; Input: D, E = x,y position on the map
; Output: DE = pointer to script table
; Output: HL = pointer to map tile data
getRoomPointerTemplatedRoom:
    push DE                                            ;; 00:25d1 $d5
    ld   L, D                                          ;; 00:25d2 $6a
    ld   H, $00                                        ;; 00:25d3 $26 $00
    ld   A, [wMapWidth]                                ;; 00:25d5 $fa $fb $c3
    call MultiplyHL_by_A                               ;; 00:25d8 $cd $7b $2b
    pop  DE                                            ;; 00:25db $d1
    ld   D, $00                                        ;; 00:25dc $16 $00
    add  HL, DE                                        ;; 00:25de $19
    add  HL, HL                                        ;; 00:25df $29
    add  HL, HL                                        ;; 00:25e0 $29
    ld   A, [wMapTablePointer.high]                    ;; 00:25e1 $fa $f3 $c3
    ld   D, A                                          ;; 00:25e4 $57
    ld   A, [wMapTablePointer]                         ;; 00:25e5 $fa $f2 $c3
    ld   E, A                                          ;; 00:25e8 $5f
    add  HL, DE                                        ;; 00:25e9 $19
    ld   DE, $1a                                       ;; 00:25ea $11 $1a $00
    add  HL, DE                                        ;; 00:25ed $19
    ld   E, [HL]                                       ;; 00:25ee $5e
    inc  HL                                            ;; 00:25ef $23
    ld   D, [HL]                                       ;; 00:25f0 $56
    inc  HL                                            ;; 00:25f1 $23
    ld   A, [HL+]                                      ;; 00:25f2 $2a
    ld   H, [HL]                                       ;; 00:25f3 $66
    ld   L, A                                          ;; 00:25f4 $6f
    ret                                                ;; 00:25f5 $c9

; Get the pointer to the map data in bank 05
; Input: D, E = x,y position on the map
; Output: DE = pointer to script table
; Output: HL = pointer to map tile data
getRoomPointerRLERoom:
    push DE                                            ;; 00:25f6 $d5
    ld   L, D                                          ;; 00:25f7 $6a
    ld   H, $00                                        ;; 00:25f8 $26 $00
    ld   A, [wMapWidth]                                ;; 00:25fa $fa $fb $c3
    call MultiplyHL_by_A                               ;; 00:25fd $cd $7b $2b
    pop  DE                                            ;; 00:2600 $d1
    ld   D, $00                                        ;; 00:2601 $16 $00
    add  HL, DE                                        ;; 00:2603 $19
    add  HL, HL                                        ;; 00:2604 $29
    add  HL, HL                                        ;; 00:2605 $29
    ld   A, [wMapTablePointer.high]                    ;; 00:2606 $fa $f3 $c3
    ld   D, A                                          ;; 00:2609 $57
    ld   A, [wMapTablePointer]                         ;; 00:260a $fa $f2 $c3
    ld   E, A                                          ;; 00:260d $5f
    add  HL, DE                                        ;; 00:260e $19
    ld   E, [HL]                                       ;; 00:260f $5e
    inc  HL                                            ;; 00:2610 $23
    ld   D, [HL]                                       ;; 00:2611 $56
    inc  HL                                            ;; 00:2612 $23
    ld   A, [HL+]                                      ;; 00:2613 $2a
    ld   H, [HL]                                       ;; 00:2614 $66
    ld   L, A                                          ;; 00:2615 $6f
    ret                                                ;; 00:2616 $c9

; D = metatile y (top nibble) x (bottom nibble) location
; E = metatile x address
; Seems to have several functions, but at its most basic (A=0) it gets the room pointers for the current room.
call_00_2617:
    ld   H, D                                          ;; 00:2617 $62
    ld   L, E                                          ;; 00:2618 $6b
    push AF                                            ;; 00:2619 $f5
    push HL                                            ;; 00:261a $e5
    ld   A, [wMapTableBankNr]                          ;; 00:261b $fa $f0 $c3
    call pushBankNrAndSwitch                           ;; 00:261e $cd $fb $29
    pop  HL                                            ;; 00:2621 $e1
    ld   A, [wRoomY]                                   ;; 00:2622 $fa $f7 $c3
    ld   D, A                                          ;; 00:2625 $57
    ld   A, [wRoomX]                                   ;; 00:2626 $fa $f6 $c3
    ld   E, A                                          ;; 00:2629 $5f
    pop  AF                                            ;; 00:262a $f1
    push AF                                            ;; 00:262b $f5
    bit  7, A                                          ;; 00:262c $cb $7f
    jr   NZ, .jr_00_266e                               ;; 00:262e $20 $3e
    bit  0, A                                          ;; 00:2630 $cb $47
    jr   NZ, .jr_00_2642                               ;; 00:2632 $20 $0e
    bit  1, A                                          ;; 00:2634 $cb $4f
    jr   NZ, .jr_00_264d                               ;; 00:2636 $20 $15
    bit  2, A                                          ;; 00:2638 $cb $57
    jr   NZ, .jr_00_2658                               ;; 00:263a $20 $1c
    bit  3, A                                          ;; 00:263c $cb $5f
    jr   NZ, .jr_00_2663                               ;; 00:263e $20 $23
    jr   .jr_00_2670                                   ;; 00:2640 $18 $2e
.jr_00_2642:
    inc  E                                             ;; 00:2642 $1c
    ld   A, [wMapWidth]                                ;; 00:2643 $fa $fb $c3
    cp   A, E                                          ;; 00:2646 $bb
    jr   NZ, .jr_00_2670                               ;; 00:2647 $20 $27
    ld   E, $00                                        ;; 00:2649 $1e $00
    jr   .jr_00_2670                                   ;; 00:264b $18 $23
.jr_00_264d:
    dec  E                                             ;; 00:264d $1d
    ld   A, [wMapWidth]                                ;; 00:264e $fa $fb $c3
    cp   A, E                                          ;; 00:2651 $bb
    jr   NC, .jr_00_2670                               ;; 00:2652 $30 $1c
    ld   E, A                                          ;; 00:2654 $5f
    dec  E                                             ;; 00:2655 $1d
    jr   .jr_00_2670                                   ;; 00:2656 $18 $18
.jr_00_2658:
    dec  D                                             ;; 00:2658 $15
    ld   A, [wMapHeight]                               ;; 00:2659 $fa $fa $c3
    cp   A, D                                          ;; 00:265c $ba
    jr   NC, .jr_00_2670                               ;; 00:265d $30 $11
    ld   D, A                                          ;; 00:265f $57
    dec  D                                             ;; 00:2660 $15
    jr   .jr_00_2670                                   ;; 00:2661 $18 $0d
.jr_00_2663:
    inc  D                                             ;; 00:2663 $14
    ld   A, [wMapHeight]                               ;; 00:2664 $fa $fa $c3
    cp   A, D                                          ;; 00:2667 $ba
    jr   NZ, .jr_00_2670                               ;; 00:2668 $20 $06
    ld   D, $00                                        ;; 00:266a $16 $00
    jr   .jr_00_2670                                   ;; 00:266c $18 $02
.jr_00_266e:
    ld   D, H                                          ;; 00:266e $54
    ld   E, L                                          ;; 00:266f $5d
.jr_00_2670:
    pop  AF                                            ;; 00:2670 $f1
    ld   C, A                                          ;; 00:2671 $4f
    bit  4, A                                          ;; 00:2672 $cb $67
    jr   Z, .get_room_pointer                          ;; 00:2674 $28 $4f
    ld   A, D                                          ;; 00:2676 $7a
    ld   [wRoomY], A                                   ;; 00:2677 $ea $f7 $c3
    ld   A, E                                          ;; 00:267a $7b
    ld   [wRoomX], A                                   ;; 00:267b $ea $f6 $c3
    ld   A, [wMapEncodingType]                         ;; 00:267e $fa $f8 $c3
    cp   A, $00                                        ;; 00:2681 $fe $00
    jr   NZ, .jr_00_2697                               ;; 00:2683 $20 $12
    call getRoomPointerRLERoom                         ;; 00:2685 $cd $f6 $25
    ld   A, D                                          ;; 00:2688 $7a
    ld   [wRoomScriptTableHigh], A                     ;; 00:2689 $ea $ff $c3
    ld   A, E                                          ;; 00:268c $7b
    ld   [wRoomScriptTableLow], A                      ;; 00:268d $ea $fe $c3
    push HL                                            ;; 00:2690 $e5
    push DE                                            ;; 00:2691 $d5
    call loadRoomMetatilesRLE                          ;; 00:2692 $cd $2b $24
    jr   .jr_00_26bc                                   ;; 00:2695 $18 $25
.jr_00_2697:
    push BC                                            ;; 00:2697 $c5
    call getRoomPointerTemplatedRoom                   ;; 00:2698 $cd $d1 $25
    ld   A, D                                          ;; 00:269b $7a
    ld   [wRoomScriptTableHigh], A                     ;; 00:269c $ea $ff $c3
    ld   A, E                                          ;; 00:269f $7b
    ld   [wRoomScriptTableLow], A                      ;; 00:26a0 $ea $fe $c3
    ld   A, H                                          ;; 00:26a3 $7c
    ld   [wRoomTileDataPointer.high], A                ;; 00:26a4 $ea $fd $c3
    ld   A, L                                          ;; 00:26a7 $7d
    ld   [wRoomTileDataPointer], A                     ;; 00:26a8 $ea $fc $c3
    pop  BC                                            ;; 00:26ab $c1
    push HL                                            ;; 00:26ac $e5
    push DE                                            ;; 00:26ad $d5
    ld   D, H                                          ;; 00:26ae $54
    ld   E, L                                          ;; 00:26af $5d
    ld   A, [wMapTablePointer.high]                    ;; 00:26b0 $fa $f3 $c3
    ld   H, A                                          ;; 00:26b3 $67
    ld   A, [wMapTablePointer]                         ;; 00:26b4 $fa $f2 $c3
    ld   L, A                                          ;; 00:26b7 $6f
    ld   A, C                                          ;; 00:26b8 $79
    call loadRoomMetatilesTemplated                    ;; 00:26b9 $cd $5d $25
.jr_00_26bc:
    call cacheMetatileAttributesAndLoadRoomTiles
    call popBankNrAndSwitch                            ;; 00:26bf $cd $0a $2a
    pop  DE                                            ;; 00:26c2 $d1
    pop  HL                                            ;; 00:26c3 $e1
    ret                                                ;; 00:26c4 $c9
.get_room_pointer:
    ld   A, [wMapEncodingType]                         ;; 00:26c5 $fa $f8 $c3
    cp   A, $00                                        ;; 00:26c8 $fe $00
    jr   NZ, .jr_00_26d1                               ;; 00:26ca $20 $05
    call getRoomPointerRLERoom                         ;; 00:26cc $cd $f6 $25
    jr   .jr_00_26d4                                   ;; 00:26cf $18 $03
.jr_00_26d1:
    call getRoomPointerTemplatedRoom                   ;; 00:26d1 $cd $d1 $25
.jr_00_26d4:
    push HL                                            ;; 00:26d4 $e5
    push DE                                            ;; 00:26d5 $d5
    call popBankNrAndSwitch                            ;; 00:26d6 $cd $0a $2a
    pop  DE                                            ;; 00:26d9 $d1
    pop  HL                                            ;; 00:26da $e1
    ret                                                ;; 00:26db $c9

; A=Map number
; DE=room XY
loadMapPreamble:
    ld   [wMapNumber], A                               ;; 00:26dc $ea $f5 $c3
    push DE                                            ;; 00:26df $d5
    push AF                                            ;; 00:26e0 $f5
    ld   A, $08                                        ;; 00:26e1 $3e $08
    call pushBankNrAndSwitch                           ;; 00:26e3 $cd $fb $29
    pop  AF                                            ;; 00:26e6 $f1
    ld   HL, $0b                                       ;; 00:26e7 $21 $0b $00
    call MultiplyHL_by_A                               ;; 00:26ea $cd $7b $2b
    ld   DE, mapHeader_00                              ;; 00:26ed $11 $00 $40
    add  HL, DE                                        ;; 00:26f0 $19
    ld   C, [HL]                                       ;; 00:26f1 $4e
    inc  HL                                            ;; 00:26f2 $23
    ld   B, [HL]                                       ;; 00:26f3 $46
    inc  HL                                            ;; 00:26f4 $23
    inc  HL                                            ;; 00:26f5 $23
    ld   E, [HL]                                       ;; 00:26f6 $5e
    inc  HL                                            ;; 00:26f7 $23
    ld   D, [HL]                                       ;; 00:26f8 $56
    inc  HL                                            ;; 00:26f9 $23
    inc  HL                                            ;; 00:26fa $23
    ld   A, [HL+]                                      ;; 00:26fb $2a
    ld   [wMapTableBankNr], A                          ;; 00:26fc $ea $f0 $c3
    ld   A, [HL+]                                      ;; 00:26ff $2a
    ld   H, [HL]                                       ;; 00:2700 $66
    ld   L, A                                          ;; 00:2701 $6f
    ld   A, H                                          ;; 00:2702 $7c
    ld   [wMapTablePointer.high], A                    ;; 00:2703 $ea $f3 $c3
    ld   A, L                                          ;; 00:2706 $7d
    ld   [wMapTablePointer], A                         ;; 00:2707 $ea $f2 $c3
    ld   HL, mapHeader_00                              ;; 00:270a $21 $00 $40
    add  HL, BC                                        ;; 00:270d $09
    call initMapGraphicsState                          ;; 00:270e $cd $f3 $1a
    call popBankNrAndSwitch                            ;; 00:2711 $cd $0a $2a
    ld   A, [wMapTableBankNr]                          ;; 00:2714 $fa $f0 $c3
    call pushBankNrAndSwitch                           ;; 00:2717 $cd $fb $29
    pop  DE                                            ;; 00:271a $d1
    ld HL, wMapTablePointer
    ld A, [HL+]
    ld H, [HL]
    ld L, A
    ld   A, [HL+]                                      ;; 00:2723 $2a
    ld   [wMapEncodingType], A                         ;; 00:2724 $ea $f8 $c3
    ld   A, [HL+]                                      ;; 00:2727 $2a
    ld   [wMapTileRLECount], A                         ;; 00:2728 $ea $f9 $c3
    ld   A, [HL+]                                      ;; 00:272b $2a
    ld   [wMapHeight], A                               ;; 00:272c $ea $fa $c3
    ld   A, [HL+]                                      ;; 00:272f $2a
    ld   [wMapWidth], A                                ;; 00:2730 $ea $fb $c3
    ld   A, H                                          ;; 00:2733 $7c
    ld   [wMapTablePointer.high], A                    ;; 00:2734 $ea $f3 $c3
    ld   A, L                                          ;; 00:2737 $7d
    ld   [wMapTablePointer], A                         ;; 00:2738 $ea $f2 $c3
    ld   A, D                                          ;; 00:273b $7a
    ld   [wRoomY], A                                   ;; 00:273c $ea $f7 $c3
    ld   A, E                                          ;; 00:273f $7b
    ld   [wRoomX], A                                   ;; 00:2740 $ea $f6 $c3
    ld   A, [wMapEncodingType]                         ;; 00:2743 $fa $f8 $c3
    and A, A
    jr   NZ, .templatedRoom                            ;; 00:2748 $20 $15
    call getRoomPointerRLERoom                         ;; 00:274a $cd $f6 $25
    ld   A, D                                          ;; 00:274d $7a
    ld   [wRoomScriptTableHigh], A                     ;; 00:274e $ea $ff $c3
    ld   A, E                                          ;; 00:2751 $7b
    ld   [wRoomScriptTableLow], A                      ;; 00:2752 $ea $fe $c3
    jp loadRoomMetatilesRLE
.templatedRoom:
    push HL                                            ;; 00:275f $e5
    call getRoomPointerTemplatedRoom                   ;; 00:2760 $cd $d1 $25
    ld   A, D                                          ;; 00:2763 $7a
    ld   [wRoomScriptTableHigh], A                     ;; 00:2764 $ea $ff $c3
    ld   A, E                                          ;; 00:2767 $7b
    ld   [wRoomScriptTableLow], A                      ;; 00:2768 $ea $fe $c3
    ld   A, H                                          ;; 00:276b $7c
    ld   [wRoomTileDataPointer.high], A                ;; 00:276c $ea $fd $c3
    ld   A, L                                          ;; 00:276f $7d
    ld   [wRoomTileDataPointer], A                     ;; 00:2770 $ea $fc $c3
    ld   D, H                                          ;; 00:2773 $54
    ld   E, L                                          ;; 00:2774 $5d
    pop  HL                                            ;; 00:2775 $e1
    xor A, A
    jp loadRoomMetatilesTemplated

; Used for loading graphics and metatile attribute cache for interactive maps
; A=Map number
; DE=room XY
loadMap:
    call loadMapPreamble
    call cacheMetatileAttributesAndLoadRoomTiles
    jp popBankNrAndSwitch

; Used for loading map graphics without building the metatile attribute cache
; So far this includes the minimap open and close routines and title screen
; A=Map number
; DE=room XY
loadMapGraphics:
    call loadMapPreamble
    call loadRoomTiles
    jp popBankNrAndSwitch

; DE=pointer to the NPC runtime data
getNpcProjectileType:
    ld   HL, $10                                       ;; 00:2782 $21 $10 $00
    add  HL, DE                                        ;; 00:2785 $19
    ld   A, [HL+]                                      ;; 00:2786 $2a
    ld   H, [HL]                                       ;; 00:2787 $66
    ld   L, A                                          ;; 00:2788 $6f
    ld   BC, $09                                       ;; 00:2789 $01 $09 $00
    add  HL, BC                                        ;; 00:278c $09
    ld   A, [HL]                                       ;; 00:278d $7e
    ret                                                ;; 00:278e $c9

getNumberOfEnemies:
    ld   HL, wNpcRuntimeData                           ;; 00:278f $21 $e0 $c4
    ld   B, $08                                        ;; 00:2792 $06 $08
    ld   C, $00                                        ;; 00:2794 $0e $00
.loop:
    push BC                                            ;; 00:2796 $c5
    ld   C, [HL]                                       ;; 00:2797 $4e
    push HL                                            ;; 00:2798 $e5
    call getObjectCollisionFlags                       ;; 00:2799 $cd $6d $0c
    pop  HL                                            ;; 00:279c $e1
    pop  BC                                            ;; 00:279d $c1
    and  A, $f0                                        ;; 00:279e $e6 $f0
    cp   A, $90                                        ;; 00:27a0 $fe $90
    jr   Z, .jr_00_27a8                                ;; 00:27a2 $28 $04
    cp   A, $10                                        ;; 00:27a4 $fe $10
    jr   NZ, .jr_00_27a9                               ;; 00:27a6 $20 $01
.jr_00_27a8:
    inc  C                                             ;; 00:27a8 $0c
.jr_00_27a9:
    ld   DE, $18                                       ;; 00:27a9 $11 $18 $00
    add  HL, DE                                        ;; 00:27ac $19
    dec  B                                             ;; 00:27ad $05
    jr   NZ, .loop                                     ;; 00:27ae $20 $e6
    ld   A, [wBossFirstObjectID]                       ;; 00:27b0 $fa $e8 $d3
    cp   A, $ff                                        ;; 00:27b3 $fe $ff
    jr   Z, .jr_00_27b8                                ;; 00:27b5 $28 $01
    inc  C                                             ;; 00:27b7 $0c
.jr_00_27b8:
    ld   A, C                                          ;; 00:27b8 $79
    ret                                                ;; 00:27b9 $c9

npcSpawnProjectile:
    push DE                                            ;; 00:27ba $d5
    call getNumberOfEnemies                            ;; 00:27bb $cd $8f $27
    pop  DE                                            ;; 00:27be $d1
    cp   A, $00                                        ;; 00:27bf $fe $00
    jr   Z, .jr_00_27cb                                ;; 00:27c1 $28 $08
    push DE                                            ;; 00:27c3 $d5
    call getNpcProjectileType                          ;; 00:27c4 $cd $82 $27
    call spawnProjectile_trampoline                    ;; 00:27c7 $cd $ec $2b
    pop  DE                                            ;; 00:27ca $d1
.jr_00_27cb:
    ld   A, $00                                        ;; 00:27cb $3e $00
    ret                                                ;; 00:27cd $c9

updateNPCsAndBoss:
    call bossUpdate                                    ;; 00:27ce $cd $aa $04
    jp_to_bank 03, npcRunBehaviorForAll                ;; 00:27d1 $f5 $3e $00 $c3 $35 $1f

processPhysicsForObject_3_trampoline:
    jp_to_bank 03, processPhysicsForObject_3           ;; 00:27d7 $f5 $3e $01 $c3 $35 $1f

spawnNPC_trampoline:
    jp_to_bank 03, spawnNPC                            ;; 00:27dd $f5 $3e $02 $c3 $35 $1f

destroyNPC_trampoline:
    jp_to_bank 03, destroyNPC                          ;; 00:27e3 $f5 $3e $03 $c3 $35 $1f

initNpcRuntimeData:
    ld   HL, wNpcRuntimeData                           ;; 00:27e9 $21 $e0 $c4
    ld   B, $08                                        ;; 00:27ec $06 $08
    ld   DE, $18                                       ;; 00:27ee $11 $18 $00
    ld   A, $ff                                        ;; 00:27f1 $3e $ff
.loop:
    ld   [HL], A                                       ;; 00:27f3 $77
    add  HL, DE                                        ;; 00:27f4 $19
    dec  B                                             ;; 00:27f5 $05
    jr   NZ, .loop                                     ;; 00:27f6 $20 $fb
    ret                                                ;; 00:27f8 $c9

scriptOpCodeSetNPCTypes:
    ld   A, [wScriptOpCounter]                         ;; 00:27f9 $fa $99 $d4
    or a
    call Z, setNpcSpawnTable_trampoline                ;; 00:27fe $cc $19 $28
    ld   A, $01                                        ;; 00:2801 $3e $01
    ld   [wScriptOpCounter], A                         ;; 00:2803 $ea $99 $d4
    ld   A, [wTileCopyRequestCount]                    ;; 00:2806 $fa $e0 $c8
    or a
    ret  NZ                                            ;; 00:2811 $c0
    ld   [wScriptOpCounter], A                         ;; 00:2812 $ea $99 $d4
; The current loaded projectile palette no longer matters so initialize it to $ff.
    dec a
    ld [wCurrentProjectilePalette], a
    call getNextScriptInstruction                      ;; 00:2815 $cd $27 $37
    ret                                                ;; 00:2818 $c9

 ds 5 ; Free space

SECTION "bank00_align_2819", ROM0[$2819]

setNpcSpawnTable_trampoline:
    ld   A, [HL+]                                      ;; 00:2819 $2a
    jp_to_bank 03, setNpcSpawnTable                    ;; 00:281a $f5 $3e $05 $c3 $35 $1f

scriptOpCodeSpawnNPC:
    ld   A, [wScriptOpCounter]                         ;; 00:2820 $fa $99 $d4
    or a
    call Z, spawnNpcsFromTable_trampoline              ;; 00:2825 $cc $40 $28
    ld   A, $01                                        ;; 00:2828 $3e $01
    ld   [wScriptOpCounter], A                         ;; 00:282a $ea $99 $d4
    ld   A, [wTileCopyRequestCount]                    ;; 00:282d $fa $e0 $c8
    or a
    ret  NZ                                            ;; 00:2838 $c0
    ld   [wScriptOpCounter], A                         ;; 00:2839 $ea $99 $d4
    call getNextScriptInstruction                      ;; 00:283c $cd $27 $37
    ret                                                ;; 00:283f $c9

ds 8 ; Free space

spawnNpcsFromTable_trampoline:
    ld   A, [HL+]                                      ;; 00:2840 $2a
    jp_to_bank 03, spawnNpcsFromTable                  ;; 00:2841 $f5 $3e $04 $c3 $35 $1f

loggerInit_trampoline:
    jp_to_bank 11, loggerInit

friendlyCollisionHandling_trampoline:
    jp_to_bank 03, friendlyCollisionHandling           ;; 00:284d $f5 $3e $08 $c3 $35 $1f

damageNpc_trampoline:
    jp_to_bank 03, damageNpc                           ;; 00:2853 $f5 $3e $09 $c3 $35 $1f

scriptNpcDelete:
    push BC                                            ;; 00:2859 $c5
    push HL                                            ;; 00:285a $e5
    call checkForMovingObjects                         ;; 00:285b $cd $9b $28
    pop  HL                                            ;; 00:285e $e1
    pop  BC                                            ;; 00:285f $c1
    ret  NZ                                            ;; 00:2860 $c0
    push HL                                            ;; 00:2861 $e5
    ld   A, C                                          ;; 00:2862 $79
    ld   L, A                                          ;; 00:2863 $6f
    add  A, L                                          ;; 00:2864 $85
    add  A, L                                          ;; 00:2865 $85
    add  A, A                                          ;; 00:2866 $87
    add  A, A                                          ;; 00:2867 $87
    add  A, A                                          ;; 00:2868 $87
    ld   L, A                                          ;; 00:2869 $6f
    ld   H, $00                                        ;; 00:286a $26 $00
    ld   DE, wNpcRuntimeData                           ;; 00:286c $11 $e0 $c4
    add  HL, DE                                        ;; 00:286f $19
    ld   C, [HL]                                       ;; 00:2870 $4e
    call destroyNPC_trampoline                         ;; 00:2871 $cd $e3 $27
    pop  HL                                            ;; 00:2874 $e1
    call getNextScriptInstruction                      ;; 00:2875 $cd $27 $37
    ret                                                ;; 00:2878 $c9

scriptObjectBehaviorMove:
    push HL                                            ;; 00:2879 $e5
    call objectBehaviorMove_trampoline                 ;; 00:287a $cd $83 $28
    pop  HL                                            ;; 00:287d $e1
    ret  NZ                                            ;; 00:287e $c0
    call getNextScriptInstruction                      ;; 00:287f $cd $27 $37
    ret                                                ;; 00:2882 $c9

objectBehaviorMove_trampoline:
    jp_to_bank 03, objectBehaviorMove                  ;; 00:2883 $f5 $3e $0a $c3 $35 $1f

moveGridlessObject_3_trampoline:
    jp_to_bank 03, moveGridlessObject_3                ;; 00:2889 $f5 $3e $0b $c3 $35 $1f

updateObjectPosition_3_trampoline:
    jp_to_bank 03, updateObjectPosition_3              ;; 00:288f $f5 $3e $0c $c3 $35 $1f

giveFollower_trampoline:
    jp_to_bank 03, giveFollower                        ;; 00:2895 $f5 $3e $0f $c3 $35 $1f

checkForMovingObjects:
    ld   HL, wObjectsMovingDuringScript                ;; 00:289b $21 $a0 $c5
    ld   B, $08                                        ;; 00:289e $06 $08
    ld   C, $00                                        ;; 00:28a0 $0e $00
.loop:
    ld   A, [HL+]                                      ;; 00:28a2 $2a
    or   A, C                                          ;; 00:28a3 $b1
    ld   C, A                                          ;; 00:28a4 $4f
    dec  B                                             ;; 00:28a5 $05
    jr   NZ, .loop                                     ;; 00:28a6 $20 $fa
    or   A, A                                          ;; 00:28a8 $b7
    ret                                                ;; 00:28a9 $c9

updateNpcPosition_trampoline:
    jp_to_bank 03, updateNpcPosition                   ;; 00:28aa $f5 $3e $0d $c3 $35 $1f

moveObjectsDuringScript_trampoline:
    jp_to_bank 03, moveObjectsDuringScript             ;; 00:28b0 $f5 $3e $0e $c3 $35 $1f

enemyCollisionHandling_trampoline:
    jp_to_bank 03, enemyCollisionHandling              ;; 00:28b6 $f5 $3e $07 $c3 $35 $1f

npcSetMeleeState:
    ld   HL, $03                                       ;; 00:28bc $21 $03 $00
    add  HL, DE                                        ;; 00:28bf $19
    ld   [HL], A                                       ;; 00:28c0 $77
    ret                                                ;; 00:28c1 $c9

; Npcs start at object 7, unless you have a follower.
; Return: 0 if no follower, 1 if follower
;         Z flag set if follower
checkForFollower:
    push HL                                            ;; 00:28c2 $e5
    ld   C, $07                                        ;; 00:28c3 $0e $07
    call getObjectCollisionFlags                       ;; 00:28c5 $cd $6d $0c
    pop  HL                                            ;; 00:28c8 $e1
    and  A, $f0                                        ;; 00:28c9 $e6 $f0
    cp   A, $d0                                        ;; 00:28cb $fe $d0
    jr   Z, .haveFollower                              ;; 00:28cd $28 $03
    ld   A, $00                                        ;; 00:28cf $3e $00
    ret                                                ;; 00:28d1 $c9
.haveFollower:
    ld   A, $01                                        ;; 00:28d2 $3e $01
    ret                                                ;; 00:28d4 $c9

; Used when you ASK your Chocobo/Chocobot/Chocoboat
hideFollower:
    call checkForFollower                              ;; 00:28d5 $cd $c2 $28
    ret  NZ                                            ;; 00:28d8 $c0
    ld hl, wNpcRuntimeData + $000c
    xor  A, A                                          ;; 00:28ec $af
    ld   [HL+], A                                      ;; 00:28ed $22
    ld   [HL+], A                                      ;; 00:28ee $22
    ret                                                ;; 00:28ef $c9

; Used when you dismount your Chocobo/Chocobot/Chocoboat
showFollower:
    call checkForFollower                              ;; 00:28f0 $cd $c2 $28
    ret  NZ                                            ;; 00:28f3 $c0
    ld hl, wNpcRuntimeData + $000c
    ld   A, $55                                        ;; 00:2907 $3e $55
    ld   [HL+], A                                      ;; 00:2909 $22
    ld   [HL+], A                                      ;; 00:290a $22
    xor  A, A                                          ;; 00:290b $af
    ret                                                ;; 00:290c $c9

; Used for the ASK command
getFollowerScript:
    ld   HL, $00                                       ;; 00:290d $21 $00 $00
    call checkForFollower                              ;; 00:2910 $cd $c2 $28
    ret  NZ                                            ;; 00:2913 $c0
    jp_to_bank 03, getNpcScriptIndex                   ;; 00:2914 $f5 $3e $15 $c3 $35 $1f

runRoomScriptIfAllEnemiesDefeated_trampoline:
    ld   A, [wMainGameStateFlags]                      ;; 00:291a $fa $a1 $c0
    bit  1, A                                          ;; 00:291d $cb $4f
    ret  NZ                                            ;; 00:291f $c0
    jp_to_bank 03, runRoomScriptIfAllEnemiesDefeated   ;; 00:2920 $f5 $3e $13 $c3 $35 $1f

initEnemiesCounterAndMoveFolower_trampoline:
    jp_to_bank 03, initEnemiesCounterAndMoveFolower    ;; 00:2926 $f5 $3e $14 $c3 $35 $1f

inflictVulnerableNpcsSlep_trampoline:
    jp_to_bank 03, inflictVulnerableNpcsSlep           ;; 00:292c $f5 $3e $10 $c3 $35 $1f

inflictVulnerableNpcsMute_trampoline:
    jp_to_bank 03, inflictVulnerableNpcsMute           ;; 00:2932 $f5 $3e $11 $c3 $35 $1f

getEmptyObjectsMovingDuringScriptSlot_trampoline:
    jp_to_bank 03, getEmptyObjectsMovingDuringScriptSlot ;; 00:2938 $f5 $3e $12 $c3 $35 $1f

; Converts a 24 bit number (in CDE) to an eight digit Binary Coded Decimal packed in four bytes at HL
convertToPackedBCD:
    push HL                                            ;; 00:293e $e5
    ld   B, $18                                        ;; 00:293f $06 $18
    xor  A, A                                          ;; 00:2941 $af
    ld   [HL+], A                                      ;; 00:2942 $22
    ld   [HL+], A                                      ;; 00:2943 $22
    ld   [HL+], A                                      ;; 00:2944 $22
    ld   [HL], A                                       ;; 00:2945 $77
.loop:
    push HL                                            ;; 00:2946 $e5
    rl   E                                             ;; 00:2947 $cb $13
    rl   D                                             ;; 00:2949 $cb $12
    rl   C                                             ;; 00:294b $cb $11
    ld   A, [HL]                                       ;; 00:294d $7e
    adc  A, A                                          ;; 00:294e $8f
    daa                                                ;; 00:294f $27
    ld   [HL-], A                                      ;; 00:2950 $32
    ld   A, [HL]                                       ;; 00:2951 $7e
    adc  A, A                                          ;; 00:2952 $8f
    daa                                                ;; 00:2953 $27
    ld   [HL-], A                                      ;; 00:2954 $32
    ld   A, [HL]                                       ;; 00:2955 $7e
    adc  A, A                                          ;; 00:2956 $8f
    daa                                                ;; 00:2957 $27
    ld   [HL-], A                                      ;; 00:2958 $32
    ld   A, [HL]                                       ;; 00:2959 $7e
    adc  A, A                                          ;; 00:295a $8f
    daa                                                ;; 00:295b $27
    ld   [HL-], A                                      ;; 00:295c $32
    pop  HL                                            ;; 00:295d $e1
    dec  B                                             ;; 00:295e $05
    jr   NZ, .loop                                     ;; 00:295f $20 $e5
    pop  HL                                            ;; 00:2961 $e1
    ret                                                ;; 00:2962 $c9

; Converts a 24 bit number (in CDE) to an eight digit Binary Coded Decimal in eight bytes at HL
convertToUnpackedBCD:
    call convertToPackedBCD                            ;; 00:2963 $cd $3e $29
    dec  HL                                            ;; 00:2966 $2b
    ld   BC, $04                                       ;; 00:2967 $01 $04 $00
    add  HL, BC                                        ;; 00:296a $09
    ld   D, H                                          ;; 00:296b $54
    ld   E, L                                          ;; 00:296c $5d
    add  HL, BC                                        ;; 00:296d $09
.loop:
    ld   A, [DE]                                       ;; 00:296e $1a
    and  A, $0f                                        ;; 00:296f $e6 $0f
    ld   [HL-], A                                      ;; 00:2971 $32
    ld   A, [DE]                                       ;; 00:2972 $1a
    swap A                                             ;; 00:2973 $cb $37
    and  A, $0f                                        ;; 00:2975 $e6 $0f
    ld   [HL-], A                                      ;; 00:2977 $32
    dec  DE                                            ;; 00:2978 $1b
    dec  C                                             ;; 00:2979 $0d
    jr   NZ, .loop                                     ;; 00:297a $20 $f2
    ret                                                ;; 00:297c $c9

playSFX:
    and  A, $7f                                        ;; 00:297d $e6 $7f
    ldh  [hSFX], A                                     ;; 00:297f $e0 $92
    ret                                                ;; 00:2981 $c9

; 01->00, 02->01, 04->02, 08->03
; Only works for the lowest set bit of bits 0 to 3.
getBitNumber:
    bit  0, A                                          ;; 00:2982 $cb $47
    jr   NZ, .bit_0                                    ;; 00:2984 $20 $0b
    bit  1, A                                          ;; 00:2986 $cb $4f
    jr   NZ, .bit_1                                    ;; 00:2988 $20 $0a
    bit  2, A                                          ;; 00:298a $cb $57
    jr   NZ, .bit_2                                    ;; 00:298c $20 $09
;.bit_3:
    ld   A, $03                                        ;; 00:298e $3e $03
    ret                                                ;; 00:2990 $c9
.bit_0:
    ld   A, $00                                        ;; 00:2991 $3e $00
    ret                                                ;; 00:2993 $c9
.bit_1:
    ld   A, $01                                        ;; 00:2994 $3e $01
    ret                                                ;; 00:2996 $c9
.bit_2:
    ld   A, $02                                        ;; 00:2997 $3e $02
    ret                                                ;; 00:2999 $c9

; 00->01, 01->02, 02->04, 03->08
; Only works for bits 0 to 3.
getBitValue:
    and  A, $03                                        ;; 00:299a $e6 $03
    jr   Z, .bit_0                                     ;; 00:299c $28 $0b
    cp   A, $01                                        ;; 00:299e $fe $01
    jr   Z, .bit_1                                     ;; 00:29a0 $28 $0a
    cp   A, $02                                        ;; 00:29a2 $fe $02
    jr   Z, .bit_2                                     ;; 00:29a4 $28 $09
;.bit_3:
    ld   A, $08                                        ;; 00:29a6 $3e $08
    ret                                                ;; 00:29a8 $c9
.bit_0:
    ld   A, $01                                        ;; 00:29a9 $3e $01
    ret                                                ;; 00:29ab $c9
.bit_1:
    ld   A, $02                                        ;; 00:29ac $3e $02
    ret                                                ;; 00:29ae $c9
.bit_2:
    ld   A, $04                                        ;; 00:29af $3e $04
    ret                                                ;; 00:29b1 $c9

HLandDE:
    ld   A, H                                          ;; 00:29b2 $7c
    and  A, D                                          ;; 00:29b3 $a2
    ld   H, A                                          ;; 00:29b4 $67
    ld   A, L                                          ;; 00:29b5 $7d
    and  A, E                                          ;; 00:29b6 $a3
    ld   L, A                                          ;; 00:29b7 $6f
    or   A, H                                          ;; 00:29b8 $b4
    ret                                                ;; 00:29b9 $c9

snapObjectToNearestTile8:
    ld e, c
    call GetObjectY                                    ;; 00:29bb $cd $3e $0c
    call snapPositionToNearestTile8                    ;; 00:29be $cd $dc $29
    ld c, e
    ld d, a
    call GetObjectX                                    ;; 00:29c4 $cd $2d $0c
    call snapPositionToNearestTile8                    ;; 00:29c7 $cd $dc $29
    ld c, e
    ld   E, A                                          ;; 00:29cb $5f
    push DE                                            ;; 00:29cd $d5
    push BC                                            ;; 00:29ce $c5
    call getObjectDirection                            ;; 00:29cf $cd $99 $0c
    and  A, $0f                                        ;; 00:29d2 $e6 $0f
    pop  BC                                            ;; 00:29d4 $c1
    pop  DE                                            ;; 00:29d5 $d1
    ld   B, $00                                        ;; 00:29d6 $06 $00
    call updateObjectPosition                          ;; 00:29d8 $cd $11 $06
    ret                                                ;; 00:29db $c9

snapPositionToNearestTile8:
    add $04
    and $f8
    ret

; Takes a facing direction and returns the opposite.
; Used, for instance, to make characters walk backwards in cutscenes.
; 0x01 -> 0x02 ( west -> east )
; 0x02 -> 0x01 ( east -> west )
; 0x04 -> 0x08 (north -> south)
; 0x08 -> 0x04 (south -> north)
objectReverseDirection:
    and  A, $0f                                        ;; 00:29e4 $e6 $0f
    bit  0, A                                          ;; 00:29e6 $cb $47
    jr   NZ, .jr_00_29ee                               ;; 00:29e8 $20 $04
    bit  1, A                                          ;; 00:29ea $cb $4f
    jr   Z, .jr_00_29f0                                ;; 00:29ec $28 $02
.jr_00_29ee:
    xor  A, $03                                        ;; 00:29ee $ee $03
.jr_00_29f0:
    bit  2, A                                          ;; 00:29f0 $cb $57
    jr   NZ, .jr_00_29f8                               ;; 00:29f2 $20 $04
    bit  3, A                                          ;; 00:29f4 $cb $5f
    jr   Z, .jr_00_29fa                                ;; 00:29f6 $28 $02
.jr_00_29f8:
    xor  A, $0c                                        ;; 00:29f8 $ee $0c
.jr_00_29fa:
    ret                                                ;; 00:29fa $c9

; Switch to bank A and put A on the bank stack.
pushBankNrAndSwitch:
    ld hl, hBankStackPointer
    inc [hl]
    ld l, [hl]
    ld   H, HIGH(wBankStack)                           ;; 00:2a03 $26 $c0
    ld   [HL], A                                       ;; 00:2a05 $77
    ld   [rROMB0], A                                   ;; 00:2a06 $ea $00 $20
    ret                                                ;; 00:2a09 $c9

; Pop A from the top of the bank stack and switch to that bank.
popBankNrAndSwitch:
    ld hl, hBankStackPointer
    dec [hl]
    ld l, [hl]
    ld   H, HIGH(wBankStack)                           ;; 00:2a10 $26 $c0
    ld   A, [HL]                                       ;; 00:2a12 $7e
    ld   [rROMB0], A                                   ;; 00:2a13 $ea $00 $20
    ret                                                ;; 00:2a16 $c9

; Load A from the bank stack (without modifying the bank stack) and switch to that bank.
; Not interrupt safe.
getCurrentBankNrAndSwitch:
    ldh  A, [hBankStackPointer]                        ;; 00:2a17 $f0 $8a
    ld   L, A                                          ;; 00:2a19 $6f
    ld   H, HIGH(wBankStack)                           ;; 00:2a1a $26 $c0
    ld   A, [HL]                                       ;; 00:2a1c $7e
    ld [rROMB0], a
    ret                                                ;; 00:2a1d $c9

; A linear congruential generator RNG.
; The original RNG has issues with some values coming up more often than others.

INCLUDE "code/rand.asm"

; Hero's skin color changes when poisoned, moogled, or stoned.
; This sets Hero's palette accordingly.
loadHeroPaletteForStatus:
    ld a, [wStatusEffect]
    push bc
    rra
    ld b, PALETTE_SET_HERO_POISON
    jr c, .set
    rra
    ; Blind/Dark has its own handling.
    rra
    ld b, PALETTE_SET_HERO_STONE
    jr c, .set
    rra
    ld b, PALETTE_SET_HERO_MOOGLE
    jr c, .set
    ld b, PALETTE_SET_HERO_GOOD
.set:
    ld a, b
    pop bc
    ; Fall through to loadHeroPalette

loadHeroPalette:
    ld b, PAL_PLAYER
    ; Fall through to loadSinglePalette

; Loads a (four color) color object palette set
; a = palette id
; b = palette number (upper five bits may be dirty)
loadSinglePalette:
    push hl
    push af
;   Switch the bank.
    ld a, BANK(ColorSinglePalettesROM)
    call pushBankNrAndSwitch
    pop af
; Make the call.
    call loadSinglePalette_expansion
; Switch back to the correct bank.
    call popBankNrAndSwitch
    pop hl
    ret

; Loads the (four color) color palette set for an NPC before continuing creation.
; The color palette set loaded is the number of the NPC id.
; It is loaded into the object palette number of the first entry in the metatile table.
; a = NPC id
; hl = metatile table pointer
loadNPCPalette_and_createObject:
; There are special NPCs for chests that inherit a palette. Make sure not to load palettes for them.
    cp a, NPC_CHEST_DROP_1
; Load the first byte of the metatile table. This is a sprite attribute with a palette number.
    ld b, [hl]
    call c, loadSinglePalette
    call createObject_speed2
    ret

; Load a set of palettes from ROM into RAM, and setup the transer to CRAM.
; This loads the main palettes, flash palettes, dark palettes, and boss damage flash palettes.
; Each has eight OBJ palettes and eight BGP palettes.
; The Hero and Follower palettes are exceptions--they are set separately.
; a = palette set number
loadPalettes:
    push hl
    push af
    ; Switch to the palette bank
    ld a, BANK(ColorPalettesROM)
    call pushBankNrAndSwitch
    ; Calculate the address of the palette
    pop af
    push af
    add a, a
    add HIGH(ColorPalettesROM)
    ld h, a
    xor a
    ld l, a
    ; Load all the palettes into RAM.
    ld de, wColorPalettes
    ld bc, $0200
    call copyHLtoDE_long
; Set the Hero palette based on current status.
    call loadHeroPaletteForStatus
; Set the Follower's palette.
; Currently this doesn't check if there is a follower.
    ld a, [wCurrentFollowerPalette]
    ld b, PAL_FOLLOWER
    call loadSinglePalette
; Check whether the Blind/Dark effect is active.
    ld hl, wPlayerSpecialFlags
    bit 1, [hl]
    ld hl, wColorPalettes.main
    jr z, .activate
    ld hl, wColorPalettes.blind
.activate:
; Prepare the copy to CRAM.
    call setPalettes
    call popBankNrAndSwitch
    pop af
    pop hl
    DBG_MSG_LABEL debugMsgLoadPalette
    ret

colorInit:
; Refuse to run unless color capable hardware is found.
    ldh a, [hBootup.a]
    cp BOOTUP_A_CGB
    jr nz, .fatal
IF DEF(DOUBLE_SPEED)
; Perform switch to Double Speed Mode
    ldh a, [rKEY1]
    and KEY1F_DBLSPEED
    jr nz, .done
    ld a, P1F_GET_NONE
    ldh [rP1], a
    ld a, KEY1F_PREPARE
    ldh [rKEY1], a
    stop
    ldh a, [rKEY1]
    and KEY1F_DBLSPEED
    jr z, .done
    DBG_MSG_LABEL debugMsgDoubleSpeed
.done: 
ENDC
    jp Init
.fatal:
    DBG_MSG_LABEL debugMsgColorIncompatible
.loop:
    jr .loop

; Loads all background and object palettes into CRAM.
; Used in VBlank.
loadPalettesToCRAM:
    ; Clear the dirty flag
    xor a
    ldh [hPalettesDirty], a
    ; Load the palette background active buffer into CRAM.
    ld hl, wColorPalettes.bgp_active
    ; Set the Background Palette Index
    ld a, BCPSF_AUTOINC
    ld c, LOW(rBCPS)
    ldh [c], a
    ; Set c to rBCPD by incrementing
    inc c
    ; The loop is unrolled to transfer one palette (eight bytes) at a time, so it runs eight times.
    ld b, $08
.loop_bgp:
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    dec b
    jr nz, .loop_bgp
    ; Load the palette object active buffer into CRAM.
    ld hl, wColorPalettes.obj_active
    ; Set the Background Palette Index
    ld a, OCPSF_AUTOINC
    ld c, LOW(rOCPS)
    ldh [c], a
    ; Set c to rOCPD by incrementing
    inc c
    ; The loop is unrolled to transfer one palette (eight bytes) at a time, so it runs eight times.
    ld b, $08
.loop_obj:
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    dec b
    jr nz, .loop_obj
    ret

; Set active palettes and flag them to be transferred during the next VBlank.
; Used whenever switching between main, blind, flash, or boss damage palettes.
; hl = background palette address
setPalettes:
; Load all palettes.
    ld de, wColorPalettes.active
    ld b, $80
    call copyHLtoDE
; Set the dirty flag.
    ld a, $01
    ldh [hPalettesDirty], a
    ret

; Clear RAM up to the stack.
clearRAM:
    xor a
    ld hl, $10000 - _RAM
    add hl, sp
    ld b, h
    ld c, l
    ld hl, _RAM
    jr FillHL_with_A_times_BC

; Clear HRAM up to the area used to store initial boot state.
clearHRAM:
    xor a
    ld b, hBootup - _HRAM
    ld hl, _HRAM
    jr fillMemory

SECTION "bank00_align_2b40", ROM0[$2b40]

copyHLtoDE_long:
CopyHL_to_DE_size_BC:
    ld   A, B                                          ;; 00:2b40 $78
    or   A, C                                          ;; 00:2b41 $b1
    ret  Z                                             ;; 00:2b42 $c8
    ld   A, [HL+]                                      ;; 00:2b43 $2a
    ld   [DE], A                                       ;; 00:2b44 $12
    inc  DE                                            ;; 00:2b45 $13
    dec  BC                                            ;; 00:2b46 $0b
    jr   CopyHL_to_DE_size_BC                          ;; 00:2b47 $18 $f7

;copy B bytes from HL to DE
copyHLtoDE:
    ld   A, B                                          ;; 00:2b49 $78
    cp   A, $00                                        ;; 00:2b4a $fe $00
    ret  Z                                             ;; 00:2b4c $c8
.loop:
    ld   A, [HL+]                                      ;; 00:2b4d $2a
    ld   [DE], A                                       ;; 00:2b4e $12
    inc  DE                                            ;; 00:2b4f $13
    dec  B                                             ;; 00:2b50 $05
    jr   NZ, .loop                                     ;; 00:2b51 $20 $fa
    ret                                                ;; 00:2b53 $c9

FillHL_with_A_times_BC:
    ld   D, A                                          ;; 00:2b54 $57
.loop:
    ld   A, B                                          ;; 00:2b55 $78
    or   A, C                                          ;; 00:2b56 $b1
    ret  Z                                             ;; 00:2b57 $c8
    ld   [HL], D                                       ;; 00:2b58 $72
    inc  HL                                            ;; 00:2b59 $23
    dec  BC                                            ;; 00:2b5a $0b
    jr   .loop                                         ;; 00:2b5b $18 $f8

;write A B times at HL
fillMemory:
    inc  B                                             ;; 00:2b5d $04
.loop:
    dec  B                                             ;; 00:2b5e $05
    ret  Z                                             ;; 00:2b5f $c8
    ld   [HL+], A                                      ;; 00:2b60 $22
    jr   .loop                                         ;; 00:2b61 $18 $fb

; Call entry A in a jumptable pointed to by HL.
callJumptable:
    add  A, A                                          ;; 00:2b63 $87
    jr   NC, .jr_00_2b67                               ;; 00:2b64 $30 $01
    inc  H                                             ;; 00:2b66 $24
.jr_00_2b67:
    add  A, L                                          ;; 00:2b67 $85
    ld   L, A                                          ;; 00:2b68 $6f
    jr   NC, .jr_00_2b6c                               ;; 00:2b69 $30 $01
    inc  H                                             ;; 00:2b6b $24
.jr_00_2b6c:
    ld   A, [HL+]                                      ;; 00:2b6c $2a
    ld   H, [HL]                                       ;; 00:2b6d $66
    ld   L, A                                          ;; 00:2b6e $6f
    jp   HL                                            ;; 00:2b73 $e9

; sLOAD_PALETTE
; A new script opcode for loading palettes.
scriptOpCodeLoadColorPalette:
    ld a, [hl+]
IF DEF(COLOR)
    call loadPalettes
ENDC
    call getNextScriptInstruction
    ret

ds 3 ; Free space

SECTION "bank00_align_2b7b", ROM0[$2b7b]

; Input HL and A
; Output:
;  HL = bits 15-0 of HL*A
;  A, C unchanged
;  DE = Input HL
;  B = 0
MultiplyHL_by_A:
    ld   E, L                                          ;; 00:2b7b $5d
    ld   D, H                                          ;; 00:2b7c $54
MultiplyDE_by_A:
    ld   HL, $00                                       ;; 00:2b7d $21 $00 $00
    ld   B, $08                                        ;; 00:2b80 $06 $08
.loop:
    add  HL, HL                                        ;; 00:2b82 $29
    rlca                                               ;; 00:2b83 $07
    jr   NC, .next                                     ;; 00:2b84 $30 $01
    add  HL, DE                                        ;; 00:2b86 $19
.next:
    dec  B                                             ;; 00:2b87 $05
    jr   NZ, .loop                                     ;; 00:2b88 $20 $f8
    ret                                                ;; 00:2b8a $c9

; modulo function:
; A = HL % A
; HL = HL / A
divMod:
    cp   A, $00                                        ;; 00:2b8b $fe $00
    ret  Z                                             ;; 00:2b8d $c8
    ld   E, L                                          ;; 00:2b8e $5d
    ld   D, H                                          ;; 00:2b8f $54
    ld   B, $10                                        ;; 00:2b90 $06 $10
    ld   C, A                                          ;; 00:2b92 $4f
    ld   HL, $00                                       ;; 00:2b93 $21 $00 $00
    ld   A, $00                                        ;; 00:2b96 $3e $00
.loop:
    add  HL, HL                                        ;; 00:2b98 $29
    sla  E                                             ;; 00:2b99 $cb $23
    rl   D                                             ;; 00:2b9b $cb $12
    rl   A                                             ;; 00:2b9d $cb $17
    jr   C, .jr_00_2ba4                                ;; 00:2b9f $38 $03
    cp   A, C                                          ;; 00:2ba1 $b9
    jr   C, .jr_00_2ba7                                ;; 00:2ba2 $38 $03
.jr_00_2ba4:
    sub  A, C                                          ;; 00:2ba4 $91
    set  0, L                                          ;; 00:2ba5 $cb $c5
.jr_00_2ba7:
    dec  B                                             ;; 00:2ba7 $05
    jr   NZ, .loop                                     ;; 00:2ba8 $20 $ee
    ret                                                ;; 00:2baa $c9

; Subtract DE from HL and set Z and C flags appropriately.
; Return: DE = DE * -1, HL = HL - DE, Z flag set if HL is zero, C flag set if DE > HL.
sub_HL_DE:
; Multiply DE by -1.
    ld   A, D                                          ;; 00:2bab $7a
    cpl                                                ;; 00:2bac $2f
    ld   D, A                                          ;; 00:2bad $57
    ld   A, E                                          ;; 00:2bae $7b
    cpl                                                ;; 00:2baf $2f
    ld   E, A                                          ;; 00:2bb0 $5f
    inc  DE                                            ;; 00:2bb1 $13
    ld   A, D                                          ;; 00:2bb2 $7a
    or   A, E                                          ;; 00:2bb3 $b3
    jr   Z, .calculate_zero_flag                       ;; 00:2bb4 $28 $03
    add  HL, DE                                        ;; 00:2bb6 $19
    ccf                                                ;; 00:2bb7 $3f
    ret  C                                             ;; 00:2bb8 $d8
.calculate_zero_flag:
    ld   A, H                                          ;; 00:2bb9 $7c
    or   A, L                                          ;; 00:2bba $b5
    ret                                                ;; 00:2bbb $c9
    db   $21, $01, $00, $e6, $0f, $c8, $29, $3d        ;; 00:2bbc ????????
    db   $20, $fc, $c9, $3e, $10, $29, $38, $03        ;; 00:2bc4 ????????
    db   $3d, $20, $fa, $3d, $c9                       ;; 00:2bcc ?????

projectileRunLogicForAll_trampoline:
    jp_to_bank 09, projectileRunLogicForAll            ;; 00:2bd1 $f5 $3e $00 $c3 $93 $1f

processPhysicsForObject_9_trampoline:
    jp_to_bank 09, processPhysicsForObject_9           ;; 00:2bd7 $f5 $3e $01 $c3 $93 $1f

projectileLoadTiles_trampoline:
    cp   A, $ff                                        ;; 00:2bdd $fe $ff
    ret  Z                                             ;; 00:2bdf $c8
    jp_to_bank 09, projectileLoadTiles                 ;; 00:2be0 $f5 $3e $02 $c3 $93 $1f

projectileDestroy_trampoline:
    jp_to_bank 09, projectileDestroy                   ;; 00:2be6 $f5 $3e $03 $c3 $93 $1f

spawnProjectile_trampoline:
    jp_to_bank 09, spawnProjectile                     ;; 00:2bec $f5 $3e $04 $c3 $93 $1f

initProjectileRuntimeData:
    ld   HL, wProjectileRuntimeData                    ;; 00:2bf2 $21 $c0 $c5
    ld   B, $03                                        ;; 00:2bf5 $06 $03
    ld   DE, $0a                                       ;; 00:2bf7 $11 $0a $00
.loop:
    ld [hl], $ff
    add  HL, DE                                        ;; 00:2bfd $19
    dec  B                                             ;; 00:2bfe $05
    jr   NZ, .loop                                     ;; 00:2bff $20 $fb
    ret                                                ;; 00:2c01 $c9

; Added to load a color palette for the color target.
projectileLoadColorPalette_trampoline:
    jp_to_bank 09, projectileLoadColorPalette

projectileCollisionHandling_trampoline:
    jp_to_bank 09, projectileCollisionHandling         ;; 00:2c03 $f5 $3e $08 $c3 $93 $1f

getProjectileSize_trampoline:
    jp_to_bank 09, getProjectileSize                   ;; 00:2c09 $f5 $3e $05 $c3 $93 $1f

getProjectileElement_trampoline:
    jp_to_bank 09, getProjectileElement                ;; 00:2c0f $f5 $3e $06 $c3 $93 $1f

getProjectilePower_trampoline:
    jp_to_bank 09, getProjectilePower                  ;; 00:2c15 $f5 $3e $07 $c3 $93 $1f

call_00_2c1b:
    jp_to_bank 01, call_01_7639                        ;; 00:2c1b $f5 $3e $1b $c3 $d7 $1e

call_00_2c21:
    jp_to_bank 01, call_01_7647                        ;; 00:2c21 $f5 $3e $1a $c3 $d7 $1e

objectJumpHandler_trampoline:
    jp_to_bank 01, objectJumpHandler                   ;; 00:2c27 $f5 $3e $1c $c3 $d7 $1e

; A = player facing direction
; C = object id
; Return: Z if blocked
pushObject:
    bit  0, A                                          ;; 00:2c2d $cb $47
    jr   NZ, .east                                     ;; 00:2c2f $20 $12
    bit  1, A                                          ;; 00:2c31 $cb $4f
    jr   NZ, .west                                     ;; 00:2c33 $20 $22
    bit  2, A                                          ;; 00:2c35 $cb $57
    jr   NZ, .north                                    ;; 00:2c37 $20 $32
    bit  3, A                                          ;; 00:2c39 $cb $5f
    jr   NZ, .south                                    ;; 00:2c3b $20 $42
    ld   A, $00                                        ;; 00:2c3d $3e $00
    call processPhysicsForObject                       ;; 00:2c3f $cd $95 $06
    ret                                                ;; 00:2c42 $c9
.east:
    call checkPlayfieldBoundaryCollision_trampoline    ;; 00:2c43 $cd $6f $03
    ld   A, B                                          ;; 00:2c46 $78
    jr   NZ, .push_east                                ;; 00:2c47 $20 $06
    bit  0, A                                          ;; 00:2c49 $cb $47
    jr   Z, .push_east                                 ;; 00:2c4b $28 $02
    xor  A, A                                          ;; 00:2c4d $af
    ret                                                ;; 00:2c4e $c9
.push_east:
    ld   A, $91                                        ;; 00:2c4f $3e $91
    ld   B, $00                                        ;; 00:2c51 $06 $00
    call processPhysicsForObject                       ;; 00:2c53 $cd $95 $06
    ret                                                ;; 00:2c56 $c9
.west:
    call checkPlayfieldBoundaryCollision_trampoline    ;; 00:2c57 $cd $6f $03
    ld   A, B                                          ;; 00:2c5a $78
    jr   NZ, .push_west                                ;; 00:2c5b $20 $06
    bit  1, A                                          ;; 00:2c5d $cb $4f
    jr   Z, .push_west                                 ;; 00:2c5f $28 $02
    xor  A, A                                          ;; 00:2c61 $af
    ret                                                ;; 00:2c62 $c9
.push_west:
    ld   A, $92                                        ;; 00:2c63 $3e $92
    ld   B, $00                                        ;; 00:2c65 $06 $00
    call processPhysicsForObject                       ;; 00:2c67 $cd $95 $06
    ret                                                ;; 00:2c6a $c9
.north:
    call checkPlayfieldBoundaryCollision_trampoline    ;; 00:2c6b $cd $6f $03
    ld   A, B                                          ;; 00:2c6e $78
    jr   NZ, .push_north                               ;; 00:2c6f $20 $06
    bit  2, A                                          ;; 00:2c71 $cb $57
    jr   Z, .push_north                                ;; 00:2c73 $28 $02
    xor  A, A                                          ;; 00:2c75 $af
    ret                                                ;; 00:2c76 $c9
.push_north:
    ld   A, $94                                        ;; 00:2c77 $3e $94
    ld   B, $00                                        ;; 00:2c79 $06 $00
    call processPhysicsForObject                       ;; 00:2c7b $cd $95 $06
    ret                                                ;; 00:2c7e $c9
.south:
    call checkPlayfieldBoundaryCollision_trampoline    ;; 00:2c7f $cd $6f $03
    ld   A, B                                          ;; 00:2c82 $78
    jr   NZ, .push_south                               ;; 00:2c83 $20 $06
    bit  3, A                                          ;; 00:2c85 $cb $5f
    jr   Z, .push_south                                ;; 00:2c87 $28 $02
    xor  A, A                                          ;; 00:2c89 $af
    ret                                                ;; 00:2c8a $c9
.push_south:
    ld   A, $98                                        ;; 00:2c8b $3e $98
    ld   B, $00                                        ;; 00:2c8d $06 $00
    call processPhysicsForObject                       ;; 00:2c8f $cd $95 $06
    ret                                                ;; 00:2c92 $c9

INCLUDE "data/npc/metasprites_extra.asm"

; Switch to the empty chest graphic.
; For the sake of color there are now three special empty chest NPCs
; They inherit the palette of the chest being opened.
scriptOpCodeChangeIntoEmptyChest:
    push HL                                            ;; 00:2ce7 $e5
    ld   A, [wNPCDroppingChest]                        ;; 00:2ce8 $fa $b0 $c5
    ld   C, A                                          ;; 00:2ceb $4f
    call getObjectMetaspriteTablePointer
    ld a, [hl]
    and $07
    add NPC_CHEST_DROP_EMPTY_1 - $05
    ld b, a
    call getObjectNearestTilePosition                  ;; 00:2ced $cd $ef $05
    push bc
    push DE                                            ;; 00:2cf1 $d5
    call destroyPushableObject                         ;; 00:2cf2 $cd $13 $2d
    pop  DE                                            ;; 00:2cf5 $d1
    pop bc
    ld c, b
    call spawnNPC_trampoline
    ld   A, $0f                                        ;; 00:2cf9 $3e $0f
    call playSFX                                       ;; 00:2cfb $cd $7d $29
    pop  HL                                            ;; 00:2cfe $e1
    call getNextScriptInstruction                      ;; 00:2cff $cd $27 $37
    ret                                                ;; 00:2d02 $c9

ds 2 ; Free space

spawnSnowman:
    ld   C, NPC_SNOWMAN_STILL                          ;; 00:2d03 $0e $00
    call spawnNPC_trampoline                           ;; 00:2d05 $cd $dd $27
    cp   A, $ff                                        ;; 00:2d08 $fe $ff
    ret  Z                                             ;; 00:2d0a $c8
    push AF                                            ;; 00:2d0b $f5
    ld   A, $01                                        ;; 00:2d0c $3e $01
    call setObjectSpeed                                ;; 00:2d0e $cd $5d $0c
    pop  AF                                            ;; 00:2d11 $f1
    ret                                                ;; 00:2d12 $c9

; This makes sure that if the snowman/chest/emptychest is sitting on a script tile, it gets triggered.
; In theory all NPCs destroyed on script tiles should trigger the script, but it doesn't hurt to make sure.
destroyPushableObject:
    push BC                                            ;; 00:2d13 $c5
    ld   B, $a9                                        ;; 00:2d14 $06 $a9
    call objectCheckTriggerScriptOrSpikeTile           ;; 00:2d16 $cd $6f $0b
    pop  BC                                            ;; 00:2d19 $c1
    call destroyNPC_trampoline                         ;; 00:2d1a $cd $e3 $27
    ret                                                ;; 00:2d1d $c9

ds 4 ; Free space

; Handles empty chests and Ice spell snowmen
pushableCollisionHandling:
    cp   A, $5a                                        ;; 00:2d22 $fe $5a
    jr   Z, .ice                                       ;; 00:2d24 $28 $10
    and  A, $f0                                        ;; 00:2d26 $e6 $f0
    cp   A, $c0                                        ;; 00:2d28 $fe $c0
    jr   Z, .player                                    ;; 00:2d2a $28 $0d
    cp   A, $a0                                        ;; 00:2d2c $fe $a0
    ret  Z                                             ;; 00:2d2e $c8
    cp   A, $b0                                        ;; 00:2d2f $fe $b0
    ret  Z                                             ;; 00:2d31 $c8
    call enemyCollisionHandling_trampoline             ;; 00:2d32 $cd $b6 $28
    ret                                                ;; 00:2d35 $c9
.ice:
    ld   A, $00                                        ;; 00:2d36 $3e $00
    ret                                                ;; 00:2d38 $c9
.player:
    push BC                                            ;; 00:2d39 $c5
    ld   A, B                                          ;; 00:2d3a $78
    ld   B, C                                          ;; 00:2d3b $41
    ld   C, A                                          ;; 00:2d3c $4f
    call checkObjectsCollisionDirection                ;; 00:2d3d $cd $9a $03
    pop  BC                                            ;; 00:2d40 $c1
    push BC                                            ;; 00:2d41 $c5
    call pushObject                                    ;; 00:2d42 $cd $2d $2c
    pop  BC                                            ;; 00:2d45 $c1
    jr   Z, .blocked                                   ;; 00:2d46 $28 $0c
    push BC                                            ;; 00:2d48 $c5
    ld   C, B                                          ;; 00:2d49 $48
    call getObjectDirection                            ;; 00:2d4a $cd $99 $0c
    pop  BC                                            ;; 00:2d4d $c1
    or   A, $40                                        ;; 00:2d4e $f6 $40
    ld   C, B                                          ;; 00:2d50 $48
    call setObjectDirection                            ;; 00:2d51 $cd $a6 $0c
.blocked:
    ld   A, $c9                                        ;; 00:2d54 $3e $c9
    ret                                                ;; 00:2d56 $c9

vblankGraphicsVRAMCopy:
    ld   A, [wTileCopyRequestCount]                    ;; 00:2d57 $fa $e0 $c8
    or a
    ret  Z                                             ;; 00:2d5c $c8
    ld b, a
    ld a, [wTileCopyRequestMutex]
    or a
    ret  NZ                                            ;; 00:2d63 $c0
; Use the stack pointer for speed. This is simplified by being in an interrupt.
    ld [wStackPointerBackup], sp
    ld sp, wTileCopyRequestData
; VBlank lasts from $90 (144) through the end of scanline $99 (153).
; Or possibly $99 (153) is short and some of scanline $00 is also VBLank.
; Due to this confusion, stop transferring tiles if the scanline is $98 (152).
    ld c, SCRN_Y + $08
.loop_transfer_tile:
; Switch to the requested graphics bank.
    pop  AF                                            ;; 00:2d88 $f1
    ld [rROMB0], a
IF DEF(COLOR)
; If built for GBC use a HDMA for tile transfer.
; This requires 16 byte alignment of data.
; Write the source address into rHDMA1 and rHDMA2.
    pop de
    ld hl, rHDMA1
    ld a, d
    ld [hl+], a
    ld a, e
    ld [hl+], a
; Write the destination address into rHDMA3 and rHDMA4.
    pop de
    ld a, d
    ld [hl+], a
    ld a, e
    ld [hl+], a
; Write zero into rHDMA5 to start an immediate transfer of one tile.
    ld [hl], HDMA5F_MODE_GP
ELSE
; Copy 16 bytes from hl to de.
; Take advantage of alignment to use inc e instead of inc de.
    pop hl
    pop de
    ld   A, [HL+]                                      ;; 00:2d8e $2a
    ld   [DE], A                                       ;; 00:2d8f $12
    inc e
    ld   A, [HL+]                                      ;; 00:2d91 $2a
    ld   [DE], A                                       ;; 00:2d92 $12
    inc e
    ld   A, [HL+]                                      ;; 00:2d94 $2a
    ld   [DE], A                                       ;; 00:2d95 $12
    inc e
    ld   A, [HL+]                                      ;; 00:2d97 $2a
    ld   [DE], A                                       ;; 00:2d98 $12
    inc e
    ld   A, [HL+]                                      ;; 00:2d9a $2a
    ld   [DE], A                                       ;; 00:2d9b $12
    inc e
    ld   A, [HL+]                                      ;; 00:2d9d $2a
    ld   [DE], A                                       ;; 00:2d9e $12
    inc e
    ld   A, [HL+]                                      ;; 00:2da0 $2a
    ld   [DE], A                                       ;; 00:2da1 $12
    inc e
    ld   A, [HL+]                                      ;; 00:2da3 $2a
    ld   [DE], A                                       ;; 00:2da4 $12
    inc e
    ld   A, [HL+]                                      ;; 00:2da6 $2a
    ld   [DE], A                                       ;; 00:2da7 $12
    inc e
    ld   A, [HL+]                                      ;; 00:2da9 $2a
    ld   [DE], A                                       ;; 00:2daa $12
    inc e
    ld   A, [HL+]                                      ;; 00:2dac $2a
    ld   [DE], A                                       ;; 00:2dad $12
    inc e
    ld   A, [HL+]                                      ;; 00:2daf $2a
    ld   [DE], A                                       ;; 00:2db0 $12
    inc e
    ld   A, [HL+]                                      ;; 00:2db2 $2a
    ld   [DE], A                                       ;; 00:2db3 $12
    inc e
    ld   A, [HL+]                                      ;; 00:2db5 $2a
    ld   [DE], A                                       ;; 00:2db6 $12
    inc e
    ld   A, [HL+]                                      ;; 00:2db8 $2a
    ld   [DE], A                                       ;; 00:2db9 $12
    inc e
    ld   A, [HL+]                                      ;; 00:2dbb $2a
    ld   [DE], A                                       ;; 00:2dbc $12
ENDC
    dec  B                                             ;; 00:2dbd $05
    jr z, .break
    ldh  A, [rLY]                                      ;; 00:2d83 $f0 $44
    cp   A, C                                          ;; 00:2d85 $b9
    jr   c, .loop_transfer_tile
.break:
    ld   A, B                                          ;; 00:2dc0 $78
    ld   [wTileCopyRequestCount], A                    ;; 00:2dc1 $ea $e0 $c8
; If there's no unprocessed requests, then there's nothing to move.
    or a
    jr   Z, .finish
; Move any unprocessed request records to the beginning of the memory area.
; Since the stack pointer is already pointing at the location to begin copying, use it.
; There is enough room allocated for 128 requests, so theoretically multiplying b*3 could be bad.
; So unroll the loop instead.
; Plus, even unrolled this code is actually smaller than the original code that called CopyHL_to_DE_size_BC.
    ld hl, wTileCopyRequestData
.loop_move:
    pop de
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    pop de
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    pop de
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    dec b
    jr nz, .loop_move
.finish:
    ld hl, wStackPointerBackup
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld sp, hl
    call getCurrentBankNrAndSwitch
    ret

ds 23 ; Free space

SECTION "bank00_align_2df5", ROM0[$2df5]

; Request the VBlank handler to copy 1 graphics tile (16 bytes) from ROM into VRAM.
; A: source bank
; DE: target VRAM address
; HL: source ROM address
; Return: DE unmodified
addTileGraphicCopyRequest:
    push de
    push hl
; Take the lock so VBlank doesn't modify the data while this is working on it.
; It should be safe to blindly set the lock.
    ld hl, wTileCopyRequestMutex
    inc [hl]
; Calculate the address to record this request.
    ld hl, wTileCopyRequestCount
    ld l, [hl]
    ld   H, $00                                        ;; 00:2e10 $26 $00
    ld   D, H                                          ;; 00:2e12 $54
    ld   E, L                                          ;; 00:2e13 $5d
    add  HL, HL                                        ;; 00:2e14 $29
    add  HL, DE                                        ;; 00:2e15 $19
    add  HL, HL                                        ;; 00:2e16 $29
    ld   DE, wTileCopyRequestData                      ;; 00:2e17 $11 $e0 $c5
    add  HL, DE                                        ;; 00:2e1a $19
; Write the bank number (16-bit).
    ld   [HL], $00                                     ;; 00:2e1c $36 $00
    inc  HL                                            ;; 00:2e1e $23
    ld   [HL+], A                                      ;; 00:2e1f $22
; Write the source address.
    pop  DE                                            ;; 00:2e20 $d1
    ld   A, E                                          ;; 00:2e21 $7b
    ld   [HL+], A                                      ;; 00:2e22 $22
    ld [hl], d
    inc hl
; Write the destination address.
    pop  DE                                            ;; 00:2e25 $d1
; Test that source and destination address are both aligned to 16 bytes.
; This is a requirement to use GBC VRAM DMA and good practice otherwise.
    or e
    and $0f
    jr z, .debug_end
    DBG_MSG_LABEL nonAlignedTileCopy
.debug_end:
    ld   A, E                                          ;; 00:2e26 $7b
    ld   [HL+], A                                      ;; 00:2e27 $22
    ld   [HL], D                                       ;; 00:2e28 $72
; Increment request count.
    ld   HL, wTileCopyRequestCount                     ;; 00:2e29 $21 $e0 $c8
    inc  [HL]                                          ;; 00:2e2c $34
; Drop the lock.
    ld   HL, wTileCopyRequestMutex                     ;; 00:2e2d $21 $e1 $c8
    dec  [HL]                                          ;; 00:2e30 $35
    ret                                                ;; 00:2e31 $c9

; The menu sprites (pointer fingers and the trashcan) use the attack palette.
loadMenuSpritePalette:
    call windowGetOffsetXYPosition
    push bc
    push de
    push hl
    ld a, PALETTE_SET_MENU_OBJ
    ld b, PAL_ATTACK
    call loadSinglePaletteBank2
    pop hl
    pop de
    pop bc
    ret

; Loads a palette whenever you use a weapon, item, or spell.
loadAttackPalette:
    push af
    ld a, [wJoypadInput]
    bit 4, a
    ld a, [wEquippedWeapon]
    ld h, (INV_SWORD_BROAD - 1)
    jr nz, .set_palette
    ld a, [wEquippedItem]
    and $7f
    ld h, $00
.set_palette:
    add a, h
    ld b, PAL_ATTACK
    call loadSinglePaletteBank2
    pop af
    ret

; Loads a (four color) color object palette set from the second bank of palettes
; a = palette id
; b = palette number (upper five bits may be dirty)
loadSinglePaletteBank2:
    push hl
    push af
;   Switch the bank.
    ld a, BANK(ColorSinglePalettesROM_2)
    call pushBankNrAndSwitch
    pop af
; Make the call.
    call loadSinglePaletteBank2_expansion
; Switch back to the correct bank.
    call popBankNrAndSwitch
    pop hl
    ret

ds 8 ; Free space

SECTION "bank00_align_2e75", ROM0[$2e75]

INCLUDE "data/metasprites_player.asm"

initSpecialAttackTimer:
    ld   HL, $1e0                                      ;; 00:2ec9 $21 $e0 $01
    call timerNew                                      ;; 00:2ecc $cd $9e $2f
    ld   [wSpecialAttackTimerNumber], A                ;; 00:2ecf $ea $62 $cf
    ret                                                ;; 00:2ed2 $c9

runPlayerAttackObjectFunctions_trampoline:
    jp_to_bank 01, runPlayerAttackObjectFunctions      ;; 00:2ed3 $f5 $3e $1d $c3 $d7 $1e

getEquippedWeaponAnimationType_trampoline:
    jp_to_bank 01, getEquippedWeaponAnimationType      ;; 00:2ed9 $f5 $3e $20 $c3 $d7 $1e

getEquippedItemAnimationType_trampoline:
    jp_to_bank 01, getEquippedItemAnimationType        ;; 00:2edf $f5 $3e $21 $c3 $d7 $1e

useEquippedWeaponOrItem_trampoline:
    jp_to_bank 01, useEquippedWeaponOrItem             ;; 00:2ee5 $f5 $3e $22 $c3 $d7 $1e

useSpecialAttack_trampoline:
    jp_to_bank 01, useSpecialAttack                    ;; 00:2eeb $f5 $3e $23 $c3 $d7 $1e

ensureReservedObjectsExist_trampoline:
    jp_to_bank 01, ensureReservedObjectsExist          ;; 00:2ef1 $f5 $3e $1e $c3 $d7 $1e

playerAttackDestroy_trampoline:
    jp_to_bank 01, playerAttackDestroy                 ;; 00:2ef7 $f5 $3e $1f $c3 $d7 $1e

playerOrFriendlyAttackCollisionHandling_trampoline:
    jp_to_bank 01, playerOrFriendlyAttackCollisionHandling ;; 00:2efd $f5 $3e $25 $c3 $d7 $1e

call_00_2f03:
    jp_to_bank 01, call_01_5db6                        ;; 00:2f03 $f5 $3e $26 $c3 $d7 $1e

ds 3 ; Free space

getSelectedX:
    ld   A, [wSelectedObjectID]                        ;; 00:2f0c $fa $5a $cf
    ld   C, A                                          ;; 00:2f0f $4f
    call GetObjectX                                    ;; 00:2f10 $cd $2d $0c
    ret                                                ;; 00:2f13 $c9

getSelectedY:
    ld   A, [wSelectedObjectID]                        ;; 00:2f14 $fa $5a $cf
    ld   C, A                                          ;; 00:2f17 $4f
    call GetObjectY                                    ;; 00:2f18 $cd $3e $0c
    ret                                                ;; 00:2f1b $c9
    db   $fa, $5a, $cf, $4f, $cd, $4f, $0c, $c9        ;; 00:2f1c ????????
    db   $21, $5a, $cf, $4e, $cd, $5d, $0c, $c9        ;; 00:2f24 ????????

getSelectedDirection:
    ld   A, [wSelectedObjectID]                        ;; 00:2f2c $fa $5a $cf
    ld   C, A                                          ;; 00:2f2f $4f
    call getObjectDirection                            ;; 00:2f30 $cd $99 $0c
    ret                                                ;; 00:2f33 $c9
    db   $47, $fa, $5a, $cf, $4f, $78, $cd, $a6        ;; 00:2f34 ????????
    db   $0c, $c9                                      ;; 00:2f3c ??

call_00_2f3e:
    jp_to_bank 01, call_01_5d98                        ;; 00:2f3e $f5 $3e $24 $c3 $d7 $1e

useSlep:
    ld   A, [wSlepTimerNumber]                         ;; 00:2f44 $fa $60 $cf
    cp   A, $00                                        ;; 00:2f47 $fe $00
    jr   Z, .jr_00_2f50                                ;; 00:2f49 $28 $05
    push HL                                            ;; 00:2f4b $e5
    call timerFree                                     ;; 00:2f4c $cd $ca $2f
    pop  HL                                            ;; 00:2f4f $e1
.jr_00_2f50:
    call timerNew                                      ;; 00:2f50 $cd $9e $2f
    ld   [wSlepTimerNumber], A                         ;; 00:2f53 $ea $60 $cf
    call timerStart                                    ;; 00:2f56 $cd $d4 $2f
    call inflictVulnerableNpcsSlep_trampoline          ;; 00:2f59 $cd $2c $29
    ret                                                ;; 00:2f5c $c9

useMute:
    ld   A, [wMuteTimerNumber]                         ;; 00:2f5d $fa $61 $cf
    cp   A, $00                                        ;; 00:2f60 $fe $00
    jr   Z, .jr_00_2f69                                ;; 00:2f62 $28 $05
    push HL                                            ;; 00:2f64 $e5
    call timerFree                                     ;; 00:2f65 $cd $ca $2f
    pop  HL                                            ;; 00:2f68 $e1
.jr_00_2f69:
    call timerNew                                      ;; 00:2f69 $cd $9e $2f
    ld   [wMuteTimerNumber], A                         ;; 00:2f6c $ea $61 $cf
    call timerStart                                    ;; 00:2f6f $cd $d4 $2f
    call inflictVulnerableNpcsMute_trampoline          ;; 00:2f72 $cd $32 $29
    ret                                                ;; 00:2f75 $c9

attackTile_trampoline:
    cp   A, $00                                        ;; 00:2f76 $fe $00
    ret  Z                                             ;; 00:2f78 $c8
    jp_to_bank 01, attackTile                          ;; 00:2f79 $f5 $3e $27 $c3 $d7 $1e

; Unused script opcode.
scriptOpCodeClearPlayerAttack:
    push HL                                            ;; 00:2f7f $e5
    call playerAttackDestroy_trampoline                ;; 00:2f80 $cd $f7 $2e
    pop  HL                                            ;; 00:2f83 $e1
    call getNextScriptInstruction                      ;; 00:2f84 $cd $27 $37
    ret                                                ;; 00:2f87 $c9

initTimerIDsNamesAndScriptFlags:
    push HL                                            ;; 00:2f88 $e5
    push BC                                            ;; 00:2f89 $c5
    ld   HL, wTimers                                   ;; 00:2f8a $21 $e1 $d7
    xor  A, A                                          ;; 00:2f8d $af
    ld   B, $10                                        ;; 00:2f8e $06 $10
.loop:
    ld   [HL+], A                                      ;; 00:2f90 $22
    inc  HL                                            ;; 00:2f91 $23
    inc  HL                                            ;; 00:2f92 $23
    inc  HL                                            ;; 00:2f93 $23
    inc  HL                                            ;; 00:2f94 $23
    dec  B                                             ;; 00:2f95 $05
    jr   NZ, .loop                                     ;; 00:2f96 $20 $f8
    pop  BC                                            ;; 00:2f98 $c1
    pop  HL                                            ;; 00:2f99 $e1
    call clearNamesAndScriptFlags                      ;; 00:2f9a $cd $b7 $3b
    ret                                                ;; 00:2f9d $c9

timerNew:
    push BC                                            ;; 00:2f9e $c5
    push HL                                            ;; 00:2f9f $e5
    ld   B, $10                                        ;; 00:2fa0 $06 $10
    ld   HL, wTimers                                   ;; 00:2fa2 $21 $e1 $d7
.loop:
    ld   A, [HL+]                                      ;; 00:2fa5 $2a
    rrca                                               ;; 00:2fa6 $0f
    jr   NC, .jr_00_2fb4                               ;; 00:2fa7 $30 $0b
    inc  HL                                            ;; 00:2fa9 $23
    inc  HL                                            ;; 00:2faa $23
    inc  HL                                            ;; 00:2fab $23
    inc  HL                                            ;; 00:2fac $23
    dec  B                                             ;; 00:2fad $05
    jr   NZ, .loop                                     ;; 00:2fae $20 $f5
    pop  HL                                            ;; 00:2fb0 $e1
    pop  BC                                            ;; 00:2fb1 $c1
    scf                                                ;; 00:2fb2 $37
    ret                                                ;; 00:2fb3 $c9
.jr_00_2fb4:
    ld   A, $10                                        ;; 00:2fb4 $3e $10
    sub  A, B                                          ;; 00:2fb6 $90
    dec  HL                                            ;; 00:2fb7 $2b
    ld   [HL], $03                                     ;; 00:2fb8 $36 $03
    inc  HL                                            ;; 00:2fba $23
    pop  BC                                            ;; 00:2fbb $c1
    push BC                                            ;; 00:2fbc $c5
    push AF                                            ;; 00:2fbd $f5
    ld   [HL], C                                       ;; 00:2fbe $71
    inc  HL                                            ;; 00:2fbf $23
    ld   [HL], B                                       ;; 00:2fc0 $70
    inc  HL                                            ;; 00:2fc1 $23
    ld   [HL], C                                       ;; 00:2fc2 $71
    inc  HL                                            ;; 00:2fc3 $23
    ld   [HL], B                                       ;; 00:2fc4 $70
    pop  AF                                            ;; 00:2fc5 $f1
    pop  HL                                            ;; 00:2fc6 $e1
    pop  BC                                            ;; 00:2fc7 $c1
    or   A, A                                          ;; 00:2fc8 $b7
    ret                                                ;; 00:2fc9 $c9

timerFree:
    push HL                                            ;; 00:2fca $e5
    push BC                                            ;; 00:2fcb $c5
    call timerGetIndex                                 ;; 00:2fcc $cd $57 $30
    xor  A, A                                          ;; 00:2fcf $af
    ld   [HL], A                                       ;; 00:2fd0 $77
    pop  BC                                            ;; 00:2fd1 $c1
    pop  HL                                            ;; 00:2fd2 $e1
    ret                                                ;; 00:2fd3 $c9

timerStart:
    push HL                                            ;; 00:2fd4 $e5
    push BC                                            ;; 00:2fd5 $c5
    call timerGetIndex                                 ;; 00:2fd6 $cd $57 $30
    ld   A, [HL]                                       ;; 00:2fd9 $7e
    or   A, $82                                        ;; 00:2fda $f6 $82
    ld   [HL+], A                                      ;; 00:2fdc $22
    push HL                                            ;; 00:2fdd $e5
    inc  HL                                            ;; 00:2fde $23
    inc  HL                                            ;; 00:2fdf $23
    ld   C, [HL]                                       ;; 00:2fe0 $4e
    inc  HL                                            ;; 00:2fe1 $23
    ld   B, [HL]                                       ;; 00:2fe2 $46
    pop  HL                                            ;; 00:2fe3 $e1
    ld   [HL], C                                       ;; 00:2fe4 $71
    inc  HL                                            ;; 00:2fe5 $23
    ld   [HL], B                                       ;; 00:2fe6 $70
    pop  BC                                            ;; 00:2fe7 $c1
    pop  HL                                            ;; 00:2fe8 $e1
    ret                                                ;; 00:2fe9 $c9

timerStop:
    push HL                                            ;; 00:2fea $e5
    push BC                                            ;; 00:2feb $c5
    call timerGetIndex                                 ;; 00:2fec $cd $57 $30
    ld   A, [HL]                                       ;; 00:2fef $7e
    and  A, $03                                        ;; 00:2ff0 $e6 $03
    ld   [HL], A                                       ;; 00:2ff2 $77
    pop  BC                                            ;; 00:2ff3 $c1
    pop  HL                                            ;; 00:2ff4 $e1
    ret                                                ;; 00:2ff5 $c9

timerDeactivate:
    push HL                                            ;; 00:2ff6 $e5
    push BC                                            ;; 00:2ff7 $c5
    call timerGetIndex                                 ;; 00:2ff8 $cd $57 $30
    res  7, [HL]                                       ;; 00:2ffb $cb $be
    pop  BC                                            ;; 00:2ffd $c1
    pop  HL                                            ;; 00:2ffe $e1
    ret                                                ;; 00:2fff $c9

timerActivate:
    push HL                                            ;; 00:3000 $e5
    push BC                                            ;; 00:3001 $c5
    call timerGetIndex                                 ;; 00:3002 $cd $57 $30
    set  7, [HL]                                       ;; 00:3005 $cb $fe
    pop  BC                                            ;; 00:3007 $c1
    pop  HL                                            ;; 00:3008 $e1
    ret                                                ;; 00:3009 $c9

; if called with A = ff, all timers are decremented
; otherwise returns in Z whether the timer in A is expired, and resets the expired bit
timerCheckExpiredOrTickAllTimers:
    push HL                                            ;; 00:300a $e5
    push DE                                            ;; 00:300b $d5
    inc  A                                             ;; 00:300c $3c
    jr   Z, .updateActiveTimers                        ;; 00:300d $28 $0d
    dec  A                                             ;; 00:300f $3d
    push BC                                            ;; 00:3010 $c5
    call timerGetIndex                                 ;; 00:3011 $cd $57 $30
    pop  BC                                            ;; 00:3014 $c1
    bit  1, [HL]                                       ;; 00:3015 $cb $4e
    set  1, [HL]                                       ;; 00:3017 $cb $ce
    pop  DE                                            ;; 00:3019 $d1
    pop  HL                                            ;; 00:301a $e1
    ret                                                ;; 00:301b $c9
.updateActiveTimers:
    push BC                                            ;; 00:301c $c5
    call timerGetIndex                                 ;; 00:301d $cd $57 $30
    ld   B, $10                                        ;; 00:3020 $06 $10
.loop:
    ld   A, [HL+]                                      ;; 00:3022 $2a
    rlca                                               ;; 00:3023 $07
    jr   NC, .jr_00_303a                               ;; 00:3024 $30 $14
    ld   E, [HL]                                       ;; 00:3026 $5e
    inc  HL                                            ;; 00:3027 $23
    ld   D, [HL]                                       ;; 00:3028 $56
    dec  DE                                            ;; 00:3029 $1b
    dec  HL                                            ;; 00:302a $2b
    ld   [HL], E                                       ;; 00:302b $73
    inc  HL                                            ;; 00:302c $23
    ld   [HL], D                                       ;; 00:302d $72
    ld   A, D                                          ;; 00:302e $7a
    or   A, E                                          ;; 00:302f $b3
    call Z, timerSetExpired                            ;; 00:3030 $cc $45 $30
    ld   A, D                                          ;; 00:3033 $7a
    and  A, E                                          ;; 00:3034 $a3
    inc  A                                             ;; 00:3035 $3c
    call Z, timerReset                                 ;; 00:3036 $cc $4c $30
    dec  HL                                            ;; 00:3039 $2b
.jr_00_303a:
    ld   DE, $04                                       ;; 00:303a $11 $04 $00
    add  HL, DE                                        ;; 00:303d $19
    dec  B                                             ;; 00:303e $05
    jr   NZ, .loop                                     ;; 00:303f $20 $e1
    pop  BC                                            ;; 00:3041 $c1
    pop  DE                                            ;; 00:3042 $d1
    pop  HL                                            ;; 00:3043 $e1
    ret                                                ;; 00:3044 $c9

timerSetExpired:
    dec  HL                                            ;; 00:3045 $2b
    dec  HL                                            ;; 00:3046 $2b
    res  1, [HL]                                       ;; 00:3047 $cb $8e
    inc  HL                                            ;; 00:3049 $23
    inc  HL                                            ;; 00:304a $23
    ret                                                ;; 00:304b $c9

timerReset:
    inc  HL                                            ;; 00:304c $23
    ld   E, [HL]                                       ;; 00:304d $5e
    inc  HL                                            ;; 00:304e $23
    ld   D, [HL]                                       ;; 00:304f $56
    dec  HL                                            ;; 00:3050 $2b
    dec  HL                                            ;; 00:3051 $2b
    dec  HL                                            ;; 00:3052 $2b
    ld   [HL], E                                       ;; 00:3053 $73
    inc  HL                                            ;; 00:3054 $23
    ld   [HL], D                                       ;; 00:3055 $72
    ret                                                ;; 00:3056 $c9

timerGetIndex:
    ld   H, A                                          ;; 00:3057 $67
    add  A, A                                          ;; 00:3058 $87
    add  A, A                                          ;; 00:3059 $87
    add  A, H                                          ;; 00:305a $84
    ld   C, A                                          ;; 00:305b $4f
    ld   B, $00                                        ;; 00:305c $06 $00
    ld   HL, wTimers                                   ;; 00:305e $21 $e1 $d7
    add  HL, BC                                        ;; 00:3061 $09
    ret                                                ;; 00:3062 $c9

hideAndSaveMenuMetasprites_trampoline:
    jp_to_bank 02, hideAndSaveMenuMetasprites          ;; 00:3063 $f5 $3e $08 $c3 $06 $1f
    db   $f5, $3e, $09, $c3, $06, $1f, $f5, $3e        ;; 00:3069 ????????
    db   $0a, $c3, $06, $1f, $f5, $3e, $0b, $c3        ;; 00:3071 ????????
    db   $06, $1f, $f5, $3e, $0c, $c3, $06, $1f        ;; 00:3079 ????????

loadRegisterState2_trampoline:
    jp_to_bank 02, loadRegisterState2                  ;; 00:3081 $f5 $3e $0d $c3 $06 $1f

windowInitContents_trampoline:
    jp_to_bank 02, windowInitContents                  ;; 00:3087 $f5 $3e $0e $c3 $06 $1f
    db   $f5, $3e, $0f, $c3, $06, $1f

enhancedLetterbox_trampoline:
    jp_to_bank 11, enhancedLetterbox

saveRegisterState2_trampoline:
    jp_to_bank 02, saveRegisterState2                  ;; 00:3099 $f5 $3e $11 $c3 $06 $1f

gameStateMenu_trampoline:
    jp_to_bank 02, gameStateMenu                       ;; 00:309f $f5 $3e $12 $c3 $06 $1f

windowCloseAndRestoreHidden_trampoline:
    jp_to_bank 02, windowCloseAndRestoreHidden         ;; 00:30a5 $f5 $3e $13 $c3 $06 $1f

drawWindow_trampoline:
    jp_to_bank 02, drawWindow                          ;; 00:30ab $f5 $3e $14 $c3 $06 $1f

windowMenuStartSpecial_trampoline:
    jp_to_bank 02, windowMenuStartSpecial              ;; 00:30b1 $f5 $3e $15 $c3 $06 $1f

windowPrintMenuText_trampoline:
    jp_to_bank 02, windowPrintMenuText                 ;; 00:30b7 $f5 $3e $16 $c3 $06 $1f

initStartingStatsAndTimers_trampoline:
    jp_to_bank 02, initStartingStatsAndTimers          ;; 00:30bd $f5 $3e $17 $c3 $06 $1f

giveItem_trampoline:
    jp_to_bank 02, giveItem                            ;; 00:30c3 $f5 $3e $18 $c3 $06 $1f

giveMagic_trampoline:
    jp_to_bank 02, giveMagic                           ;; 00:30c9 $f5 $3e $19 $c3 $06 $1f

giveEquipmentAndStorePowers_trampoline:
    jp_to_bank 02, giveEquipmentAndStorePowers         ;; 00:30cf $f5 $3e $1a $c3 $06 $1f

removeItemFromInventory_trampoline:
    jp_to_bank 02, removeItemFromInventory             ;; 00:30d5 $f5 $3e $1b $c3 $06 $1f

removeEquipmentFromInventory_trampoline:
    jp_to_bank 02, removeEquipmentFromInventory        ;; 00:30db $f5 $3e $1c $c3 $06 $1f

removeMagicFromInventory_trampoline:
    jp_to_bank 02, removeMagicFromInventory            ;; 00:30e1 $f5 $3e $1d $c3 $06 $1f

getEquippedHelmElementalResistances_trampoline:
    jp_to_bank 02, getEquippedHelmElementalResistances ;; 00:30e7 $f5 $3e $1e $c3 $06 $1f

getEquippedShieldBlockElements_trampoline:
    jp_to_bank 02, getEquippedShieldBlockElements      ;; 00:30ed $f5 $3e $1f $c3 $06 $1f

getEquippedWeaponBonusTypes_trampoline:
    jp_to_bank 02, getEquippedWeaponBonusTypes         ;; 00:30f3 $f5 $3e $20 $c3 $06 $1f

getSpellOrBookPower_trampoline:
    jp_to_bank 02, getSpellOrBookPower                 ;; 00:30f9 $f5 $3e $21 $c3 $06 $1f

showFullscreenWindow_trampoline:
    jp_to_bank 02, showFullscreenWindow                ;; 00:30ff $f5 $3e $22 $c3 $06 $1f
    db   $f5, $3e, $23, $c3, $06, $1f                  ;; 00:3105 ??????

drawHPOnStatusBar_trampoline:
    jp_to_bank 11, drawHPOnStatusBar                   ;; 00:310b $f5 $3e $24 $c3 $06 $1f

drawManaOnStatusBar_trampoline:
    jp_to_bank 11, drawManaOnStatusBar                 ;; 00:3111 $f5 $3e $25 $c3 $06 $1f

drawMoneyOnStatusBar_trampoline:
    jp_to_bank 11, drawMoneyOnStatusBar_new            ;; 00:3117 $f5 $3e $26 $c3 $06 $1f

doSpellOrItemEffect_trampoline:
    jp_to_bank 02, doSpellOrItemEffect                 ;; 00:311d $f5 $3e $27 $c3 $06 $1f

enhancedWarmBoot_trampoline:
    jp_to_bank 11, enhancedWarmBoot

attackWithWeaponUseWill_trampoline:
    jp_to_bank 02, attackWithWeaponUseWill             ;; 00:3129 $f5 $3e $29 $c3 $06 $1f

giveStatusEffect_trampoline:
    jp_to_bank 02, giveStatusEffect                    ;; 00:312f $f5 $3e $2a $c3 $06 $1f

windowMoveBackup_trampoline:
    jp_to_bank 02, windowMoveBackup

updateStatusEffects_trampoline:
    jp_to_bank 02, updateStatusEffects                 ;; 00:313b $f5 $3e $2c $c3 $06 $1f
    db   $f5, $3e, $2d, $c3, $06, $1f                  ;; 00:3141 ??????

drawWillBarCharge_trampoline:
    jp_to_bank 02, drawWillBarCharge                   ;; 00:3147 $f5 $3e $2e $c3 $06 $1f

drawEmptyWillBar_trampoline:
    jp_to_bank 02, drawEmptyWillBar                    ;; 00:314d $f5 $3e $2f $c3 $06 $1f

titleScreenInit_trampoline:
    jp_to_bank 02, titleScreenInit                     ;; 00:3153 $f5 $3e $30 $c3 $06 $1f

gameStateTitleScreen_trampoline:
    jp_to_bank 02, gameStateTitleScreen                ;; 00:3159 $f5 $3e $31 $c3 $06 $1f

castEquippedSpellIfSufficientMana_trampoline:
    jp_to_bank 02, castEquippedSpellIfSufficientMana   ;; 00:315f $f5 $3e $32 $c3 $06 $1f

getScriptOpcodeFunctionTrampoline:
    jp_to_bank 02, getScriptOpcodeFunction             ;; 00:3165 $f5 $3e $33 $c3 $06 $1f

clearPoisStatusEffect_trampoline:
    jp_to_bank 02, endPoisStatusEffect                 ;; 00:316b $f5 $3e $34 $c3 $06 $1f

clearDarkStatusEffect_trampoline:
    jp_to_bank 02, endDarkStatusEffect                 ;; 00:3171 $f5 $3e $35 $c3 $06 $1f

clearStonStatusEffect_trampoline:
    jp_to_bank 02, endStonStatusEffect                 ;; 00:3177 $f5 $3e $36 $c3 $06 $1f

clearMoogStatusEffect_trampoline:
    jp_to_bank 02, endMoogStatusEffect                 ;; 00:317d $f5 $3e $37 $c3 $06 $1f

clearFujiStatusEffect_trampoline:
    jp_to_bank 02, endFujiStatusEffect                 ;; 00:3183 $f5 $3e $38 $c3 $06 $1f

getEquippedArmorElementalResistances_trampoline:
    jp_to_bank 02, getEquippedArmorElementalResistances ;; 00:3189 $f5 $3e $39 $c3 $06 $1f

startScriptIfRequested:
    ld   HL, wWindowFlags                              ;; 00:318f $21 $74 $d8
    bit  7, [HL]                                       ;; 00:3192 $cb $7e
    ret  Z                                             ;; 00:3194 $c8
    ld   A, [wMainGameState]                           ;; 00:3195 $fa $a0 $c0
    ld   [wScriptMainGameStateBackup], A               ;; 00:3198 $ea $6e $d8
    ld   A, $10                                        ;; 00:319b $3e $10
    ld   [wMainGameState], A                           ;; 00:319d $ea $a0 $c0
    res  7, [HL]                                       ;; 00:31a0 $cb $be
    ld   HL, wMainGameStateFlags                       ;; 00:31a2 $21 $a1 $c0
    set  3, [HL]                                       ;; 00:31a5 $cb $de
    ld   HL, wMainGameStateFlags.nextFrame             ;; 00:31a7 $21 $a2 $c0
    set  3, [HL]                                       ;; 00:31aa $cb $de
    ret                                                ;; 00:31ac $c9

; Init script related flags and then start a script.
; Used to run scripts from directly from non-script code.
; A=Player facing direction
; C=Player collision flags
; HL=Script index
runScriptByIndex:
; First a check for script numbers larger than $7fff in order to protect against invalid room scripts.
    bit 7, h
    ret nz
    push HL                                            ;; 00:31ad $e5
    ld   HL, wMainGameStateFlags                       ;; 00:31ae $21 $a1 $c0
    bit  1, [HL]                                       ;; 00:31b1 $cb $4e
    pop  HL                                            ;; 00:31b3 $e1
    ret  NZ                                            ;; 00:31b4 $c0
    ld   [wScriptPlayerFacingDirection], A             ;; 00:31b5 $ea $73 $d8
    call setDirectionScriptFlags                       ;; 00:31b8 $cd $24 $3c
    ld   A, C                                          ;; 00:31bb $79
    ld   [wScriptTriggerCollisionFlags], A             ;; 00:31bc $ea $71 $d8
    ld   A, [wWindowFlags]                             ;; 00:31bf $fa $74 $d8
    or   A, $80                                        ;; 00:31c2 $f6 $80
    ld   [wWindowFlags], A                             ;; 00:31c4 $ea $74 $d8

; Run a script. Requires script related flags to have already been initialized.
; Handles three special script numbers that run scripts from RAM: $000b, $000f, and $0013.
; HL = script index
; Return: HL = script address
runScriptFromScriptByIndex:
    ; Text speed 2 still allows pressing a button to further speed up text display.
    ld a, TEXT_SPEED
    ld   [wTextSpeedTimer], A                          ;; 00:31c9 $ea $64 $d8
    ld   A, H                                          ;; 00:31cc $7c
    and  A, A                                          ;; 00:31cd $a7
    jr   NZ, .normal_script                            ;; 00:31ce $20 $1a
    ld   A, L                                          ;; 00:31d0 $7d
    ld   DE, wOpenChestScript1                         ;; 00:31d1 $11 $13 $d6
    sub  A, $0b                                        ;; 00:31d4 $d6 $0b
    jr   Z, .dynamic_script                            ;; 00:31d6 $28 $0e
    ld   DE, wOpenChestScript2                         ;; 00:31d8 $11 $23 $d6
    sub  A, $04                                        ;; 00:31db $d6 $04
    jr   Z, .dynamic_script                            ;; 00:31dd $28 $07
    ld   DE, wOpenChestScript3                         ;; 00:31df $11 $33 $d6
    sub  A, $04                                        ;; 00:31e2 $d6 $04
    jr   NZ, .normal_script                            ;; 00:31e4 $20 $04
.dynamic_script:
    push DE                                            ;; 00:31e6 $d5
    pop  HL                                            ;; 00:31e7 $e1
    jr   .setup_script                                 ;; 00:31e8 $18 $07
.normal_script:
    call getScriptPointerFromScriptPointerTable        ;; 00:31ea $cd $82 $32
    ld   DE, $4000 ;@=value hex=True                   ;; 00:31ed $11 $00 $40
    add  HL, DE                                        ;; 00:31f0 $19
.setup_script:
    ld   A, H                                          ;; 00:31f1 $7c
    ld   [wScriptPointerHigh], A                       ;; 00:31f2 $ea $b7 $d8
    ld   A, L                                          ;; 00:31f5 $7d
    ld   [wScriptPointerLow], A                        ;; 00:31f6 $ea $b6 $d8
    call getBankNrForScript                            ;; 00:31f9 $cd $44 $3c
    push hl
    call getNextScriptInstruction                      ;; 00:31fc $cd $27 $37
    call popBankNrAndSwitch                            ;; 00:3200 $cd $0a $2a
    ld   HL, wMainGameStateFlags                       ;; 00:3203 $21 $a1 $c0
    ld a, [hl]
    or $06
    ld [hl+], a
; wMainGameStateFlags.nextFrame
    ld a, [hl]
    or $06
    ld [hl+], a
    pop  HL                                            ;; 00:3211 $e1
    ret                                                ;; 00:3212 $c9

; Used by script commands that run the entry, exit, and all-clear scripts for a room.
; C=Player collision flags
; HL=Script index
runSubScriptFromScriptByIndex:
; Save the bank of the current script to restore later.
    ld   A, [wScriptBank]                              ;; 00:3213 $fa $6a $d8
    ld b, a
; Load the current script address (in the range $4000 to $7fff, or a RAM address).
    ld a, [wScriptPointerLow]
    ld e, a
    ld a, [wScriptPointerHigh]
    ld d, a
; An area in RAM is used for scripts. Its pointers must not be changed.
; BUG: This will be a problem in the fourth script bank.
    cp HIGH(wOpenChestScript1)
    jr z, .run_script
; Turn the address and bank of the current running script into a 16 bit pointer.
    ld a, b
    call calculateScriptPointerFromAddress
.run_script:
    push DE                                            ;; 00:322e $d5
; Initialize the new script.
    push bc
    call runScriptFromScriptByIndex                    ;; 00:322f $cd $c7 $31
    pop bc
    ld d, h
    ld e, l
    pop  HL                                            ;; 00:3234 $e1
; Now turn the address and bank of the new script into a 16 bit pointer.
    ld   A, [wScriptBank]                              ;; 00:3243 $fa $6a $d8
    call calculateScriptPointerFromAddress
; Restore original script bank, required for a calculation when pushing the old location.
    ld a, b
    ld   [wScriptBank], A                              ;; 00:3248 $ea $6a $d8
; Call the new script.
; At this point wScriptBank and hl are set with the old script, de with the new.
    ld b, $02 ; sCALL
    call callScriptAtAddressDE

gameStateScript:
    call moveObjectsDuringScript_trampoline            ;; 00:3254 $cd $b0 $28
    ld   HL, wWindowFlags                              ;; 00:3257 $21 $74 $d8
    res  0, [HL]                                       ;; 00:325a $cb $86
    jr   Z, .run_script_opcode                         ;; 00:325c $28 $02
    set  0, [HL]                                       ;; 00:325e $cb $c6
.run_script_opcode:
    call switchToScriptBank                            ;; 00:3260 $cd $60 $3c
    ld   HL, .ret_by_push                              ;; 00:3263 $21 $74 $32
    push HL                                            ;; 00:3266 $e5
    call getScriptOpcodeFunctionTrampoline             ;; 00:3267 $cd $65 $31
    push HL                                            ;; 00:326a $e5
    ld   A, [wScriptPointerHigh]                       ;; 00:326b $fa $b7 $d8
    ld   H, A                                          ;; 00:326e $67
    ld   A, [wScriptPointerLow]                        ;; 00:326f $fa $b6 $d8
    ld   L, A                                          ;; 00:3272 $6f
    ret                                                ;; 00:3273 $c9
.ret_by_push:
    ld   A, H                                          ;; 00:3274 $7c
    ld   [wScriptPointerHigh], A                       ;; 00:3275 $ea $b7 $d8
    ld   A, L                                          ;; 00:3278 $7d
    ld   [wScriptPointerLow], A                        ;; 00:3279 $ea $b6 $d8
    push HL                                            ;; 00:327c $e5
    call popBankNrAndSwitch                            ;; 00:327d $cd $0a $2a
    pop  HL                                            ;; 00:3280 $e1
    ret                                                ;; 00:3281 $c9

; Turn a memory address (including bank number) into a 16 bit script pointer covering four banks.
; a = script bank
; de = script address ($4000 to $7fff)
; Return: de = $4000 * script bank + (de & $3fff)
calculateScriptPointerFromAddress:
    push af
; And de with $3fff.
    res 7, d
    res 6, d
; Get the script bank, from 0 to 3.
    sub BANK(script_0000)
; Multiply by $4000.
    rrca
    rrca
; Add to de.
    add d
    ld d, a
    pop af
    ret

ds 8 ; Free space

; Input: HL, index in the script pointer table
; Output: HL, script pointer value
getScriptPointerFromScriptPointerTable:
    push HL                                            ;; 00:3282 $e5
    ld   A, BANK(scriptPointersTable) ;@=bank scriptPointersTable ;; 00:3283 $3e $08
    call pushBankNrAndSwitch                           ;; 00:3285 $cd $fb $29
    pop  BC                                            ;; 00:3288 $c1
    ld   HL, scriptPointersTable                       ;; 00:3289 $21 $05 $4f
    add  HL, BC                                        ;; 00:328c $09
    add  HL, BC                                        ;; 00:328d $09
    ld   A, [HL+]                                      ;; 00:328e $2a
    ld   H, [HL]                                       ;; 00:328f $66
    ld   L, A                                          ;; 00:3290 $6f
    push HL                                            ;; 00:3291 $e5
    call popBankNrAndSwitch                            ;; 00:3292 $cd $0a $2a
    pop  HL                                            ;; 00:3295 $e1
    ret                                                ;; 00:3296 $c9

; Handles end of scripts and loops.
scriptOpCodeEND:
    ld   A, [wWindowFlags]                             ;; 00:3297 $fa $74 $d8
    bit  0, A                                          ;; 00:329a $cb $47
    ret  NZ                                            ;; 00:329c $c0
    ld   A, [wScriptStackCount]                        ;; 00:329d $fa $65 $d8
    and  A, A                                          ;; 00:32a0 $a7
    jr   NZ, .script_stack_not_empty                   ;; 00:32a1 $20 $1d
    xor  A, A                                          ;; 00:32a3 $af
    ld   [wScriptCommand], A                           ;; 00:32a4 $ea $5a $d8
    ld   A, [wScriptMainGameStateBackup]               ;; 00:32a7 $fa $6e $d8
    ld   [wMainGameState], A                           ;; 00:32aa $ea $a0 $c0
    ld   HL, wMainGameStateFlags                       ;; 00:32ad $21 $a1 $c0
    res  1, [HL]                                       ;; 00:32b0 $cb $8e
    res  3, [HL]                                       ;; 00:32b2 $cb $9e
    res  2, [HL]                                       ;; 00:32b4 $cb $96
    ld   HL, wMainGameStateFlags.nextFrame             ;; 00:32b6 $21 $a2 $c0
    res  1, [HL]                                       ;; 00:32b9 $cb $8e
    res  3, [HL]                                       ;; 00:32bb $cb $9e
    res  2, [HL]                                       ;; 00:32bd $cb $96
    ret                                                ;; 00:32bf $c9
.script_stack_not_empty:
    push HL                                            ;; 00:32c0 $e5
    call popBCDEfromScriptStack                        ;; 00:32c1 $cd $05 $37
    pop  HL                                            ;; 00:32c4 $e1
    ld   A, B                                          ;; 00:32c5 $78
    cp   A, $03 ; sLOOP                                ;; 00:32c6 $fe $03
    jr   Z, .loop                                      ;; 00:32c8 $28 $19
    cp   A, $02 ; sCALL                                ;; 00:32ca $fe $02
    jr   Z, .return_from_call                          ;; 00:32cc $28 $01
    ret                                                ;; 00:32ce $c9
.return_from_call:
    push DE                                            ;; 00:32cf $d5
    pop  HL                                            ;; 00:32d0 $e1
    ld   A, H                                          ;; 00:32d1 $7c
    ld   [wScriptPointerHigh], A                       ;; 00:32d2 $ea $b7 $d8
    ld   A, L                                          ;; 00:32d5 $7d
    ld   [wScriptPointerLow], A                        ;; 00:32d6 $ea $b6 $d8
    call popBankNrAndSwitch                            ;; 00:32d9 $cd $0a $2a
    call getBankNrForScript                            ;; 00:32dc $cd $44 $3c
    call getNextScriptInstruction                      ;; 00:32df $cd $27 $37
    ret                                                ;; 00:32e2 $c9
.loop:
    dec  C                                             ;; 00:32e3 $0d
    jr   Z, .loop_end                                  ;; 00:32e4 $28 $09
    push DE                                            ;; 00:32e6 $d5
    pop  HL                                            ;; 00:32e7 $e1
    call pushBCHLtoScriptStack                         ;; 00:32e8 $cd $df $36
    call getNextScriptInstruction                      ;; 00:32eb $cd $27 $37
    ret                                                ;; 00:32ee $c9
.loop_end:
    call getNextScriptInstruction                      ;; 00:32ef $cd $27 $37
    ret                                                ;; 00:32f2 $c9

scriptOpCodeJR:
    push DE                                            ;; 00:32f3 $d5
    ld   A, [HL+]                                      ;; 00:32f4 $2a
    ld   E, A                                          ;; 00:32f5 $5f
    ld   D, $00                                        ;; 00:32f6 $16 $00
    add  HL, DE                                        ;; 00:32f8 $19
    pop  DE                                            ;; 00:32f9 $d1
    call getNextScriptInstruction                      ;; 00:32fa $cd $27 $37
    ret                                                ;; 00:32fd $c9

scriptOpCodeCall:
    ld   B, $02                                        ;; 00:32fe $06 $02
    ld   A, [HL+]                                      ;; 00:3300 $2a
    ld   D, A                                          ;; 00:3301 $57
    ld   A, [HL+]                                      ;; 00:3302 $2a
    ld   E, A                                          ;; 00:3303 $5f

; Call a new script, saving the current script position to return to after it completes.
; This assumes there is already a running script.
; DE = New script address (not index number)
; HL = Current script address
callScriptAtAddressDE:
    push DE                                            ;; 00:3304 $d5
    ld   A, H                                          ;; 00:3305 $7c
; An area in RAM is used for scripts. Its pointers must not be changed.
; BUG: This will be a problem in the fourth script bank.
    cp HIGH(wOpenChestScript1)
    jr z, .call
    ld d, h
    ld e, l
    ld a, [wScriptBank]
; Turn the address and bank of the current running script into a 16 bit pointer.
    call calculateScriptPointerFromAddress
    ld a, d
; Add $4000 to the pointer, so the first script bank is at $4000 and the fourth is at $0000..
    add $40
    ld h, a
    ld l, e
.call:
    call pushBCHLtoScriptStack                         ;; 00:3315 $cd $df $36
    pop  HL                                            ;; 00:3318 $e1
    ld a, h
    add $40
    ld   [wScriptPointerHigh], A                       ;; 00:331e $ea $b7 $d8
    ld   A, L                                          ;; 00:3321 $7d
    ld   [wScriptPointerLow], A                        ;; 00:3322 $ea $b6 $d8
    call popBankNrAndSwitch                            ;; 00:3325 $cd $0a $2a
    call getBankNrForScript                            ;; 00:3328 $cd $44 $3c
    call getNextScriptInstruction                      ;; 00:332b $cd $27 $37
    ret                                                ;; 00:332e $c9

scriptOpCodeLoop:
    call getNextScriptInstruction                      ;; 00:332f $cd $27 $37
    ld   B, $03                                        ;; 00:3332 $06 $03
    ld   C, A                                          ;; 00:3334 $4f
    inc  HL                                            ;; 00:3335 $23
    call pushBCHLtoScriptStack                         ;; 00:3336 $cd $df $36
    call getNextScriptInstruction                      ;; 00:3339 $cd $27 $37
    ret                                                ;; 00:333c $c9

scriptOpCodeMsg:
    ld   A, [HL]                                       ;; 00:333d $7e
    cp   A, $a0                                        ;; 00:333e $fe $a0
    jp   NC, scriptOpCodeMsg_HandleSimpleCharacters    ;; 00:3340 $d2 $80 $34
    cp   A, $20                                        ;; 00:3343 $fe $20
    jr   C, .jr_00_3356                                ;; 00:3345 $38 $0f
    cp   A, $70                                        ;; 00:3347 $fe $70
    jp   C, scriptOpCodeMsg_HandleDualCharacters       ;; 00:3349 $da $a4 $34
    cp   A, $80                                        ;; 00:334c $fe $80
    jp   C, scriptOpCodeMsg_HandleSimpleCharacters     ;; 00:334e $da $80 $34
    sub  A, $10                                        ;; 00:3351 $d6 $10
    jp   scriptOpCodeMsg_HandleDualCharacters          ;; 00:3353 $c3 $a4 $34
.jr_00_3356:
    and  A, A                                          ;; 00:3356 $a7
    jr   NZ, .handleCtrlCodes                          ;; 00:3357 $20 $05
    inc  HL                                            ;; 00:3359 $23
    call getNextScriptInstruction                      ;; 00:335a $cd $27 $37
    ret                                                ;; 00:335d $c9
.handleCtrlCodes:
    push HL                                            ;; 00:335e $e5
    sub  A, $10                                        ;; 00:335f $d6 $10
    ld h, a
    call getDialogTextInsertionPoint
    ld a, h
    ld hl, textCtrlCodes
    jp callJumptable

; Free space
db $00, $00, $00, $00

scriptOpCodeIfFlags:
    call getNextScriptInstruction                      ;; 00:3370 $cd $27 $37
    and  A, A                                          ;; 00:3373 $a7
    jr   Z, .jr_00_338b                                ;; 00:3374 $28 $15
    push BC                                            ;; 00:3376 $c5
    call testScriptFlag                                ;; 00:3377 $cd $ef $35
    pop  BC                                            ;; 00:337a $c1
    jr   Z, scriptOpCodeIfFlags                        ;; 00:337b $28 $f3
.jr_00_337d:
    ld   A, [HL+]                                      ;; 00:337d $2a
    and  A, A                                          ;; 00:337e $a7
    jr   NZ, .jr_00_337d                               ;; 00:337f $20 $fc
    dec  HL                                            ;; 00:3381 $2b
    call getNextScriptInstruction                      ;; 00:3382 $cd $27 $37
    ld   A, $01                                        ;; 00:3385 $3e $01
    ld   [wScriptCommand], A                           ;; 00:3387 $ea $5a $d8
    ret                                                ;; 00:338a $c9
.jr_00_338b:
    inc  HL                                            ;; 00:338b $23
    call getNextScriptInstruction                      ;; 00:338c $cd $27 $37
    ret                                                ;; 00:338f $c9

scriptOpCodeIfEquiped:
    ld   DE, wEquippedWeapon                           ;; 00:3390 $11 $e9 $d6
    ld   A, D                                          ;; 00:3393 $7a
    ld   [wItemSearchList.high], A                     ;; 00:3394 $ea $91 $d8
    ld   A, E                                          ;; 00:3397 $7b
    ld   [wItemSearchList], A                          ;; 00:3398 $ea $90 $d8
    ld   A, $07                                        ;; 00:339b $3e $07
    ld   [wSearchInventoryLength], A                   ;; 00:339d $ea $70 $d8
    call findSpellItemOrEquipment                      ;; 00:33a0 $cd $cf $33
    push AF                                            ;; 00:33a3 $f5
    call revertItemIDs                                 ;; 00:33a4 $cd $11 $34
    pop  AF                                            ;; 00:33a7 $f1
    jr   Z, jr_00_33ca                                 ;; 00:33a8 $28 $20

jr_00_33aa:
    ld   A, $01                                        ;; 00:33aa $3e $01
    ld   [wScriptCommand], A                           ;; 00:33ac $ea $5a $d8
    ret                                                ;; 00:33af $c9

scriptOpCodeIfInventory:
    ld   DE, wItemInventory                            ;; 00:33b0 $11 $c5 $d6
    ld   A, D                                          ;; 00:33b3 $7a
    ld   [wItemSearchList.high], A                     ;; 00:33b4 $ea $91 $d8
    ld   A, E                                          ;; 00:33b7 $7b
    ld   [wItemSearchList], A                          ;; 00:33b8 $ea $90 $d8
    ld   A, $2b                                        ;; 00:33bb $3e $2b
    ld   [wSearchInventoryLength], A                   ;; 00:33bd $ea $70 $d8
    call findSpellItemOrEquipment                      ;; 00:33c0 $cd $cf $33
    push AF                                            ;; 00:33c3 $f5
    call revertItemIDs                                 ;; 00:33c4 $cd $11 $34
    pop  AF                                            ;; 00:33c7 $f1
    jr   NZ, jr_00_33aa                                ;; 00:33c8 $20 $e0

jr_00_33ca:
    inc  HL                                            ;; 00:33ca $23
    call getNextScriptInstruction                      ;; 00:33cb $cd $27 $37
    ret                                                ;; 00:33ce $c9

; Spells, items, and equipment the player has are all stored with ID ranges starting at zero.
; For instance, the Cure spell, Cure item, and Broad sword are all ID zero.
; This changes the IDs into essentially indexes into one big items table, like scripts use.
; Then it searches for items given in a zero terminated list.
findSpellItemOrEquipment:
    push HL                                            ;; 00:33cf $e5
    ld   HL, wEquippedWeapon                           ;; 00:33d0 $21 $e9 $d6
    ld   B, $06                                        ;; 00:33d3 $06 $06
    ld   C, INV_SWORD_BROAD - 1                        ;; 00:33d5 $0e $41
    call addOffsetToItemIDs                            ;; 00:33d7 $cd $3f $34
    ld   HL, wEquipmentInventory                       ;; 00:33da $21 $dd $d6
    ld   B, SAVE_EQUIP_INVENTORY_SIZE                  ;; 00:33dd $06 $0c
    call addOffsetToItemIDs                            ;; 00:33df $cd $3f $34
    ld   HL, wItemInventory                            ;; 00:33e2 $21 $c5 $d6
    ld   B, SAVE_ITEM_INVENTORY_SIZE                   ;; 00:33e5 $06 $10
    ld   C, INV_ITEM_POTION_CURE - 1                   ;; 00:33e7 $0e $08
    call addOffsetToItemIDs                            ;; 00:33e9 $cd $3f $34
    pop  HL                                            ;; 00:33ec $e1
.findItemsFromList:
    ld   A, [HL+]                                      ;; 00:33ed $2a
    and  A, A                                          ;; 00:33ee $a7
    ret  Z                                             ;; 00:33ef $c8
    ld   C, A                                          ;; 00:33f0 $4f
    push HL                                            ;; 00:33f1 $e5
    ld   A, [wItemSearchList.high]                     ;; 00:33f2 $fa $91 $d8
    ld   H, A                                          ;; 00:33f5 $67
    ld   A, [wItemSearchList]                          ;; 00:33f6 $fa $90 $d8
    ld   L, A                                          ;; 00:33f9 $6f
    ld   A, [wSearchInventoryLength]                   ;; 00:33fa $fa $70 $d8
    ld   B, A                                          ;; 00:33fd $47
.loop_1:
    ld   A, [HL+]                                      ;; 00:33fe $2a
    and  A, $7f                                        ;; 00:33ff $e6 $7f
    cp   A, C                                          ;; 00:3401 $b9
    jr   Z, .jr_00_340e                                ;; 00:3402 $28 $0a
    dec  B                                             ;; 00:3404 $05
    jr   NZ, .loop_1                                   ;; 00:3405 $20 $f7
    pop  HL                                            ;; 00:3407 $e1
.loop_2:
    ld   A, [HL+]                                      ;; 00:3408 $2a
    or   A, A                                          ;; 00:3409 $b7
    jr   NZ, .loop_2                                   ;; 00:340a $20 $fc
    dec  A                                             ;; 00:340c $3d
    ret                                                ;; 00:340d $c9
.jr_00_340e:
    pop  HL                                            ;; 00:340e $e1
    jr   .findItemsFromList                            ;; 00:340f $18 $dc

revertItemIDs:
    push HL                                            ;; 00:3411 $e5
    ld   HL, wEquippedWeapon                           ;; 00:3412 $21 $e9 $d6
    ld   B, $06                                        ;; 00:3415 $06 $06
    ld   C, INV_SWORD_BROAD - 1                        ;; 00:3417 $0e $41
    call subtractOffsetFromItemIDs                     ;; 00:3419 $cd $30 $34
    ld   HL, wEquipmentInventory                       ;; 00:341c $21 $dd $d6
    ld   B, SAVE_EQUIP_INVENTORY_SIZE                  ;; 00:341f $06 $0c
    call subtractOffsetFromItemIDs                     ;; 00:3421 $cd $30 $34
    ld   HL, wItemInventory                            ;; 00:3424 $21 $c5 $d6
    ld   B, SAVE_ITEM_INVENTORY_SIZE                   ;; 00:3427 $06 $10
    ld   C, INV_ITEM_POTION_CURE - 1                   ;; 00:3429 $0e $08
    call subtractOffsetFromItemIDs                     ;; 00:342b $cd $30 $34
    pop  HL                                            ;; 00:342e $e1
    ret                                                ;; 00:342f $c9

; b = number of items
; c = offset to add
; hl = address of the first item
subtractOffsetFromItemIDs:
    ld   A, [HL]                                       ;; 00:3430 $7e
    cp   A, $80                                        ;; 00:3431 $fe $80
    jr   Z, .jr_00_343a                                ;; 00:3433 $28 $05
    and  A, A                                          ;; 00:3435 $a7
    jr   Z, .jr_00_343a                                ;; 00:3436 $28 $02
    sub  A, C                                          ;; 00:3438 $91
    ld   [HL], A                                       ;; 00:3439 $77
.jr_00_343a:
    inc  HL                                            ;; 00:343a $23
    dec  B                                             ;; 00:343b $05
    jr   NZ, subtractOffsetFromItemIDs                 ;; 00:343c $20 $f2
    ret                                                ;; 00:343e $c9

; b = number of items in the specified inventory
; c = offset to add
; hl = base address of the inventory
addOffsetToItemIDs:
    ld   A, [HL]                                       ;; 00:343f $7e
    cp   A, $80                                        ;; 00:3440 $fe $80
    jr   Z, .jr_00_3449                                ;; 00:3442 $28 $05
    and  A, A                                          ;; 00:3444 $a7
    jr   Z, .jr_00_3449                                ;; 00:3445 $28 $02
    add  A, C                                          ;; 00:3447 $81
    ld   [HL], A                                       ;; 00:3448 $77
.jr_00_3449:
    inc  HL                                            ;; 00:3449 $23
    dec  B                                             ;; 00:344a $05
    jr   NZ, addOffsetToItemIDs                        ;; 00:344b $20 $f2
    ret                                                ;; 00:344d $c9

scriptOpCodeIfTriggeredOnBy:
    ld   A, [wScriptTriggerCollisionFlags]             ;; 00:344e $fa $71 $d8
    ld   C, A                                          ;; 00:3451 $4f
    ld   A, [wScriptPlayerFacingDirection]             ;; 00:3452 $fa $73 $d8
    bit  7, A                                          ;; 00:3455 $cb $7f
    jr   NZ, jr_00_3476                                ;; 00:3457 $20 $1d
    jr   jr_00_3466                                    ;; 00:3459 $18 $0b

scriptOpCodeIfTriggeredOffBy:
    ld   A, [wScriptTriggerCollisionFlags]             ;; 00:345b $fa $71 $d8
    ld   C, A                                          ;; 00:345e $4f
    ld   A, [wScriptPlayerFacingDirection]             ;; 00:345f $fa $73 $d8
    bit  7, A                                          ;; 00:3462 $cb $7f
    jr   Z, jr_00_3476                                 ;; 00:3464 $28 $10

jr_00_3466:
    ld   A, [HL+]                                      ;; 00:3466 $2a
    and  A, A                                          ;; 00:3467 $a7
    jr   Z, jr_00_347a                                 ;; 00:3468 $28 $10
    cp   A, C                                          ;; 00:346a $b9
    jr   NZ, jr_00_3466                                ;; 00:346b $20 $f9
.jr_00_346d:
    ld   A, [HL+]                                      ;; 00:346d $2a
    and  A, A                                          ;; 00:346e $a7
    jr   NZ, .jr_00_346d                               ;; 00:346f $20 $fc
    inc  HL                                            ;; 00:3471 $23
    call getNextScriptInstruction                      ;; 00:3472 $cd $27 $37
    ret                                                ;; 00:3475 $c9

jr_00_3476:
    ld   A, [HL+]                                      ;; 00:3476 $2a
    and  A, A                                          ;; 00:3477 $a7
    jr   NZ, jr_00_3476                                ;; 00:3478 $20 $fc

jr_00_347a:
    ld   A, $01                                        ;; 00:347a $3e $01
    ld   [wScriptCommand], A                           ;; 00:347c $ea $5a $d8
    ret                                                ;; 00:347f $c9

scriptOpCodeMsg_HandleSimpleCharacters:
    call textDelay                                     ;; 00:3480 $cd $c2 $36
    ret  NZ                                            ;; 00:3483 $c0
    push HL                                            ;; 00:3484 $e5
    call loadRegisterState2_bank0                      ;; 00:3485 $cd $87 $3c
    pop  HL                                            ;; 00:3488 $e1
    call drawText                                      ;; 00:3489 $cd $77 $37
    ld   A, [wWindowTextLength]                        ;; 00:348c $fa $9b $d8
    ld   B, A                                          ;; 00:348f $47
    ld   A, [wWindowTextRows]                          ;; 00:3490 $fa $9a $d8
    ld   C, A                                          ;; 00:3493 $4f
    call saveRegisterState2_bank0                      ;; 00:3494 $cd $73 $3c
    dec  HL                                            ;; 00:3497 $2b
    ld   A, H                                          ;; 00:3498 $7c
    ld   [wScriptPointerHigh], A                       ;; 00:3499 $ea $b7 $d8
    ld   A, L                                          ;; 00:349c $7d
    ld   [wScriptPointerLow], A                        ;; 00:349d $ea $b6 $d8
    call startDialog                                   ;; 00:34a0 $cd $d0 $36
    ret                                                ;; 00:34a3 $c9

scriptOpCodeMsg_HandleDualCharacters:
    ld   B, A                                          ;; 00:34a4 $47
    push BC                                            ;; 00:34a5 $c5
    call textDelay                                     ;; 00:34a6 $cd $c2 $36
    pop  BC                                            ;; 00:34a9 $c1
    ret  NZ                                            ;; 00:34aa $c0
    ld   A, B                                          ;; 00:34ab $78
    push HL                                            ;; 00:34ac $e5
    push AF                                            ;; 00:34ad $f5
    call loadRegisterState2_bank0                      ;; 00:34ae $cd $87 $3c
    pop  AF                                            ;; 00:34b1 $f1
    ld   HL, dualCharMapping                           ;; 00:34b2 $21 $1d $3f
    sub  A, $20                                        ;; 00:34b5 $d6 $20
    add  A, A                                          ;; 00:34b7 $87
    ld   C, A                                          ;; 00:34b8 $4f
    ld   B, $00                                        ;; 00:34b9 $06 $00
    add  HL, BC                                        ;; 00:34bb $09
    ld   BC, wDualCharacterScratch                     ;; 00:34bc $01 $db $d8
    ld   A, [HL+]                                      ;; 00:34bf $2a
    ld   [BC], A                                       ;; 00:34c0 $02
    inc  BC                                            ;; 00:34c1 $03
    ld   A, [HL+]                                      ;; 00:34c2 $2a
    ld   [BC], A                                       ;; 00:34c3 $02
    inc  BC                                            ;; 00:34c4 $03
    xor  A, A                                          ;; 00:34c5 $af
    ld   [BC], A                                       ;; 00:34c6 $02
    ld   B, $00                                        ;; 00:34c7 $06 $00
    ld   A, [wDualCharacterPosition]                   ;; 00:34c9 $fa $83 $d8
    ld   HL, wDualCharacterScratch                     ;; 00:34cc $21 $db $d8
    ld   C, A                                          ;; 00:34cf $4f
    add  HL, BC                                        ;; 00:34d0 $09
    inc  A                                             ;; 00:34d1 $3c
    ld   [wDualCharacterPosition], A                   ;; 00:34d2 $ea $83 $d8
    call drawText                                      ;; 00:34d5 $cd $77 $37
    call saveRegisterState2_bank0                      ;; 00:34d8 $cd $73 $3c
    pop  HL                                            ;; 00:34db $e1
    ld   A, [wDualCharacterPosition]                   ;; 00:34dc $fa $83 $d8
    and  A, A                                          ;; 00:34df $a7
    jr   Z, .jr_00_34e3                                ;; 00:34e0 $28 $01
    dec  HL                                            ;; 00:34e2 $2b
.jr_00_34e3:
    call startDialog                                   ;; 00:34e3 $cd $d0 $36
    ret                                                ;; 00:34e6 $c9

textCtrlCodeOpenDialogWindow:
    ld   A, WINDOW_DIALOG                              ;; 00:34e7 $3e $06
    ld   [wDialogType], A                              ;; 00:34e9 $ea $4a $d8
    call windowOpenDialog                              ;; 00:34ec $cd $27 $36
    pop  HL                                            ;; 00:34ef $e1
    call Z, startDialog                                ;; 00:34f0 $cc $d0 $36
    ret                                                ;; 00:34f3 $c9

textCtrlCodeCloseDialogWindow:
    call windowCloseAndRestoreHidden_trampoline        ;; 00:34f4 $cd $a5 $30
    ld   A, [wMenuStateCurrentFunction]                ;; 00:34f7 $fa $53 $d8
    and  A, $80                                        ;; 00:34fa $e6 $80
    pop  HL                                            ;; 00:34fc $e1
    ret  NZ                                            ;; 00:34fd $c0
    call startDialog                                   ;; 00:34fe $cd $d0 $36
    ret                                                ;; 00:3501 $c9

textCtrlCodeWaitInput:
    call updateJoypadInput
    pop  HL                                            ;; 00:3505 $e1
    ld   A, C                                          ;; 00:3506 $79
    or   A, A                                          ;; 00:3507 $b7
    ret  NZ                                            ;; 00:3508 $c0
    ld   B, $04                                        ;; 00:3509 $06 $04
    call runVirtualScriptOpCodeFF                      ;; 00:350b $cd $69 $3c
    ret                                                ;; 00:350e $c9

opCodeFFWaitInput:
    call updateJoypadInput
    pop  HL                                            ;; 00:3512 $e1
    ld   A, C                                          ;; 00:3513 $79
    and  A, A                                          ;; 00:3514 $a7
    ret  Z                                             ;; 00:3515 $c8
    call startDialog                                   ;; 00:3516 $cd $d0 $36
    ret                                                ;; 00:3519 $c9

textCtrlCodeYesNo:
    push HL                                            ;; 00:351a $e5
    ld   B, $a4                                        ;; 00:351b $06 $a4
    ld   DE, wWindowBackgroundSaveBuffer.end - $a4 - 1 ;; 00:351d $11 $6e $d5
    ld   HL, wDialogX                                  ;; 00:3520 $21 $a7 $d4
    call windowMoveBackup_trampoline
    ld   A, [wMainGameState]                           ;; 00:3526 $fa $a0 $c0
    ld   [wWindowMainGameStateBackup], A               ;; 00:3529 $ea $62 $d8
    pop  HL                                            ;; 00:352c $e1
    ld   A, [HL+]                                      ;; 00:352d $2a
    ld   [wScriptSavedNextOpcode], A                   ;; 00:352e $ea $6c $d8
    ld   A, $00                                        ;; 00:3531 $3e $00
    ld   [wMenuStateCurrentFunction], A                ;; 00:3533 $ea $53 $d8
    ld   A, WINDOW_DIALOG_YES_NO                       ;; 00:3536 $3e $07
    ld   [wDialogType], A                              ;; 00:3538 $ea $4a $d8
    ld   A, $0f                                        ;; 00:353b $3e $0f
    ld   [wMainGameState], A                           ;; 00:353d $ea $a0 $c0
    ld   B, $00                                        ;; 00:3540 $06 $00
    call runVirualScriptOpCodeFFIfMenuStateCurrentFuctionBit7 ;; 00:3542 $cd $05 $3d
    pop  HL                                            ;; 00:3545 $e1
    ret                                                ;; 00:3546 $c9

yesNoWindowFinish:
    ld   B, $a4                                        ;; 00:3547 $06 $a4
    ld   DE, wDialogX                                  ;; 00:3549 $11 $a7 $d4
    ld   HL, wWindowBackgroundSaveBuffer.end - $a4 - 1 ;; 00:354c $21 $6e $d5
    call windowMoveBackup_trampoline
    ld   A, [wScriptFlags0F]                           ;; 00:3552 $fa $d5 $d7
    and  A, $fe                                        ;; 00:3555 $e6 $fe
    ld   B, A                                          ;; 00:3557 $47
    ld   A, [wSelectedMenuIndex]                       ;; 00:3558 $fa $4b $d8
    and  A, $01                                        ;; 00:355b $e6 $01
    or   A, B                                          ;; 00:355d $b0
    ld   [wScriptFlags0F], A                           ;; 00:355e $ea $d5 $d7
    ld   A, WINDOW_DIALOG                              ;; 00:3561 $3e $06
    ld   [wDialogType], A                              ;; 00:3563 $ea $4a $d8
    push AF                                            ;; 00:3566 $f5
    call getDialogTextInsertionPoint                   ;; 00:3567 $cd $4d $37
    pop  AF                                            ;; 00:356a $f1
    push BC                                            ;; 00:356b $c5
    push DE                                            ;; 00:356c $d5
    call windowInitContents_trampoline                 ;; 00:356d $cd $87 $30
    pop  DE                                            ;; 00:3570 $d1
    pop  BC                                            ;; 00:3571 $c1
    call setDialogTextInsertionPoint                   ;; 00:3572 $cd $36 $37
    call saveRegisterState2_bank0                      ;; 00:3575 $cd $73 $3c
    pop  HL                                            ;; 00:3578 $e1
    call startDialog                                   ;; 00:3579 $cd $d0 $36
    ret                                                ;; 00:357c $c9

textCtrlCodePrintHeroName:
    ld   HL, wBoyName                                  ;; 00:357d $21 $9d $d7
    jr   printName                                     ;; 00:3580 $18 $03

textCtrlCodePrintHeroineName:
    ld   HL, wGirlName                                 ;; 00:3582 $21 $a2 $d7

printName:
    ld   A, H                                          ;; 00:3585 $7c
    ld   [wRegisterSave2.H], A                         ;; 00:3586 $ea $ab $d8
    ld   A, L                                          ;; 00:3589 $7d
    ld   [wRegisterSave2], A                           ;; 00:358a $ea $aa $d8
    push BC                                            ;; 00:358d $c5
    ld   B, $01                                        ;; 00:358e $06 $01
    call runVirtualScriptOpCodeFF                      ;; 00:3590 $cd $69 $3c
    pop  BC                                            ;; 00:3593 $c1
    call saveRegisterState2_bank0                      ;; 00:3594 $cd $73 $3c

opCodeFFPrintName:
    call textDelay                                     ;; 00:3597 $cd $c2 $36
    jr   NZ, .jr_00_35ae                               ;; 00:359a $20 $12
    call loadRegisterState2_bank0                      ;; 00:359c $cd $87 $3c
    call drawText                                      ;; 00:359f $cd $77 $37
    call saveRegisterState2_bank0                      ;; 00:35a2 $cd $73 $3c
    jr   NZ, .jr_00_35ae                               ;; 00:35a5 $20 $07
    ld   A, $01                                        ;; 00:35a7 $3e $01
    ld   [wTextSpeedTimer], A                          ;; 00:35a9 $ea $64 $d8
    jr   moveInsertionPointCommon                      ;; 00:35ac $18 $36
.jr_00_35ae:
    pop  HL                                            ;; 00:35ae $e1
    ret                                                ;; 00:35af $c9

textCtrlCodeNewline:
    call loadRegisterState2_bank0                      ;; 00:35b0 $cd $87 $3c
    call menuNextItemPosition                          ;; 00:35b3 $cd $0b $38
    call saveRegisterState2_bank0                      ;; 00:35b6 $cd $73 $3c
    call setDialogTextInsertionPoint                   ;; 00:35b9 $cd $36 $37
    pop  HL                                            ;; 00:35bc $e1
    call startDialog                                   ;; 00:35bd $cd $d0 $36
    ret                                                ;; 00:35c0 $c9

textCtrlCodeClearDialog:
    call clearWindow                                   ;; 00:35c1 $cd $48 $36
    pop  HL                                            ;; 00:35c4 $e1
    ret                                                ;; 00:35c5 $c9

textCtrlCodeMoveInsertionPointRight:
    call loadRegisterState2_bank0                      ;; 00:35c6 $cd $87 $3c
    inc  E                                             ;; 00:35c9 $1c
    dec  C                                             ;; 00:35ca $0d
    jr   moveInsertionPointCommon                      ;; 00:35cb $18 $17

textCtrlCodeMoveInsertionPointLeft:
    call loadRegisterState2_bank0                      ;; 00:35cd $cd $87 $3c
    dec  E                                             ;; 00:35d0 $1d
    inc  C                                             ;; 00:35d1 $0c
    jr   moveInsertionPointCommon                      ;; 00:35d2 $18 $10

textCtrlCodeMoveInsertionPointUp:
    call loadRegisterState2_bank0                      ;; 00:35d4 $cd $87 $3c
    dec  D                                             ;; 00:35d7 $15
    dec  D                                             ;; 00:35d8 $15
    inc  B                                             ;; 00:35d9 $04
    inc  B                                             ;; 00:35da $04
    jr   moveInsertionPointCommon                      ;; 00:35db $18 $07

textCtrlCodeMoveInsertionPointDown:
    call loadRegisterState2_bank0                      ;; 00:35dd $cd $87 $3c
    inc  D                                             ;; 00:35e0 $14
    inc  D                                             ;; 00:35e1 $14
    dec  B                                             ;; 00:35e2 $05
    dec  B                                             ;; 00:35e3 $05

moveInsertionPointCommon:
    call setDialogTextInsertionPoint                   ;; 00:35e4 $cd $36 $37
    call saveRegisterState2_bank0                      ;; 00:35e7 $cd $73 $3c
    pop  HL                                            ;; 00:35ea $e1
    call startDialog                                   ;; 00:35eb $cd $d0 $36
    ret                                                ;; 00:35ee $c9

testScriptFlag:
    push HL                                            ;; 00:35ef $e5
    push AF                                            ;; 00:35f0 $f5
    call getScriptFlag                                 ;; 00:35f1 $cd $02 $36
    ld   B, A                                          ;; 00:35f4 $47
    and  A, C                                          ;; 00:35f5 $a1
    ld   C, A                                          ;; 00:35f6 $4f
    pop  AF                                            ;; 00:35f7 $f1
    pop  HL                                            ;; 00:35f8 $e1
    and  A, $80                                        ;; 00:35f9 $e6 $80
    ld   A, C                                          ;; 00:35fb $79
    jr   NZ, .jr_00_3600                               ;; 00:35fc $20 $02
    xor  A, B                                          ;; 00:35fe $a8
    ret                                                ;; 00:35ff $c9
.jr_00_3600:
    and  A, A                                          ;; 00:3600 $a7
    ret                                                ;; 00:3601 $c9

; Get a script flag
; this required a bit index in A, in the range $00-$7F
; Returned are:
; A: Got the proper bit set for the flag number
; C: Byte containing the flag
; HL: Pointer to the byte containing the flag.
getScriptFlag:
    and  A, $7f                                        ;; 00:3602 $e6 $7f
    ld   B, A                                          ;; 00:3604 $47
    ld   A, $7f                                        ;; 00:3605 $3e $7f
    sub  A, B                                          ;; 00:3607 $90
    ld   B, A                                          ;; 00:3608 $47
    srl  B                                             ;; 00:3609 $cb $38
    srl  B                                             ;; 00:360b $cb $38
    srl  B                                             ;; 00:360d $cb $38
    and  A, $07                                        ;; 00:360f $e6 $07
    push AF                                            ;; 00:3611 $f5
    ld   HL, wScriptFlags                              ;; 00:3612 $21 $c6 $d7
    ld   A, $0f                                        ;; 00:3615 $3e $0f
    sub  A, B                                          ;; 00:3617 $90
    ld   C, A                                          ;; 00:3618 $4f
    ld   B, $00                                        ;; 00:3619 $06 $00
    add  HL, BC                                        ;; 00:361b $09
    ld   C, [HL]                                       ;; 00:361c $4e
    pop  AF                                            ;; 00:361d $f1
    ld   B, A                                          ;; 00:361e $47
    inc  B                                             ;; 00:361f $04
    ld   A, $80                                        ;; 00:3620 $3e $80
.loop:
    rlca                                               ;; 00:3622 $07
    dec  B                                             ;; 00:3623 $05
    jr   NZ, .loop                                     ;; 00:3624 $20 $fc
    ret                                                ;; 00:3626 $c9

windowOpenDialog:
    call drawWindow_trampoline                         ;; 00:3627 $cd $ab $30
    ld   A, [wMenuStateCurrentFunction]                ;; 00:362a $fa $53 $d8
    and  A, $80                                        ;; 00:362d $e6 $80
    ret  NZ                                            ;; 00:362f $c0
    ld   A, [wDialogType]                              ;; 00:3630 $fa $4a $d8
    call windowInitContents_trampoline                 ;; 00:3633 $cd $87 $30
    ld   A, B                                          ;; 00:3636 $78
    ld   [wWindowTextLength], A                        ;; 00:3637 $ea $9b $d8
    ld   A, C                                          ;; 00:363a $79
    ld   [wWindowTextRows], A                          ;; 00:363b $ea $9a $d8
    ld   A, B                                          ;; 00:363e $78
    ld   [wRegisterSave2.B], A                         ;; 00:363f $ea $af $d8
    ld   A, C                                          ;; 00:3642 $79
    ld   [wRegisterSave2.C], A                         ;; 00:3643 $ea $ae $d8
    xor  A, A                                          ;; 00:3646 $af
    ret                                                ;; 00:3647 $c9

clearWindow:
    ld   HL, wDialogW                                  ;; 00:3648 $21 $a9 $d4
    ld   C, [HL]                                       ;; 00:364b $4e
    inc  HL                                            ;; 00:364c $23
    ld   B, [HL]                                       ;; 00:364d $46
    dec  B                                             ;; 00:364e $05
    dec  C                                             ;; 00:364f $0d
    ld   DE, $101                                      ;; 00:3650 $11 $01 $01
    ld   A, D                                          ;; 00:3653 $7a
    ld   [wWindowClearY], A                            ;; 00:3654 $ea $b3 $d8
    ld   A, E                                          ;; 00:3657 $7b
    ld   [wWindowClearX], A                            ;; 00:3658 $ea $b2 $d8
    ld   A, B                                          ;; 00:365b $78
    ld   [wWindowClearH], A                            ;; 00:365c $ea $b5 $d8
    ld   A, C                                          ;; 00:365f $79
    ld   [wWindowClearW], A                            ;; 00:3660 $ea $b4 $d8
    ld   A, $1e                                        ;; 00:3663 $3e $1e
    ld   [wMenuStateCurrentFunction], A                ;; 00:3665 $ea $53 $d8
    ld   B, $02                                        ;; 00:3668 $06 $02
    call runVirtualScriptOpCodeFF                      ;; 00:366a $cd $69 $3c
    ld   A, [wDialogType]                              ;; 00:366d $fa $4a $d8
    cp   A, WINDOW_START_MENU                          ;; 00:3670 $fe $00
    jr   Z, jr_00_36a8                                 ;; 00:3672 $28 $34
    ret                                                ;; 00:3674 $c9

windowClearRectangle:
    ld   A, [wWindowClearY]                            ;; 00:3675 $fa $b3 $d8
    ld   D, A                                          ;; 00:3678 $57
    ld   A, [wWindowClearX]                            ;; 00:3679 $fa $b2 $d8
    ld   E, A                                          ;; 00:367c $5f
    ld   A, [wWindowClearH]                            ;; 00:367d $fa $b5 $d8
    ld   B, A                                          ;; 00:3680 $47
    ld   A, [wWindowClearW]                            ;; 00:3681 $fa $b4 $d8
    ld   C, A                                          ;; 00:3684 $4f
    push BC                                            ;; 00:3685 $c5
    push DE                                            ;; 00:3686 $d5
.loop:
    ld   A, $7f                                        ;; 00:3687 $3e $7f
    call storeTileAatDialogPositionDE                  ;; 00:3689 $cd $44 $38
    inc  E                                             ;; 00:368c $1c
    dec  C                                             ;; 00:368d $0d
    jr   NZ, .loop                                     ;; 00:368e $20 $f7
    pop  DE                                            ;; 00:3690 $d1
    pop  BC                                            ;; 00:3691 $c1
    inc  D                                             ;; 00:3692 $14
    dec  B                                             ;; 00:3693 $05
    push AF                                            ;; 00:3694 $f5
    ld   A, D                                          ;; 00:3695 $7a
    ld   [wWindowClearY], A                            ;; 00:3696 $ea $b3 $d8
    ld   A, E                                          ;; 00:3699 $7b
    ld   [wWindowClearX], A                            ;; 00:369a $ea $b2 $d8
    ld   A, B                                          ;; 00:369d $78
    ld   [wWindowClearH], A                            ;; 00:369e $ea $b5 $d8
    ld   A, C                                          ;; 00:36a1 $79
    ld   [wWindowClearW], A                            ;; 00:36a2 $ea $b4 $d8
    pop  AF                                            ;; 00:36a5 $f1
    pop  HL                                            ;; 00:36a6 $e1
    ret  NZ                                            ;; 00:36a7 $c0

jr_00_36a8:
    ld   A, $1f                                        ;; 00:36a8 $3e $1f
    ld   [wMenuStateCurrentFunction], A                ;; 00:36aa $ea $53 $d8
    call startDialog                                   ;; 00:36ad $cd $d0 $36
    ld   A, [wWindowTextLength]                        ;; 00:36b0 $fa $9b $d8
    ld   B, A                                          ;; 00:36b3 $47
    ld   A, [wWindowTextRows]                          ;; 00:36b4 $fa $9a $d8
    ld   C, A                                          ;; 00:36b7 $4f
    ld   DE, $201                                      ;; 00:36b8 $11 $01 $02
    call setDialogTextInsertionPoint                   ;; 00:36bb $cd $36 $37
    call saveRegisterState2_bank0                      ;; 00:36be $cd $73 $3c
    ret                                                ;; 00:36c1 $c9

textDelay:
    ld   A, [wTextSpeedTimer]                          ;; 00:36c2 $fa $64 $d8
    dec  A                                             ;; 00:36c5 $3d
    ld   [wTextSpeedTimer], A                          ;; 00:36c6 $ea $64 $d8
    ret  NZ                                            ;; 00:36c9 $c0
    ; Text speed 2 still allows pressing a button to further speed up text display.
    ld a, TEXT_SPEED
    ld   [wTextSpeedTimer], A                          ;; 00:36cc $ea $64 $d8
    ret                                                ;; 00:36cf $c9

; Start a dialog, which runs an sTXT opcode internally.
startDialog:
    inc  HL                                            ;; 00:36d0 $23
    ld   A, H                                          ;; 00:36d1 $7c
    ld   [wScriptPointerHigh], A                       ;; 00:36d2 $ea $b7 $d8
    ld   A, L                                          ;; 00:36d5 $7d
    ld   [wScriptPointerLow], A                        ;; 00:36d6 $ea $b6 $d8
    ld   A, $04                                        ;; 00:36d9 $3e $04
    ld   [wScriptCommand], A                           ;; 00:36db $ea $5a $d8
    ret                                                ;; 00:36de $c9

; Push 4 bytes to the script stack.
; b = opcode number ($02 == sCALL or $03 == sLOOP)
; c = loop counter, if used by a loop.
; hl = script address
; Return: bc, hl unmodified.
pushBCHLtoScriptStack:
    ld d, h
    ld e, l
; Load the script stack pointer.
    ld hl, wScriptStackPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
; Pre-decrement.
    dec hl
; Push hl (now in de).
    ld a, d
    ld [hl-], a
    ld a, e
    ld [hl-], a
; Push bc.
    ld a, b
    ld [hl-], a
    ld [hl], c
; Store the pointer to the top of the script stack.
    ld a, l
    ld [wScriptStackPointer], a
    ld a, h
    ld [wScriptStackPointer.high], a
; Increment the stack count.
    ld hl, wScriptStackCount
    inc [hl]
; Restore hl to the original value.
    ld h, d
    ld l, e
    ret

ds 7 ; Free space

; pop 4 bytes from the script stack.
; Return: b = saved opcode number ($02 == sCALL or $03 == sLOOP)
; Return: c = saved loop counter, if used by a loop.
; Return: hl = saved script address
popBCDEfromScriptStack:
; Load pointer to top item on the script stack.
    ld hl, wScriptStackPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
; Pop bc.
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
; Pop de.
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
; Store the pointer to the top of the script stack.
    ld a, l
    ld [wScriptStackPointer], a
    ld a, h
    ld [wScriptStackPointer.high], a
; Decrement the stack count.
    ld hl, wScriptStackCount
    dec [hl]
    ret

ds 7 ; Free space

; Advance to the next byte in a script.
; Return: a = next byte, hl = incremented script pointer
getNextScriptInstruction:
    inc hl
    ld a, l
    ld [wScriptPointerLow], a
    ld a, h
    ld [wScriptPointerHigh], a
    dec hl
    ld a, [hl+]
    ld [wScriptCommand], a
    ret

; Return: Z set for dialog, clear for other windows.
setDialogTextInsertionPoint:
    ld   A, [wDialogType]                              ;; 00:3736 $fa $4a $d8
    cp   A, WINDOW_DIALOG                              ;; 00:3739 $fe $06
    ret  NZ                                            ;; 00:373b $c0
    ld   A, D                                          ;; 00:373c $7a
    ld   [wWindowTextInsertionPointY], A               ;; 00:373d $ea $b9 $d8
    ld   A, E                                          ;; 00:3740 $7b
    ld   [wWindowTextInsertionPointX], A               ;; 00:3741 $ea $b8 $d8
    ld   A, B                                          ;; 00:3744 $78
    ld   [wWindowTextLinesLeft], A                     ;; 00:3745 $ea $bb $d8
    ld   A, C                                          ;; 00:3748 $79
    ld   [wWindowTextSpaceLeftOnLine], A               ;; 00:3749 $ea $ba $d8
    ret                                                ;; 00:374c $c9

; Return: Z set and DE BC set to distance from edges if the current window is dialog.
getDialogTextInsertionPoint:
    ld   A, [wDialogType]                              ;; 00:374d $fa $4a $d8
    cp   A, WINDOW_DIALOG                              ;; 00:3750 $fe $06
    ret  NZ                                            ;; 00:3752 $c0
    ld   A, [wWindowTextInsertionPointY]               ;; 00:3753 $fa $b9 $d8
    ld   D, A                                          ;; 00:3756 $57
    ld   A, [wWindowTextInsertionPointX]               ;; 00:3757 $fa $b8 $d8
    ld   E, A                                          ;; 00:375a $5f
    ld   A, [wWindowTextLinesLeft]                     ;; 00:375b $fa $bb $d8
    ld   B, A                                          ;; 00:375e $47
    ld   A, [wWindowTextSpaceLeftOnLine]               ;; 00:375f $fa $ba $d8
    ld   C, A                                          ;; 00:3762 $4f
    ret                                                ;; 00:3763 $c9

    db   $d5, $3e, $7f, $15, $cd, $44, $38, $14        ;; 00:3764 ????????
    db   $3e, $7f, $cd, $44, $38, $1c, $05, $20        ;; 00:376c ????????
    db   $f0, $d1, $c9                                 ;; 00:3774 ???

; Draw text
; HL = pointer to text
; DE = position on the open window (overridden for the dialog window)
; B = size of text to draw (but not always?, whole interaction is more complex)
drawText:
    call getDialogTextInsertionPoint                   ;; 00:3777 $cd $4d $37
.loop_1:
    push AF                                            ;; 00:377a $f5
    ld   A, [HL+]                                      ;; 00:377b $2a
; The original range was $7f (copyright symbol) or $a0 and greater.
; New range is $70 to $7f or $a0 and greater, which means $0f additional glyphs..
; Except $70 to $7f has to have $20 added to them to map to the correct glyph.
; For scripts it's instead just $90 and greater.
; I don't remember why this discrepancy exists but my notes say there was a bug to work around.
    cp   A, $70                                        ;; 00:377c $fe $7f
    jr   c, .terminator                                ;; 00:377e $28 $05
    cp   A, $a0                                        ;; 00:3780 $fe $a0
    jr nc, .print
    cp a, $80
    jr nc, .terminator
    add a, $20
.print:
    xor  A, $80                                        ;; 00:3794 $ee $80
    call storeTileAatDialogPositionDE                  ;; 00:3796 $cd $44 $38
    ld   A, [wDialogType]                              ;; 00:3799 $fa $4a $d8
    cp   A, WINDOW_NAMING_SCREEN_BOTTOM                ;; 00:379c $fe $1e
    jr   NZ, .checkIntro                               ;; 00:379e $20 $01
; Naming screen puts a space between each character
    inc  E                                             ;; 00:37a0 $1c
.checkIntro:
    inc a
    jr nz, .checkDialog
    dec d
    ld a, $7f
    call storeTileAatDialogPositionDE
    inc d
.checkDialog:
    pop  AF                                            ;; 00:37a1 $f1
; Windows other than the script dialog window print continuously until finished.
    jr   NZ, .print_more_text                          ;; 00:37a2 $20 $14
    ld   A, [wWindowFlags]                             ;; 00:37a4 $fa $74 $d8
    bit  1, A                                          ;; 00:37a7 $cb $4f
    jr   NZ, .finished                                 ;; 00:37a9 $20 $29
    push HL                                            ;; 00:37ab $e5
    push DE                                            ;; 00:37ac $d5
    push BC                                            ;; 00:37ad $c5
    call updateJoypadInput
    ld   A, B                                          ;; 00:37b1 $78
    or   A, C                                          ;; 00:37b2 $b1
    pop  BC                                            ;; 00:37b3 $c1
    pop  DE                                            ;; 00:37b4 $d1
    pop  HL                                            ;; 00:37b5 $e1
    jr   Z, .finished                                  ;; 00:37b6 $28 $1c
.print_more_text:
    inc  E                                             ;; 00:37b8 $1c
    dec  B                                             ;; 00:37b9 $05
    jr   NZ, .loop_1                                   ;; 00:37ba $20 $be
    ld   A, D                                          ;; 00:37bc $7a
    ld   [wWindowTextInsertionPointFinalY], A          ;; 00:37bd $ea $c6 $d8
    ld   A, E                                          ;; 00:37c0 $7b
    ld   [wWindowTextInsertionPointFinalX], A          ;; 00:37c1 $ea $c5 $d8
    ld   A, [wDialogType]                              ;; 00:37c4 $fa $4a $d8
    cp   A, WINDOW_DIALOG                              ;; 00:37c7 $fe $06
    call NZ, menuNextItemPosition                      ;; 00:37c9 $c4 $0b $38
    xor  A, A                                          ;; 00:37cc $af
    ld   [wDualCharacterPosition], A                   ;; 00:37cd $ea $83 $d8
    call setDialogTextInsertionPoint                   ;; 00:37d0 $cd $36 $37
    ret                                                ;; 00:37d3 $c9
.finished:
    inc  E                                             ;; 00:37d4 $1c
    dec  B                                             ;; 00:37d5 $05
    push AF                                            ;; 00:37d6 $f5
    call setDialogTextInsertionPoint                   ;; 00:37d7 $cd $36 $37
    pop  AF                                            ;; 00:37da $f1
    ret                                                ;; 00:37db $c9
.terminator:
    ld   A, D                                          ;; 00:37dc $7a
    ld   [wWindowTextInsertionPointFinalY], A          ;; 00:37dd $ea $c6 $d8
    ld   A, E                                          ;; 00:37e0 $7b
    ld   [wWindowTextInsertionPointFinalX], A          ;; 00:37e1 $ea $c5 $d8
    call setDialogTextInsertionPoint                   ;; 00:37e4 $cd $36 $37
    jr   Z, .jr_00_3804                                ;; 00:37e7 $28 $1b
    ld   A, [wDialogType]                              ;; 00:37e9 $fa $4a $d8
    cp   A, WINDOW_SELECT_MENU                         ;; 00:37ec $fe $11
    jr   Z, .jr_00_3800                                ;; 00:37ee $28 $10
.loop_2:
    dec  D                                             ;; 00:37f0 $15
    ld   A, $7f                                        ;; 00:37f1 $3e $7f
    call storeTileAatDialogPositionDE                  ;; 00:37f3 $cd $44 $38
    inc  D                                             ;; 00:37f6 $14
    ld   A, $7f                                        ;; 00:37f7 $3e $7f
    call storeTileAatDialogPositionDE                  ;; 00:37f9 $cd $44 $38
    inc  E                                             ;; 00:37fc $1c
    dec  B                                             ;; 00:37fd $05
    jr   NZ, .loop_2                                   ;; 00:37fe $20 $f0
.jr_00_3800:
    call menuNextItemPosition                          ;; 00:3800 $cd $0b $38
    inc  HL                                            ;; 00:3803 $23
.jr_00_3804:
    dec  HL                                            ;; 00:3804 $2b
    xor  A, A                                          ;; 00:3805 $af
    ld   [wDualCharacterPosition], A                   ;; 00:3806 $ea $83 $d8
    pop  AF                                            ;; 00:3809 $f1
    ret                                                ;; 00:380a $c9

; Handles special cases for the SELECT menu (three columns), the dialog and intro scroll (less indented).
menuNextItemPosition:
    ld   A, [wWindowTextLength]                        ;; 00:380b $fa $9b $d8
    ld   B, A                                          ;; 00:380e $47
    ld   A, [wMenuFlags]                               ;; 00:380f $fa $49 $d8
    rrca                                               ;; 00:3812 $0f
    jr   NC, .new_line                                 ;; 00:3813 $30 $17
    ld   A, [wDialogType]                              ;; 00:3815 $fa $4a $d8
    cp   A, WINDOW_SELECT_MENU                         ;; 00:3818 $fe $11
    jr   Z, .jr_00_3827                                ;; 00:381a $28 $0b
    ld   A, [wDialogW]                                 ;; 00:381c $fa $a9 $d4
    inc  A                                             ;; 00:381f $3c
    inc  A                                             ;; 00:3820 $3c
    srl  A                                             ;; 00:3821 $cb $3f
    cp   A, E                                          ;; 00:3823 $bb
    jr   C, .new_line                                  ;; 00:3824 $38 $06
    ld   E, A                                          ;; 00:3826 $5f
.jr_00_3827:
    inc  E                                             ;; 00:3827 $1c
    call saveRegisterState2_bank0                      ;; 00:3828 $cd $73 $3c
    ret                                                ;; 00:382b $c9
.new_line:
    ld   E, $02                                        ;; 00:382c $1e $02
    ld   A, [wDialogType]                              ;; 00:382e $fa $4a $d8
    cp   A, WINDOW_INTRO_SCROLL                        ;; 00:3831 $fe $ff
    jr   Z, .small_indent                              ;; 00:3833 $28 $04
    cp   A, WINDOW_DIALOG                              ;; 00:3835 $fe $06
    jr   NZ, .jr_00_383b                               ;; 00:3837 $20 $02
.small_indent:
    ld   E, $01                                        ;; 00:3839 $1e $01
.jr_00_383b:
    inc  D                                             ;; 00:383b $14
    inc  D                                             ;; 00:383c $14
    dec  C                                             ;; 00:383d $0d
    push AF                                            ;; 00:383e $f5
    call saveRegisterState2_bank0                      ;; 00:383f $cd $73 $3c
    pop  AF                                            ;; 00:3842 $f1
    ret                                                ;; 00:3843 $c9

storeTileAatDialogPositionDE:
    push DE                                            ;; 00:3844 $d5
    push AF                                            ;; 00:3845 $f5
    ld   A, [wDialogX]                                 ;; 00:3846 $fa $a7 $d4
    add  A, E                                          ;; 00:3849 $83
    ld   E, A                                          ;; 00:384a $5f
    ld   A, [wDialogY]                                 ;; 00:384b $fa $a8 $d4
    add  A, D                                          ;; 00:384e $82
    ld   D, A                                          ;; 00:384f $57
    pop  AF                                            ;; 00:3850 $f1
    call storeTileAatScreenPositionDE                  ;; 00:3851 $cd $91 $38
    pop  DE                                            ;; 00:3854 $d1
    ret                                                ;; 00:3855 $c9
    db   $d5, $fa, $a7, $d4, $83, $5f, $fa, $a8        ;; 00:3856 ????????
    db   $d4, $82, $57, $cd, $a7, $38, $d1, $c9        ;; 00:385e ????????

storeTileAatWindowPositionDE:
    push BC                                            ;; 00:3866 $c5
    push AF                                            ;; 00:3867 $f5
    call windowTilePositionToScreenTilePosition        ;; 00:3868 $cd $7a $38
    pop  AF                                            ;; 00:386b $f1
    call storeTileAatScreenPositionDE                  ;; 00:386c $cd $91 $38
    pop  BC                                            ;; 00:386f $c1
    ret                                                ;; 00:3870 $c9
    db   $c5, $cd, $7a, $38, $cd, $a7, $38, $c1        ;; 00:3871 ????????
    db   $c9                                           ;; 00:3879 ?

windowTilePositionToScreenTilePosition:
    ld   A, [wVideoWY]                                 ;; 00:387a $fa $a9 $c0
    srl  A                                             ;; 00:387d $cb $3f
    srl  A                                             ;; 00:387f $cb $3f
    srl  A                                             ;; 00:3881 $cb $3f
    add  A, D                                          ;; 00:3883 $82
    ld   D, A                                          ;; 00:3884 $57
    ld   A, [wVideoWX]                                 ;; 00:3885 $fa $a8 $c0
    srl  A                                             ;; 00:3888 $cb $3f
    srl  A                                             ;; 00:388a $cb $3f
    srl  A                                             ;; 00:388c $cb $3f
    add  A, E                                          ;; 00:388e $83
    ld   E, A                                          ;; 00:388f $5f
    ret                                                ;; 00:3890 $c9

; a = tile id
; de = Y and X tile positions on screen
; For the color target it always uses BGP_SPECIAL by xor to zero.
storeTileAatScreenPositionDE:
    push hl
    push af
    call tilePositionToVRAMAddress
.loop:
    ldh a, [rSTAT]
    and STATF_BUSY
    jr nz, .loop
IF DEF(COLOR)
    ld a, $01
    ldh [rVBK], a
    xor a
    ld [hl], a
    ldh [rVBK], a
ENDC
    pop af
    ld [hl], a
    pop hl
    ret

ds 12 ; Free space

; Convert de (Y,X) screen tile position into VRAM memory location.
; Takes into account window position and the position of screen scrolling.
; de = Y and X tile positions on screen
; Return: hl = VRAM address, de unmodified
tilePositionToVRAMAddress:
    ld a, d
; Muliply y by eight for comparison to pixel position of the window.
    add a
    add a
    add a
; Compare to rWY.
    ld hl, wVideoWY
    cp [hl]
    jr nc, .window
; Adjust for any y offset.
    ld a, [wBackgroundDrawPositionY]
    add d
; Mask top three bits because the title screen is weird.
    and $1f
; Multiply again.
    add a
    add a
    add a
    ld l, a
; Tile coordinates need to be multiplied by 8 to get pixels for comparison and $20 to get a line address. $20/8=4.
    ld h, high(_SCRN0 / 4)
; Adjust for any x offset.
    ld a, [wBackgroundDrawPositionX]
    jr .ready
.window:
    sub [hl]
    ld h, high(_SCRN1 / 4)
    ld l, a
    xor a
.ready:
; Multiply by four.
    add hl, hl
    add hl, hl
; Add x.
    add e
; Mask top three bits just in case since this is what the original code did.
    and $1f
    add l
    ld l, a
    ret

SECTION "bank00_align_38de", ROM0[$38de]

; A jumptable implemented as a script opcode.
; Never used directly from scripts, but it gets used from code.
; Sort of a virtual script opcode.
scriptOpCodeFF:
    push HL                                            ;; 00:38de $e5
    ld   A, [wVirtualScriptOpCodeFFArgument]           ;; 00:38df $fa $6b $d8
    ld   HL, scriptOpCodeFFJumpTable                   ;; 00:38e2 $21 $a1 $3b
    jp callJumptable

ds 6 ; Free space

;@jumptable amount=16
textCtrlCodes:
    dw   textCtrlCodeOpenDialogWindow                  ;; 00:38ee pP $00
    dw   textCtrlCodeCloseDialogWindow                 ;; 00:38f0 pP $01
    dw   textCtrlCodeWaitInput                         ;; 00:38f2 pP $02
    dw   textCtrlCodeYesNo                             ;; 00:38f4 pP $03
    dw   textCtrlCodePrintHeroName                     ;; 00:38f6 pP $04
    dw   textCtrlCodePrintHeroineName                  ;; 00:38f8 pP $05
    dw   $0000                                         ;; 00:38fa ?? $06
    dw   $0000                                         ;; 00:38fc ?? $07
    dw   $0000                                         ;; 00:38fe ?? $08
    dw   $0000                                         ;; 00:3900 ?? $09
    dw   textCtrlCodeNewline                           ;; 00:3902 pP $0a
    dw   textCtrlCodeClearDialog                       ;; 00:3904 pP $0b
    dw   textCtrlCodeMoveInsertionPointRight           ;; 00:3906 ?? $0c
    dw   textCtrlCodeMoveInsertionPointLeft            ;; 00:3908 ?? $0d
    dw   textCtrlCodeMoveInsertionPointUp              ;; 00:390a ?? $0e
    dw   textCtrlCodeMoveInsertionPointDown            ;; 00:390c ?? $0f

scriptOpCodeSetChestOpenScript1:
    ld   A, [HL+]                                      ;; 00:390e $2a
    ld   D, A                                          ;; 00:390f $57
    ld   A, [HL+]                                      ;; 00:3910 $2a
    ld   E, A                                          ;; 00:3911 $5f
    ld   BC, wOpenChestScript1                         ;; 00:3912 $01 $13 $d6
    call writeCallScriptHLAtBC                         ;; 00:3915 $cd $2f $39
    ret                                                ;; 00:3918 $c9

scriptOpCodeSetChestOpenScript2:
    ld   A, [HL+]                                      ;; 00:3919 $2a
    ld   D, A                                          ;; 00:391a $57
    ld   A, [HL+]                                      ;; 00:391b $2a
    ld   E, A                                          ;; 00:391c $5f
    ld   BC, wOpenChestScript2                         ;; 00:391d $01 $23 $d6
    call writeCallScriptHLAtBC                         ;; 00:3920 $cd $2f $39
    ret                                                ;; 00:3923 $c9

scriptOpCodeSetChestOpenScript3:
    ld   A, [HL+]                                      ;; 00:3924 $2a
    ld   D, A                                          ;; 00:3925 $57
    ld   A, [HL+]                                      ;; 00:3926 $2a
    ld   E, A                                          ;; 00:3927 $5f
    ld   BC, wOpenChestScript3                         ;; 00:3928 $01 $33 $d6
    call writeCallScriptHLAtBC                         ;; 00:392b $cd $2f $39
    ret                                                ;; 00:392e $c9

writeCallScriptHLAtBC:
    push HL                                            ;; 00:392f $e5
    push BC                                            ;; 00:3930 $c5
    ld   H, D                                          ;; 00:3931 $62
    ld   L, E                                          ;; 00:3932 $6b
    call getScriptPointerFromScriptPointerTable        ;; 00:3933 $cd $82 $32
    ld   D, H                                          ;; 00:3936 $54
    ld   E, L                                          ;; 00:3937 $5d
    pop  HL                                            ;; 00:3938 $e1
    ld   A, $02                                        ;; 00:3939 $3e $02
    ld   [HL+], A                                      ;; 00:393b $22
    ld   A, D                                          ;; 00:393c $7a
    ld   [HL+], A                                      ;; 00:393d $22
    ld   A, E                                          ;; 00:393e $7b
    ld   [HL+], A                                      ;; 00:393f $22
    ld   [HL], $00                                     ;; 00:3940 $36 $00
    pop  HL                                            ;; 00:3942 $e1
    call getNextScriptInstruction                      ;; 00:3943 $cd $27 $37
    ret                                                ;; 00:3946 $c9

scriptOpCodeFullHealDummyFA:
    ld   A, [wMaxHPHigh]                               ;; 00:3947 $fa $b5 $d7
    ld   D, A                                          ;; 00:394a $57
    ld   A, [wMaxHPLow]                                ;; 00:394b $fa $b4 $d7
    ld   E, A                                          ;; 00:394e $5f
    ld   A, D                                          ;; 00:394f $7a
    ld   [wHPHigh], A                                  ;; 00:3950 $ea $b3 $d7
    ld   A, E                                          ;; 00:3953 $7b
    ld   [wHPLow], A                                   ;; 00:3954 $ea $b2 $d7
    push HL                                            ;; 00:3957 $e5
    call drawHPOnStatusBar_trampoline                  ;; 00:3958 $cd $0b $31
    pop  HL                                            ;; 00:395b $e1
    call getNextScriptInstruction                      ;; 00:395c $cd $27 $37
    ret                                                ;; 00:395f $c9

scriptOpCodeFullMana:
    ld   A, [wMaxManaHigh]                             ;; 00:3960 $fa $b9 $d7
    ld   D, A                                          ;; 00:3963 $57
    ld   A, [wMaxManaLow]                              ;; 00:3964 $fa $b8 $d7
    ld   E, A                                          ;; 00:3967 $5f
    ld   A, D                                          ;; 00:3968 $7a
    ld   [wManaHigh], A                                ;; 00:3969 $ea $b7 $d7
    ld   A, E                                          ;; 00:396c $7b
    ld   [wManaLow], A                                 ;; 00:396d $ea $b6 $d7
    push HL                                            ;; 00:3970 $e5
    call drawManaOnStatusBar_trampoline                ;; 00:3971 $cd $11 $31
    pop  HL                                            ;; 00:3974 $e1
    call getNextScriptInstruction                      ;; 00:3975 $cd $27 $37
    ret                                                ;; 00:3978 $c9

scriptOpCodeClearStatus:
    ld   A, [HL+]                                      ;; 00:3979 $2a
    cpl                                                ;; 00:397a $2f
    ld   C, A                                          ;; 00:397b $4f
    push HL                                            ;; 00:397c $e5
    bit  0, C                                          ;; 00:397d $cb $41
    call Z, clearPoisStatusEffect_trampoline           ;; 00:397f $cc $6b $31
    bit  1, C                                          ;; 00:3982 $cb $49
    call Z, clearDarkStatusEffect_trampoline           ;; 00:3984 $cc $71 $31
    bit  2, C                                          ;; 00:3987 $cb $51
    call Z, clearStonStatusEffect_trampoline           ;; 00:3989 $cc $77 $31
    bit  3, C                                          ;; 00:398c $cb $59
    call Z, clearMoogStatusEffect_trampoline           ;; 00:398e $cc $7d $31
    bit  4, C                                          ;; 00:3991 $cb $61
    call Z, clearFujiStatusEffect_trampoline           ;; 00:3993 $cc $83 $31
    pop  HL                                            ;; 00:3996 $e1
    call getNextScriptInstruction                      ;; 00:3997 $cd $27 $37
    ret                                                ;; 00:399a $c9

scriptOpCodeGiveStatus:
    ld   A, [HL+]                                      ;; 00:399b $2a
    push HL                                            ;; 00:399c $e5
    call giveStatusEffect_trampoline                   ;; 00:399d $cd $2f $31
    ld   B, $09                                        ;; 00:39a0 $06 $09
    call runVirualScriptOpCodeFFIfMenuStateCurrentFuctionBit7 ;; 00:39a2 $cd $05 $3d
    pop  HL                                            ;; 00:39a5 $e1
    ret                                                ;; 00:39a6 $c9

copyMainGameStateBackupFromScriptToWindow:
    ld   A, [wScriptMainGameStateBackup]               ;; 00:39a7 $fa $6e $d8
    ld   [wWindowMainGameStateBackup], A               ;; 00:39aa $ea $62 $d8
    pop  HL                                            ;; 00:39ad $e1
    call getNextScriptInstruction                      ;; 00:39ae $cd $27 $37
    ret                                                ;; 00:39b1 $c9

scriptOpCodeRNG:
    push HL                                            ;; 00:39b2 $e5
    call getRandomByte                                 ;; 00:39b3 $cd $1e $2b
    and  A, $03                                        ;; 00:39b6 $e6 $03
    ld   B, A                                          ;; 00:39b8 $47
    ld   A, [wScriptFlags0F]                           ;; 00:39b9 $fa $d5 $d7
    and  A, $fc                                        ;; 00:39bc $e6 $fc
    or   A, B                                          ;; 00:39be $b0
    ld   [wScriptFlags0F], A                           ;; 00:39bf $ea $d5 $d7
    pop  HL                                            ;; 00:39c2 $e1
    call getNextScriptInstruction                      ;; 00:39c3 $cd $27 $37
    ret                                                ;; 00:39c6 $c9

scriptOpCodeStartNameEntry:
    push HL                                            ;; 00:39c7 $e5
    xor  A, A                                          ;; 00:39c8 $af
    ld   [wScriptMainGameStateBackup], A               ;; 00:39c9 $ea $6e $d8
    ld   A, [wMainGameState]                           ;; 00:39cc $fa $a0 $c0
    ld   [wWindowMainGameStateBackup], A               ;; 00:39cf $ea $62 $d8
    ld   A, [HL+]                                      ;; 00:39d2 $2a
    ld   [wScriptSavedNextOpcode], A                   ;; 00:39d3 $ea $6c $d8
    call showFullscreenWindow_trampoline               ;; 00:39d6 $cd $ff $30
    ld   A, $01                                        ;; 00:39d9 $3e $01
    ld   [wMenuStateCurrentFunction], A                ;; 00:39db $ea $53 $d8
    ld   A, WINDOW_NAMING_SCREEN_TOP                   ;; 00:39de $3e $1d
    ld   [wDialogType], A                              ;; 00:39e0 $ea $4a $d8
    ld   A, $0f                                        ;; 00:39e3 $3e $0f
    ld   [wMainGameState], A                           ;; 00:39e5 $ea $a0 $c0
    xor  A, A                                          ;; 00:39ed $af
    ld   [wNameEntryNameLength], A                     ;; 00:39ee $ea $85 $d8
    ld   HL, wSRAMSaveHeader                           ;; 00:39f1 $21 $a7 $d7
    ld   B, SAVE_MAX_NAME_LENGTH                       ;; 00:39f4 $06 $04
.loop:
    ld   [HL+], A                                      ;; 00:39f6 $22
    dec  B                                             ;; 00:39f7 $05
    jr   NZ, .loop                                     ;; 00:39f8 $20 $fc
    ld   B, $05                                        ;; 00:39fa $06 $05
    call runVirualScriptOpCodeFFIfMenuStateCurrentFuctionBit7 ;; 00:39fc $cd $05 $3d
    pop  HL                                            ;; 00:39ff $e1
    ret                                                ;; 00:3a00 $c9

ds 5 ; Free space

scriptOpCodeAltNOP:
    call getNextScriptInstruction                      ;; 00:3a01 $cd $27 $37
    ret                                                ;; 00:3a04 $c9

scriptOpCodeGiveXP:
    ld   E, [HL]                                       ;; 00:3a05 $5e
    inc  HL                                            ;; 00:3a06 $23
    ld   D, [HL]                                       ;; 00:3a07 $56
    inc  HL                                            ;; 00:3a08 $23
    push HL                                            ;; 00:3a09 $e5
    push DE                                            ;; 00:3a0a $d5
    pop  HL                                            ;; 00:3a0b $e1
    call addXP                                         ;; 00:3a0c $cd $16 $3d
    pop  HL                                            ;; 00:3a0f $e1
    call getNextScriptInstruction                      ;; 00:3a10 $cd $27 $37
    ret                                                ;; 00:3a13 $c9

; Unused
scriptOpCodeTakeXP:
    ld   E, [HL]                                       ;; 00:3a14 $5e
    inc  HL                                            ;; 00:3a15 $23
    ld   D, [HL]                                       ;; 00:3a16 $56
    inc  HL                                            ;; 00:3a17 $23
    push HL                                            ;; 00:3a18 $e5
    ld   A, [wXPHigh]                                  ;; 00:3a19 $fa $bc $d7
    ld   H, A                                          ;; 00:3a1c $67
    ld   A, [wXPLow]                                   ;; 00:3a1d $fa $bb $d7
    ld   L, A                                          ;; 00:3a20 $6f
    ld   A, [wXPHighExt]                               ;; 00:3a21 $fa $bd $d7
    ld   C, A                                          ;; 00:3a24 $4f
    ld   A, L                                          ;; 00:3a25 $7d
    sub  A, E                                          ;; 00:3a26 $93
    ld   L, A                                          ;; 00:3a27 $6f
    ld   A, H                                          ;; 00:3a28 $7c
    sbc  A, D                                          ;; 00:3a29 $9a
    ld   H, A                                          ;; 00:3a2a $67
    ld   A, C                                          ;; 00:3a2b $79
    sbc  A, $00                                        ;; 00:3a2c $de $00
    ld   C, A                                          ;; 00:3a2e $4f
    jr   NC, .jr_00_3a36                               ;; 00:3a2f $30 $05
    ld   HL, $00                                       ;; 00:3a31 $21 $00 $00
    ld   C, $00                                        ;; 00:3a34 $0e $00
.jr_00_3a36:
    ld   A, H                                          ;; 00:3a36 $7c
    ld   [wXPHigh], A                                  ;; 00:3a37 $ea $bc $d7
    ld   A, L                                          ;; 00:3a3a $7d
    ld   [wXPLow], A                                   ;; 00:3a3b $ea $bb $d7
    ld   A, C                                          ;; 00:3a3e $79
    ld   [wXPHighExt], A                               ;; 00:3a3f $ea $bd $d7
    pop  HL                                            ;; 00:3a42 $e1
    call getNextScriptInstruction                      ;; 00:3a43 $cd $27 $37
    ret                                                ;; 00:3a46 $c9

scriptOpCodeGiveMoney:
    ld   E, [HL]                                       ;; 00:3a47 $5e
    inc  HL                                            ;; 00:3a48 $23
    ld   D, [HL]                                       ;; 00:3a49 $56
    inc  HL                                            ;; 00:3a4a $23
    push HL                                            ;; 00:3a4b $e5
    ld   H, D
    ld   L, E
    call addMoney
    pop  HL                                            ;; 00:3a65 $e1
    call getNextScriptInstruction                      ;; 00:3a66 $cd $27 $37
    ret                                                ;; 00:3a69 $c9

scriptOpCodeTakeMoney:
    ld   E, [HL]                                       ;; 00:3a6a $5e
    inc  HL                                            ;; 00:3a6b $23
    ld   D, [HL]                                       ;; 00:3a6c $56
    inc  HL                                            ;; 00:3a6d $23
    push HL                                            ;; 00:3a6e $e5
    ld   A, [wMoneyHigh]                               ;; 00:3a6f $fa $bf $d7
    ld   H, A                                          ;; 00:3a72 $67
    ld   A, [wMoneyLow]                                ;; 00:3a73 $fa $be $d7
    ld   L, A                                          ;; 00:3a76 $6f
    sub  A, E                                          ;; 00:3a78 $93
    ld   L, A                                          ;; 00:3a79 $6f
    ld   A, H                                          ;; 00:3a7a $7c
    sbc  A, D                                          ;; 00:3a7b $9a
    ld   H, A                                          ;; 00:3a7c $67
    jr   NC, .have_enough                              ;; 00:3a7d $30 $07
    push HL
    ld   HL, wStatusEffect
    bit  7, [HL]
    jr   NZ, .unset_rich_flag
    pop  HL
    ld   A, $06                                        ;; 00:3a7f $3e $06
    call setScriptFlag                                 ;; 00:3a81 $cd $e4 $3b
    jr   .draw_and_continue
.unset_rich_flag:
    res  7, [HL]
    pop  HL
.have_enough:
    ld   A, H                                          ;; 00:3a86 $7c
    ld   [wMoneyHigh], A                               ;; 00:3a87 $ea $bf $d7
    ld   A, L                                          ;; 00:3a8a $7d
    ld   [wMoneyLow], A                                ;; 00:3a8b $ea $be $d7
    ld   A, $06                                        ;; 00:3a8e $3e $06
    call clearScriptFlag                               ;; 00:3a90 $cd $ee $3b
.draw_and_continue:
    call drawMoneyOnStatusBar_trampoline                ;; 00:3a93 $cd $17 $31
    pop  HL                                            ;; 00:3a96 $e1
    call getNextScriptInstruction                      ;; 00:3a97 $cd $27 $37
    ret                                                ;; 00:3a9a $c9
    db   $00, $00, $00, $00, $00, $00, $00, $00
    db   $00

scriptOpCodeHalt:
    dec  HL                                            ;; 00:3a9b $2b
    call getNextScriptInstruction                      ;; 00:3a9c $cd $27 $37
    ret                                                ;; 00:3a9f $c9

scriptOpCodeGiveItem:
    ld   A, [HL+]                                      ;; 00:3aa0 $2a
    inc  A                                             ;; 00:3aa1 $3c
    push HL                                            ;; 00:3aa2 $e5
    call giveItem_trampoline                           ;; 00:3aa3 $cd $c3 $30
    pop  HL                                            ;; 00:3aa6 $e1
    ld   A, [wMiscFlags]                               ;; 00:3aa7 $fa $6f $d8
    bit  1, A                                          ;; 00:3aaa $cb $4f
    jr   NZ, scriptGivesCantCarry                      ;; 00:3aac $20 $28
    call getNextScriptInstruction                      ;; 00:3aae $cd $27 $37
    ret                                                ;; 00:3ab1 $c9

scriptOpCodeGiveMagic:
    ld   A, [HL+]                                      ;; 00:3ab2 $2a
    inc  A                                             ;; 00:3ab3 $3c
    push HL                                            ;; 00:3ab4 $e5
    call giveMagic_trampoline                          ;; 00:3ab5 $cd $c9 $30
    pop  HL                                            ;; 00:3ab8 $e1
    ld   A, [wMiscFlags]                               ;; 00:3ab9 $fa $6f $d8
    bit  1, A                                          ;; 00:3abc $cb $4f
    jr   NZ, scriptGivesCantCarry                      ;; 00:3abe $20 $16
    call getNextScriptInstruction                      ;; 00:3ac0 $cd $27 $37
    ret                                                ;; 00:3ac3 $c9

scriptOpCodeGiveEquipment:
    ld   A, [HL+]                                      ;; 00:3ac4 $2a
    inc  A                                             ;; 00:3ac5 $3c
    push HL                                            ;; 00:3ac6 $e5
    call giveEquipmentAndStorePowers_trampoline        ;; 00:3ac7 $cd $cf $30
    pop  HL                                            ;; 00:3aca $e1
    ld   A, [wMiscFlags]                               ;; 00:3acb $fa $6f $d8
    bit  1, A                                          ;; 00:3ace $cb $4f
    jr   NZ, scriptGivesCantCarry                      ;; 00:3ad0 $20 $04
    call getNextScriptInstruction                      ;; 00:3ad2 $cd $27 $37
    ret                                                ;; 00:3ad5 $c9

scriptGivesCantCarry:
    ld   A, $05                                        ;; 00:3ad6 $3e $05
    call setScriptFlag                                 ;; 00:3ad8 $cd $e4 $3b
    push HL                                            ;; 00:3adb $e5
    ld   A, WINDOW_DIALOG                              ;; 00:3adc $3e $06
    ld   [wDialogType], A                              ;; 00:3ade $ea $4a $d8
    call windowOpenDialog                              ;; 00:3ae1 $cd $27 $36
    pop  HL                                            ;; 00:3ae4 $e1
    dec  HL                                            ;; 00:3ae5 $2b
    ret  NZ                                            ;; 00:3ae6 $c0
    inc  HL                                            ;; 00:3ae7 $23
    ld   B, $06                                        ;; 00:3ae8 $06 $06
    call runVirtualScriptOpCodeFF                      ;; 00:3aea $cd $69 $3c
    ret                                                ;; 00:3aed $c9

vendorCantCarry:
    ld   A, WINDOW_VENDOR_TEXT_TOP                     ;; 00:3aee $3e $0f
    ld   [wDialogType], A                              ;; 00:3af0 $ea $4a $d8
    ld   HL, cantCarryTextLabel                        ;; 00:3af3 $21 $10 $3f
    ld   A, [wWindowTextLength]                        ;; 00:3af6 $fa $9b $d8
    ld   B, A                                          ;; 00:3af9 $47
    ld   A, [wWindowTextRows]                          ;; 00:3afa $fa $9a $d8
    ld   C, A                                          ;; 00:3afd $4f
    dec  B                                             ;; 00:3afe $05
    dec  B                                             ;; 00:3aff $05
    ld   DE, $202                                      ;; 00:3b00 $11 $02 $02
    call drawText                                      ;; 00:3b03 $cd $77 $37
    pop  HL                                            ;; 00:3b06 $e1
    ld   B, $07                                        ;; 00:3b07 $06 $07
    call runVirtualScriptOpCodeFF                      ;; 00:3b09 $cd $69 $3c
    ret                                                ;; 00:3b0c $c9

opCodeFFWaitCantCarry:
    pop  HL                                            ;; 00:3b10 $e1
; Joypad input is in d and e.
    ld   A, D                                          ;; 00:3b11 $7a
    and  A, E                                          ;; 00:3b12 $a3
    ret  Z                                             ;; 00:3b13 $c8
    push HL                                            ;; 00:3b14 $e5
    ld   HL, wMiscFlags                                ;; 00:3b15 $21 $6f $d8
    res  1, [HL]                                       ;; 00:3b18 $cb $8e
    pop  HL                                            ;; 00:3b1a $e1
    ld   B, $08                                        ;; 00:3b1b $06 $08
    call runVirtualScriptOpCodeFF                      ;; 00:3b1d $cd $69 $3c
    ret                                                ;; 00:3b20 $c9

ds 3 ; Free space

opCodeFFCloseWindow:
    call windowCloseAndRestoreHidden_trampoline        ;; 00:3b21 $cd $a5 $30
    ld   A, [wMenuStateCurrentFunction]                ;; 00:3b24 $fa $53 $d8
    and  A, $80                                        ;; 00:3b27 $e6 $80
    pop  HL                                            ;; 00:3b29 $e1
    ret  NZ                                            ;; 00:3b2a $c0
    call getNextScriptInstruction                      ;; 00:3b2b $cd $27 $37
    ret                                                ;; 00:3b2e $c9

scriptOpCodeRemoveItemFromInventory:
    ld   A, [HL+]                                      ;; 00:3b2f $2a
    inc  A                                             ;; 00:3b30 $3c
    push HL                                            ;; 00:3b31 $e5
    call removeItemFromInventory_trampoline            ;; 00:3b32 $cd $d5 $30
    pop  HL                                            ;; 00:3b35 $e1
    call getNextScriptInstruction                      ;; 00:3b36 $cd $27 $37
    ret                                                ;; 00:3b39 $c9

scriptOpCodeRemoveMagicFromInventory:
    ld   A, [HL+]                                      ;; 00:3b3a $2a
    inc  A                                             ;; 00:3b3b $3c
    push HL                                            ;; 00:3b3c $e5
    call removeMagicFromInventory_trampoline           ;; 00:3b3d $cd $e1 $30
    pop  HL                                            ;; 00:3b40 $e1
    call getNextScriptInstruction                      ;; 00:3b41 $cd $27 $37
    ret                                                ;; 00:3b44 $c9

scriptOpCodeRemoveEquipmentFromInventory:
    ld   A, [HL+]                                      ;; 00:3b45 $2a
    inc  A                                             ;; 00:3b46 $3c
    push HL                                            ;; 00:3b47 $e5
    call removeEquipmentFromInventory_trampoline       ;; 00:3b48 $cd $db $30
    pop  HL                                            ;; 00:3b4b $e1
    call getNextScriptInstruction                      ;; 00:3b4c $cd $27 $37
    ret                                                ;; 00:3b4f $c9

scriptOpCodeTextSpeedLockOn:
    push HL                                            ;; 00:3b50 $e5
    ld   HL, wWindowFlags                              ;; 00:3b51 $21 $74 $d8
    set  1, [HL]                                       ;; 00:3b54 $cb $ce
    pop  HL                                            ;; 00:3b56 $e1
    call getNextScriptInstruction                      ;; 00:3b57 $cd $27 $37
    ret                                                ;; 00:3b5a $c9

scriptOpCodeTextSpeedLockOff:
    push HL                                            ;; 00:3b5b $e5
    ld   HL, wWindowFlags                              ;; 00:3b5c $21 $74 $d8
    res  1, [HL]                                       ;; 00:3b5f $cb $8e
    pop  HL                                            ;; 00:3b61 $e1
    call getNextScriptInstruction                      ;; 00:3b62 $cd $27 $37
    ret                                                ;; 00:3b65 $c9

scriptOpCodeSetLocationFlags:
    ld   A, [HL+]                                      ;; 00:3b66 $2a
    and  A, $3f                                        ;; 00:3b67 $e6 $3f
    ld   C, A                                          ;; 00:3b69 $4f
    ld   DE, wScriptFlags0E                            ;; 00:3b6a $11 $d4 $d7
    ld   A, [DE]                                       ;; 00:3b6d $1a
    and  A, $c0                                        ;; 00:3b6e $e6 $c0
    or   A, C                                          ;; 00:3b70 $b1
    ld   [DE], A                                       ;; 00:3b71 $12
    call getNextScriptInstruction                      ;; 00:3b72 $cd $27 $37
    ret                                                ;; 00:3b75 $c9

scriptOpCodeTakeEquipedItem:
    push HL                                            ;; 00:3b76 $e5
    ld   HL, wEquippedItemAmount                       ;; 00:3b77 $21 $f0 $d6
    ld   A, [HL]                                       ;; 00:3b7a $7e
    and  A, A                                          ;; 00:3b7b $a7
    jr   Z, .jr_00_3b81                                ;; 00:3b7c $28 $03
    dec  [HL]                                          ;; 00:3b7e $35
    jr   NZ, .jr_00_3b99                               ;; 00:3b7f $20 $18
.jr_00_3b81:
    ld   A, $80                                        ;; 00:3b81 $3e $80
    ld   [wEquippedItem], A                            ;; 00:3b83 $ea $ef $d6
    ld   [wEquippedItemAndWeaponCopy], A               ;; 00:3b86 $ea $f1 $d6
    ld   HL, wItemInventory                            ;; 00:3b89 $21 $c5 $d6
    ld   B, SAVE_ITEM_INVENTORY_SIZE + SAVE_MAGIC_INVENTORY_SIZE ;; 00:3b8c $06 $18
.loop:
    ld   A, [HL+]                                      ;; 00:3b8e $2a
    cp   A, $80                                        ;; 00:3b8f $fe $80
    jr   Z, .jr_00_3b96                                ;; 00:3b91 $28 $03
    dec  B                                             ;; 00:3b93 $05
    jr   NZ, .loop                                     ;; 00:3b94 $20 $f8
.jr_00_3b96:
    xor  A, A                                          ;; 00:3b96 $af
    dec  HL                                            ;; 00:3b97 $2b
    ld   [HL], A                                       ;; 00:3b98 $77
.jr_00_3b99:
    pop  HL                                            ;; 00:3b99 $e1
    call getNextScriptInstruction                      ;; 00:3b9a $cd $27 $37
    ret                                                ;; 00:3b9d $c9

; Used when you die.
scriptOpCodeResetGame:
    ld hl, debugMsgGameOver
    call logger.hl
    jp   FullReset                                     ;; 00:3b9e $c3 $50 $01

;@jumptable amount=11
scriptOpCodeFFJumpTable:
    dw   yesNoWindowFinish                             ;; 00:3ba1 pP $00
    dw   opCodeFFPrintName                             ;; 00:3ba3 pP $01
    dw   windowClearRectangle                          ;; 00:3ba5 pP $02
    dw   checkScriptDelayTimer                         ;; 00:3ba7 pP $03
    dw   opCodeFFWaitInput                             ;; 00:3ba9 pP $04
    dw   scriptResumeAfterWindow                       ;; 00:3bab pP $05
    dw   vendorCantCarry                               ;; 00:3bad ?? $06
    dw   opCodeFFWaitCantCarry                         ;; 00:3baf ?? $07
    dw   opCodeFFCloseWindow                           ;; 00:3bb1 ?? $08
    dw   copyMainGameStateBackupFromScriptToWindow     ;; 00:3bb3 pP $09
    dw   opCodeFFPrintMenuText                         ;; 00:3bb5 ?? $0a

; Clears the boy and girl name, and all the script flags.
clearNamesAndScriptFlags:
    ld   HL, wBoyName                                  ;; 00:3bb7 $21 $9d $d7
    ld   B, $0a                                        ;; 00:3bba $06 $0a
    xor  A, A                                          ;; 00:3bbc $af
    call fillMemory
    ld   HL, wScriptFlags                              ;; 00:3bc1 $21 $c6 $d7
    ld   B, $10                                        ;; 00:3bc4 $06 $10
    call fillMemory
    ret                                                ;; 00:3bca $c9

opCodeFFPrintMenuText:
    pop  HL                                            ;; 00:3bcb $e1
    call windowPrintMenuText_trampoline                ;; 00:3bcc $cd $b7 $30
    ret                                                ;; 00:3bcf $c9

scriptOpCodeSetFlag:
    ld a, [hl+]
    call setScriptFlag                                 ;; 00:3bd3 $cd $e4 $3b
    call getNextScriptInstruction                      ;; 00:3bd6 $cd $27 $37
    ret                                                ;; 00:3bd9 $c9

scriptOpCodeClearFlag:
    ld a, [hl+]
    call clearScriptFlag                               ;; 00:3bdd $cd $ee $3b
    call getNextScriptInstruction                      ;; 00:3be0 $cd $27 $37
    ret                                                ;; 00:3be3 $c9

; Set the script flag indicated by A
setScriptFlag:
    push HL                                            ;; 00:3be4 $e5
    push BC                                            ;; 00:3be5 $c5
    call getScriptFlag                                 ;; 00:3be6 $cd $02 $36
    or   A, C                                          ;; 00:3be9 $b1
    ld   [HL], A                                       ;; 00:3bea $77
    pop  BC                                            ;; 00:3beb $c1
    pop  HL                                            ;; 00:3bec $e1
    ret                                                ;; 00:3bed $c9

; Clear the script flag incated by A
clearScriptFlag:
    push HL                                            ;; 00:3bee $e5
    push BC                                            ;; 00:3bef $c5
    call getScriptFlag                                 ;; 00:3bf0 $cd $02 $36
    cpl                                                ;; 00:3bf3 $2f
    and  A, C                                          ;; 00:3bf4 $a1
    ld   [HL], A                                       ;; 00:3bf5 $77
    pop  BC                                            ;; 00:3bf6 $c1
    pop  HL                                            ;; 00:3bf7 $e1
    ret                                                ;; 00:3bf8 $c9

scriptOpCodeDelay:
    call getNextScriptInstruction                      ;; 00:3bf9 $cd $27 $37
    push HL                                            ;; 00:3bfc $e5
    ld   H, $00                                        ;; 00:3bfd $26 $00
    ld   L, A                                          ;; 00:3bff $6f
    call timerNew                                      ;; 00:3c00 $cd $9e $2f
    ld   [wScriptDelayOpCodeTimerNumber], A            ;; 00:3c03 $ea $4d $d8
    call timerStart                                    ;; 00:3c06 $cd $d4 $2f
    ld   B, $03                                        ;; 00:3c09 $06 $03
    call runVirtualScriptOpCodeFF                      ;; 00:3c0b $cd $69 $3c
    pop  HL                                            ;; 00:3c0e $e1
    ret                                                ;; 00:3c0f $c9

checkScriptDelayTimer:
    ld   A, [wScriptDelayOpCodeTimerNumber]            ;; 00:3c10 $fa $4d $d8
    call timerCheckExpiredOrTickAllTimers              ;; 00:3c13 $cd $0a $30
    pop  HL                                            ;; 00:3c16 $e1
    ret  NZ                                            ;; 00:3c17 $c0
    push HL                                            ;; 00:3c18 $e5
    ld   A, [wScriptDelayOpCodeTimerNumber]            ;; 00:3c19 $fa $4d $d8
    call timerFree                                     ;; 00:3c1c $cd $ca $2f
    pop  HL                                            ;; 00:3c1f $e1
    call getNextScriptInstruction                      ;; 00:3c20 $cd $27 $37
    ret                                                ;; 00:3c23 $c9

setDirectionScriptFlags:
    push BC                                            ;; 00:3c24 $c5
    ld   B, $04                                        ;; 00:3c25 $06 $04
    ld   C, $00                                        ;; 00:3c27 $0e $00
.loop:
    rrca                                               ;; 00:3c29 $0f
    rl   C                                             ;; 00:3c2a $cb $11
    dec  B                                             ;; 00:3c2c $05
    jr   NZ, .loop                                     ;; 00:3c2d $20 $fa
    rl   C                                             ;; 00:3c2f $cb $11
    rl   C                                             ;; 00:3c31 $cb $11
    rl   C                                             ;; 00:3c33 $cb $11
    ld   A, [wScriptFlags]                             ;; 00:3c35 $fa $c6 $d7
    and  A, $87                                        ;; 00:3c38 $e6 $87
    ld   B, A                                          ;; 00:3c3a $47
    ld   A, C                                          ;; 00:3c3b $79
    and  A, $78                                        ;; 00:3c3c $e6 $78
    or   A, B                                          ;; 00:3c3e $b0
    ld   [wScriptFlags], A                             ;; 00:3c3f $ea $c6 $d7
    pop  BC                                            ;; 00:3c42 $c1
    ret                                                ;; 00:3c43 $c9

; Calculates the bank and address for the current script pointer and switches to the bank.
getBankNrForScript:
; Load the script pointer.
    ld hl, wScriptPointerHigh
    ld a, [hl-]
    ld l, [hl]
    ld h, a
; An area in RAM is used for scripts. Its pointers must not be changed.
; BUG: This will be a problem in the fourth script bank.
    cp HIGH(wOpenChestScript1)
    jr z, switchToScriptBank
; Subtract bank size and increment bank number until the address is between $0000 and $3fff.
    ld b, BANK(script_0000) - 1
.loop:
    inc b
    sub $40
    cp $40
    jr nc, .loop
; Correct the address to between $4000 and $7fff.
    add $40
    ld   H, A                                          ;; 00:3c5b $67
; Set the script bank.
    ld   A, B                                          ;; 00:3c5c $78
    ld   [wScriptBank], A                              ;; 00:3c5d $ea $6a $d8

; Switch to the bank of the current script.
switchToScriptBank:
    ld   A, [wScriptBank]                              ;; 00:3c60 $fa $6a $d8
    push HL                                            ;; 00:3c63 $e5
    call pushBankNrAndSwitch                           ;; 00:3c64 $cd $fb $29
    pop  HL                                            ;; 00:3c67 $e1
    ret                                                ;; 00:3c68 $c9

ds 2 ; Free space

runVirtualScriptOpCodeFF:
    ld   A, B                                          ;; 00:3c69 $78
    ld   [wVirtualScriptOpCodeFFArgument], A           ;; 00:3c6a $ea $6b $d8
    ld   A, $ff                                        ;; 00:3c6d $3e $ff
    ld   [wScriptCommand], A                           ;; 00:3c6f $ea $5a $d8
    ret                                                ;; 00:3c72 $c9

; Trampoline handling does not preserve the value of F, so F is fixed after the call.
saveRegisterState2_bank0:
    push AF                                            ;; 00:3c73 $f5
    push AF                                            ;; 00:3c74 $f5
    call saveRegisterState2_trampoline                 ;; 00:3c75 $cd $99 $30
    pop  AF                                            ;; 00:3c78 $f1
    push BC                                            ;; 00:3c79 $c5
    push AF                                            ;; 00:3c7a $f5
    pop  BC                                            ;; 00:3c7b $c1
    ld   A, B                                          ;; 00:3c7c $78
    ld   [wRegisterSave2.A], A                         ;; 00:3c7d $ea $b1 $d8
    ld   A, C                                          ;; 00:3c80 $79
    ld   [wRegisterSave2.F], A                         ;; 00:3c81 $ea $b0 $d8
    pop  BC                                            ;; 00:3c84 $c1
    pop  AF                                            ;; 00:3c85 $f1
    ret                                                ;; 00:3c86 $c9

; Trampoline handling does not preserve the value of F, so F is fixed after the call.
loadRegisterState2_bank0:
    call loadRegisterState2_trampoline                 ;; 00:3c87 $cd $81 $30
    push BC                                            ;; 00:3c8a $c5
    ld   A, [wRegisterSave2.A]                         ;; 00:3c8b $fa $b1 $d8
    ld   B, A                                          ;; 00:3c8e $47
    ld   A, [wRegisterSave2.F]                         ;; 00:3c8f $fa $b0 $d8
    ld   C, A                                          ;; 00:3c92 $4f
    push BC                                            ;; 00:3c93 $c5
    pop  AF                                            ;; 00:3c94 $f1
    pop  BC                                            ;; 00:3c95 $c1
    ret                                                ;; 00:3c96 $c9

scriptOpCodeOpenShop:
    push HL                                            ;; 00:3c97 $e5
    ld   A, [wMainGameState]                           ;; 00:3c98 $fa $a0 $c0
    ld   [wWindowMainGameStateBackup], A               ;; 00:3c9b $ea $62 $d8
    ld   A, [HL+]                                      ;; 00:3c9e $2a
    ld   [wVendorNumber], A                            ;; 00:3c9f $ea $6d $d8
    ld   A, [HL+]                                      ;; 00:3ca2 $2a
    ld   [wScriptSavedNextOpcode], A                   ;; 00:3ca3 $ea $6c $d8
    call showFullscreenWindow_trampoline               ;; 00:3ca6 $cd $ff $30
    ld   HL, wWindowVendorSellPointerSavedX            ;; 00:3ca9 $21 $d7 $d8
    xor  A, A                                          ;; 00:3cac $af
    ld   B, $04                                        ;; 00:3cad $06 $04
.loop:
    ld   [HL+], A                                      ;; 00:3caf $22
    dec  B                                             ;; 00:3cb0 $05
    jr   NZ, .loop                                     ;; 00:3cb1 $20 $fc
    ld   [wWindowVendorSellItemIndex], A               ;; 00:3cb3 $ea $76 $d8
    ld   A, $02                                        ;; 00:3cb6 $3e $02
    ld   [wWindowVendorSellPointerSavedY], A           ;; 00:3cb8 $ea $d8 $d8
    ld   A, $01                                        ;; 00:3cbb $3e $01
    ld   [wMenuStateCurrentFunction], A                ;; 00:3cbd $ea $53 $d8
    ld   A, WINDOW_VENDOR_TEXT_TOP                     ;; 00:3cc0 $3e $0f
    ld   [wDialogType], A                              ;; 00:3cc2 $ea $4a $d8
    ld   A, $0f                                        ;; 00:3cc5 $3e $0f
    ld   [wMainGameState], A                           ;; 00:3cc7 $ea $a0 $c0
    ld   B, $05                                        ;; 00:3cca $06 $05
    call runVirualScriptOpCodeFFIfMenuStateCurrentFuctionBit7 ;; 00:3ccc $cd $05 $3d
    pop  HL                                            ;; 00:3ccf $e1
    ret                                                ;; 00:3cd0 $c9

scriptResumeAfterWindow:
    ld   A, [wVideoWYBackup]                           ;; 00:3cd1 $fa $84 $d8
    ld   [wVideoWY], A                                 ;; 00:3cd4 $ea $a9 $c0
    ld   A, [wScriptSavedNextOpcode]                   ;; 00:3cd7 $fa $6c $d8
    ld   [wScriptCommand], A                           ;; 00:3cda $ea $5a $d8
    ld   DE, $00                                       ;; 00:3cdd $11 $00 $00
    ld   HL, $1214                                     ;; 00:3ce0 $21 $14 $12
    call showSpritesBehindWindow_trampoline            ;; 00:3ce3 $cd $35 $04
    ld   A, [wScriptMainGameStateBackup]               ;; 00:3ce6 $fa $6e $d8
    ld   [wWindowMainGameStateBackup], A               ;; 00:3ce9 $ea $62 $d8
    pop  HL                                            ;; 00:3cec $e1
    inc  HL                                            ;; 00:3ced $23
    inc  HL                                            ;; 00:3cee $23
    ld   A, H                                          ;; 00:3cef $7c
    ld   [wScriptPointerHigh], A                       ;; 00:3cf0 $ea $b7 $d8
    ld   A, L                                          ;; 00:3cf3 $7d
    ld   [wScriptPointerLow], A                        ;; 00:3cf4 $ea $b6 $d8
    ld   A, [wDialogType]                              ;; 00:3cf7 $fa $4a $d8
    cp   A, WINDOW_NAMING_SCREEN_BOTTOM                ;; 00:3cfa $fe $1e
    call Z, getNextScriptInstruction                   ;; 00:3cfc $cc $27 $37
    jr   Z, .here                                      ;; 00:3cff $28 $00
.here:
    call hideAndSaveMenuMetasprites_trampoline         ;; 00:3d01 $cd $63 $30
    ret                                                ;; 00:3d04 $c9

runVirualScriptOpCodeFFIfMenuStateCurrentFuctionBit7:
    ld   A, [wMenuStateCurrentFunction]                ;; 00:3d05 $fa $53 $d8
    rlca                                               ;; 00:3d08 $07
    ret  C                                             ;; 00:3d09 $d8
    call runVirtualScriptOpCodeFF                      ;; 00:3d0a $cd $69 $3c
    ret                                                ;; 00:3d0d $c9

getTotalAP:
    ld   A, [wDupTotalAP]                              ;; 00:3d0e $fa $c1 $d6
    ret                                                ;; 00:3d11 $c9

getTotalDP:
    ld   A, [wDupTotalDP]                              ;; 00:3d12 $fa $c3 $d6
    ret                                                ;; 00:3d15 $c9

; Add HL to the amount of XP the player has.
; Maximum XP is $0f423f (999999)
addXP:
    push DE                                            ;; 00:3d16 $d5
    ld   A, [wXPHigh]                                  ;; 00:3d17 $fa $bc $d7
    ld   D, A                                          ;; 00:3d1a $57
    ld   A, [wXPLow]                                   ;; 00:3d1b $fa $bb $d7
    ld   E, A                                          ;; 00:3d1e $5f
    ld   A, [wXPHighExt]                               ;; 00:3d1f $fa $bd $d7
    add  HL, DE                                        ;; 00:3d22 $19
    adc  A, $00                                        ;; 00:3d23 $ce $00
    ld   C, A                                          ;; 00:3d25 $4f
    cp   A, $0f                                        ;; 00:3d26 $fe $0f
    jr   C, .set                                       ;; 00:3d28 $38 $13
    jr   NZ, .max999999                                ;; 00:3d2a $20 $0c
    ld   A, H                                          ;; 00:3d2c $7c
    cp   A, $42                                        ;; 00:3d2d $fe $42
    jr   C, .set                                       ;; 00:3d2f $38 $0c
    jr   NZ, .max999999                                ;; 00:3d31 $20 $05
    ld   A, L                                          ;; 00:3d33 $7d
    cp   A, $3f                                        ;; 00:3d34 $fe $3f
    jr   C, .set                                       ;; 00:3d36 $38 $05
.max999999:
    ld   HL, $423f                                     ;; 00:3d38 $21 $3f $42
    ld   C, $0f                                        ;; 00:3d3b $0e $0f
.set:
    ld   A, H                                          ;; 00:3d3d $7c
    ld   [wXPHigh], A                                  ;; 00:3d3e $ea $bc $d7
    ld   A, L                                          ;; 00:3d41 $7d
    ld   [wXPLow], A                                   ;; 00:3d42 $ea $bb $d7
    ld   A, C                                          ;; 00:3d45 $79
    ld   [wXPHighExt], A                               ;; 00:3d46 $ea $bd $d7
    pop  DE                                            ;; 00:3d49 $d1
    ret                                                ;; 00:3d4a $c9

checkForLevelUp:
    ld   A, [wMainGameState]                           ;; 00:3d4b $fa $a0 $c0
    and  A, A                                          ;; 00:3d4e $a7
    ret  NZ                                            ;; 00:3d4f $c0
    ld   A, [wXPHigh]                                  ;; 00:3d50 $fa $bc $d7
    ld   H, A                                          ;; 00:3d53 $67
    ld   A, [wXPLow]                                   ;; 00:3d54 $fa $bb $d7
    ld   L, A                                          ;; 00:3d57 $6f
    ld   A, [wXPHighExt]                               ;; 00:3d58 $fa $bd $d7
    ld   B, A                                          ;; 00:3d5b $47
    ld   A, [wNextXPLevelHigh]                         ;; 00:3d5c $fa $c1 $d8
    ld   D, A                                          ;; 00:3d5f $57
    ld   A, [wNextXPLevelLow]                          ;; 00:3d60 $fa $c0 $d8
    ld   E, A                                          ;; 00:3d63 $5f
    ld   A, [wNextXPLevelHighExt]                      ;; 00:3d64 $fa $c2 $d8
    ld   C, A                                          ;; 00:3d67 $4f
    ld   A, L                                          ;; 00:3d68 $7d
    sub  A, E                                          ;; 00:3d69 $93
    ld   A, H                                          ;; 00:3d6a $7c
    sbc  A, D                                          ;; 00:3d6b $9a
    ld   A, B                                          ;; 00:3d6c $78
    sbc  A, C                                          ;; 00:3d6d $99
    jp   NC, startLevelUp                              ;; 00:3d6e $d2 $6b $3e
    ret                                                ;; 00:3d71 $c9

; Add HL to player money, then draw on status bar
addMoney:
    call addMoneyAdjustValues
    call drawMoneyOnStatusBar_trampoline
    ret

; Add HL to player money accounting for rich bit
addMoneyAdjustValues:
    push DE                                            ;; 00:3d72 $d5
    ld   A, [wMoneyHigh]                               ;; 00:3d73 $fa $bf $d7
    ld   D, A                                          ;; 00:3d76 $57
    ld   A, [wMoneyLow]                                ;; 00:3d77 $fa $be $d7
    ld   E, A                                          ;; 00:3d7a $5f
    add  HL, DE                                        ;; 00:3d7b $19
    pop  DE                                            ;; 00:3d7c $d1
    push HL
    ld   HL, wStatusEffect
    jr   NC, .set_1
    set  7, [HL]
.set_1:
    bit  7, [HL]
    pop  HL
    jr   Z, .set_2
    ld   A, L
    sub  A, $9f
    ld   A, H
    sbc  A, $86
    jr   C, .set_2
    ld   HL, $869f ; fix largest value to 99999
.set_2:
    ld   A, H                                          ;; 00:3d82 $7c
    ld   [wMoneyHigh], A                               ;; 00:3d83 $ea $bf $d7
    ld   A, L                                          ;; 00:3d86 $7d
    ld   [wMoneyLow], A                                ;; 00:3d87 $ea $be $d7
    ret                                                ;; 00:3d8d $c9

ds 10 ; Free space

; Magic Power is equal to the spell's power plus two times Wisdom.
; The Japanese version had an overflow bug with Nuke and Wisodom 94 or above.
; This was fixed in Final Fantasy Adventure both with an overflow check and also by nerfing Nuke.
; Nuke has been buffed back to its original power: 57->68. Its power maxes at 255 with Wisdom 94.
; It would be simple to change this to allow Nuke to have power above 255.
; Return: a = power (base damage before random factor and modifications).
getTotalMagicPower:
    call getSpellOrBookPower_trampoline
    or a
    ret z
    ld b, a
; Wisdom is capped at 99 so no need for an overflow check here.
    ld a, [wStatWisdom]
    add a
; Add in the spell's power and do an overflow check.
    add b
    jr nc, .return
    ld a, $ff
.return:
    ret

ds 1 ; Free space

getPlayerAttackElements:
    ld   A, [wMiscFlags]                               ;; 00:3dc0 $fa $6f $d8
    bit  6, A                                          ;; 00:3dc3 $cb $77
    ld   A, [wEquippedWeaponElements]                  ;; 00:3dc5 $fa $d7 $d7
    ret  Z                                             ;; 00:3dc8 $c8
    ld   A, [wEquippedItemElements]                    ;; 00:3dc9 $fa $51 $d8
    ret                                                ;; 00:3dcc $c9

getEquippedShieldBlockElements_SaveBC:
    push BC                                            ;; 00:3dcd $c5
    call getEquippedShieldBlockElements_trampoline     ;; 00:3dce $cd $ed $30
    pop  BC                                            ;; 00:3dd1 $c1
    ret                                                ;; 00:3dd2 $c9

; Originally checked armor twice and nothing checked helmets.
getEquippedElementalResistances:
    push BC                                            ;; 00:3dd3 $c5
    call getEquippedHelmElementalResistances_trampoline
    ld   B, A                                          ;; 00:3dd7 $47
    call getEquippedArmorElementalResistances_trampoline ;; 00:3dd8 $cd $89 $31
    or   A, B                                          ;; 00:3ddb $b0
    pop  BC                                            ;; 00:3ddc $c1
    ret                                                ;; 00:3ddd $c9

ds 15 ; Free space

getHP:
    ld   A, [wHPHigh]                                  ;; 00:3ded $fa $b3 $d7
    ld   H, A                                          ;; 00:3df0 $67
    ld   A, [wHPLow]                                   ;; 00:3df1 $fa $b2 $d7
    ld   L, A                                          ;; 00:3df4 $6f
    ret                                                ;; 00:3df5 $c9

addHP:
    push DE                                            ;; 00:3df6 $d5
    ld   A, [wHPHigh]                                  ;; 00:3df7 $fa $b3 $d7
    ld   D, A                                          ;; 00:3dfa $57
    ld   A, [wHPLow]                                   ;; 00:3dfb $fa $b2 $d7
    ld   E, A                                          ;; 00:3dfe $5f
    add  HL, DE                                        ;; 00:3dff $19
    ld   A, H                                          ;; 00:3e00 $7c
    ld   [wHPHigh], A                                  ;; 00:3e01 $ea $b3 $d7
    ld   A, L                                          ;; 00:3e04 $7d
    ld   [wHPLow], A                                   ;; 00:3e05 $ea $b2 $d7
    ld   A, [wMaxHPHigh]                               ;; 00:3e08 $fa $b5 $d7
    ld   D, A                                          ;; 00:3e0b $57
    ld   A, [wMaxHPLow]                                ;; 00:3e0c $fa $b4 $d7
    ld   E, A                                          ;; 00:3e0f $5f
    ld   A, L                                          ;; 00:3e10 $7d
    sub  A, E                                          ;; 00:3e11 $93
    ld   A, H                                          ;; 00:3e12 $7c
    sbc  A, D                                          ;; 00:3e13 $9a
    jr   C, .set                                       ;; 00:3e14 $38 $02
    push DE                                            ;; 00:3e16 $d5
    pop  HL                                            ;; 00:3e17 $e1
.set:
    ld   A, H                                          ;; 00:3e18 $7c
    ld   [wHPHigh], A                                  ;; 00:3e19 $ea $b3 $d7
    ld   A, L                                          ;; 00:3e1c $7d
    ld   [wHPLow], A                                   ;; 00:3e1d $ea $b2 $d7
    pop  DE                                            ;; 00:3e20 $d1
    call drawHPOnStatusBar_trampoline                  ;; 00:3e21 $cd $0b $31
    ret                                                ;; 00:3e24 $c9

; Subtract hl from current HP and update the status bar display.
subHP:
    push DE                                            ;; 00:3e25 $d5
    ld   A, [wHPHigh]                                  ;; 00:3e26 $fa $b3 $d7
    ld   D, A                                          ;; 00:3e29 $57
    ld   A, [wHPLow]                                   ;; 00:3e2a $fa $b2 $d7
    ld   E, A                                          ;; 00:3e2d $5f
    ld   A, E                                          ;; 00:3e2e $7b
    sub  A, L                                          ;; 00:3e2f $95
    ld   L, A                                          ;; 00:3e30 $6f
    ld   A, D                                          ;; 00:3e31 $7a
    sbc  A, H                                          ;; 00:3e32 $9c
    ld   H, A                                          ;; 00:3e33 $67
    pop  DE                                            ;; 00:3e34 $d1
    jr   NC, .set                                      ;; 00:3e35 $30 $03
    ld   HL, $00                                       ;; 00:3e37 $21 $00 $00
.set:
    ld   A, H                                          ;; 00:3e3a $7c
    ld   [wHPHigh], A                                  ;; 00:3e3b $ea $b3 $d7
    ld   A, L                                          ;; 00:3e3e $7d
    ld   [wHPLow], A                                   ;; 00:3e3f $ea $b2 $d7
    call drawHPOnStatusBar_trampoline                  ;; 00:3e42 $cd $0b $31
    ret                                                ;; 00:3e45 $c9

; Checks whether Hero's HP is zero.
checkForPlayerDeath:
    ld hl, wHPLow
    ld a, [hl+]
    or [hl]
    ret  NZ                                            ;; 00:3e4f $c0
    ld   A, [wMainGameStateFlags]                      ;; 00:3e50 $fa $a1 $c0
    bit  1, A                                          ;; 00:3e53 $cb $4f
    ret  NZ                                            ;; 00:3e55 $c0
    ld   A, [wMainGameState]                           ;; 00:3e56 $fa $a0 $c0
    cp   A, $0f                                        ;; 00:3e59 $fe $0f
    ret  Z                                             ;; 00:3e5b $c8
    call playerAttackDestroy_trampoline                ;; 00:3e5c $cd $f7 $2e
    ld   A, $20                                        ;; 00:3e5f $3e $20
    call playSFX                                       ;; 00:3e61 $cd $7d $29
    ld   HL, $07                                       ;; 00:3e64 $21 $07 $00
    call runScriptByIndex                              ;; 00:3e67 $cd $ad $31
    ret                                                ;; 00:3e6a $c9

ds 4 ; Free space

startLevelUp:
    ld   A, [wNectarStaminaTimerNumber]                ;; 00:3e6b $fa $7e $d8
    cp   A, $ff                                        ;; 00:3e6e $fe $ff
    call NZ, clearItemBuff                             ;; 00:3e70 $c4 $44 $1d
    ld   A, [wMusic]                                   ;; 00:3e73 $fa $9b $d4
    ld   [wCurrentMusicLevelUpBackup], A               ;; 00:3e76 $ea $42 $d8
; Levelup removes the status effect music, so why not remove Pois as well?
    call clearPoisStatusEffect_trampoline
    ld   A, $1c                                        ;; 00:3e79 $3e $1c
    ldh  [hCurrentMusic], A                            ;; 00:3e7b $e0 $90
    ld   A, WINDOW_LEVELUP_FANFARE                     ;; 00:3e7d $3e $21
    ld   [wDialogType], A                              ;; 00:3e7f $ea $4a $d8
    call windowMenuStartSpecial_trampoline             ;; 00:3e82 $cd $b1 $30
    ld   HL, wWindowSecondaryFlags                     ;; 00:3e85 $21 $72 $d8
    set  1, [HL]                                       ;; 00:3e88 $cb $ce
    res  0, [HL]                                       ;; 00:3e8a $cb $86
    res  6, [HL]                                       ;; 00:3e8c $cb $b6
    ret                                                ;; 00:3e8e $c9

ds 5 ; Free space

setWillBarMax:
    ld   A, $40                                        ;; 00:3e97 $3e $40
    ld   [wWillCharge], A                              ;; 00:3e99 $ea $58 $d8
    call drawEmptyWillBar_trampoline                   ;; 00:3e9c $cd $4d $31
    call drawWillBarCharge_trampoline                  ;; 00:3e9f $cd $47 $31
    ret                                                ;; 00:3ea2 $c9

; A=next level
setNextXPLevel:
    push BC                                            ;; 00:3ea3 $c5
    push AF                                            ;; 00:3ea4 $f5
    ld   A, BANK(xpPerLevelTable) ;@=bank xpPerLevelTable ;; 00:3ea5 $3e $08
    call pushBankNrAndSwitch                           ;; 00:3ea7 $cd $fb $29
    pop  AF                                            ;; 00:3eaa $f1
    ld   HL, xpPerLevelTable                           ;; 00:3eab $21 $d6 $4d
    ld   B, A                                          ;; 00:3eae $47
    add  A, A                                          ;; 00:3eaf $87
    add  A, B                                          ;; 00:3eb0 $80
    ld   C, A                                          ;; 00:3eb1 $4f
    ld   A, $00                                        ;; 00:3eb2 $3e $00
    adc  A, $00                                        ;; 00:3eb4 $ce $00
    ld   B, A                                          ;; 00:3eb6 $47
    add  HL, BC                                        ;; 00:3eb7 $09
    ld   C, [HL]                                       ;; 00:3eb8 $4e
    inc  HL                                            ;; 00:3eb9 $23
    ld   D, [HL]                                       ;; 00:3eba $56
    inc  HL                                            ;; 00:3ebb $23
    ld   E, [HL]                                       ;; 00:3ebc $5e
    ld   A, D                                          ;; 00:3ebd $7a
    ld   [wNextXPLevelHigh], A                         ;; 00:3ebe $ea $c1 $d8
    ld   A, E                                          ;; 00:3ec1 $7b
    ld   [wNextXPLevelLow], A                          ;; 00:3ec2 $ea $c0 $d8
    ld   A, C                                          ;; 00:3ec5 $79
    ld   [wNextXPLevelHighExt], A                      ;; 00:3ec6 $ea $c2 $d8
    push HL                                            ;; 00:3ec9 $e5
    call popBankNrAndSwitch                            ;; 00:3eca $cd $0a $2a
    pop  HL                                            ;; 00:3ecd $e1
    pop  BC                                            ;; 00:3ece $c1
    ret                                                ;; 00:3ecf $c9

useWillCharge:
    ld   A, [wWillCharge]                              ;; 00:3ed0 $fa $58 $d8
    push AF                                            ;; 00:3ed3 $f5
    xor  A, A                                          ;; 00:3ed4 $af
    ld   [wWillCharge], A                              ;; 00:3ed5 $ea $58 $d8
    call drawEmptyWillBar_trampoline                   ;; 00:3ed8 $cd $4d $31
    call drawWillBarCharge_trampoline                  ;; 00:3edb $cd $47 $31
    pop  AF                                            ;; 00:3ede $f1
    ret                                                ;; 00:3edf $c9

increaseWillCharge:
    ld   A, [wWillCharge]                              ;; 00:3ee0 $fa $58 $d8
    ld   B, A                                          ;; 00:3ee3 $47
    inc  B                                             ;; 00:3ee4 $04
    ld   A, $10                                        ;; 00:3ee5 $3e $10
    add  A, A                                          ;; 00:3ee7 $87
    add  A, A                                          ;; 00:3ee8 $87
    cp   A, B                                          ;; 00:3ee9 $b8
    jr   NC, .set                                      ;; 00:3eea $30 $07
    ld   B, A                                          ;; 00:3eec $47
    cp   A, $40                                        ;; 00:3eed $fe $40
    jr   C, .set                                       ;; 00:3eef $38 $02
    ld   A, $40                                        ;; 00:3ef1 $3e $40
.set:
    ld   A, B                                          ;; 00:3ef3 $78
    ld   [wWillCharge], A                              ;; 00:3ef4 $ea $58 $d8
    call drawWillBarCharge_trampoline                  ;; 00:3ef7 $cd $47 $31
    ret                                                ;; 00:3efa $c9

isWillBarFull:
    ld   A, [wWillCharge]                              ;; 00:3efb $fa $58 $d8
    cp   A, $40                                        ;; 00:3efe $fe $40
    ret                                                ;; 00:3f00 $c9

scriptOpCodeNOP:
    call getNextScriptInstruction                      ;; 00:3f01 $cd $27 $37
    ret                                                ;; 00:3f04 $c9

; Helper function to provide a place to hook in for color palette changes.
; a = status effect value
setStatusEffect:
    ld [wStatusEffect], a
IF DEF(COLOR)
    jp loadHeroPaletteForStatus
ELSE
    ret
    nop
    nop
ENDC


;@ffa_text
yesNoTextLabels:
    TXT  "YesNo<00>"                                   ;; 00:3f0a ......

;@ffa_text
cantCarryTextLabel:
    TXT  "Can't carry!<00>"                            ;; 00:3f10 ?????????????

; This maps single byte text encodings to two actual characters.
; Used in texts from scripts exclusively.
dualCharMapping:
    INCBIN "ffa.gb", $3f1d, 112 * 2
