; Metasprites for the player and the player's attacks.

; These metasprite tables are made up of entries of [attr, tile1, tile2].
; The first four entries are for standing facing the four directions.
; The second four entries are for stepping in those directions.

; Give Ice its own metasprite table using OBP1 so it is blue under boot rom auto colorization.
playerAttackIceMetaspriteTable:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_SNOW, $0a, $08
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_SNOW, $08, $0a
    db   OAMF_YFLIP  | OAMF_PAL1 | PAL_SNOW, $08, $0a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_SNOW, $08, $0a
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_SNOW, $0a, $08
    db   OAMF_YFLIP  | OAMF_PAL1 | PAL_SNOW, $08, $0a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_SNOW, $08, $0a
    db   OAMF_XYFLIP | OAMF_PAL1 | PAL_SNOW, $0a, $08

playerMetaspriteTable:
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PLAYER, $02, $00
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PLAYER, $00, $02
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PLAYER, $00, $02
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PLAYER, $00, $02

playerAttackFirstMetaspriteTable:
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_ATTACK, $0a, $08
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_ATTACK, $08, $0a
    db   OAMF_YFLIP  | OAMF_PAL0 | PAL_ATTACK, $08, $0a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_ATTACK, $08, $0a
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_ATTACK, $0a, $08
    db   OAMF_YFLIP  | OAMF_PAL0 | PAL_ATTACK, $08, $0a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_ATTACK, $08, $0a
    db   OAMF_XYFLIP | OAMF_PAL0 | PAL_ATTACK, $0a, $08

playerAttackSecondMetaspriteTable:
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_ATTACK, $0e, $0c
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_ATTACK, $0c, $0e
    db   OAMF_YFLIP  | OAMF_PAL0 | PAL_ATTACK, $0c, $0e
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_ATTACK, $0c, $0e
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_ATTACK, $0e, $0c
    db   OAMF_YFLIP  | OAMF_PAL0 | PAL_ATTACK, $0c, $0e
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_ATTACK, $0c, $0e
    db   OAMF_XYFLIP | OAMF_PAL0 | PAL_ATTACK, $0e, $0c

