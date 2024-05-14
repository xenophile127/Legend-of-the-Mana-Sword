; Metasprites for script-triggered special effects (recovery ponds, fire, and explosions).

; These metasprite tables are made up of entries of [attr, tile1, tile2].
; The first four entries are for standing facing the four directions.
; The next four entries are for walking in the four directions.

npcKillExplosionMetaspriteTable:
    db   OAMF_XFLIP  | OAMF_PAL0, $72, $70
    db   OAMF_NOFLIP | OAMF_PAL0, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0, $70, $72

    db   OAMF_XFLIP  | OAMF_PAL0, $72, $70
    db   OAMF_NOFLIP | OAMF_PAL0, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0, $70, $72
