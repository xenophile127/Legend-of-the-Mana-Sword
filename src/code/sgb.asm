; SGB related code.

; Currently the only SGB support is triggered off of the letterbox script command, run as part of the ending.
; At that time, the border is set to all black--since the letterbox is essentially setting a black border,
; and the screen palette is set to a sepia effect.

; If you are using the SGB default palette then the switch to sepia will be somewhat subtle,
; but with other palettes it can be a drastic change. Hopefully in a good way.
; The biggest motivation for a custom palette is a real black instead of the dark blue/purple in the default.

; Provides SGBSendData taken from https://github.com/ahrnbom/gingerbread/ which is public domain.
INCLUDE "code/gingerbread.asm"

; This is the palette loaded during the ending.
SGB_PAL_SEPIA:
;           #fff7de   #f7d673   #ad7331   #000000
    db $01, $df, $6f, $5e, $3b, $d5, $19, $00, $00, $00, $00, $00, $00, $00, $00, $00

checkSGB:
; Returns whether the game is running on an SGB in carry.
; Leaves it set to two controllers because it is only used during the ending.
    ld bc, .SGB_MLTREQ2
    call SGBSendData
    ld b, $04
    ld c, LOW(rP1)
.loop:
    ld a, $20
    ld [c], a ; Set P1.4 low to simulate normal reading.
    ld a, [c]
    ld a, [c]
    ld a, $10
    ld [c], a ; Set P1.5 low to advance to the next joypad.
    ld a, [c]
    ld a, [c]
    ld a, $30
    ld [c], a ; Set P1.4 and P1.5 high to read the joypad id.
    ld a, [c]
    ld a, [c]
    ld a, [c]
    ld a, [c]
    and $03
    cp $03
    jp nz, .is_sgb
    dec b
    jr nz, .loop
    ret
.is_sgb
    scf
    ret
.SGB_MLTREQ2:
    db $89, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; Rather than store the boot value, check for SGB support using the multiple controller method.
enhancedLetterboxCheckSGB:
; Run the original letterbox code
    call prepareLetterboxEffect_trampoline
; Check whether SGB code should be run
    call checkSGB
    ret nc
    ld hl, wScriptOpCounter
    inc [hl]
    ret

; Freezes to black since that's what it will ultimately be after the palette is loaded.
; This way the timing around when the SNES has a frame cached isn't important.
enhancedLetterboxFreezeScreen:
    ld hl, wScriptOpCounter
    inc [hl]
    ld bc, .SGB_FREEZE_BLACK
    jp SGBSendData
.SGB_FREEZE_BLACK:
    db $b9, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; Setup for the border tile transfer.
enhancedLetterboxTransferTilesPrepare:
    ld hl, wScriptOpCounter
    inc [hl]
; Only two tiles need to be transferred: A transparent one and a solid one.
; One will be all black, and the other all white.
; It just so happens that if the screen is scrolled slightly then the transfer will be correct.
    ld a, $f0
    ld [wVideoSCX], a
; Set the palette correctly.
    ld a, $e4
    ld [wVideoBGP], a
    ret

enhancedLetterboxTransferTiles:
    ld hl, wScriptOpCounter
    inc [hl]
; Start the transfer.
    ld bc, .SGB_VRAMTRANS_TILEDATA1
    jp SGBSendData
.SGB_VRAMTRANS_TILEDATA1:
    db $99, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; Setup for the border tilemap and palette transfer.
enhancedLetterboxSetBlackBorderPrepare:
    ld hl, wScriptOpCounter
    inc [hl]
; Four tiles are required to encode the tilemap.
; They are stored over HUD tiles since the HUD is now permanently hidden.
    ld b, $20
    ld de, $1000
    ld hl, $8f10
.tile_loop1:
; This weirdness is to set up the transparent parts of those four tiles
    ld a, $12
    cp b
    jr nz, .not_start
    inc e
.not_start:
    ld a, $06
    cp b
    jr nz, .not_end
    dec e
.not_end:
    push hl
    push de
    call storeDEinVRAM
    pop de
    pop hl
    inc hl
    inc hl
    dec b
    jr nz, .tile_loop1
; Set the tilemap with opaque and transparent tiles.
    ld hl, $9c40
    ld c, $1c
.tilemap_loop_outer:
    ld b, $05
.tilemap_loop_inner:
    push bc
    ld a, c
    cp $06
    jr c, .edge
    cp $18
    jr c, .middle
.edge:
    ld de, $f1f1
    call storeDEinVRAM
    inc hl
    call storeDEinVRAM
    inc hl
    jr .common
.middle:
    ld de, $f2f3
    call storeDEinVRAM
    inc hl
    ld de, $f3f4
    call storeDEinVRAM
    inc hl
.common:
    pop bc
    dec c
    ret z
    dec b
    jr nz, .tilemap_loop_inner
    ld de, $000c
    add hl, de
    jr .tilemap_loop_outer

enhancedLetterboxSetBlackBorder:
    ld hl, wScriptOpCounter
    inc [hl]
; The second tilemap is mostly unused...
    ld a, $ed
    ld [wVideoLCDC], a
; ... Just need to scroll past the HUD.
    xor a
    ld [wVideoSCX], a
    ld a, $10
    ld [wVideoSCY], a
; Set the palette correctly.
    ld a, $e4
    ld [wVideoBGP], a
; Start the transfer.
    ld bc, .SGB_VRAMTRANS_TILEMAP
    jp SGBSendData
.SGB_VRAMTRANS_TILEMAP:
    db $a1, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; Set a sepia palette for the ending.
enhancedLetterboxSetSGBPalette:
    ld hl, wScriptOpCounter
    inc [hl]
; Since all the VRAM transfers are over, restore screen settings.
    xor a
    ld [wVideoSCY], a
    ld a, $e5
    ld [wVideoLCDC], a
    ld a, $ff
    ld [wVideoBGP], a
; Then set the palette.
    ld bc, SGB_PAL_SEPIA
    jp SGBSendData

; Unfreeze the screen and continues script execution.
enhancedLetterboxFinish:
    xor a
    ld [wScriptOpCounter], a
    ld bc, .SGB_UNFREEZE
    jp SGBSendData
.SGB_UNFREEZE:
    db $b9, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; VRAM transfers take multiple frames.
enhancedLetterboxDelayFrame:
    ld hl, wScriptOpCounter
    inc [hl]
    ret

; A number of packets are sent:
; * Freezing the screen.
; * Transferring tiles.
; * Setting the black border.
; * Setting the sepia palette.
; * Unfreezing the screen.
; Five packets total. Two trigger VRAM transfers.
enhancedLetterbox:
    push hl
    ld a, [wScriptOpCounter]
    ld hl, .enhancedLetterboxJumptable
    call callJumptable
    pop hl
    ld a, [wScriptOpCounter]
    or a
    ret
.enhancedLetterboxJumptable:
    dw enhancedLetterboxCheckSGB
    dw enhancedLetterboxFreezeScreen
    dw enhancedLetterboxTransferTilesPrepare
    dw enhancedLetterboxTransferTiles ; Trigger VRAM transfer
    dw enhancedLetterboxSetBlackBorderPrepare
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxSetBlackBorder ; Trigger VRAM transfer
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxSetSGBPalette
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxFinish
