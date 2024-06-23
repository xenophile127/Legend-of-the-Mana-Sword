; Metasprites for the explosion effect when an enemy is defeated.

; These metasprite tables are made up of entries of [attr, tile1, tile2].
; The first four entries are for standing facing the four directions.
; The next four entries are for walking in the four directions.

npcKillExplosion1MetaspriteTable:
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_NPC1, $72, $70
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC1, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC1, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC1, $70, $72

    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_NPC1, $72, $70
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC1, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC1, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC1, $70, $72

npcKillExplosion2MetaspriteTable:
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_NPC2, $72, $70
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC2, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC2, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC2, $70, $72

    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_NPC2, $72, $70
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC2, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC2, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC2, $70, $72

npcKillExplosion3MetaspriteTable:
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_NPC3, $72, $70
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC3, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC3, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC3, $70, $72

    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_NPC3, $72, $70
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC3, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC3, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC3, $70, $72
