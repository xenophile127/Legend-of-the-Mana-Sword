INCLUDE "include/hardware.inc"

SGB_CODE_BANK EQU $17

SECTION "Game Boy Color Bank - Code", ROMX[$4000], BANK[SGB_CODE_BANK]

; Initial palette loading.
gbc_init:
    ld hl, .bgp
    ld a, BCPSF_AUTOINC
    ldh [rBCPS], a
    ld b, $40
.loop_bgp:
    ld a, [hl+]
    ldh [rBCPD], a
    dec b
    jr nz, .loop_bgp

    ld hl, .obj
    ld a, OCPSF_AUTOINC
    ldh [rOCPS], a
    ld b, $40
.loop_obj:
    ld a, [hl+]
    ldh [rOCPD], a
    dec b
    jr nz, .loop_obj
    ret

; Initial background palettes.
.bgp:
INCBIN "pal/bios_bgp.pal",0,8
INCBIN "pal/monochrome.pal",0,8
INCBIN "pal/monochrome.pal",0,8
INCBIN "pal/monochrome.pal",0,8
INCBIN "pal/monochrome.pal",0,8
INCBIN "pal/monochrome.pal",0,8
INCBIN "pal/monochrome.pal",0,8
INCBIN "pal/monochrome.pal",0,8

; Initial sprite (object) palettes.
.obj:
INCBIN "pal/bios_obj_red.pal",0,8
INCBIN "pal/bios_obj_blue.pal",0,8
INCBIN "pal/monochrome.pal",0,8
INCBIN "pal/monochrome.pal",0,8
INCBIN "pal/monochrome.pal",0,8
INCBIN "pal/monochrome.pal",0,8
INCBIN "pal/monochrome.pal",0,8
INCBIN "pal/monochrome.pal",0,8


