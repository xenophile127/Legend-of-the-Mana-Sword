; Metasprites for NPCs that are not spawned normally. Specifically:
; * Inanimate snowmen spawned by using the Ice spell (or similar items).
; * Chests spawned by killing enemies or from a script.
; * Empty chests which can be spawned by opening a chest (or via the normal spawn mechanisms).

; For the color port the graphics have been moved to VRAM bank 1 to
; free up additional graphics space for bosses.

; METASPRITE macro format:
; 1. Index in the metasprite table. Informative only for use in other structures; not recorded in the rom.
;    Boss explosion animations (for bosses that have them) use $0c and $0d.
; 2. OAM Attributes - X/Y flip bits.
; 3. OAM Attributes - DMG OBP palette number.
; 4. Left tile index. Sprites are 8x16 so tile indexes are always even.
; 5. Right tile index. Sprites are 8x16 so tile indexes are always even.
; 6. CGB OBP color palette number.
; 7. Future: Second CGB OBP color palette number for the right sprite.
; 8. Optional: CGB VRAM bank number.

; These metasprite tables are four entries,
; one for each of the four directions.

snowmanMetaspriteTable:
    METASPRITE $00, OAMF_NOFLIP,  OAMF_PAL1, $74, $76, PAL_SNOW, PAL_SNOW, OAMF_BANK1
    METASPRITE $01, OAMF_NOFLIP,  OAMF_PAL1, $74, $76, PAL_SNOW, PAL_SNOW, OAMF_BANK1
    METASPRITE $02, OAMF_NOFLIP,  OAMF_PAL1, $74, $76, PAL_SNOW, PAL_SNOW, OAMF_BANK1
    METASPRITE $03, OAMF_NOFLIP,  OAMF_PAL1, $74, $76, PAL_SNOW, PAL_SNOW, OAMF_BANK1

chest1MetaspriteTable:
    METASPRITE $00, OAMF_NOFLIP,  OAMF_PAL0, $78, $7a, PAL_NPC1, PAL_NPC1, OAMF_BANK1
    METASPRITE $01, OAMF_NOFLIP,  OAMF_PAL0, $78, $7a, PAL_NPC1, PAL_NPC1, OAMF_BANK1
    METASPRITE $02, OAMF_NOFLIP,  OAMF_PAL0, $78, $7a, PAL_NPC1, PAL_NPC1, OAMF_BANK1
    METASPRITE $03, OAMF_NOFLIP,  OAMF_PAL0, $78, $7a, PAL_NPC1, PAL_NPC1, OAMF_BANK1

chest2MetaspriteTable:
    METASPRITE $00, OAMF_NOFLIP,  OAMF_PAL0, $78, $7a, PAL_NPC2, PAL_NPC2, OAMF_BANK1
    METASPRITE $01, OAMF_NOFLIP,  OAMF_PAL0, $78, $7a, PAL_NPC2, PAL_NPC2, OAMF_BANK1
    METASPRITE $02, OAMF_NOFLIP,  OAMF_PAL0, $78, $7a, PAL_NPC2, PAL_NPC2, OAMF_BANK1
    METASPRITE $03, OAMF_NOFLIP,  OAMF_PAL0, $78, $7a, PAL_NPC2, PAL_NPC2, OAMF_BANK1

chest3MetaspriteTable:
    METASPRITE $00, OAMF_NOFLIP,  OAMF_PAL0, $78, $7a, PAL_NPC3, PAL_NPC3, OAMF_BANK1
    METASPRITE $01, OAMF_NOFLIP,  OAMF_PAL0, $78, $7a, PAL_NPC3, PAL_NPC3, OAMF_BANK1
    METASPRITE $02, OAMF_NOFLIP,  OAMF_PAL0, $78, $7a, PAL_NPC3, PAL_NPC3, OAMF_BANK1
    METASPRITE $03, OAMF_NOFLIP,  OAMF_PAL0, $78, $7a, PAL_NPC3, PAL_NPC3, OAMF_BANK1

chestEmpty1MetaspriteTable:
    METASPRITE $00, OAMF_NOFLIP,  OAMF_PAL0, $7c, $7e, PAL_NPC1, PAL_NPC1, OAMF_BANK1
    METASPRITE $01, OAMF_NOFLIP,  OAMF_PAL0, $7c, $7e, PAL_NPC1, PAL_NPC1, OAMF_BANK1
    METASPRITE $02, OAMF_NOFLIP,  OAMF_PAL0, $7c, $7e, PAL_NPC1, PAL_NPC1, OAMF_BANK1
    METASPRITE $03, OAMF_NOFLIP,  OAMF_PAL0, $7c, $7e, PAL_NPC1, PAL_NPC1, OAMF_BANK1

chestEmpty2MetaspriteTable:
    METASPRITE $00, OAMF_NOFLIP,  OAMF_PAL0, $7c, $7e, PAL_NPC2, PAL_NPC2, OAMF_BANK1
    METASPRITE $01, OAMF_NOFLIP,  OAMF_PAL0, $7c, $7e, PAL_NPC2, PAL_NPC2, OAMF_BANK1
    METASPRITE $02, OAMF_NOFLIP,  OAMF_PAL0, $7c, $7e, PAL_NPC2, PAL_NPC2, OAMF_BANK1
    METASPRITE $03, OAMF_NOFLIP,  OAMF_PAL0, $7c, $7e, PAL_NPC2, PAL_NPC2, OAMF_BANK1

chestEmpty3MetaspriteTable:
    METASPRITE $00, OAMF_NOFLIP,  OAMF_PAL0, $7c, $7e, PAL_NPC3, PAL_NPC3, OAMF_BANK1
    METASPRITE $01, OAMF_NOFLIP,  OAMF_PAL0, $7c, $7e, PAL_NPC3, PAL_NPC3, OAMF_BANK1
    METASPRITE $02, OAMF_NOFLIP,  OAMF_PAL0, $7c, $7e, PAL_NPC3, PAL_NPC3, OAMF_BANK1
    METASPRITE $03, OAMF_NOFLIP,  OAMF_PAL0, $7c, $7e, PAL_NPC3, PAL_NPC3, OAMF_BANK1
