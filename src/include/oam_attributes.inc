INCLUDE "include/hardware.inc"

; Constants so all four flip variants can be expressed easily.
DEF OAMF_XYFLIP EQU OAMF_YFLIP | OAMF_XFLIP
DEF OAMF_NOFLIP EQU !OAMF_YFLIP | !OAMF_XFLIP
