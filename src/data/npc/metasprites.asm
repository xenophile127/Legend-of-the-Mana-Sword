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

;@data format=bbb amount=12
data_03_7b96:
    db   OAMF_XFLIP  | OAMF_PAL1, $52, $50                                 ;; 03:7b96 ... $00
    db   OAMF_NOFLIP | OAMF_PAL1, $50, $52                                 ;; 03:7b99 ... $01
    db   OAMF_NOFLIP | OAMF_PAL1, $50, $52                                 ;; 03:7b9c ... $02
    db   OAMF_NOFLIP | OAMF_PAL1, $50, $52                                 ;; 03:7b9f ... $03
    db   OAMF_XFLIP  | OAMF_PAL1, $56, $54                                 ;; 03:7ba2 ... $04
    db   OAMF_NOFLIP | OAMF_PAL1, $54, $56                                 ;; 03:7ba5 ... $05
    db   OAMF_NOFLIP | OAMF_PAL1, $54, $56                                 ;; 03:7ba8 ... $06
    db   OAMF_NOFLIP | OAMF_PAL1, $54, $56                                 ;; 03:7bab ... $07
    db   OAMF_XFLIP  | OAMF_PAL1, $5a, $58                                 ;; 03:7bae ... $08
    db   OAMF_NOFLIP | OAMF_PAL1, $58, $5a                                 ;; 03:7bb1 ... $09
    db   OAMF_NOFLIP | OAMF_PAL1, $58, $5a                                 ;; 03:7bb4 ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL1, $58, $5a                                 ;; 03:7bb7 ... $0b

;@data format=bbb amount=12
data_03_7bba:
    db   OAMF_XFLIP  | OAMF_PAL1, $62, $60                                 ;; 03:7bba ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7bbd ??? $01
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7bc0 ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7bc3 ??? $03
    db   OAMF_XFLIP  | OAMF_PAL1, $66, $64                                 ;; 03:7bc6 ??? $04
    db   OAMF_NOFLIP | OAMF_PAL1, $64, $66                                 ;; 03:7bc9 ??? $05
    db   OAMF_NOFLIP | OAMF_PAL1, $64, $66                                 ;; 03:7bcc ??? $06
    db   OAMF_NOFLIP | OAMF_PAL1, $64, $66                                 ;; 03:7bcf ??? $07
    db   OAMF_XFLIP  | OAMF_PAL1, $6a, $68                                 ;; 03:7bd2 ??? $08
    db   OAMF_NOFLIP | OAMF_PAL1, $68, $6a                                 ;; 03:7bd5 ??? $09
    db   OAMF_NOFLIP | OAMF_PAL1, $68, $6a                                 ;; 03:7bd8 ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL1, $68, $6a                                 ;; 03:7bdb ??? $0b

;@data format=bbb amount=8
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
;@data format=bbb amount=8
metaspritesTable60Red:
    db   OAMF_XFLIP  | OAMF_PAL0, $6a, $68
    db   OAMF_NOFLIP | OAMF_PAL0, $68, $6a
    db   OAMF_NOFLIP | OAMF_PAL0, $64, $66
    db   OAMF_NOFLIP | OAMF_PAL0, $60, $62
    db   OAMF_XFLIP  | OAMF_PAL0, $6e, $6c
    db   OAMF_NOFLIP | OAMF_PAL0, $6c, $6e
    db   OAMF_XFLIP  | OAMF_PAL0, $66, $64
    db   OAMF_XFLIP  | OAMF_PAL0, $62, $60

;@data format=bbb amount=12
metaspritesGuardian:
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7c02 ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7c05 ??? $01
    db   OAMF_NOFLIP | OAMF_PAL1, $64, $66                                 ;; 03:7c08 ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7c0b ??? $03
    db   OAMF_XFLIP  | OAMF_PAL1, $62, $60                                 ;; 03:7c0e ??? $04
    db   OAMF_XFLIP  | OAMF_PAL1, $62, $60                                 ;; 03:7c11 ??? $05
    db   OAMF_XFLIP  | OAMF_PAL1, $66, $64                                 ;; 03:7c14 ??? $06
    db   OAMF_XFLIP  | OAMF_PAL1, $62, $60                                 ;; 03:7c17 ??? $07

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
;@data format=bbb amount=8
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

