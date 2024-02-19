; Each frame this animates one of the tile animation types
animateTiles:
    ld   A, [wTileAnimationCounter]                    ;; 02:4074 $fa $99 $d3
    and  A, $0f                                        ;; 02:4077 $e6 $0f
    ld   HL, .tileAnimationJumptable                   ;; 02:4079 $21 $84 $40
    call callJumptable                                 ;; 02:407c $cd $70 $2b
    ld   HL, wTileAnimationCounter                     ;; 02:407f $21 $99 $d3
    inc  [HL]                                          ;; 02:4082 $34
    ret                                                ;; 02:4083 $c9
;@jumptable amount=16
.tileAnimationJumptable:
    dw   animateTilesTwoframe                          ;; 02:4084 pP $00
    dw   animateTilesTwoframe                          ;; 02:4086 pP $01
    dw   animateTilesWaterfall                         ;; 02:4088 pP $02
    dw   animateTilesReverseWaterfall                  ;; 02:408a pP $03
    dw   animateTilesOcean                             ;; 02:408c pP $04
    dw   animateTilesOcean                             ;; 02:408e pP $05
    dw   animateTileRiver                              ;; 02:4090 pP $06
    dw   animateTilesNop                               ;; 02:4092 pP $07
    dw   animateTilesIncrementCounter                  ;; 02:4094 pP $08
    dw   animateTilesIncrementCounter                  ;; 02:4096 ?? $09
    dw   animateTilesWaterfall                         ;; 02:4098 pP $0a
    dw   animateTilesReverseWaterfall                  ;; 02:409a pP $0b
    dw   animateTilesOcean                             ;; 02:409c pP $0c
    dw   animateTilesOcean                             ;; 02:409e pP $0d
    dw   animateTileRiver                              ;; 02:40a0 pP $0e
    dw   animateTilesNop                               ;; 02:40a2 pP $0f

animateTilesTwoframe_TileCopy:
    ld   B, $04                                        ;; 02:40a9 $06 $04
.loop:
    push DE                                            ;; 02:40ab $d5
    ld   A, [DE]                                       ;; 02:40ac $1a
    or a
    jr   Z, .jr_02_40bf                                ;; 02:40af $28 $0e
    push BC                                            ;; 02:40b1 $c5
    push HL                                            ;; 02:40b2 $e5
    ld   HL, -256 ;@=value signed=True                 ;; 02:40b3 $21 $00 $ff
    add  HL, DE                                        ;; 02:40b6 $19
    ld   A, [HL]                                       ;; 02:40b7 $7e
    pop  BC                                            ;; 02:40b8 $c1
    push BC                                            ;; 02:40b9 $c5
    ld l, a
    ld  a, BANK(tilesets)
    bit 7, b
    jr z, .requestTileCopy
    dec a
    res 7, b
    set 6, b
.requestTileCopy:
    call requestBackgroundTileCopy.withBank
    pop  HL                                            ;; 02:40bd $e1
    pop  BC                                            ;; 02:40be $c1
.jr_02_40bf:
    ld   DE, $10                                       ;; 02:40bf $11 $10 $00
    add  HL, DE                                        ;; 02:40c2 $19
    pop  DE                                            ;; 02:40c3 $d1
    inc  DE                                            ;; 02:40c4 $13
    dec  B                                             ;; 02:40c5 $05
    jr   NZ, .loop                                     ;; 02:40c6 $20 $e3

animateTilesNop:
    ret                                                ;; 02:40c8 $c9

; Used for the lava and the sparkly damage tiles
animateTilesTwoframe:
    ld   A, [wTileAnimationCounter]                    ;; 02:40c9 $fa $99 $d3
    ld   C, A                                          ;; 02:40cc $4f
    and  A, $30                                        ;; 02:40cd $e6 $30
    ret  NZ                                            ;; 02:40cf $c0
    ld   A, C                                          ;; 02:40d0 $79
    and  A, $01                                        ;; 02:40d1 $e6 $01
    jr   NZ, .secondFrame                              ;; 02:40d3 $20 $18
    ld   DE, wBackgroundGraphicsTileState              ;; 02:40d5 $11 $70 $d1
    ld   A, [wMapGraphicsPointer.High]                 ;; 02:40d8 $fa $91 $d3
    ld   H, A                                          ;; 02:40db $67
    ld   A, [wMapGraphicsPointer]                      ;; 02:40dc $fa $90 $d3
    ld   L, A                                          ;; 02:40df $6f
    ld   A, C                                          ;; 02:40e0 $79
    and  A, $40                                        ;; 02:40e1 $e6 $40
    jr Z, .jr_02_4101
    jr .adjust

