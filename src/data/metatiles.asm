; Exported by meMetatileImport.py from a Mystic Editor decode.
; Mystic Editor is available from:
; https://github.com/arathron123/mystic-editor

INCLUDE "include/bgp_attributes.inc"

; Each metatile is six bytes.
;  offset 0-3: Tile graphic indexes.
;  4-5: Behavior and collision info.
;  offset 4: Behavior when attacked, and land/water collision info:
;   bits 0-2: Behavior when attacked:
;    0: No effect.
;    1: Chain pole.
;    2: Mattock destructible.
;    3: Mattock to reveal stairs.
;    4: Axe tree with stump.
;    5: Axe tree without stump.
;    6: Sickle cut foliage.
;    7: Run script (used for the track switches in the Mithril Mine).
;   bit 3: Open door pieces.
;   bit 4-5:
;    0: Blocked to land objects (player and many NPCs).
;    1: Land, top blocked, bottom can be entered but the centerline is blocked.
;    2: Land, bottom blocked, top can be entered but the centerline is blocked.
;    3: Land, not blocked.
;   bit 6: Bottom is water.
;   bit 7: Top is water.
;   offset 5: Additional behavior and collision info.
;    bit 0: Passable to projectiles.
;    bit 1: Passable to objects with collision flags & $07 == $04, which seems unused.
;    bit 2: Passable to airborn NPCs.
;    bit 3: Face north (used for vines and chains).
;    bit 4-6: Spike damage, or slide direction.
;     0: No damage or slide
;     1: Spike damage equal to player level.
;     2: Spike damage equal to twice player level.
;     3: Spike damage equal to three times player level.
;     4: Slide east.
;     5: Slide west.
;     6: Slide north.
;     7: Slide south.
;    bit 7: Trigger a script when stepped on.
metatilesOutdoor:
    METATILE $2e, $2f, $2e, $2f, $30, $05                  ;; $00
    METATILE $2e, $2f, $9e, $9f, $00, $05                  ;; $01
    METATILE $b2, $3e, $36, $37, $28, $04                  ;; $02
    METATILE $2d, $3e, $36, $37, $28, $04                  ;; $03
    METATILE $3f, $2d, $44, $40, $20, $06                  ;; $04
    METATILE $2d, $2d, $2d, $2d, $30, $05, BGP_SAND        ;; $05
    METATILE $56, $2d, $57, $58, $20, $06                  ;; $06
    METATILE $6c, $6d, $10, $10, $c0, $07, BGP_SHORE, BGP_SHORE, BGP_RIVER, BGP_RIVER ;; $07
    METATILE $6e, $6f, $10, $71, $c0, $07, BGP_SHORE, BGP_SHORE, BGP_RIVER, BGP_SHORE ;; $08
    METATILE $db, $d4, $db, $d4, $00, $04                  ;; $09
    METATILE $d7, $dc, $d7, $dc, $00, $04                  ;; $0a
    METATILE $3a, $3b, $4c, $7e, $30, $0d                  ;; $0b
    METATILE $26, $26, $26, $26, $00, $05                  ;; $0c
    METATILE $f0, $f1, $f0, $f1, $00, $04                  ;; $0d
    METATILE $f2, $f3, $f2, $f3, $00, $04                  ;; $0e
    METATILE $e5, $e5, $e5, $e5, $00, $04                  ;; $0f
    METATILE $56, $b3, $57, $58, $20, $06                  ;; $10
    METATILE $0c, $0d, $0e, $0f, $c0, $07, BGP_OCEAN       ;; $11
    METATILE $b2, $59, $5a, $5b, $20, $02                  ;; $12
    METATILE $4a, $4b, $2d, $4d, $10, $04                  ;; $13
    METATILE $4e, $41, $55, $2d, $10, $04                  ;; $14
    METATILE $52, $53, $54, $2d, $10, $04                  ;; $15
    METATILE $72, $10, $74, $10, $c0, $07, BGP_SHORE, BGP_RIVER, BGP_SHORE, BGP_RIVER ;; $16
    METATILE $10, $10, $10, $10, $c0, $07, BGP_RIVER       ;; $17
    METATILE $10, $73, $10, $75, $c0, $07, BGP_RIVER, BGP_SHORE, BGP_RIVER, BGP_SHORE ;; $18
    METATILE $d3, $d4, $d5, $d6, $10, $04                  ;; $19
    METATILE $d7, $d8, $d9, $da, $10, $04                  ;; $1a
; Curved tower base tiles with stone pattern floor.
    METATILE $d3, $d4, $df, $d6, $10, $04                  ;; $1b
    METATILE $d7, $d8, $d9, $e0, $10, $04                  ;; $1c
    METATILE $f4, $f5, $f6, $f7, $10, $04                  ;; $1d
    METATILE $f8, $f9, $fa, $fb, $10, $04                  ;; $1e
    METATILE $e5, $e5, $e6, $e6, $00, $04                  ;; $1f
    METATILE $4a, $4b, $b3, $4d, $10, $04                  ;; $20
    METATILE $52, $53, $54, $b2, $10, $04                  ;; $21
    METATILE $3f, $b3, $44, $40, $20, $06                  ;; $22
    METATILE $2b, $2c, $48, $49, $00, $74                  ;; $23
    METATILE $32, $33, $34, $35, $30, $05                  ;; $24
    METATILE $25, $25, $25, $25, $30, $05                  ;; $25
    METATILE $76, $10, $78, $79, $c0, $07, BGP_SHORE, BGP_RIVER, BGP_SHORE, BGP_SHORE ;; $26
    METATILE $10, $10, $7a, $7b, $c0, $07, BGP_RIVER, BGP_RIVER, BGP_SHORE, BGP_SHORE ;; $27
    METATILE $10, $77, $7c, $7d, $c0, $07, BGP_RIVER, BGP_SHORE, BGP_SHORE, BGP_SHORE ;; $28
    METATILE $84, $85, $86, $87, $f0, $07, BGP_DOCK        ;; $29
    METATILE $2e, $3e, $36, $37, $28, $04                  ;; $2a
    METATILE $7f, $7f, $7f, $7f, $30, $05                  ;; $2b
    METATILE $ea, $ea, $ea, $eb, $30, $05                  ;; $2c
    METATILE $62, $63, $c4, $65, $30, $84                  ;; $2d
    METATILE $c2, $c3, $c4, $c5, $30, $84, BGP_DOOR        ;; $2e
    METATILE $cf, $d0, $d2, $d2, $00, $04                  ;; $2f
    METATILE $25, $3e, $36, $37, $28, $04                  ;; $30
    METATILE $38, $39, $44, $45, $00, $04                  ;; $31
    METATILE $4e, $41, $55, $b2, $10, $04                  ;; $32
    METATILE $56, $25, $57, $58, $20, $06                  ;; $33
    METATILE $25, $59, $5a, $5b, $20, $02                  ;; $34
    METATILE $2e, $59, $5a, $5b, $20, $02                  ;; $35
    METATILE $2d, $59, $5a, $5b, $20, $02                  ;; $36
    METATILE $96, $97, $98, $99, $04, $04, BGP_TREE        ;; $37
    METATILE $88, $89, $8b, $8c, $00, $05, BGP_SKY         ;; $38
    METATILE $89, $8a, $8c, $8d, $00, $05, BGP_SKY         ;; $39
    METATILE $8a, $b5, $8d, $8e, $00, $05, BGP_SKY         ;; $3a
    METATILE $1f, $7f, $1f, $7f, $30, $05                  ;; $3b
    METATILE $eb, $25, $25, $25, $30, $05                  ;; $3c
    METATILE $20, $de, $20, $dd, $30, $05                  ;; $3d
