;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

; These metasprite tables are 12 entries of [attr, tile1, tile2].
; The first four entries are for standing facing the four directions.
; The second four entries are for stepping in those directions.
; The next four are for any special poses an NPC may or may not have.
; Many of these could be shortened to only eight or four entires.

; Used for NPCs that use the same frame for all facing directions but mirror east/west.
metaspritesTable40FrontFacing:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $42, $40
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a

metaspritesTable50FrontFacing:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC2, $52, $50
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $50, $52
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $50, $52
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $50, $52
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC2, $56, $54
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $54, $56
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $54, $56
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $54, $56
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC2, $5a, $58
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $58, $5a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $58, $5a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $58, $5a

metaspritesTable60FrontFacing:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $62, $60
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $66, $64
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $64, $66
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $64, $66
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $64, $66
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $6a, $68
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $68, $6a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $68, $6a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $68, $6a

metaspritesMyconid:
    db   OAMF_NOFLIP | OAMF_PAL0, $50, $52                                 ;; 03:7bde ... $00
    db   OAMF_NOFLIP | OAMF_PAL0, $50, $52                                 ;; 03:7be1 ... $01
    db   OAMF_NOFLIP | OAMF_PAL0, $54, $56                                 ;; 03:7be4 ... $02
    db   OAMF_NOFLIP | OAMF_PAL0, $50, $52                                 ;; 03:7be7 ... $03
    db   OAMF_XFLIP  | OAMF_PAL0, $52, $50                                 ;; 03:7bea ... $04
    db   OAMF_XFLIP  | OAMF_PAL0, $52, $50                                 ;; 03:7bed ... $05
    db   OAMF_XFLIP  | OAMF_PAL0, $56, $54                                 ;; 03:7bf0 ... $06
    db   OAMF_XFLIP  | OAMF_PAL0, $52, $50                                 ;; 03:7bf3 ... $07

; For a standard NPC like a townsperson in the third slot that should be red by using OBP0.
; Tables on either side are shortened (by removing unused entries) to make room for this one.
; Unused
metaspritesTable60Red:
    db   OAMF_XFLIP  | OAMF_PAL0, $6a, $68
    db   OAMF_NOFLIP | OAMF_PAL0, $68, $6a
    db   OAMF_NOFLIP | OAMF_PAL0, $64, $66
    db   OAMF_NOFLIP | OAMF_PAL0, $60, $62
    db   OAMF_XFLIP  | OAMF_PAL0, $6e, $6c
    db   OAMF_NOFLIP | OAMF_PAL0, $6c, $6e
    db   OAMF_XFLIP  | OAMF_PAL0, $66, $64
    db   OAMF_XFLIP  | OAMF_PAL0, $62, $60

metaspritesGuardian:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $64, $66
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $62, $60
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $62, $60
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $66, $64
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $62, $60

metaspritesEvilSword:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_YFLIP  | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_YFLIP  | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42

; Tables on either side are shortened (by removing unused entries) to make room for this one.
metaspritesCompanionRed:
    db   OAMF_XFLIP  | OAMF_PAL0, $2a, $28
    db   OAMF_NOFLIP | OAMF_PAL0, $28, $2a
    db   OAMF_NOFLIP | OAMF_PAL0, $24, $26
    db   OAMF_NOFLIP | OAMF_PAL0, $20, $22
    db   OAMF_XFLIP  | OAMF_PAL0, $2e, $2c
    db   OAMF_NOFLIP | OAMF_PAL0, $2c, $2e
    db   OAMF_XFLIP  | OAMF_PAL0, $26, $24
    db   OAMF_XFLIP  | OAMF_PAL0, $22, $20

metaspritesZombie:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $42, $40
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $42, $40
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $42, $40

