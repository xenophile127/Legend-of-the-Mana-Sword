;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"

SECTION "bank07", ROMX[$4000], BANK[$07]

INCLUDE "data/map/03_rooms.asm"

INCLUDE "data/map/02_rooms.asm"

INCLUDE "data/map/0D_rooms.asm"

INCLUDE "data/map/04_rooms.asm"

INCLUDE "data/map/05_rooms.asm"

INCLUDE "data/map/0B_rooms.asm"

INCLUDE "data/map/0C_rooms.asm"

INCLUDE "data/map/06_rooms.asm"

INCLUDE "data/map/07_rooms.asm"

    db   $89, $8a, $58, $87, $88, $86, $ff, $ff        ;; 07:7fba ????????
    db   $3b, $0c, $0d, $1c, $fe, $fd, $5f, $a5        ;; 07:7fc2 ????????
    db   $a9, $aa, $59, $60, $fc, $1f, $1f, $3c        ;; 07:7fca ????????
    db   $3d, $1c, $0c, $0d, $05, $06, $07, $d4        ;; 07:7fd2 ????????
    db   $d4, $d4, $05, $06, $07, $5d, $ff, $ff        ;; 07:7fda ????????
    db   $ff, $18, $4c, $0d, $5d, $1b, $3c, $3d        ;; 07:7fe2 ????????
    db   $1c, $0c, $ff, $ff, $ff, $ff, $ff, $ff        ;; 07:7fea ????????
    db   $ff, $ff, $4c, $ff, $ff, $ff, $ff, $ff        ;; 07:7ff2 ????????
    db   $ff, $ff, $4d, $5d, $5f, $60                  ;; 07:7ffa ??????
