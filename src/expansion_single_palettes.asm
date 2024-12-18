INCLUDE "include/macros.inc"
INCLUDE "include/constants.inc"

DEF COLOR_SINGLE_PALETTES_BANK_1 EQU $19

SECTION "Game Boy Color Bank - Single Palettes 1", ROMX[$4000], BANK[COLOR_SINGLE_PALETTES_BANK_1]

ColorSinglePalettesROM:

INCLUDE "pal/npc/palette_map.inc"

INCLUDE "pal/projectile/palette_map.inc"

; Hero color palettes.
; The macro for these creates a constant based on the argument, so renaming the directory won't work.
    COLOR_PALETTE_SET_SINGLE hero/good
    COLOR_PALETTE_SET_SINGLE hero/moogle
    COLOR_PALETTE_SET_SINGLE hero/poison
    COLOR_PALETTE_SET_SINGLE hero/stone

; Loads the palette for an NPC.
; a = NPC id
; b = palette number (upper five bits may be dirty)
loadSinglePalette_expansion:
; Calculate the address of the palette.
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    push de
    ld de, ColorSinglePalettesROM
    add hl, de
; Now calculate the address of the palette to replace.
    ld a, b
    and $07
    add a
    add a
    add a
    ld de, wColorPalettes.obj_main
    add e
    ld e, a
    ld a, d
    adc $00
    ld d, a
; Copy one palette.
    ld b, $08
    call copyHLtoDE
; That leaves hl ready for the next palette but de needs to advance 15 palettes (120 bytes).
    ld a, $78
    add e
    ld e, a
    ld a, d
    adc $00
    ld d, a
; Copy the blind palette.
    ld b, $08
    call copyHLtoDE
; That leaves hl ready for the next palette but de needs to advance 15 palettes (120 bytes).
    ld a, $78
    add e
    ld e, a
    ld a, d
    adc $00
    ld d, a
; Copy the damage palette.
    ld b, $08
    call copyHLtoDE
; That leaves hl ready for the next palette but de needs to advance 15 palettes (120 bytes).
    ld a, $78
    add e
    ld e, a
    ld a, d
    adc $00
    ld d, a
; Copy the flash palette.
    ld b, $08
    call copyHLtoDE
; Check whether the Blind/Dark effect is active.
    ld hl, wPlayerSpecialFlags
    bit 1, [hl]
    ld hl, wColorPalettes.main
    jr z, .activate
    ld hl, wColorPalettes.blind
; Activate the palette if the screen isn't currently faded to black or white.
.activate:
    ld a, [wLastFade]
    or a
    call z, setPalettes
; And finish.
    pop de
    ret
