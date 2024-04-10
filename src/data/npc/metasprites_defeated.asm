; Metasprites for script-triggered special effects (recovery ponds, fire, and explosions).

; These metasprite tables are made up of entries of [attr, tile1, tile2].
; The first four entries are for standing facing the four directions.
; The next four entries are for walking in the four directions.

npcKillExplosionMetaspriteTable:
    db   $20, $72, $70
    db   $00, $70, $72
    db   $00, $70, $72
    db   $00, $70, $72

    db   $20, $72, $70
    db   $00, $70, $72
    db   $00, $70, $72
    db   $00, $70, $72