; Empty
    db $00, $09

.secondFrame:
    ld   DE, wBackgroundGraphicsTileState._04          ;; 02:40ed $11 $74 $d1
    ld   A, [wMapGraphicsPointer.High]                 ;; 02:40f0 $fa $91 $d3
    ld   H, A                                          ;; 02:40f3 $67
    ld   A, [wMapGraphicsPointer]                      ;; 02:40f4 $fa $90 $d3
    ld   L, A                                          ;; 02:40f7 $6f
    ld   A, C                                          ;; 02:40f8 $79
    and  A, $40                                        ;; 02:40f9 $e6 $40
    jr   NZ, .jr_02_4101                               ;; 02:40fb $20 $04
.adjust:
    ld   BC, $40                                       ;; 02:40fd $01 $40 $00
    add  HL, BC                                        ;; 02:4100 $09
.jr_02_4101:
    jr animateTilesTwoframe_TileCopy

animateTilesWaterfall:
    ld   A, [wBackgroundGraphicsTileState._08]         ;; 02:4105 $fa $78 $d1
    cp   A, $00                                        ;; 02:4108 $fe $00
    ret  Z                                             ;; 02:410a $c8
    ld   A, [wBackgroundGraphicsTileMapping._08]       ;; 02:410b $fa $78 $d0
    ld   HL, wAnimatedTileWaterfall1                   ;; 02:410e $21 $f0 $d2
    call animateTileDown                               ;; 02:4111 $cd $1e $41
    ld   A, [wBackgroundGraphicsTileMapping._09]       ;; 02:4114 $fa $79 $d0
    ld   HL, wAnimatedTileWaterfall2                   ;; 02:4117 $21 $00 $d3
    call animateTileDown                               ;; 02:411a $cd $1e $41
    ret                                                ;; 02:411d $c9

animateTileDown:
    push AF                                            ;; 02:411e $f5
    push HL                                            ;; 02:411f $e5
    ld   DE, wAnimatedTileScratchpad                   ;; 02:4120 $11 $80 $d3
    ld   B, $10                                        ;; 02:4123 $06 $10
    call copyHLtoDE                                    ;; 02:4125 $cd $49 $2b
    pop  DE                                            ;; 02:4128 $d1
    push DE                                            ;; 02:4129 $d5
    inc  DE                                            ;; 02:412a $13
    inc  DE                                            ;; 02:412b $13
    ld   HL, wAnimatedTileScratchpad                   ;; 02:412c $21 $80 $d3
    ld   B, $0e                                        ;; 02:412f $06 $0e
    call copyHLtoDE                                    ;; 02:4131 $cd $49 $2b
    pop  HL                                            ;; 02:4134 $e1
    push HL                                            ;; 02:4135 $e5
    ld   A, [wAnimatedTileScratchpad._0F]              ;; 02:4136 $fa $8f $d3
    ld   D, A                                          ;; 02:4139 $57
    ld   A, [wAnimatedTileScratchpad._0E]              ;; 02:413a $fa $8e $d3
    ld   E, A                                          ;; 02:413d $5f
    ld   [HL], E                                       ;; 02:413e $73
    inc  HL                                            ;; 02:413f $23
    ld   [HL], D                                       ;; 02:4140 $72
    pop  BC                                            ;; 02:4141 $c1
    pop  AF                                            ;; 02:4142 $f1
    call requestBackgroundTileCopy                     ;; 02:4143 $cd $fe $41
    ret                                                ;; 02:4146 $c9

