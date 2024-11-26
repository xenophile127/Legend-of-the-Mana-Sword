; Each boss is made up of 16px * 16px metasprites, just like virtually everything else in the game.
; Entries $0c and $0d are special for most because if a boss uses an explosion animation those are used.
; Ususally an explosion projectile is loaded (even if the boss does not use it) for those explosions.

metaspritesVampire:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42                                 ;; 04:7ba7 ??? $00
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $42, $40                                 ;; 04:7baa ??? $01
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46                                 ;; 04:7bad ??? $02
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4e, $4c                                 ;; 04:7bb0 ??? $03
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48                                 ;; 04:7bb3 ??? $04
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a                                 ;; 04:7bb6 ??? $05
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44                                 ;; 04:7bb9 ??? $06
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e                                 ;; 04:7bbc ??? $07
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52                                 ;; 04:7bbf ??? $08
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $52, $50                                 ;; 04:7bc2 ??? $09
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $56, $54                                 ;; 04:7bc5 ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $54, $56                                 ;; 04:7bc8 ??? $0b
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a                                 ;; 04:7bcb ??? $0c
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e                                 ;; 04:7bce ??? $0d

metaspritesHydraDragonZombie:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $58, $5a                                 ;; 04:7bd1 ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a                                 ;; 04:7bd4 ??? $01
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42                                 ;; 04:7bd7 ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46                                 ;; 04:7bda ??? $03
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e                                 ;; 04:7bdd ??? $04
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $60, $62                                 ;; 04:7be0 ??? $05
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52                                 ;; 04:7be3 ??? $06
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $6c, $6e                                 ;; 04:7be6 ??? $07
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $54, $56                                 ;; 04:7be9 ??? $08
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $68, $6a                                 ;; 04:7bec ??? $09
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $5c, $5e                                 ;; 04:7bef ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $64, $66                                 ;; 04:7bf2 ??? $0b
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a                                 ;; 04:7bf5 ??? $0c
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e                                 ;; 04:7bf8 ??? $0d
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e                                 ;; 04:7bfb ??? $0e

metaspritesMedusa:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e                                 ;; 04:7bfe ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46                                 ;; 04:7c01 ??? $01
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44                                 ;; 04:7c04 ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $6c, $6e                                 ;; 04:7c07 ??? $03
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $64, $66                                 ;; 04:7c0a ??? $04
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $66, $64                                 ;; 04:7c0d ??? $05
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52                                 ;; 04:7c10 ??? $06
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $58, $5a                                 ;; 04:7c13 ??? $07
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $62, $60                                 ;; 04:7c16 ??? $08
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $60, $62                                 ;; 04:7c19 ??? $09
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $5c, $5e                                 ;; 04:7c1c ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $5c, $5e                                 ;; 04:7c1f ??? $0b
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a                                 ;; 04:7c22 ??? $0c
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e                                 ;; 04:7c25 ??? $0d
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $68, $6a                                 ;; 04:7c28 ??? $0e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $58, $5a                                 ;; 04:7c2b ??? $0f
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $54, $56                                 ;; 04:7c2e ??? $10
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4e, $4c                                 ;; 04:7c31 ??? $11
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42                                 ;; 04:7c34 ??? $12
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a                                 ;; 04:7c37 ??? $13

metaspritesDavias:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e                                 ;; 04:7c3a ??? $00
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4e, $4c                                 ;; 04:7c3d ??? $01
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44                                 ;; 04:7c40 ??? $02
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48                                 ;; 04:7c43 ??? $03
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $42, $40                                 ;; 04:7c46 ??? $04
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42                                 ;; 04:7c49 ??? $05
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $5c, $5e                                 ;; 04:7c4c ??? $06
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46                                 ;; 04:7c4f ??? $07
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a                                 ;; 04:7c52 ??? $08
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52                                 ;; 04:7c55 ??? $09
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $58, $5a                                 ;; 04:7c58 ??? $0a
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44                                 ;; 04:7c5b ??? $0b
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a                                 ;; 04:7c5e ??? $0c
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e                                 ;; 04:7c61 ??? $0d
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32                                 ;; 04:7c64 ??? $0e
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $34, $36                                 ;; 04:7c67 ??? $0f
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $54, $56                                 ;; 04:7c6a ??? $10
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46                                 ;; 04:7c6d ??? $11

