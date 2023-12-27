; This is from https://github.com/ahrnbom/gingerbread

; This is free and unencumbered software released into the public domain.

; Anyone is free to copy, modify, publish, use, compile, sell, or
; distribute this software, either in source code form or as a compiled
; binary, for any purpose, commercial or non-commercial, and by any
; means.

; In jurisdictions that recognize copyright laws, the author or authors
; of this software dedicate any and all copyright interest in the
; software to the public domain. We make this dedication for the benefit
; of the public at large and to the detriment of our heirs and
; successors. We intend this dedication to be an overt act of
; relinquishment in perpetuity of all present and future rights to this
; software under copyright law.

; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
; IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
; OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
; ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
; OTHER DEALINGS IN THE SOFTWARE.

; For more information, please refer to <http://unlicense.org>

SGB_OUT_ADDRESS EQU $FF00

SGB_SEND_ZERO   EQU %00100000
SGB_SEND_ONE    EQU %00010000
SGB_SEND_RESET  EQU %00000000
SGB_SEND_NULL   EQU %00110000

; Input: HL - address to first byte to send
SGBSendData:
    di
    ; Register use:
    ; B - Byte currently sending
    ; C - Total number of bytes to send
    ; D - Number of bits sent of current byte

    ld a, [hl]
    ld b, a

    ; Each packet should send 16 bytes
    ld c, 16

    xor a
    ld d, a

    ; Prepare SGB for listening
    ld a, SGB_SEND_RESET
    ld [SGB_OUT_ADDRESS], a

    ld a, SGB_SEND_NULL
    ld [SGB_OUT_ADDRESS], a

SGBSendBit:
    inc d
    ld a, d
    cp 9
    jr z, SGBEndOfByte

    ld a, b
    and %00000001
    cp 0
    jr z, SGBSendZeroBit

    ; Send a ONE bit here
    ld a, SGB_SEND_ONE
    ld [SGB_OUT_ADDRESS], a
    jr SGBSendBitEnd

SGBSendZeroBit:
    ld a, SGB_SEND_ZERO
    ld [SGB_OUT_ADDRESS], a

SGBSendBitEnd:
    ; Both P14 and P15 should be HIGH in between sent bits
    ld a, SGB_SEND_NULL
    ld [SGB_OUT_ADDRESS], a

    ld a, b
    sra a
    and %01111111
    ld b, a

    jr SGBSendBit

SGBEndOfByte:
    dec c
    ld a, c
    cp 0
    jr z, SGBFinalEnd

    ; If there are still bytes to send, we get here
    inc hl
    ld a, [hl]
    ld b, a

    xor a
    ld d, a

    jr SGBSendBit

SGBFinalEnd:
    call SGBFinish
    ret

SGBFinish:
    ld a, SGB_SEND_ZERO
    ld [SGB_OUT_ADDRESS], a

    ld a, SGB_SEND_NULL
    ld [SGB_OUT_ADDRESS], a

    ei
    ret