animateTilesReverseWaterfall:
    ld   A, [wBackgroundGraphicsTileState._0A]         ;; 02:4147 $fa $7a $d1
    cp   A, $00                                        ;; 02:414a $fe $00
    ret  Z                                             ;; 02:414c $c8
    ld   A, [wBackgroundGraphicsTileMapping._0A]       ;; 02:414d $fa $7a $d0
    ld   HL, wAnimatedTileWaterfallReversed1           ;; 02:4150 $21 $10 $d3
    call animateTileUp                                 ;; 02:4153 $cd $60 $41
    ld   A, [wBackgroundGraphicsTileMapping._0B]       ;; 02:4156 $fa $7b $d0
    ld   HL, wAnimatedTileWaterfallReversed2           ;; 02:4159 $21 $20 $d3
    call animateTileUp                                 ;; 02:415c $cd $60 $41
    ret                                                ;; 02:415f $c9

animateTileUp:
    push AF                                            ;; 02:4160 $f5
    push HL                                            ;; 02:4161 $e5
    inc  HL                                            ;; 02:4162 $23
    inc  HL                                            ;; 02:4163 $23
    ld   DE, wAnimatedTileScratchpad                   ;; 02:4164 $11 $80 $d3
    ld   B, $0e                                        ;; 02:4167 $06 $0e
    call copyHLtoDE                                    ;; 02:4169 $cd $49 $2b
    pop  HL                                            ;; 02:416c $e1
    push HL                                            ;; 02:416d $e5
    ld   E, [HL]                                       ;; 02:416e $5e
    inc  HL                                            ;; 02:416f $23
    ld   D, [HL]                                       ;; 02:4170 $56
    ld   A, D                                          ;; 02:4171 $7a
    ld   [wAnimatedTileScratchpad._0F], A              ;; 02:4172 $ea $8f $d3
    ld   A, E                                          ;; 02:4175 $7b
    ld   [wAnimatedTileScratchpad._0E], A              ;; 02:4176 $ea $8e $d3
    pop  DE                                            ;; 02:4179 $d1
    push DE                                            ;; 02:417a $d5
    ld   HL, wAnimatedTileScratchpad                   ;; 02:417b $21 $80 $d3
    ld   B, $10                                        ;; 02:417e $06 $10
    call copyHLtoDE                                    ;; 02:4180 $cd $49 $2b
    pop  BC                                            ;; 02:4183 $c1
    pop  AF                                            ;; 02:4184 $f1
    call requestBackgroundTileCopy                     ;; 02:4185 $cd $fe $41
    ret                                                ;; 02:4188 $c9

animateTilesOcean:
    ld   A, [wTileAnimationCounter]                    ;; 02:4189 $fa $99 $d3
    and  A, $01                                        ;; 02:418c $e6 $01
    jr   NZ, .bottomTiles                              ;; 02:418e $20 $1f
    ld   A, [wBackgroundGraphicsTileState._0C]         ;; 02:4190 $fa $7c $d1
    cp   A, $00                                        ;; 02:4193 $fe $00
    ret  Z                                             ;; 02:4195 $c8
    ld   HL, wAnimatedTileOcean1                       ;; 02:4196 $21 $30 $d3
    call animateTilesRight                             ;; 02:4199 $cd $e9 $41
    ld   A, [wBackgroundGraphicsTileMapping._0C]       ;; 02:419c $fa $7c $d0
    ld   BC, wAnimatedTileOcean1                       ;; 02:419f $01 $30 $d3
    call requestBackgroundTileCopy                     ;; 02:41a2 $cd $fe $41
    ld   A, [wBackgroundGraphicsTileMapping._0D]       ;; 02:41a5 $fa $7d $d0
    ld   BC, wAnimatedTileOcean2                       ;; 02:41a8 $01 $40 $d3
    call requestBackgroundTileCopy                     ;; 02:41ab $cd $fe $41
    ret                                                ;; 02:41ae $c9