metaspritesGolemJackal:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42                                 ;; 04:7c70 ... $00
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46                                 ;; 04:7c73 ... $01
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a                                 ;; 04:7c76 ... $02
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4e, $4c                                 ;; 04:7c79 ... $03
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48                                 ;; 04:7c7c ... $04
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $42, $40                                 ;; 04:7c7f ... $05
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e                                 ;; 04:7c82 ... $06
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44                                 ;; 04:7c85 ... $07
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52                                 ;; 04:7c88 ... $08
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $54, $56                                 ;; 04:7c8b ... $09
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $5c, $5e                                 ;; 04:7c8e ... $0a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $58, $5a                                 ;; 04:7c91 ... $0b
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a                                 ;; 04:7c94 ... $0c
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e                                 ;; 04:7c97 ... $0d

metaspritesJulius2:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42                                 ;; 04:7c9a ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46                                 ;; 04:7c9d ??? $01
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $60, $62                                 ;; 04:7ca0 ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $5c, $5e                                 ;; 04:7ca3 ??? $03
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a                                 ;; 04:7ca6 ??? $04
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $42, $40                                 ;; 04:7ca9 ??? $05
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $62, $60                                 ;; 04:7cac ??? $06
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $62, $60                                 ;; 04:7caf ??? $07
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44                                 ;; 04:7cb2 ??? $08
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e                                 ;; 04:7cb5 ??? $09
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4e, $4c                                 ;; 04:7cb8 ??? $0a
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $52, $50                                 ;; 04:7cbb ??? $0b
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a                                 ;; 04:7cbe ??? $0c
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e                                 ;; 04:7cc1 ??? $0d
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a                                 ;; 04:7cc4 ??? $0e
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $5e, $5c                                 ;; 04:7cc7 ??? $0f
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48                                 ;; 04:7cca ??? $10
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $54, $56                                 ;; 04:7ccd ??? $11
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $58, $5a                                 ;; 04:7cd0 ??? $12
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52                                 ;; 04:7cd3 ??? $13

metaspritesCyclops:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $30, $32                                 ;; 04:7cd6 ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $34, $36                                 ;; 04:7cd9 ??? $01
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $38, $3a                                 ;; 04:7cdc ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $3c, $3e                                 ;; 04:7cdf ??? $03
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42                                 ;; 04:7ce2 ??? $04
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46                                 ;; 04:7ce5 ??? $05
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a                                 ;; 04:7ce8 ??? $06
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $54, $56                                 ;; 04:7ceb ??? $07
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52                                 ;; 04:7cee ??? $08
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e                                 ;; 04:7cf1 ??? $09
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $58, $5a                                 ;; 04:7cf4 ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $5c, $5e                                 ;; 04:7cf7 ??? $0b
; Cyclops explodes in a cloud of half morning stars and half random body part when defeated.
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $60, $62                                 ;; 04:7cfa ??? $0c
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $64, $66                           ;; 04:7cfd ??? $0d
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $66, $64                           ;; 04:7d00 ??? $0e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $68, $68                                 ;; 04:7d03 ??? $0f

metaspritesChimeraMantisAnt:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52                                 ;; 04:7d06 ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42                                 ;; 04:7d09 ??? $01
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $68, $6a                                 ;; 04:7d0c ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $6c, $6e                                 ;; 04:7d0f ??? $03
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a                                 ;; 04:7d12 ??? $04
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e                                 ;; 04:7d15 ??? $05
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52                                 ;; 04:7d18 ??? $06
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $68, $6a                                 ;; 04:7d1b ??? $07
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $54, $56                                 ;; 04:7d1e ??? $08
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $5c, $5e                                 ;; 04:7d21 ??? $09
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $60, $62                                 ;; 04:7d24 ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $58, $5a                                 ;; 04:7d27 ??? $0b
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a                                 ;; 04:7d2a ??? $0c
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e                                 ;; 04:7d2d ??? $0d
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $64, $66                                 ;; 04:7d30 ??? $0e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46                                 ;; 04:7d33 ??? $0f