; Fancy parapet with sky.
    METATILE $b5, $b5, $cf, $d0, $20, $04, BGP_SKY, BGP_SKY, BGP_DEFAULT, BGP_DEFAULT ;; $3e
    METATILE $ea, $ea, $cf, $d0, $20, $04                  ;; $3f
    METATILE $3f, $25, $44, $40, $20, $06                  ;; $40
    METATILE $42, $43, $44, $45, $00, $04                  ;; $41
    METATILE $46, $47, $48, $49, $00, $04                  ;; $42
    METATILE $5c, $5d, $5e, $26, $00, $04                  ;; $43
    METATILE $5f, $60, $26, $61, $00, $04                  ;; $44
    METATILE $ae, $af, $b0, $b1, $06, $04                  ;; $45
    METATILE $aa, $ab, $ac, $ad, $00, $04, BGP_CRYSTAL     ;; $46
    METATILE $96, $97, $b4, $31, $20, $04, BGP_TREE, BGP_TREE, BGP_DEFAULT, BGP_DEFAULT ;; $47
    METATILE $b2, $b3, $b4, $31, $20, $04                  ;; $48
    METATILE $b2, $b3, $b3, $b2, $30, $05                  ;; $49
    METATILE $3f, $2f, $44, $40, $20, $06                  ;; $4a
    METATILE $4a, $4b, $2e, $4d, $10, $04                  ;; $4b
    METATILE $66, $67, $68, $69, $30, $85                  ;; $4c
    METATILE $62, $63, $64, $65, $30, $84                  ;; $4d
    METATILE $92, $93, $94, $95, $31, $04                  ;; $4e
    METATILE $1b, $1c, $1d, $1e, $31, $04                  ;; $4f
    METATILE $4a, $4b, $25, $4d, $10, $04                  ;; $50
    METATILE $4e, $4f, $50, $51, $00, $04                  ;; $51
    METATILE $52, $53, $54, $25, $10, $04                  ;; $52
    METATILE $4e, $41, $55, $25, $10, $04                  ;; $53
    METATILE $d1, $d1, $d2, $d2, $00, $04                  ;; $54
    METATILE $d1, $d1, $d1, $d1, $00, $04                  ;; $55
    METATILE $e7, $e8, $e7, $e8, $30, $05, BGP_BRIDGE      ;; $56
    METATILE $e8, $e9, $e8, $e9, $30, $05, BGP_BRIDGE      ;; $57
    METATILE $dd, $de, $de, $dd, $30, $05                  ;; $58
    METATILE $80, $81, $82, $83, $30, $85                  ;; $59
    METATILE $cf, $d0, $d2, $d2, $00, $04                  ;; $5a
    METATILE $08, $09, $08, $09, $00, $05, BGP_FALLS       ;; $5b
    METATILE $0a, $0b, $0a, $0b, $c0, $07, BGP_FALLS       ;; $5c
    METATILE $8c, $8d, $8e, $8f, $00, $04                  ;; $5d Unused?
    METATILE $90, $91, $90, $91, $00, $04                  ;; $5e
    METATILE $a0, $a1, $44, $45, $00, $04                  ;; $5f
    METATILE $35, $11, $12, $37, $20, $04                  ;; $60
    METATILE $13, $34, $44, $14, $20, $04                  ;; $61
    METATILE $15, $4b, $32, $16, $10, $04                  ;; $62
    METATILE $4e, $41, $55, $2f, $10, $04                  ;; $63
    METATILE $a0, $a1, $44, $45, $00, $04                  ;; $64
    METATILE $ea, $ea, $ea, $ea, $30, $05                  ;; $65
    METATILE $2e, $2f, $b4, $31, $20, $04                  ;; $66
    METATILE $b4, $31, $d2, $d2, $00, $00                  ;; $67
    METATILE $d1, $d1, $30, $31, $00, $04                  ;; $68
    METATILE $c6, $2f, $c7, $2f, $38, $05                  ;; $69
    METATILE $26, $26, $26, $26, $30, $85                  ;; $6a
    METATILE $7f, $7f, $7f, $7f, $30, $85                  ;; $6b
    METATILE $30, $31, $d1, $d1, $00, $04                  ;; $6c
    METATILE $10, $10, $b4, $31, $80, $04, BGP_RIVER, BGP_RIVER, BGP_DEFAULT, BGP_DEFAULT ;; $6d
    METATILE $c6, $2f, $c6, $2f, $30, $05                  ;; $6e
    METATILE $3a, $3b, $4c, $7e, $30, $8d                  ;; $6f
    METATILE $2e, $2f, $2e, $2f, $30, $85                  ;; $70
    METATILE $dd, $de, $de, $dd, $30, $85                  ;; $71
    METATILE $52, $53, $54, $2f, $10, $04                  ;; $72
    METATILE $cf, $d0, $26, $26, $00, $04                  ;; $73
    METATILE $08, $09, $08, $09, $f0, $87, BGP_FALLS       ;; $74
    METATILE $52, $19, $1a, $33, $10, $04                  ;; $75
    METATILE $56, $2f, $57, $58, $20, $06                  ;; $76
    METATILE $b5, $b5, $b5, $b5, $00, $05, BGP_SKY         ;; $77
    METATILE $08, $09, $08, $09, $f0, $07, BGP_FALLS       ;; $78
    METATILE $d1, $d1, $cf, $d0, $00, $04                  ;; $79
    METATILE $2d, $2d, $2d, $2d, $30, $85                  ;; $7a
    METATILE $1f, $7f, $1f, $7f, $30, $85                  ;; $7b
    METATILE $2e, $2f, $2e, $2f, $00, $05                  ;; $7c
    METATILE $88, $89, $8a, $8b, $f0, $87, BGP_SKY         ;; $7d
    METATILE $25, $25, $25, $25, $00, $05                  ;; $7e
    METATILE $96, $97, $98, $99, $05, $04, BGP_TREE        ;; $7f

metatilesTown:
    METATILE $70, $71, $70, $71, $30, $05                  ;; $00
    METATILE $70, $71, $fe, $ff, $00, $05                  ;; $01
    METATILE $3c, $25, $47, $3d, $20, $04                  ;; $02
    METATILE $f2, $f2, $f2, $f2, $30, $05                  ;; $03
    METATILE $56, $25, $57, $58, $20, $05                  ;; $04
    METATILE $25, $59, $5a, $5b, $20, $05                  ;; $05
    METATILE $27, $10, $10, $10, $00, $07, BGP_RIVER       ;; $06
    METATILE $10, $28, $10, $10, $00, $07, BGP_RIVER       ;; $07
    METATILE $1e, $1f, $1f, $1e, $30, $05                  ;; $08
    METATILE $08, $09, $08, $09, $30, $77, BGP_FALLS       ;; $09
    METATILE $74, $75, $76, $77, $00, $05                  ;; $0a
    METATILE $3a, $3b, $4c, $7e, $30, $0d                  ;; $0b
    METATILE $26, $26, $26, $26, $00, $05                  ;; $0c
    METATILE $25, $25, $25, $25, $30, $05                  ;; $0d
    METATILE $81, $82, $83, $c7, $00, $05                  ;; $0e
    METATILE $63, $64, $65, $66, $00, $05                  ;; $0f
    METATILE $3f, $25, $44, $40, $20, $05                  ;; $10
    METATILE $42, $43, $44, $45, $00, $04                  ;; $11
    METATILE $46, $47, $48, $49, $00, $04                  ;; $12
    METATILE $f3, $f2, $f3, $f2, $30, $05                  ;; $13
    METATILE $5c, $5d, $5e, $26, $00, $04                  ;; $14
    METATILE $5f, $60, $26, $61, $00, $04                  ;; $15
    METATILE $10, $10, $29, $10, $00, $07, BGP_RIVER       ;; $16
    METATILE $10, $10, $10, $2a, $00, $07, BGP_RIVER       ;; $17
    METATILE $22, $23, $24, $2b, $30, $05                  ;; $18
    METATILE $0a, $0b, $0a, $0b, $30, $77, BGP_FALLS       ;; $19
    METATILE $78, $79, $7a, $7b, $30, $05                  ;; $1a
    METATILE $96, $97, $98, $99, $30, $0d                  ;; $1b
    METATILE $34, $35, $c8, $c9, $04, $04, BGP_TREE        ;; $1c
    METATILE $7c, $7d, $7f, $80, $00, $05                  ;; $1d
    METATILE $c3, $c4, $c5, $c6, $00, $04                  ;; $1e
    METATILE $00, $01, $02, $03, $30, $05                  ;; $1f
    METATILE $4a, $4b, $25, $4d, $10, $04                  ;; $20
    METATILE $4e, $4f, $50, $51, $00, $04                  ;; $21
    METATILE $52, $53, $54, $25, $10, $04                  ;; $22
    METATILE $4e, $41, $55, $25, $10, $04                  ;; $23
    METATILE $f4, $f5, $f6, $f7, $30, $05, BGP_DOCK        ;; $24
    METATILE $cc, $cd, $ce, $cf, $30, $05                  ;; $25
    METATILE $d1, $d1, $d2, $d2, $00, $04                  ;; $26
    METATILE $d4, $d5, $d4, $d5, $00, $04                  ;; $27
    METATILE $ac, $ad, $b3, $b4, $00, $04                  ;; $28
    METATILE $ae, $ae, $ae, $ae, $30, $05                  ;; $29
    METATILE $b5, $b5, $b7, $b7, $00, $04                  ;; $2a
    METATILE $a8, $a9, $aa, $ab, $30, $0d, BGP_AIRSHIP     ;; $2b
    METATILE $a7, $d3, $93, $a7, $00, $04, BGP_AIRSHIP     ;; $2c
    METATILE $b9, $ba, $bb, $bc, $30, $05                  ;; $2d
    METATILE $af, $b0, $af, $b0, $00, $04                  ;; $2e
    METATILE $94, $b6, $94, $b6, $00, $05                  ;; $2f
    METATILE $9a, $9b, $94, $94, $00, $05                  ;; $30
    METATILE $9d, $9e, $9a, $9b, $20, $05                  ;; $31
    METATILE $93, $93, $9a, $9b, $20, $05                  ;; $32
    METATILE $d6, $d7, $d8, $d9, $30, $85                  ;; $33
    METATILE $de, $df, $e0, $e1, $30, $85                  ;; $34
    METATILE $6a, $6b, $6a, $6b, $00, $05                  ;; $35
    METATILE $ee, $ef, $f0, $f1, $00, $05                  ;; $36
    METATILE $15, $16, $17, $18, $30, $85, BGP_DOOR        ;; $37
    METATILE $da, $db, $dc, $dd, $30, $85                  ;; $38 Unused
    METATILE $6f, $6e, $6f, $6e, $00, $05                  ;; $39
    METATILE $6f, $6f, $6f, $6f, $00, $04                  ;; $3a
    METATILE $25, $3e, $36, $37, $20, $04                  ;; $3b
    METATILE $a6, $d3, $91, $a6, $00, $04, BGP_AIRSHIP     ;; $3c
    METATILE $ca, $ca, $cb, $cb, $30, $05                  ;; $3d Unused
    METATILE $af, $b0, $b1, $b2, $00, $04                  ;; $3e
    METATILE $a5, $94, $a5, $94, $00, $05                  ;; $3f
    METATILE $94, $94, $9a, $9b, $00, $05                  ;; $40
    METATILE $9c, $9b, $95, $95, $00, $05                  ;; $41
    METATILE $9c, $9b, $94, $94, $00, $05                  ;; $42
    METATILE $9d, $9e, $9f, $a0, $30, $05                  ;; $43
    METATILE $2e, $2f, $70, $71, $10, $05                  ;; $44
    METATILE $62, $6b, $72, $62, $00, $05                  ;; $45
    METATILE $6c, $6b, $6c, $6b, $00, $05                  ;; $46
    METATILE $6c, $6c, $6c, $6c, $00, $05                  ;; $47
    METATILE $6d, $6e, $6d, $6e, $00, $05                  ;; $48
    METATILE $6f, $6e, $6f, $e5, $00, $05                  ;; $49
    METATILE $6f, $e6, $e6, $e7, $00, $05                  ;; $4a
    METATILE $e3, $e4, $70, $71, $10, $05                  ;; $4b
    METATILE $26, $26, $26, $26, $30, $85                  ;; $4c
    METATILE $f8, $f9, $fa, $fb, $30, $85                  ;; $4d
    METATILE $bf, $c0, $c1, $c2, $30, $85                  ;; $4e
    METATILE $b9, $ba, $9c, $9b, $20, $05                  ;; $4f
    METATILE $94, $94, $94, $94, $00, $05                  ;; $50
    METATILE $94, $94, $95, $95, $00, $05                  ;; $51
    METATILE $a1, $a2, $a3, $a4, $00, $05                  ;; $52
    METATILE $8c, $8d, $8f, $90, $00, $75, BGP_SKY         ;; $53
    METATILE $8d, $8e, $90, $91, $00, $75, BGP_SKY         ;; $54
    METATILE $73, $86, $88, $89, $00, $05                  ;; $55
    METATILE $87, $62, $73, $86, $00, $05                  ;; $56
    METATILE $6c, $6c, $87, $bd, $00, $05                  ;; $57
    METATILE $6d, $e5, $be, $e8, $00, $05                  ;; $58
    METATILE $e6, $e8, $e9, $ea, $00, $05                  ;; $59
    METATILE $e9, $ea, $ec, $ed, $00, $05                  ;; $5a
    METATILE $84, $71, $84, $71, $30, $05                  ;; $5b
    METATILE $b8, $b8, $b8, $b8, $00, $04, BGP_AIRSHIP     ;; $5c
    METATILE $22, $23, $24, $2b, $30, $85                  ;; $5d
    METATILE $70, $71, $70, $71, $30, $85                  ;; $5e
    METATILE $84, $85, $70, $71, $30, $05                  ;; $5f
    METATILE $11, $12, $13, $14, $00, $04                  ;; $60
    METATILE $1c, $1c, $1d, $1d, $00, $04                  ;; $61
    METATILE $1d, $1d, $1d, $1d, $00, $04                  ;; $62
    METATILE $8e, $93, $91, $92, $00, $75, BGP_SKY         ;; $63
    METATILE $93, $93, $93, $93, $00, $75, BGP_SKY         ;; $64
    METATILE $8a, $8b, $70, $71, $10, $05                  ;; $65
    METATILE $88, $89, $8a, $8b, $00, $05                  ;; $66
    METATILE $73, $e2, $70, $71, $10, $05                  ;; $67
    METATILE $e2, $ea, $70, $71, $10, $05                  ;; $68
    METATILE $ec, $ed, $fc, $fd, $00, $05                  ;; $69
    METATILE $fc, $fd, $70, $71, $10, $05                  ;; $6a
    METATILE $84, $71, $85, $71, $30, $05                  ;; $6b
    METATILE $b9, $ba, $9c, $9b, $20, $05                  ;; $6c
    METATILE $38, $39, $44, $45, $00, $04                  ;; $6d
    METATILE $a8, $a9, $aa, $ab, $30, $85                  ;; $6e
    METATILE $84, $84, $70, $71, $30, $05                  ;; $6f
    METATILE $30, $2c, $32, $2d, $00, $04                  ;; $70
    METATILE $2c, $2c, $2d, $2d, $00, $04                  ;; $71
    METATILE $2c, $31, $2d, $33, $00, $04                  ;; $72
    METATILE $67, $67, $68, $68, $00, $04                  ;; $73
    METATILE $68, $68, $69, $69, $00, $04                  ;; $74
    METATILE $70, $71, $9c, $9b, $20, $05                  ;; $75
    METATILE $20, $23, $20, $2b, $30, $05                  ;; $76
    METATILE $20, $23, $21, $2b, $30, $05                  ;; $77
    METATILE $22, $23, $9c, $9b, $20, $05                  ;; $78
    METATILE $10, $10, $10, $10, $00, $07, BGP_RIVER       ;; $79
    METATILE $9d, $9e, $9c, $9b, $20, $05                  ;; $7a
    METATILE $d1, $d1, $d2, $d2, $30, $05                  ;; $7b
    METATILE $d4, $d5, $d4, $d5, $30, $05                  ;; $7c
    METATILE $1e, $1f, $1f, $1e, $30, $85                  ;; $7d
    METATILE $f3, $f2, $f3, $f2, $30, $85                  ;; $7e
    METATILE $3a, $3b, $4c, $7e, $30, $8d                  ;; $7f
