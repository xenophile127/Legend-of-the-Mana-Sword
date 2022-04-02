;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"

SECTION "bank0a", ROMX[$4000], BANK[$0a]

;@gfximg name=enemy/chibidevil width=2 height=4
gfxEnemyChibidevil:
    INCBIN "enemy/chibidevil.bin"                      ;; 0a:4000

;@gfximg name=enemy/myconid width=2 height=4
gfxEnemyMyconid:
    INCBIN "enemy/myconid.bin"                         ;; 0a:4080

;@gfximg name=enemy/grell width=2 height=4
gfxEnemyGrell:
    INCBIN "enemy/grell.bin"                           ;; 0a:4100

;@gfximg name=enemy/mudman width=2 height=4
gfxEnemyMudman:
    INCBIN "enemy/mudman.bin"                          ;; 0a:4180

;@gfximg name=enemy/death_flower width=2 height=4
gfxEnemyDeathFlower:
    INCBIN "enemy/death_flower.bin"                    ;; 0a:4200

;@gfximg name=enemy/roper width=2 height=4
gfxEnemyRoper:
    INCBIN "enemy/roper.bin"                           ;; 0a:4280

;@gfximg name=enemy/land_leech width=2 height=4
gfxEnemyLandLeech:
    INCBIN "enemy/land_leech.bin"                      ;; 0a:4300

;@gfximg name=enemy/killer_bee width=2 height=4
gfxEnemyKillerBee:
    INCBIN "enemy/killer_bee.bin"                      ;; 0a:4380
;@gfximg name=enemy/unknown1 width=2 height=4
    INCBIN "enemy/unknown1.bin"                        ;; 0a:4400

;@gfximg name=enemy/ruster width=2 height=4
gfxEnemyRuster:
    INCBIN "enemy/ruster.bin"                          ;; 0a:4480

;@gfximg name=enemy/mega_xorn width=2 height=4
gfxEnemyMegaXorn:
    INCBIN "enemy/mega_xorn.bin"                       ;; 0a:4500

;@gfximg name=enemy/ghost width=2 height=4
gfxEnemyGhost:
    INCBIN "enemy/ghost.bin"                           ;; 0a:4580

;@gfximg name=enemy/basilisk width=2 height=4
gfxEnemyBasilisk:
    INCBIN "enemy/basilisk.bin"                        ;; 0a:4600

;@gfximg name=enemy/mummy width=2 height=4
gfxEnemyMummy:
    INCBIN "enemy/mummy.bin"                           ;; 0a:4680

;@gfximg name=enemy/red_wisp width=2 height=4
gfxEnemyRedWisp:
    INCBIN "enemy/red_wisp.bin"                        ;; 0a:4700

;@gfximg name=enemy/barnaclejack width=2 height=4
gfxEnemyBarnaclejack:
    INCBIN "enemy/barnaclejack.bin"                    ;; 0a:4780
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:4800 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:4808 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:4810 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:4818 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:4820 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:4828 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:4830 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:4838 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:4840 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:4848 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:4850 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:4858 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:4860 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:4868 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:4870 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:4878 ????????

;@gfximg name=enemy/mammoth width=2 height=4
gfxEnemyMammoth:
    INCBIN "enemy/mammoth.bin"                         ;; 0a:4880

;@gfximg name=enemy/bulette width=2 height=4
gfxEnemyBulette:
    INCBIN "enemy/bulette.bin"                         ;; 0a:4900

;@gfximg name=enemy/dragonfly width=2 height=4
gfxEnemyDragonfly:
    INCBIN "enemy/dragonfly.bin"                       ;; 0a:4980

;@gfximg name=enemy/walrus width=2 height=4
gfxEnemyWalrus:
    INCBIN "enemy/walrus.bin"                          ;; 0a:4a00

;@gfximg name=enemy/snowman width=2 height=4
gfxEnemySnowman:
    INCBIN "enemy/snowman.bin"                         ;; 0a:4a80

;@gfximg name=enemy/sabercat width=2 height=4
gfxEnemySabercat:
    INCBIN "enemy/sabercat.bin"                        ;; 0a:4b00

;@gfximg name=enemy/poto width=2 height=4
gfxEnemyPoto:
    INCBIN "enemy/poto.bin"                            ;; 0a:4b80

;@gfximg name=enemy/manta_ray width=2 height=4
gfxEnemyMantaRay:
    INCBIN "enemy/manta_ray.bin"                       ;; 0a:4c00

;@gfximg name=enemy/griffin_hand width=2 height=4
gfxEnemyGriffinHand:
    INCBIN "enemy/griffin_hand.bin"                    ;; 0a:4c80

;@gfximg name=enemy/fire_moth width=2 height=4
gfxEnemyFireMoth:
    INCBIN "enemy/fire_moth.bin"                       ;; 0a:4d00

;@gfximg name=enemy/denden width=2 height=4
gfxEnemyDenden:
    INCBIN "enemy/denden.bin"                          ;; 0a:4d80

;@gfximg name=enemy/gaurdian width=2 height=4
gfxEnemyGuardian:
    INCBIN "enemy/gaurdian.bin"                        ;; 0a:4e00

;@gfximg name=enemy/wonder width=2 height=4
gfxEnemyWonder:
    INCBIN "enemy/wonder.bin"                          ;; 0a:4e80

;@gfximg name=enemy/evil_sword width=2 height=4
gfxEnemyEvilSword:
    INCBIN "enemy/evil_sword.bin"                      ;; 0a:4f00

;@gfximg name=enemy/demon width=2 height=4
gfxEnemyDemon:
    INCBIN "enemy/demon.bin"                           ;; 0a:4f80

;@gfximg name=enemy/rabite width=2 height=6
gfxEnemyRabite:
    INCBIN "enemy/rabite.bin"                          ;; 0a:5000

;@gfximg name=enemy/green_slime width=2 height=6
gfxEnemyGreenSlime:
    INCBIN "enemy/green_slime.bin"                     ;; 0a:50c0

;@gfximg name=enemy/zombie width=2 height=6
gfxEnemyZombie:
    INCBIN "enemy/zombie.bin"                          ;; 0a:5180

;@gfximg name=enemy/pumpkin_bomb width=2 height=6
gfxEnemyPumpkinBomb:
    INCBIN "enemy/pumpkin_bomb.bin"                    ;; 0a:5240

;@gfximg name=enemy/blood_own width=2 height=6
gfxEnemyBloodOwl:
    INCBIN "enemy/blood_own.bin"                       ;; 0a:5300

;@gfximg name=enemy/gas_cloud width=2 height=6
gfxEnemyGasCloud:
    INCBIN "enemy/gas_cloud.bin"                       ;; 0a:53c0

;@gfximg name=enemy/death_crab width=2 height=6
gfxEnemyDeathCrab:
    INCBIN "enemy/death_crab.bin"                      ;; 0a:5480

;@gfximg name=enemy/mandrake width=2 height=6
gfxEnemyMandrake:
    INCBIN "enemy/mandrake.bin"                        ;; 0a:5540

;@gfximg name=enemy/death_scorpion width=2 height=6
gfxEnemyDeathScorpion:
    INCBIN "enemy/death_scorpion.bin"                  ;; 0a:5600

;@gfximg name=enemy/shadow_zero width=2 height=6
gfxEnemyShadowZero:
    INCBIN "enemy/shadow_zero.bin"                     ;; 0a:56c0

;@gfximg name=enemy/mimic width=2 height=6
gfxEnemyMimic:
    INCBIN "enemy/mimic.bin"                           ;; 0a:5780

;@gfximg name=enemy/air_elemental width=2 height=6
gfxEnemyAirElemental:
    INCBIN "enemy/air_elemental.bin"                   ;; 0a:5840

;@gfximg name=enemy/earth_elemental width=2 height=6
gfxEnemyEarthElemental:
    INCBIN "enemy/earth_elemental.bin"                 ;; 0a:5900

;@gfximg name=enemy/doppel_mirror width=2 height=6
gfxEnemyDoppelMirror:
    INCBIN "enemy/doppel_mirror.bin"                   ;; 0a:59c0
    db   $81, $81, $42, $42, $24, $24, $18, $18        ;; 0a:5a80 ????????
    db   $18, $18, $24, $24, $42, $42, $81, $81        ;; 0a:5a88 ????????
    db   $81, $81, $42, $42, $24, $24, $18, $18        ;; 0a:5a90 ????????
    db   $18, $18, $24, $24, $42, $42, $81, $81        ;; 0a:5a98 ????????
    db   $81, $81, $42, $42, $24, $24, $18, $18        ;; 0a:5aa0 ????????
    db   $18, $18, $24, $24, $42, $42, $81, $81        ;; 0a:5aa8 ????????
    db   $81, $81, $42, $42, $24, $24, $18, $18        ;; 0a:5ab0 ????????
    db   $18, $18, $24, $24, $42, $42, $81, $81        ;; 0a:5ab8 ????????
    db   $81, $81, $42, $42, $24, $24, $18, $18        ;; 0a:5ac0 ????????
    db   $18, $18, $24, $24, $42, $42, $81, $81        ;; 0a:5ac8 ????????
    db   $81, $81, $42, $42, $24, $24, $18, $18        ;; 0a:5ad0 ????????
    db   $18, $18, $24, $24, $42, $42, $81, $81        ;; 0a:5ad8 ????????
    db   $81, $81, $42, $42, $24, $24, $18, $18        ;; 0a:5ae0 ????????
    db   $18, $18, $24, $24, $42, $42, $81, $81        ;; 0a:5ae8 ????????
    db   $81, $81, $42, $42, $24, $24, $18, $18        ;; 0a:5af0 ????????
    db   $18, $18, $24, $24, $42, $42, $81, $81        ;; 0a:5af8 ????????
    db   $81, $81, $42, $42, $24, $24, $18, $18        ;; 0a:5b00 ????????
    db   $18, $18, $24, $24, $42, $42, $81, $81        ;; 0a:5b08 ????????
    db   $81, $81, $42, $42, $24, $24, $18, $18        ;; 0a:5b10 ????????
    db   $18, $18, $24, $24, $42, $42, $81, $81        ;; 0a:5b18 ????????
    db   $81, $81, $42, $42, $24, $24, $18, $18        ;; 0a:5b20 ????????
    db   $18, $18, $24, $24, $42, $42, $81, $81        ;; 0a:5b28 ????????
    db   $81, $81, $42, $42, $24, $24, $18, $18        ;; 0a:5b30 ????????
    db   $18, $18, $24, $24, $42, $42, $81, $81        ;; 0a:5b38 ????????

;@gfximg name=enemy/sea_dragon width=2 height=6
gfxEnemySeaDragon:
    INCBIN "enemy/sea_dragon.bin"                      ;; 0a:5b40

;@gfximg name=enemy/goblin width=2 height=8
gfxEnemyGoblin:
    INCBIN "enemy/goblin.bin"                          ;; 0a:5c00

;@gfximg name=enemy/skeleton width=2 height=8
gfxEnemySkeleton:
    INCBIN "enemy/skeleton.bin"                        ;; 0a:5d00

;@gfximg name=enemy/wererat width=2 height=8
gfxEnemyWarerat:
    INCBIN "enemy/wererat.bin"                         ;; 0a:5e00

;@gfximg name=enemy/gal_fish width=2 height=8
gfxEnemyGalFish:
    INCBIN "enemy/gal_fish.bin"                        ;; 0a:5f00

;@gfximg name=enemy/lizardman width=2 height=8
gfxEnemyLizardman:
    INCBIN "enemy/lizardman.bin"                       ;; 0a:6000

;@gfximg name=enemy/tarantula width=2 height=8
gfxEnemyTarantula:
    INCBIN "enemy/tarantula.bin"                       ;; 0a:6100

;@gfximg name=enemy/gargoyle width=2 height=8
gfxEnemyGargoyle:
    INCBIN "enemy/gargoyle.bin"                        ;; 0a:6200

;@gfximg name=enemy/eye_spy width=2 height=8
gfxEnemyEyeSpy:
    INCBIN "enemy/eye_spy.bin"                         ;; 0a:6300

;@gfximg name=enemy/werewolf width=2 height=8
gfxEnemyWerewolf:
    INCBIN "enemy/werewolf.bin"                        ;; 0a:6400

;@gfximg name=enemy/saurus width=2 height=8
gfxEnemySaurus:
    INCBIN "enemy/saurus.bin"                          ;; 0a:6500

;@gfximg name=enemy/cobra width=2 height=8
gfxEnemyCobra:
    INCBIN "enemy/cobra.bin"                           ;; 0a:6600

;@gfximg name=enemy/molebear width=2 height=8
gfxEnemyMolebear:
    INCBIN "enemy/molebear.bin"                        ;; 0a:6700

data_0a_6800:
    db   $01, $01, $06, $07, $08, $0f, $1f, $1f        ;; 0a:6800 ????????
    db   $28, $3f, $56, $79, $5f, $74, $bf, $f3        ;; 0a:6808 ????????
    db   $e0, $e0, $18, $f8, $04, $fc, $c4, $fc        ;; 0a:6810 ????????
    db   $22, $fe, $d1, $3f, $f1, $5f, $f9, $9f        ;; 0a:6818 ????????
    db   $ff, $d2, $ef, $d8, $7f, $6f, $5f, $78        ;; 0a:6820 ????????
    db   $ed, $fe, $7f, $7f, $1f, $1f, $00, $00        ;; 0a:6828 ????????
    db   $fd, $97, $ed, $37, $fa, $ee, $f2, $3e        ;; 0a:6830 ????????
    db   $6a, $fe, $fe, $f6, $7f, $55, $2b, $2b        ;; 0a:6838 ????????
    db   $07, $07, $08, $0f, $10, $1f, $30, $3f        ;; 0a:6840 ????????
    db   $70, $5f, $78, $5f, $20, $3f, $38, $3f        ;; 0a:6848 ????????
    db   $c0, $c0, $20, $e0, $10, $f0, $18, $f8        ;; 0a:6850 ????????
    db   $1c, $f4, $3c, $f4, $08, $f8, $38, $f8        ;; 0a:6858 ????????
    db   $23, $3f, $46, $7b, $8f, $f1, $86, $f9        ;; 0a:6860 ????????
    db   $54, $6f, $b7, $cf, $7f, $7f, $00, $00        ;; 0a:6868 ????????
    db   $04, $fc, $e4, $1c, $f4, $0c, $e2, $1e        ;; 0a:6870 ????????
    db   $42, $7e, $ce, $f2, $ee, $f2, $7c, $7c        ;; 0a:6878 ????????
    db   $00, $00, $0f, $0f, $30, $3f, $40, $7f        ;; 0a:6880 ????????
    db   $73, $4f, $ff, $94, $ff, $a2, $5f, $70        ;; 0a:6888 ????????
    db   $00, $00, $00, $00, $80, $80, $40, $c0        ;; 0a:6890 ????????
    db   $20, $e0, $a0, $e0, $a0, $e0, $98, $f8        ;; 0a:6898 ????????
    db   $3e, $27, $38, $2f, $38, $2f, $18, $1f        ;; 0a:68a0 ????????
    db   $30, $3f, $67, $5f, $78, $58, $ff, $ff        ;; 0a:68a8 ????????
    db   $04, $fc, $42, $fe, $82, $fe, $81, $ff        ;; 0a:68b0 ????????
    db   $c1, $ff, $79, $7f, $7e, $42, $ff, $ff        ;; 0a:68b8 ????????
    db   $0f, $0f, $30, $3f, $40, $7f, $73, $4f        ;; 0a:68c0 ????????
    db   $ff, $94, $ff, $a2, $5f, $70, $3d, $23        ;; 0a:68c8 ????????
    db   $00, $00, $80, $80, $40, $c0, $20, $e0        ;; 0a:68d0 ????????
    db   $a0, $e0, $a0, $e0, $bc, $fc, $02, $fe        ;; 0a:68d8 ????????
    db   $3c, $27, $38, $2f, $10, $1f, $10, $1f        ;; 0a:68e0 ????????
    db   $09, $0f, $09, $0f, $07, $04, $3f, $3f        ;; 0a:68e8 ????????
    db   $02, $fe, $41, $ff, $41, $ff, $c1, $ff        ;; 0a:68f0 ????????
    db   $e1, $3f, $e2, $be, $fc, $dc, $be, $be        ;; 0a:68f8 ????????

