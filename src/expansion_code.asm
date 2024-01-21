;; A new bank for additional code.

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"

SECTION "bank11", ROMX[$4000], BANK[$11]

;@call_to_bank_jumptable
entryPointTableBankExpansion:
    call_to_bank_target drawHPOnStatusBar
    call_to_bank_target drawManaOnStatusBar
    call_to_bank_target drawMoneyOnStatusBar_new
    call_to_bank_target enhancedLetterbox
    call_to_bank_target scanRoomForNpcPlacementOptions

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
    ld   HL, gfxNumbersBottomLeftAligned
    pop  AF ; grab digit
    swap A
    push BC
    ld   B, $00
    ld   C, A
    add  HL, BC
    ld   B, $10
    call copyHLtoDE.loop
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

gfxNumbersBottomLeftAligned:
INCBIN "numbers_bottom_left_aligned.bin"

drawMoneyOnStatusBar_new:
    ld   DE, $12 ; Tile position of last number        ;; 02:6f55 $11 $12 $00
    ld   B, $06 ; Tiles back to clear                  ;; 02:6f59 $06 $06

.clearStatusBarSection:
    ld   A, $7f                                        ;; 02:6f6b $3e $7f
    push DE                                            ;; 02:6f6d $d5
    call storeTileAatWindowPositionDE                  ;; 02:6f6e $cd $66 $38
    pop  DE                                            ;; 02:6f71 $d1
    dec  DE                                            ;; 02:6f72 $1b
    dec  B                                             ;; 02:6f73 $05
    jr   NZ, .clearStatusBarSection                    ;; 02:6f74 $20 $f5
    
    ld   A, [wMoneyHigh]                               ;; 02:6f5f $fa $bf $d7
    ld   D, A
    ld   A, [wMoneyLow]                                ;; 02:6f63 $fa $be $d7
    ld   E, A
    ld   HL, $0b ; Draw location from left to right

; drawNumberAndSymbolOnStatusBar:
    push HL
    ld   C, $00
    ld   A, [wStatusEffect]
    rla
    jr   NC, .do_bcd_conversion
    inc  C
.do_bcd_conversion:
    ld   HL, wSRAMSaveHeader._1
    push HL
    call convertToUnpackedBCD
    pop  HL
    ld   C, $08
    pop  DE
.find_first_digit:
    ld   A, [HL+]
    dec  C
    inc  DE
    jr   Z, .store_number_in_window
    and  A, A
    jr   Z, .find_first_digit
.store_number_in_window:
    dec  HL
    dec  HL
    inc  C
    inc  C
    dec  DE
    dec  DE
    ld   [HL], $f5 ; Lucre symbol tile
.store_number_loop:
    ld   A, [HL+]
    push HL
    push DE
    call storeTileAatWindowPositionDE
    pop  DE
    pop  HL
    inc  DE
    dec  C
    jr   NZ, .store_number_loop
    ret

; Make a list of all possible NPC placement options in y=[02,0c] and x=[02,10]
; Input A = spawning NPC collision flags
scanRoomForNpcPlacementOptions:

    ; Save collision bit check information based on NPC spawn type into B
    ; This remapping is done to save time and space later
    and A, $07
    cp A, $01
    jr Z, .land
    cp A, $05
    jr Z, .water
    ld B, $00 ; simply signifies not water or land
    jr .typing_done
.water:
    ld B, $80 ; water top tile bit checked from LSB of metatile attributes
    jr .typing_done
.land:
    ld B, $20 ; land top tile bit checked from LSB of metatile attributes