; Expansion:
; Cliff edge with grass, used in Ifrit's antechamber.
    METATILE $70, $59, $5a, $5b, $20, $05                  ;; $80 ($05)
; Mountain corners with grass, used in Lich's arena.
    METATILE $3f, $71, $44, $40, $20, $05                  ;; $81 ($10)
    METATILE $4a, $4b, $70, $4d, $10, $04                  ;; $82 ($20)
    METATILE $52, $53, $54, $71, $10, $04                  ;; $83 ($22)
    METATILE $70, $3e, $36, $37, $20, $04                  ;; $84 ($3b)
; Parapet with shadowed grass, used in Wendel.
    METATILE $84, $71, $9c, $9b, $20, $05                  ;; $85 ($75)
; Parapet with shaddowed stone, used in Jadd.
    METATILE $20, $23, $9c, $9b, $20, $05                  ;; $86 ($78)
; Cliff edge with rubble, used at Mithril Mine's bridge .
    METATILE $56, $1f, $57, $58, $20, $05                  ;; $87 ($04)
    METATILE $1e, $59, $5a, $5b, $20, $05                  ;; $88 ($05)
; Mountain corners with rubble, used at Mithril Mine's bridge.
    METATILE $3f, $1f, $44, $40, $20, $05                  ;; $89 ($10)
    METATILE $4a, $4b, $1f, $4d, $10, $04                  ;; $8a ($20)
    METATILE $52, $53, $54, $1e, $10, $04                  ;; $8b ($22)
; Mountain with cloud, used in the outside area of Kary's cave.
    METATILE $3f, $d0, $44, $40, $20, $05, BGP_DEFAULT, BGP_SKY, BGP_DEFAULT, BGP_DEFAULT ;; $8c ($10)

