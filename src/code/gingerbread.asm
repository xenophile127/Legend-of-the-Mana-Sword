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

; hl = address of the packet
; This uses hl instead of c for writes which is a cycle faster and allows using a for the working byte.
; That means it is a little faster than the common version in licenced software.
; Commonly available documentation says data and reset pulses are kept low for 5 microseconds,
; and then to leave P14 and P15 high for at least 15 microseconds afterwards.
; The common packet transfer routine keeps data and reset pulses low for 4 cycles,
; and P14 and P15 high for at least 15 cycles.
; This code preserves the 4 cycle timing for data and reset pulses (with nops),
; but holds P14 and P15 high for as little as 12 cycles. That is, three times the duration for data and reset pulses.
SGBSendData:
    ; Register use:
    ; a - byte currently being sent
    ; bc - address of the byte being sent
    ; hl - SGB communications port address
    ; e - Total number of bytes to send
    ; d - Number of bits sent of current byte

    ; There are only sixteen bytes to be loaded from memory and 260 to write so use hl for writes.
    ld b, h
    ld c, l
    ld hl, SGB_OUT_ADDRESS

    ; Disable interrupts
    di

    ; Prepare SGB for listening
    ld [hl], SGB_SEND_RESET
    nop

    ld [hl], SGB_SEND_NULL

    ; Each packet should send 16 bytes. This is located here in place of a nop.
    ld e, 16

SGBSendByte:
    ld d, 8

    ld a, [bc]
    inc bc

SGBSendBit:
    ; Rotate the next bit into the carry flag
    rra
    jr nc, SGBSendZeroBit

    ; Send a ONE bit here
    ld [hl], SGB_SEND_ONE
    jr SGBSendBitEnd

SGBSendZeroBit:
    ld [hl], SGB_SEND_ZERO
    nop

SGBSendBitEnd:
    ; Both P14 and P15 should be HIGH in between sent bits
    ld [hl], SGB_SEND_NULL
    nop
    nop

    dec d
    jr nz, SGBSendBit

    dec e
    jr nz, SGBSendByte

; Send final stop bit
    ld [hl], SGB_SEND_ZERO
    nop

    ld [hl], SGB_SEND_NULL

    ei
    ret