.bottomTiles:
    ld   A, [wBackgroundGraphicsTileState._0E]         ;; 02:41af $fa $7e $d1
    cp   A, $00                                        ;; 02:41b2 $fe $00
    ret  Z                                             ;; 02:41b4 $c8
    ld   HL, wAnimatedTileOcean3                       ;; 02:41b5 $21 $50 $d3
    call animateTilesRight                             ;; 02:41b8 $cd $e9 $41
    ld   A, [wBackgroundGraphicsTileMapping._0E]       ;; 02:41bb $fa $7e $d0
    ld   BC, wAnimatedTileOcean3                       ;; 02:41be $01 $50 $d3
    call requestBackgroundTileCopy                     ;; 02:41c1 $cd $fe $41
    ld   A, [wBackgroundGraphicsTileMapping._0F]       ;; 02:41c4 $fa $7f $d0
    ld   BC, wAnimatedTileOcean4                       ;; 02:41c7 $01 $60 $d3
    call requestBackgroundTileCopy                     ;; 02:41ca $cd $fe $41
    ret                                                ;; 02:41cd $c9

; Check if we need to animate the river  tile, and scroll it 1 pixel.
animateTileRiver:
    ld   A, [wBackgroundGraphicsTileState._10]         ;; 02:41ce $fa $80 $d1
    cp   A, $00                                        ;; 02:41d1 $fe $00
    ret  Z                                             ;; 02:41d3 $c8
    ld   HL, wAnimatedTileRiver                        ;; 02:41d4 $21 $70 $d3
    ld   B, $10                                        ;; 02:41d7 $06 $10
.loop:
    rrc  [HL]                                          ;; 02:41d9 $cb $0e
    inc  HL                                            ;; 02:41db $23
    dec  B                                             ;; 02:41dc $05
    jr   NZ, .loop                                     ;; 02:41dd $20 $fa
    ld   A, [wBackgroundGraphicsTileMapping._10]       ;; 02:41df $fa $80 $d0
    ld   BC, wAnimatedTileRiver                        ;; 02:41e2 $01 $70 $d3
    jp requestBackgroundTileCopy

animateTilesRight:
    ld   D, H                                          ;; 02:41e9 $54
    ld   E, L                                          ;; 02:41ea $5d
    ld   B, $10                                        ;; 02:41eb $06 $10
.loop:
    ld   A, [DE]                                       ;; 02:41ed $1a
    ld   C, A                                          ;; 02:41ee $4f
    ld   HL, $10                                       ;; 02:41ef $21 $10 $00
    add  HL, DE                                        ;; 02:41f2 $19
    srl  C                                             ;; 02:41f3 $cb $39
    rr   [HL]                                          ;; 02:41f5 $cb $1e
    rra                                                ;; 02:41f7 $1f
    ld   [DE], A                                       ;; 02:41f8 $12
    inc  DE                                            ;; 02:41f9 $13
    dec  B                                             ;; 02:41fa $05
    jr   NZ, .loop                                     ;; 02:41fb $20 $f0
    ret                                                ;; 02:41fd $c9

; Request to copy a background graphic tile from bank $0C into VRAM
; A: VRAM target tile number
; BC: source graphics address
requestBackgroundTileCopy:
    ld   L, A                                          ;; 02:41fe $6f
    ld   a, BANK(tilesets)
.withBank:
    push af
    ld   H, $00                                        ;; 02:41ff $26 $00
    add  HL, HL                                        ;; 02:4201 $29
    add  HL, HL                                        ;; 02:4202 $29
    add  HL, HL                                        ;; 02:4203 $29
    add  HL, HL                                        ;; 02:4204 $29
    ld   DE, _VRAM8000 ;@=ptr _VRAM8000                ;; 02:4205 $11 $00 $80
    add  HL, DE                                        ;; 02:4208 $19
    ld   D, H                                          ;; 02:4209 $54
    ld   E, L                                          ;; 02:420a $5d
    ld   H, B                                          ;; 02:420b $60
    ld   L, C                                          ;; 02:420c $69
    pop af
    jp addTileGraphicCopyRequest

animateTilesIncrementCounter:
    ld   HL, wTileAnimationCounter                     ;; 02:4213 $21 $99 $d3
    inc  [HL]                                          ;; 02:4216 $34
    ret                                                ;; 02:4217 $c9