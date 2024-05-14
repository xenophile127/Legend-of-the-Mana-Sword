; Letterbox effect used during the final part of the ending.

; Line effect buffer for the letterbox effect.
; Format is entries with:
; * Scanline number (minus two) to effect the change.
; * Value to be ANDed with the current LCDC value.
; * Value to be XORed with the current LCDC value.
; * BGP palette. When running in color this is used to look up the real palette.
lcdcLetterboxEffect:
    db   $0e, $f4, LCDCF_BG9800 | LCDCF_OBJON | LCDCF_BGON, $e4
    db   $7e, $f4, LCDCF_BG9800 | LCDCF_OBJOFF | LCDCF_BGON, $e0
    db   $ff

prepareLetterboxEffect:
IF DEF(COLOR)
    ld b, $08
    ld de, wPaletteBackground
    ld hl, colorPalettes.letterbox
    call copyHLtoDE
ELSE
    ld   A, $ff                                        ;; 01:4059 $3e $ff
    ld   [wVideoBGP], A                                ;; 01:405b $ea $aa $c0
ENDC
    ld   A, [wVideoLCDC]                               ;; 01:405e $fa $a5 $c0
    and a, $f4
    xor a, LCDCF_BG9C00 | LCDCF_OBJOFF | LCDCF_BGON
    ld   [wVideoLCDC], A                               ;; 01:4065 $ea $a5 $c0
    ld   HL, lcdcLetterboxEffect                       ;; 01:4068 $21 $50 $40
    ld   B, $09                                        ;; 01:406b $06 $09
    call loadLCDCEffectBuffer                          ;; 01:406d $cd $f3 $02
; Fix letterbox. Previously it would display a bunch of the letter H at the bottom of the screen
; for a frame because it queued a tile transfer for VBlank but wrote the tilemap mid frame.
; The fix is to use the same mechanism to store the tile and modify the tilemap.
    ld hl, _VRAM8800+$70*$10
    ld de, $ffff
    ld b, $08
.loop_tile:
    call storeDEinVRAM
    dec b
    jr nz, .loop_tile
; Now modify the tilemap for the bottom two lines of the HUD.
    ld hl, _SCRN1
    ld de, $f0f0
.loop_outer:
    ld b, $0a
.loop_inner:
    call storeDEinVRAM
    dec b
    jr nz, .loop_inner
    ld a, LOW(_SCRN1+$20)
    cp l
    ld l, a
    jr nc, .loop_outer
    ret
