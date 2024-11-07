INCLUDE "include/hardware.inc"
INCLUDE "include/debug.inc"


DEF SGB_CODE_BANK EQU $16

SECTION "SGB Bank - Code", ROMX[$4000], BANK[SGB_CODE_BANK]

early_init:
    ; Init Super Game Boy if necessary
    call sgb_init
    ; Continue with the normal reset.
    jp FullReset

; Super Game Boy border injector
; by Marc Robledo 2024
INCLUDE "code/super-game-boy-border-injector.asm"

sgb_init:
    ; Exit early if not SGB
    ld a, c
    cp a, $14
    ret nz

    ; Log a message before calling the injector because emulators in GBC+border mode may
    ; abort the moment the border transfer finishes.
    DBG_MSG_LABEL debugMsgSGBBorderInjector

    ; Call border injector
    call SuperGameBoyBorderInjector
    ret

; Border art adapted from Visions Of A Tree by orioto.
; https://www.deviantart.com/orioto/art/Vision-Of-A-Tree-1010165610
SECTION "SGB Bank - Border data - Map & palettes", ROMX[$5300], BANK[SGB_CODE_BANK]
_data_sgb_border_map:
;border map=2048 bytes
INCBIN "data/sgb/sgb_border_map.bin"    ;rows 0-27
DS 32 * 2 * 4                           ;rows 28-31: unused, row 28 should be blank to avoid strange scanline flickering when fading in/out border
;border palettes=32 bytes (1 pal), 64 bytes (2 pals), 96 bytes (3 pals), 128 bytes (4 pals, bad results in emulators)
INCBIN "data/sgb/sgb_border_palettes.bin"

SECTION "SGB Bank - Border data - Tiles", ROMX[$5c00], BANK[SGB_CODE_BANK]
_data_sgb_border_tiles:
INCBIN "data/sgb/sgb_border_tiles.bin"
