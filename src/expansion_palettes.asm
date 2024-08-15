INCLUDE "include/macros.inc"

DEF COLOR_PALETTES_BANK_1 EQU $18

SECTION "Game Boy Color Bank - Palettes 1", ROMX[$4000], BANK[COLOR_PALETTES_BANK_1]

ColorPalettesROM:

INCLUDE "pal/palette_list.inc"
