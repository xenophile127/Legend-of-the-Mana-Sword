; Metasprites for the explosion effect when an enemy is defeated.

; For the color port the graphics have been moved to VRAM bank 1 for two reasons:
; 1. Free up additional graphics space for bosses.
; 2. Because there is no downside to doing so.

; These metasprite tables are made up of entries of [attr, tile1, tile2].
; The first four entries are for standing facing the four directions.
; The next four entries are for walking in the four directions.

npcKillExplosion1MetaspriteTable:
    db   OAMF_XFLIP  | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC1, $72, $70
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC1, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC1, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC1, $70, $72

    db   OAMF_XFLIP  | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC1, $72, $70
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC1, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC1, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC1, $70, $72

npcKillExplosion2MetaspriteTable:
    db   OAMF_XFLIP  | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC2, $72, $70
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC2, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC2, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC2, $70, $72

    db   OAMF_XFLIP  | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC2, $72, $70
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC2, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC2, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC2, $70, $72

npcKillExplosion3MetaspriteTable:
    db   OAMF_XFLIP  | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC3, $72, $70
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC3, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC3, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC3, $70, $72

    db   OAMF_XFLIP  | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC3, $72, $70
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC3, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC3, $70, $72
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC3, $70, $72
