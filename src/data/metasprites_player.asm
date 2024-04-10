; Metasprites for the player and the player's attacks.

; These metasprite tables are made up of entries of [attr, tile1, tile2].
; The first four entries are for standing facing the four directions.
; The second four entries are for stepping in those directions.

; Give Ice its own metasprite table using OBP1 so it is blue under boot rom auto colorization.
playerAttackIceMetaspriteTable:
    db   $30, $0a, $08
    db   $10, $08, $0a
    db   $50, $08, $0a
    db   $10, $08, $0a
    db   $30, $0a, $08
    db   $50, $08, $0a
    db   $10, $08, $0a
    db   $70, $0a, $08

playerMetaspriteTable:
    db   $20, $02, $00
    db   $00, $00, $02
    db   $00, $00, $02
    db   $00, $00, $02

playerAttackFirstMetaspriteTable:
    db   $20, $0a, $08
    db   $00, $08, $0a
    db   $40, $08, $0a
    db   $00, $08, $0a
    db   $20, $0a, $08
    db   $40, $08, $0a
    db   $00, $08, $0a
    db   $60, $0a, $08

playerAttackSecondMetaspriteTable:
    db   $20, $0e, $0c
    db   $00, $0c, $0e
    db   $40, $0c, $0e
    db   $00, $0c, $0e
    db   $20, $0e, $0c
    db   $40, $0c, $0e
    db   $00, $0c, $0e
    db   $60, $0e, $0c

