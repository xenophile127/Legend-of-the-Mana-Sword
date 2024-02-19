; Read buttons and dpad.
; Return: a = pressed buttons
; Return: b = newly pressed buttons
; Return: c = pressed buttons (copy)
updateJoypadInput:
    ld hl, rP1
    ld [hl], P1F_GET_BTN
    ld a, [hl]
    ld a, [hl]
    ld [hl], P1F_GET_DPAD
; If A, B, Start, and Select are all pressed, then reset the game.
    and $0f
; This handles a special case for Super Game Boy.
    jp z, enhancedWarmBoot_trampoline
    swap a
    ld c, a
; Read buttons eight times to stabilizie their states. 
; This was originally a loop but other games unroll it, and it only takes two additional bytes.
    ld a, [hl]
    ld a, [hl]
    ld a, [hl]
    ld a, [hl]
    ld a, [hl]
    ld a, [hl]
    ld a, [hl]
    ld a, [hl]
    ld [hl], P1F_GET_NONE
    and $0f
    or a, c
    cpl
; wJoypadInput is only used right here to determine which buttons are newly pressed.
    ld hl, wJoypadInput
    ld c, a
    ld a, [hl]
    xor c
    and c
    ld b, a
    ld a, c
    ld [hl], a
    ret
