; Shutter effect used for most map transitions.

; The code is scattered and intertwined with room loading so it has not been moved.

; Line effect buffer for the letterbox effect.
; Format is entries with:
; * Scanline number (minus two) to effect the change.
;   NOTE: These scanline numbers are modified as the effect progresses.
; * Value to be ANDed with the current LCDC value.
; * Value to be XORed with the current LCDC value.
; * BGP palette to be set.
lcdcShutterEffectClose:
    db   $00, $fc, LCDCF_OBJON | LCDCF_BGON, $e4
    db   $7c, $fc, LCDCF_OBJOFF | LCDCF_BGOFF, $fc
    db   $7e, $fc, LCDCF_OBJOFF | LCDCF_BGON, $e0
    db   $ff

lcdcShutterEffectOpen:
    db   $3c, $fc, LCDCF_OBJON | LCDCF_BGON, $e4
    db   $40, $fc, LCDCF_OBJOFF | LCDCF_BGOFF, $fc
    db   $7e, $fc, LCDCF_OBJOFF | LCDCF_BGON, $e0
    db   $ff

; This effect originally applied the dark effect to the status bar, now fixed.
lcdcShutterEffectDarkClose:
    db   $00, $fc, LCDCF_OBJON | LCDCF_BGON, $3f
    db   $7c, $fc, LCDCF_OBJOFF | LCDCF_BGOFF, $ff
    db   $7e, $fc, LCDCF_OBJOFF | LCDCF_BGON, $e0
    db   $ff

; This effect was originally not used, with the above close effect accidentally used instead.
; It also, like the above effect, originally applied the dark effect to the status bar.
lcdcShutterEffectDarkOpen:
    db   $3c, $fc, LCDCF_OBJON | LCDCF_BGON, $3f
    db   $40, $fc, LCDCF_OBJOFF | LCDCF_BGOFF, $ff
    db   $7e, $fc, LCDCF_OBJOFF | LCDCF_BGON, $e0
    db   $ff