metatilesIndoor:
    METATILE $1b, $1c, $1d, $1e, $30, $05                  ;; $00
    METATILE $e4, $e5, $b0, $b1, $00, $05                  ;; $01
    METATILE $13, $14, $15, $16, $30, $85                  ;; $02
    METATILE $1b, $2f, $1d, $3f, $08, $00                  ;; $03
    METATILE $21, $45, $47, $22, $00, $00                  ;; $04
    METATILE $21, $24, $33, $34, $00, $00                  ;; $05
    METATILE $20, $21, $30, $31, $00, $00                  ;; $06
    METATILE $10, $10, $10, $10, $c0, $07, BGP_RIVER       ;; $07
    METATILE $0c, $0d, $0e, $0f, $c0, $07, BGP_OCEAN       ;; $08
    METATILE $12, $12, $12, $12, $00, $05                  ;; $09
    METATILE $11, $11, $11, $11, $30, $05                  ;; $0a
    METATILE $c4, $c5, $c6, $c7, $00, $04                  ;; $0b
    METATILE $74, $75, $76, $77, $00, $04                  ;; $0c
    METATILE $84, $85, $86, $87, $30, $05                  ;; $0d
    METATILE $1b, $1c, $8c, $8d, $20, $04                  ;; $0e
    METATILE $92, $93, $94, $95, $00, $05                  ;; $0f
    METATILE $48, $25, $30, $49, $00, $00                  ;; $10
    METATILE $17, $18, $19, $1a, $30, $85                  ;; $11
    METATILE $50, $51, $60, $61, $00, $00                  ;; $12
    METATILE $52, $53, $62, $63, $00, $00                  ;; $13
    METATILE $2e, $1c, $3e, $1e, $08, $00                  ;; $14
    METATILE $26, $4f, $4e, $34, $00, $00                  ;; $15
    METATILE $9e, $9f, $a0, $a1, $00, $05                  ;; $16
    METATILE $a2, $a3, $a5, $a6, $00, $04                  ;; $17
    METATILE $a3, $a3, $a6, $a6, $00, $04                  ;; $18
    METATILE $a3, $a4, $a6, $a7, $00, $04                  ;; $19
    METATILE $9a, $9b, $9c, $9d, $02, $04                  ;; $1a
    METATILE $c8, $c9, $ca, $cb, $00, $04                  ;; $1b
    METATILE $80, $81, $82, $83, $00, $04                  ;; $1c
    METATILE $88, $89, $8a, $8b, $00, $05                  ;; $1d
    METATILE $8e, $8f, $90, $91, $30, $05                  ;; $1e
    METATILE $96, $97, $98, $99, $30, $05                  ;; $1f
    METATILE $2a, $2b, $1d, $1e, $08, $00                  ;; $20
    METATILE $5c, $5d, $6c, $6d, $00, $00                  ;; $21
    METATILE $00, $01, $02, $03, $30, $31                  ;; $22
    METATILE $04, $05, $06, $07, $30, $31                  ;; $23
    METATILE $58, $59, $68, $69, $00, $00                  ;; $24
    METATILE $28, $29, $1d, $1e, $08, $00                  ;; $25
    METATILE $a8, $a9, $aa, $ab, $00, $04                  ;; $26
    METATILE $ac, $ad, $ae, $af, $30, $21                  ;; $27
    METATILE $44, $21, $22, $46, $00, $00                  ;; $28
    METATILE $b4, $b5, $b6, $b7, $30, $85                  ;; $29
    METATILE $b2, $b2, $b3, $b3, $00, $00                  ;; $2a
    METATILE $9a, $9b, $9c, $9d, $03, $04                  ;; $2b
    METATILE $08, $09, $08, $09, $00, $05, BGP_FALLS       ;; $2c
    METATILE $0a, $0b, $0a, $0b, $00, $05, BGP_FALLS       ;; $2d
    METATILE $cc, $cd, $ce, $cf, $31, $05                  ;; $2e
    METATILE $d0, $d1, $d2, $d3, $30, $05                  ;; $2f
    METATILE $1b, $1c, $3a, $3b, $08, $00                  ;; $30
    METATILE $5e, $5f, $6e, $6f, $00, $00                  ;; $31
    METATILE $78, $79, $7a, $7b, $00, $04                  ;; $32
    METATILE $7c, $7d, $7e, $7f, $30, $95                  ;; $33
    METATILE $5a, $5b, $6a, $6b, $00, $00                  ;; $34
    METATILE $1b, $1c, $38, $39, $08, $00                  ;; $35
    METATILE $d4, $d4, $d4, $d4, $30, $05                  ;; $36
    METATILE $d5, $d6, $d7, $d8, $00, $04                  ;; $37
    METATILE $db, $dc, $dd, $de, $30, $05                  ;; $38
    METATILE $d9, $d9, $d9, $d9, $30, $05                  ;; $39
    METATILE $da, $da, $da, $da, $30, $05                  ;; $3a
    METATILE $e0, $e1, $e2, $e3, $04, $04, BGP_TREE        ;; $3b
    METATILE $e4, $e5, $e6, $e7, $30, $05                  ;; $3c
    METATILE $e8, $e9, $ea, $eb, $30, $05                  ;; $3d
    METATILE $d4, $d4, $8c, $8d, $20, $04                  ;; $3e
    METATILE $96, $97, $98, $99, $30, $85                  ;; $3f
    METATILE $30, $4b, $4a, $25, $00, $00                  ;; $40
    METATILE $70, $71, $72, $73, $30, $05                  ;; $41
    METATILE $54, $55, $64, $65, $00, $00                  ;; $42
    METATILE $56, $57, $66, $67, $00, $00                  ;; $43
    METATILE $c0, $c1, $c2, $c3, $00, $05, BGP_CASKET      ;; $44
    METATILE $4c, $34, $26, $4d, $00, $00                  ;; $45
    METATILE $ec, $ed, $ee, $ef, $00, $04                  ;; $46
    METATILE $12, $12, $12, $12, $30, $85                  ;; $47
    METATILE $f0, $f1, $f4, $f5, $30, $05                  ;; $48
    METATILE $f2, $f3, $f6, $f7, $30, $05                  ;; $49
    METATILE $1b, $1c, $1d, $1e, $30, $85                  ;; $4a
    METATILE $ff, $ff, $ff, $ff, $00, $00                  ;; $4b
    METATILE $ff, $ff, $ff, $ff, $00, $00                  ;; $4c
    METATILE $f8, $f9, $fc, $fd, $30, $05                  ;; $4d
    METATILE $fa, $fb, $fe, $ff, $30, $05                  ;; $4e
    METATILE $a3, $a3, $a6, $a6, $10, $04                  ;; $4f
    METATILE $30, $35, $27, $23, $00, $00                  ;; $50
    METATILE $32, $40, $42, $23, $00, $00                  ;; $51
    METATILE $2c, $1c, $3c, $1e, $08, $00                  ;; $52
    METATILE $1b, $2d, $1d, $3d, $08, $00                  ;; $53
    METATILE $41, $32, $23, $43, $00, $00                  ;; $54
    METATILE $36, $34, $23, $37, $00, $00                  ;; $55
    METATILE $1b, $78, $1d, $7a, $00, $04                  ;; $56
    METATILE $79, $1c, $7b, $1e, $00, $04                  ;; $57
    METATILE $f8, $f9, $fc, $fd, $30, $85                  ;; $58
    METATILE $fa, $fb, $fe, $ff, $30, $85                  ;; $59
    METATILE $d4, $8e, $d4, $90, $30, $05                  ;; $5a
    METATILE $8f, $d4, $91, $d4, $30, $05                  ;; $5b
    METATILE $d4, $d4, $d4, $8c, $20, $04                  ;; $5c
    METATILE $d4, $d4, $8d, $d4, $20, $04                  ;; $5d
    METATILE $e0, $e1, $e2, $e3, $05, $04                  ;; $5e
    METATILE $ff, $ff, $ff, $ff, $00, $00                  ;; $5f
    METATILE $32, $2c, $42, $3c, $00, $00                  ;; $60
    METATILE $2d, $32, $3d, $43, $00, $00                  ;; $61
    METATILE $a2, $a4, $a2, $a4, $00, $04                  ;; $62
    METATILE $bc, $bd, $be, $bf, $30, $03                  ;; $63
    METATILE $b8, $b9, $ba, $bb, $00, $01                  ;; $64
    METATILE $b4, $b5, $b6, $b7, $30, $05                  ;; $65
    METATILE $bc, $bd, $be, $bf, $30, $61                  ;; $66
    METATILE $bc, $bd, $be, $bf, $30, $71                  ;; $67
    METATILE $bc, $bd, $be, $bf, $30, $41                  ;; $68
    METATILE $bc, $bd, $be, $bf, $30, $51                  ;; $69
    METATILE $c0, $c1, $c2, $c3, $30, $05, BGP_CASKET      ;; $6a
    METATILE $1b, $1c, $1d, $1e, $00, $05                  ;; $6b
; Two new metatiles for a room in Castle Granz with a stairway behind a wall.
; This brings the wall out to a whole metatile border, which allows walking closer to it.
    METATILE $48, $25, $2a, $2b, $00, $00                  ;; $6c
    METATILE $26, $4f, $28, $29, $00, $00                  ;; $6d

metatilesCaves:
    METATILE $1b, $1c, $1d, $1e, $30, $05                  ;; $00
    METATILE $44, $21, $22, $46, $00, $00                  ;; $01
    METATILE $13, $14, $15, $16, $30, $85                  ;; $02
    METATILE $1b, $2f, $1d, $3f, $08, $00                  ;; $03
    METATILE $21, $45, $47, $22, $00, $00                  ;; $04
    METATILE $21, $24, $33, $34, $00, $00                  ;; $05
    METATILE $11, $11, $11, $11, $30, $05                  ;; $06
    METATILE $12, $12, $12, $12, $00, $05                  ;; $07
    METATILE $21, $2e, $46, $3e, $00, $00                  ;; $08
    METATILE $10, $10, $10, $10, $00, $07, BGP_RIVER       ;; $09
    METATILE $2f, $21, $3f, $47, $00, $00                  ;; $0a
    METATILE $0c, $0d, $0e, $0f, $c0, $05, BGP_OCEAN       ;; $0b
    METATILE $74, $75, $76, $77, $00, $05                  ;; $0c
    METATILE $84, $85, $86, $87, $30, $05                  ;; $0d
    METATILE $1b, $1c, $8c, $8d, $20, $04                  ;; $0e
    METATILE $92, $93, $94, $95, $00, $05                  ;; $0f
    METATILE $48, $25, $30, $49, $00, $00                  ;; $10
    METATILE $17, $18, $19, $1a, $30, $85                  ;; $11
    METATILE $50, $51, $60, $61, $00, $00                  ;; $12
    METATILE $52, $53, $62, $63, $00, $00                  ;; $13
    METATILE $2e, $1c, $3e, $1e, $08, $00                  ;; $14
    METATILE $26, $4f, $4e, $34, $00, $00                  ;; $15
    METATILE $20, $21, $30, $31, $00, $00                  ;; $16
    METATILE $30, $49, $2a, $2b, $00, $00                  ;; $17
