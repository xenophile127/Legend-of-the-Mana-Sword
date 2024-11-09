; Debug logging functions that use self modifying RAM code to save space.
; A BGB/No$GBA style log is located in RAM and helper functions replace the message pointer.

; There are helper functions for each register pair.
; These helpers don't strictly need to be in RAM but otherwise they would take space in bank 0.

; Calling logger directly repeats the last message logged.

copy_logger_to_ram:
    ld hl, logger_ram_code
    ld de, logger
    ld b, logger.end - logger
    jp copyHLtoDE

logger_ram_code:
LOAD "RAM code", WRAM0

logger:
    ld d, d
    jr .return
    dw $6464
    dw $0001
.addr:
    dw debugMsgBuildDate
    dw BANK(debugMsgBuildDate)
.return:
    ret

.bc:
    push af
    ld a, c
    ld [.addr], a
    ld a, b
    ld [.addr+1], a
    pop af
    jr logger

.de:
    push af
    ld a, e
    ld [.addr], a
    ld a, d
    ld [.addr+1], a
    pop af
    jr logger

.hl:
    push af
    ld a, l
    ld [.addr], a
    ld a, h
    ld [.addr+1], a
    pop af
    jr logger

.end:
ENDL