data_0a_6900:
    db   $67, $67, $7a, $5f, $37, $2d, $3f, $38        ;; 0a:6900 ????????
    db   $5f, $7d, $ff, $b4, $ff, $b0, $ff, $f7        ;; 0a:6908 ????????
    db   $c0, $c0, $26, $e6, $1e, $fa, $bc, $e4        ;; 0a:6910 ????????
    db   $fc, $dc, $ee, $9e, $ff, $19, $ff, $d1        ;; 0a:6918 ????????
    db   $b7, $f8, $54, $5f, $1f, $1f, $2e, $33        ;; 0a:6920 ????????
    db   $3f, $21, $23, $3d, $11, $1f, $3f, $3f        ;; 0a:6928 ????????
    db   $df, $b1, $33, $fd, $fa, $ce, $7a, $ce        ;; 0a:6930 ????????
    db   $fc, $fc, $90, $f0, $f8, $f8, $e0, $e0        ;; 0a:6938 ????????
    db   $63, $63, $74, $57, $38, $3f, $28, $3f        ;; 0a:6940 ????????
    db   $77, $4f, $7f, $47, $f7, $8f, $ff, $9f        ;; 0a:6948 ????????
    db   $e0, $e0, $96, $f6, $0e, $fa, $04, $fc        ;; 0a:6950 ????????
    db   $0e, $fe, $ad, $ff, $bf, $fd, $fe, $fe        ;; 0a:6958 ????????
    db   $cf, $bf, $bb, $ff, $78, $4f, $7d, $4f        ;; 0a:6960 ????????
    db   $3f, $3f, $09, $0f, $1f, $1f, $07, $07        ;; 0a:6968 ????????
    db   $fc, $fc, $c8, $f8, $3c, $f4, $7c, $c4        ;; 0a:6970 ????????
    db   $fc, $84, $84, $fc, $88, $f8, $fc, $fc        ;; 0a:6978 ????????
    db   $1e, $1e, $71, $7f, $bb, $ee, $79, $6f        ;; 0a:6980 ????????
    db   $3e, $3f, $3e, $2b, $3f, $21, $3e, $3d        ;; 0a:6988 ????????
    db   $30, $30, $f0, $d0, $e0, $20, $d0, $f0        ;; 0a:6990 ????????
    db   $68, $f8, $f8, $88, $fc, $84, $fc, $c4        ;; 0a:6998 ????????
    db   $3b, $27, $27, $3c, $1f, $1c, $07, $07        ;; 0a:69a0 ????????
    db   $07, $04, $02, $03, $04, $07, $0f, $0f        ;; 0a:69a8 ????????
    db   $7c, $84, $b8, $c8, $b8, $d8, $e4, $fc        ;; 0a:69b0 ????????
    db   $f4, $3c, $18, $f8, $10, $f0, $f8, $f8        ;; 0a:69b8 ????????
    db   $1f, $1f, $28, $3f, $5c, $77, $3e, $23        ;; 0a:69c0 ????????
    db   $3f, $37, $3f, $32, $7f, $60, $ff, $be        ;; 0a:69c8 ????????
    db   $98, $98, $7c, $ec, $f2, $9e, $7c, $fc        ;; 0a:69d0 ????????
    db   $3e, $e2, $ff, $c1, $7f, $c1, $71, $ff        ;; 0a:69d8 ????????
    db   $fe, $a1, $71, $7f, $1f, $1f, $3f, $30        ;; 0a:69e0 ????????
    db   $43, $7c, $21, $3f, $13, $1f, $7f, $7f        ;; 0a:69e8 ????????
    db   $fd, $ff, $ff, $f3, $7e, $f2, $9e, $fe        ;; 0a:69f0 ????????
    db   $d1, $7f, $e2, $fe, $f4, $fc, $ff, $ff        ;; 0a:69f8 ????????

data_0a_6a00:
    db   $1c, $1c, $3e, $22, $7f, $41, $7f, $4f        ;; 0a:6a00 ????????
    db   $7f, $5d, $3e, $22, $3f, $3f, $40, $7f        ;; 0a:6a08 ????????
    db   $1c, $1c, $3e, $22, $7f, $41, $7f, $79        ;; 0a:6a10 ????????
    db   $7f, $5d, $3e, $22, $fe, $fe, $01, $ff        ;; 0a:6a18 ????????
    db   $5f, $7f, $3f, $27, $3f, $2d, $39, $2f        ;; 0a:6a20 ????????
    db   $16, $17, $01, $01, $00, $00, $3f, $3f        ;; 0a:6a28 ????????
    db   $fd, $ff, $fe, $f2, $fe, $da, $ce, $fa        ;; 0a:6a30 ????????
    db   $34, $f4, $c0, $c0, $00, $00, $fe, $fe        ;; 0a:6a38 ????????
    db   $00, $00, $1c, $1c, $3e, $22, $7f, $41        ;; 0a:6a40 ????????
    db   $7f, $4f, $7f, $5d, $3e, $22, $1c, $1c        ;; 0a:6a48 ????????
    db   $00, $00, $1c, $1c, $3e, $22, $7f, $41        ;; 0a:6a50 ????????
    db   $7f, $79, $7f, $5d, $3e, $22, $1c, $1c        ;; 0a:6a58 ????????
    db   $23, $3f, $5d, $7e, $7f, $66, $3c, $2f        ;; 0a:6a60 ????????
    db   $3b, $2b, $10, $10, $00, $00, $7f, $7f        ;; 0a:6a68 ????????
    db   $e2, $fe, $5d, $bf, $ff, $b3, $1e, $fa        ;; 0a:6a70 ????????
    db   $ee, $ea, $04, $04, $00, $00, $ff, $ff        ;; 0a:6a78 ????????
    db   $00, $00, $1c, $1c, $3e, $22, $7f, $79        ;; 0a:6a80 ????????
    db   $77, $4d, $7f, $4f, $3e, $2a, $3c, $3c        ;; 0a:6a88 ????????
    db   $00, $00, $1c, $1c, $3e, $22, $7f, $4f        ;; 0a:6a90 ????????
    db   $77, $59, $7f, $79, $3e, $2a, $1e, $1e        ;; 0a:6a98 ????????
    db   $47, $7f, $58, $7f, $3f, $27, $3f, $2d        ;; 0a:6aa0 ????????
    db   $38, $2f, $17, $17, $00, $00, $7f, $7f        ;; 0a:6aa8 ????????
    db   $f1, $ff, $0d, $ff, $fe, $f2, $fe, $da        ;; 0a:6ab0 ????????
    db   $0e, $fa, $f4, $f4, $00, $00, $ff, $ff        ;; 0a:6ab8 ????????
    db   $1c, $1c, $3e, $22, $7f, $79, $77, $4d        ;; 0a:6ac0 ????????
    db   $7f, $4f, $3e, $2a, $1d, $1d, $06, $07        ;; 0a:6ac8 ????????
    db   $1c, $1c, $3e, $22, $7f, $4f, $77, $59        ;; 0a:6ad0 ????????
    db   $7f, $79, $3e, $2a, $dc, $dc, $30, $f0        ;; 0a:6ad8 ????????
    db   $19, $1f, $3e, $27, $79, $6f, $7e, $6e        ;; 0a:6ae0 ????????
    db   $10, $10, $00, $00, $00, $00, $3f, $3f        ;; 0a:6ae8 ????????
    db   $cc, $fc, $3e, $f2, $cf, $fb, $3f, $3b        ;; 0a:6af0 ????????
    db   $04, $04, $00, $00, $00, $00, $fe, $fe        ;; 0a:6af8 ????????

data_0a_6b00:
    db   $16, $16, $6f, $7f, $ff, $bf, $fb, $8f        ;; 0a:6b00 ????????
    db   $71, $5f, $b4, $ff, $96, $fb, $96, $fb        ;; 0a:6b08 ????????
    db   $d8, $d8, $e4, $fc, $fe, $fa, $be, $e2        ;; 0a:6b10 ????????
    db   $9d, $f7, $59, $ff, $d1, $bf, $d5, $bf        ;; 0a:6b18 ????????
    db   $88, $ff, $4b, $7f, $5f, $7c, $3f, $27        ;; 0a:6b20 ????????
    db   $3d, $27, $1f, $1f, $3f, $3f, $01, $01        ;; 0a:6b28 ????????
    db   $26, $fe, $a4, $fc, $c8, $78, $f4, $fc        ;; 0a:6b30 ????????
    db   $84, $fc, $08, $f8, $fc, $3c, $f8, $f8        ;; 0a:6b38 ????????
    db   $06, $06, $4f, $4f, $fb, $bf, $e4, $bf        ;; 0a:6b40 ????????
    db   $46, $7b, $43, $7d, $96, $fb, $8c, $ff        ;; 0a:6b48 ????????
    db   $c0, $c0, $f4, $f4, $ae, $fa, $46, $fe        ;; 0a:6b50 ????????
    db   $c2, $be, $81, $7f, $c5, $bf, $46, $fe        ;; 0a:6b58 ????????
    db   $b8, $ff, $7f, $4f, $7f, $4f, $33, $3f        ;; 0a:6b60 ????????
    db   $09, $0f, $1f, $1f, $0f, $0f, $03, $03        ;; 0a:6b68 ????????
    db   $28, $f8, $f8, $f8, $c8, $f8, $84, $fc        ;; 0a:6b70 ????????
    db   $04, $fc, $08, $f8, $fc, $3c, $f0, $f0        ;; 0a:6b78 ????????
    db   $06, $06, $0f, $0f, $17, $17, $0b, $0f        ;; 0a:6b80 ????????
    db   $11, $1f, $26, $3f, $2c, $3b, $2c, $3b        ;; 0a:6b88 ????????
    db   $c0, $c0, $e8, $e8, $fc, $f4, $7c, $c4        ;; 0a:6b90 ????????
    db   $98, $e8, $78, $f8, $34, $ec, $22, $fe        ;; 0a:6b98 ????????
    db   $70, $5f, $f1, $9f, $d7, $bf, $7f, $7f        ;; 0a:6ba0 ????????
    db   $06, $07, $02, $03, $01, $01, $1f, $1f        ;; 0a:6ba8 ????????
    db   $72, $fe, $c2, $fe, $e4, $3c, $fc, $3c        ;; 0a:6bb0 ????????
    db   $fa, $fe, $14, $f6, $e2, $22, $fc, $fc        ;; 0a:6bb8 ????????
    db   $00, $00, $06, $06, $0f, $0f, $17, $17        ;; 0a:6bc0 ????????
    db   $0b, $0f, $11, $1f, $26, $3f, $2c, $3b        ;; 0a:6bc8 ????????
    db   $00, $00, $c0, $c0, $e8, $e8, $fc, $f4        ;; 0a:6bd0 ????????
    db   $7c, $c4, $98, $e8, $7c, $fc, $32, $ee        ;; 0a:6bd8 ????????
    db   $2c, $3b, $70, $5f, $f1, $9f, $d6, $bf        ;; 0a:6be0 ????????
    db   $7f, $7f, $13, $1f, $31, $2f, $77, $7f        ;; 0a:6be8 ????????
    db   $21, $ff, $71, $ff, $99, $ff, $3b, $e7        ;; 0a:6bf0 ????????
    db   $fe, $e6, $99, $ff, $85, $ff, $ff, $fd        ;; 0a:6bf8 ????????

data_0a_6c00:
    db   $1f, $1f, $20, $3f, $4e, $71, $50, $6f        ;; 0a:6c00 ????????
    db   $57, $6f, $5c, $7f, $98, $ff, $b0, $ff        ;; 0a:6c08 ????????
    db   $e0, $e0, $10, $f0, $08, $f8, $08, $f8        ;; 0a:6c10 ????????
    db   $88, $f8, $e8, $f8, $64, $fc, $34, $fc        ;; 0a:6c18 ????????
    db   $a7, $ff, $5c, $7f, $7f, $67, $ff, $90        ;; 0a:6c20 ????????
    db   $ff, $90, $7f, $7c, $23, $3f, $1f, $1f        ;; 0a:6c28 ????????
    db   $94, $fc, $e8, $f8, $f8, $18, $f4, $3c        ;; 0a:6c30 ????????
    db   $c4, $7c, $c4, $7c, $c8, $f8, $30, $30        ;; 0a:6c38 ????????
    db   $07, $07, $18, $1f, $27, $38, $48, $77        ;; 0a:6c40 ????????
    db   $50, $6f, $50, $6f, $40, $7f, $80, $ff        ;; 0a:6c48 ????????
    db   $80, $80, $60, $e0, $90, $70, $08, $f8        ;; 0a:6c50 ????????
    db   $08, $f8, $08, $f8, $08, $f8, $04, $fc        ;; 0a:6c58 ????????
    db   $80, $ff, $78, $7f, $7f, $4f, $ff, $90        ;; 0a:6c60 ????????
    db   $ff, $a0, $7f, $60, $1f, $11, $0e, $0e        ;; 0a:6c68 ????????
    db   $54, $fc, $fe, $aa, $fc, $54, $fc, $2c        ;; 0a:6c70 ????????
    db   $f8, $08, $f8, $e8, $10, $f0, $e0, $e0        ;; 0a:6c78 ????????
    db   $0f, $0f, $13, $1c, $24, $3b, $40, $7f        ;; 0a:6c80 ????????
    db   $7e, $7f, $1f, $17, $71, $6f, $e2, $9f        ;; 0a:6c88 ????????
    db   $e0, $e0, $10, $f0, $08, $f8, $04, $fc        ;; 0a:6c90 ????????
    db   $04, $fc, $04, $fc, $84, $fc, $82, $fe        ;; 0a:6c98 ????????
    db   $7f, $7f, $0f, $0e, $1f, $13, $3f, $25        ;; 0a:6ca0 ????????
    db   $3f, $24, $1f, $13, $0c, $0f, $3f, $3f        ;; 0a:6ca8 ????????
    db   $c2, $7e, $fc, $7c, $de, $5a, $fc, $24        ;; 0a:6cb0 ????????
    db   $f8, $48, $f0, $d0, $20, $e0, $fc, $fc        ;; 0a:6cb8 ????????
    db   $00, $00, $0f, $0f, $11, $1e, $22, $3d        ;; 0a:6cc0 ????????
    db   $40, $7f, $7c, $7f, $1f, $17, $71, $6f        ;; 0a:6cc8 ????????
    db   $00, $00, $e0, $e0, $90, $70, $08, $f8        ;; 0a:6cd0 ????????
    db   $04, $fc, $04, $fc, $04, $fc, $84, $fc        ;; 0a:6cd8 ????????
    db   $e2, $9f, $7f, $7f, $3f, $2e, $7f, $58        ;; 0a:6ce0 ????????
    db   $3f, $30, $5f, $70, $2f, $38, $7f, $7f        ;; 0a:6ce8 ????????
    db   $82, $fe, $c2, $7e, $fc, $7c, $fe, $9a        ;; 0a:6cf0 ????????
    db   $fc, $94, $e8, $78, $98, $f8, $fe, $fe        ;; 0a:6cf8 ????????

