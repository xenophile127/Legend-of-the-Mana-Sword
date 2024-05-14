; Default effect used during gameplay.
; Hides sprites in the status bar HUD area and prevent it from being affected by the Blind/Dark effect..

; Load the default LCDC effect buffer, which handles the status bar not having sprites
; on top and the forces the color palette of the status bar.
setDefaultLCDCEffect:
    ld   A, $7e                                        ;; 00:0313 $3e $7e
    ldh  [rLYC], A                                     ;; 00:0315 $e0 $45
    ld   HL, .lcdcDefaultEffect                        ;; 00:031f $21 $28 $03
    ld   B, $05                                        ;; 00:0322 $06 $05
    call loadLCDCEffectBuffer
    ret

; Line effect buffer for the letterbox effect.
; Format is entries with:
; * Scanline number (minus two) to effect the change.
; * Value to be ANDed with the current LCDC value.
; * Value to be XORed with the current LCDC value.
; * BGP palette. When running in color this is used to look up the real palette.
.lcdcDefaultEffect:
    db   $7e, $f4, LCDCF_BG9800 | LCDCF_OBJOFF | LCDCF_BGON, $e0
    db   $ff
