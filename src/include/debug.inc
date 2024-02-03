; Useful for printing messages to the BGB debugger
; For format details, see https://bgb.bircd.org/manual.html#expressions
; You can enable logging to debugmsg.txt in BGB settings
; Remember to add INCLUDE "include/debug.inc" to the top of your asm file

; Helper macro for getting strings in ASCII
MACRO DBG_STR
    PUSHC
    SETCHARMAP main
    db \1
    POPC
    ENDM

; Simple debug macro that accepts a string as input
;
; Example:
;
;   DBG_MSG "Here is register A:%A%"
;
MACRO DBG_MSG
IF DEF(DEBUG)
    ld d, d
    jr .end\@
    DW $6464
    DW $0000
    DBG_STR \1
.end\@:
    ENDC
    ENDM

; Accepts a label as input (even from another bank)
; You need to use the DBG_STR macro instead of db to make the string.
; This will ensure the string is encoded in ASCII.
;
; Example:
;
; ... Somewhere you have space ...
;
; myDebugMsg:
;   DBG_STR "Stuff: %($FF44)% %DE%"
;
; ... Somewhere else in your code...
;
;   DBG_MSG_LABEL myDebugMsg
;
MACRO DBG_MSG_LABEL
IF DEF(DEBUG)
    ld d, d
    jr .end\@
    DW $6464
    DW $0001
    DW \1
    DW BANK(\1)
.end\@:
    ENDC
    ENDM