;@data format=bbb amount=12
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
;@data format=bbb amount=8
metaspritesTable40Red:
    db   OAMF_XFLIP  | OAMF_PAL0, $4a, $48
    db   OAMF_NOFLIP | OAMF_PAL0, $48, $4a
    db   OAMF_NOFLIP | OAMF_PAL0, $44, $46
    db   OAMF_NOFLIP | OAMF_PAL0, $40, $42
    db   OAMF_XFLIP  | OAMF_PAL0, $4e, $4c
    db   OAMF_NOFLIP | OAMF_PAL0, $4c, $4e
    db   OAMF_XFLIP  | OAMF_PAL0, $46, $44
    db   OAMF_XFLIP  | OAMF_PAL0, $42, $40

;@data format=bbb amount=8
data_03_7cfe:
    db   OAMF_XFLIP  | OAMF_PAL1, $5a, $58
    db   OAMF_NOFLIP | OAMF_PAL1, $58, $5a
    db   OAMF_NOFLIP | OAMF_PAL1, $54, $56
    db   OAMF_NOFLIP | OAMF_PAL1, $50, $52
    db   OAMF_XFLIP  | OAMF_PAL1, $5e, $5c
    db   OAMF_NOFLIP | OAMF_PAL1, $5c, $5e
    db   OAMF_XFLIP  | OAMF_PAL1, $56, $54
    db   OAMF_XFLIP  | OAMF_PAL1, $52, $50

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

;@data format=bbb amount=12
metaspritesShadowZero:
    db   OAMF_XFLIP  | OAMF_PAL1, $6a, $68                                 ;; 03:7d6a ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1, $68, $6a                                 ;; 03:7d6d ??? $01
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7d70 ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7d73 ??? $03
    db   OAMF_XFLIP  | OAMF_PAL1, $6a, $68                                 ;; 03:7d76 ??? $04
    db   OAMF_NOFLIP | OAMF_PAL1, $68, $6a                                 ;; 03:7d79 ??? $05
    db   OAMF_NOFLIP | OAMF_PAL1, $64, $66                                 ;; 03:7d7c ??? $06
    db   OAMF_XFLIP  | OAMF_PAL1, $66, $64                                 ;; 03:7d7f ??? $07
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7d82 ??? $08
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7d85 ??? $09
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7d88 ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7d8b ??? $0b

;@data format=bbb amount=12
metaspritesEarthElemental:
    db   OAMF_NOFLIP | OAMF_PAL1, $50, $52                                 ;; 03:7d8e ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1, $54, $56                                 ;; 03:7d91 ??? $01
    db   OAMF_NOFLIP | OAMF_PAL1, $50, $52                                 ;; 03:7d94 ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1, $54, $56                                 ;; 03:7d97 ??? $03
    db   OAMF_XFLIP  | OAMF_PAL1, $5a, $58                                 ;; 03:7d9a ??? $04
    db   OAMF_NOFLIP | OAMF_PAL1, $58, $5a                                 ;; 03:7d9d ??? $05
    db   OAMF_XFLIP  | OAMF_PAL1, $56, $54                                 ;; 03:7da0 ??? $06
    db   OAMF_NOFLIP | OAMF_PAL1, $58, $5a                                 ;; 03:7da3 ??? $07
    db   OAMF_XFLIP  | OAMF_PAL1, $5a, $58                                 ;; 03:7da6 ??? $08
    db   OAMF_NOFLIP | OAMF_PAL1, $58, $5a                                 ;; 03:7da9 ??? $09
    db   OAMF_XFLIP  | OAMF_PAL1, $56, $54                                 ;; 03:7dac ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL1, $58, $5a                                 ;; 03:7daf ??? $0b

;@data format=bbb amount=12
metaspritesDoppelMirror:
    db   OAMF_XFLIP  | OAMF_PAL1, $56, $54                                 ;; 03:7db2 ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1, $54, $56                                 ;; 03:7db5 ??? $01
    db   OAMF_NOFLIP | OAMF_PAL1, $58, $5a                                 ;; 03:7db8 ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1, $50, $52                                 ;; 03:7dbb ??? $03
    db   OAMF_XFLIP  | OAMF_PAL1, $56, $54                                 ;; 03:7dbe ??? $04
    db   OAMF_NOFLIP | OAMF_PAL1, $54, $56                                 ;; 03:7dc1 ??? $05
    db   OAMF_NOFLIP | OAMF_PAL1, $58, $5a                                 ;; 03:7dc4 ??? $06
    db   OAMF_NOFLIP | OAMF_PAL1, $50, $52                                 ;; 03:7dc7 ??? $07
    db   OAMF_XFLIP  | OAMF_PAL1, $56, $54                                 ;; 03:7dca ??? $08
    db   OAMF_NOFLIP | OAMF_PAL1, $54, $56                                 ;; 03:7dcd ??? $09
    db   OAMF_NOFLIP | OAMF_PAL1, $58, $5a                                 ;; 03:7dd0 ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL1, $50, $52                                 ;; 03:7dd3 ??? $0b

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