data_0a_6d00:
    db   $03, $03, $0f, $0c, $1f, $10, $3f, $20        ;; 0a:6d00 ????????
    db   $3f, $20, $7f, $40, $7f, $43, $7f, $47        ;; 0a:6d08 ????????
    db   $c0, $c0, $f0, $30, $e8, $18, $e4, $1c        ;; 0a:6d10 ????????
    db   $f4, $0c, $f2, $0e, $f2, $8e, $f2, $ce        ;; 0a:6d18 ????????
    db   $7f, $47, $3f, $27, $3f, $23, $1e, $11        ;; 0a:6d20 ????????
    db   $0c, $0f, $03, $03, $00, $00, $1f, $1f        ;; 0a:6d28 ????????
    db   $f2, $4e, $e4, $dc, $c4, $bc, $08, $f8        ;; 0a:6d30 ????????
    db   $30, $f0, $c0, $c0, $00, $00, $f8, $f8        ;; 0a:6d38 ????????
    db   $03, $03, $0f, $0c, $1f, $10, $3f, $20        ;; 0a:6d40 ????????
    db   $3f, $20, $7f, $40, $7f, $40, $7f, $40        ;; 0a:6d48 ????????
    db   $c0, $c0, $f0, $30, $e8, $18, $e4, $1c        ;; 0a:6d50 ????????
    db   $f4, $0c, $f2, $0e, $f2, $0e, $f2, $0e        ;; 0a:6d58 ????????
    db   $7f, $40, $3f, $20, $27, $38, $10, $1f        ;; 0a:6d60 ????????
    db   $0c, $0f, $03, $03, $00, $00, $1f, $1f        ;; 0a:6d68 ????????
    db   $f2, $0e, $e4, $1c, $84, $7c, $08, $f8        ;; 0a:6d70 ????????
    db   $30, $f0, $c0, $c0, $00, $00, $f8, $f8        ;; 0a:6d78 ????????
    db   $03, $03, $0f, $0c, $17, $18, $27, $38        ;; 0a:6d80 ????????
    db   $2f, $30, $4f, $7c, $5f, $7e, $5f, $76        ;; 0a:6d88 ????????
    db   $c0, $c0, $f0, $30, $f8, $08, $fc, $04        ;; 0a:6d90 ????????
    db   $fc, $04, $fe, $02, $fe, $02, $fe, $02        ;; 0a:6d98 ????????
    db   $5f, $7e, $2f, $3c, $23, $3c, $11, $1e        ;; 0a:6da0 ????????
    db   $0c, $0f, $03, $03, $00, $00, $1f, $1f        ;; 0a:6da8 ????????
    db   $fe, $02, $fc, $04, $fc, $04, $f8, $08        ;; 0a:6db0 ????????
    db   $30, $f0, $c0, $c0, $00, $00, $f8, $f8        ;; 0a:6db8 ????????
    db   $00, $00, $00, $00, $07, $07, $1f, $18        ;; 0a:6dc0 ????????
    db   $2f, $30, $5f, $7c, $bf, $fe, $bf, $ee        ;; 0a:6dc8 ????????
    db   $00, $00, $00, $00, $e0, $e0, $f8, $18        ;; 0a:6dd0 ????????
    db   $fc, $04, $fe, $02, $ff, $01, $ff, $01        ;; 0a:6dd8 ????????
    db   $bf, $fe, $5f, $7c, $21, $3e, $18, $1f        ;; 0a:6de0 ????????
    db   $07, $07, $00, $00, $00, $00, $7f, $7f        ;; 0a:6de8 ????????
    db   $ff, $01, $fe, $02, $fc, $04, $38, $d8        ;; 0a:6df0 ????????
    db   $e0, $e0, $00, $00, $00, $00, $fe, $fe        ;; 0a:6df8 ????????

data_0a_6e00:
    db   $00, $00, $07, $07, $1f, $1b, $3f, $39        ;; 0a:6e00 ????????
    db   $3f, $20, $7f, $71, $7f, $64, $7f, $6f        ;; 0a:6e08 ????????
    db   $00, $00, $e0, $e0, $f8, $f8, $fc, $fc        ;; 0a:6e10 ????????
    db   $fc, $7c, $fe, $fa, $fe, $f2, $fe, $e6        ;; 0a:6e18 ????????
    db   $7c, $7f, $7b, $7f, $47, $7f, $7f, $65        ;; 0a:6e20 ????????
    db   $7f, $75, $3f, $3f, $03, $03, $00, $00        ;; 0a:6e28 ????????
    db   $3e, $fe, $de, $fe, $e2, $fe, $fe, $a6        ;; 0a:6e30 ????????
    db   $fe, $ae, $fc, $fc, $c0, $c0, $00, $00        ;; 0a:6e38 ????????
    db   $00, $00, $07, $07, $1f, $1b, $3f, $33        ;; 0a:6e40 ????????
    db   $3f, $33, $7f, $62, $7f, $47, $7f, $7f        ;; 0a:6e48 ????????
    db   $00, $00, $e0, $e0, $f8, $f8, $fc, $dc        ;; 0a:6e50 ????????
    db   $fc, $9c, $fe, $06, $fe, $8e, $fe, $26        ;; 0a:6e58 ????????
    db   $7f, $7f, $7f, $7f, $4f, $7f, $7f, $73        ;; 0a:6e60 ????????
    db   $7f, $78, $3f, $38, $07, $07, $00, $00        ;; 0a:6e68 ????????
    db   $fe, $76, $fe, $fe, $f2, $fe, $fe, $ce        ;; 0a:6e70 ????????
    db   $fe, $1e, $fc, $1c, $e0, $e0, $00, $00        ;; 0a:6e78 ????????
    db   $1c, $1c, $7e, $66, $bd, $ff, $bd, $f7        ;; 0a:6e80 ????????
    db   $9b, $ff, $67, $7d, $1f, $1b, $3c, $27        ;; 0a:6e88 ????????
    db   $00, $00, $00, $00, $c0, $c0, $f0, $f0        ;; 0a:6e90 ????????
    db   $f8, $e8, $fc, $84, $fc, $e4, $fc, $e4        ;; 0a:6e98 ????????
    db   $28, $3f, $39, $2f, $27, $3f, $3f, $23        ;; 0a:6ea0 ????????
    db   $1c, $17, $0c, $0f, $04, $07, $03, $03        ;; 0a:6ea8 ????????
    db   $fc, $ec, $fc, $fc, $fc, $bc, $fc, $cc        ;; 0a:6eb0 ????????
    db   $f2, $fe, $7b, $ff, $66, $e6, $80, $80        ;; 0a:6eb8 ????????
    db   $00, $00, $1c, $1c, $7e, $66, $bd, $f7        ;; 0a:6ec0 ????????
    db   $bd, $e7, $9b, $ff, $67, $7d, $1f, $1b        ;; 0a:6ec8 ????????
    db   $00, $00, $00, $00, $00, $00, $c0, $c0        ;; 0a:6ed0 ????????
    db   $f0, $f0, $f8, $e8, $fc, $84, $fc, $e4        ;; 0a:6ed8 ????????
    db   $7c, $67, $a4, $ff, $be, $e7, $67, $7f        ;; 0a:6ee0 ????????
    db   $39, $2f, $11, $1f, $13, $1f, $0c, $0c        ;; 0a:6ee8 ????????
    db   $fc, $e4, $7c, $ec, $fc, $fc, $ff, $bf        ;; 0a:6ef0 ????????
    db   $f9, $cf, $fe, $fe, $90, $f0, $60, $60        ;; 0a:6ef8 ????????

data_0a_6f00:
    db   $02, $02, $07, $05, $0f, $0c, $1f, $10        ;; 0a:6f00 ????????
    db   $3f, $2c, $3f, $2e, $3f, $2a, $7f, $67        ;; 0a:6f08 ????????
    db   $80, $80, $c0, $40, $e0, $60, $f0, $10        ;; 0a:6f10 ????????
    db   $f8, $68, $f8, $e8, $fc, $ac, $fe, $ca        ;; 0a:6f18 ????????
    db   $bc, $d7, $f8, $ef, $fc, $97, $ff, $97        ;; 0a:6f20 ????????
    db   $6f, $77, $5b, $6d, $ff, $9b, $7f, $7f        ;; 0a:6f28 ????????
    db   $71, $df, $35, $ef, $76, $ee, $fa, $f6        ;; 0a:6f30 ????????
    db   $f9, $df, $df, $75, $8e, $fe, $d0, $f0        ;; 0a:6f38 ????????
    db   $02, $02, $0f, $0d, $1f, $14, $2f, $30        ;; 0a:6f40 ????????
    db   $3f, $20, $2f, $33, $1f, $1c, $3c, $33        ;; 0a:6f48 ????????
    db   $80, $80, $e0, $60, $f0, $50, $e8, $18        ;; 0a:6f50 ????????
    db   $f8, $08, $f8, $e8, $f8, $18, $1c, $e4        ;; 0a:6f58 ????????
    db   $40, $7f, $90, $ff, $d0, $ff, $e1, $be        ;; 0a:6f60 ????????
    db   $67, $79, $3f, $27, $3f, $3f, $7f, $7f        ;; 0a:6f68 ????????
    db   $02, $fe, $0a, $fe, $04, $fc, $f2, $0e        ;; 0a:6f70 ????????
    db   $fe, $f2, $be, $fe, $0c, $f4, $fe, $fe        ;; 0a:6f78 ????????
    db   $01, $01, $07, $06, $0f, $08, $0f, $0b        ;; 0a:6f80 ????????
    db   $1f, $17, $1f, $15, $3f, $36, $4f, $78        ;; 0a:6f88 ????????
    db   $60, $60, $e0, $a0, $f0, $10, $f8, $88        ;; 0a:6f90 ????????
    db   $f8, $08, $f8, $08, $f0, $10, $f8, $78        ;; 0a:6f98 ????????
    db   $87, $fd, $73, $7e, $0f, $0d, $1f, $12        ;; 0a:6fa0 ????????
    db   $0f, $0a, $0d, $0f, $18, $17, $3f, $3f        ;; 0a:6fa8 ????????
    db   $fc, $84, $88, $78, $90, $f0, $d0, $70        ;; 0a:6fb0 ????????
    db   $d0, $70, $88, $f8, $fc, $84, $f8, $f8        ;; 0a:6fb8 ????????
    db   $00, $00, $01, $01, $07, $06, $0f, $08        ;; 0a:6fc0 ????????
    db   $1f, $13, $7f, $77, $8f, $fd, $6f, $7e        ;; 0a:6fc8 ????????
    db   $00, $00, $60, $60, $e0, $a0, $f0, $10        ;; 0a:6fd0 ????????
    db   $f8, $88, $f8, $08, $f8, $08, $f0, $10        ;; 0a:6fd8 ????????
    db   $17, $1c, $1b, $1e, $27, $3d, $1f, $1e        ;; 0a:6fe0 ????????
    db   $df, $d2, $ff, $b9, $47, $7f, $2f, $3f        ;; 0a:6fe8 ????????
    db   $f8, $78, $fc, $84, $88, $78, $34, $fc        ;; 0a:6ff0 ????????
    db   $7c, $cc, $fa, $4e, $ff, $b1, $ce, $fe        ;; 0a:6ff8 ????????

data_0a_7000:
    db   $01, $01, $77, $76, $7f, $48, $7f, $42        ;; 0a:7000 ????????
    db   $3f, $39, $1f, $11, $7f, $73, $9f, $f4        ;; 0a:7008 ????????
    db   $c0, $c0, $f7, $37, $ff, $09, $ff, $21        ;; 0a:7010 ????????
    db   $fe, $4e, $fc, $44, $fe, $e6, $fd, $17        ;; 0a:7018 ????????
    db   $ef, $fd, $fb, $9f, $f8, $9f, $74, $7f        ;; 0a:7020 ????????
    db   $2f, $3b, $39, $3f, $07, $07, $00, $00        ;; 0a:7028 ????????
    db   $fe, $5e, $ee, $fa, $0c, $fc, $14, $fc        ;; 0a:7030 ????????
    db   $fa, $ee, $4e, $fe, $90, $f0, $e0, $e0        ;; 0a:7038 ????????
    db   $01, $01, $77, $76, $7f, $48, $7f, $40        ;; 0a:7040 ????????
    db   $3f, $38, $1f, $10, $3f, $3b, $44, $7f        ;; 0a:7048 ????????
    db   $c0, $c0, $f7, $37, $ff, $09, $ff, $01        ;; 0a:7050 ????????
    db   $fe, $0e, $fc, $04, $fe, $e6, $19, $ff        ;; 0a:7058 ????????
    db   $74, $7f, $f8, $9f, $f4, $9f, $6b, $7f        ;; 0a:7060 ????????
    db   $1f, $19, $09, $0f, $07, $07, $00, $00        ;; 0a:7068 ????????
    db   $0e, $fe, $0e, $fa, $14, $fc, $ea, $fe        ;; 0a:7070 ????????
    db   $7e, $ce, $88, $f8, $90, $f0, $f8, $f8        ;; 0a:7078 ????????
    db   $03, $03, $07, $04, $0f, $09, $0f, $0a        ;; 0a:7080 ????????
    db   $3f, $3a, $3f, $20, $3f, $20, $3f, $3c        ;; 0a:7088 ????????
    db   $e0, $e0, $fe, $1e, $fe, $82, $fe, $02        ;; 0a:7090 ????????
    db   $fc, $24, $f8, $38, $c4, $7c, $9e, $fe        ;; 0a:7098 ????????
    db   $79, $7f, $e6, $bf, $e0, $bf, $71, $7f        ;; 0a:70a0 ????????
    db   $0f, $0e, $0a, $0f, $04, $07, $07, $07        ;; 0a:70a8 ????????
    db   $9e, $f2, $7f, $f1, $77, $c9, $f6, $ce        ;; 0a:70b0 ????????
    db   $fc, $3c, $14, $fc, $18, $f8, $e0, $e0        ;; 0a:70b8 ????????
    db   $00, $00, $19, $19, $3f, $26, $3f, $20        ;; 0a:70c0 ????????
    db   $1f, $11, $0f, $08, $0f, $08, $1f, $10        ;; 0a:70c8 ????????
    db   $00, $00, $e0, $e0, $f8, $18, $fe, $c6        ;; 0a:70d0 ????????
    db   $ff, $01, $fe, $22, $fc, $3c, $c6, $7e        ;; 0a:70d8 ????????
    db   $1f, $14, $09, $0f, $17, $1f, $31, $3f        ;; 0a:70e0 ????????
    db   $4c, $7f, $23, $3f, $12, $1e, $0c, $0c        ;; 0a:70e8 ????????
    db   $9a, $fe, $fe, $e6, $de, $26, $dc, $2c        ;; 0a:70f0 ????????
    db   $f2, $fe, $a2, $fe, $4c, $7c, $70, $70        ;; 0a:70f8 ????????

