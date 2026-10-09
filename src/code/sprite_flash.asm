; HL = shadow OAM address of the sprite's y position.
spriteShuffleShowSprite:
    push AF                                            ;; 02:44b1 $f5
    push DE                                            ;; 02:44b2 $d5
    push HL                                            ;; 02:44b3 $e5
    srl  L                                             ;; 02:44b4 $cb $3d
    srl  L                                             ;; 02:44b6 $cb $3d
    ld   H, $00                                        ;; 02:44b8 $26 $00
    ld   DE, wHiddenSpritesYPositions                   ;; 02:44ba $11 $a2 $c4
    add  HL, DE                                        ;; 02:44bd $19
    ld   A, [HL]                                       ;; 02:44be $7e
    pop  HL                                            ;; 02:44bf $e1
    ld   [HL], A                                       ;; 02:44c0 $77
    pop  DE                                            ;; 02:44c1 $d1
    pop  AF                                            ;; 02:44c2 $f1
    ret                                                ;; 02:44c3 $c9

; Sprites hidden by the shuffling routine are moved to y=$ce so any sprites with that y value should be restored.
spriteShuffleShowHidden:
    ld   HL, wOAMBuffer                                ;; 02:44c4 $21 $00 $c0
    ld   B, OAM_COUNT                                  ;; 02:44c7 $06 $28
    ld   A, $ce                                        ;; 02:44c9 $3e $ce
    ld   DE, sizeof_OAM_ATTRS                          ;; 02:44cb $11 $04 $00
.loop:
    cp   A, [HL]                                       ;; 02:44ce $be
    call Z, spriteShuffleShowSprite                    ;; 02:44cf $cc $b1 $44
    add  HL, DE                                        ;; 02:44d2 $19
    dec  B                                             ;; 02:44d3 $05
    jr   NZ, .loop                                     ;; 02:44d4 $20 $f8
    ret                                                ;; 02:44d6 $c9

; Hides a sprite and saves its previous y position.
; If it is the first sprite hidden this frame then the address is saved.
; This allows giving hidden sprites preferential treatment next frame.
; C = sprite shadow OAM address low.
spriteShuffleHideSprite:
    ld   A, [wSpriteShuffleHiddenSpriteAddressLow]     ;; 02:44d7 $fa $a0 $c4
    cp   A, $ff                                        ;; 02:44da $fe $ff
    jr   NZ, .hide                                     ;; 02:44dc $20 $04
    ld   A, C                                          ;; 02:44de $79
    ld   [wSpriteShuffleHiddenSpriteAddressLow], A     ;; 02:44df $ea $a0 $c4
.hide:
    ld   L, C                                          ;; 02:44e3 $69
    ld   H, HIGH(wOAMBuffer)                           ;; 02:44e4 $26 $c0
    ld   A, [HL]                                       ;; 02:44e6 $7e
; This can be called up to three times for a sprite so return if it has already been hidden.
    cp   A, SCRN_Y + $10                               ;; 02:44e7 $fe $a0
    ret nc
    ld   [HL], $ce                                     ;; 02:44eb $36 $ce
    srl  L                                             ;; 02:44ed $cb $3d
    srl  L                                             ;; 02:44ef $cb $3d
    ld   H, $00                                        ;; 02:44f1 $26 $00
    ld   DE, wHiddenSpritesYPositions                   ;; 02:44f3 $11 $a2 $c4
    add  HL, DE                                        ;; 02:44f6 $19
    ld   [HL], A                                       ;; 02:44f7 $77
    ret                                                ;; 02:44f9 $c9

ds 3 ; Free space

; Tests the screen in eight pixel sections for more than ten sprites.
; A sprite that is not aligned to a vertical multiple of eight is treated as if it is 24 pixels tall.
; Testing starts at the first sprite hidden last frame (if any) to give previously hidden sprites priority.
; If half an object is hidden by a window then this could end up hiding half of fully visible objects.
spriteShuffleDoFlash:
    ld   HL, wSpriteShuffleScratch                     ;; 02:44fa $21 $80 $c4
    ld   B, SCRN_Y_B + $02                             ;; 02:44fd $06 $14
    ld   A, $00                                        ;; 02:44ff $3e $00