; Bridge over water.
    METATILE $a8, $a9, $aa, $ab, $30, $05                  ;; $18
    METATILE $b0, $b1, $b2, $b3, $30, $05                  ;; $19
    METATILE $9e, $1f, $9f, $a0, $07, $04                  ;; $1a
    METATILE $4e, $34, $28, $29, $00, $00                  ;; $1b
    METATILE $80, $81, $82, $83, $00, $05                  ;; $1c
    METATILE $88, $89, $8a, $8b, $00, $04                  ;; $1d
    METATILE $8e, $8f, $90, $91, $30, $05                  ;; $1e
    METATILE $96, $97, $98, $99, $30, $05                  ;; $1f
    METATILE $2a, $2b, $1d, $1e, $08, $00                  ;; $20
    METATILE $5c, $5d, $6c, $6d, $00, $00                  ;; $21
    METATILE $00, $01, $02, $03, $30, $37                  ;; $22
    METATILE $04, $05, $06, $07, $30, $37                  ;; $23
    METATILE $58, $59, $68, $69, $00, $00                  ;; $24
    METATILE $28, $29, $1d, $1e, $08, $00                  ;; $25
    METATILE $08, $09, $08, $09, $00, $77, BGP_FALLS       ;; $26
    METATILE $0a, $0b, $0a, $0b, $00, $77, BGP_FALLS       ;; $27
    METATILE $ff, $ff, $ff, $ff, $30, $05                  ;; $28
    METATILE $b4, $b5, $b6, $b7, $30, $05                  ;; $29
    METATILE $9a, $9b, $9c, $9d, $02, $04                  ;; $2a
    METATILE $b8, $b9, $ba, $bb, $30, $05                  ;; $2b
    METATILE $bc, $bd, $be, $bf, $02, $05                  ;; $2c
    METATILE $a2, $a3, $a5, $a6, $00, $04                  ;; $2d
    METATILE $a3, $a3, $a6, $a6, $00, $04                  ;; $2e
    METATILE $a3, $a4, $a6, $a7, $00, $04                  ;; $2f
    METATILE $1b, $1c, $3a, $3b, $08, $00                  ;; $30
    METATILE $5e, $5f, $6e, $6f, $00, $00                  ;; $31
    METATILE $78, $79, $7a, $7b, $30, $05                  ;; $32
    METATILE $7c, $7d, $7e, $7f, $30, $85                  ;; $33
    METATILE $5a, $5b, $6a, $6b, $00, $00                  ;; $34
    METATILE $1b, $1c, $38, $39, $08, $00                  ;; $35
    METATILE $c4, $c5, $c4, $c5, $30, $05                  ;; $36
    METATILE $3a, $3b, $30, $4b, $00, $00                  ;; $37
    METATILE $c6, $c6, $c7, $c7, $30, $55                  ;; $38
    METATILE $c8, $c5, $c8, $c5, $30, $75                  ;; $39
    METATILE $c4, $c9, $c4, $c9, $30, $05                  ;; $3a
    METATILE $38, $39, $26, $4d, $00, $00                  ;; $3b
    METATILE $ca, $ca, $c7, $c7, $30, $05                  ;; $3c
    METATILE $c6, $c6, $d4, $d4, $30, $55                  ;; $3d
    METATILE $12, $12, $12, $12, $00, $85                  ;; $3e
    METATILE $1b, $1c, $1d, $1e, $30, $85                  ;; $3f
    METATILE $30, $4b, $4a, $25, $00, $00                  ;; $40
    METATILE $70, $71, $72, $73, $30, $01                  ;; $41
    METATILE $54, $55, $64, $65, $00, $00                  ;; $42
    METATILE $56, $57, $66, $67, $00, $00                  ;; $43
    METATILE $c0, $c1, $c2, $c3, $30, $05                  ;; $44
    METATILE $4c, $34, $26, $4d, $00, $00                  ;; $45
    METATILE $c6, $c6, $c7, $c7, $30, $d5                  ;; $46
    METATILE $d0, $d1, $d2, $d3, $06, $05                  ;; $47
    METATILE $40, $2c, $23, $3c, $00, $00                  ;; $48
    METATILE $da, $db, $dc, $dd, $30, $05                  ;; $49
    METATILE $2d, $32, $3d, $43, $00, $00                  ;; $4a
    METATILE $de, $df, $e0, $e1, $30, $55                  ;; $4b
    METATILE $e2, $e3, $e4, $e5, $30, $05                  ;; $4c
    METATILE $e6, $e7, $e8, $e9, $30, $05                  ;; $4d
    METATILE $ea, $eb, $ec, $ed, $30, $85                  ;; $4e
    METATILE $ee, $ef, $f0, $f1, $00, $04                  ;; $4f
    METATILE $30, $35, $27, $23, $00, $00                  ;; $50
    METATILE $32, $40, $42, $23, $00, $00                  ;; $51
    METATILE $2c, $1c, $3c, $1e, $08, $00                  ;; $52
    METATILE $1b, $2d, $1d, $3d, $08, $00                  ;; $53
    METATILE $41, $32, $23, $43, $00, $00                  ;; $54
    METATILE $36, $34, $23, $37, $00, $00                  ;; $55
    METATILE $d6, $d7, $d8, $d9, $30, $65                  ;; $56
    METATILE $d6, $d7, $d8, $d9, $30, $75                  ;; $57
    METATILE $d6, $d7, $d8, $d9, $30, $55                  ;; $58
    METATILE $d6, $d7, $d8, $d9, $30, $45                  ;; $59
    METATILE $f2, $f3, $f4, $f5, $00, $05                  ;; $5a
    METATILE $f6, $f7, $f8, $f9, $30, $05                  ;; $5b
    METATILE $fa, $fb, $fc, $fd, $05, $05                  ;; $5c
    METATILE $fe, $fe, $fe, $fe, $30, $05                  ;; $5d
    METATILE $cc, $cd, $ce, $cf, $31, $05                  ;; $5e
    METATILE $ee, $ef, $f0, $f1, $00, $05                  ;; $5f
    METATILE $c6, $c6, $c7, $c7, $30, $55                  ;; $60
    METATILE $c6, $c6, $c7, $c7, $30, $45                  ;; $61
    METATILE $c4, $c5, $c4, $c5, $30, $65                  ;; $62
    METATILE $c4, $c5, $c4, $c5, $30, $75                  ;; $63
    METATILE $c6, $c6, $d4, $d4, $30, $55                  ;; $64
    METATILE $e2, $e3, $e4, $e5, $30, $75                  ;; $65
    METATILE $da, $db, $dc, $dd, $30, $45                  ;; $66
    METATILE $c6, $c6, $c7, $c7, $30, $75                  ;; $67
    METATILE $de, $df, $e0, $e1, $30, $65                  ;; $68
    METATILE $da, $db, $dc, $dd, $30, $45                  ;; $69
    METATILE $bc, $bd, $be, $bf, $03, $05                  ;; $6a
    METATILE $9a, $9b, $9c, $9d, $03, $04                  ;; $6b
    METATILE $2e, $fe, $3e, $fe, $08, $00                  ;; $6c
    METATILE $fe, $2f, $fe, $3f, $08, $00                  ;; $6d
    METATILE $2c, $fe, $3c, $fe, $08, $00                  ;; $6e
    METATILE $fe, $2d, $fe, $3d, $08, $00                  ;; $6f
    METATILE $e6, $e7, $e8, $e9, $30, $75                  ;; $70
    METATILE $32, $fe, $42, $fe, $08, $00                  ;; $71
    METATILE $fe, $32, $fe, $43, $08, $00                  ;; $72
    METATILE $1f, $a1, $ac, $ad, $07, $04                  ;; $73
    METATILE $a2, $a4, $a2, $a4, $00, $04                  ;; $74
    METATILE $ea, $eb, $ec, $ed, $30, $05                  ;; $75
    METATILE $ff, $ff, $ff, $ff, $00, $00                  ;; $76
    METATILE $ff, $ff, $ff, $ff, $00, $00                  ;; $77
    METATILE $ff, $ff, $ff, $ff, $00, $00                  ;; $78
    METATILE $12, $12, $12, $12, $00, $00                  ;; $79
    METATILE $12, $12, $12, $12, $00, $00                  ;; $7a

metatilesTitle:
    METATILE $11, $11, $11, $11, $30, $00                  ;; $00
    METATILE $21, $11, $11, $11, $30, $00                  ;; $01
    METATILE $11, $21, $11, $11, $30, $00                  ;; $02
    METATILE $21, $21, $11, $11, $30, $00                  ;; $03
    METATILE $11, $11, $21, $11, $30, $00                  ;; $04
    METATILE $21, $11, $21, $11, $30, $00                  ;; $05
    METATILE $11, $21, $21, $11, $30, $00                  ;; $06
    METATILE $21, $21, $21, $11, $30, $00                  ;; $07
    METATILE $11, $11, $11, $21, $30, $00                  ;; $08
    METATILE $21, $11, $11, $21, $30, $00                  ;; $09
    METATILE $11, $21, $11, $21, $30, $00                  ;; $0a
    METATILE $21, $21, $11, $21, $30, $00                  ;; $0b
    METATILE $11, $11, $21, $21, $30, $00                  ;; $0c
    METATILE $21, $11, $21, $21, $30, $00                  ;; $0d
    METATILE $11, $21, $21, $21, $30, $00                  ;; $0e
    METATILE $21, $21, $21, $21, $30, $00                  ;; $0f
    METATILE $22, $22, $22, $22, $f0, $00                  ;; $10
    METATILE $3f, $3f, $3f, $3f, $30, $00                  ;; $11
    METATILE $30, $25, $31, $25, $30, $00, BGP_LIGHT       ;; $12
    METATILE $25, $25, $25, $25, $30, $00, BGP_LIGHT       ;; $13
    METATILE $25, $2f, $25, $2f, $30, $00, BGP_LIGHT       ;; $14
    METATILE $3f, $48, $3f, $3f, $30, $00, BGP_END         ;; $15
    METATILE $49, $4a, $50, $51, $30, $00, BGP_END         ;; $16
    METATILE $4b, $4c, $52, $53, $30, $00, BGP_END         ;; $17
    METATILE $4d, $4e, $54, $55, $30, $00, BGP_END         ;; $18
    METATILE $4f, $3f, $56, $3f, $30, $00, BGP_END         ;; $19
    METATILE $3f, $30, $3f, $31, $30, $00, BGP_LIGHT       ;; $1a
    METATILE $30, $25, $31, $25, $30, $00, BGP_LIGHT       ;; $1b
    METATILE $3f, $30, $3f, $31, $30, $00, BGP_LIGHT       ;; $1c
    METATILE $23, $24, $33, $34, $30, $00, BGP_SPROUT      ;; $1d
    METATILE $25, $25, $35, $25, $30, $00, BGP_SPROUT      ;; $1e
    METATILE $26, $27, $36, $37, $30, $00, BGP_LIGHT       ;; $1f
    METATILE $28, $29, $38, $39, $30, $00, BGP_LIGHT       ;; $20
    METATILE $43, $44, $3a, $3a, $30, $00, BGP_LIGHT       ;; $21
    METATILE $45, $2c, $3b, $3c, $30, $00, BGP_LIGHT       ;; $22
    METATILE $2d, $2e, $3d, $3e, $30, $00, BGP_LIGHT       ;; $23
    METATILE $25, $25, $35, $25, $30, $00, BGP_SPROUT      ;; $24
    METATILE $25, $25, $32, $25, $30, $00, BGP_SPROUT      ;; $25
    METATILE $46, $25, $47, $25, $30, $00, BGP_SPROUT      ;; $26
    METATILE $40, $41, $42, $25, $30, $00, BGP_SPROUT      ;; $27
    METATILE $25, $25, $25, $5b, $30, $00                  ;; $28
    METATILE $25, $25, $5c, $25, $00, $00                  ;; $29
    METATILE $25, $5d, $25, $6d, $00, $00                  ;; $2a
    METATILE $5e, $25, $6e, $b7, $00, $00                  ;; $2b
    METATILE $60, $61, $70, $71, $00, $00                  ;; $2c
    METATILE $25, $63, $72, $73, $00, $00                  ;; $2d
    METATILE $64, $65, $74, $75, $00, $00                  ;; $2e
    METATILE $66, $67, $76, $77, $00, $00                  ;; $2f
    METATILE $68, $69, $78, $79, $00, $00                  ;; $30
    METATILE $3f, $57, $3f, $31, $00, $00, BGP_LIGHT       ;; $31
    METATILE $58, $58, $25, $25, $30, $00, BGP_LIGHT       ;; $32
    METATILE $58, $58, $25, $2f, $30, $00, BGP_LIGHT       ;; $33
    METATILE $25, $25, $25, $5f, $30, $00                  ;; $34
    METATILE $6a, $6b, $7a, $7b, $30, $00                  ;; $35
    METATILE $6c, $6f, $7c, $7d, $30, $00                  ;; $36
    METATILE $25, $25, $7e, $7f, $30, $00                  ;; $37
    METATILE $80, $81, $90, $91, $30, $00                  ;; $38
    METATILE $82, $83, $92, $93, $30, $00                  ;; $39
    METATILE $84, $85, $94, $95, $30, $00                  ;; $3a
    METATILE $86, $87, $96, $97, $30, $00                  ;; $3b
    METATILE $88, $89, $98, $99, $30, $00                  ;; $3c
    METATILE $8a, $8b, $9a, $9b, $30, $00                  ;; $3d
    METATILE $8c, $8d, $9c, $9d, $30, $00                  ;; $3e
    METATILE $8e, $8f, $25, $25, $30, $00                  ;; $3f
    METATILE $a0, $a1, $25, $25, $30, $00                  ;; $40
    METATILE $a2, $a3, $25, $b3, $30, $00                  ;; $41
    METATILE $a4, $25, $b4, $25, $30, $00                  ;; $42
    METATILE $25, $a9, $25, $b9, $00, $00                  ;; $43
    METATILE $25, $25, $b8, $ba, $00, $00                  ;; $44
    METATILE $25, $25, $bb, $bc, $00, $00                  ;; $45
    METATILE $25, $25, $bd, $be, $00, $00                  ;; $46
    METATILE $25, $25, $bf, $25, $00, $00                  ;; $47
    METATILE $bc, $bd, $25, $25, $00, $00                  ;; $48
    METATILE $be, $25, $25, $25, $00, $00                  ;; $49

