;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"

SECTION "bank0c", ROMX[$4000], BANK[$0c]

; Moved to bank 1c
tilesetsOldLocation:
    ds $4000, $ff

;tilesetGfxOutdoor:
;    INCBIN "tileset/outdoor.bin"                       ;; 0c:4000

;tilesetGfxTown:
;    INCBIN "tileset/town_airship_mountain.bin"         ;; 0c:5000

;tilesetGfxIndoor:
;    INCBIN "tileset/indoor.bin"                        ;; 0c:6000

;tilesetGfxCaves:
;    INCBIN "tileset/caves.bin"                         ;; 0c:7000
