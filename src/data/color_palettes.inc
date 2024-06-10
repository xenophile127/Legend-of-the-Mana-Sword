; Color palettes. Each includes sets of eight background palettes and eight object palettes for:
; * Normal colors.
; * Blind effect.
; * Fullscreen flash script command.
; * Boss damage blink.

; Backgrounds currently only use palette 0.

; Sprites use these palettes:
; 0 Player.
; 1 Player attack
; 2 Snowman.
; 3 follower.
; 4 Enemy projectile.
; 5, 6, and 7 for everything else (NPCs, enemies, and bosses).

; Loaded at boot.
color_palette_init:
.bgp:
INCBIN "pal/init/normal/bgp0.pal",0,8
INCBIN "pal/init/normal/bgp1.pal",0,8
INCBIN "pal/init/normal/bgp2.pal",0,8
INCBIN "pal/init/normal/bgp3.pal",0,8
INCBIN "pal/init/normal/bgp4.pal",0,8
INCBIN "pal/init/normal/bgp5.pal",0,8
INCBIN "pal/init/normal/bgp6.pal",0,8
INCBIN "pal/init/normal/bgp7.pal",0,8
.obj:
INCBIN "pal/init/normal/obj0.pal",0,8
INCBIN "pal/init/normal/obj1.pal",0,8
INCBIN "pal/init/normal/obj2.pal",0,8
INCBIN "pal/init/normal/obj3.pal",0,8
INCBIN "pal/init/normal/obj4.pal",0,8
INCBIN "pal/init/normal/obj5.pal",0,8
INCBIN "pal/init/normal/obj6.pal",0,8
INCBIN "pal/init/normal/obj7.pal",0,8
.bgp_blind:
INCBIN "pal/init/blind/bgp0.pal",0,8
INCBIN "pal/init/blind/bgp1.pal",0,8
INCBIN "pal/init/blind/bgp2.pal",0,8
INCBIN "pal/init/blind/bgp3.pal",0,8
INCBIN "pal/init/blind/bgp4.pal",0,8
INCBIN "pal/init/blind/bgp5.pal",0,8
INCBIN "pal/init/blind/bgp6.pal",0,8
INCBIN "pal/init/blind/bgp7.pal",0,8
.obj_blind:
INCBIN "pal/init/blind/obj0.pal",0,8
INCBIN "pal/init/blind/obj1.pal",0,8
INCBIN "pal/init/blind/obj2.pal",0,8
INCBIN "pal/init/blind/obj3.pal",0,8
INCBIN "pal/init/blind/obj4.pal",0,8
INCBIN "pal/init/blind/obj5.pal",0,8
INCBIN "pal/init/blind/obj6.pal",0,8
INCBIN "pal/init/blind/obj7.pal",0,8
.bgp_damage:
INCBIN "pal/init/damage/bgp0.pal",0,8
INCBIN "pal/init/damage/bgp1.pal",0,8
INCBIN "pal/init/damage/bgp2.pal",0,8
INCBIN "pal/init/damage/bgp3.pal",0,8
INCBIN "pal/init/damage/bgp4.pal",0,8
INCBIN "pal/init/damage/bgp5.pal",0,8
INCBIN "pal/init/damage/bgp6.pal",0,8
INCBIN "pal/init/damage/bgp7.pal",0,8
.obj_damage:
INCBIN "pal/init/damage/obj0.pal",0,8
INCBIN "pal/init/damage/obj1.pal",0,8
INCBIN "pal/init/damage/obj2.pal",0,8
INCBIN "pal/init/damage/obj3.pal",0,8
INCBIN "pal/init/damage/obj4.pal",0,8
INCBIN "pal/init/damage/obj5.pal",0,8
INCBIN "pal/init/damage/obj6.pal",0,8
INCBIN "pal/init/damage/obj7.pal",0,8
.bgp_flash:
INCBIN "pal/init/flash/bgp0.pal",0,8
INCBIN "pal/init/flash/bgp1.pal",0,8
INCBIN "pal/init/flash/bgp2.pal",0,8
INCBIN "pal/init/flash/bgp3.pal",0,8
INCBIN "pal/init/flash/bgp4.pal",0,8
INCBIN "pal/init/flash/bgp5.pal",0,8
INCBIN "pal/init/flash/bgp6.pal",0,8
INCBIN "pal/init/flash/bgp7.pal",0,8
.obj_flash:
INCBIN "pal/init/flash/obj0.pal",0,8
INCBIN "pal/init/flash/obj1.pal",0,8
INCBIN "pal/init/flash/obj2.pal",0,8
INCBIN "pal/init/flash/obj3.pal",0,8
INCBIN "pal/init/flash/obj4.pal",0,8
INCBIN "pal/init/flash/obj5.pal",0,8
INCBIN "pal/init/flash/obj6.pal",0,8
INCBIN "pal/init/flash/obj7.pal",0,8