; Does not use a death explosion animation.
metaspritesKary:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e                                 ;; 04:7d36 ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52                                 ;; 04:7d39 ??? $01
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $3c, $3e                                 ;; 04:7d3c ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a                                 ;; 04:7d3f ??? $03
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $54, $56                                 ;; 04:7d42 ??? $04
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $5a, $58                                 ;; 04:7d45 ??? $05
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $58, $5a                                 ;; 04:7d48 ??? $06
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $5c, $5e                                 ;; 04:7d4b ??? $07
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42                                 ;; 04:7d4e ??? $08
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $5e, $5c                                 ;; 04:7d51 ??? $09
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48                                 ;; 04:7d54 ??? $0a
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $56, $54                                 ;; 04:7d57 ??? $0b
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $38, $3a                                 ;; 04:7d5a ??? $0c
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $3c, $3e                                 ;; 04:7d5d ??? $0d
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46                                 ;; 04:7d60 ??? $0e
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $42, $40                                 ;; 04:7d63 ??? $0f
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44                                 ;; 04:7d66 ??? $10
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $64, $66                                 ;; 04:7d69 ??? $11
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $68, $6a                                 ;; 04:7d6c ??? $12
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $6c, $6e                                 ;; 04:7d6f ??? $13
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $62, $60                                 ;; 04:7d72 ??? $14
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $60, $62                                 ;; 04:7d75 ??? $15

metaspritesIflyteMetalCrab:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52                                 ;; 04:7d78 ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42                                 ;; 04:7d7b ??? $01
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $52, $50                                 ;; 04:7d7e ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46                                 ;; 04:7d81 ??? $03
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a                                 ;; 04:7d84 ??? $04
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e                                 ;; 04:7d87 ??? $05
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $62, $68                                 ;; 04:7d8a ??? $06
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $68, $62                                 ;; 04:7d8d ??? $07
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $42, $40                                 ;; 04:7d90 ??? $08
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44                                 ;; 04:7d93 ??? $09
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48                                 ;; 04:7d96 ??? $0a
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4e, $4c                                 ;; 04:7d99 ??? $0b
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a                                 ;; 04:7d9c ??? $0c
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e                                 ;; 04:7d9f ??? $0d
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $5c, $5e                                 ;; 04:7da2 ??? $0e
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $60, $62                                 ;; 04:7da5 ??? $0f
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $64, $66                                 ;; 04:7da8 ??? $10
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $68, $6a                                 ;; 04:7dab ??? $11
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $5e, $5c                                 ;; 04:7dae ??? $12
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $62, $60                                 ;; 04:7db1 ??? $13
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $66, $64                                 ;; 04:7db4 ??? $14
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $6a, $68                                 ;; 04:7db7 ??? $15
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $54, $56                                 ;; 04:7dba ??? $16
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $58, $5a                                 ;; 04:7dbd ??? $17
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $56, $54                                 ;; 04:7dc0 ??? $18
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $5a, $58                                 ;; 04:7dc3 ??? $19

; Garuda is changed to add two entries so that the death explosion uses the feather projectiles instead of random bits.
metaspritesGaruda:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $56, $54                                 ;; 04:7dc0 ??? $18
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $5a, $58                                 ;; 04:7dc3 ??? $19
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42                                 ;; 04:7dc6 ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $34, $36                                 ;; 04:7dc9 ??? $01
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $5c, $5e                                 ;; 04:7dcc ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $38, $3a                                 ;; 04:7dcf ??? $03
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $3c, $3e                                 ;; 04:7dd2 ??? $04
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46                                 ;; 04:7dd5 ??? $05
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a                                 ;; 04:7dd8 ??? $06
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e                                 ;; 04:7ddb ??? $07
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52                                 ;; 04:7dde ??? $08
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $54, $56                                 ;; 04:7de1 ??? $09

; These two entries are added for Garuda's projectile feathers.
; They are placed at exactly this spot so that the death explosion pattern uses them.
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32 ; Entry 0x0c
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $32, $30 ; Entry 0x0d

    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $58, $5a                                 ;; 04:7de4 ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $60, $62                                 ;; 04:7de7 ??? $0b
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $64, $66                                 ;; 04:7dea ??? $0c
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $68, $6a                                 ;; 04:7ded ??? $0d
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $6c, $6e                                 ;; 04:7df0 ??? $0e
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $36, $34                                 ;; 04:7df3 ??? $0f
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $3a, $38                                 ;; 04:7df6 ??? $10
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $3e, $3c                                 ;; 04:7df9 ??? $11
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $42, $40                                 ;; 04:7dfc ??? $12
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44                                 ;; 04:7dff ??? $13
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48                                 ;; 04:7e02 ??? $14
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4e, $4c                                 ;; 04:7e05 ??? $15
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $52, $50                                 ;; 04:7e08 ??? $16

