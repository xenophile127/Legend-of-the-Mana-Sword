;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy


;@data format=bbbbbbbbpppp amount=40
; Projectile data.
; 0) Collision flags. Valid options:
;    $38: friendly melee (Bogard)
;    $3a: friendly ranged (four cardinal directions)
;    $60: enemy melee
;    $62: enemy ranged (four cardinal directions)
;    $72: enemy ranged (any angle)
; 1) Speed, lower = faster.
; 2) Size (for collision calculations)
; 3) Element
; 4) Damage
; 5) Status Effect inflicted
; 6) Graphics Tile Load Index
; 7) Graphics Tile Load Count
; 8-9) Graphics pointer
; 10-11) Tile indexes
; 12-13) Metatiles
; 14-15) ?
projectileDataTable:
    data_bbbbbbbbpppp $62, $08, $08, $01, $0a, $00, $30, $04, gfxProjectileKnife, data_09_46f9, metasprites30FourDirections, pattern_simple ;; 09:4479 ................ $00
    data_bbbbbbbbpppp $72, $08, $08, $04, $20, $00, $30, $04, gfxProjectileSun, data_09_46f9, metasprites30Static_npc_pal2, pattern_simple ;; 09:4489 ???????????????? $01
    data_bbbbbbbbpppp $62, $08, $08, $04, $1e, $00, $38, $04, gfxProjectileNeedles, data_09_46f9, metasprites38FourDirections, pattern_simple ;; 09:4499 ???????????????? $02
    data_bbbbbbbbpppp $62, $08, $08, $04, $1e, $00, $30, $04, gfxProjectilePitchfork, data_09_46f9, metasprites30FourDirections, pattern_simple ;; 09:44a9 ..????.......... $03
    data_bbbbbbbbpppp $72, $08, $08, $40, $50, $00, $38, $04, gfxProjectileMirrorImage, data_09_46f9, metasprites38Static, pattern_simple ;; 09:44b9 ???????????????? $04
    data_bbbbbbbbpppp $62, $08, $08, $40, $64, $00, $68, $04, gfxProjectileLaser, data_09_46f9, metasprites68FourDirections, pattern_simple ;; 09:44c9 ???????????????? $05
    data_bbbbbbbbpppp $72, $08, $08, $08, $46, $00, $38, $04, gfxProjectileAxe, data_09_46f9, metasprites38BiasRotate, pattern_simple ;; 09:44d9 ???????????????? $06
    data_bbbbbbbbpppp $72, $0a, $08, $04, $1c, $00, $38, $04, gfxProjectileClaw, data_09_46f9, metasprites38BiasRotate, pattern_simple ;; 09:44e9 ???????????????? $07
    data_bbbbbbbbpppp $72, $08, $08, $08, $32, $08, $30, $04, gfxProjectileRing, data_09_46f9, metasprites30Static_npc_pal3, pattern_simple ;; 09:44f9 ???????????????? $08
    data_bbbbbbbbpppp $62, $08, $08, $08, $46, $00, $30, $04, gfxProjectileRock, data_09_46f9, metasprites30BiasRotate, pattern_simple ;; 09:4509 ???????????????? $09
    data_bbbbbbbbpppp $72, $08, $08, $40, $89, $00, $38, $04, gfxProjectileNinjaStar, data_09_46f9, metasprites38Pulsing, pattern_simple ;; 09:4519 ???????????????? $0a
    data_bbbbbbbbpppp $72, $08, $08, $40, $3e, $04, $30, $04, gfxProjectileOrb, data_09_46f9, metasprites30Pulsing, pattern_simple ;; 09:4529 ???????????????? $0b
    data_bbbbbbbbpppp $72, $08, $08, $10, $50, $00, $38, $04, gfxProjectileFire, data_09_46f9, metasprites38FourDirections, pattern_simple ;; 09:4539 ???????????????? $0c
    data_bbbbbbbbpppp $62, $08, $08, $20, $5f, $00, $30, $04, gfxProjectileIce, data_09_46f9, projectileIceMetatileTable, pattern_simple ;; 09:4549 ???????????????? $0d
    data_bbbbbbbbpppp $62, $08, $08, $40, $30, $00, $38, $04, gfxProjectileLightning, data_09_46f9, metasprites38FourDirections, pattern_simple ;; 09:4559 ???????????????? $0e
    data_bbbbbbbbpppp $62, $08, $08, $04, $21, $01, $30, $04, gfxProjectileWind, data_09_46f9, metasprites30FourDirections_npc_pal3, pattern_simple ;; 09:4569 ???????????????? $0f
    data_bbbbbbbbpppp $60, $08, $08, $01, $0f, $00, $30, $04, gfxProjectileArrow, data_09_46f9, metasprites30FourDirections, pattern_melee ;; 09:4579 ??????......???? $10
    data_bbbbbbbbpppp $60, $08, $08, $08, $46, $00, $38, $04, gfxProjectileSword, data_09_46f9, metasprites38FourDirections, pattern_melee ;; 09:4589 ??????......???? $11
    data_bbbbbbbbpppp $60, $0a, $08, $02, $14, $00, $38, $04, gfxProjectileNeedle, data_09_46f9, metasprites38FourDirections, pattern_melee ;; 09:4599 ???????????????? $12
    data_bbbbbbbbpppp $60, $0a, $08, $04, $2d, $01, $38, $04, gfxProjectileNail, data_09_46f9, metasprites38XMirror, pattern_scorpion_tail ;; 09:45a9 ???????????????? $13
    data_bbbbbbbbpppp $72, $0a, $08, $40, $5f, $00, $30, $04, gfxProjectileFire2, data_09_46f9, metasprites30BiasRotate, pattern_simple ;; 09:45b9 ???????????????? $14
    data_bbbbbbbbpppp $60, $08, $08, $04, $26, $02, $38, $04, gfxProjectileWave, data_09_46f9, metasprites38FlipRotate, pattern_melee ;; 09:45c9 ???????????????? $15
    data_bbbbbbbbpppp $72, $08, $08, $40, $63, $00, $38, $04, gfxProjectileExplosion, data_09_46f9, metasprites38Pulsing, pattern_simple ;; 09:45d9 ??????......???? $16
    data_bbbbbbbbpppp $60, $08, $08, $01, $1e, $00, $38, $04, gfxProjectileChestBite, data_09_46f9, metasprites38XMirror, pattern_chest_bite ;; 09:45e9 ???????????????? $17
    data_bbbbbbbbpppp $38, $08, $0c, $01, $27, $00, $18, $04, gfxProjectileSword, data_09_46f9, metaspritesCompanionFourDirections, pattern_melee ;; 09:45f9 ???????????????? $18
    data_bbbbbbbbpppp $3a, $0a, $0c, $01, $19, $00, $18, $04, gfxProjectileAxe, data_09_46f9, metaspritesCompanionBiasRotate, pattern_simple ;; 09:4609 ???????????????? $19
    data_bbbbbbbbpppp $3a, $08, $0c, $01, $2b, $00, $18, $04, gfxProjectileKnife, data_09_46f9, metaspritesCompanionFourDirections, pattern_simple ;; 09:4619 ???????????????? $1a
    data_bbbbbbbbpppp $3a, $08, $0c, $01, $2c, $00, $18, $04, gfxProjectileArrow, data_09_46f9, metaspritesCompanionFourDirections, pattern_simple ;; 09:4629 ???????????????? $1b
    data_bbbbbbbbpppp $3a, $08, $0c, $01, $5f, $00, $18, $04, gfxProjectileLaser, data_09_46f9, metaspritesCompanionFourDirections, pattern_simple ;; 09:4639 ???????????????? $1c
    data_bbbbbbbbpppp $3a, $06, $08, $08, $0d, $00, $18, $04, gfxProjectileFire, data_09_46f9, metaspritesCompanionFourDirections, pattern_simple ;; 09:4649 ???????????????? $1d
    data_bbbbbbbbpppp $72, $08, $08, $02, $1e, $00, $30, $08, gfxProjectileExplosion, data_09_4701, metasprites30Pulsing, pattern_simple ;; 09:4659 ???????????????? $1e
    data_bbbbbbbbpppp $62, $0c, $08, $80, $17, $00, $30, $08, gfxProjectileExplosion, data_09_4711, metasprites30FourDirections, pattern_simple ;; 09:4669 ???????????????? $1f
    data_bbbbbbbbpppp $72, $0a, $08, $04, $40, $04, $30, $08, gfxProjectileExplosion, data_09_4721, metasprites30Pulsing, pattern_simple ;; 09:4679 ???????????????? $20
    data_bbbbbbbbpppp $72, $0a, $08, $40, $a0, $00, $30, $02, gfxProjectileFeather2, data_09_46f9, metasprites30Static, pattern_simple ;; 09:4689 ???????????????? $21
    data_bbbbbbbbpppp $72, $0a, $08, $40, $a6, $00, $30, $02, gfxProjectileSkull, data_09_46f9, metasprites30Static, pattern_simple ;; 09:4699 ???????????????? $22
    data_bbbbbbbbpppp $62, $08, $08, $40, $50, $00, $30, $08, gfxProjectileExplosion, data_09_4731, metasprites30FourDirections, pattern_simple ;; 09:46a9 ???????????????? $23
    data_bbbbbbbbpppp $62, $08, $08, $40, $a8, $00, $30, $08, gfxProjectileLightning, data_09_4741, metasprites30FourDirections, pattern_simple ;; 09:46b9 ???????????????? $24
    data_bbbbbbbbpppp $72, $08, $0a, $40, $a3, $00, $30, $08, gfxProjectileExplosion, data_09_4751, metasprites30Pulsing, pattern_simple ;; 09:46c9 ???????????????? $25
    data_bbbbbbbbpppp $72, $0a, $08, $40, $4f, $00, $30, $08, gfxProjectileExplosion, data_09_4761, metasprites30Static, pattern_simple ;; 09:46d9 ???????????????? $26
    data_bbbbbbbbpppp $72, $0a, $08, $40, $88, $00, $30, $08, gfxProjectileExplosion, data_09_4761, metasprites30Static, pattern_simple ;; 09:46e9 ???????????????? $27