metaspritesPumpkin:
    db   OAMF_XFLIP  | OAMF_PAL0, $46, $44                                 ;; 03:7c6e ??? $00
    db   OAMF_NOFLIP | OAMF_PAL0, $44, $46                                 ;; 03:7c71 ??? $01
    db   OAMF_NOFLIP | OAMF_PAL0, $48, $4a                                 ;; 03:7c74 ??? $02
    db   OAMF_NOFLIP | OAMF_PAL0, $40, $42                                 ;; 03:7c77 ??? $03
    db   OAMF_XFLIP  | OAMF_PAL0, $46, $44                                 ;; 03:7c7a ??? $04
    db   OAMF_NOFLIP | OAMF_PAL0, $44, $46                                 ;; 03:7c7d ??? $05
    db   OAMF_NOFLIP | OAMF_PAL0, $48, $4a                                 ;; 03:7c80 ??? $06
    db   OAMF_NOFLIP | OAMF_PAL0, $40, $42                                 ;; 03:7c83 ??? $07
    db   OAMF_XFLIP  | OAMF_PAL0, $46, $44                                 ;; 03:7c86 ??? $08
    db   OAMF_NOFLIP | OAMF_PAL0, $44, $46                                 ;; 03:7c89 ??? $09
    db   OAMF_NOFLIP | OAMF_PAL0, $48, $4a                                 ;; 03:7c8c ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL0, $40, $42                                 ;; 03:7c8f ??? $0b

metaspritesAirElemental:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $42, $40
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46

; Used for NPCs like town people that have walk cycles in all four directions.
metaspritesTabel40Normal:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4e, $4c
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $42, $40
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42

metaspritesTabel60Normal:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $6a, $68
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $68, $6a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $64, $66
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $6e, $6c
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $6c, $6e
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $66, $64
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $62, $60

; For Fuji when loaded as a normal NPC. Probably in the Airship.
; For a standard NPC like a townsperson in the third slot that should be red by using OBP0.
; Tables on either side are shortened (by removing unused entries) to make room for this one.
metaspritesTable40Red:
    db   OAMF_XFLIP  | OAMF_PAL0, $4a, $48
    db   OAMF_NOFLIP | OAMF_PAL0, $48, $4a
    db   OAMF_NOFLIP | OAMF_PAL0, $44, $46
    db   OAMF_NOFLIP | OAMF_PAL0, $40, $42
    db   OAMF_XFLIP  | OAMF_PAL0, $4e, $4c
    db   OAMF_NOFLIP | OAMF_PAL0, $4c, $4e
    db   OAMF_XFLIP  | OAMF_PAL0, $46, $44
    db   OAMF_XFLIP  | OAMF_PAL0, $42, $40

; Used for NPCs like town people that have walk cycles in all four directions.
metaspritesTabel50Normal:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC2, $5a, $58
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $58, $5a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $54, $56
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $50, $52
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC2, $5e, $5c
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $5c, $5e
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC2, $56, $54
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC2, $52, $50

metaspritesEyeSpy:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $42, $40
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $42, $40
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4e, $4c
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e

metaspritesRoper:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44

metaspritesShadowZero:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $6a, $68
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $68, $6a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $6a, $68
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $68, $6a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $64, $66
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $66, $64
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62

metaspritesEarthElemental:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $50, $52
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $54, $56
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $50, $52
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $54, $56
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC2, $5a, $58
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $58, $5a
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC2, $56, $54
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $58, $5a
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC2, $5a, $58
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $58, $5a
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC2, $56, $54
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $58, $5a

metaspritesDoppelMirror:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC2, $56, $54
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $54, $56
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $58, $5a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $50, $52
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC2, $56, $54
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $54, $56
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $58, $5a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $50, $52
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC2, $56, $54
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $54, $56
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $58, $5a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $50, $52

metaspritesPhantasm:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e

metaspritesPakkunPorcupine:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $5a, $58
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $58, $5a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $54, $56
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $50, $52
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $5e, $5c
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $5c, $5e
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $56, $54
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $52, $50
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62

metaspritesJulius:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $62, $60
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $58, $5a
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $66, $64
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $64, $66
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $5e, $5c
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $5a, $58
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $6e, $6c
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $6c, $6e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $68, $6a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $5c, $5a

metaspritesWizard:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4e, $4c
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $42, $40
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $56, $54
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $54, $56
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52

metaspritesDeathGauntlet:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $5a, $58
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $58, $5a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $50, $52
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $5e, $5c
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $64, $66
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $54, $56
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $5e, $5c
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $64, $66
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $54, $56

metaspritesDarkStalker:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $6a, $68
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $68, $6a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $58, $5a
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $6e, $6c
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $6c, $6e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $64, $66
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $5c, $5e
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC3, $6e, $6c
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $6c, $6e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $64, $66
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $5c, $5e

metaspritesShadowKnight:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $52, $50
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $56, $54
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $54, $56
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $52, $50
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42

metaspritesTable5cUnmoving:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC2, $5c, $5e

metaspritesTable40Unmoving:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42

