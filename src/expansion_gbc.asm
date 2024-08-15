INCLUDE "include/hardware.inc"

DEF SGB_CODE_BANK EQU $17

SECTION "Game Boy Color Bank - Code", ROMX[$4000], BANK[SGB_CODE_BANK]

; Initial palette loading.
gbc_init:
    ld a, $00
    call loadPalettes
    ret
