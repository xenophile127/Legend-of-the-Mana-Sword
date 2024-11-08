; Debug logging functions that use self modifying RAM code to save space.
; A BGB/No$GBA style log is located in RAM and helper functions replace the message pointer.

; There are helper functions for each register pair.
; These helpers don't strictly need to be in RAM but otherwise they would take space in bank 0.

copy_ram_code:
    ld hl, debug_ram_code
    ld de, logger
    ld b, logger.end - logger
    jp copyHLtoDE

debug_ram_code:
LOAD "RAM code", WRAM0

logger:
.bc:
    push af
    ld a, c
    ld [.addr], a
    ld a, b
    ld [.addr+1], a
    pop af
    jr ._log

.de:
    push af
    ld a, e
    ld [.addr], a
    ld a, d
    ld [.addr+1], a
    pop af
    jr ._log

.hl:
    push af
    ld a, l
    ld [.addr], a
    ld a, h
    ld [.addr+1], a
    pop af
; Fall through to _log

._log:
    ld d, d
    jr .return
    dw $6464
    dw $0001
.addr:
    dw debugMsgBuildDate
    dw BANK(debugMsgBuildDate)
.return:
    ret
.end:
ENDL