metatilesWorldmap:
    METATILE $2e, $2f, $2e, $2f, $30, $05                  ;; $00
    METATILE $2e, $2f, $9e, $9f, $00, $05                  ;; $01
    METATILE $16, $17, $0e, $18, $60, $07, BGP_OCEAN       ;; $02
    METATILE $27, $10, $10, $10, $c0, $07, BGP_RIVER       ;; $03
    METATILE $10, $28, $10, $10, $c0, $07, BGP_RIVER       ;; $04
    METATILE $2d, $2d, $2d, $2d, $30, $05, BGP_SAND        ;; $05
    METATILE $6a, $6b, $70, $10, $c0, $07, BGP_SHORE, BGP_SHORE, BGP_SHORE, BGP_RIVER ;; $06
    METATILE $6c, $6d, $10, $10, $c0, $07, BGP_SHORE, BGP_SHORE, BGP_RIVER, BGP_RIVER ;; $07
    METATILE $6e, $6f, $10, $71, $c0, $07, BGP_SHORE, BGP_SHORE, BGP_RIVER, BGP_SHORE ;; $08
    METATILE $db, $d4, $db, $d4, $00, $04                  ;; $09
    METATILE $d7, $dc, $d7, $dc, $00, $04                  ;; $0a
    METATILE $3a, $3b, $4c, $7e, $30, $0d                  ;; $0b
    METATILE $26, $26, $26, $26, $00, $05                  ;; $0c
    METATILE $56, $2f, $57, $58, $20, $06                  ;; $0d
    METATILE $4e, $41, $55, $2f, $10, $04                  ;; $0e
    METATILE $2e, $3e, $36, $37, $28, $04                  ;; $0f
    METATILE $19, $0d, $1a, $0f, $c0, $07, BGP_OCEAN       ;; $10
    METATILE $0c, $0d, $0e, $0f, $c0, $07, BGP_OCEAN       ;; $11
    METATILE $0c, $1b, $0e, $1c, $c0, $07, BGP_OCEAN       ;; $12
    METATILE $10, $10, $29, $10, $c0, $07, BGP_RIVER       ;; $13
    METATILE $10, $10, $10, $2a, $c0, $07, BGP_RIVER       ;; $14
    METATILE $11, $12, $13, $0f, $60, $07, BGP_OCEAN       ;; $15
    METATILE $72, $10, $74, $10, $c0, $07, BGP_RIVER       ;; $16
    METATILE $10, $10, $10, $10, $c0, $07, BGP_RIVER       ;; $17
    METATILE $10, $73, $10, $75, $c0, $07, BGP_RIVER       ;; $18
    METATILE $d3, $d4, $d5, $d6, $10, $04                  ;; $19
    METATILE $d7, $d8, $d9, $da, $10, $04                  ;; $1a
    METATILE $fc, $fd, $fe, $ff, $00, $04                  ;; $1b
    METATILE $42, $43, $df, $e0, $00, $04                  ;; $1c
    METATILE $4a, $4b, $2e, $4d, $10, $04                  ;; $1d
    METATILE $52, $53, $54, $2f, $10, $04                  ;; $1e
    METATILE $e5, $e5, $e6, $e6, $00, $04                  ;; $1f
    METATILE $1d, $0d, $1e, $1f, $90, $07, BGP_OCEAN       ;; $20
    METATILE $0c, $0d, $20, $21, $80, $07, BGP_OCEAN       ;; $21
    METATILE $0c, $22, $23, $24, $90, $07, BGP_OCEAN       ;; $22
    METATILE $2b, $2c, $48, $49, $00, $74                  ;; $23
    METATILE $32, $33, $34, $35, $30, $05                  ;; $24
    METATILE $25, $25, $25, $25, $30, $05                  ;; $25
    METATILE $76, $10, $78, $79, $c0, $07, BGP_SHORE, BGP_RIVER, BGP_SHORE, BGP_SHORE ;; $26
    METATILE $10, $10, $7a, $7b, $c0, $07, BGP_RIVER, BGP_RIVER, BGP_SHORE, BGP_SHORE ;; $27
    METATILE $10, $77, $7c, $7d, $c0, $07, BGP_RIVER, BGP_SHORE, BGP_SHORE, BGP_SHORE ;; $28
    METATILE $84, $85, $86, $87, $f0, $07, BGP_DOCK        ;; $29
    METATILE $88, $89, $8a, $8b, $f0, $07, BGP_DOCK        ;; $2a
    METATILE $7f, $7f, $7f, $7f, $30, $05                  ;; $2b
    METATILE $3f, $2f, $44, $40, $20, $06                  ;; $2c
    METATILE $4a, $4b, $2d, $4d, $10, $04, BGP_DEFAULT, BGP_DEFAULT, BGP_SAND, BGP_DEFAULT ;; $2d
    METATILE $c2, $c3, $c4, $c5, $30, $84, BGP_DOOR        ;; $2e
    METATILE $4e, $41, $55, $2d, $10, $04, BGP_DEFAULT, BGP_DEFAULT, BGP_DEFAULT, BGP_SAND ;; $2f
    METATILE $25, $3e, $36, $37, $28, $04                  ;; $30
    METATILE $38, $39, $44, $45, $00, $04                  ;; $31
    METATILE $3c, $2d, $47, $3d, $20, $04, BGP_DEFAULT, BGP_SAND, BGP_DEFAULT, BGP_DEFAULT ;; $32
    METATILE $56, $25, $57, $58, $20, $06                  ;; $33
    METATILE $2e, $59, $5a, $5b, $20, $02                  ;; $34
    METATILE $a2, $a3, $a4, $a5, $00, $04, BGP_SNAG        ;; $35
    METATILE $a6, $a7, $a8, $a9, $00, $05                  ;; $36
    METATILE $96, $97, $98, $99, $04, $04, BGP_TREE        ;; $37
    METATILE $14, $15, $0e, $0f, $40, $07, BGP_OCEAN       ;; $38
    METATILE $2d, $3e, $36, $37, $28, $04, BGP_SAND, BGP_DEFAULT, BGP_DEFAULT, BGP_DEFAULT ;; $39
    METATILE $3f, $2d, $44, $40, $20, $06, BGP_DEFAULT, BGP_SAND, BGP_DEFAULT, BGP_DEFAULT ;; $3a
    METATILE $00, $01, $02, $03, $02, $04, BGP_FLOATROCK   ;; $3b
    METATILE $3c, $2f, $47, $3d, $20, $04                  ;; $3c
    METATILE $be, $bf, $c0, $c1, $00, $04, BGP_SNOW        ;; $3d
    METATILE $ba, $bb, $bc, $bd, $00, $04, BGP_SNOW        ;; $3e
    METATILE $52, $53, $54, $2d, $10, $04, BGP_DEFAULT, BGP_DEFAULT, BGP_DEFAULT, BGP_SAND ;; $3f
    METATILE $3f, $25, $44, $40, $20, $06                  ;; $40
    METATILE $42, $43, $44, $45, $00, $04                  ;; $41
    METATILE $46, $47, $48, $49, $00, $04                  ;; $42
    METATILE $5c, $5d, $5e, $26, $00, $04                  ;; $43
    METATILE $5f, $60, $26, $61, $00, $04                  ;; $44
    METATILE $ae, $af, $b0, $b1, $06, $04                  ;; $45
    METATILE $aa, $ab, $ac, $ad, $00, $04, BGP_CRYSTAL     ;; $46
    METATILE $9a, $9b, $9c, $9d, $00, $04                  ;; $47
    METATILE $b6, $b7, $b8, $b9, $00, $04                  ;; $48
    METATILE $b2, $b3, $b3, $b2, $30, $05                  ;; $49
    METATILE $c9, $ca, $cb, $cc, $30, $05                  ;; $4a
    METATILE $e1, $e2, $e3, $e4, $30, $85                  ;; $4b
    METATILE $66, $67, $68, $69, $30, $85                  ;; $4c
    METATILE $62, $63, $64, $65, $30, $84                  ;; $4d
    METATILE $92, $93, $94, $95, $31, $04                  ;; $4e
    METATILE $cd, $cd, $ce, $ce, $00, $04, BGP_PALISADE    ;; $4f
    METATILE $4a, $4b, $25, $4d, $10, $04                  ;; $50
    METATILE $4e, $4f, $50, $51, $00, $04                  ;; $51
    METATILE $52, $53, $54, $25, $10, $04                  ;; $52
    METATILE $4e, $41, $55, $25, $10, $04                  ;; $53
    METATILE $d1, $d1, $d2, $d2, $00, $04                  ;; $54
    METATILE $d1, $d1, $d1, $d1, $00, $04                  ;; $55
    METATILE $e7, $e8, $e7, $e8, $30, $05, BGP_BRIDGE      ;; $56
    METATILE $e8, $e9, $e8, $e9, $30, $05, BGP_BRIDGE      ;; $57
    METATILE $b2, $3e, $36, $37, $28, $04                  ;; $58
    METATILE $3f, $b3, $44, $40, $20, $04                  ;; $59
    METATILE $4a, $4b, $b3, $4d, $10, $04                  ;; $5a
    METATILE $08, $09, $08, $09, $00, $05, BGP_FALLS       ;; $5b
    METATILE $4e, $41, $55, $b2, $10, $04                  ;; $5c
    METATILE $8c, $8d, $8e, $8f, $00, $04, BGP_CABIN_ROOF  ;; $5d
    METATILE $90, $91, $90, $91, $00, $04, BGP_CABIN_WALL  ;; $5e