data_0a_7100:
    db   $07, $07, $09, $0e, $11, $1e, $19, $16        ;; 0a:7100 ????????
    db   $17, $18, $37, $3e, $4f, $7a, $84, $ff        ;; 0a:7108 ????????
    db   $ea, $ee, $15, $f7, $0d, $ff, $1d, $ef        ;; 0a:7110 ????????
    db   $ea, $1e, $ec, $fc, $f2, $5e, $21, $ff        ;; 0a:7118 ????????
    db   $83, $ff, $e1, $ff, $f8, $9f, $f0, $9f        ;; 0a:7120 ????????
    db   $70, $7f, $08, $0f, $04, $07, $1f, $1f        ;; 0a:7128 ????????
    db   $cd, $ff, $9f, $f3, $1f, $f3, $0e, $fe        ;; 0a:7130 ????????
    db   $88, $f8, $90, $f0, $f0, $f0, $f8, $f8        ;; 0a:7138 ????????
    db   $57, $77, $a8, $ef, $b0, $ff, $b0, $ff        ;; 0a:7140 ????????
    db   $50, $7f, $30, $3f, $38, $3f, $44, $7f        ;; 0a:7148 ????????
    db   $e0, $e0, $10, $f0, $08, $f8, $08, $f8        ;; 0a:7150 ????????
    db   $08, $f8, $08, $f8, $1c, $fc, $22, $fe        ;; 0a:7158 ????????
    db   $43, $7f, $78, $5f, $38, $3f, $10, $1f        ;; 0a:7160 ????????
    db   $10, $1f, $08, $0f, $04, $07, $03, $03        ;; 0a:7168 ????????
    db   $c1, $ff, $89, $ff, $9f, $fd, $4b, $fb        ;; 0a:7170 ????????
    db   $f0, $f0, $90, $f0, $e0, $e0, $f0, $f0        ;; 0a:7178 ????????
    db   $0f, $0f, $18, $17, $30, $2f, $31, $2e        ;; 0a:7180 ????????
    db   $3e, $21, $1f, $1e, $1e, $15, $11, $1f        ;; 0a:7188 ????????
    db   $e3, $e3, $15, $f7, $09, $ff, $0a, $fe        ;; 0a:7190 ????????
    db   $0a, $fe, $0a, $fe, $1a, $fe, $a4, $fc        ;; 0a:7198 ????????
    db   $0e, $0f, $18, $1f, $11, $1f, $13, $1e        ;; 0a:71a0 ????????
    db   $0b, $0e, $05, $07, $08, $0f, $3f, $3f        ;; 0a:71a8 ????????
    db   $78, $f8, $10, $f0, $90, $f0, $90, $70        ;; 0a:71b0 ????????
    db   $a0, $60, $c0, $c0, $40, $c0, $fc, $fc        ;; 0a:71b8 ????????
    db   $00, $00, $0f, $0f, $10, $1f, $30, $2f        ;; 0a:71c0 ????????
    db   $31, $2e, $3f, $21, $1f, $1e, $1e, $15        ;; 0a:71c8 ????????
    db   $00, $00, $e0, $e0, $17, $f7, $0c, $ff        ;; 0a:71d0 ????????
    db   $09, $ff, $0a, $fe, $1a, $fe, $24, $fc        ;; 0a:71d8 ????????
    db   $11, $1f, $0e, $0f, $18, $1f, $10, $1f        ;; 0a:71e0 ????????
    db   $18, $1f, $20, $3f, $13, $1f, $3f, $3f        ;; 0a:71e8 ????????
    db   $f8, $f8, $10, $f0, $08, $f8, $9c, $e4        ;; 0a:71f0 ????????
    db   $7c, $e4, $18, $f8, $90, $f0, $fc, $fc        ;; 0a:71f8 ????????

data_0a_7200:
    dw   `00000003                                     ;; 0a:7200 $01 $01
    dw   `00000331                                     ;; 0a:7202 $07 $06
    dw   `00033323                                     ;; 0a:7204 $1d $1f
    dw   `00311132                                     ;; 0a:7206 $3e $23
    dw   `00333332                                     ;; 0a:7208 $3e $3f
    dw   `33313132                                     ;; 0a:720a $fe $eb
    dw   `31313333                                     ;; 0a:720c $ff $af
    dw   `03231111                                     ;; 0a:720e $5f $70

    dw   `00000000                                     ;; 0a:7210 $00 $00
    dw   `33000000                                     ;; 0a:7212 $c0 $c0
    dw   `23330000                                     ;; 0a:7214 $70 $f0
    dw   `31113000                                     ;; 0a:7216 $f8 $88
    dw   `33333000                                     ;; 0a:7218 $f8 $f8
    dw   `31313330                                     ;; 0a:721a $fe $ae
    dw   `33313130                                     ;; 0a:721c $fe $ea
    dw   `11132300                                     ;; 0a:721e $f4 $1c

    dw   `31311333                                     ;; 0a:7220 $ff $a7
    dw   `03313111                                     ;; 0a:7222 $7f $68
    dw   `03311133                                     ;; 0a:7224 $7f $63
    dw   `31133311                                     ;; 0a:7226 $ff $9c
    dw   `31132111                                     ;; 0a:7228 $f7 $98
    dw   `03303333                                     ;; 0a:722a $6f $6f
    dw   `00031113                                     ;; 0a:722c $1f $11
    dw   `00033333                                     ;; 0a:722e $1f $1f

    dw   `33113130                                     ;; 0a:7230 $fe $ca
    dw   `11313300                                     ;; 0a:7232 $fc $2c
    dw   `31113130                                     ;; 0a:7234 $fe $8a
    dw   `13333130                                     ;; 0a:7236 $fe $7a
    dw   `11311300                                     ;; 0a:7238 $fc $24
    dw   `33111300                                     ;; 0a:723a $fc $c4
    dw   `03113000                                     ;; 0a:723c $78 $48
    dw   `00330000                                     ;; 0a:723e $30 $30

    dw   `00000003                                     ;; 0a:7240 $01 $01
    dw   `00000331                                     ;; 0a:7242 $07 $06
    dw   `00033223                                     ;; 0a:7244 $19 $1f
    dw   `00322223                                     ;; 0a:7246 $21 $3f
    dw   `00322222                                     ;; 0a:7248 $20 $3f
    dw   `33322222                                     ;; 0a:724a $e0 $ff
    dw   `31322222                                     ;; 0a:724c $e0 $bf
    dw   `03222222                                     ;; 0a:724e $40 $7f

    dw   `00000000                                     ;; 0a:7250 $00 $00
    dw   `33000000                                     ;; 0a:7252 $c0 $c0
    dw   `12330000                                     ;; 0a:7254 $b0 $70
    dw   `13223000                                     ;; 0a:7256 $c8 $78
    dw   `33223000                                     ;; 0a:7258 $c8 $f8
    dw   `31323330                                     ;; 0a:725a $ee $be
    dw   `31323130                                     ;; 0a:725c $ee $ba
    dw   `33222300                                     ;; 0a:725e $c4 $fc

    dw   `31322222                                     ;; 0a:7260 $e0 $bf
    dw   `03322222                                     ;; 0a:7262 $60 $7f
    dw   `03322222                                     ;; 0a:7264 $60 $7f
    dw   `31132222                                     ;; 0a:7266 $f0 $9f
    dw   `03333223                                     ;; 0a:7268 $79 $7f
    dw   `00031333                                     ;; 0a:726a $1f $17
    dw   `00311111                                     ;; 0a:726c $3f $20
    dw   `00033333                                     ;; 0a:726e $1f $1f

    dw   `31323130                                     ;; 0a:7270 $ee $ba
    dw   `31323300                                     ;; 0a:7272 $ec $bc
    dw   `33331130                                     ;; 0a:7274 $fe $f2
    dw   `31131130                                     ;; 0a:7276 $fe $92
    dw   `11313300                                     ;; 0a:7278 $fc $2c
    dw   `13113000                                     ;; 0a:727a $f8 $48
    dw   `33330000                                     ;; 0a:727c $f0 $f0
    dw   `00000000                                     ;; 0a:727e $00 $00

    dw   `00003303                                     ;; 0a:7280 $0d $0d
    dw   `00003131                                     ;; 0a:7282 $0f $0a
    dw   `00032222                                     ;; 0a:7284 $10 $1f
    dw   `00323332                                     ;; 0a:7286 $2e $3f
    dw   `03231113                                     ;; 0a:7288 $5f $71
    dw   `03233333                                     ;; 0a:728a $5f $7f
    dw   `03333313                                     ;; 0a:728c $7f $7d
    dw   `31113332                                     ;; 0a:728e $fe $8f

    dw   `03000000                                     ;; 0a:7290 $40 $40
    dw   `31330000                                     ;; 0a:7292 $f0 $b0
    dw   `32313000                                     ;; 0a:7294 $b8 $e8
    dw   `22233000                                     ;; 0a:7296 $18 $f8
    dw   `22221300                                     ;; 0a:7298 $0c $f4
    dw   `22323000                                     ;; 0a:729a $28 $f8
    dw   `23123000                                     ;; 0a:729c $68 $d8
    dw   `23323000                                     ;; 0a:729e $68 $f8

    dw   `03331113                                     ;; 0a:72a0 $7f $71
    dw   `31113313                                     ;; 0a:72a2 $ff $8d
    dw   `03331133                                     ;; 0a:72a4 $7f $73
    dw   `00313311                                     ;; 0a:72a6 $3f $2c
    dw   `00311311                                     ;; 0a:72a8 $3f $24
    dw   `00033333                                     ;; 0a:72aa $1f $1f
    dw   `00003111                                     ;; 0a:72ac $0f $08
    dw   `00000333                                     ;; 0a:72ae $07 $07

    dw   `23123333                                     ;; 0a:72b0 $6f $df
    dw   `22323113                                     ;; 0a:72b2 $2f $f9
    dw   `22222223                                     ;; 0a:72b4 $01 $ff
    dw   `32223113                                     ;; 0a:72b6 $8f $f9
    dw   `32231230                                     ;; 0a:72b8 $9a $f6
    dw   `33303130                                     ;; 0a:72ba $ee $ea
    dw   `11300300                                     ;; 0a:72bc $e4 $24
    dw   `33000000                                     ;; 0a:72be $c0 $c0

    dw   `00000000                                     ;; 0a:72c0 $00 $00
    dw   `00003303                                     ;; 0a:72c2 $0d $0d
    dw   `00003131                                     ;; 0a:72c4 $0f $0a
    dw   `00032222                                     ;; 0a:72c6 $10 $1f
    dw   `00323332                                     ;; 0a:72c8 $2e $3f
    dw   `03231113                                     ;; 0a:72ca $5f $71
    dw   `03233333                                     ;; 0a:72cc $5f $7f
    dw   `03333313                                     ;; 0a:72ce $7f $7d

    dw   `00000000                                     ;; 0a:72d0 $00 $00
    dw   `03000000                                     ;; 0a:72d2 $40 $40
    dw   `31330000                                     ;; 0a:72d4 $f0 $b0
    dw   `32313000                                     ;; 0a:72d6 $b8 $e8
    dw   `22233000                                     ;; 0a:72d8 $18 $f8
    dw   `22221300                                     ;; 0a:72da $0c $f4
    dw   `22323000                                     ;; 0a:72dc $28 $f8
    dw   `23123000                                     ;; 0a:72de $68 $d8

    dw   `31113332                                     ;; 0a:72e0 $fe $8f
    dw   `03331113                                     ;; 0a:72e2 $7f $71
    dw   `03333313                                     ;; 0a:72e4 $7f $7d
    dw   `31111113                                     ;; 0a:72e6 $ff $81
    dw   `03333332                                     ;; 0a:72e8 $7e $7f
    dw   `00311322                                     ;; 0a:72ea $3c $27
    dw   `00031133                                     ;; 0a:72ec $1f $13
    dw   `00003300                                     ;; 0a:72ee $0c $0c

    dw   `23323000                                     ;; 0a:72f0 $68 $f8
    dw   `23123333                                     ;; 0a:72f2 $6f $df
    dw   `23323113                                     ;; 0a:72f4 $6f $f9
    dw   `31132223                                     ;; 0a:72f6 $f1 $9f
    dw   `31133113                                     ;; 0a:72f8 $ff $99
    dw   `23313230                                     ;; 0a:72fa $7a $ee
    dw   `31133130                                     ;; 0a:72fc $fe $9a
    dw   `03300300                                     ;; 0a:72fe $64 $64


