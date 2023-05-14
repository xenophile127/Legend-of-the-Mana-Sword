INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"

SECTION "bank10", ROMX[$4000], BANK[$10]

; The metatile tables have been moved here from bank 8 to give room for more tilesets.

metatiles:
INCLUDE "data/metatiles.asm"