.loop_clear_scratch:
    ld   [HL+], A                                      ;; 02:4501 $22
    dec  B                                             ;; 02:4502 $05
    jr   NZ, .loop_clear_scratch                       ;; 02:4503 $20 $fc
    ld   A, [wSpriteShuffleHiddenSpriteAddressLow]     ;; 02:4505 $fa $a0 $c4
    ld l, a
    ld   A, $ff                                        ;; 02:4509 $3e $ff
    ld   [wSpriteShuffleHiddenSpriteAddressLow], A     ;; 02:450b $ea $a0 $c4
    ld   B, OAM_COUNT                                  ;; 02:4510 $06 $28
    ld h, HIGH(wOAMBuffer)
.loop:
    ld   A, [HL]                                       ;; 02:4513 $7e
; Test if this sprite is already hidden (y position is zero or greater than 159) and if so skip it.
    or   A, A                                          ;; 02:4514 $b7
    jr   Z, .next                                      ;; 02:4515 $28 $35
    cp   A, SCRN_Y + $10                               ;; 02:4517 $fe $a0
    jr   NC, .next                                     ;; 02:4519 $30 $31
    push hl
; Push the sprite y position.
    ld   C, A                                          ;; 02:451b $4f
    push BC                                            ;; 02:451c $c5
    ld   C, L                                          ;; 02:451d $4d
; Divide the sprite y position by eight.
    and $f8
    rra
    rra
    rra
    ld   L, A                                          ;; 02:4524 $6f
    ld   H, $00                                        ;; 02:4525 $26 $00
    ld   DE, wSpriteShuffleScratch                     ;; 02:4527 $11 $80 $c4
    add  HL, DE                                        ;; 02:452a $19
; Add to the count of one eight pixel section and hide the sprite if more than ten have been recorded.
    inc [hl]
    ld a, [hl+]
    cp   A, $0b                                        ;; 02:452e $fe $0b
    push hl
    call NC, spriteShuffleHideSprite                   ;; 02:4530 $d4 $d7 $44
    pop hl
; Add to the count of the next eight pixel section and hide the sprite if more than ten have been recorded.
    inc [hl]
    ld a, [hl+]
    cp   A, $0b                                        ;; 02:4536 $fe $0b
    push hl
    call NC, spriteShuffleHideSprite                   ;; 02:4538 $d4 $d7 $44
    pop hl
; Pop the sprite y position.
    pop  DE                                            ;; 02:453b $d1
    ld   A, E                                          ;; 02:453c $7b
; If not aligned to the eight pixel grid, then test a third eight pixel section.
    and  A, $07                                        ;; 02:453f $e6 $07
    jr   Z, .done                                      ;; 02:4541 $28 $08
    inc [hl]
    ld a, [hl]
    cp   A, $0b                                        ;; 02:4546 $fe $0b
    call NC, spriteShuffleHideSprite                   ;; 02:4548 $d4 $d7 $44
.done:
    pop hl
.next:
    ld   A, sizeof_OAM_ATTRS                           ;; 02:454c $3e $04
    add l
; This loop starts with the first hidden sprite from last frame but wraps around to test all 40 sprites.
    cp   A, OAM_COUNT * sizeof_OAM_ATTRS               ;; 02:454f $fe $a0
    jr   C, .jr_02_4555                                ;; 02:4551 $38 $02
    xor a
.jr_02_4555:
    ld l, a
    dec  B                                             ;; 02:4558 $05
    jr   NZ, .loop                                     ;; 02:4559 $20 $b7
    ld   A, [wSpriteShuffleHiddenSpriteAddressLow]     ;; 02:455b $fa $a0 $c4
    cp   A, $ff                                        ;; 02:455e $fe $ff
    ret  NZ                                            ;; 02:4560 $c0
    ld   A, $00                                        ;; 02:4561 $3e $00
    ld   [wSpriteShuffleHiddenSpriteAddressLow], A     ;; 02:4563 $ea $a0 $c4
    ret                                                ;; 02:4566 $c9