.typing_done:

    ; Get player position in DE
    call getPlayerNearestTilePosition

    ; Store the player position in HRAM scratch space for easy access
    ; This may be overwritten by the last position placement option,
    ; but if that happens this data will no longer be necessary.
    ld HL, hScratch
    ld A, D
    ld [HL+], A
    ld [HL], E
    ld E, B

    ; Backup stack pointer, stack operations will be used to speed up processing
    ld [wStackPointerBackupLow], SP

    ; Disable interrupts and load in the scratch location
    ; into the stack pointer for fast writes.
    ; Start the stack pointer at the end of the buffer.
    di
    ld SP, wSpawnPlacementScratch+331

    ; Load pointer to appropriate starting point in metatile attribute cache.
    ; There are 8x10 (rows by columns) metatiles on screen, but only the inner
    ; 6x8 are considered for potential spawn locations. So set the array to:
    ; 2 bytes per metatile * (6 rows * 10 columns + 8 columns) + 1 for MSB = 137
    ld HL, wMetatileAttributeCache+137

    ; B = starting row to check (1 metatile up from the bottom)
    ; C = 0 to speed up assumptions in loop instructions
    ld BC, $0c00

.loop_outer:
    ; Loop over each relevant metatile row.

    ; D is used for processing flags throughout the procedure.
    ; The bit flags are described below
    ; Bits 3/4 and 6/7 are intentionally duplicated for speed improvements
    ;
    ; bit 0: current metatile bottom half clear
    ; bit 1: current metatile top half clear
    ; bit 2: bottom position passed y prox check
    ; bit 3: top position passed y prox check
    ; bit 4: rightward metatile bottom half clear
    ; bit 5: rightward metatile top half clear
    ; bit 6: bottom position passed y prox check
    ; bit 7: top position passed y prox check
    ld D, C ; Reset flags. C guaranteed to be 0 at this point

    ; Load player y position into C
    ldh A, [hScratch]
    ld C, A

    ; Do proximity checks in y direction
.start_y_prox_check:
    ld A, C
    sub A, B ; subtract candidate placement y position from player y position
    bit 7, A ; check for carry or if player position was FF (8px off top edge)
    jr Z, .verify_y_distance
    cpl ; complement then increment to turn a negative number positive
    inc  A
.verify_y_distance:
    cp A, $04
    bit 0, B ; currently considering a placement at the top of the tile? 
    ; NOTE: bit command does not affect the carry flag from the previous cp
    jr Z, .check_above ; this is the bottom of the tile, branch logic
    jr C, .y_prox_check_complete ; too close, end the proximity check
    set 3, D ; top placement position is sufficiently distant from the player
    jr .y_prox_check_complete
.check_above:
    dec B ; check one position placement position higher next
    jr C, .start_y_prox_check ; too close, loop the proximity check
    set 2, D ; bottom placement position is sufficiently distant from the player
    jr .start_y_prox_check ; restart loop
.y_prox_check_complete:
    inc B ; reset B from the y proximity check

    ; Set both top and bottom nibble to have the same y proximity flags
    ld A, D
    swap A
    or A, D
    ld D, A

    ld C, $10 ; starting x metatile position on the right

.loop_inner:
    ; Loop over each relevant metatile in the current row.
    ; For each metatile, we analyze its collision flags then check
    ; 4 potential placement positions in the following order:
    ; -- bottom left (spawn sprite is centered on the metatile)
    ; -- top left (spawn sprite is 8px offset up from the metatile)
    ; -- bottom right (spawn sprite is 8px offset right from the metatile)
    ; -- top right (spawn sprite is 8px offset up & right from the metatile)

    ; Analyze the metatile collision flags and set algorithm flags accordingly
    ; - Land:  The metatile bottom/top halves are separately considered, but if
    ;          either is blocked, then spawns cannot be horizontally centered
    ; - Water: The metatile bottom/top halves are separately considered
    ; - Air:   The whole metatile is either clear or blocked
    ld A, E ; Load tile type
    and A, A
    jr NZ, .land_water_collision_check
    ld A, [HL-] ; air metatiles check the upper byte of the attributes
    and A, $04 ; check if metatile is clear for air units
    jr Z, .finish_collision_check
    set 1, D ; top half clear
    inc D ; bottom half clear, faster than set 0, D
    jr .finish_collision_check
.land_water_collision_check:
    dec HL ; land/water metatiles check the lower byte of the attributes
    and A, [HL] ; check if top is clear
    jr Z, .check_bottom ; if not, skip to the bottom
    set 1, D ; top half clear
.check_bottom:
    ld A, E
    rrca
    and A, [HL] ; check if bottom is clear
    jr Z, .finish_collision_check
    inc D ; bottom half clear, faster than set 0, D