data_09_46f9:
    db   $00, $02, $01, $03, $04, $06, $05, $07        ;; 09:46f9 ........

data_09_4701:
    db   $08, $0a, $09, $0b, $0c, $0e, $0d, $0f        ;; 09:4701 ????????
    db   $00, $02, $01, $03, $04, $06, $05, $07        ;; 09:4709 ????????

data_09_4711:
    db   $48, $4a, $49, $4b, $4c, $4e, $4d, $4f        ;; 09:4711 ????????
    db   $00, $02, $01, $03, $04, $06, $05, $07        ;; 09:4719 ????????

data_09_4721:
    db   $10, $12, $11, $13, $14, $16, $15, $17        ;; 09:4721 ????????
    db   $00, $02, $01, $03, $04, $06, $05, $07        ;; 09:4729 ????????

data_09_4731:
    db   $48, $4a, $49, $4b, $4c, $4e, $4d, $4f        ;; 09:4731 ????????
    db   $00, $02, $01, $03, $04, $06, $05, $07        ;; 09:4739 ????????

data_09_4741:
    db   $00, $02, $01, $03, $04, $06, $05, $07        ;; 09:4741 ????????
    db   $38, $3a, $39, $3b, $3c, $3e, $3d, $3f        ;; 09:4749 ????????

data_09_4751:
    db   $00, $02, $01, $03, $04, $06, $05, $07        ;; 09:4751 ????????
    db   $60, $62, $61, $63, $64, $66, $65, $67        ;; 09:4759 ????????

data_09_4761:
    db   $34, $36, $35, $37, $38, $3a, $39, $3b        ;; 09:4761 ????????
    db   $00, $02, $01, $03, $04, $06, $05, $07        ;; 09:4769 ????????
