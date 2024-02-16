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

; Used if the game is rebooted using A+B+Start+Select from the ending to ensure attribute changes are cleared.
sgbClearAttributes:
    ld bc, .SGB_ATTR_CLEAR
    call SGBSendData
    ret
.SGB_ATTR_CLEAR:
    db $31, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; Send a MLT_REQ command to the Super Game Boy to change the number of joypads to one.
sgbSetOneController:
    ld bc, .SGB_MLTREQ1
    call SGBSendData
    ret
.SGB_MLTREQ1:
    db $89, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; Send a MLT_REQ command to the Super Game Boy to change the number of joypads to two.
sgbSetTwoControllers:
    ld bc, .SGB_MLTREQ2
    call SGBSendData
    ret
.SGB_MLTREQ2:
    db $89, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; Check whether the game is running on Super Game Boy.
; Requires number of controllers to be set to two (or four) beforehand.
; For real SGBs and low level emulators multiple (three) frames must pass after changing number of controllers.
; Return: Carry flag set if running on SGB.
checkSGB:
    ld b, $04
    ld c, LOW(rP1)
.loop:
    ld a, P1F_GET_DPAD
    ld [c], a ; Set P1.4 low to simulate normal reading.
    ld a, [c]
    ld a, [c]
    ld a, P1F_GET_BTN
    ld [c], a ; Set P1.5 low to advance to the next joypad.
    ld a, [c]
    ld a, [c]
    ld a, P1F_GET_NONE
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
    and a ; Clear carry
    ret
.is_sgb
    scf
    ret

; The Super Game Boy detection is done by testing for multiple controller support.
; This restores back to one controller afterwards in case the player chooses to reboot and play more.
enhancedLetterboxSetOneController:
    call sgbSetOneController
    ld hl, wScriptOpCounter
    inc [hl]
    ret

; The Super Game Boy detection is done by testing for multiple controller support.
; On real SGBs and low level emulators a three frame delay is required after sending this command.
enhancedLetterboxSetTwoControllers:
    call sgbSetTwoControllers
    ld hl, wScriptOpCounter
    inc [hl]
    ret

; Rather than store the boot value, check for SGB support using the multiple controller method.
enhancedLetterboxCheckSGB:
; Run the original letterbox code
    call prepareLetterboxEffect_trampoline
; Check whether SGB code should be run
    call checkSGB
    jr c, .sgb
    xor a
    ld [wScriptOpCounter], a
    ret
.sgb:
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
; The second tilemap is mostly unused...
    ld a, $ed
    ld [wVideoLCDC], a
; ... Just need to scroll past the HUD.
    ld hl, wVideoSCX
    ld [hl], $00
    inc hl
    ld [hl], $10
; Set the palette correctly.
    ld a, $e4
    ld [wVideoBGP], a
; Use the VBlank tile transfer mechanism.
    ld a, BANK(@)
    ld de, _VRAM + $0f10
    ld hl, .TILE_WHITE
    call addTileGraphicCopyRequest
    ld a, BANK(@)
    ld de, _VRAM + $0f20
    ld hl, .TILE_BLACK
    call addTileGraphicCopyRequest
    ld a, BANK(@)
; Set the tilemap directly. Each tile is written twice since these are monochrome 2bpp and SNES are 4bpp.
    ld de, $f1f1
    ld hl, _SCRN1 + 2 * SCRN_VX_B
    call storeDEinVRAM
    ld de, $f2f2
    call storeDEinVRAM
    ret
.TILE_WHITE:
    dw `00000000
    dw `00000000
    dw `00000000
    dw `00000000
    dw `00000000
    dw `00000000
    dw `00000000
    dw `00000000
.TILE_BLACK:
    dw `33333333
    dw `33333333
    dw `33333333
    dw `33333333
    dw `33333333
    dw `33333333
    dw `33333333
    dw `33333333

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
; d = snes tile number, e = snes attributes
    ld de, $0110
; The tiles are numbers $f1, $f2, $f3, and $f4.
    ld hl, _VRAM + $0f10
.tile_loop1:
; This weirdness is to set up the transparent parts of those four tiles
    ld a, $12
    cp b
    jr nz, .not_start
; Switch to the transparent tile id.
    dec d
.not_start:
    ld a, $06
    cp b
    jr nz, .not_end
; Switch back to the solid black tile id.
    inc d
