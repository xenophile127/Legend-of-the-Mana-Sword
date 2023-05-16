INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"

SECTION "bank1b", ROMX[$4000], BANK[$1b]

; Background tiles have been moved from banks 0b and 0c to 1b and 1c to give
; space for additional tilesets.

tilesetGfxTitle:
    INCBIN "tileset/title_end.bin"

tilesetGfxWorldmap:
    INCBIN "tileset/worldmap.bin"