; Ifrit/Metal Crab has identical entries at the end of their table, so use those instead.
;    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $56, $54                                 ;; 04:7e0b ??? $17
;    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $5a, $58                                 ;; 04:7e0e ??? $18

    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $5e, $5c                                 ;; 04:7e11 ??? $19
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $62, $60                                 ;; 04:7e14 ??? $1a
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $66, $64                                 ;; 04:7e17 ??? $1b
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $6a, $68                                 ;; 04:7e1a ??? $1c
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $6e, $6c                                 ;; 04:7e1d ??? $1d

; Does not use a death explosion animation because.
metaspritesDragon:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a                                 ;; 04:7e20 ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $38, $3a                                 ;; 04:7e23 ??? $01
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48                                 ;; 04:7e26 ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $3c, $3e                                 ;; 04:7e29 ??? $03
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42                                 ;; 04:7e2c ??? $04
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46                                 ;; 04:7e2f ??? $05
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e                                 ;; 04:7e32 ??? $06
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52                                 ;; 04:7e35 ??? $07
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $54, $56                                 ;; 04:7e38 ??? $08
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $58, $5a                                 ;; 04:7e3b ??? $09
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $5c, $5e                                 ;; 04:7e3e ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $60, $62                                 ;; 04:7e41 ??? $0b
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $64, $66                                 ;; 04:7e44 ??? $0c
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $68, $6a                                 ;; 04:7e47 ??? $0d
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $6c, $6e                                 ;; 04:7e4a ??? $0e
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $3a, $38                                 ;; 04:7e4d ??? $0f
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $3e, $3c                                 ;; 04:7e50 ??? $10
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $42, $40                                 ;; 04:7e53 ??? $11
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44                                 ;; 04:7e56 ??? $12
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4e, $4c                                 ;; 04:7e59 ??? $13
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $52, $50                                 ;; 04:7e5c ??? $14
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $56, $54                                 ;; 04:7e5f ??? $15
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $5a, $58                                 ;; 04:7e62 ??? $16
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $5e, $5c                                 ;; 04:7e65 ??? $17
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $62, $60                                 ;; 04:7e68 ??? $18
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $66, $64                                 ;; 04:7e6b ??? $19
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $6a, $68                                 ;; 04:7e6e ??? $1a
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $6e, $6c                                 ;; 04:7e71 ??? $1b

; Lich is changed to add two entries so that the death explosion uses the skull projectiles instead of random bits.
; This means changes to a lot of how both Lich and Kraken are arranged.
metaspritesLich:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $38, $3a                                 ;; 04:7e74 ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $3c, $3e                                 ;; 04:7e77 ??? $01
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42                                 ;; 04:7e7a ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46                                 ;; 04:7e7d ??? $03
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a                                 ;; 04:7e80 ??? $04
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e                                 ;; 04:7e83 ??? $05
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52                                 ;; 04:7e86 ??? $06
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $54, $56                                 ;; 04:7e89 ??? $07
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $58, $5a                                 ;; 04:7e8c ??? $08
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $5c, $5e                                 ;; 04:7e8f ??? $09
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $60, $62                                 ;; 04:7e92 ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $64, $66                                 ;; 04:7e95 ??? $0b

; These two entries are added for Lich's projectile skulls.
; They are placed at exactly this spot so that the death explosion pattern uses them.
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32 ; Entry 0x0c
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32 ; Entry 0x0d

    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $68, $6a                                 ;; 04:7e98 ??? $0c
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $6c, $6e                                 ;; 04:7e9b ??? $0d
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $3a, $38                                 ;; 04:7e9e ??? $0e
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $3e, $3c                                 ;; 04:7ea1 ??? $0f

; Kraken (the next boss) has an identical entry, so use Kraken's.
;    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $42, $40                                 ;; 04:7ea4 ??? $10
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44                                 ;; 04:7ea7 ??? $11
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48                                 ;; 04:7eaa ??? $12
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4e, $4c                                 ;; 04:7ead ??? $13
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $52, $50                                 ;; 04:7eb0 ??? $14
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $56, $54                                 ;; 04:7eb3 ??? $15
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $5a, $58                                 ;; 04:7eb6 ??? $16
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $5e, $5c                                 ;; 04:7eb9 ??? $17
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $62, $60                                 ;; 04:7ebc ??? $18
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $66, $64                                 ;; 04:7ebf ??? $19
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $6a, $68                                 ;; 04:7ec2 ??? $1a
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $6e, $6c                                 ;; 04:7ec5 ??? $1b