; Curved tower base with swamp for Kett's:
    METATILE $d3, $d4, $dd, $d6, $10, $04                  ;; $5f
    METATILE $35, $f0, $f1, $37, $20, $04                  ;; $60
    METATILE $f2, $34, $44, $f3, $20, $04                  ;; $61
    METATILE $f4, $4b, $32, $f5, $10, $04                  ;; $62
    METATILE $4e, $f6, $f7, $33, $10, $04                  ;; $63
    METATILE $a0, $a1, $44, $45, $00, $04                  ;; $64
    METATILE $ea, $ea, $ea, $ea, $30, $05                  ;; $65
    METATILE $2d, $2d, $b4, $31, $20, $04, BGP_SAND, BGP_SAND, BGP_DEFAULT, BGP_DEFAULT ;; $66
    METATILE $52, $53, $54, $b2, $10, $04                  ;; $67
    METATILE $fa, $b3, $fb, $b2, $30, $05                  ;; $68
    METATILE $c6, $2f, $c7, $2f, $30, $05                  ;; $69
    METATILE $26, $26, $26, $26, $30, $85                  ;; $6a
    METATILE $7f, $7f, $7f, $7f, $30, $85                  ;; $6b
    METATILE $30, $31, $d1, $d1, $00, $04                  ;; $6c
    METATILE $10, $10, $b4, $31, $80, $04, BGP_RIVER, BGP_RIVER, BGP_DEFAULT, BGP_DEFAULT ;; $6d
    METATILE $c6, $2f, $c6, $2f, $30, $05                  ;; $6e
; Curved tower base with swamp for Kett's:
    METATILE $d7, $d8, $d9, $de, $10, $04                  ;; $6f
    METATILE $2e, $2f, $2e, $2f, $30, $85                  ;; $70
    METATILE $80, $12, $13, $0f, $60, $07, BGP_OCEAN       ;; $71
    METATILE $ea, $ea, $b4, $31, $20, $05                  ;; $72
    METATILE $cf, $d0, $26, $26, $00, $04                  ;; $73
    METATILE $16, $81, $0e, $18, $60, $07, BGP_OCEAN       ;; $74
    METATILE $52, $f8, $f9, $33, $10, $04                  ;; $75
    METATILE $1d, $0d, $82, $1f, $90, $07, BGP_OCEAN       ;; $76
    METATILE $0c, $22, $23, $83, $90, $07, BGP_OCEAN       ;; $77
    METATILE $56, $2d, $57, $58, $20, $06, BGP_DEFAULT, BGP_SAND, BGP_DEFAULT, BGP_DEFAULT ;; $78
    METATILE $d1, $d1, $cf, $d0, $00, $04                  ;; $79
; Chain post with swamp:
    METATILE $ec, $ed, $ee, $ef, $31, $04                  ;; $7a
    METATILE $84, $85, $86, $87, $f0, $87, BGP_DOCK        ;; $7b
    METATILE $2e, $2f, $2e, $2f, $00, $05                  ;; $7c
    METATILE $88, $89, $8a, $8b, $f0, $87, BGP_DOCK        ;; $7d
    METATILE $25, $25, $25, $25, $00, $05                  ;; $7e
    METATILE $96, $97, $98, $99, $05, $04, BGP_TREE        ;; $7f
; Expansion:
; Dime Tower rises in front of crystals:
    METATILE $aa, $ab, $b4, $31, $20, $04, BGP_CRYSTAL, BGP_CRYSTAL, BGP_DEFAULT, BGP_DEFAULT ;; $80 ($66)
; Vertical bridge that blocks Chocoboat for the bridge to the Snowfields.
    METATILE $88, $89, $8a, $8b, $30, $07, BGP_DOCK        ;; $81 ($2a)

metatilesManaland:
    METATILE $70, $71, $70, $71, $30, $05                  ;; $00
    METATILE $70, $71, $fe, $ff, $00, $05                  ;; $01
    METATILE $3c, $25, $47, $3d, $20, $04                  ;; $02
    METATILE $f2, $f2, $f2, $f2, $30, $05                  ;; $03
    METATILE $56, $71, $57, $58, $20, $05                  ;; $04
    METATILE $70, $59, $5a, $5b, $20, $05                  ;; $05
    METATILE $27, $10, $10, $10, $00, $07, BGP_RIVER       ;; $06
    METATILE $10, $28, $10, $10, $00, $07, BGP_RIVER       ;; $07
    METATILE $1e, $1f, $1f, $1e, $30, $05                  ;; $08
; Waterfalls in this tileset originally were set to walkable, slide south. Changed to not be walkable.
    METATILE $08, $09, $08, $09, $00, $05, BGP_FALLS       ;; $09
    METATILE $74, $75, $76, $77, $00, $05                  ;; $0a
    METATILE $3a, $3b, $4c, $7e, $30, $0d                  ;; $0b
    METATILE $26, $26, $26, $26, $00, $05                  ;; $0c
    METATILE $25, $25, $25, $25, $30, $05                  ;; $0d
    METATILE $81, $82, $83, $c7, $00, $05                  ;; $0e
    METATILE $63, $64, $65, $66, $00, $05                  ;; $0f
    METATILE $3f, $25, $44, $40, $20, $05                  ;; $10
    METATILE $42, $43, $44, $45, $00, $04                  ;; $11
    METATILE $46, $47, $48, $49, $00, $04                  ;; $12
    METATILE $f3, $f2, $f3, $f2, $30, $05                  ;; $13
; Castle tower left
    METATILE $db, $d4, $db, $d4, $00, $04                  ;; $14
; Castle tower right
    METATILE $d7, $dc, $d7, $dc, $00, $04                  ;; $15
    METATILE $10, $10, $29, $10, $00, $07, BGP_RIVER       ;; $16
    METATILE $10, $10, $10, $2a, $00, $07, BGP_RIVER       ;; $17
    METATILE $22, $23, $24, $2b, $30, $05                  ;; $18
; Castle tower bottom left
    METATILE $d3, $d4, $d5, $d6, $10, $04                  ;; $19
    METATILE $78, $79, $7a, $7b, $30, $05                  ;; $1a
    METATILE $96, $97, $98, $99, $30, $0d                  ;; $1b
    METATILE $34, $35, $c8, $c9, $04, $04, BGP_TREE        ;; $1c
    METATILE $7c, $7d, $7f, $80, $00, $05                  ;; $1d
    METATILE $c3, $c4, $c5, $c6, $00, $04                  ;; $1e
; Castle tower bottom right
    METATILE $d7, $d8, $d9, $da, $10, $04                  ;; $1f
    METATILE $4a, $4b, $70, $4d, $10, $04                  ;; $20
    METATILE $4e, $4f, $50, $51, $00, $04                  ;; $21
    METATILE $52, $53, $54, $71, $10, $04                  ;; $22
    METATILE $4e, $41, $55, $71, $10, $04                  ;; $23
    METATILE $f4, $f5, $f6, $f7, $30, $05                  ;; $24
    METATILE $cc, $cd, $ce, $cf, $30, $05, BGP_DOCK        ;; $25
    METATILE $d1, $d1, $d2, $d2, $00, $04                  ;; $26
    METATILE $d4, $d5, $d4, $d5, $00, $04                  ;; $27
    METATILE $ac, $ad, $b3, $b4, $00, $04                  ;; $28
    METATILE $ae, $ae, $ae, $ae, $30, $05                  ;; $29
    METATILE $b5, $b5, $b7, $b7, $00, $04                  ;; $2a
    METATILE $a8, $a9, $aa, $ab, $30, $0d                  ;; $2b
