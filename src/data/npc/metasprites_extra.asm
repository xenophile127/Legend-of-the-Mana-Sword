; Metasprites for NPCs that are not spawned normally. Specifically:
; * Inanimate snowmen spawned by using the Ice spell (or similar items).
; * Chests spawned by killing enemies.
; * Empty chests which can be spawned by opening a chest (or via the normal spawn mechanisms).

; These metasprite tables are eight entries of [attr, tile1, tile2].
; The first four entries are for standing facing the four directions.
; The second four entries are for stepping in those directions.

snowmanMetaspriteTable:
    db   $10, $74, $76
    db   $10, $74, $76
    db   $10, $74, $76
    db   $10, $74, $76
    db   $10, $74, $76
    db   $10, $74, $76
    db   $10, $74, $76
    db   $10, $74, $76

chestMetaspriteTable:
    db   $00, $78, $7a
    db   $00, $78, $7a
    db   $00, $78, $7a
    db   $00, $78, $7a
    db   $00, $78, $7a
    db   $00, $78, $7a
    db   $00, $78, $7a
    db   $00, $78, $7a

chestEmptyMetaspriteTable:
    db   $00, $7c, $7e
    db   $00, $7c, $7e
    db   $00, $7c, $7e
    db   $00, $7c, $7e
    db   $00, $7c, $7e
    db   $00, $7c, $7e
    db   $00, $7c, $7e
    db   $00, $7c, $7e
