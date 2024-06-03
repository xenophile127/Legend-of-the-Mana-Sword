INCLUDE "include/hardware.inc"

SGB_CODE_BANK EQU $17

SECTION "Game Boy Color Bank - Code", ROMX[$4000], BANK[SGB_CODE_BANK]

; Initial palette loading.
gbc_init:
    ; Load the normal background palette into RAM.
    ld hl, .bgp
    ld de, wPaletteBackgroundNormal
    ld b, $40
    call copyHLtoDE
    ; Load the normal background palette into the active palette RAM.
    ld hl, .bgp
    ld de, wPaletteBackgroundActive
    ld b, $40
    call copyHLtoDE
    ; Load the blind background palette into RAM.
    ld hl, .bgp_blind
    ld de, wPaletteBackgroundBlind
    ld b, $40
    call copyHLtoDE
    ; Load the boss damage background palette into RAM.
    ld hl, .bgp_damage
    ld de, wPaletteBackgroundBossDamage
    ld b, $40
    call copyHLtoDE
    ; Load the normal background palette into CRAM.
    ld hl, .bgp
    ld a, BCPSF_AUTOINC
    ldh [rBCPS], a
    ld b, $40
.loop_bgp:
    ld a, [hl+]
    ldh [rBCPD], a
    dec b
    jr nz, .loop_bgp
    ; Load the normal object palette into RAM.
    ld hl, .obj
    ld de, wPaletteObjectNormal
    ld b, $40
    call copyHLtoDE
    ; Load the normal object palette into the active palette RAM.
    ld hl, .obj
    ld de, wPaletteObjectActive
    ld b, $40
    call copyHLtoDE
    ; Load the blind object palette into RAM.
    ld hl, .obj_blind
    ld de, wPaletteObjectBlind
    ld b, $40
    call copyHLtoDE
    ; Load the boss damage object palette into RAM.
    ld hl, .obj_damage
    ld de, wPaletteObjectBossDamage
    ld b, $40
    call copyHLtoDE
    ; Load the normal object palette into CRAM.
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

; Initial background palettes for the Blind effect
.bgp_blind:
INCBIN "pal/init/blind/bgp0.pal",0,8
INCBIN "pal/init/blind/bgp1.pal",0,8
INCBIN "pal/init/blind/bgp2.pal",0,8
INCBIN "pal/init/blind/bgp3.pal",0,8
INCBIN "pal/init/blind/bgp4.pal",0,8
INCBIN "pal/init/blind/bgp5.pal",0,8
INCBIN "pal/init/blind/bgp6.pal",0,8
INCBIN "pal/init/blind/bgp7.pal",0,8

; Initial sprite (object) palettes for the Blind effect.
; Player, player attack, snowman, follower, enemy projectile, and three for NPCs.
; On DMG the player, all attacks (player, enemy, and follower), and snowmen are unaffected.
; In Legend of the Mana Sword certain NPCs, followers, attacks, and snowmen have been changed in order to control coloring.
.obj_blind:
INCBIN "pal/init/blind/obj0.pal",0,8
INCBIN "pal/init/blind/obj1.pal",0,8
INCBIN "pal/init/blind/obj2.pal",0,8
INCBIN "pal/init/blind/obj3.pal",0,8
INCBIN "pal/init/blind/obj4.pal",0,8
INCBIN "pal/init/blind/obj5.pal",0,8
INCBIN "pal/init/blind/obj6.pal",0,8
INCBIN "pal/init/blind/obj7.pal",0,8

; Initial background palettes for the Boss Damage effect.
.bgp_damage:
INCBIN "pal/init/damage/bgp0.pal",0,8
INCBIN "pal/init/damage/bgp1.pal",0,8
INCBIN "pal/init/damage/bgp2.pal",0,8
INCBIN "pal/init/damage/bgp3.pal",0,8
INCBIN "pal/init/damage/bgp4.pal",0,8
INCBIN "pal/init/damage/bgp5.pal",0,8
INCBIN "pal/init/damage/bgp6.pal",0,8
INCBIN "pal/init/damage/bgp7.pal",0,8

; Initial sprite (object) palettes for the Boss Damage effect.
; Player, player attack, snowman, follower, enemy projectile, and three for NPCs.
; This should only affect the palettes used by the boss(es).
.obj_damage:
INCBIN "pal/init/damage/obj0.pal",0,8
INCBIN "pal/init/damage/obj1.pal",0,8
INCBIN "pal/init/damage/obj2.pal",0,8
INCBIN "pal/init/damage/obj3.pal",0,8
INCBIN "pal/init/damage/obj4.pal",0,8
INCBIN "pal/init/damage/obj5.pal",0,8
INCBIN "pal/init/damage/obj6.pal",0,8
INCBIN "pal/init/damage/obj7.pal",0,8