metaspritesTable40UnmovingRed:
    db   OAMF_NOFLIP | OAMF_PAL0, $40, $42                                 ;; 03:7f1a ??? $00
    db   OAMF_NOFLIP | OAMF_PAL0, $40, $42                                 ;; 03:7f1d ??? $01
    db   OAMF_NOFLIP | OAMF_PAL0, $40, $42                                 ;; 03:7f20 ??? $02
    db   OAMF_NOFLIP | OAMF_PAL0, $40, $42                                 ;; 03:7f23 ??? $03

metaspritesTable5cUnmovingRed:
    db   OAMF_NOFLIP | OAMF_PAL0, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL0, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL0, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL0, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL0, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL0, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL0, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL0, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL0, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL0, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL0, $5c, $5e
    db   OAMF_NOFLIP | OAMF_PAL0, $5c, $5e

ds 12 ; Free space

metaspritesInvisible:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $6e, $6e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $6e, $6e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $6e, $6e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $6e, $6e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $6e, $6e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $6e, $6e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $6e, $6e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $6e, $6e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $6e, $6e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $6e, $6e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $6e, $6e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $6e, $6e

metaspritesCompanion:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_FOLLOWER, $2a, $28
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_FOLLOWER, $28, $2a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_FOLLOWER, $24, $26
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_FOLLOWER, $20, $22
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_FOLLOWER, $2e, $2c
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_FOLLOWER, $2c, $2e
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_FOLLOWER, $26, $24
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_FOLLOWER, $22, $20
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_FOLLOWER, $2a, $28
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_FOLLOWER, $28, $2a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_FOLLOWER, $24, $26
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_FOLLOWER, $20, $22

metaspritesWilly:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC3, $60, $62

; A variant of metaspritesTable50FrontFacing using OBP0 to turn certain enemies red.
metaspritesRabiteFlowerFlameRed:
    db   OAMF_XFLIP  | OAMF_PAL0, $52, $50                                 ;; 03:7f92 ??? $00
    db   OAMF_NOFLIP | OAMF_PAL0, $50, $52                                 ;; 03:7f95 ??? $01
    db   OAMF_NOFLIP | OAMF_PAL0, $50, $52                                 ;; 03:7f98 ??? $02
    db   OAMF_NOFLIP | OAMF_PAL0, $50, $52                                 ;; 03:7f9b ??? $03
    db   OAMF_XFLIP  | OAMF_PAL0, $56, $54                                 ;; 03:7f9e ??? $04
    db   OAMF_NOFLIP | OAMF_PAL0, $54, $56                                 ;; 03:7fa1 ??? $05
    db   OAMF_NOFLIP | OAMF_PAL0, $54, $56                                 ;; 03:7fa4 ??? $06
    db   OAMF_NOFLIP | OAMF_PAL0, $54, $56                                 ;; 03:7fa7 ??? $07
    db   OAMF_XFLIP  | OAMF_PAL0, $5a, $58                                 ;; 03:7faa ??? $08
    db   OAMF_NOFLIP | OAMF_PAL0, $58, $5a                                 ;; 03:7fad ??? $09
    db   OAMF_NOFLIP | OAMF_PAL0, $58, $5a                                 ;; 03:7fb0 ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL0, $58, $5a                                 ;; 03:7fb3 ??? $0b

; A variant of metaspritesTabel50Normal using OBP0 to turn certain NPCs red.
metaspritesShieldlessPC:
    db   OAMF_XFLIP  | OAMF_PAL0, $5a, $58
    db   OAMF_NOFLIP | OAMF_PAL0, $58, $5a
    db   OAMF_NOFLIP | OAMF_PAL0, $54, $56
    db   OAMF_NOFLIP | OAMF_PAL0, $50, $52
    db   OAMF_XFLIP  | OAMF_PAL0, $5e, $5c
    db   OAMF_NOFLIP | OAMF_PAL0, $5c, $5e
    db   OAMF_XFLIP  | OAMF_PAL0, $56, $54
    db   OAMF_XFLIP  | OAMF_PAL0, $52, $50
    db   OAMF_XFLIP  | OAMF_PAL0, $5a, $58
    db   OAMF_NOFLIP | OAMF_PAL0, $58, $5a
    db   OAMF_NOFLIP | OAMF_PAL0, $54, $56
    db   OAMF_NOFLIP | OAMF_PAL0, $50, $52
