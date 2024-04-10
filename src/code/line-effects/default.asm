; Default effect used during gameplay.
; Hides sprites in the status bar HUD area and prevent it from being affected by the Blind/Dark effect..

; Load the default LCDC effect buffer, which handles the status bar not having sprites
; on top and the forces the color palette of the status bar.
setDefaultLCDCEffect:
    ld   A, $7e                                        ;; 00:0313 $3e $7e
    ldh  [rLYC], A                                     ;; 00:0315 $e0 $45
    ld   A, $00                                        ;; 00:0317 $3e $00
    ld   [wLCDCEffectIndex], A                         ;; 00:0319 $ea $e2 $d3
    ld   DE, wLCDCEffectBuffer                         ;; 00:031c $11 $a0 $d3
    ld   HL, .lcdcDefaultEffect ;@=ptr .lcdcDefaultEffect ;; 00:031f $21 $28 $03
    ld   B, $05                                        ;; 00:0322 $06 $05
    call copyHLtoDE                                    ;; 00:0324 $cd $49 $2b
    ret                                                ;; 00:0327 $c9

; Line effect buffer for the letterbox effect.
; Format is entries with:
; * Scanline number (minus two) to effect the change.
; * Value to be ANDed with the current LCDC value.
; * Value to be XORed with the current LCDC value.
; * BGP palette to be set.
.lcdcDefaultEffect:
    db   $7e, $fc, LCDCF_OBJOFF | LCDCF_BGON, $e4
    db   $ff
