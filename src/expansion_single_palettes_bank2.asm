INCLUDE "include/macros.inc"
INCLUDE "include/constants.inc"

DEF COLOR_SINGLE_PALETTES_BANK_2 EQU $1a

SECTION "Game Boy Color Bank - Single Palettes 2", ROMX[$4000], BANK[COLOR_SINGLE_PALETTES_BANK_2]

ColorSinglePalettesROM_2:

; Used for the pointer fingers and trashcan in menus.
    COLOR_PALETTE_SET_SINGLE menu/obj

INCLUDE "pal/attack/palette_map.inc"

; Loads the palette for an NPC.
; a = NPC id
; b = palette number (upper five bits may be dirty)
loadSinglePaletteBank2_expansion:
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
