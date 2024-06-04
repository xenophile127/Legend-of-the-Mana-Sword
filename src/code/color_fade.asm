; a = component value (0 to 31).
; c = 0 to 11.
; Return a = a * (11-c)/11, carry reset.
fadeBlackComponent:
    push de
    push hl
    ld b, $00
    ld hl, .fadeBlackFactors
    add hl, bc
    add hl, bc
    ld e, [hl]
    inc hl
    ld d, [hl]
    call MultiplyDE_by_A
    ld a, h
    pop hl
    pop de
    ret

; Instead of both a multiply and a divide, pre calculate multiply factor * 256 and take the high byte.
.fadeBlackFactors:
FOR n, 12
dw ((11 - n) << 8) / 11
ENDR

; Return a value between the given color and black.
; c = fade step
; hl = address of the 16-bit little-endian color.
; Return: bc = color in big-endian. a = color low byte.
fadeBlackColor:
; First load the color. Loaded as big-endian.
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
; Start with blue and green since they are one shift closer to being in individual bytes.
    ld a, e
    sra d
    rra
    sra d
    rra
; Green times eight is now in a, and blue is in d.
    call fadeBlackComponent ; green * 8
; Low bits need to be masked off after a multiply.
    and $f8
; Load blue from d, and store the processed green in its place.
    ld b, a
    ld a, d
    ld d, b
    call fadeBlackComponent ; blue
; Create the final high byte in a, with d containing the lower three bits of green.
    sla d
    rla
    sla d
    rla
; Load red from e and store the finished high byte in its place.
    ld b, a
    ld a, e
    ld e, b
; High bits need to be masked off befoer a multiply.
    and $1f
    call fadeBlackComponent ; red
; Combine red with the lower three bits of green.
    or d
; Return the color in big-endian in bc.
    ld b, e
    ld c, a
    ret

; a = component value (0 to 31).
; c = 0 to 11.
; Return a = a + (31 - a) * c / 11, carry reset.
fadeWhiteComponent:
    push de
    push hl
    ld b, $00
    ld hl, .fadeWhiteFactors
    add hl, bc
    add hl, bc
    ld e, [hl]
    inc hl
    ld d, [hl]
    ldh [hScratch], a
    cpl
    add $1f + 1
    call MultiplyDE_by_A
    ldh a, [hScratch]
    add h
    pop hl
    pop de
    ret

; Instead of both a multiply and a divide, pre calculate multiply factor * 256 and take the high byte.
; For fade to white the math is component + (31 - component) * factor
; The factor in this table is 256 * n / 11
.fadeWhiteFactors:
FOR n, 12
dw (n << 8) / 11
ENDR

; Return a value between the given color and white.
; c = fade step
; hl = address of the 16-bit little-endian color.
; Return: bc = color in big-endian. a = color low byte.
fadeWhiteColor:
; First load the color. Loaded as big-endian.
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
; Start with blue and green since they are one shift closer to being in individual bytes.
    ld a, e
    sra d
    rra
    sra d
    rra
; Green times eight is now in a, and blue is in d.
; Unlike black fades, due to the addition shifted values cannot be used.
    rra
    rra
    rra
    and $1f
    call fadeWhiteComponent ; green
    add a
    add a
    add a
; Load blue from d, and store the processed green in its place.
    ld b, a
    ld a, d
    ld d, b
    call fadeWhiteComponent ; blue
; Create the final high byte in a, with d containing the lower three bits of green.
    sla d
    rla
    sla d
    rla
; Load red from e and store the finished high byte in its place.
    ld b, a
    ld a, e
    ld e, b
; High bits need to be masked off befoer a multiply.
    and $1f
    call fadeWhiteComponent ; red
; Combine red with the lower three bits of green.
    or d
; Return the color in big-endian in bc.
    ld b, e
    ld c, a
    ret
