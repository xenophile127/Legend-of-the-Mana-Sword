INCLUDE "include/hardware.inc"

; Constants so all four flip variants can be expressed easily.
DEF OAMF_XYFLIP EQU OAMF_YFLIP | OAMF_XFLIP
DEF OAMF_NOFLIP EQU !OAMF_YFLIP | !OAMF_XFLIP

; There are eight total hardware sprite palettes.
DEF PAL_PLAYER     EQU $00
DEF PAL_ATTACK     EQU $01
DEF PAL_SNOW       EQU $02
DEF PAL_FOLLOWER   EQU $03
DEF PAL_PROJECTILE EQU $04
DEF PAL_NPC1       EQU $05
DEF PAL_NPC2       EQU $06
DEF PAL_NPC3       EQU $07