data_0a_7300:
    db   $08, $08, $0d, $0d, $cf, $cf, $7f, $7f        ;; 0a:7300 ????????
    db   $3f, $3f, $f3, $ff, $6f, $7c, $3e, $25        ;; 0a:7308 ????????
    db   $90, $90, $b2, $b2, $fc, $fc, $fd, $fd        ;; 0a:7310 ????????
    db   $ff, $ff, $9e, $fe, $6e, $fe, $7f, $cf        ;; 0a:7318 ????????
    db   $7c, $7f, $32, $3f, $40, $7f, $49, $7f        ;; 0a:7320 ????????
    db   $38, $3f, $0f, $0f, $09, $0f, $06, $06        ;; 0a:7328 ????????
    db   $36, $fe, $0a, $fe, $0a, $fe, $1c, $fc        ;; 0a:7330 ????????
    db   $24, $fc, $c4, $fc, $48, $78, $30, $30        ;; 0a:7338 ????????
    db   $08, $08, $0d, $0d, $cf, $cf, $7f, $7f        ;; 0a:7340 ????????
    db   $3b, $3f, $fd, $ff, $7f, $7f, $27, $3f        ;; 0a:7348 ????????
    db   $90, $90, $b2, $b2, $fc, $fc, $fd, $fd        ;; 0a:7350 ????????
    db   $ff, $ff, $ee, $fe, $dc, $fc, $b7, $ff        ;; 0a:7358 ????????
    db   $7f, $7f, $3f, $3f, $5b, $7f, $7f, $7f        ;; 0a:7360 ????????
    db   $1f, $1f, $3b, $3f, $2a, $2f, $07, $07        ;; 0a:7368 ????????
    db   $fe, $fe, $fe, $fe, $df, $ff, $ec, $fc        ;; 0a:7370 ????????
    db   $fe, $fe, $fa, $fa, $d8, $d8, $00, $00        ;; 0a:7378 ????????
    db   $19, $19, $0d, $0d, $3f, $3f, $1f, $1f        ;; 0a:7380 ????????
    db   $7f, $7f, $c8, $bf, $8f, $ff, $4f, $78        ;; 0a:7388 ????????
    db   $10, $10, $b2, $b2, $f6, $f6, $fc, $fc        ;; 0a:7390 ????????
    db   $7c, $fc, $9f, $ff, $9e, $fe, $bc, $fc        ;; 0a:7398 ????????
    db   $27, $3f, $10, $1f, $10, $1f, $10, $1f        ;; 0a:73a0 ????????
    db   $08, $0f, $07, $07, $08, $0f, $0f, $0f        ;; 0a:73a8 ????????
    db   $2e, $fe, $8f, $ff, $9c, $fc, $9e, $fe        ;; 0a:73b0 ????????
    db   $6a, $fa, $10, $f0, $10, $f0, $f0, $f0        ;; 0a:73b8 ????????
    db   $00, $00, $19, $19, $0d, $0d, $3f, $3f        ;; 0a:73c0 ????????
    db   $1f, $1f, $7f, $7f, $cf, $b8, $8f, $fa        ;; 0a:73c8 ????????
    db   $00, $00, $10, $10, $b2, $b2, $f6, $f6        ;; 0a:73d0 ????????
    db   $fc, $fc, $7c, $fc, $9f, $ff, $9e, $fe        ;; 0a:73d8 ????????
    db   $4f, $78, $27, $3f, $50, $7f, $50, $7f        ;; 0a:73e0 ????????
    db   $38, $3f, $24, $3f, $13, $1f, $0e, $0e        ;; 0a:73e8 ????????
    db   $bc, $fc, $2e, $fe, $07, $ff, $44, $fc        ;; 0a:73f0 ????????
    db   $3e, $fe, $0a, $fa, $c8, $f8, $70, $70        ;; 0a:73f8 ????????
    db   $08, $08, $0d, $0d, $cf, $cf, $7f, $7f        ;; 0a:7400 ????????
    db   $3b, $3f, $fd, $ff, $7f, $7f, $37, $3f        ;; 0a:7408 ????????
    db   $90, $90, $b2, $b2, $fc, $fc, $fd, $fd        ;; 0a:7410 ????????
    db   $ff, $ff, $ee, $fe, $dc, $fc, $b7, $ff        ;; 0a:7418 ????????
    db   $ff, $ff, $3d, $3f, $7b, $7f, $f7, $ff        ;; 0a:7420 ????????
    db   $bf, $bf, $3f, $3f, $4d, $4d, $09, $09        ;; 0a:7428 ????????
    db   $fc, $fc, $ee, $fe, $ff, $ff, $bc, $fc        ;; 0a:7430 ????????
    db   $de, $fe, $f3, $f3, $b0, $b0, $10, $10        ;; 0a:7438 ????????

data_0a_7440:
    db   $01, $01, $06, $07, $18, $1f, $38, $27        ;; 0a:7440 ????????
    db   $7d, $43, $7f, $5b, $7b, $5f, $46, $7f        ;; 0a:7448 ????????
    db   $f0, $f0, $a8, $58, $34, $fc, $f4, $fc        ;; 0a:7450 ????????
    db   $f4, $fc, $e8, $f8, $d0, $f0, $50, $f0        ;; 0a:7458 ????????
    db   $23, $3f, $39, $3f, $62, $5f, $8f, $fd        ;; 0a:7460 ????????
    db   $7f, $72, $3f, $21, $3f, $33, $7f, $7f        ;; 0a:7468 ????????
    db   $ee, $fe, $ed, $fb, $0a, $fe, $fc, $fc        ;; 0a:7470 ????????
    db   $c8, $38, $b8, $78, $90, $f0, $fe, $fe        ;; 0a:7478 ????????
    db   $1f, $1f, $20, $3f, $40, $7f, $58, $67        ;; 0a:7480 ????????
    db   $78, $77, $78, $77, $50, $6f, $20, $3f        ;; 0a:7488 ????????
    db   $c0, $c0, $60, $e0, $90, $70, $58, $a8        ;; 0a:7490 ????????
    db   $4c, $b4, $4c, $b4, $48, $b8, $08, $f8        ;; 0a:7498 ????????
    db   $38, $3f, $60, $5f, $c0, $bf, $60, $7f        ;; 0a:74a0 ????????
    db   $30, $3f, $3c, $3f, $43, $7f, $7f, $7f        ;; 0a:74a8 ????????
    db   $38, $f8, $7e, $e6, $ed, $df, $49, $bf        ;; 0a:74b0 ????????
    db   $0f, $ff, $18, $f8, $f0, $f0, $fe, $fe        ;; 0a:74b8 ????????
    db   $7e, $7e, $b5, $cb, $40, $7f, $21, $3e        ;; 0a:74c0 ????????
    db   $13, $1f, $0b, $0f, $05, $06, $06, $07        ;; 0a:74c8 ????????
    db   $00, $00, $80, $80, $40, $c0, $a0, $60        ;; 0a:74d0 ????????
    db   $d0, $30, $d0, $30, $98, $78, $14, $fc        ;; 0a:74d8 ????????
    db   $0f, $0f, $1c, $1f, $30, $3f, $41, $7f        ;; 0a:74e0 ????????
    db   $3e, $3f, $1e, $11, $0e, $0f, $04, $07        ;; 0a:74e8 ????????
    db   $2a, $ee, $79, $9f, $09, $ff, $91, $ff        ;; 0a:74f0 ????????
    db   $b2, $de, $ec, $fc, $30, $f0, $18, $f8        ;; 0a:74f8 ????????
    db   $00, $00, $7e, $7e, $b5, $cb, $40, $7f        ;; 0a:7500 ????????
    db   $21, $3e, $13, $1f, $0b, $0f, $05, $06        ;; 0a:7508 ????????
    db   $00, $00, $00, $00, $80, $80, $40, $c0        ;; 0a:7510 ????????
    db   $a0, $60, $d0, $30, $d3, $33, $95, $77        ;; 0a:7518 ????????
    db   $06, $07, $0f, $0f, $1c, $1f, $30, $3f        ;; 0a:7520 ????????
    db   $41, $7f, $3e, $3f, $4e, $79, $27, $3f        ;; 0a:7528 ????????
    db   $1a, $fe, $2a, $ee, $11, $ff, $0d, $fb        ;; 0a:7530 ????????
    db   $99, $ef, $7a, $fe, $04, $fc, $cf, $ff        ;; 0a:7538 ????????
    db   $07, $07, $08, $0f, $0f, $0f, $1f, $18        ;; 0a:7540 ????????
    db   $3f, $20, $7f, $40, $7f, $40, $9f, $f0        ;; 0a:7548 ????????
    db   $80, $80, $60, $e0, $1c, $fc, $9e, $f2        ;; 0a:7550 ????????
    db   $de, $6e, $fe, $32, $fc, $1c, $fa, $0e        ;; 0a:7558 ????????
    db   $8f, $f8, $8f, $f8, $ff, $f0, $ff, $80        ;; 0a:7560 ????????
    db   $7f, $40, $5f, $60, $83, $ff, $ff, $ff        ;; 0a:7568 ????????
    db   $fa, $06, $fd, $0f, $f1, $1f, $f3, $1f        ;; 0a:7570 ????????
    db   $ee, $1e, $c2, $3e, $82, $fe, $d5, $ff        ;; 0a:7578 ????????

data_0a_7580:
    db   $01, $01, $03, $02, $0f, $0e, $3f, $32        ;; 0a:7580 ????????
    db   $7f, $44, $7f, $40, $2f, $30, $38, $3f        ;; 0a:7588 ????????
    db   $80, $80, $40, $c0, $70, $f0, $4c, $fc        ;; 0a:7590 ????????
    db   $ba, $66, $fa, $06, $f4, $0c, $1c, $fc        ;; 0a:7598 ????????
    db   $4f, $7d, $df, $ff, $bb, $e7, $bc, $e7        ;; 0a:75a0 ????????
    db   $9d, $ff, $54, $7f, $2f, $3f, $3f, $38        ;; 0a:75a8 ????????
    db   $f2, $be, $e1, $ff, $d9, $ff, $3d, $e7        ;; 0a:75b0 ????????
    db   $fd, $e7, $19, $ff, $11, $ff, $fa, $fe        ;; 0a:75b8 ????????
    db   $01, $01, $03, $02, $0f, $0e, $3f, $32        ;; 0a:75c0 ????????
    db   $7f, $44, $7f, $40, $2f, $30, $38, $3f        ;; 0a:75c8 ????????
    db   $80, $80, $40, $c0, $70, $f0, $4c, $fc        ;; 0a:75d0 ????????
    db   $ba, $66, $fa, $06, $f4, $0c, $1c, $fc        ;; 0a:75d8 ????????
    db   $17, $1f, $20, $3f, $44, $7f, $43, $7f        ;; 0a:75e0 ????????
    db   $40, $7f, $40, $7f, $38, $3f, $07, $07        ;; 0a:75e8 ????????
    db   $e8, $f8, $04, $fc, $02, $fe, $a2, $fe        ;; 0a:75f0 ????????
    db   $02, $fe, $74, $fc, $fc, $8c, $f0, $f0        ;; 0a:75f8 ????????
    db   $00, $00, $01, $01, $7f, $7e, $ff, $80        ;; 0a:7600 ????????
    db   $7f, $60, $1f, $1c, $0f, $0b, $0f, $0b        ;; 0a:7608 ????????
    db   $3c, $3c, $fc, $c4, $e8, $18, $d0, $30        ;; 0a:7610 ????????
    db   $90, $70, $c8, $38, $f6, $0e, $fd, $f3        ;; 0a:7618 ????????
    db   $1e, $1f, $13, $1f, $17, $19, $0f, $09        ;; 0a:7620 ????????
    db   $0e, $0f, $0a, $0f, $0a, $0f, $0f, $0f        ;; 0a:7628 ????????
    db   $3e, $fe, $08, $f8, $08, $f8, $04, $fc        ;; 0a:7630 ????????
    db   $04, $fc, $02, $fe, $01, $ff, $ff, $ff        ;; 0a:7638 ????????
    db   $00, $00, $00, $00, $01, $01, $7f, $7e        ;; 0a:7640 ????????
    db   $ff, $80, $7f, $60, $1f, $1c, $0f, $0b        ;; 0a:7648 ????????
    db   $00, $00, $3c, $3c, $fc, $c4, $e8, $18        ;; 0a:7650 ????????
    db   $d0, $30, $90, $70, $c8, $38, $f6, $0e        ;; 0a:7658 ????????
    db   $0f, $0b, $1e, $1f, $11, $1f, $16, $1f        ;; 0a:7660 ????????
    db   $0f, $09, $0f, $09, $17, $1f, $1f, $1f        ;; 0a:7668 ????????
    db   $fd, $f3, $3e, $fe, $88, $f8, $08, $f8        ;; 0a:7670 ????????
    db   $04, $fc, $14, $fc, $0a, $fe, $ff, $ff        ;; 0a:7678 ????????
    db   $00, $00, $01, $01, $03, $02, $0f, $0e        ;; 0a:7680 ????????
    db   $3f, $32, $7f, $44, $7f, $40, $2f, $30        ;; 0a:7688 ????????
    db   $00, $00, $80, $80, $40, $c0, $70, $f0        ;; 0a:7690 ????????
    db   $4c, $fc, $ba, $66, $fa, $06, $f4, $0c        ;; 0a:7698 ????????
    db   $58, $7f, $8f, $fd, $87, $ff, $83, $ff        ;; 0a:76a0 ????????
    db   $47, $7c, $47, $7c, $2f, $3f, $3f, $3f        ;; 0a:76a8 ????????
    db   $1a, $fe, $f1, $bf, $e1, $ff, $c1, $ff        ;; 0a:76b0 ????????
    db   $e2, $be, $e2, $be, $f6, $fe, $fc, $1c        ;; 0a:76b8 ????????
    db   $00, $00, $01, $01, $7f, $7e, $ff, $80        ;; 0a:76c0 ????????
    db   $7f, $60, $1f, $1c, $0f, $0b, $0f, $0b        ;; 0a:76c8 ????????
    db   $3c, $3c, $fc, $c4, $e8, $18, $d0, $30        ;; 0a:76d0 ????????
    db   $90, $70, $c8, $38, $f6, $0e, $fd, $f3        ;; 0a:76d8 ????????
    db   $7e, $7f, $70, $5f, $70, $5f, $30, $3f        ;; 0a:76e0 ????????
    db   $08, $0f, $18, $1f, $34, $2f, $3f, $3f        ;; 0a:76e8 ????????
    db   $3e, $fe, $10, $f0, $10, $f0, $08, $f8        ;; 0a:76f0 ????????
    db   $48, $f8, $44, $fc, $c2, $fe, $ff, $ff        ;; 0a:76f8 ????????