.finish_collision_check:
    dec HL ; move metatile attr pointer down for next loop iteration

    ; Passed the collision test, now check for proximity to player.
    ; NPC cannot be placed within 4 tile positions of the player.
    ; Given sprites are 2 tiles wide, this translate to requiring
    ; NPCs to be at least 1 metatile apart from the player.
    ld A, D
    and A, $03
    jr Z, .positions_blocked ; all metatile positions blocked

    ; Check if only the top/bottom of a land tile is set
    ; If so, the center of the tile is blocked
    cp A, $03
    jr NC, .proximity_test ; both top/bottom are open, proceed as normal
    bit 5, E ; signifies land tile
    jr NZ, .prepare_for_right_column ; land tile, skip to the right x position
.proximity_test:
    bit 0, D ; is the section of tile collision free?
    jr Z, .check_next ; if not, go to the next position
    bit 2, D ; is this position already over a metatile away in the y direction?
    jr NZ, .write_spawn_placement_option ; yes, shortcut checking x-direction
    ldh A, [hScratch+1] ; load player x position
    sub A, C ; subtract candidate placement x position from player x position
    bit 7, A ; check for carry or if player position was FF (8px off left edge)
    jr Z, .verify_x_distance ; if so, skip ahead
    cpl ; complement then increment to turn a negative number positive
    inc  A
.verify_x_distance:
    cp A, $04
    jr C, .check_next ; too close, try next position
.write_spawn_placement_option:
    push BC ; all tests passed, use the SP to write to wSpawnPlacementScratch
.check_next:
    bit 0, B ; currently considering a placement at the top of the tile?
    jr NZ, .continue_x ; if so, see if we can move right next
    dec B ; otherwise move to considering top of tile
    rrc D ; roll flags to the right to consider the top section in the loop
    ld A, B
    dec A
    jr Z, .continue_x ; if this is y position 1, skip it by original design
    jr .proximity_test ; start over at new y position
.continue_x:
    bit 0, C ; currently considering a placement on the right side of the tile?
    jr NZ, .complete_check ; if so, we're already done
    ; Otherwise, roll back B and D to their original state
    inc B
    rlc D
.prepare_for_right_column:
    inc C ; move to the right side of the tile
    ld A, D
    swap D ; now swap D flag nibbles
    or A, $f0
    and A, D ; and the two metatiles' collision results
    ; This code also moves this inner_loop's collision results into the upper
    ; nibble for the next iteration of inner_loop to use
    ld D, A
    jr .proximity_test ; start over at new x position
.complete_check:
    ; Roll back B, C, and D to original positions
    inc B
    dec C
    rlc D
    jr .finish_proximity_check
.positions_blocked:
    ; In this case, just ensure collision results are stored in the
    ; upper nibble of D for the next iteration of inner_loop
    swap D
.finish_proximity_check:

    ; Reset current metatile collision flags for next loop iteration
    res 0, D
    res 1, D

    ; Move left by two (since we consider spawn positions in quads)
    dec C
    dec C
    jr NZ, .loop_inner

    ; Move up by two (since we consider spawn positions in quads)
    dec B
    dec B
    jr Z, .all_done

    ; Reduce metatile attr pointer by 4 to move to the next row above
    ld A, L
    sub A, $04
    ld L, A
    jp NC, .loop_outer
    dec H
    jp .loop_outer

.all_done:

    ; Store ending stack pointer into DE
    ld HL, SP+0
    ld D, H
    ld E, L

    ; Restore stack pointer and reenable interrupts
    ld HL, wStackPointerBackupLow
    ld A, [HL+]
    ld H, [HL]
    ld L, A
    ld SP, HL
    ei

    ; Determine number of bytes written via SP
    ld HL, wSpawnPlacementScratch+331
    call sub_HL_DE

    ; Divide by two, this is the number of possible positions (max 165)
    ld A, L
    rr H
    rra
    ld [wSpawnPlacementScratch], A ; store result in first byte of buffer

    ret

; This provides a replacement letterbox routine which blacks the border on SGB
INCLUDE "code/sgb.asm"
