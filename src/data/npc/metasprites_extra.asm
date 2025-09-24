; Metasprites for NPCs that are not spawned normally. Specifically:
; * Inanimate snowmen spawned by using the Ice spell (or similar items).
; * Chests spawned by killing enemies or from a script.
; * Empty chests which can be spawned by opening a chest (or via the normal spawn mechanisms).

; For the color port the graphics have been moved to VRAM bank 1 for two reasons:
; 1. Free up additional graphics space for bosses.
; 2. Because there is no downside to doing so.

; These metasprite tables are four entries of [attr, tile1, tile2].
; One for each of the four directions.

snowmanMetaspriteTable:
    db   OAMF_NOFLIP | OAMF_PAL1 | OAMF_BANK1 | PAL_SNOW, $74, $76
    db   OAMF_NOFLIP | OAMF_PAL1 | OAMF_BANK1 | PAL_SNOW, $74, $76
    db   OAMF_NOFLIP | OAMF_PAL1 | OAMF_BANK1 | PAL_SNOW, $74, $76
    db   OAMF_NOFLIP | OAMF_PAL1 | OAMF_BANK1 | PAL_SNOW, $74, $76

chest1MetaspriteTable:
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC1, $78, $7a
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC1, $78, $7a
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC1, $78, $7a
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC1, $78, $7a

chest2MetaspriteTable:
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC2, $78, $7a
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC2, $78, $7a
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC2, $78, $7a
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC2, $78, $7a

chest3MetaspriteTable:
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC3, $78, $7a
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC3, $78, $7a
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC3, $78, $7a
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC3, $78, $7a

chestEmpty1MetaspriteTable:
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC1, $7c, $7e
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC1, $7c, $7e
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC1, $7c, $7e
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC1, $7c, $7e

chestEmpty2MetaspriteTable:
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC2, $7c, $7e
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC2, $7c, $7e
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC2, $7c, $7e
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC2, $7c, $7e

chestEmpty3MetaspriteTable:
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC3, $7c, $7e
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC3, $7c, $7e
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC3, $7c, $7e
    db   OAMF_NOFLIP | OAMF_PAL0 | OAMF_BANK1 | PAL_NPC3, $7c, $7e