data_0a_7700:
    db   $00, $00, $03, $03, $0f, $0c, $14, $1f        ;; 0a:7700 ????????
    db   $2f, $3c, $35, $3e, $23, $3f, $60, $7f        ;; 0a:7708 ????????
    db   $00, $00, $c0, $c0, $b0, $f0, $e8, $f8        ;; 0a:7710 ????????
    db   $b4, $dc, $9c, $fc, $f6, $de, $3d, $f7        ;; 0a:7718 ????????
    db   $70, $5f, $5c, $6f, $7b, $4b, $30, $30        ;; 0a:7720 ????????
    db   $00, $00, $00, $00, $00, $00, $3f, $3f        ;; 0a:7728 ????????
    db   $1f, $fd, $86, $fe, $f8, $f8, $00, $00        ;; 0a:7730 ????????
    db   $00, $00, $00, $00, $00, $00, $fc, $fc        ;; 0a:7738 ????????
    db   $03, $03, $0c, $0f, $13, $1f, $2f, $3f        ;; 0a:7740 ????????
    db   $28, $3f, $30, $3f, $2d, $3f, $3f, $32        ;; 0a:7748 ????????
    db   $c0, $c0, $30, $f0, $c8, $f8, $f4, $fc        ;; 0a:7750 ????????
    db   $1c, $fc, $04, $fc, $84, $fc, $f2, $7e        ;; 0a:7758 ????????
    db   $32, $3f, $3f, $32, $3b, $36, $36, $3f        ;; 0a:7760 ????????
    db   $2f, $3f, $10, $1f, $0f, $0f, $1f, $1f        ;; 0a:7768 ????????
    db   $7e, $ce, $ca, $7e, $6a, $de, $d4, $fc        ;; 0a:7770 ????????
    db   $f8, $f8, $80, $80, $80, $80, $f8, $f8        ;; 0a:7778 ????????
    db   $03, $03, $07, $05, $05, $07, $06, $05        ;; 0a:7780 ????????
    db   $7d, $7e, $d7, $af, $7c, $7f, $ea, $97        ;; 0a:7788 ????????
    db   $00, $00, $00, $00, $00, $00, $80, $80        ;; 0a:7790 ????????
    db   $80, $80, $4f, $cf, $79, $ff, $39, $ef        ;; 0a:7798 ????????
    db   $7f, $7f, $6a, $57, $3c, $3f, $3a, $27        ;; 0a:77a0 ????????
    db   $1f, $1f, $00, $00, $00, $00, $7f, $7f        ;; 0a:77a8 ????????
    db   $b9, $ef, $39, $ef, $39, $ef, $79, $ff        ;; 0a:77b0 ????????
    db   $8f, $8f, $00, $00, $00, $00, $fe, $fe        ;; 0a:77b8 ????????
    db   $00, $00, $1e, $1e, $21, $3f, $60, $7f        ;; 0a:77c0 ????????
    db   $a0, $ff, $e0, $ff, $a0, $ff, $e0, $ff        ;; 0a:77c8 ????????
    db   $00, $00, $00, $00, $8f, $8f, $79, $ff        ;; 0a:77d0 ????????
    db   $39, $ef, $39, $ef, $39, $ef, $39, $ef        ;; 0a:77d8 ????????
    db   $b7, $ff, $5d, $7e, $3d, $3b, $0a, $0e        ;; 0a:77e0 ????????
    db   $0e, $0a, $06, $06, $00, $00, $3f, $3f        ;; 0a:77e8 ????????
    db   $79, $ff, $8f, $8f, $00, $00, $00, $00        ;; 0a:77f0 ????????
    db   $00, $00, $00, $00, $00, $00, $fc, $fc        ;; 0a:77f8 ????????
    db   $00, $00, $03, $03, $1c, $1f, $20, $3f        ;; 0a:7800 ????????
    db   $23, $3c, $4f, $73, $4c, $7f, $30, $3f        ;; 0a:7808 ????????
    db   $c0, $c0, $e0, $20, $d0, $f0, $10, $f0        ;; 0a:7810 ????????
    db   $c8, $38, $e8, $d8, $3c, $f4, $0c, $fc        ;; 0a:7818 ????????
    db   $17, $1f, $2f, $3f, $2b, $3f, $2c, $3f        ;; 0a:7820 ????????
    db   $13, $1f, $0c, $0f, $03, $03, $1f, $1f        ;; 0a:7828 ????????
    db   $e8, $f8, $f4, $fc, $d4, $fc, $34, $fc        ;; 0a:7830 ????????
    db   $c8, $f8, $30, $f0, $c0, $c0, $f8, $f8        ;; 0a:7838 ????????
    db   $00, $00, $00, $00, $03, $03, $dc, $df        ;; 0a:7840 ????????
    db   $e0, $bf, $f3, $9c, $77, $5b, $2c, $3f        ;; 0a:7848 ????????
    db   $00, $00, $c0, $c0, $e0, $20, $d0, $f0        ;; 0a:7850 ????????
    db   $10, $f0, $ce, $3e, $ff, $d1, $3f, $f3        ;; 0a:7858 ????????
    db   $10, $1f, $17, $1f, $2f, $3f, $2b, $3f        ;; 0a:7860 ????????
    db   $2c, $3f, $13, $1f, $0c, $0f, $3f, $3f        ;; 0a:7868 ????????
    db   $0c, $fc, $e8, $f8, $f4, $fc, $d4, $fc        ;; 0a:7870 ????????
    db   $34, $fc, $c8, $f8, $30, $f0, $fc, $fc        ;; 0a:7878 ????????

data_0a_7880:
    db   $01, $01, $02, $03, $1c, $1f, $2e, $3b        ;; 0a:7880 ????????
    db   $47, $7d, $43, $7e, $21, $3f, $38, $3f        ;; 0a:7888 ????????
    db   $c0, $c0, $20, $e0, $78, $f8, $74, $dc        ;; 0a:7890 ????????
    db   $e2, $be, $c2, $7e, $84, $fc, $1c, $fc        ;; 0a:7898 ????????
    db   $4f, $7d, $b7, $fd, $fb, $cf, $fc, $cf        ;; 0a:78a0 ????????
    db   $bf, $fb, $bf, $fe, $51, $5f, $1f, $1f        ;; 0a:78a8 ????????
    db   $f2, $be, $e5, $bf, $cd, $ff, $3f, $f3        ;; 0a:78b0 ????????
    db   $ff, $d3, $fd, $bf, $e5, $e7, $f2, $f2        ;; 0a:78b8 ????????
    db   $00, $00, $01, $01, $0e, $0f, $32, $3f        ;; 0a:78c0 ????????
    db   $44, $7f, $40, $7f, $20, $3f, $38, $3f        ;; 0a:78c8 ????????
    db   $c0, $c0, $20, $e0, $70, $f0, $4c, $fc        ;; 0a:78d0 ????????
    db   $22, $fe, $02, $fe, $04, $fc, $1c, $fc        ;; 0a:78d8 ????????
    db   $4f, $7f, $80, $ff, $88, $ff, $87, $ff        ;; 0a:78e0 ????????
    db   $e1, $9e, $7f, $61, $1f, $1f, $1f, $1f        ;; 0a:78e8 ????????
    db   $f2, $fe, $01, $ff, $01, $ff, $63, $fd        ;; 0a:78f0 ????????
    db   $ff, $03, $fc, $fc, $f8, $08, $f8, $f8        ;; 0a:78f8 ????????
    db   $00, $00, $03, $03, $7d, $7e, $87, $fd        ;; 0a:7900 ????????
    db   $62, $7f, $1c, $1f, $0f, $0b, $0f, $0b        ;; 0a:7908 ????????
    db   $bc, $bc, $c2, $7e, $8c, $fc, $10, $f0        ;; 0a:7910 ????????
    db   $10, $f0, $08, $f8, $06, $fe, $f1, $ff        ;; 0a:7918 ????????
    db   $0e, $0f, $11, $1f, $0f, $0f, $1f, $15        ;; 0a:7920 ????????
    db   $1f, $15, $0f, $0a, $04, $07, $1f, $1f        ;; 0a:7928 ????????
    db   $0e, $fe, $e4, $fc, $94, $fc, $d4, $3c        ;; 0a:7930 ????????
    db   $f4, $3c, $f2, $fe, $3a, $fe, $fc, $fc        ;; 0a:7938 ????????
    db   $00, $00, $00, $00, $03, $03, $7d, $7e        ;; 0a:7940 ????????
    db   $87, $fd, $62, $7f, $1c, $1f, $0f, $0b        ;; 0a:7948 ????????
    db   $00, $00, $bc, $bc, $c2, $7e, $8c, $fc        ;; 0a:7950 ????????
    db   $10, $f0, $10, $f0, $08, $f8, $06, $fe        ;; 0a:7958 ????????
    db   $0f, $0b, $0e, $0f, $11, $1f, $0f, $0f        ;; 0a:7960 ????????
    db   $3f, $35, $4f, $7d, $27, $3e, $1f, $1f        ;; 0a:7968 ????????
    db   $f1, $ff, $0e, $fe, $e2, $fe, $d9, $ff        ;; 0a:7970 ????????
    db   $dd, $67, $fd, $67, $9d, $ff, $fa, $fa        ;; 0a:7978 ????????
    db   $01, $01, $02, $03, $07, $05, $3b, $3e        ;; 0a:7980 ????????
    db   $41, $7f, $30, $3f, $7f, $7d, $f7, $9d        ;; 0a:7988 ????????
    db   $80, $80, $40, $c0, $e0, $a0, $dc, $7c        ;; 0a:7990 ????????
    db   $82, $fe, $0c, $fc, $fe, $be, $ef, $b9        ;; 0a:7998 ????????
    db   $eb, $9f, $5c, $7f, $bf, $f7, $bf, $fa        ;; 0a:79a0 ????????
    db   $7f, $ca, $f7, $ce, $67, $7f, $18, $18        ;; 0a:79a8 ????????
    db   $d7, $f9, $3a, $fe, $fd, $ef, $7d, $df        ;; 0a:79b0 ????????
    db   $7e, $d3, $6f, $f3, $e4, $fc, $18, $18        ;; 0a:79b8 ????????
    db   $00, $00, $03, $03, $7d, $7e, $87, $fd        ;; 0a:79c0 ????????
    db   $62, $7f, $7c, $5f, $2f, $3b, $2f, $3b        ;; 0a:79c8 ????????
    db   $bc, $bc, $c2, $7e, $8c, $fc, $10, $f0        ;; 0a:79d0 ????????
    db   $10, $f0, $08, $f8, $06, $fe, $f1, $ff        ;; 0a:79d8 ????????
    db   $1e, $1f, $11, $1f, $7f, $7f, $ff, $94        ;; 0a:79e0 ????????
    db   $de, $b5, $5c, $7f, $33, $33, $00, $00        ;; 0a:79e8 ????????
    db   $0e, $fe, $f2, $fe, $ed, $bf, $af, $f3        ;; 0a:79f0 ????????
    db   $df, $f3, $dd, $ff, $e2, $e2, $00, $00        ;; 0a:79f8 ????????

data_0a_7a00:
    db   $07, $07, $0b, $0f, $16, $1f, $16, $1f        ;; 0a:7a00 ????????
    db   $10, $1f, $0e, $09, $0b, $0c, $7c, $7f        ;; 0a:7a08 ????????
    db   $e0, $e0, $f0, $f0, $f8, $f8, $f8, $f8        ;; 0a:7a10 ????????
    db   $f8, $f8, $f0, $90, $f0, $30, $fe, $fe        ;; 0a:7a18 ????????
    db   $87, $ff, $69, $7f, $f0, $bf, $fa, $9f        ;; 0a:7a20 ????????
    db   $6d, $6f, $08, $0f, $04, $07, $1f, $1f        ;; 0a:7a28 ????????
    db   $ff, $e3, $ff, $d5, $7f, $d5, $7f, $dd        ;; 0a:7a30 ????????
    db   $ff, $dd, $be, $ea, $fc, $f4, $f8, $f8        ;; 0a:7a38 ????????
    db   $07, $07, $0b, $0f, $16, $1f, $16, $1f        ;; 0a:7a40 ????????
    db   $10, $1f, $0e, $09, $0b, $0c, $7c, $7f        ;; 0a:7a48 ????????
    db   $e0, $e0, $f0, $f0, $f8, $f8, $f8, $f8        ;; 0a:7a50 ????????
    db   $f8, $f8, $f0, $90, $f0, $30, $fe, $fe        ;; 0a:7a58 ????????
    db   $e7, $ff, $f9, $9f, $f0, $9f, $7a, $7f        ;; 0a:7a60 ????????
    db   $0f, $0f, $09, $0f, $07, $07, $1f, $1f        ;; 0a:7a68 ????????
    db   $fd, $ff, $bf, $e3, $7f, $d5, $7f, $d5        ;; 0a:7a70 ????????
    db   $ff, $dd, $7f, $dd, $3e, $ea, $fc, $f4        ;; 0a:7a78 ????????
    db   $07, $07, $0b, $0f, $17, $1f, $17, $1f        ;; 0a:7a80 ????????
    db   $17, $1f, $0b, $0f, $0f, $0f, $7f, $7f        ;; 0a:7a88 ????????
    db   $e0, $e0, $f0, $f0, $f8, $f8, $f8, $f8        ;; 0a:7a90 ????????
    db   $f8, $f8, $f0, $f0, $f0, $f0, $fe, $fe        ;; 0a:7a98 ????????
    db   $87, $ff, $e9, $ff, $f0, $df, $fa, $df        ;; 0a:7aa0 ????????
    db   $ef, $bf, $c9, $bf, $67, $5f, $3f, $2f        ;; 0a:7aa8 ????????
    db   $e1, $ff, $96, $fe, $0c, $fc, $5c, $f4        ;; 0a:7ab0 ????????
    db   $b8, $f8, $10, $f0, $20, $e0, $f8, $f8        ;; 0a:7ab8 ????????
    db   $07, $07, $0b, $0f, $17, $1f, $17, $1f        ;; 0a:7ac0 ????????
    db   $17, $1f, $0b, $0f, $0f, $0f, $7f, $7f        ;; 0a:7ac8 ????????
    db   $e0, $e0, $f0, $f0, $f8, $f8, $f8, $f8        ;; 0a:7ad0 ????????
    db   $f8, $f8, $f0, $f0, $f0, $f0, $fe, $fe        ;; 0a:7ad8 ????????
    db   $87, $ff, $e9, $ff, $f0, $df, $ba, $ff        ;; 0a:7ae0 ????????
    db   $dd, $bf, $68, $5f, $3c, $2f, $1f, $1f        ;; 0a:7ae8 ????????
    db   $e1, $ff, $96, $fe, $0e, $fa, $5e, $f2        ;; 0a:7af0 ????????
    db   $fc, $f4, $98, $f8, $e0, $e0, $f8, $f8        ;; 0a:7af8 ????????
    db   $07, $07, $0b, $0f, $17, $1f, $17, $1f        ;; 0a:7b00 ????????
    db   $1f, $19, $07, $0b, $0f, $0f, $7f, $7f        ;; 0a:7b08 ????????
    db   $e0, $e0, $f0, $f0, $f8, $f8, $38, $f8        ;; 0a:7b10 ????????
    db   $78, $f8, $f0, $f0, $e0, $e0, $f0, $f0        ;; 0a:7b18 ????????
    db   $75, $5f, $d8, $bf, $f9, $af, $fb, $ae        ;; 0a:7b20 ????????
    db   $df, $be, $73, $53, $34, $37, $07, $07        ;; 0a:7b28 ????????
    db   $08, $f8, $f0, $f0, $90, $f0, $90, $70        ;; 0a:7b30 ????????
    db   $a0, $60, $e0, $e0, $20, $e0, $f0, $f0        ;; 0a:7b38 ????????
    db   $00, $00, $07, $07, $0b, $0f, $17, $1f        ;; 0a:7b40 ????????
    db   $17, $1f, $1f, $19, $07, $0b, $0f, $0f        ;; 0a:7b48 ????????
    db   $00, $00, $e0, $e0, $f0, $f0, $f8, $f8        ;; 0a:7b50 ????????
    db   $38, $f8, $78, $f8, $f0, $f0, $e0, $e0        ;; 0a:7b58 ????????
    db   $7f, $7f, $75, $5f, $d8, $bf, $f8, $af        ;; 0a:7b60 ????????
    db   $fa, $bf, $e6, $ff, $43, $7f, $27, $3f        ;; 0a:7b68 ????????
    db   $f0, $f0, $08, $f8, $f0, $f0, $48, $f8        ;; 0a:7b70 ????????
    db   $dc, $e4, $fc, $e4, $98, $f8, $e8, $f8        ;; 0a:7b78 ????????

