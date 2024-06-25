; Metasprites for the minimap's flashing "you are here" marker.

; Metasprite tables are made up of entries of [attr, tile1, tile2].
; These four entries are for standing facing the four directions.

; It appears that the marker only ever uses the last of these four.

INCLUDE "include/oam_attributes.inc"

minimapFlashingMarkerMetaspriteTable:
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_ATTACK, $08, $0a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_ATTACK, $08, $0a,
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_ATTACK, $08, $0a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_ATTACK, $08, $0a
