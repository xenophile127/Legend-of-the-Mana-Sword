INCLUDE "include/macros.inc"

DEF COLOR_PALETTES_BANK_1 EQU $18

SECTION "Game Boy Color Bank - Palettes 1", ROMX[$4000], BANK[COLOR_PALETTES_BANK_1]

ColorPalettesROM:

INCLUDE "pal/palette_list.inc"

INCLUDE "pal/boss/palette_map.inc"

; Load a set of background palettes from ROM into RAM, and setup the transer to CRAM.
; This loads the main palettes, flash palettes, dark palettes, and boss damage flash palettes.
; Each has eight BGP palettes.
; The OBJ palettes are untouched.
; a = palette set number
loadPalettesBackground_expansion:
; Calculate the address of the palette. Each palette is $200 bytes in size.
    add a, a
    add HIGH(ColorPalettesROM)
    ld h, a
    xor a
    ld l, a
; Load all background palettes, including blind, damage, and flash.
    ld de, wColorPalettes
    ld c, $40 ; size of eight background palettes: 2 * 4 * 8
    ld a, $04
    .loop:
    push af
    ld b, c
    call copyHLtoDE
; Since object palettes aren't being touched hl and de need to be modified.
    add hl, bc ; b is now $00, so bc is $0040
    ld a, e
    add c
    ld e, a
    ld a, d
    adc b ; b is still $00
    ld d, a
    pop af
    dec a
    jr nz, .loop
; Check whether the Blind/Dark effect is active.
    ld hl, wPlayerSpecialFlags
    bit 1, [hl]
    ld hl, wColorPalettes.main
    jr z, .activate
    ld hl, wColorPalettes.blind
.activate:
; Prepare the copy to CRAM.
    call setPalettes
    ret