data_0a_7b80:
    dw   `00000033                                     ;; 0a:7b80 $03 $03
    dw   `00000312                                     ;; 0a:7b82 $06 $05
    dw   `00003122                                     ;; 0a:7b84 $0c $0b
    dw   `00003122                                     ;; 0a:7b86 $0c $0b
    dw   `00032332                                     ;; 0a:7b88 $16 $1f
    dw   `03032313                                     ;; 0a:7b8a $57 $5d
    dw   `32333213                                     ;; 0a:7b8c $bb $fd
    dw   `32222322                                     ;; 0a:7b8e $84 $ff

    dw   `33033033                                     ;; 0a:7b90 $db $db
    dw   `32311313                                     ;; 0a:7b92 $bf $e5
    dw   `32231130                                     ;; 0a:7b94 $9e $f2
    dw   `32233300                                     ;; 0a:7b96 $9c $fc
    dw   `33323000                                     ;; 0a:7b98 $e8 $f8
    dw   `31323030                                     ;; 0a:7b9a $ea $ba
    dw   `31233323                                     ;; 0a:7b9c $dd $bf
    dw   `22311133                                     ;; 0a:7b9e $3f $e3

    dw   `33223132                                     ;; 0a:7ba0 $ce $fb
    dw   `33333213                                     ;; 0a:7ba2 $fb $fd
    dw   `31133321                                     ;; 0a:7ba4 $fd $9e
    dw   `31133223                                     ;; 0a:7ba6 $f9 $9f
    dw   `33333333                                     ;; 0a:7ba8 $ff $ff
    dw   `32333122                                     ;; 0a:7baa $bc $fb
    dw   `32300322                                     ;; 0a:7bac $a4 $e7
    dw   `03003333                                     ;; 0a:7bae $4f $4f

    dw   `23132313                                     ;; 0a:7bb0 $77 $dd
    dw   `33133313                                     ;; 0a:7bb2 $ff $dd
    dw   `13133313                                     ;; 0a:7bb4 $ff $5d
    dw   `33132313                                     ;; 0a:7bb6 $f7 $dd
    dw   `33132313                                     ;; 0a:7bb8 $f7 $dd
    dw   `33311133                                     ;; 0a:7bba $ff $e3
    dw   `33333330                                     ;; 0a:7bbc $fe $fe
    dw   `33330000                                     ;; 0a:7bbe $f0 $f0

    dw   `33033033                                     ;; 0a:7bc0 $db $db
    dw   `31311312                                     ;; 0a:7bc2 $fe $a5
    dw   `03113122                                     ;; 0a:7bc4 $7c $4b
    dw   `00333122                                     ;; 0a:7bc6 $3c $3b
    dw   `00032332                                     ;; 0a:7bc8 $16 $1f
    dw   `03032313                                     ;; 0a:7bca $57 $5d
    dw   `32333213                                     ;; 0a:7bcc $bb $fd
    dw   `32222322                                     ;; 0a:7bce $84 $ff

    dw   `33000000                                     ;; 0a:7bd0 $c0 $c0
    dw   `32300000                                     ;; 0a:7bd2 $a0 $e0
    dw   `32230000                                     ;; 0a:7bd4 $90 $f0
    dw   `32230000                                     ;; 0a:7bd6 $90 $f0
    dw   `33323000                                     ;; 0a:7bd8 $e8 $f8
    dw   `31323030                                     ;; 0a:7bda $ea $ba
    dw   `31233323                                     ;; 0a:7bdc $dd $bf
    dw   `22333323                                     ;; 0a:7bde $3d $ff

    dw   `33323132                                     ;; 0a:7be0 $ee $fb
    dw   `31133213                                     ;; 0a:7be2 $fb $9d
    dw   `31133321                                     ;; 0a:7be4 $fd $9e
    dw   `33333223                                     ;; 0a:7be6 $f9 $ff
    dw   `32333333                                     ;; 0a:7be8 $bf $ff
    dw   `32303233                                     ;; 0a:7bea $ab $ef
    dw   `03000333                                     ;; 0a:7bec $47 $47
    dw   `00000033                                     ;; 0a:7bee $03 $03

    dw   `23311133                                     ;; 0a:7bf0 $7f $e3
    dw   `33132313                                     ;; 0a:7bf2 $f7 $dd
    dw   `13133313                                     ;; 0a:7bf4 $ff $5d
    dw   `33133313                                     ;; 0a:7bf6 $ff $dd
    dw   `33132313                                     ;; 0a:7bf8 $f7 $dd
    dw   `23132313                                     ;; 0a:7bfa $77 $dd
    dw   `22311133                                     ;; 0a:7bfc $3f $e3
    dw   `33333330                                     ;; 0a:7bfe $fe $fe

    dw   `00000033                                     ;; 0a:7c00 $03 $03
    dw   `00000323                                     ;; 0a:7c02 $05 $07
    dw   `00003231                                     ;; 0a:7c04 $0b $0e
    dw   `00003111                                     ;; 0a:7c06 $0f $08
    dw   `00003311                                     ;; 0a:7c08 $0f $0c
    dw   `03031113                                     ;; 0a:7c0a $5f $51
    dw   `32313331                                     ;; 0a:7c0c $bf $ee
    dw   `32233122                                     ;; 0a:7c0e $9c $fb

    dw   `33000000                                     ;; 0a:7c10 $c0 $c0
    dw   `32300000                                     ;; 0a:7c12 $a0 $e0
    dw   `13230000                                     ;; 0a:7c14 $d0 $70
    dw   `13230000                                     ;; 0a:7c16 $d0 $70
    dw   `32230000                                     ;; 0a:7c18 $90 $f0
    dw   `33230030                                     ;; 0a:7c1a $d2 $f2
    dw   `11333323                                     ;; 0a:7c1c $fd $3f
    dw   `22132223                                     ;; 0a:7c1e $31 $df

    dw   `33332322                                     ;; 0a:7c20 $f4 $ff
    dw   `33222233                                     ;; 0a:7c22 $c3 $ff
    dw   `32222222                                     ;; 0a:7c24 $80 $ff
    dw   `32222322                                     ;; 0a:7c26 $84 $ff
    dw   `32222233                                     ;; 0a:7c28 $83 $ff
    dw   `32222222                                     ;; 0a:7c2a $80 $ff
    dw   `33322222                                     ;; 0a:7c2c $e0 $ff
    dw   `03333333                                     ;; 0a:7c2e $7f $7f

    dw   `22323330                                     ;; 0a:7c30 $2e $fe
    dw   `33222230                                     ;; 0a:7c32 $c2 $fe
    dw   `22222230                                     ;; 0a:7c34 $02 $fe
    dw   `22222223                                     ;; 0a:7c36 $01 $ff
    dw   `32222223                                     ;; 0a:7c38 $81 $ff
    dw   `22233223                                     ;; 0a:7c3a $19 $ff
    dw   `23333323                                     ;; 0a:7c3c $7d $ff
    dw   `33333333                                     ;; 0a:7c3e $ff $ff

    dw   `00000033                                     ;; 0a:7c40 $03 $03
    dw   `00000323                                     ;; 0a:7c42 $05 $07
    dw   `00003231                                     ;; 0a:7c44 $0b $0e
    dw   `00003231                                     ;; 0a:7c46 $0b $0e
    dw   `00003223                                     ;; 0a:7c48 $09 $0f
    dw   `03003233                                     ;; 0a:7c4a $4b $4f
    dw   `32333311                                     ;; 0a:7c4c $bf $fc
    dw   `32223122                                     ;; 0a:7c4e $8c $fb

    dw   `33000000                                     ;; 0a:7c50 $c0 $c0
    dw   `32300000                                     ;; 0a:7c52 $a0 $e0
    dw   `13230000                                     ;; 0a:7c54 $d0 $70
    dw   `11130000                                     ;; 0a:7c56 $f0 $10
    dw   `11330000                                     ;; 0a:7c58 $f0 $30
    dw   `31113030                                     ;; 0a:7c5a $fa $8a
    dw   `13331323                                     ;; 0a:7c5c $fd $77
    dw   `22133223                                     ;; 0a:7c5e $39 $df

    dw   `33332322                                     ;; 0a:7c60 $f4 $ff
    dw   `33222233                                     ;; 0a:7c62 $c3 $ff
    dw   `33222222                                     ;; 0a:7c64 $c0 $ff
    dw   `32222222                                     ;; 0a:7c66 $80 $ff
    dw   `32222223                                     ;; 0a:7c68 $81 $ff
    dw   `32233222                                     ;; 0a:7c6a $98 $ff
    dw   `32333332                                     ;; 0a:7c6c $be $ff
    dw   `33333333                                     ;; 0a:7c6e $ff $ff

    dw   `22323330                                     ;; 0a:7c70 $2e $fe
    dw   `33222230                                     ;; 0a:7c72 $c2 $fe
    dw   `22222223                                     ;; 0a:7c74 $01 $ff
    dw   `22322223                                     ;; 0a:7c76 $21 $ff
    dw   `33222223                                     ;; 0a:7c78 $c1 $ff
    dw   `22222223                                     ;; 0a:7c7a $01 $ff
    dw   `22222330                                     ;; 0a:7c7c $06 $fe
    dw   `33333333                                     ;; 0a:7c7e $ff $ff

    dw   `00000333                                     ;; 0a:7c80 $07 $07
    dw   `00003122                                     ;; 0a:7c82 $0c $0b
    dw   `00031222                                     ;; 0a:7c84 $18 $17
    dw   `00031233                                     ;; 0a:7c86 $1b $17
    dw   `00032313                                     ;; 0a:7c88 $17 $1d
    dw   `00003313                                     ;; 0a:7c8a $0f $0d
    dw   `00003332                                     ;; 0a:7c8c $0e $0f
    dw   `33003222                                     ;; 0a:7c8e $c8 $cf

    dw   `33003300                                     ;; 0a:7c90 $cc $cc
    dw   `22331130                                     ;; 0a:7c92 $3e $f2
    dw   `32221130                                     ;; 0a:7c94 $8e $f2
    dw   `32233113                                     ;; 0a:7c96 $9f $f9
    dw   `22230313                                     ;; 0a:7c98 $17 $f5
    dw   `22330313                                     ;; 0a:7c9a $37 $f5
    dw   `23033130                                     ;; 0a:7c9c $5e $da
    dw   `33323300                                     ;; 0a:7c9e $ec $fc

    dw   `31333323                                     ;; 0a:7ca0 $fd $bf
    dw   `31313131                                     ;; 0a:7ca2 $ff $aa
    dw   `31323212                                     ;; 0a:7ca4 $ea $bd
    dw   `31333323                                     ;; 0a:7ca6 $fd $bf
    dw   `31300033                                     ;; 0a:7ca8 $e3 $a3
    dw   `31300032                                     ;; 0a:7caa $e2 $a3
    dw   `03300322                                     ;; 0a:7cac $64 $67
    dw   `00333333                                     ;; 0a:7cae $3f $3f

    dw   `32222300                                     ;; 0a:7cb0 $84 $fc
    dw   `23333000                                     ;; 0a:7cb2 $78 $f8
    dw   `33223000                                     ;; 0a:7cb4 $c8 $f8
    dw   `11323300                                     ;; 0a:7cb6 $ec $3c
    dw   `11332300                                     ;; 0a:7cb8 $f4 $3c
    dw   `33332300                                     ;; 0a:7cba $f4 $fc
    dw   `22333230                                     ;; 0a:7cbc $3a $fe
    dw   `33333330                                     ;; 0a:7cbe $fe $fe

    dw   `00000000                                     ;; 0a:7cc0 $00 $00
    dw   `00000333                                     ;; 0a:7cc2 $07 $07
    dw   `00003122                                     ;; 0a:7cc4 $0c $0b
    dw   `00031222                                     ;; 0a:7cc6 $18 $17
    dw   `00031233                                     ;; 0a:7cc8 $1b $17
    dw   `00032313                                     ;; 0a:7cca $17 $1d
    dw   `00003313                                     ;; 0a:7ccc $0f $0d
    dw   `00003332                                     ;; 0a:7cce $0e $0f

    dw   `00000000                                     ;; 0a:7cd0 $00 $00
    dw   `33003300                                     ;; 0a:7cd2 $cc $cc
    dw   `22331130                                     ;; 0a:7cd4 $3e $f2
    dw   `32221130                                     ;; 0a:7cd6 $8e $f2
    dw   `32233130                                     ;; 0a:7cd8 $9e $fa
    dw   `22233113                                     ;; 0a:7cda $1f $f9
    dw   `22330313                                     ;; 0a:7cdc $37 $f5
    dw   `23030033                                     ;; 0a:7cde $53 $d3

    dw   `33003222                                     ;; 0a:7ce0 $c8 $cf
    dw   `31333323                                     ;; 0a:7ce2 $fd $bf
    dw   `31313131                                     ;; 0a:7ce4 $ff $aa
    dw   `31323212                                     ;; 0a:7ce6 $ea $bd
    dw   `31333323                                     ;; 0a:7ce8 $fd $bf
    dw   `31333233                                     ;; 0a:7cea $fb $bf
    dw   `31322123                                     ;; 0a:7cec $e5 $bb
    dw   `03331233                                     ;; 0a:7cee $7b $77

    dw   `33323300                                     ;; 0a:7cf0 $ec $fc
    dw   `32222300                                     ;; 0a:7cf2 $84 $fc
    dw   `23333000                                     ;; 0a:7cf4 $78 $f8
    dw   `33113300                                     ;; 0a:7cf6 $fc $cc
    dw   `33113300                                     ;; 0a:7cf8 $fc $cc
    dw   `32333230                                     ;; 0a:7cfa $ba $fe
    dw   `22123230                                     ;; 0a:7cfc $2a $de
    dw   `33233323                                     ;; 0a:7cfe $dd $ff


