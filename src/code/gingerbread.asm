; This is from https://github.com/ahrnbom/gingerbread
; With modifications for speed.

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
    ; C - Used for fast access to the SGB communication port
    ; E - Total number of bytes to send
    ; D - Number of bits sent of current byte

    ld c, LOW(SGB_OUT_ADDRESS)

    ; Each packet should send 16 bytes
    ld e, 16

    ; Prepare SGB for listening
    ld a, SGB_SEND_RESET
    ldh [c], a

    ld a, SGB_SEND_NULL
    ldh [c], a

SGBSendByte:
    xor a
    ld d, a

    ld a, [hl+]
    ld b, a

SGBSendBit:
    bit 0, b
    jr z, SGBSendZeroBit

    ; Send a ONE bit here
    ld a, SGB_SEND_ONE
    ldh [c], a
    jr SGBSendBitEnd

SGBSendZeroBit:
    ld a, SGB_SEND_ZERO
    ldh [c], a

SGBSendBitEnd:
    ; Both P14 and P15 should be HIGH in between sent bits
    ld a, SGB_SEND_NULL
    ldh [c], a

    sra b

    inc d
    ld a, d
    cp 8
    jr nz, SGBSendBit

    dec e
    jr nz, SGBSendByte

; Send final stop bit
    ld a, SGB_SEND_ZERO
    ldh [c], a

    ld a, SGB_SEND_NULL
    ldh [c], a

    ei
    ret
