INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"

SECTION "bank1c", ROMX[$4000], BANK[$1c]

; Background tiles have been moved from banks 0b and 0c to 1b and 1c to give
; space for additional tilesets.

tilesets:

IF DEF(COLOR)

tilesetGfxOutdoor:
    INCBIN "tileset/outdoor_color.bin"

tilesetGfxTown:
    INCBIN "tileset/town_airship_mountain_color.bin"

ELSE

tilesetGfxOutdoor:
    INCBIN "tileset/outdoor.bin"

tilesetGfxTown:
    INCBIN "tileset/town_airship_mountain.bin"

ENDC

tilesetGfxIndoor:
    INCBIN "tileset/indoor.bin"

tilesetGfxCaves:
    INCBIN "tileset/caves.bin"