data_0a_7d00:
    dw   `00033333                                     ;; 0a:7d00 $1f $1f
    dw   `00032222                                     ;; 0a:7d02 $10 $1f
    dw   `00003232                                     ;; 0a:7d04 $0a $0f
    dw   `00032323                                     ;; 0a:7d06 $15 $1f
    dw   `03003321                                     ;; 0a:7d08 $4d $4e
    dw   `31333331                                     ;; 0a:7d0a $ff $be
    dw   `31113131                                     ;; 0a:7d0c $ff $8a
    dw   `33332311                                     ;; 0a:7d0e $f7 $fc

    dw   `33330000                                     ;; 0a:7d10 $f0 $f0
    dw   `22223000                                     ;; 0a:7d12 $08 $f8
    dw   `32223000                                     ;; 0a:7d14 $88 $f8
    dw   `11323000                                     ;; 0a:7d16 $e8 $38
    dw   `11323030                                     ;; 0a:7d18 $ea $3a
    dw   `33323313                                     ;; 0a:7d1a $ef $fd
    dw   `13131113                                     ;; 0a:7d1c $ff $51
    dw   `11323233                                     ;; 0a:7d1e $eb $3f

    dw   `03233233                                     ;; 0a:7d20 $5b $7f
    dw   `03333322                                     ;; 0a:7d22 $7c $7f
    dw   `31133133                                     ;; 0a:7d24 $ff $9b
    dw   `31133231                                     ;; 0a:7d26 $fb $9e
    dw   `33332231                                     ;; 0a:7d28 $f3 $fe
    dw   `32332231                                     ;; 0a:7d2a $b3 $fe
    dw   `32303232                                     ;; 0a:7d2c $aa $ef
    dw   `03333333                                     ;; 0a:7d2e $7f $7f

    dw   `33233130                                     ;; 0a:7d30 $de $fa
    dw   `22331213                                     ;; 0a:7d32 $3b $f5
    dw   `33133113                                     ;; 0a:7d34 $ff $d9
    dw   `32233333                                     ;; 0a:7d36 $9f $ff
    dw   `32223323                                     ;; 0a:7d38 $8d $ff
    dw   `33322323                                     ;; 0a:7d3a $e5 $ff
    dw   `31133323                                     ;; 0a:7d3c $fd $9f
    dw   `33333330                                     ;; 0a:7d3e $fe $fe

    dw   `00000333                                     ;; 0a:7d40 $07 $07
    dw   `00003222                                     ;; 0a:7d42 $08 $0f
    dw   `00003222                                     ;; 0a:7d44 $08 $0f
    dw   `00003222                                     ;; 0a:7d46 $08 $0f
    dw   `03003233                                     ;; 0a:7d48 $4b $4f
    dw   `31333311                                     ;; 0a:7d4a $ff $bc
    dw   `31113133                                     ;; 0a:7d4c $ff $8b
    dw   `33333333                                     ;; 0a:7d4e $ff $ff

    dw   `33333000                                     ;; 0a:7d50 $f8 $f8
    dw   `22223000                                     ;; 0a:7d52 $08 $f8
    dw   `22230000                                     ;; 0a:7d54 $10 $f0
    dw   `22223000                                     ;; 0a:7d56 $08 $f8
    dw   `33233030                                     ;; 0a:7d58 $da $fa
    dw   `11333313                                     ;; 0a:7d5a $ff $3d
    dw   `33131113                                     ;; 0a:7d5c $ff $d1
    dw   `33333333                                     ;; 0a:7d5e $ff $ff

    dw   `33333333                                     ;; 0a:7d60 $ff $ff
    dw   `33333333                                     ;; 0a:7d62 $ff $ff
    dw   `33333333                                     ;; 0a:7d64 $ff $ff
    dw   `33333333                                     ;; 0a:7d66 $ff $ff
    dw   `33333333                                     ;; 0a:7d68 $ff $ff
    dw   `33333333                                     ;; 0a:7d6a $ff $ff
    dw   `30000333                                     ;; 0a:7d6c $87 $87
    dw   `00000003                                     ;; 0a:7d6e $01 $01

    dw   `33333333                                     ;; 0a:7d70 $ff $ff
    dw   `33333333                                     ;; 0a:7d72 $ff $ff
    dw   `33332333                                     ;; 0a:7d74 $f7 $ff
    dw   `33223333                                     ;; 0a:7d76 $cf $ff
    dw   `22333333                                     ;; 0a:7d78 $3f $ff
    dw   `33333330                                     ;; 0a:7d7a $fe $fe
    dw   `33333300                                     ;; 0a:7d7c $fc $fc
    dw   `33333000                                     ;; 0a:7d7e $f8 $f8

    dw   `00333333                                     ;; 0a:7d80 $3f $3f
    dw   `03222222                                     ;; 0a:7d82 $40 $7f
    dw   `00322222                                     ;; 0a:7d84 $20 $3f
    dw   `03223111                                     ;; 0a:7d86 $4f $78
    dw   `03231123                                     ;; 0a:7d88 $5d $73
    dw   `00333331                                     ;; 0a:7d8a $3f $3e
    dw   `00031311                                     ;; 0a:7d8c $1f $14
    dw   `00031113                                     ;; 0a:7d8e $1f $11

    dw   `33000000                                     ;; 0a:7d90 $c0 $c0
    dw   `22300000                                     ;; 0a:7d92 $20 $e0
    dw   `22300000                                     ;; 0a:7d94 $20 $e0
    dw   `22300000                                     ;; 0a:7d96 $20 $e0
    dw   `12300000                                     ;; 0a:7d98 $a0 $60
    dw   `12300000                                     ;; 0a:7d9a $a0 $60
    dw   `33130000                                     ;; 0a:7d9c $f0 $d0
    dw   `11130000                                     ;; 0a:7d9e $f0 $10

    dw   `00033332                                     ;; 0a:7da0 $1e $1f
    dw   `00003223                                     ;; 0a:7da2 $09 $0f
    dw   `00000332                                     ;; 0a:7da4 $06 $07
    dw   `00003112                                     ;; 0a:7da6 $0e $09
    dw   `00003113                                     ;; 0a:7da8 $0f $09
    dw   `00000332                                     ;; 0a:7daa $06 $07
    dw   `00000313                                     ;; 0a:7dac $07 $05
    dw   `00033333                                     ;; 0a:7dae $1f $1f

    dw   `32233000                                     ;; 0a:7db0 $98 $f8
    dw   `33233300                                     ;; 0a:7db2 $dc $fc
    dw   `23323300                                     ;; 0a:7db4 $6c $fc
    dw   `23323300                                     ;; 0a:7db6 $6c $fc
    dw   `32323330                                     ;; 0a:7db8 $ae $fe
    dw   `22322333                                     ;; 0a:7dba $27 $ff
    dw   `22232223                                     ;; 0a:7dbc $11 $ff
    dw   `33333333                                     ;; 0a:7dbe $ff $ff

    dw   `00000000                                     ;; 0a:7dc0 $00 $00
    dw   `00333333                                     ;; 0a:7dc2 $3f $3f
    dw   `03222222                                     ;; 0a:7dc4 $40 $7f
    dw   `00322222                                     ;; 0a:7dc6 $20 $3f
    dw   `03223111                                     ;; 0a:7dc8 $4f $78
    dw   `03231123                                     ;; 0a:7dca $5d $73
    dw   `00333331                                     ;; 0a:7dcc $3f $3e
    dw   `00031311                                     ;; 0a:7dce $1f $14

    dw   `00000000                                     ;; 0a:7dd0 $00 $00
    dw   `33000000                                     ;; 0a:7dd2 $c0 $c0
    dw   `22300000                                     ;; 0a:7dd4 $20 $e0
    dw   `22300000                                     ;; 0a:7dd6 $20 $e0
    dw   `22300000                                     ;; 0a:7dd8 $20 $e0
    dw   `12300000                                     ;; 0a:7dda $a0 $60
    dw   `12333000                                     ;; 0a:7ddc $b8 $78
    dw   `33313000                                     ;; 0a:7dde $f8 $e8

    dw   `00031113                                     ;; 0a:7de0 $1f $11
    dw   `00003332                                     ;; 0a:7de2 $0e $0f
    dw   `00003223                                     ;; 0a:7de4 $09 $0f
    dw   `00000333                                     ;; 0a:7de6 $07 $07
    dw   `00000323                                     ;; 0a:7de8 $05 $07
    dw   `00003322                                     ;; 0a:7dea $0c $0f
    dw   `00031132                                     ;; 0a:7dec $1e $13
    dw   `00333333                                     ;; 0a:7dee $3f $3f

    dw   `31113000                                     ;; 0a:7df0 $f8 $88
    dw   `33323300                                     ;; 0a:7df2 $ec $fc
    dw   `22332330                                     ;; 0a:7df4 $36 $fe
    dw   `22232330                                     ;; 0a:7df6 $16 $fe
    dw   `31133233                                     ;; 0a:7df8 $fb $9f
    dw   `31133233                                     ;; 0a:7dfa $fb $9f
    dw   `23333233                                     ;; 0a:7dfc $7b $ff
    dw   `33333333                                     ;; 0a:7dfe $ff $ff

    dw   `00033333                                     ;; 0a:7e00 $1f $1f
    dw   `00032222                                     ;; 0a:7e02 $10 $1f
    dw   `00003232                                     ;; 0a:7e04 $0a $0f
    dw   `00032323                                     ;; 0a:7e06 $15 $1f
    dw   `03003321                                     ;; 0a:7e08 $4d $4e
    dw   `31333331                                     ;; 0a:7e0a $ff $be
    dw   `31113131                                     ;; 0a:7e0c $ff $8a
    dw   `33332311                                     ;; 0a:7e0e $f7 $fc

    dw   `33330000                                     ;; 0a:7e10 $f0 $f0
    dw   `22223000                                     ;; 0a:7e12 $08 $f8
    dw   `32223000                                     ;; 0a:7e14 $88 $f8
    dw   `11323000                                     ;; 0a:7e16 $e8 $38
    dw   `11323030                                     ;; 0a:7e18 $ea $3a
    dw   `33323313                                     ;; 0a:7e1a $ef $fd
    dw   `13131113                                     ;; 0a:7e1c $ff $51
    dw   `11323333                                     ;; 0a:7e1e $ef $3f

    dw   `03323233                                     ;; 0a:7e20 $6b $7f
    dw   `33222322                                     ;; 0a:7e22 $c4 $ff
    dw   `11122233                                     ;; 0a:7e24 $e3 $1f
    dw   `33133232                                     ;; 0a:7e26 $fa $df
    dw   `32333232                                     ;; 0a:7e28 $ba $ff
    dw   `32332231                                     ;; 0a:7e2a $b3 $fe
    dw   `32303232                                     ;; 0a:7e2c $aa $ef
    dw   `03333333                                     ;; 0a:7e2e $7f $7f

    dw   `33233230                                     ;; 0a:7e30 $da $fe
    dw   `22322333                                     ;; 0a:7e32 $27 $ff
    dw   `33221113                                     ;; 0a:7e34 $cf $f1
    dw   `23231333                                     ;; 0a:7e36 $5f $f7
    dw   `23223323                                     ;; 0a:7e38 $4d $ff
    dw   `13222323                                     ;; 0a:7e3a $c5 $7f
    dw   `23223323                                     ;; 0a:7e3c $4d $ff
    dw   `33333330                                     ;; 0a:7e3e $fe $fe

    dw   `00333333                                     ;; 0a:7e40 $3f $3f
    dw   `03222222                                     ;; 0a:7e42 $40 $7f
    dw   `00332312                                     ;; 0a:7e44 $36 $3d
    dw   `33323111                                     ;; 0a:7e46 $ef $f8
    dw   `31323123                                     ;; 0a:7e48 $ed $bb
    dw   `31333331                                     ;; 0a:7e4a $ff $be
    dw   `03231311                                     ;; 0a:7e4c $5f $74
    dw   `03231113                                     ;; 0a:7e4e $5f $71

    dw   `33000000                                     ;; 0a:7e50 $c0 $c0
    dw   `22300000                                     ;; 0a:7e52 $20 $e0
    dw   `22333000                                     ;; 0a:7e54 $38 $f8
    dw   `22311300                                     ;; 0a:7e56 $3c $e4
    dw   `31311300                                     ;; 0a:7e58 $fc $a4
    dw   `13313000                                     ;; 0a:7e5a $f8 $68
    dw   `33133000                                     ;; 0a:7e5c $f8 $d8
    dw   `13111300                                     ;; 0a:7e5e $fc $44

    dw   `00333331                                     ;; 0a:7e60 $3f $3e
    dw   `00332232                                     ;; 0a:7e62 $32 $3f
    dw   `00031322                                     ;; 0a:7e64 $1c $17
    dw   `00033113                                     ;; 0a:7e66 $1f $19
    dw   `00032232                                     ;; 0a:7e68 $12 $1f
    dw   `00032232                                     ;; 0a:7e6a $12 $1f
    dw   `00311132                                     ;; 0a:7e6c $3e $23
    dw   `00333333                                     ;; 0a:7e6e $3f $3f

    dw   `32223000                                     ;; 0a:7e70 $88 $f8
    dw   `32230000                                     ;; 0a:7e72 $90 $f0
    dw   `23330000                                     ;; 0a:7e74 $70 $f0
    dw   `33233330                                     ;; 0a:7e76 $de $fe
    dw   `23323333                                     ;; 0a:7e78 $6f $ff
    dw   `22332233                                     ;; 0a:7e7a $33 $ff
    dw   `22233323                                     ;; 0a:7e7c $1d $ff
    dw   `33333333                                     ;; 0a:7e7e $ff $ff

    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7e80 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7e88 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7e90 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7e98 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7ea0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7ea8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7eb0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7eb8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7ec0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7ec8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7ed0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7ed8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7ee0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7ee8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7ef0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7ef8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7f00 ????????
    db   $0f, $0f, $1e, $12, $1c, $14, $38, $28        ;; 0a:7f08 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7f10 ????????
    db   $70, $70, $f8, $c8, $38, $28, $1c, $14        ;; 0a:7f18 ????????
    db   $70, $50, $ec, $9c, $78, $68, $3c, $34        ;; 0a:7f20 ????????
    db   $1e, $1a, $7b, $7d, $1f, $1f, $00, $00        ;; 0a:7f28 ????????
    db   $0e, $0a, $37, $39, $1e, $16, $3c, $2c        ;; 0a:7f30 ????????
    db   $78, $58, $de, $be, $f8, $f8, $00, $00        ;; 0a:7f38 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7f40 ????????
    db   $00, $00, $00, $00, $03, $03, $1f, $1c        ;; 0a:7f48 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7f50 ????????
    db   $00, $00, $00, $00, $f0, $f0, $f8, $08        ;; 0a:7f58 ????????
    db   $3f, $21, $1b, $17, $1c, $14, $1c, $14        ;; 0a:7f60 ????????
    db   $3a, $36, $67, $7f, $3e, $3e, $00, $00        ;; 0a:7f68 ????????
    db   $fc, $fc, $32, $d2, $e8, $d8, $38, $28        ;; 0a:7f70 ????????
    db   $5c, $6c, $e6, $fe, $7c, $7c, $00, $00        ;; 0a:7f78 ????????
    db   $01, $01, $06, $07, $0f, $0f, $10, $1f        ;; 0a:7f80 ????????
    db   $20, $3f, $2f, $3f, $3f, $39, $ef, $f9        ;; 0a:7f88 ????????
    db   $e0, $e0, $10, $f0, $08, $f8, $86, $fe        ;; 0a:7f90 ????????
    db   $41, $ff, $0d, $ff, $9a, $fe, $df, $f7        ;; 0a:7f98 ????????
    db   $f7, $9f, $f8, $bf, $f7, $97, $7f, $4f        ;; 0a:7fa0 ????????
    db   $3f, $3d, $0b, $0f, $1f, $1c, $0f, $0f        ;; 0a:7fa8 ????????
    db   $37, $f9, $fb, $fd, $ff, $c3, $f6, $ee        ;; 0a:7fb0 ????????
    db   $fa, $1e, $e4, $fc, $ce, $3e, $fc, $fc        ;; 0a:7fb8 ????????
    db   $00, $00, $01, $01, $06, $07, $0f, $0f        ;; 0a:7fc0 ????????
    db   $10, $1f, $20, $3f, $20, $3f, $5f, $7f        ;; 0a:7fc8 ????????
    db   $00, $00, $e0, $e0, $10, $f0, $08, $f8        ;; 0a:7fd0 ????????
    db   $84, $fc, $42, $fe, $01, $ff, $0d, $ff        ;; 0a:7fd8 ????????
    db   $7f, $79, $2f, $3f, $30, $3f, $3f, $2f        ;; 0a:7fe0 ????????
    db   $27, $3e, $1f, $1f, $3f, $20, $1f, $1f        ;; 0a:7fe8 ????????
    db   $bf, $ff, $59, $ef, $ea, $de, $d2, $be        ;; 0a:7ff0 ????????
    db   $bc, $7c, $a4, $7c, $ce, $7e, $fc, $fc        ;; 0a:7ff8 ????????
