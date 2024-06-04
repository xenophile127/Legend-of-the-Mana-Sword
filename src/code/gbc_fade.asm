; Handles fading back in from either black or white.
gbcFadeToNormal:
; Each step is held for multiple frames.
    ld a, [wScriptOpCounter2]
    or a
    ret nz
; The primary script counter is used as the main fade control.
    ld a, [wScriptOpCounter]
; Run the fade-to-black effect backwards. Complement and increment, then add the number of items in the array (minus one).
    cpl
    add $0a + 1 ; Fold the increment into the addition.
    ld c, a
    ld a, [wLastFade]
    or a
    jr z, fadeWhite
    jr fadeBlack

; Fade to black.
gbcFadeToBlack:
; Each step is held for multiple frames.
    ld a, [wScriptOpCounter2]
    or a
    ret nz
; The primary script counter is used as the main fade control.
    ld a, [wScriptOpCounter]
    ld c, a
; The first fade step is full brightness so it can be skipped.
    inc c

; Handles fading all BGP and all OBJ palettes between full brightness and black.
; c = fade step from 0 to 11.
fadeBlack:
    push hl
    ld de, wPaletteBackgroundActive
    ld hl, wPaletteBackgroundNormal
    ld b, $20
.loop_bgp:
    push bc
    push de
    call fadeBlackColor
    pop de
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    pop bc
    dec b
    jr nz, .loop_bgp
    ld de, wPaletteObjectActive
    ld hl, wPaletteObjectNormal
    ld b, $20
.loop_obj:
    push bc
    push de
    call fadeBlackColor
    pop de
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    pop bc
    dec b
    jr nz, .loop_obj
; Tell the VBlank handler to set palettes.
    ld a, $01
    ld [hPalettesDirty], a
    pop hl
    ret

; Fade to white.
gbcFadeToWhite:
; The primary script counter is used as the main fade control.
    ld a, [wScriptOpCounter2]
    or a
    ret nz
; The primary script counter is used as the main fade control.
    ld a, [wScriptOpCounter]
    ld c, a
; The first fade step is full brightness so it can be skipped.
    inc c

; Handles fading all BGP and all OBJ palettes between full brightness and black.
; c = fade step from 0 to 11.
fadeWhite:
    push hl
    ld de, wPaletteBackgroundActive
    ld hl, wPaletteBackgroundNormal
    ld b, $20
.loop_bgp:
    push bc
    push de
    call fadeWhiteColor
    pop de
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    pop bc
    dec b
    jr nz, .loop_bgp
    ld de, wPaletteObjectActive
    ld hl, wPaletteObjectNormal
    ld b, $20
.loop_obj:
    push bc
    push de
    call fadeWhiteColor
    pop de
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    pop bc
    dec b
    jr nz, .loop_obj
; Tell the VBlank handler to set palettes.
    ld a, $01
    ld [hPalettesDirty], a
    pop hl
    ret