;@data format=bbb amount=12
data_03_7dfa:
    db   OAMF_XFLIP  | OAMF_PAL1, $5a, $58                                 ;; 03:7dfa ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1, $58, $5a                                 ;; 03:7dfd ??? $01
    db   OAMF_NOFLIP | OAMF_PAL1, $54, $56                                 ;; 03:7e00 ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1, $50, $52                                 ;; 03:7e03 ??? $03
    db   OAMF_XFLIP  | OAMF_PAL1, $5e, $5c                                 ;; 03:7e06 ??? $04
    db   OAMF_NOFLIP | OAMF_PAL1, $5c, $5e                                 ;; 03:7e09 ??? $05
    db   OAMF_XFLIP  | OAMF_PAL1, $56, $54                                 ;; 03:7e0c ??? $06
    db   OAMF_XFLIP  | OAMF_PAL1, $52, $50                                 ;; 03:7e0f ??? $07
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7e12 ??? $08
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7e15 ??? $09
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7e18 ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7e1b ??? $0b

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

;@data format=bbb amount=12
metaspritesDeathGauntlet:
    db   OAMF_XFLIP  | OAMF_PAL1, $5a, $58                                 ;; 03:7e66 ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1, $58, $5a                                 ;; 03:7e69 ??? $01
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7e6c ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1, $50, $52                                 ;; 03:7e6f ??? $03
    db   OAMF_XFLIP  | OAMF_PAL1, $5e, $5c                                 ;; 03:7e72 ??? $04
    db   OAMF_NOFLIP | OAMF_PAL1, $5c, $5e                                 ;; 03:7e75 ??? $05
    db   OAMF_NOFLIP | OAMF_PAL1, $64, $66                                 ;; 03:7e78 ??? $06
    db   OAMF_NOFLIP | OAMF_PAL1, $54, $56                                 ;; 03:7e7b ??? $07
    db   OAMF_XFLIP  | OAMF_PAL1, $5e, $5c                                 ;; 03:7e7e ??? $08
    db   OAMF_NOFLIP | OAMF_PAL1, $5c, $5e                                 ;; 03:7e81 ??? $09
    db   OAMF_NOFLIP | OAMF_PAL1, $64, $66                                 ;; 03:7e84 ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL1, $54, $56                                 ;; 03:7e87 ??? $0b

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

;@data format=bbb amount=12
metaspritesTable5cUnmoving:
    db   OAMF_NOFLIP | OAMF_PAL1, $5c, $5e                                 ;; 03:7ed2 ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1, $5c, $5e                                 ;; 03:7ed5 ??? $01
    db   OAMF_NOFLIP | OAMF_PAL1, $5c, $5e                                 ;; 03:7ed8 ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1, $5c, $5e                                 ;; 03:7edb ??? $03
    db   OAMF_NOFLIP | OAMF_PAL1, $5c, $5e                                 ;; 03:7ede ??? $04
    db   OAMF_NOFLIP | OAMF_PAL1, $5c, $5e                                 ;; 03:7ee1 ??? $05
    db   OAMF_NOFLIP | OAMF_PAL1, $5c, $5e                                 ;; 03:7ee4 ??? $06
    db   OAMF_NOFLIP | OAMF_PAL1, $5c, $5e                                 ;; 03:7ee7 ??? $07
    db   OAMF_NOFLIP | OAMF_PAL1, $5c, $5e                                 ;; 03:7eea ??? $08
    db   OAMF_NOFLIP | OAMF_PAL1, $5c, $5e                                 ;; 03:7eed ??? $09
    db   OAMF_NOFLIP | OAMF_PAL1, $5c, $5e                                 ;; 03:7ef0 ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL1, $5c, $5e                                 ;; 03:7ef3 ??? $0b

metaspritesTable40Unmoving:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42

;@data format=bbb amount=12
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

;@data format=bbb amount=4
metaspritesWilly:
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7f86 ... $00
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7f89 ... $01
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7f8c ... $02
    db   OAMF_NOFLIP | OAMF_PAL1, $60, $62                                 ;; 03:7f8f ... $03

;@data format=bbb amount=8
; A variant of the data_03_7b96 metasprites table using OBP0 to turn certain enemies red.
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

;@data format=bbb amount=
; A variant of the data_03_7cfe metasprites table using OBP0 to turn certain npcs red.
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
