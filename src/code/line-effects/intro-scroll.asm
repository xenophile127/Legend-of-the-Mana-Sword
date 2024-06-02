; Vignette effect used by the New Game text scroll.
; Anything at the top or bottom of the frame is gradually faded towards white.

; Line effect buffer for the letterbox effect.
; Format is entries with:
; * Scanline number (minus two) to effect the change.
; * Value to be ANDed with the current LCDC value.
; * Value to be XORed with the current LCDC value.
; * BGP palette. When running in color this is used to look up the real palette.
lcdcIntroScrollEffect:
    db   $06, $fc, LCDCF_OBJON | LCDCF_BGON, $40
    db   $16, $fc, LCDCF_OBJON | LCDCF_BGON, $90
    db   $26, $fc, LCDCF_OBJON | LCDCF_BGON, $e4
    db   $66, $fc, LCDCF_OBJON | LCDCF_BGON, $90
    db   $76, $fc, LCDCF_OBJON | LCDCF_BGON, $40
    db   $86, $fc, LCDCF_OBJON | LCDCF_BGON, $00
    db   $ff

prepareIntroScrollEffect:
    ld   HL, lcdcIntroScrollEffect                     ;; 01:40ca $21 $b1 $40
    ld   B, $19                                        ;; 01:40cd $06 $19
    call loadLCDCEffectBuffer                          ;; 01:40cf $cd $f3 $02
IF DEF(COLOR)
    ld b, $08
    ld de, wPaletteBackgroundActive
    ld hl, colorPalettes.intro_scroll0
    call copyHLtoDE
ELSE
    ld   A, $00                                        ;; 01:40d2 $3e $00
    ld   [wVideoBGP], A                                ;; 01:40d4 $ea $aa $c0
ENDC
    ret                                                ;; 01:40d7 $c9

introScrollEffectUpdateLCDEffect:
    ld   A, [wVideoSCY]                                ;; 01:40d8 $fa $a7 $c0
; Adjust to exact tile boundaries to get rid of one miscolored line of pixels.
    add a, $0a
    cpl                                                ;; 01:40dd $2f
    and  A, $0f                                        ;; 01:40de $e6 $0f
    ld   C, A                                          ;; 01:40e0 $4f
    ld   HL, wLCDCEffectBuffer                         ;; 01:40e1 $21 $a0 $d3
    ld   B, $06                                        ;; 01:40e4 $06 $06
    ld   DE, $04                                       ;; 01:40e6 $11 $04 $00
.loop:
    ld   A, [HL]                                       ;; 01:40e9 $7e
    and  A, $f0                                        ;; 01:40ea $e6 $f0
    or   A, C                                          ;; 01:40ec $b1
; If you try to run an LCDC on LCY=$8f it will actually run on line 0.
; That creates a brief flash of a visible line at the top that should be all white.
    cp $8f
    jr nz, .safe
    dec a
.safe:
    ld   [HL], A                                       ;; 01:40ed $77
    add  HL, DE                                        ;; 01:40ee $19
    dec  B                                             ;; 01:40ef $05
    jr   NZ, .loop                                     ;; 01:40f0 $20 $f7
    ret                                                ;; 01:40f2 $c9

