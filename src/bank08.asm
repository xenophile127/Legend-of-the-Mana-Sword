;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"

SECTION "bank08", ROMX[$4000], BANK[$08]

INCLUDE "data/map/headers.asm"

; Metatile tables have been moved to expansion space to make room for more
;INCLUDE "data/metatiles.asm"
metatilesOldLocation:
    ds   $0d26, $ff

INCLUDE "data/xptable.asm"

INCLUDE "data/scriptPointers.asm"

ds 83 ; Free space

SECTION "bank08_gfx", ROMX[$5a00], BANK[$08]

gfxBlankTiles08:
    dw   `00000000                                     ;; 08:5a00 $00 $00
    dw   `00000000                                     ;; 08:5a02 $00 $00
    dw   `00000000                                     ;; 08:5a04 $00 $00
    dw   `00000000                                     ;; 08:5a06 $00 $00
    dw   `00000000                                     ;; 08:5a08 $00 $00
    dw   `00000000                                     ;; 08:5a0a $00 $00
    dw   `00000000                                     ;; 08:5a0c $00 $00
    dw   `00000000                                     ;; 08:5a0e $00 $00

    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 08:5a10 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 08:5a18 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 08:5a20 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 08:5a28 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 08:5a30 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 08:5a38 ????????

;@gfximg name=player width=2 height=38
gfxPlayer:
IF DEF(PLAYER_GRAPHICS_AMANDA)
    INCBIN "player_amanda.bin"                         ;; 08:5a40
ELIF DEF(PLAYER_GRAPHICS_ORIGINAL)
    INCBIN "player.bin"                                ;; 08:5a40
ENDC

;@gfximg name=chest width=2 height=3
gfxChest:
    INCBIN "chest.bin"                                 ;; 08:5f00

;@gfximg name=hand_spark width=2 height=5
gfxHand:
    INCBIN "hand_spark.bin"                            ;; 08:5f60

;@gfximg name=chocobo width=2 height=24
gfxChocobo:
    INCBIN "chocobo.bin"                               ;; 08:6000

;@gfximg name=minecart width=2 height=6
gfxMinecart:
IF DEF(PLAYER_GRAPHICS_AMANDA)
    INCBIN "minecart_amanda.bin"                       ;; 08:6300
ELIF DEF(PLAYER_GRAPHICS_ORIGINAL)
    INCBIN "minecart.bin"                              ;; 08:6300
ENDC

;@gfximg name=cloud width=2 height=2
    INCBIN "cloud.bin"                                 ;; 08:63c0

;@gfximg name=moogle width=2 height=12
gfxMoogle:
    INCBIN "moogle.bin"                                ;; 08:6400
;@gfximg name=chocobo2 width=2 height=12
    INCBIN "chocobo2.bin"                              ;; 08:6580

;@gfximg name=statusbar width=16 height=3
gfxStatusBar:
    INCBIN "statusbar.bin"                             ;; 08:6700
;@gfximg name=font width=16 height=6
    INCBIN "font.bin"                                  ;; 08:6a00

;@gfximg name=attack/sword width=2 height=6
gfxAttackSword:
    INCBIN "attack/sword.bin"                          ;; 08:7000

;@gfximg name=attack/axe width=2 height=6
gfxAttackAxe:
    INCBIN "attack/axe.bin"                            ;; 08:70c0

;@gfximg name=attack/morning_star width=2 height=6
gfxAttackMorningStar:
    INCBIN "attack/morning_star.bin"                   ;; 08:7180

;@gfximg name=attack/sickle width=2 height=6
gfxAttackSickle:
    INCBIN "attack/sickle.bin"                         ;; 08:7240

;@gfximg name=attacks1 width=6 height=1
data_08_7300:
    INCBIN "attacks1.bin"                              ;; 08:7300

;@gfximg name=attack/spear width=14 height=1
gfxAttackSpear:
    INCBIN "attack/spear.bin"                              ;; 08:7360

;@gfximg name=attack/mattok width=2 height=6
gfxAttackMattok:
    INCBIN "attack/mattok.bin"                         ;; 08:7440

;@gfximg name=attacks3 width=2 height=4
data_08_7500:
    INCBIN "attacks3.bin"                              ;; 08:7500

data_08_7580:
    db   $00, $00, $00, $00, $00, $00, $01, $01        ;; 08:7580 ????????
    db   $06, $07, $05, $06, $0b, $0c, $0b, $0c        ;; 08:7588 ????????
    db   $00, $00, $00, $00, $00, $00, $80, $80        ;; 08:7590 ????????
    db   $60, $e0, $a0, $60, $d0, $30, $d0, $30        ;; 08:7598 ????????
    db   $0b, $0c, $05, $06, $06, $07, $01, $01        ;; 08:75a0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 08:75a8 ????????
    db   $d0, $30, $a0, $60, $60, $e0, $80, $80        ;; 08:75b0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 08:75b8 ????????
    db   $00, $00, $03, $03, $0c, $0f, $11, $1e        ;; 08:75c0 ????????
    db   $27, $38, $2f, $30, $4f, $70, $5f, $60        ;; 08:75c8 ????????
    db   $00, $00, $c0, $c0, $30, $f0, $88, $78        ;; 08:75d0 ????????
    db   $e4, $1c, $f4, $0c, $f2, $0e, $fa, $06        ;; 08:75d8 ????????
    db   $5f, $60, $4f, $70, $2f, $30, $27, $38        ;; 08:75e0 ????????
    db   $11, $1e, $0c, $0f, $03, $03, $00, $00        ;; 08:75e8 ????????
    db   $fa, $06, $f2, $0e, $f4, $0c, $e4, $1c        ;; 08:75f0 ????????
    db   $88, $78, $30, $f0, $c0, $c0, $00, $00        ;; 08:75f8 ????????

;@gfximg name=effect/snowman width=2 height=2
gfxSnowman:
    INCBIN "effect/snowman.bin"                        ;; 08:7600

;@gfximg name=attack/ice width=2 height=10
gfxAttackIce:
    INCBIN "attack/ice.bin"                            ;; 08:7640

;@gfximg name=attack/fire width=2 height=6
gfxAttackFire:
    INCBIN "attack/fire.bin"                           ;; 08:7780

;@gfximg name=attacks4 width=2 height=8
data_08_7840:
    INCBIN "attacks4.bin"                              ;; 08:7840

;@gfximg name=attacks5 width=1 height=1
data_08_7940:
    INCBIN "attacks5.bin"                              ;; 08:7940

;@gfximg name=attacks6 width=2 height=2
data_08_7950:
    INCBIN "attacks6.bin"                              ;; 08:7950

;@gfximg name=attacks7 width=2 height=2
data_08_7990:
    INCBIN "attacks7.bin"                              ;; 08:7990

;@gfximg name=attacks8 width=2 height=31
data_08_79d0:
    INCBIN "attacks8.bin"                              ;; 08:79d0

;@gfximg name=attacks9 width=2 height=5
data_08_7db0:
    INCBIN "attacks9.bin"                              ;; 08:7db0