; Rearranged to allow changes for the previous boss, Lich.
metaspritesKraken:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $46, $48                                 ;; 04:7ec8 ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $3a, $3c                                 ;; 04:7ecb ??? $01
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $44, $42                                 ;; 04:7ece ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $3e, $40                                 ;; 04:7ed1 ??? $03
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $42, $44                                 ;; 04:7ed4 ??? $04
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $3a, $4a                                 ;; 04:7ed7 ??? $05
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e                                 ;; 04:7eda ??? $06
; Unused so remove to make space for one of the added Lich explosion sprites.
;    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $3a                                 ;; 04:7edd ??? $07
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52                                 ;; 04:7ee0 ??? $08
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $54, $56                                 ;; 04:7ee3 ??? $09
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $58, $5a                                 ;; 04:7ee6 ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $5c, $5e                                 ;; 04:7ee9 ??? $0b
; Moved so the next two entries are in an unchanged location.
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $68, $6a                                 ;; 04:7ef2 ??? $0e

; These two entries are placed at exactly this spot so that the death explosion pattern uses them.
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $30, $32                                 ;; 04:7eec ??? $0c
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $34, $36                                 ;; 04:7eef ??? $0d

    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $6c, $6e                                 ;; 04:7ef5 ??? $0f
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $3c, $3a                                 ;; 04:7ef8 ??? $10
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $40, $3e                                 ;; 04:7efb ??? $11
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $48, $46                                 ;; 04:7efe ??? $12
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4e, $4c                                 ;; 04:7f01 ??? $13
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $52, $50                                 ;; 04:7f04 ??? $14
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $56, $54                                 ;; 04:7f07 ??? $15
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $5a, $58                                 ;; 04:7f0a ??? $16
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $5e, $5c                                 ;; 04:7f0d ??? $17
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $62, $60                                 ;; 04:7f10 ??? $18
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $3a, $3a                                 ;; 04:7f13 ??? $19
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $6a, $68                                 ;; 04:7f16 ??? $1a
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $6e, $6c                                 ;; 04:7f19 ??? $1b
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $66, $64                                 ;; 04:7f1c ??? $1c
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $60, $62                                 ;; 04:7f1f ??? $1d
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $64, $66                                 ;; 04:7f22 ??? $1e

metaspritesMegapede:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42                                 ;; 04:7f25 ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46                                 ;; 04:7f28 ??? $01
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a                                 ;; 04:7f2b ??? $02
    db   OAMF_YFLIP  | OAMF_PAL1 | PAL_NPC1, $40, $42                                 ;; 04:7f2e ??? $03
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $46, $44                                 ;; 04:7f31 ??? $04
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_NPC1, $4a, $48                                 ;; 04:7f34 ??? $05
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52                                 ;; 04:7f37 ??? $06
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e                                 ;; 04:7f3a ??? $07
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $54, $56                                 ;; 04:7f3d ??? $08
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $58, $5a                                 ;; 04:7f40 ??? $09
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $5c, $5e                                 ;; 04:7f43 ??? $0a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a                                 ;; 04:7f46 ??? $0b
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a                                 ;; 04:7f49 ??? $0c
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e                                 ;; 04:7f4c ??? $0d

metaspritesJulius3:
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $44, $46                                 ;; 04:7f4f ??? $00
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $40, $42                                 ;; 04:7f52 ??? $01
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $48, $4a                                 ;; 04:7f55 ??? $02
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $4c, $4e                                 ;; 04:7f58 ??? $03
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $50, $52                                 ;; 04:7f5b ??? $04
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_NPC1, $54, $56                                 ;; 04:7f5e ??? $05
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $58, $5a                                 ;; 04:7f61 ??? $06
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $5c, $5e                                 ;; 04:7f64 ??? $07
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $5a, $58                                 ;; 04:7f67 ??? $08
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $5e, $5c                                 ;; 04:7f6a ??? $09
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $5e, $5c                                 ;; 04:7f6d ??? $0a
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $5e, $5c                                 ;; 04:7f70 ??? $0b
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a                                 ;; 04:7f73 ??? $0c
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e                                 ;; 04:7f76 ??? $0d
