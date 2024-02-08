; SGB related code.

; Currently the only SGB support is triggered off of the letterbox script command, run as part of the ending.
; At that time, the border is set to all black--since the letterbox is essentially setting a black border,
; and the screen palette is set to a sepia effect.

; If you are using the SGB default palette then the switch to sepia will be somewhat subtle,
; but with other palettes it can be a drastic change. Hopefully in a good way.
; The biggest motivation for a custom palette is a real black instead of the dark blue/purple in the default.

; Provides SGBSendData based off of https://github.com/ahrnbom/gingerbread/ which is public domain.
; This has been rewritten to be as fast as the (vague) guidelines allow:
; 4 cycles between writing a data or reset value and three times that after pulsing P14 and P15.
INCLUDE "code/gingerbread.asm"

; Also note: The recommended four frames between packets is completely ignored--up to three packets are sent in a frame.
; If the user is using the bomb tool, too bad.

; These are the palettes loaded during the ending.
; Palettes 1, 2, and 3 are only used on the final "End" screen.
SGB_PAL01:
;           /------------ sepia-ish -------------\  /----------- stem ----------\
;            #fff7de   #efce6b   #ad7331   #000000    #efce6b   #18a500   #085a00
    db $01, $df, $6f, $3d, $37, $d5, $19, $00, $00, $3d, $37, $83, $02, $61, $01, $ff

SGB_PAL23:
;           /------------- leaves ---------------\  /------- plus yellow ------\
    db $09, $df, $6f, $68, $17, $83, $02, $61, $01, $68, $17, $7f, $03, $61, $01, $ff
;            #fff7de   #42de29   #18a500   #085a00    #42de29   #ffde00   #085a00

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
; Used by the fade effect and to set up palette attributes at the propper moment.
    ld hl, wSGBEndingCounter
    inc [hl]
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
    ld bc, SGB_PAL01
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

; Sets up color regions for the very final End screen.
sgbSetEndScreenColors:
    push hl
; The second and third palettes are untouched by fading to black, so they need to be blacked out first.
    ld bc, .SGB_PAL23_BLACK
    call SGBSendData
    ld bc, .SGB_ATTR
    call SGBSendData
    ld bc, .SGB_ATTR+$10
    call SGBSendData
    pop hl
    ret
.SGB_PAL23_BLACK:
    db $09, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
.SGB_ATTR:
;            x    y   number   l->r  /----------------- data -----------------------\
    db $39, $0c, $0a, $18, $00, $00, $af, $00, $00, $00, $00, $af, $00, $00, $00, $00
    db $39, $0c, $0c, $03, $00, $00, $54, $00, $00, $00, $00, $00, $00, $00, $00, $00

; Given a SGB palette packet, creates a modified packet with colors faded between the original and black.
; c = fade amount from 0 (completely black) to 11 (unmodified colors)
; hl = address of packet
; Return: c = unmodified, wSGBPacket = new packet
fadeToOrFromBlack:
    ld de, wSGBPacket
; Copy the packet header byte.
    ld a, [hl+]
    ld [de], a
    inc de
; There are seven colors in each of the two packets.
    ld b, $07
.loop:
    push bc
    push de
    call fadeBlackColor
    pop de
;    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    pop bc
    dec b
    jr nz, .loop
    ret

; Fade to black using SNES palettes.
; Also manages loading the attribute maps to colorize the final "End" screen.
sgbFadeToBlack:
; This counter is used to time when the final fade-to-black is happening to load attributes.
    ld a, [wSGBEndingCounter]
    cp $07
    jr nz, .fade
    ld a, [wScriptOpCounter2]
    dec a
    jr z, .fade
    ld a, [wScriptOpCounter]
    cp $0a
    jr z, .setEndScreenColors
.fade:
    ld a, [wScriptOpCounter2]
    or a
    ret nz
; The primary script counter is used as the main fade control.
    ld a, [wScriptOpCounter]
    ld c, a
; The first fade step is full brightness so it can be skipped.
    inc c
    push hl
    ld hl, SGB_PAL01
    call fadeToOrFromBlack
; Send the new packet to the Super Game Boy.
    ld bc, wSGBPacket
    call SGBSendData
    pop hl
    ret

.setEndScreenColors:
; If this code is reached then the screen should have just gone black before the final fade-in for the End screen.
    call sgbSetEndScreenColors
    ret

; Fade back from black. This should handle white as well, but that is never used during the ending.
; Two palette commands are managed here, one used only by the final "End" screen.
sgbFadeToNormal:
; The primary script counter is used as the main fade control.
    ld a, [wScriptOpCounter]
; Run the fade-to-black effect backwards. Complement and increment, then add the number of items in the array (minus one).
    cpl
    add $0a + 1 ; Fold the increment into the addition.
    ld c, a
    ld a, [wScriptOpCounter2]
    or a
    jr nz, .second_step
    push hl
; There is not enough time in one frame to calculate two palette packets and send both to the SGB.
; Calculate the first packet.
    ld hl, SGB_PAL01
    call fadeToOrFromBlack
; Send the new packet to the Super Game Boy.
    ld bc, wSGBPacket
    call SGBSendData
    pop hl
    ret

.second_step:
    dec a
    ret nz
    push hl
; There is not enough time in one frame to calculate two palette packets and send both to the SGB.
; Calculate the second packet.
    ld hl, SGB_PAL23
    call fadeToOrFromBlack
; Send the new packet to the Super Game Boy.
    ld bc, wSGBPacket
    call SGBSendData
    pop hl
    ret 
