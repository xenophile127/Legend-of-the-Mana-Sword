INCLUDE "include/hardware.inc"

SGB_CODE_BANK EQU $17

SECTION "Game Boy Color Bank - Code", ROMX[$4000], BANK[SGB_CODE_BANK]

; Initial palette loading.
gbc_init:
    ; Load the normal background palette into RAM.
    ld hl, color_palette_init.bgp
    ld de, wColorPalettes.bgp_normal
    ld b, $40
    call copyHLtoDE
    ; Load the normal background palette into the active palette RAM.
    ld hl, color_palette_init.bgp
    ld de, wColorPalettes.bgp_active
    ld b, $40
    call copyHLtoDE
    ; Load the blind background palette into RAM.
    ld hl, color_palette_init.bgp_blind
    ld de, wColorPalettes.bgp_blind
    ld b, $40
    call copyHLtoDE
    ; Load the boss damage background palette into RAM.
    ld hl, color_palette_init.bgp_damage
    ld de, wColorPalettes.bgp_damage
    ld b, $40
    call copyHLtoDE
    ; Load the screen flash background palette into RAM.
    ld hl, color_palette_init.bgp_flash
    ld de, wColorPalettes.bgp_flash
    ld b, $40
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
    ; Load the normal object palette into RAM.
    ld hl, color_palette_init.obj
    ld de, wColorPalettes.obj_normal
    ld b, $40
    call copyHLtoDE
    ; Load the normal object palette into the active palette RAM.
    ld hl, color_palette_init.obj
    ld de, wColorPalettes.obj_active
    ld b, $40
    call copyHLtoDE
    ; Load the blind object palette into RAM.
    ld hl, color_palette_init.obj_blind
    ld de, wColorPalettes.obj_blind
    ld b, $40
    call copyHLtoDE
    ; Load the boss damage object palette into RAM.
    ld hl, color_palette_init.obj_damage
    ld de, wColorPalettes.obj_damage
    ld b, $40
    call copyHLtoDE
    ; Load the screen flash object palette into RAM.
    ld hl, color_palette_init.obj_flash
    ld de, wColorPalettes.obj_flash
    ld b, $40
    call copyHLtoDE
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