; Swamp with script bit set
    METATILE $b9, $ba, $ba, $bb, $30, $85                  ;; $2c
    METATILE $b9, $ba, $ba, $bb, $30, $05                  ;; $2d
    METATILE $af, $b0, $af, $b0, $00, $04                  ;; $2e
    METATILE $94, $b6, $94, $b6, $00, $05                  ;; $2f
    METATILE $9a, $9b, $94, $94, $00, $05                  ;; $30
    METATILE $9d, $9e, $9c, $9b, $20, $05                  ;; $31
    METATILE $93, $93, $9a, $9b, $20, $05, BGP_SKY, BGP_SKY, BGP_DEFAULT, BGP_DEFAULT ;; $32
    METATILE $d6, $d7, $d8, $d9, $30, $85                  ;; $33
    METATILE $de, $df, $e0, $e1, $30, $85                  ;; $34
    METATILE $6a, $6b, $6a, $6b, $00, $05, BGP_BARK        ;; $35
    METATILE $ee, $ef, $f0, $f1, $00, $05, BGP_LEAVES      ;; $36
    METATILE $15, $16, $17, $18, $30, $85, BGP_DOOR        ;; $37
    METATILE $da, $db, $dc, $dd, $30, $85                  ;; $38
    METATILE $6f, $6e, $6f, $6e, $00, $05, BGP_BARK        ;; $39
    METATILE $6f, $6f, $6f, $6f, $00, $04, BGP_BARK        ;; $3a
    METATILE $25, $3e, $36, $37, $20, $04                  ;; $3b
    METATILE $a6, $b8, $25, $a6, $00, $04                  ;; $3c
    METATILE $ca, $ca, $cb, $cb, $30, $05, BGP_LOG         ;; $3d
    METATILE $af, $b0, $b1, $b2, $00, $04                  ;; $3e
    METATILE $a5, $94, $a5, $94, $00, $05                  ;; $3f
    METATILE $94, $94, $9a, $9b, $00, $05                  ;; $40
    METATILE $9c, $9b, $95, $95, $00, $05                  ;; $41
    METATILE $9c, $9b, $94, $94, $00, $05                  ;; $42
    METATILE $9d, $9e, $9f, $a0, $30, $05                  ;; $43
    METATILE $2e, $2f, $70, $71, $10, $05, BGP_BARK, BGP_BARK, BGP_DEFAULT, BGP_DEFAULT ;; $44
    METATILE $62, $6b, $72, $62, $00, $05, BGP_BARK        ;; $45
    METATILE $6c, $6b, $6c, $6b, $00, $05, BGP_BARK        ;; $46
    METATILE $6c, $6c, $6c, $6c, $00, $05, BGP_BARK        ;; $47
    METATILE $6d, $6e, $6d, $6e, $00, $05, BGP_BARK        ;; $48
    METATILE $6f, $6e, $6f, $e5, $00, $05, BGP_BARK        ;; $49
    METATILE $6f, $e6, $e6, $e7, $00, $05, BGP_BARK        ;; $4a
    METATILE $e3, $e4, $70, $71, $10, $05, BGP_BARK, BGP_BARK, BGP_DEFAULT, BGP_DEFAULT ;; $4b
    METATILE $26, $26, $26, $26, $30, $85                  ;; $4c
    METATILE $f8, $f9, $fa, $fb, $30, $85                  ;; $4d
    METATILE $bf, $c0, $c1, $c2, $30, $85                  ;; $4e
    METATILE $b9, $ba, $9c, $9b, $20, $05                  ;; $4f
    METATILE $94, $94, $94, $94, $00, $05                  ;; $50
    METATILE $94, $94, $95, $95, $00, $05                  ;; $51
    METATILE $a1, $a2, $a3, $a4, $00, $05                  ;; $52
    METATILE $8c, $8d, $8f, $90, $00, $75, BGP_SKY         ;; $53
    METATILE $8d, $8e, $90, $91, $00, $75, BGP_SKY         ;; $54
    METATILE $73, $86, $88, $89, $00, $05, BGP_BARK        ;; $55
    METATILE $87, $62, $73, $86, $00, $05, BGP_BARK        ;; $56
    METATILE $6c, $6c, $87, $bd, $00, $05, BGP_BARK        ;; $57
    METATILE $6d, $e5, $be, $e8, $00, $05, BGP_BARK        ;; $58
    METATILE $e6, $e8, $e9, $ea, $00, $05, BGP_BARK        ;; $59
    METATILE $e9, $ea, $ec, $ed, $00, $05, BGP_BARK        ;; $5a
    METATILE $84, $71, $84, $71, $30, $05                  ;; $5b
    METATILE $b8, $b8, $b8, $b8, $00, $04                  ;; $5c
    METATILE $22, $23, $24, $2b, $30, $85                  ;; $5d
    METATILE $70, $71, $70, $71, $30, $85                  ;; $5e
    METATILE $84, $85, $70, $71, $30, $05                  ;; $5f
    METATILE $11, $12, $13, $14, $00, $04                  ;; $60
    METATILE $1c, $1c, $1d, $1d, $00, $04                  ;; $61
    METATILE $1d, $1d, $1d, $1d, $00, $04                  ;; $62
    METATILE $8e, $93, $91, $92, $00, $75, BGP_SKY         ;; $63
    METATILE $93, $93, $93, $93, $00, $75, BGP_SKY         ;; $64
    METATILE $8a, $8b, $70, $71, $10, $05, BGP_BARK, BGP_BARK, BGP_DEFAULT, BGP_DEFAULT ;; $65
    METATILE $88, $89, $8a, $8b, $00, $05, BGP_BARK        ;; $66
    METATILE $73, $e2, $70, $71, $10, $05, BGP_BARK, BGP_BARK, BGP_DEFAULT, BGP_DEFAULT ;; $67
    METATILE $e2, $ea, $70, $71, $10, $05, BGP_BARK, BGP_BARK, BGP_DEFAULT, BGP_DEFAULT ;; $68
    METATILE $ec, $ed, $fc, $fd, $00, $05, BGP_BARK        ;; $69
    METATILE $fc, $fd, $70, $71, $10, $05, BGP_BARK, BGP_BARK, BGP_DEFAULT, BGP_DEFAULT ;; $6a
    METATILE $84, $71, $85, $71, $30, $05                  ;; $6b
    METATILE $b9, $ba, $9c, $9b, $20, $05                  ;; $6c
    METATILE $38, $39, $44, $45, $00, $04                  ;; $6d
    METATILE $a8, $a9, $aa, $ab, $30, $85                  ;; $6e
    METATILE $84, $84, $70, $71, $30, $05                  ;; $6f
    METATILE $30, $2c, $32, $2d, $00, $04                  ;; $70
    METATILE $2c, $2c, $2d, $2d, $00, $04                  ;; $71
    METATILE $2c, $31, $2d, $33, $00, $04                  ;; $72
    METATILE $67, $67, $68, $68, $00, $04                  ;; $73
    METATILE $68, $68, $69, $69, $00, $04                  ;; $74
    METATILE $70, $71, $9c, $9b, $20, $05                  ;; $75
    METATILE $20, $23, $20, $2b, $30, $05                  ;; $76
    METATILE $20, $23, $21, $2b, $30, $05                  ;; $77
    METATILE $22, $23, $9c, $9b, $20, $05                  ;; $78
    METATILE $10, $10, $10, $10, $00, $07, BGP_RIVER       ;; $79
    METATILE $9d, $9e, $9c, $9b, $20, $05                  ;; $7a
    METATILE $d1, $d1, $d2, $d2, $30, $05                  ;; $7b
    METATILE $d4, $d5, $d4, $d5, $30, $05                  ;; $7c
    METATILE $1e, $1f, $1f, $1e, $30, $85                  ;; $7d
    METATILE $f3, $f2, $f3, $f2, $30, $85                  ;; $7e
    METATILE $3a, $3b, $4c, $7e, $30, $8d                  ;; $7f
; Expansion:
; Parapet with cloud, used in Castle Granz.
    METATILE $8e, $93, $9a, $9b, $00, $75, BGP_SKY, BGP_SKY, BGP_DEFAULT, BGP_DEFAULT ;; $80 ($63)
; Parapet with shadowed grass, used in Castle Granz.
    METATILE $84, $71, $9c, $9b, $20, $05                  ;; $81 ($75)
; Parapet with shaddowed stone, used in Castle Granz.
    METATILE $20, $23, $9c, $9b, $20, $05                  ;; $82 ($78)
; Parapet with tree, used in Castle Granz.
    METATILE $34, $35, $9c, $9b, $20, $05, BGP_TREE, BGP_TREE, BGP_DEFAULT, BGP_DEFAULT ;; $83 ($75)
; Parapet with decerative bricks below but unshaded, used in Castle Granz and when Dime tower falls.
    METATILE $9a, $9b, $95, $95, $20, $05                  ;; $84 ($41)
; Mountain with cloud, used in the Mana Land sky.
    METATILE $3f, $d0, $44, $40, $20, $05, BGP_DEFAULT, BGP_SKY, BGP_DEFAULT, BGP_DEFAULT ;; $85 ($10)
; Parapet with stones but unshaded, used when Dime tower falls.
    METATILE $9d, $9e, $9a, $9b, $20, $05                  ;; $86 ($7a)
; Bridge for Marsh Cave which should not have a blue background.
    METATILE $cc, $cd, $ce, $cf, $30, $05, BGP_DEFAULT     ;; $87 ($25)
