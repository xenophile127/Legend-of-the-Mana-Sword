INCLUDE "include/hardware.inc"

SGB_CODE_BANK EQU $17

SECTION "Game Boy Color Bank - Code", ROMX[$4000], BANK[SGB_CODE_BANK]

; Initial palette loading.
gbc_init:
    ; Load all the palettes into RAM. 
    ld hl, color_palette_init
    ld de, wColorPalettes
    ld bc, $0200
    call copyHLtoDE_long

    ; Load the normal palettes into the active palette.
    ld hl, color_palette_init
    ld de, wColorPalettes.active
    ld b, $80
    call copyHLtoDE

    ; Load the normal background palette into CRAM.
    ld hl, color_palette_init.bgp
    ld a, BCPSF_AUTOINC
    ldh [rBCPS], a
    ld b, $40
.loop_bgp:
    ld a, [hl+]
    ldh [rBCPD], a
    dec b
    jr nz, .loop_bgp

    ; Load the normal object palette into CRAM.
    ld hl, color_palette_init.obj
    ld a, OCPSF_AUTOINC
    ldh [rOCPS], a
    ld b, $40
.loop_obj:
    ld a, [hl+]
    ldh [rOCPD], a
    dec b
    jr nz, .loop_obj
    ret

INCLUDE "data/color_palettes.inc"
