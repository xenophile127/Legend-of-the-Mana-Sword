; Shutter effect used for most map transitions.

; The code is scattered and intertwined with room loading so it has not been moved.

; Line effect buffer for the letterbox effect.
; Format is entries with:
; * Scanline number (minus two) to effect the change.
; * Value to be ANDed with the current LCDC value.
; * Value to be XORed with the current LCDC value.
; * BGP palette to be set.
lcdcShutterEffectClose:
    db   $00, $fc, $03, $e4
    db   $7c, $fc, $00, $fc
    db   $7e, $fc, $01, $e0
    db   $ff

lcdcShutterEffectOpen:
    db   $3c, $fc, $03, $e4
    db   $40, $fc, $00, $fc
    db   $7e, $fc, $01, $e0
    db   $ff

; This effect originally applied the dark effect to the status bar, now fixed.
lcdcShutterEffectDarkClose:
    db   $00, $fc, $03, $3f
    db   $7c, $fc, $00, $ff
    db   $7e, $fc, $01, $e0
    db   $ff

; This effect was originally not used, with the above close effect accidentally used instead.
; It also, like the above effect, originally applied the dark effect to the status bar.
lcdcShutterEffectDarkOpen:
    db   $3c, $fc, $03, $3f
    db   $40, $fc, $00, $ff
    db   $7e, $fc, $01, $e0
    db   $ff
