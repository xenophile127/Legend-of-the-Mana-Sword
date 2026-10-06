; Metasprites for the explosion effect when an enemy is defeated.

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

; The first four entries are for standing facing the four directions.
; The next four entries are for walking in the four directions.

npcKillExplosion1MetaspriteTable:
    METASPRITE $00, OAMF_XFLIP,  OAMF_PAL0, $72, $70, PAL_NPC1, PAL_NPC1, OAMF_BANK1
    METASPRITE $01, OAMF_NOFLIP, OAMF_PAL0, $70, $72, PAL_NPC1, PAL_NPC1, OAMF_BANK1
    METASPRITE $02, OAMF_NOFLIP, OAMF_PAL0, $70, $72, PAL_NPC1, PAL_NPC1, OAMF_BANK1
    METASPRITE $03, OAMF_NOFLIP, OAMF_PAL0, $70, $72, PAL_NPC1, PAL_NPC1, OAMF_BANK1

    METASPRITE $00, OAMF_XFLIP,  OAMF_PAL0, $72, $70, PAL_NPC1, PAL_NPC1, OAMF_BANK1
    METASPRITE $01, OAMF_NOFLIP, OAMF_PAL0, $70, $72, PAL_NPC1, PAL_NPC1, OAMF_BANK1
    METASPRITE $02, OAMF_NOFLIP, OAMF_PAL0, $70, $72, PAL_NPC1, PAL_NPC1, OAMF_BANK1
    METASPRITE $03, OAMF_NOFLIP, OAMF_PAL0, $70, $72, PAL_NPC1, PAL_NPC1, OAMF_BANK1

npcKillExplosion2MetaspriteTable:
    METASPRITE $00, OAMF_XFLIP,  OAMF_PAL0, $72, $70, PAL_NPC2, PAL_NPC2, OAMF_BANK1
    METASPRITE $01, OAMF_NOFLIP, OAMF_PAL0, $70, $72, PAL_NPC2, PAL_NPC2, OAMF_BANK1
    METASPRITE $02, OAMF_NOFLIP, OAMF_PAL0, $70, $72, PAL_NPC2, PAL_NPC2, OAMF_BANK1
    METASPRITE $03, OAMF_NOFLIP, OAMF_PAL0, $70, $72, PAL_NPC2, PAL_NPC2, OAMF_BANK1

    METASPRITE $00, OAMF_XFLIP,  OAMF_PAL0, $72, $70, PAL_NPC2, PAL_NPC2, OAMF_BANK1
    METASPRITE $01, OAMF_NOFLIP, OAMF_PAL0, $70, $72, PAL_NPC2, PAL_NPC2, OAMF_BANK1
    METASPRITE $02, OAMF_NOFLIP, OAMF_PAL0, $70, $72, PAL_NPC2, PAL_NPC2, OAMF_BANK1
    METASPRITE $03, OAMF_NOFLIP, OAMF_PAL0, $70, $72, PAL_NPC2, PAL_NPC2, OAMF_BANK1

npcKillExplosion3MetaspriteTable:
    METASPRITE $00, OAMF_XFLIP,  OAMF_PAL0, $72, $70, PAL_NPC3, PAL_NPC3, OAMF_BANK1
    METASPRITE $01, OAMF_NOFLIP, OAMF_PAL0, $70, $72, PAL_NPC3, PAL_NPC3, OAMF_BANK1
    METASPRITE $02, OAMF_NOFLIP, OAMF_PAL0, $70, $72, PAL_NPC3, PAL_NPC3, OAMF_BANK1
    METASPRITE $03, OAMF_NOFLIP, OAMF_PAL0, $70, $72, PAL_NPC3, PAL_NPC3, OAMF_BANK1

    METASPRITE $00, OAMF_XFLIP,  OAMF_PAL0, $72, $70, PAL_NPC3, PAL_NPC3, OAMF_BANK1
    METASPRITE $01, OAMF_NOFLIP, OAMF_PAL0, $70, $72, PAL_NPC3, PAL_NPC3, OAMF_BANK1
    METASPRITE $02, OAMF_NOFLIP, OAMF_PAL0, $70, $72, PAL_NPC3, PAL_NPC3, OAMF_BANK1
    METASPRITE $03, OAMF_NOFLIP, OAMF_PAL0, $70, $72, PAL_NPC3, PAL_NPC3, OAMF_BANK1
