;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"

SECTION "bank11", ROMX[$4000], BANK[$11]

;@call_to_bank_jumptable
entryPointTableBankExpansion:
    call_to_bank_target expansion_test
    call_to_bank_target drawHPOnStatusBar
    call_to_bank_target drawManaOnStatusBar

expansion_test:
    ret

drawHPOnStatusBar:
    ld   C, $13 ; Mode/Max-digits to write
    ld   DE, wHPMPTileBuffer ; WRAM address
    ld   A, [wHPLow]
    ld   L, A
    ld   A, [wHPHigh]
    ld   H, A
    call drawLeftAlignedNumberInWRAM
    ld   B, $a0 ; Starting tile position
    jp   requestVRAMStatusBarTransfer

drawManaOnStatusBar:
    ld   C, $02 ; Mode/Max-digits to write
    ld   DE, wHPMPTileBuffer+$40 ; WRAM address
    ld   A, [wManaLow]
    ld   L, A
    ld   A, [wManaHigh]
    ld   H, A
    call drawLeftAlignedNumberInWRAM
    ld   B, $e0 ; Starting tile position
    jp   requestVRAMStatusBarTransfer

; Draws left aligned number HL as modified tiles at WRAM position DE
; C holds the drawing mode in the first nibble (0 for shift, 1 for shift/swap)
; C holds number of max digits in the second nibble
drawLeftAlignedNumberInWRAM:
    ld   B, $00 ; digit counter
    ; Housekeeping, get a copy of proper WRAM starting
    ;  location on the stack for later use
    push DE
    push BC

    ; Load up the digits on the stack
.divmod_and_store_number:
    ld   A, $0a
    push BC
    push DE
    call divMod
    pop  DE
    pop  BC
    push AF
    inc  B
    ld   A, H
    or   A, L
    jr   NZ, .divmod_and_store_number

    ; Reduce second nibble of C by num digits found
    ; Remainder provides the number of tiles to clear
    ; after we write the digits
    ld   A, C
    sub  A, B
    ld   C, A

    ; Stack holds B digits to pop, transfer them
 .grab_digit_and_transfer:
    ld   HL, gfxStatusBar+$100 ; start of number tiles
    pop  AF ; grab digit
    swap A
    push BC
    ld   B, $00
    ld   C, A
    add  HL, BC
    ld   A, BANK(gfxStatusBar)
    ld   B, $10
    call copyAndRotateBankAfromHLtoDE
    pop  BC
    dec  B
    jr   NZ, .grab_digit_and_transfer

    ; Clear remaining tiles
    ld   A, C
    and  A, $10 ; add a tile for swap mode
    swap A
    add  A, C
    and  A, $0f
    jr   Z, .check_swap

    ld   H, D
    ld   L, E
    ld   B, A
    xor  A, A
 .clear_remaining_tiles:
    ld   [HL+], A
    ld   [HL+], A
    ld   [HL+], A
    ld   [HL+], A
    ld   [HL+], A
    ld   [HL+], A
    ld   [HL+], A
    ld   [HL+], A
    ld   [HL+], A
    ld   [HL+], A
    ld   [HL+], A
    ld   [HL+], A
    ld   [HL+], A
    ld   [HL+], A
    ld   [HL+], A
    ld   [HL+], A
    dec  B
    jr   NZ, .clear_remaining_tiles

    ; Shifted tiles are in WRAM, check if swap needed
 .check_swap:
    ld   L, C
    pop  BC
    bit  4, C
    jr   NZ, .do_the_swap
    pop  DE
    ret

.do_the_swap: ; Swap forward across tilea
    push BC
    ld   A, C
    sub  A, L
    ld   B, A ; B holds number of tiles to swap
    call swapForwardHalfTiles
    pop  BC
    pop  DE
    ret

; Swaps tiles forward across half tile boundaries.
; B holds number of tiles to shift
; DE holds address of first byte after last digit tile
swapForwardHalfTiles:
    swap B ; now B holds number of bytes to swap
    dec  DE ; go to last byte of last digit
    ld   HL, $0010
    add  HL, DE ;HL points to last byte of next tile

; Shifts tiles 4 pixels to the right across
; tile boundaries. DE points to last byte of
; last digit, HL points to last byte of next
; empty tile
.shift_4px: ; loop is 21 cycles/16 bytes
    ; First "or" in the last 4 bits of the
    ; previous tile byte into the current
    ; tile byte
    ld   A, [DE]
    swap A
    ld   C, A
    and  A, $f0
    or   A, [HL]
    ld   [HL-], A
    ; Now shift down the last 4 bits of the
    ; previous tile byte
    ld   A, C
    and  A, $0f
    ld   [DE], A
    dec  DE
    dec  B
    jr   NZ, .shift_4px
    ret

; Requests transfer of status bar WRAM tiles to VRAM
; B holds VRAM tile position
; C holds the drawing mode in the first nibble (0 for shift, 1 for shift/swap)
; C holds number of max digits in the second nibble
; DE holds the WRAM address
requestVRAMStatusBarTransfer:
    ; Short circuit if nothing to do, else load number of tiles in C
    ; This logic adds one to max digits if mode is shift-swap
    ld   A, C
    and  A, $10
    swap A
    add  A, C
    and  A, $0f
    ret  Z
    ld   C, A

    ; Prep source and destination addresses
    ld   H, D
    ld   L, E
    ld   D, $90
    ld   E, B
    xor  A, A
.request_loop:
    push BC
    push HL
    push DE
    call addTileGraphicCopyRequest
    ld   BC, $0010
    pop  HL
    add  HL, BC
    ld   D, H
    ld   E, L
    pop  HL
    add  HL, BC
    pop  BC
    dec  C
    jr   NZ, .request_loop
    ret

