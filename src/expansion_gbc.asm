INCLUDE "include/hardware.inc"

SGB_CODE_BANK EQU $17

SECTION "Game Boy Color Bank - Code", ROMX[$4000], BANK[SGB_CODE_BANK]

; Initial palette loading.
gbc_init:
    ld hl, .bgp
    ld de, wPaletteBackground
    ld a, BCPSF_AUTOINC
    ldh [rBCPS], a
    ld b, $40
.loop_bgp:
    ld a, [hl+]
    ldh [rBCPD], a
    ld [de], a
    inc de
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
INCBIN "pal/init/normal/bgp0.pal",0,8
INCBIN "pal/init/normal/bgp1.pal",0,8
INCBIN "pal/init/normal/bgp2.pal",0,8
INCBIN "pal/init/normal/bgp3.pal",0,8
INCBIN "pal/init/normal/bgp4.pal",0,8
INCBIN "pal/init/normal/bgp5.pal",0,8
INCBIN "pal/init/normal/bgp6.pal",0,8
INCBIN "pal/init/normal/bgp7.pal",0,8

; Initial sprite (object) palettes.
; Player, player attack, snowman, follower, enemy projectile, and three for NPCs.
.obj:
INCBIN "pal/init/normal/obj0.pal",0,8
INCBIN "pal/init/normal/obj1.pal",0,8
INCBIN "pal/init/normal/obj2.pal",0,8
INCBIN "pal/init/normal/obj3.pal",0,8
INCBIN "pal/init/normal/obj4.pal",0,8
INCBIN "pal/init/normal/obj5.pal",0,8
INCBIN "pal/init/normal/obj6.pal",0,8
INCBIN "pal/init/normal/obj7.pal",0,8
