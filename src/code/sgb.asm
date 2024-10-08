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
    db $01
    INCBIN "pal/sgb/credits.pal",0,8
    INCBIN "pal/sgb/end_plant_stem.pal",0,6 ; Don't load the fourth color.
    db $ff

SGB_PAL23:
    db $09
    INCBIN "pal/sgb/end_plant_leaves.pal",0,8
    INCBIN "pal/sgb/end_plant_flash.pal",0,6 ; Don't load the fourth color.
    db $ff

SGB_PAL01_BLACK:
    db $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
SGB_PAL23_BLACK:
    db $09, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,

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

; Used to init palettes two and three before they are used for the final fade-in.
; Also causes the background color to become black,
; which blacks out the transparent parts of the default border before the fade to black and palette set.
enhancedLetterboxSetPAL23Black:
    ld bc, SGB_PAL23_BLACK
    call SGBSendData
    ld hl, wScriptOpCounter
    inc [hl]
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
; Check whether SGB code should be run
    call checkSGB
    jr c, .sgb
; Run the original letterbox code
    call prepareLetterboxEffect_trampoline
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

; Load tiles from this bank.
; b = number of tiles, hl = array containing pairs of destinations and sources.
loadTiles:
.loop:
; Load the destination address.
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
; Load the source address.
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    push hl
    ld h, a
    ld l, c
; Load the bank number containing the tiles (this bank).
    ld a, BANK(@)
; Use the VBlank tile transfer mechanism.
    call addTileGraphicCopyRequest
    pop hl
    dec b
    jr nz, .loop
    ret

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
; Load tiles into VRAM.
    ld b, $03
    ld hl, .tileLoads
    call loadTiles
; Set the tilemap directly. Each tile is written twice since these are monochrome 2bpp and SNES are 4bpp.
    ld hl, _SCRN1 + 2 * SCRN_VX_B
    ld de, $f1f1
    call storeDEinVRAM
    ld de, $f2f2
    call storeDEinVRAM
    ld de, $f3f3
    call storeDEinVRAM
    ret
.tileLoads:
    dw _VRAM + $0f10, TILE_WHITE
    dw _VRAM + $0f20, TILE_BLACK
    dw _VRAM + $0f30, TILE_CORNER

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
; Load the tiles required to encode the tilemap.
; They are stored over HUD tiles since the HUD is now permanently hidden.
    ld b, $08
    ld hl, .tileLoads
    call loadTiles
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
    jr z, .bottom
    jr c, .edge
    cp $18
    jr z, .top
    jr c, .middle
.edge:
; Edges (above and below the game screen) are solid black.
    ld de, $f1f1
    call storeDEinVRAM
    call storeDEinVRAM
    jr .next
.bottom:
; Use rounded corners to black out the lower corners of dialog windows.
; Also for a nice effect if the game is restarted with A+B+Start+Select.
    ld de, $f7f3
    call storeDEinVRAM
    ld de, $f3f8
    call storeDEinVRAM
    jr .next
.top:
; Use rounded corners for a nice effect if the game is restarted with A+B+Start+Select.
    ld de, $f5f3
    call storeDEinVRAM
    ld de, $f3f6
    call storeDEinVRAM
    jr .next
.middle:
; The middle area has a transparent cuttout for the game screen.
    ld de, $f2f3
    call storeDEinVRAM
    ld de, $f3f4
    call storeDEinVRAM
.next:
    pop bc
    dec c
    ret z
    dec b
    jr nz, .tilemap_loop_inner
    ld de, SCRN_VX_B - SCRN_X_B
    add hl, de
    jr .tilemap_loop_outer
.tileLoads:
    dw _VRAM + $0f10, TILE_SOLID
    dw _VRAM + $0f20, TILE_LEFT
    dw _VRAM + $0f30, TILE_TRANSPARENT
    dw _VRAM + $0f40, TILE_RIGHT
    dw _VRAM + $0f50, TILE_UPPER_LEFT
    dw _VRAM + $0f60, TILE_UPPER_RIGHT
    dw _VRAM + $0f70, TILE_LOWER_LEFT
    dw _VRAM + $0f80, TILE_LOWER_RIGHT

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

; Just runs the original letterbox code
enhancedLetterboxRunOriginalLetterbox:
    ld hl, wScriptOpCounter
    inc [hl]
    call prepareLetterboxEffect_trampoline
    ret

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

; Give the border change fade-to-black time to finish.
enhancedLetterboxDelay70Frames:
    ld hl, wScriptOpCounter2
    ld a, [hl]
    or a
    jr nz, .delay
    ld a, $46
.delay:
    dec a
    ld [hl], a
    ret nz
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
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxSetPAL23Black
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxFreezeScreen
    dw enhancedLetterboxTransferTilesPrepare
    dw enhancedLetterboxTransferTiles ; Trigger VRAM transfer
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxSetBlackBorderPrepare
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxSetBlackBorder ; Trigger VRAM transfer
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxDelayFrame
    dw enhancedLetterboxSetOneController
    dw enhancedLetterboxRunOriginalLetterbox
    dw enhancedLetterboxDelay70Frames ; Default border shows some background so wait to set the palette.
    dw enhancedLetterboxSetSGBPalette
    dw enhancedLetterboxDelayFrame
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
; The first frame of the last step is used to set the palette to black.
    ld a, [wScriptOpCounter2]
    ld bc, SGB_PAL01_BLACK
    or a
    jr z, .send_packet
; This counter is used to time when the final fade-to-black is happening to load attributes.
; When it hits 13, additional work is done to set up colors for the "End" screen.
    ld a, [wSGBEndingCounter]
    cp $0d
    jr nz, .return
    ld a, [wScriptOpCounter2]
; It takes two packets to load the color attributes for the sprout.
; Send the first one two frames after the color palette packet.
    ld bc, .SGB_ATTR
    cp $02
    jr z, .send_packet
; Send the second one two frames after the first.
    ld bc, .SGB_ATTR+$10
    cp $04
    jr nz, .return
.send_packet:
    call SGBSendData
.return:
    pop hl
    ret

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
; Write on both the second and third frames of a fade, just in case.
    cp $03
    ret nc
; But only on the final fade.
    ld a, [wSGBEndingCounter]
    cp $0e
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