.not_end:
    call storeDEinVRAM
    dec b
    jr nz, .tile_loop1
; Set the tilemap with opaque and transparent tiles.
; Starting just after the window data.
    ld hl, _SCRN1 + $40
; A total of 29 rows of tiles instead of 28 because the SNES palette fade commands cause scanline 225 to flash.
    ld c, $1d
.tilemap_loop_outer:
    ld b, $05
.tilemap_loop_inner:
    push bc
    ld a, c
    cp $07
    jr c, .edge
    cp $19
    jr c, .middle
.edge:
; Edges (above and below the game screen) are solid black.
    ld de, $f1f1
    call storeDEinVRAM
    call storeDEinVRAM
    jr .common
.middle:
; The middle area has a transparent cuttout for the game screen.
    ld de, $f2f3
    call storeDEinVRAM
    ld de, $f3f4
    call storeDEinVRAM
.common:
    pop bc
    dec c
    ret z
    dec b
    jr nz, .tilemap_loop_inner
    ld de, SCRN_VX_B - SCRN_X_B
    add hl, de
    jr .tilemap_loop_outer

enhancedLetterboxSetBlackBorder:
    ld hl, wScriptOpCounter
    inc [hl]
; The second tilemap is mostly unused...
    ld a, $ed
    ld [wVideoLCDC], a
; ... Just need to scroll past the HUD.
    ld hl, wVideoSCX
    ld [hl], $00
    inc hl
    ld [hl], $10
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

; In addition to setting the normal letterbox effect, checks for Super Game Boy support and if found:
; * Loads an all-black SGB border.
; * Sets a sepia(ish) color palette.
; * Switches to using SNES hardware for screen fades.
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
    dw enhancedLetterboxSetTwoControllers
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxCheckSGB
    dw enhancedLetterboxFreezeScreen
    dw enhancedLetterboxTransferTilesPrepare
    dw enhancedLetterboxTransferTiles ; Trigger VRAM transfer
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxSetBlackBorderPrepare
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxSetBlackBorder ; Trigger VRAM transfer
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxSetSGBPalette
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxSetTwoControllers
    dw enhancedLetterboxFinish

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
    ld a, [wScriptOpCounter]
    cp $0a
    jr z, .last_step
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

; Handles loading color palettes if the next screen is the final "End" screen.
.last_step:
    push hl
; Normally this only does anything on the first sub-step of a fade step.
    ld a, [wScriptOpCounter2]
    ld bc, .SGB_PAL01_BLACK
    or a
    jr z, .send_packet
; This counter is used to time when the final fade-to-black is happening to load attributes.
; When it hits seven, additional work is done to set up colors for the "End" screen.
    ld a, [wSGBEndingCounter]
    cp $07
    jr nz, .return
; The second and third palettes are untouched by fading to black, so they need to be blacked out.
    ld a, [wScriptOpCounter2]
    ld bc, .SGB_PAL23_BLACK
    dec a
    jr z, .send_packet
; It takes two packets to load the color attributes for the sprout.
    ld bc, .SGB_ATTR
    dec a
    jr z, .send_packet
    ld bc, .SGB_ATTR+$10
    dec a
    jr nz, .return
.send_packet:
    call SGBSendData
.return:
    pop hl
    ret

.SGB_PAL01_BLACK:
    db $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
.SGB_PAL23_BLACK:
    db $09, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
.SGB_ATTR:
;            x    y   number   l->r  /----------------- data -----------------------\
    db $39, $0c, $0a, $18, $00, $00, $af, $00, $00, $00, $00, $af, $00, $00, $00, $00
    db $39, $0c, $0c, $03, $00, $00, $54, $00, $00, $00, $00, $00, $00, $00, $00, $00

; Fade back from black. This would handle white as well, but that is never used during the ending.
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
; The Super Game Boy can only handle one PAL packet per frame, so send them on alternate frames.
    jr nz, .second_packet
    push hl
; Calculate the first packet.
    ld hl, SGB_PAL01
    call fadeToOrFromBlack
; Send the new packet to the Super Game Boy.
    ld bc, wSGBPacket
    call SGBSendData
    pop hl
    ret

.second_packet:
    dec a
    ret nz
    push hl
; Calculate the second packet.
    ld hl, SGB_PAL23
    call fadeToOrFromBlack
; Send the new packet to the Super Game Boy.
    ld bc, wSGBPacket
    call SGBSendData
    pop hl
    ret 
