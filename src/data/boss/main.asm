;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy


; Boss data table, 24 bytes per entry. Data is loaded from here on a boss spawn, but not on an NPC spawn.
; offset 0: speed (delay between actions, low=fast)
; offset 1: HP
; offset 2: XP on defeated
; offset 3: Money on defeated
; offset 4: Amount of 16x16 "objects" used for this boss
; offset 5: Projectile attack from the projectiles dataset (also causes the graphics to be loaded for this projectile)
; offset 6-7: index to script when defeated (usually just some simple screen flash or nothing)
; offset 8: graphics related, sets the VRAM start tile number to load graphics data into
; offset 9: graphics related, sets how many tiles need to be loaded into VRAM
; offset a-b: graphics related, pointer including bank, allowing everything from bank $08 to $0B to be selected for graphics.
; offset c-d: graphics related, points to data of which tile offsets to load from the previous pointer into VRAM
; offset e-f: metatile info (list of [attr, tile1, tile2])
; offset 10-11: pointer to stats for each of the 16x16 "objects" used for this boss. Eight bytes per object:
; * offset 0: collision flags (unused--$20 is always used regardless of the value in the table)
; * offset 1: elemental immunities
; * offset 2: weaknesses (see npc/stats.asm)
; * offset 3: attack power
; * offset 4: defense power
; * offset 5: unknown
; * offset 6: tatus Effect on touch
; * offset 7: unknown
; offset 12-13: attack movement pattern
; offset 14-15: spawn movement pattern
; offset 16-17: death animation pattern
;@boss_data amount=21
bossDataTable:
    BOSS_HEADER $08, $19, $14, $0a, $08, $1e, script_0246 ;; 04:4739 ????????
      BOSS_HEADER_GFX $40, $0d, bossGfxVampire, tileorderVampire, metaspritesVampire ;; 04:4741 ????????
      dw statsVampire, data_04_4e21, data_04_4df1, data_04_5435 ;; 04:4749 ????????
    BOSS_HEADER $0a, $14, $0a, $5a, $07, $1f, script_0246 ;; 04:4751 ????????
      BOSS_HEADER_GFX $40, $18, gfxBossHydra, tileorderHydraDragonZombie, metaspritesHydraDragonZombie ;; 04:4759 ????????
      dw statsHydra, data_04_4e37, data_04_4e37, data_04_54bb ;; 04:4761 ????????
    BOSS_HEADER $06, $3b, $55, $46, $04, $20, script_0246 ;; 04:4769 ????????
      BOSS_HEADER_GFX $40, $18, bossGfxMedusa, tileorderCommon, metaspritesMedusa ;; 04:4771 ????????
      dw statsMedusa, data_04_4e75, data_04_4e75, data_04_5503 ;; 04:4779 ????????
    BOSS_HEADER $0a, $1c, $2c, $96, $0b, $16, script_0246 ;; 04:4781 ????????
      BOSS_HEADER_GFX $40, $10, bossGfxMegapede, tileorderCommon, metaspritesMegapede ;; 04:4789 ????????
      dw statsMegapede, data_04_525b, data_04_4e09, data_04_5541 ;; 04:4791 ????????
    BOSS_HEADER $08, $4b, $5a, $64, $08, $26, script_0246 ;; 04:4799 ????????
      BOSS_HEADER_GFX $40, $14, bossGfxDavias, tileorderDavias, metaspritesDavias ;; 04:47a1 ????????
      dw statsDavias, data_04_4edb, data_04_4edb, data_04_5575 ;; 04:47a9 ????????
    BOSS_HEADER $04, $8f, $60, $a0, $06, $16, script_0246 ;; 04:47b1 ????????
      BOSS_HEADER_GFX $40, $10, bossGfxGolem, tileorderCommon, metaspritesGolemJackal ;; 04:47b9 ????????
      dw statsGolem, data_04_4ee7, data_04_4ee7, data_04_5473 ;; 04:47c1 ????????
    BOSS_HEADER $06, $6f, $46, $3c, $07, $ff, script_0247 ;; 04:47c9 ????????
      BOSS_HEADER_GFX $30, $1d, bossGfxCyclops, tileorderCyclops, metaspritesCyclops ;; 04:47d1 ????????
      dw statsCyclops, data_04_4fdd, data_04_4fdd, data_04_5435 ;; 04:47d9 ????????
    BOSS_HEADER $04, $70, $14, $58, $06, $23, script_0246 ;; 04:47e1 ????????
      BOSS_HEADER_GFX $40, $18, bossGfxChimera, tileorderCommon, metaspritesChimeraMantisAnt ;; 04:47e9 ????????
      dw statsChimera, data_04_504d, data_04_504d, data_04_55b3 ;; 04:47f1 ????????
    BOSS_HEADER $08, $79, $a6, $78, $09, $0d, script_024f ;; 04:47f9 ????????
      BOSS_HEADER_GFX $3c, $1a, bossGfxKary, tileorderKary, metaspritesKary ;; 04:4801 ????????
      dw statsKary, data_04_509f, data_04_509f, data_04_56b2 ;; 04:4809 ????????
    BOSS_HEADER $0c, $7d, $be, $78, $0a, $14, script_0247 ;; 04:4811 ????????
      BOSS_HEADER_GFX $3a, $1b, bossGfxKraken, tileorderKraken, metaspritesKraken ;; 04:4819 ????????
      dw statsKraken, data_04_5231, data_04_4dfd, data_04_56b9 ;; 04:4821 ????????
    BOSS_HEADER $06, $92, $c8, $fa, $07, $16, script_0247 ;; 04:4829 ????????
      BOSS_HEADER_GFX $40, $18, bossGfxIflyte, tileorderIflyteMetalCrab, metaspritesIflyteMetalCrab ;; 04:4831 ????????
      dw statsIflyte, data_04_50f1, data_04_50f1, data_04_566d ;; 04:4839 ????????
    BOSS_HEADER $0a, $76, $b2, $c8, $07, $22, script_0247 ;; 04:4841 ????????
      BOSS_HEADER_GFX $38, $1c, bossGfxLich, tileorderLich, metaspritesLich ;; 04:4849 ????????
      dw statsLich, data_04_5171, data_04_5171, data_04_5435 ;; 04:4851 ????????
    BOSS_HEADER $04, $bb, $d2, $fa, $08, $21, script_0247 ;; 04:4859 ????????
      BOSS_HEADER_GFX $34, $1e, bossGfxGaruda, tileorderGaruda, metaspritesGaruda ;; 04:4861 ????????
      dw statsGaruda, data_04_5127, data_04_5127, data_04_5435 ;; 04:4869 ????????
    BOSS_HEADER $08, $6a, $00, $fa, $09, $14, script_024f ;; 04:4871 ????????
      BOSS_HEADER_GFX $38, $1c, bossGfxDragon, tileorderDragon, metaspritesDragon ;; 04:4879 ????????
      dw statsDragon, data_04_5165, data_04_5165, data_04_56ab ;; 04:4881 ????????
    BOSS_HEADER $05, $da, $00, $a0, $0b, $24, script_0246 ;; 04:4889 ????????
      BOSS_HEADER_GFX $40, $12, bossGfxJulius2, tileorderJulius2, metaspritesJulius2 ;; 04:4891 ????????
      dw statsJulius2, data_04_4f77, data_04_4f77, data_04_55f1 ;; 04:4899 ????????
    BOSS_HEADER $08, $ce, $00, $fa, $07, $27, script_0247 ;; 04:48a1 ????????
      BOSS_HEADER_GFX $40, $18, bossGfxDragonZombie, tileorderHydraDragonZombie, metaspritesHydraDragonZombie ;; 04:48a9 ????????
      dw statsDragonZombie, data_04_4e37, data_04_4e37, data_04_54bb ;; 04:48b1 ????????
; Give Jackal a bit of money to drop.
    BOSS_HEADER $05, $02, $00, $18, $06, $16, script_0246 ;; 04:48b9 ........
      BOSS_HEADER_GFX $40, $10, bossGfxJackal, tileorderCommon, metaspritesGolemJackal ;; 04:48c1 ........
      dw statsJackal, data_04_4f4d, data_04_4e15, data_04_5473 ;; 04:48c9 ........
    BOSS_HEADER $04, $ff, $00, $a0, $08, $25, script_0246 ;; 04:48d1 ????????
      BOSS_HEADER_GFX $40, $10, bossGfxJulius3, tileorderJulius3, metaspritesJulius3 ;; 04:48d9 ????????
      dw statsJulius3, data_04_531b, data_04_531b, data_04_562f ;; 04:48e1 ????????
    BOSS_HEADER $0a, $51, $64, $64, $07, $16, script_0247 ;; 04:48e9 ????????
      BOSS_HEADER_GFX $40, $18, bossGfxMetalCrab, tileorderIflyteMetalCrab, metaspritesIflyteMetalCrab ;; 04:48f1 ????????
      dw statsMetalCrab, data_04_50fd, data_04_50fd, data_04_566d ;; 04:48f9 ????????
    BOSS_HEADER $08, $af, $c7, $dc, $06, $ff, script_0246 ;; 04:4901 ????????
      BOSS_HEADER_GFX $40, $18, bossGfxMantisAnt, tileorderCommon, metaspritesChimeraMantisAnt ;; 04:4909 ????????
      dw statsMantisAnt, data_04_504d, data_04_504d, data_04_55b3 ;; 04:4911 ????????
    BOSS_HEADER $08, $bb, $00, $fa, $09, $14, script_024f ;; 04:4919 ????????
      BOSS_HEADER_GFX $38, $1c, bossGfxDragon, tileorderDragon, metaspritesDragon ;; 04:4921 ????????
      dw statsDragon, data_04_5165, data_04_5165, data_04_56ab ;; 04:4929 ????????

statsVampire:
    db   $20, $90, $01, $1a, $08, $11, $00, $01        ;; 04:4931 ????????
    db   $20, $90, $01, $1a, $08, $11, $00, $01        ;; 04:4939 ????????
    db   $20, $90, $01, $1a, $08, $11, $00, $01        ;; 04:4941 ????????
    db   $20, $90, $01, $1a, $08, $11, $00, $01        ;; 04:4949 ????????
    db   $20, $90, $01, $1c, $1a, $0a, $00, $01        ;; 04:4951 ????????
    db   $20, $90, $01, $1c, $1a, $0a, $00, $01        ;; 04:4959 ????????
    db   $20, $90, $01, $1c, $1a, $0a, $00, $01        ;; 04:4961 ????????
    db   $20, $90, $01, $1c, $1a, $0a, $00, $01        ;; 04:4969 ????????

statsHydra:
    db   $20, $ff, $00, $16, $19, $10, $00, $00        ;; 04:4971 ????????
    db   $20, $90, $00, $16, $01, $10, $00, $00        ;; 04:4979 ????????
    db   $20, $98, $00, $16, $17, $10, $00, $00        ;; 04:4981 ????????
    db   $20, $98, $00, $16, $17, $10, $00, $00        ;; 04:4989 ????????
    db   $20, $98, $00, $16, $17, $10, $00, $00        ;; 04:4991 ????????
    db   $20, $98, $00, $16, $17, $10, $00, $00        ;; 04:4999 ????????
    db   $20, $98, $00, $16, $17, $10, $00, $00        ;; 04:49a1 ????????

statsDragonZombie:
    db   $20, $ff, $00, $be, $08, $08, $00, $00        ;; 04:49a9 ????????
    db   $20, $90, $01, $c8, $1c, $3f, $00, $00        ;; 04:49b1 ????????
    db   $20, $90, $01, $c8, $1c, $3f, $00, $00        ;; 04:49b9 ????????
    db   $20, $ff, $00, $be, $08, $08, $00, $00        ;; 04:49c1 ????????
    db   $20, $ff, $00, $be, $08, $08, $00, $00        ;; 04:49c9 ????????
    db   $20, $ff, $00, $be, $08, $08, $00, $00        ;; 04:49d1 ????????
    db   $20, $ff, $00, $be, $08, $08, $00, $00        ;; 04:49d9 ????????

statsMedusa:
    db   $20, $f0, $00, $4e, $32, $32, $00, $04        ;; 04:49e1 ????????
    db   $20, $f0, $00, $4e, $08, $12, $00, $04        ;; 04:49e9 ????????
    db   $20, $f0, $00, $4e, $08, $12, $00, $04        ;; 04:49f1 ????????
    db   $20, $f0, $00, $4e, $32, $32, $00, $04        ;; 04:49f9 ????????

statsDavias:
    db   $20, $10, $00, $5d, $0a, $01, $00, $00        ;; 04:4a01 ????????
    db   $20, $10, $00, $5d, $01, $16, $00, $00        ;; 04:4a09 ????????
    db   $20, $10, $00, $5d, $01, $16, $00, $00        ;; 04:4a11 ????????
    db   $20, $10, $00, $5d, $0a, $01, $00, $00        ;; 04:4a19 ????????
    db   $20, $ff, $00, $49, $1c, $1f, $00, $00        ;; 04:4a21 ????????
    db   $20, $ff, $00, $49, $1c, $1f, $00, $00        ;; 04:4a29 ????????
    db   $20, $ff, $00, $49, $1c, $1f, $00, $00        ;; 04:4a31 ????????
    db   $20, $ff, $00, $49, $1c, $1f, $00, $00        ;; 04:4a39 ????????

statsGolem:
    db   $20, $fb, $00, $5c, $04, $02, $00, $00        ;; 04:4a41 ????????
    db   $20, $fb, $00, $5c, $04, $02, $00, $00        ;; 04:4a49 ????????
    db   $20, $fb, $00, $5c, $04, $02, $00, $00        ;; 04:4a51 ????????
    db   $20, $fb, $00, $5c, $04, $02, $00, $00        ;; 04:4a59 ????????
    db   $20, $fb, $00, $00, $04, $02, $00, $00        ;; 04:4a61 ????????
    db   $20, $fb, $00, $00, $04, $02, $00, $00        ;; 04:4a69 ????????

statsJulius2:
    db   $20, $90, $00, $a0, $45, $3a, $00, $00        ;; 04:4a71 ????????
    db   $20, $90, $00, $a0, $45, $3a, $00, $00        ;; 04:4a79 ????????
    db   $20, $90, $00, $a0, $45, $3a, $00, $00        ;; 04:4a81 ????????
    db   $20, $90, $00, $a0, $45, $3a, $00, $00        ;; 04:4a89 ????????
    db   $20, $90, $00, $a0, $45, $3a, $00, $00        ;; 04:4a91 ????????
    db   $20, $90, $00, $a0, $45, $3a, $00, $00        ;; 04:4a99 ????????
    db   $20, $90, $00, $a0, $45, $3a, $00, $00        ;; 04:4aa1 ????????
    db   $20, $90, $00, $a0, $45, $3a, $00, $00        ;; 04:4aa9 ????????
    db   $20, $90, $00, $a0, $45, $3a, $00, $00        ;; 04:4ab1 ????????
    db   $20, $90, $00, $a0, $45, $3a, $00, $00        ;; 04:4ab9 ????????
    db   $20, $90, $00, $a0, $45, $3a, $00, $00        ;; 04:4ac1 ????????

statsCyclops:
    db   $20, $f0, $00, $69, $08, $0e, $00, $00        ;; 04:4ac9 ????????
    db   $20, $f0, $00, $69, $08, $0e, $00, $00        ;; 04:4ad1 ????????
    db   $20, $f0, $00, $69, $08, $0e, $00, $00        ;; 04:4ad9 ????????
    db   $20, $f0, $00, $69, $16, $29, $00, $00        ;; 04:4ae1 ????????
    db   $20, $f0, $00, $69, $16, $29, $00, $00        ;; 04:4ae9 ????????
    db   $20, $ff, $00, $9b, $20, $1f, $00, $00        ;; 04:4af1 ????????
    db   $20, $ff, $00, $9b, $20, $1f, $00, $00        ;; 04:4af9 ????????

statsChimera:
    db   $20, $f0, $00, $5c, $04, $23, $00, $00        ;; 04:4b01 ????????
    db   $20, $f0, $00, $5c, $04, $23, $00, $00        ;; 04:4b09 ????????
    db   $20, $f0, $00, $5c, $04, $23, $00, $00        ;; 04:4b11 ????????
    db   $20, $f0, $00, $5c, $04, $23, $00, $00        ;; 04:4b19 ????????
    db   $20, $f0, $00, $5c, $04, $23, $00, $00        ;; 04:4b21 ????????
    db   $20, $f0, $00, $5c, $04, $23, $00, $00        ;; 04:4b29 ????????

statsKary:
    db   $20, $d0, $80, $64, $10, $23, $00, $00        ;; 04:4b31 ????????
    db   $20, $ff, $80, $64, $43, $30, $00, $00        ;; 04:4b39 ????????
    db   $20, $ff, $80, $64, $43, $30, $00, $00        ;; 04:4b41 ????????
    db   $20, $ff, $80, $64, $43, $30, $00, $00        ;; 04:4b49 ????????
    db   $20, $ff, $80, $64, $43, $30, $00, $00        ;; 04:4b51 ????????
    db   $20, $ff, $80, $64, $43, $30, $00, $00        ;; 04:4b59 ????????
    db   $20, $ff, $80, $a0, $43, $30, $00, $00        ;; 04:4b61 ????????
    db   $20, $ff, $80, $64, $43, $30, $00, $00        ;; 04:4b69 ????????
    db   $20, $ff, $80, $64, $43, $30, $00, $00        ;; 04:4b71 ????????

statsIflyte:
    db   $20, $8a, $40, $81, $10, $10, $00, $00        ;; 04:4b79 ????????
    db   $20, $ff, $40, $81, $08, $08, $00, $00        ;; 04:4b81 ????????
    db   $20, $ff, $40, $81, $08, $08, $00, $00        ;; 04:4b89 ????????
    db   $20, $ff, $40, $81, $08, $08, $00, $00        ;; 04:4b91 ????????
    db   $20, $ff, $40, $81, $08, $08, $00, $00        ;; 04:4b99 ????????
    db   $20, $ff, $40, $81, $08, $08, $00, $00        ;; 04:4ba1 ????????
    db   $20, $ff, $40, $81, $08, $08, $00, $00        ;; 04:4ba9 ????????

statsGaruda:
    db   $20, $90, $00, $96, $12, $3f, $00, $00        ;; 04:4bb1 ????????
    db   $20, $90, $00, $96, $12, $3f, $00, $00        ;; 04:4bb9 ????????
    db   $20, $90, $00, $96, $12, $3f, $00, $00        ;; 04:4bc1 ????????
    db   $20, $90, $00, $96, $12, $3f, $00, $00        ;; 04:4bc9 ????????
    db   $20, $90, $00, $96, $12, $3f, $00, $00        ;; 04:4bd1 ????????
    db   $20, $90, $00, $96, $12, $3f, $00, $00        ;; 04:4bd9 ????????
    db   $20, $90, $00, $96, $12, $3f, $00, $00        ;; 04:4be1 ????????
    db   $20, $90, $00, $96, $12, $3f, $00, $00        ;; 04:4be9 ????????

statsDragon:
    db   $20, $ff, $00, $90, $14, $33, $00, $00        ;; 04:4bf1 ????????
    db   $20, $ff, $00, $90, $14, $33, $00, $00        ;; 04:4bf9 ????????
    db   $20, $ff, $00, $90, $14, $33, $00, $00        ;; 04:4c01 ????????
    db   $20, $ff, $00, $90, $14, $33, $00, $00        ;; 04:4c09 ????????
    db   $20, $ff, $00, $90, $14, $33, $00, $00        ;; 04:4c11 ????????
    db   $20, $ff, $00, $90, $14, $33, $00, $00        ;; 04:4c19 ????????
    db   $20, $ff, $00, $90, $14, $33, $00, $00        ;; 04:4c21 ????????
    db   $20, $ff, $00, $90, $14, $33, $00, $00        ;; 04:4c29 ????????
    db   $20, $90, $02, $ae, $14, $33, $00, $00        ;; 04:4c31 ????????

statsLich:
    db   $20, $90, $01, $9c, $1d, $21, $00, $00        ;; 04:4c39 ????????
    db   $20, $90, $01, $9c, $1d, $21, $00, $00        ;; 04:4c41 ????????
    db   $20, $90, $01, $9c, $1d, $21, $00, $00        ;; 04:4c49 ????????
    db   $20, $90, $01, $9c, $1d, $21, $00, $00        ;; 04:4c51 ????????
    db   $20, $90, $01, $9c, $1d, $21, $00, $00        ;; 04:4c59 ????????
    db   $20, $90, $01, $9c, $1d, $21, $00, $00        ;; 04:4c61 ????????
    db   $20, $90, $01, $9c, $1d, $21, $00, $00        ;; 04:4c69 ????????

statsKraken:
    db   $20, $90, $00, $8c, $02, $02, $00, $00        ;; 04:4c71 ????????
    db   $20, $90, $00, $8c, $02, $02, $00, $00        ;; 04:4c79 ????????
    db   $20, $90, $00, $8c, $02, $02, $00, $00        ;; 04:4c81 ????????
    db   $20, $90, $00, $8c, $02, $02, $00, $00        ;; 04:4c89 ????????
    db   $20, $ff, $00, $8c, $41, $32, $00, $00        ;; 04:4c91 ????????
    db   $20, $ff, $00, $8c, $41, $32, $00, $00        ;; 04:4c99 ????????
    db   $20, $ff, $00, $8c, $41, $32, $00, $00        ;; 04:4ca1 ????????
    db   $20, $ff, $00, $8c, $41, $32, $00, $00        ;; 04:4ca9 ????????
    db   $20, $ff, $00, $8c, $41, $32, $00, $00        ;; 04:4cb1 ????????
    db   $20, $ff, $00, $8c, $41, $32, $00, $00        ;; 04:4cb9 ????????

statsMegapede:
    db   $20, $90, $00, $21, $0a, $14, $00, $00        ;; 04:4cc1 ????????
    db   $20, $ff, $00, $21, $0c, $1e, $00, $00        ;; 04:4cc9 ????????
    db   $20, $ff, $00, $21, $0c, $1e, $00, $00        ;; 04:4cd1 ????????
    db   $20, $ff, $00, $21, $0c, $1e, $00, $00        ;; 04:4cd9 ????????
    db   $20, $ff, $00, $21, $0c, $1e, $00, $00        ;; 04:4ce1 ????????
    db   $20, $ff, $00, $21, $0c, $1e, $00, $00        ;; 04:4ce9 ????????
    db   $20, $ff, $00, $21, $0c, $1e, $00, $00        ;; 04:4cf1 ????????
    db   $20, $ff, $00, $21, $0c, $1e, $00, $00        ;; 04:4cf9 ????????
    db   $20, $ff, $00, $21, $0c, $1e, $00, $00        ;; 04:4d01 ????????
    db   $20, $ff, $00, $21, $0c, $1e, $00, $00        ;; 04:4d09 ????????
    db   $20, $ff, $00, $21, $0c, $1e, $00, $00        ;; 04:4d11 ????????

statsJackal:
    db   $20, $00, $00, $08, $02, $02, $00, $00        ;; 04:4d19 ?..?.???
    db   $20, $00, $00, $08, $02, $02, $00, $00        ;; 04:4d21 ????????
    db   $20, $00, $00, $08, $02, $02, $00, $00        ;; 04:4d29 ????????
    db   $20, $00, $00, $08, $02, $02, $00, $00        ;; 04:4d31 ?..?.???
    db   $20, $00, $00, $00, $03, $02, $00, $00        ;; 04:4d39 ???.??.?
    db   $20, $00, $00, $00, $03, $02, $00, $00        ;; 04:4d41 ????????

statsJulius3:
    db   $20, $92, $00, $bc, $45, $3a, $00, $00        ;; 04:4d49 ????????
    db   $20, $92, $00, $bc, $45, $3a, $00, $00        ;; 04:4d51 ????????
    db   $20, $92, $00, $bc, $45, $3a, $00, $00        ;; 04:4d59 ????????
    db   $20, $92, $00, $bc, $45, $3a, $00, $00        ;; 04:4d61 ????????
    db   $20, $92, $00, $bc, $45, $3a, $00, $00        ;; 04:4d69 ????????
    db   $20, $92, $00, $bc, $45, $3a, $00, $00        ;; 04:4d71 ????????
    db   $20, $ff, $00, $bc, $45, $3a, $00, $00        ;; 04:4d79 ????????
    db   $20, $ff, $00, $bc, $45, $3a, $00, $00        ;; 04:4d81 ????????

statsMetalCrab:
    db   $20, $90, $00, $4d, $04, $08, $00, $00        ;; 04:4d89 ????????
    db   $20, $ff, $00, $4d, $01, $01, $00, $00        ;; 04:4d91 ????????
    db   $20, $ff, $00, $4d, $01, $01, $00, $00        ;; 04:4d99 ????????
    db   $20, $ff, $00, $4d, $01, $01, $00, $00        ;; 04:4da1 ????????
    db   $20, $ff, $00, $4d, $01, $01, $00, $00        ;; 04:4da9 ????????
    db   $20, $ff, $00, $4d, $01, $01, $00, $00        ;; 04:4db1 ????????
    db   $20, $ff, $00, $4d, $01, $01, $00, $00        ;; 04:4db9 ????????

statsMantisAnt:
    db   $20, $f0, $00, $79, $28, $35, $00, $00        ;; 04:4dc1 ????????
    db   $20, $f0, $00, $79, $28, $35, $00, $00        ;; 04:4dc9 ????????
    db   $20, $f0, $00, $79, $28, $35, $00, $00        ;; 04:4dd1 ????????
    db   $20, $f0, $00, $79, $28, $35, $00, $00        ;; 04:4dd9 ????????
    db   $20, $f0, $00, $79, $28, $35, $00, $00        ;; 04:4de1 ????????
    db   $20, $f0, $00, $79, $28, $35, $00, $00        ;; 04:4de9 ????????

data_04_4df1:
    dw   data_04_56f7, data_04_56f7, data_04_56f7, data_04_56f7 ;; 04:4df1 ????????
    db   $0a, $00                                      ;; 04:4df9 ??
    db   $ff, $ff                                      ;; 04:4dfb ??

data_04_4dfd:
    dw   data_04_6752, data_04_6752, data_04_6752, data_04_6752 ;; 04:4dfd ????????
    db   $08, $0c                                      ;; 04:4e05 ??
    db   $ff, $ff                                      ;; 04:4e07 ??

data_04_4e09:
    dw   data_04_6855, data_04_6855, data_04_6855, data_04_6855 ;; 04:4e09 ????????
    db   $1f, $15                                      ;; 04:4e11 ??
    db   $ff, $ff                                      ;; 04:4e13 ??

data_04_4e15:
    dw   data_04_5dc1, data_04_5dc1, data_04_5dc1, data_04_5dc1 ;; 04:4e15 ..??..??
    db   $0a, $02                                      ;; 04:4e1d ..
    db   $ff, $ff                                      ;; 04:4e1f ..

data_04_4e21:
    dw   data_04_570c, data_04_570c, data_04_5735, data_04_5735 ;; 04:4e21 ????????
    db   $04, $06                                      ;; 04:4e29 ??
    dw   data_04_575e, data_04_575e, data_04_5787, data_04_5787 ;; 04:4e2b ????????
    db   $10, $06                                      ;; 04:4e33 ??
    db   $ff, $ff                                      ;; 04:4e35 ??

data_04_4e37:
    dw   data_04_57b0, data_04_57ed, data_04_57ed, data_04_57ed ;; 04:4e37 ????????
    db   $12, $05                                      ;; 04:4e3f ??
    dw   data_04_57b0, data_04_57b0, data_04_57ed, data_04_57ed ;; 04:4e41 ????????
    db   $12, $07                                      ;; 04:4e49 ??
    dw   data_04_57b0, data_04_57b0, data_04_57b0, data_04_57ed ;; 04:4e4b ????????
    db   $12, $09                                      ;; 04:4e53 ??
    dw   data_04_582a, data_04_582a, data_04_5867, data_04_5867 ;; 04:4e55 ????????
    db   $12, $0b                                      ;; 04:4e5d ??
    dw   data_04_582a, data_04_582a, data_04_5867, data_04_5867 ;; 04:4e5f ????????
    db   $12, $09                                      ;; 04:4e67 ??
    dw   data_04_582a, data_04_5867, data_04_5867, data_04_5867 ;; 04:4e69 ????????
    db   $12, $07                                      ;; 04:4e71 ??
    db   $ff, $ff                                      ;; 04:4e73 ??

data_04_4e75:
    dw   data_04_58b9, data_04_58b9, data_04_58b9, data_04_58b9 ;; 04:4e75 ????????
    db   $08, $06                                      ;; 04:4e7d ??
    dw   data_04_58ce, data_04_58ce, data_04_58ce, data_04_595b ;; 04:4e7f ????????
    db   $04, $06                                      ;; 04:4e87 ??
    dw   data_04_58ce, data_04_595b, data_04_595b, data_04_595b ;; 04:4e89 ????????
    db   $04, $06                                      ;; 04:4e91 ??
    dw   data_04_58a4, data_04_58a4, data_04_58a4, data_04_58a4 ;; 04:4e93 ????????
    db   $04, $06                                      ;; 04:4e9b ??
    dw   data_04_5b2b, data_04_5b2b, data_04_5a9e, data_04_5a9e ;; 04:4e9d ????????
    db   $08, $06                                      ;; 04:4ea5 ??
    dw   data_04_58a4, data_04_58a4, data_04_58a4, data_04_58a4 ;; 04:4ea7 ????????
    db   $0c, $06                                      ;; 04:4eaf ??
    dw   data_04_59b6, data_04_5a43, data_04_5a43, data_04_5a43 ;; 04:4eb1 ????????
    db   $10, $06                                      ;; 04:4eb9 ??
    dw   data_04_59b6, data_04_59b6, data_04_59b6, data_04_5a43 ;; 04:4ebb ????????
    db   $10, $06                                      ;; 04:4ec3 ??
    dw   data_04_58b9, data_04_58b9, data_04_58b9, data_04_58b9 ;; 04:4ec5 ????????
    db   $10, $06                                      ;; 04:4ecd ??
    dw   data_04_5c13, data_04_5c13, data_04_5b86, data_04_5b86 ;; 04:4ecf ????????
    db   $0c, $06                                      ;; 04:4ed7 ??
    db   $ff, $ff                                      ;; 04:4ed9 ??

data_04_4edb:
    dw   data_04_5c6e, data_04_5c6e, data_04_5cab, data_04_5cab ;; 04:4edb ????????
    db   $0a, $04                                      ;; 04:4ee3 ??
    db   $ff, $ff                                      ;; 04:4ee5 ??

data_04_4ee7:
    dw   data_04_5d94, data_04_5ce8, data_04_5ce8, data_04_5ce8 ;; 04:4ee7 ????????
    db   $0a, $02                                      ;; 04:4eef ??
    dw   data_04_5daa, data_04_5db5, data_04_5db5, data_04_5db5 ;; 04:4ef1 ????????
    db   $10, $02                                      ;; 04:4ef9 ??
    dw   data_04_5daa, data_04_5daa, data_04_5db5, data_04_5db5 ;; 04:4efb ????????
    db   $10, $02                                      ;; 04:4f03 ??
    dw   data_04_5d9f, data_04_5d3e, data_04_5d3e, data_04_5d3e ;; 04:4f05 ????????
    db   $10, $02                                      ;; 04:4f0d ??
    dw   data_04_5daa, data_04_5db5, data_04_5db5, data_04_5db5 ;; 04:4f0f ????????
    db   $0a, $02                                      ;; 04:4f17 ??
    dw   data_04_5daa, data_04_5daa, data_04_5db5, data_04_5db5 ;; 04:4f19 ????????
    db   $0a, $02                                      ;; 04:4f21 ??
    dw   data_04_5d9f, data_04_5d3e, data_04_5d3e, data_04_5d3e ;; 04:4f23 ????????
    db   $0a, $02                                      ;; 04:4f2b ??
    dw   data_04_5daa, data_04_5db5, data_04_5db5, data_04_5db5 ;; 04:4f2d ????????
    db   $04, $02                                      ;; 04:4f35 ??
    dw   data_04_5daa, data_04_5daa, data_04_5db5, data_04_5db5 ;; 04:4f37 ????????
    db   $04, $02                                      ;; 04:4f3f ??
    dw   data_04_5d94, data_04_5ce8, data_04_5ce8, data_04_5ce8 ;; 04:4f41 ????????
    db   $04, $02                                      ;; 04:4f49 ??
    db   $ff, $ff                                      ;; 04:4f4b ??

data_04_4f4d:
    dw   data_04_5ce8, data_04_5ce8, data_04_5ce8, data_04_5ce8 ;; 04:4f4d ..??....
    db   $0a, $05                                      ;; 04:4f55 ..
    dw   data_04_5d3e, data_04_5d3e, data_04_5d3e, data_04_5d3e ;; 04:4f57 ..????..
    db   $10, $05                                      ;; 04:4f5f ..
    dw   data_04_5d3e, data_04_5d3e, data_04_5d3e, data_04_5d3e ;; 04:4f61 ..????..
    db   $0a, $05                                      ;; 04:4f69 ..
    dw   data_04_5ce8, data_04_5ce8, data_04_5ce8, data_04_5ce8 ;; 04:4f6b ....??..
    db   $04, $05                                      ;; 04:4f73 ..
    db   $ff, $ff                                      ;; 04:4f75 ..

data_04_4f77:
    dw   data_04_5dc7, data_04_5dc7, data_04_5dc7, data_04_5dc7 ;; 04:4f77 ????????
    db   $0a, $02                                      ;; 04:4f7f ??
    dw   data_04_5e93, data_04_5ea4, data_04_5ea4, data_04_5e9e ;; 04:4f81 ????????
    db   $10, $02                                      ;; 04:4f89 ??
    dw   data_04_5e93, data_04_5e93, data_04_5ea4, data_04_5e9e ;; 04:4f8b ????????
    db   $10, $02                                      ;; 04:4f93 ??
    dw   data_04_5e88, data_04_5e22, data_04_5e22, data_04_5e22 ;; 04:4f95 ????????
    db   $10, $02                                      ;; 04:4f9d ??
    dw   data_04_5e93, data_04_5ea4, data_04_5ea4, data_04_5e9e ;; 04:4f9f ????????
    db   $0a, $02                                      ;; 04:4fa7 ??
    dw   data_04_5e93, data_04_5e93, data_04_5ea4, data_04_5e9e ;; 04:4fa9 ????????
    db   $0a, $02                                      ;; 04:4fb1 ??
    dw   data_04_5e22, data_04_5e22, data_04_5e22, data_04_5e22 ;; 04:4fb3 ????????
    db   $0a, $02                                      ;; 04:4fbb ??
    dw   data_04_5e93, data_04_5ea4, data_04_5e9e, data_04_5e9e ;; 04:4fbd ????????
    db   $04, $02                                      ;; 04:4fc5 ??
    dw   data_04_5e93, data_04_5ea4, data_04_5ea4, data_04_5e9e ;; 04:4fc7 ????????
    db   $04, $02                                      ;; 04:4fcf ??
    dw   data_04_5e7d, data_04_5dc7, data_04_5dc7, data_04_5dc7 ;; 04:4fd1 ????????
    db   $04, $02                                      ;; 04:4fd9 ??
    db   $ff, $ff                                      ;; 04:4fdb ??

data_04_4fdd:
    dw   data_04_5eaf, data_04_5eaf, data_04_5eaf, data_04_5eaf ;; 04:4fdd ????????
    db   $0d, $02                                      ;; 04:4fe5 ??
    dw   data_04_5f33, data_04_5f33, data_04_5f33, data_04_5f70 ;; 04:4fe7 ????????
    db   $0d, $06                                      ;; 04:4fef ??
    dw   data_04_5f33, data_04_5f33, data_04_5f70, data_04_5f70 ;; 04:4ff1 ????????
    db   $0d, $06                                      ;; 04:4ff9 ??
    dw   data_04_5eaf, data_04_5eaf, data_04_5eaf, data_04_5eaf ;; 04:4ffb ????????
    db   $0d, $06                                      ;; 04:5003 ??
    dw   data_04_5f33, data_04_5f33, data_04_5f33, data_04_5f70 ;; 04:5005 ????????
    db   $0d, $0a                                      ;; 04:500d ??
    dw   data_04_5f33, data_04_5f33, data_04_5f70, data_04_5f70 ;; 04:500f ????????
    db   $0d, $0a                                      ;; 04:5017 ??
    dw   data_04_5ef1, data_04_5ef1, data_04_5ef1, data_04_5ef1 ;; 04:5019 ????????
    db   $0d, $0a                                      ;; 04:5021 ??
    dw   data_04_5f33, data_04_5f33, data_04_5f70, data_04_5f70 ;; 04:5023 ????????
    db   $0d, $06                                      ;; 04:502b ??
    dw   data_04_5ef1, data_04_5ef1, data_04_5ef1, data_04_5ef1 ;; 04:502d ????????
    db   $0d, $06                                      ;; 04:5035 ??
    dw   data_04_5f33, data_04_5f33, data_04_5f70, data_04_5f70 ;; 04:5037 ????????
    db   $0d, $02                                      ;; 04:503f ??
    dw   data_04_5f33, data_04_5f70, data_04_5f70, data_04_5f70 ;; 04:5041 ????????
    db   $0d, $02                                      ;; 04:5049 ??
    db   $ff, $ff                                      ;; 04:504b ??

data_04_504d:
    dw   data_04_6021, data_04_6021, data_04_6021, data_04_6021 ;; 04:504d ????????
    db   $0a, $04                                      ;; 04:5055 ??
    dw   data_04_60ba, data_04_60ba, data_04_60ba, data_04_60ba ;; 04:5057 ????????
    db   $0e, $04                                      ;; 04:505f ??
    dw   data_04_6036, data_04_6036, data_04_6036, data_04_6036 ;; 04:5061 ????????
    db   $0e, $04                                      ;; 04:5069 ??
    dw   data_04_5fda, data_04_5fda, data_04_6129, data_04_6166 ;; 04:506b ????????
    db   $0a, $04                                      ;; 04:5073 ??
    dw   data_04_6036, data_04_6036, data_04_6036, data_04_6036 ;; 04:5075 ????????
    db   $0a, $04                                      ;; 04:507d ??
    dw   data_04_604b, data_04_604b, data_04_604b, data_04_604b ;; 04:507f ????????
    db   $06, $04                                      ;; 04:5087 ??
    dw   data_04_6021, data_04_6021, data_04_6021, data_04_6021 ;; 04:5089 ????????
    db   $06, $04                                      ;; 04:5091 ??
    dw   data_04_5fda, data_04_5fda, data_04_6129, data_04_6166 ;; 04:5093 ????????
    db   $0a, $04                                      ;; 04:509b ??
    db   $ff, $ff                                      ;; 04:509d ??

data_04_509f:
    dw   data_04_61a3, data_04_61a3, data_04_61a3, data_04_61a3 ;; 04:509f ????????
    db   $10, $02                                      ;; 04:50a7 ??
    dw   data_04_61e1, data_04_61e1, data_04_61e1, data_04_61e1 ;; 04:50a9 ????????
    db   $10, $05                                      ;; 04:50b1 ??
    dw   data_04_61a3, data_04_61a3, data_04_61a3, data_04_61a3 ;; 04:50b3 ????????
    db   $10, $05                                      ;; 04:50bb ??
    dw   data_04_61e1, data_04_61e1, data_04_61e1, data_04_61e1 ;; 04:50bd ????????
    db   $10, $08                                      ;; 04:50c5 ??
    dw   data_04_61c2, data_04_61c2, data_04_61c2, data_04_61c2 ;; 04:50c7 ????????
    db   $10, $08                                      ;; 04:50cf ??
    dw   data_04_61e1, data_04_61e1, data_04_61e1, data_04_61e1 ;; 04:50d1 ????????
    db   $10, $05                                      ;; 04:50d9 ??
    dw   data_04_61c2, data_04_61c2, data_04_61c2, data_04_61c2 ;; 04:50db ????????
    db   $10, $05                                      ;; 04:50e3 ??
    dw   data_04_61e1, data_04_61e1, data_04_61e1, data_04_61e1 ;; 04:50e5 ????????
    db   $10, $02                                      ;; 04:50ed ??
    db   $ff, $ff                                      ;; 04:50ef ??

data_04_50f1:
    dw   data_04_629d, data_04_629d, data_04_624b, data_04_6274 ;; 04:50f1 ????????
    db   $0a, $04                                      ;; 04:50f9 ??
    db   $ff, $ff                                      ;; 04:50fb ??

data_04_50fd:
    dw   data_04_624b, data_04_624b, data_04_6274, data_04_6274 ;; 04:50fd ????????
    db   $0a, $04                                      ;; 04:5105 ??
    dw   data_04_633e, data_04_633e, data_04_633e, data_04_633e ;; 04:5107 ????????
    db   $0a, $04                                      ;; 04:510f ??
    dw   data_04_624b, data_04_624b, data_04_6274, data_04_6274 ;; 04:5111 ????????
    db   $0a, $0c                                      ;; 04:5119 ??
    dw   data_04_6367, data_04_6367, data_04_6367, data_04_6367 ;; 04:511b ????????
    db   $0a, $0c                                      ;; 04:5123 ??
    db   $ff, $ff                                      ;; 04:5125 ??

data_04_5127:
    dw   data_04_641e, data_04_641e, data_04_641e, data_04_6448 ;; 04:5127 ????????
    db   $04, $02                                      ;; 04:512f ??
    dw   data_04_641e, data_04_641e, data_04_6448, data_04_6448 ;; 04:5131 ????????
    db   $04, $02                                      ;; 04:5139 ??
    dw   data_04_6390, data_04_6390, data_04_6390, data_04_6390 ;; 04:513b ????????
    db   $04, $02                                      ;; 04:5143 ??
    dw   data_04_6433, data_04_6433, data_04_6433, data_04_647b ;; 04:5145 ????????
    db   $10, $02                                      ;; 04:514d ??
    dw   data_04_6433, data_04_6433, data_04_647b, data_04_647b ;; 04:514f ????????
    db   $10, $02                                      ;; 04:5157 ??
    dw   data_04_63d7, data_04_63d7, data_04_63d7, data_04_63d7 ;; 04:5159 ????????
    db   $10, $02                                      ;; 04:5161 ??
    db   $ff, $ff                                      ;; 04:5163 ??

data_04_5165:
    dw   data_04_64ae, data_04_64ae, data_04_659f, data_04_659f ;; 04:5165 ????????
    db   $09, $03                                      ;; 04:516d ??
    db   $ff, $ff                                      ;; 04:516f ??

data_04_5171:
    dw   data_04_66f0, data_04_66f0, data_04_66f0, data_04_66f0 ;; 04:5171 ????????
    db   $16, $0c                                      ;; 04:5179 ??
    dw   data_04_6738, data_04_6738, data_04_6738, data_04_6738 ;; 04:517b ????????
    db   $13, $09                                      ;; 04:5183 ??
    dw   data_04_66f0, data_04_66f0, data_04_66f0, data_04_66f0 ;; 04:5185 ????????
    db   $10, $06                                      ;; 04:518d ??
    dw   data_04_670a, data_04_670a, data_04_670a, data_04_670a ;; 04:518f ????????
    db   $0d, $03                                      ;; 04:5197 ??
    dw   data_04_6738, data_04_6738, data_04_6738, data_04_6738 ;; 04:5199 ????????
    db   $07, $09                                      ;; 04:51a1 ??
    dw   data_04_6690, data_04_6690, data_04_6690, data_04_6690 ;; 04:51a3 ????????
    db   $04, $06                                      ;; 04:51ab ??
    dw   data_04_66f0, data_04_66f0, data_04_66f0, data_04_66f0 ;; 04:51ad ????????
    db   $10, $06                                      ;; 04:51b5 ??
    dw   data_04_6738, data_04_6738, data_04_6738, data_04_6738 ;; 04:51b7 ????????
    db   $0d, $03                                      ;; 04:51bf ??
    dw   data_04_66f0, data_04_66f0, data_04_66f0, data_04_66f0 ;; 04:51c1 ????????
    db   $0a, $00                                      ;; 04:51c9 ??
    dw   data_04_6738, data_04_6738, data_04_6738, data_04_6738 ;; 04:51cb ????????
    db   $07, $fd                                      ;; 04:51d3 ??
    dw   data_04_6738, data_04_6738, data_04_6738, data_04_6738 ;; 04:51d5 ????????
    db   $0c, $11                                      ;; 04:51dd ??
    dw   data_04_66f0, data_04_66f0, data_04_66f0, data_04_66f0 ;; 04:51df ????????
    db   $09, $0e                                      ;; 04:51e7 ??
    dw   data_04_6738, data_04_6738, data_04_6738, data_04_6738 ;; 04:51e9 ????????
    db   $06, $0b                                      ;; 04:51f1 ??
    dw   data_04_6690, data_04_6690, data_04_6690, data_04_6690 ;; 04:51f3 ????????
    db   $03, $08                                      ;; 04:51fb ??
    dw   data_04_66f0, data_04_66f0, data_04_66f0, data_04_66f0 ;; 04:51fd ????????
    db   $0f, $08                                      ;; 04:5205 ??
    dw   data_04_670a, data_04_670a, data_04_670a, data_04_670a ;; 04:5207 ????????
    db   $0c, $05                                      ;; 04:520f ??
    dw   data_04_6738, data_04_6738, data_04_6738, data_04_6738 ;; 04:5211 ????????
    db   $06, $0b                                      ;; 04:5219 ??
    dw   data_04_66f0, data_04_66f0, data_04_66f0, data_04_66f0 ;; 04:521b ????????
    db   $03, $08                                      ;; 04:5223 ??
    dw   data_04_6738, data_04_6738, data_04_6738, data_04_6738 ;; 04:5225 ????????
    db   $00, $05                                      ;; 04:522d ??
    db   $ff, $ff                                      ;; 04:522f ??

data_04_5231:
    dw   data_04_679c, data_04_679c, data_04_67b1, data_04_67b1 ;; 04:5231 ????????
    db   $08, $0c                                      ;; 04:5239 ??
    dw   data_04_6771, data_04_6771, data_04_6771, data_04_6771 ;; 04:523b ????????
    db   $08, $0c                                      ;; 04:5243 ??
    dw   data_04_677c, data_04_677c, data_04_67c6, data_04_67c6 ;; 04:5245 ????????
    db   $08, $0c                                      ;; 04:524d ??
    dw   data_04_6791, data_04_6791, data_04_6791, data_04_6791 ;; 04:524f ????????
    db   $08, $0c                                      ;; 04:5257 ??
    db   $ff, $ff                                      ;; 04:5259 ??

data_04_525b:
    dw   data_04_683b, data_04_683b, data_04_683b, data_04_683b ;; 04:525b ????????
    db   $16, $0c                                      ;; 04:5263 ??
    dw   data_04_68b6, data_04_68b6, data_04_68b6, data_04_68b6 ;; 04:5265 ????????
    db   $13, $09                                      ;; 04:526d ??
    dw   data_04_683b, data_04_683b, data_04_683b, data_04_683b ;; 04:526f ????????
    db   $10, $06                                      ;; 04:5277 ??
    dw   data_04_6888, data_04_6888, data_04_6888, data_04_6888 ;; 04:5279 ????????
    db   $0d, $03                                      ;; 04:5281 ??
    dw   data_04_68b6, data_04_68b6, data_04_68b6, data_04_68b6 ;; 04:5283 ????????
    db   $07, $09                                      ;; 04:528b ??
    dw   data_04_67db, data_04_67db, data_04_67db, data_04_67db ;; 04:528d ????????
    db   $04, $06                                      ;; 04:5295 ??
    dw   data_04_683b, data_04_683b, data_04_683b, data_04_683b ;; 04:5297 ????????
    db   $10, $06                                      ;; 04:529f ??
    dw   data_04_68b6, data_04_68b6, data_04_68b6, data_04_68b6 ;; 04:52a1 ????????
    db   $0d, $03                                      ;; 04:52a9 ??
    dw   data_04_683b, data_04_683b, data_04_683b, data_04_683b ;; 04:52ab ????????
    db   $0a, $00                                      ;; 04:52b3 ??
    dw   data_04_68b6, data_04_68b6, data_04_68b6, data_04_68b6 ;; 04:52b5 ????????
    db   $07, $fd                                      ;; 04:52bd ??
    dw   data_04_68b6, data_04_68b6, data_04_68b6, data_04_68b6 ;; 04:52bf ????????
    db   $0c, $11                                      ;; 04:52c7 ??
    dw   data_04_683b, data_04_683b, data_04_683b, data_04_683b ;; 04:52c9 ????????
    db   $09, $0e                                      ;; 04:52d1 ??
    dw   data_04_68b6, data_04_68b6, data_04_68b6, data_04_68b6 ;; 04:52d3 ????????
    db   $06, $0b                                      ;; 04:52db ??
    dw   data_04_67db, data_04_67db, data_04_67db, data_04_67db ;; 04:52dd ????????
    db   $03, $08                                      ;; 04:52e5 ??
    dw   data_04_683b, data_04_683b, data_04_683b, data_04_683b ;; 04:52e7 ????????
    db   $0f, $08                                      ;; 04:52ef ??
    dw   data_04_6888, data_04_6888, data_04_6888, data_04_6888 ;; 04:52f1 ????????
    db   $0c, $05                                      ;; 04:52f9 ??
    dw   data_04_68b6, data_04_68b6, data_04_68b6, data_04_68b6 ;; 04:52fb ????????
    db   $06, $0b                                      ;; 04:5303 ??
    dw   data_04_683b, data_04_683b, data_04_683b, data_04_683b ;; 04:5305 ????????
    db   $03, $08                                      ;; 04:530d ??
    dw   data_04_68b6, data_04_68b6, data_04_68b6, data_04_68b6 ;; 04:530f ????????
    db   $00, $05                                      ;; 04:5317 ??
    db   $ff, $ff                                      ;; 04:5319 ??

data_04_531b:
    dw   data_04_68d0, data_04_68d0, data_04_68d0, data_04_68d0 ;; 04:531b ????????
    db   $0a, $02                                      ;; 04:5323 ??
    dw   data_04_68f9, data_04_68f9, data_04_68f9, data_04_68f9 ;; 04:5325 ????????
    db   $00, $18                                      ;; 04:532d ??
    dw   data_04_68d0, data_04_68d0, data_04_68d0, data_04_68d0 ;; 04:532f ????????
    db   $06, $06                                      ;; 04:5337 ??
    dw   data_04_68f9, data_04_68f9, data_04_68f9, data_04_68f9 ;; 04:5339 ????????
    db   $00, $18                                      ;; 04:5341 ??
    dw   data_04_68d0, data_04_68d0, data_04_68d0, data_04_68d0 ;; 04:5343 ????????
    db   $10, $04                                      ;; 04:534b ??
    dw   data_04_68f9, data_04_68f9, data_04_68f9, data_04_68f9 ;; 04:534d ????????
    db   $00, $18                                      ;; 04:5355 ??
    dw   data_04_68d0, data_04_68d0, data_04_68d0, data_04_68d0 ;; 04:5357 ????????
    db   $0c, $08                                      ;; 04:535f ??
    dw   data_04_68f9, data_04_68f9, data_04_68f9, data_04_68f9 ;; 04:5361 ????????
    db   $00, $18                                      ;; 04:5369 ??
    dw   data_04_68d0, data_04_68d0, data_04_68d0, data_04_68d0 ;; 04:536b ????????
    db   $06, $02                                      ;; 04:5373 ??
    dw   data_04_68f9, data_04_68f9, data_04_68f9, data_04_68f9 ;; 04:5375 ????????
    db   $00, $18                                      ;; 04:537d ??
    dw   data_04_68d0, data_04_68d0, data_04_68d0, data_04_68d0 ;; 04:537f ????????
    db   $08, $08                                      ;; 04:5387 ??
    dw   data_04_68f9, data_04_68f9, data_04_68f9, data_04_68f9 ;; 04:5389 ????????
    db   $00, $18                                      ;; 04:5391 ??
    dw   data_04_68d0, data_04_68d0, data_04_68d0, data_04_68d0 ;; 04:5393 ????????
    db   $0c, $04                                      ;; 04:539b ??
    dw   data_04_68f9, data_04_68f9, data_04_68f9, data_04_68f9 ;; 04:539d ????????
    db   $00, $18                                      ;; 04:53a5 ??
    dw   data_04_68d0, data_04_68d0, data_04_68d0, data_04_68d0 ;; 04:53a7 ????????
    db   $04, $08                                      ;; 04:53af ??
    dw   data_04_68f9, data_04_68f9, data_04_68f9, data_04_68f9 ;; 04:53b1 ????????
    db   $00, $18                                      ;; 04:53b9 ??
    dw   data_04_68d0, data_04_68d0, data_04_68d0, data_04_68d0 ;; 04:53bb ????????
    db   $0e, $06                                      ;; 04:53c3 ??
    dw   data_04_68f9, data_04_68f9, data_04_68f9, data_04_68f9 ;; 04:53c5 ????????
    db   $00, $18                                      ;; 04:53cd ??
    dw   data_04_68d0, data_04_68d0, data_04_68d0, data_04_68d0 ;; 04:53cf ????????
    db   $08, $04                                      ;; 04:53d7 ??
    dw   data_04_68f9, data_04_68f9, data_04_68f9, data_04_68f9 ;; 04:53d9 ????????
    db   $00, $18                                      ;; 04:53e1 ??
    dw   data_04_68d0, data_04_68d0, data_04_68d0, data_04_68d0 ;; 04:53e3 ????????
    db   $10, $08                                      ;; 04:53eb ??
    dw   data_04_68f9, data_04_68f9, data_04_68f9, data_04_68f9 ;; 04:53ed ????????
    db   $00, $18                                      ;; 04:53f5 ??
    dw   data_04_68d0, data_04_68d0, data_04_68d0, data_04_68d0 ;; 04:53f7 ????????
    db   $0a, $06                                      ;; 04:53ff ??
    dw   data_04_68f9, data_04_68f9, data_04_68f9, data_04_68f9 ;; 04:5401 ????????
    db   $00, $18                                      ;; 04:5409 ??
    dw   data_04_68d0, data_04_68d0, data_04_68d0, data_04_68d0 ;; 04:540b ????????
    db   $0e, $02                                      ;; 04:5413 ??
    dw   data_04_68f9, data_04_68f9, data_04_68f9, data_04_68f9 ;; 04:5415 ????????
    db   $00, $18                                      ;; 04:541d ??
    dw   data_04_68d0, data_04_68d0, data_04_68d0, data_04_68d0 ;; 04:541f ????????
    db   $04, $04                                      ;; 04:5427 ??
    dw   data_04_68f9, data_04_68f9, data_04_68f9, data_04_68f9 ;; 04:5429 ????????
    db   $00, $18                                      ;; 04:5431 ??
    db   $ff, $ff                                      ;; 04:5433 ??

data_04_5435:
    db   $01                                           ;; 04:5435 ?
    dw   data_04_6914, data_04_762d                    ;; 04:5436 ????
    db   $01                                           ;; 04:543a ?
    dw   data_04_6914, data_04_7643                    ;; 04:543b ????
    db   $01                                           ;; 04:543f ?
    dw   data_04_6914, data_04_7659                    ;; 04:5440 ????
    db   $01                                           ;; 04:5444 ?
    dw   data_04_6914, data_04_766f                    ;; 04:5445 ????
    db   $01                                           ;; 04:5449 ?
    dw   data_04_6914, data_04_7643                    ;; 04:544a ????
    db   $01                                           ;; 04:544e ?
    dw   data_04_6914, data_04_7659                    ;; 04:544f ????
    db   $01                                           ;; 04:5453 ?
    dw   data_04_6914, data_04_766f                    ;; 04:5454 ????
    db   $01                                           ;; 04:5458 ?
    dw   data_04_6b3c, data_04_78a2                    ;; 04:5459 ????
    db   $01                                           ;; 04:545d ?
    dw   data_04_6b3f, data_04_78c1                    ;; 04:545e ????
    db   $01                                           ;; 04:5462 ?
    dw   data_04_6b3c, data_04_78e0                    ;; 04:5463 ????
    db   $01                                           ;; 04:5467 ?
    dw   data_04_6b3f, data_04_78ff                    ;; 04:5468 ????
    db   $01                                           ;; 04:546c ?
    dw   data_04_6b3f, data_04_791e                    ;; 04:546d ????
    db   $ff, $ff                                      ;; 04:5471 ??

data_04_5473:
    db   $01                                           ;; 04:5473 .
    dw   data_04_6b3c, data_04_7685                    ;; 04:5474 ....
    db   $01                                           ;; 04:5478 .
    dw   data_04_6b3f, data_04_7695                    ;; 04:5479 ....
    db   $01                                           ;; 04:547d .
    dw   data_04_6b3c, data_04_76a5                    ;; 04:547e ....
    db   $01                                           ;; 04:5482 .
    dw   data_04_6b3f, data_04_76b5                    ;; 04:5483 ....
    db   $01                                           ;; 04:5487 .
    dw   data_04_6b3c, data_04_76c5                    ;; 04:5488 ....
    db   $01                                           ;; 04:548c .
    dw   data_04_6b3f, data_04_7695                    ;; 04:548d ....
    db   $01                                           ;; 04:5491 .
    dw   data_04_6b3c, data_04_76a5                    ;; 04:5492 ....
    db   $01                                           ;; 04:5496 .
    dw   data_04_6b3f, data_04_76b5                    ;; 04:5497 ....
    db   $01                                           ;; 04:549b .
    dw   data_04_6b3c, data_04_76c5                    ;; 04:549c ....
    db   $01                                           ;; 04:54a0 .
    dw   data_04_6b3f, data_04_78a2                    ;; 04:54a1 ....
    db   $01                                           ;; 04:54a5 .
    dw   data_04_6b3c, data_04_78c1                    ;; 04:54a6 ....
    db   $01                                           ;; 04:54aa .
    dw   data_04_6b3f, data_04_78e0                    ;; 04:54ab ....
    db   $01                                           ;; 04:54af .
    dw   data_04_6b3c, data_04_78ff                    ;; 04:54b0 ....
    db   $01                                           ;; 04:54b4 .
    dw   data_04_6b3f, data_04_791e                    ;; 04:54b5 ....
    db   $ff, $ff                                      ;; 04:54b9 .?

data_04_54bb:
    db   $01                                           ;; 04:54bb ?
    dw   data_04_691d, data_04_76d5                    ;; 04:54bc ????
    db   $01                                           ;; 04:54c0 ?
    dw   data_04_691d, data_04_76e8                    ;; 04:54c1 ????
    db   $01                                           ;; 04:54c5 ?
    dw   data_04_691d, data_04_76fb                    ;; 04:54c6 ????
    db   $01                                           ;; 04:54ca ?
    dw   data_04_691d, data_04_770e                    ;; 04:54cb ????
    db   $01                                           ;; 04:54cf ?
    dw   data_04_691d, data_04_7721                    ;; 04:54d0 ????
    db   $01                                           ;; 04:54d4 ?
    dw   data_04_691d, data_04_76e8                    ;; 04:54d5 ????
    db   $01                                           ;; 04:54d9 ?
    dw   data_04_691d, data_04_76fb                    ;; 04:54da ????
    db   $01                                           ;; 04:54de ?
    dw   data_04_691d, data_04_770e                    ;; 04:54df ????
    db   $01                                           ;; 04:54e3 ?
    dw   data_04_691d, data_04_7721                    ;; 04:54e4 ????
    db   $01                                           ;; 04:54e8 ?
    dw   data_04_6b3c, data_04_78a2                    ;; 04:54e9 ????
    db   $01                                           ;; 04:54ed ?
    dw   data_04_6b3c, data_04_78c1                    ;; 04:54ee ????
    db   $01                                           ;; 04:54f2 ?
    dw   data_04_6b3c, data_04_78e0                    ;; 04:54f3 ????
    db   $01                                           ;; 04:54f7 ?
    dw   data_04_6b3c, data_04_78ff                    ;; 04:54f8 ????
    db   $01                                           ;; 04:54fc ?
    dw   data_04_6b3c, data_04_791e                    ;; 04:54fd ????
    db   $ff, $ff                                      ;; 04:5501 ??

data_04_5503:
    db   $01                                           ;; 04:5503 ?
    dw   data_04_691d, data_04_7734                    ;; 04:5504 ????
    db   $01                                           ;; 04:5508 ?
    dw   data_04_691d, data_04_773e                    ;; 04:5509 ????
    db   $01                                           ;; 04:550d ?
    dw   data_04_691d, data_04_7748                    ;; 04:550e ????
    db   $01                                           ;; 04:5512 ?
    dw   data_04_691d, data_04_7752                    ;; 04:5513 ????
    db   $01                                           ;; 04:5517 ?
    dw   data_04_691d, data_04_773e                    ;; 04:5518 ????
    db   $01                                           ;; 04:551c ?
    dw   data_04_691d, data_04_7748                    ;; 04:551d ????
    db   $01                                           ;; 04:5521 ?
    dw   data_04_691d, data_04_7752                    ;; 04:5522 ????
    db   $01                                           ;; 04:5526 ?
    dw   data_04_6b3c, data_04_78a2                    ;; 04:5527 ????
    db   $01                                           ;; 04:552b ?
    dw   data_04_6b3f, data_04_78c1                    ;; 04:552c ????
    db   $01                                           ;; 04:5530 ?
    dw   data_04_6b3c, data_04_78e0                    ;; 04:5531 ????
    db   $01                                           ;; 04:5535 ?
    dw   data_04_6b3f, data_04_78ff                    ;; 04:5536 ????
    db   $01                                           ;; 04:553a ?
    dw   data_04_6b3c, data_04_791e                    ;; 04:553b ????
    db   $ff, $ff                                      ;; 04:553f ??

data_04_5541:
    db   $01                                           ;; 04:5541 ?
    dw   data_04_6aca, data_04_74f8                    ;; 04:5542 ????
    db   $01                                           ;; 04:5546 ?
    dw   data_04_6aca, data_04_7517                    ;; 04:5547 ????
    db   $01                                           ;; 04:554b ?
    dw   data_04_6aca, data_04_7536                    ;; 04:554c ????
    db   $01                                           ;; 04:5550 ?
    dw   data_04_6aca, data_04_7555                    ;; 04:5551 ????
    db   $01                                           ;; 04:5555 ?
    dw   data_04_6aca, data_04_7574                    ;; 04:5556 ????
    db   $01                                           ;; 04:555a ?
    dw   data_04_6b3c, data_04_78a2                    ;; 04:555b ????
    db   $01                                           ;; 04:555f ?
    dw   data_04_6b3f, data_04_78c1                    ;; 04:5560 ????
    db   $01                                           ;; 04:5564 ?
    dw   data_04_6b3c, data_04_78e0                    ;; 04:5565 ????
    db   $01                                           ;; 04:5569 ?
    dw   data_04_6b3f, data_04_78ff                    ;; 04:556a ????
    db   $01                                           ;; 04:556e ?
    dw   data_04_6b3c, data_04_791e                    ;; 04:556f ????
    db   $ff, $ff                                      ;; 04:5573 ??

data_04_5575:
    db   $01                                           ;; 04:5575 ?
    dw   data_04_691d, data_04_6d44                    ;; 04:5576 ????
    db   $01                                           ;; 04:557a ?
    dw   data_04_691d, data_04_6d5a                    ;; 04:557b ????
    db   $01                                           ;; 04:557f ?
    dw   data_04_691d, data_04_6d70                    ;; 04:5580 ????
    db   $01                                           ;; 04:5584 ?
    dw   data_04_691d, data_04_6d86                    ;; 04:5585 ????
    db   $01                                           ;; 04:5589 ?
    dw   data_04_691d, data_04_6d5a                    ;; 04:558a ????
    db   $01                                           ;; 04:558e ?
    dw   data_04_691d, data_04_6d70                    ;; 04:558f ????
    db   $01                                           ;; 04:5593 ?
    dw   data_04_691d, data_04_6d86                    ;; 04:5594 ????
    db   $01                                           ;; 04:5598 ?
    dw   data_04_6b3c, data_04_78a2                    ;; 04:5599 ????
    db   $01                                           ;; 04:559d ?
    dw   data_04_6b3f, data_04_78c1                    ;; 04:559e ????
    db   $01                                           ;; 04:55a2 ?
    dw   data_04_6b3c, data_04_78e0                    ;; 04:55a3 ????
    db   $01                                           ;; 04:55a7 ?
    dw   data_04_6b3f, data_04_78ff                    ;; 04:55a8 ????
    db   $01                                           ;; 04:55ac ?
    dw   data_04_6b3c, data_04_791e                    ;; 04:55ad ????
    db   $ff, $ff                                      ;; 04:55b1 ??

data_04_55b3:
    db   $01                                           ;; 04:55b3 ?
    dw   data_04_691d, data_04_6f47                    ;; 04:55b4 ????
    db   $01                                           ;; 04:55b8 ?
    dw   data_04_691d, data_04_6f57                    ;; 04:55b9 ????
    db   $01                                           ;; 04:55bd ?
    dw   data_04_691d, data_04_6f67                    ;; 04:55be ????
    db   $01                                           ;; 04:55c2 ?
    dw   data_04_691d, data_04_6f77                    ;; 04:55c3 ????
    db   $01                                           ;; 04:55c7 ?
    dw   data_04_691d, data_04_6f57                    ;; 04:55c8 ????
    db   $01                                           ;; 04:55cc ?
    dw   data_04_691d, data_04_6f67                    ;; 04:55cd ????
    db   $01                                           ;; 04:55d1 ?
    dw   data_04_691d, data_04_6f77                    ;; 04:55d2 ????
    db   $01                                           ;; 04:55d6 ?
    dw   data_04_6b3c, data_04_78a2                    ;; 04:55d7 ????
    db   $01                                           ;; 04:55db ?
    dw   data_04_6b3f, data_04_78c1                    ;; 04:55dc ????
    db   $01                                           ;; 04:55e0 ?
    dw   data_04_6b3c, data_04_78e0                    ;; 04:55e1 ????
    db   $01                                           ;; 04:55e5 ?
    dw   data_04_6b3f, data_04_78ff                    ;; 04:55e6 ????
    db   $01                                           ;; 04:55ea ?
    dw   data_04_6b3c, data_04_791e                    ;; 04:55eb ????
    db   $ff, $ff                                      ;; 04:55ef ??

data_04_55f1:
    db   $01                                           ;; 04:55f1 ?
    dw   data_04_6914, data_04_6e29                    ;; 04:55f2 ????
    db   $01                                           ;; 04:55f6 ?
    dw   data_04_6914, data_04_6e48                    ;; 04:55f7 ????
    db   $01                                           ;; 04:55fb ?
    dw   data_04_6914, data_04_6e67                    ;; 04:55fc ????
    db   $01                                           ;; 04:5600 ?
    dw   data_04_6914, data_04_6e86                    ;; 04:5601 ????
    db   $01                                           ;; 04:5605 ?
    dw   data_04_6914, data_04_6e48                    ;; 04:5606 ????
    db   $01                                           ;; 04:560a ?
    dw   data_04_6914, data_04_6e67                    ;; 04:560b ????
    db   $01                                           ;; 04:560f ?
    dw   data_04_6914, data_04_6e86                    ;; 04:5610 ????
    db   $01                                           ;; 04:5614 ?
    dw   data_04_6b3c, data_04_78a2                    ;; 04:5615 ????
    db   $01                                           ;; 04:5619 ?
    dw   data_04_6b3f, data_04_78c1                    ;; 04:561a ????
    db   $01                                           ;; 04:561e ?
    dw   data_04_6b3c, data_04_78e0                    ;; 04:561f ????
    db   $01                                           ;; 04:5623 ?
    dw   data_04_6b3f, data_04_78ff                    ;; 04:5624 ????
    db   $01                                           ;; 04:5628 ?
    dw   data_04_6b3c, data_04_791e                    ;; 04:5629 ????
    db   $ff, $ff                                      ;; 04:562d ??

data_04_562f:
    db   $01                                           ;; 04:562f ?
    dw   data_04_691d, data_04_779e                    ;; 04:5630 ????
    db   $01                                           ;; 04:5634 ?
    dw   data_04_691d, data_04_775c                    ;; 04:5635 ????
    db   $01                                           ;; 04:5639 ?
    dw   data_04_691d, data_04_7772                    ;; 04:563a ????
    db   $01                                           ;; 04:563e ?
    dw   data_04_691d, data_04_7788                    ;; 04:563f ????
    db   $01                                           ;; 04:5643 ?
    dw   data_04_691d, data_04_775c                    ;; 04:5644 ????
    db   $01                                           ;; 04:5648 ?
    dw   data_04_691d, data_04_7772                    ;; 04:5649 ????
    db   $01                                           ;; 04:564d ?
    dw   data_04_691d, data_04_7788                    ;; 04:564e ????
    db   $01                                           ;; 04:5652 ?
    dw   data_04_6b3c, data_04_78a2                    ;; 04:5653 ????
    db   $01                                           ;; 04:5657 ?
    dw   data_04_6b3f, data_04_78c1                    ;; 04:5658 ????
    db   $01                                           ;; 04:565c ?
    dw   data_04_6b3c, data_04_78e0                    ;; 04:565d ????
    db   $01                                           ;; 04:5661 ?
    dw   data_04_6b3f, data_04_78ff                    ;; 04:5662 ????
    db   $01                                           ;; 04:5666 ?
    dw   data_04_6b3c, data_04_791e                    ;; 04:5667 ????
    db   $ff, $ff                                      ;; 04:566b ??

data_04_566d:
    db   $01                                           ;; 04:566d ?
    dw   data_04_6b3c, data_04_77b4                    ;; 04:566e ????
    db   $01                                           ;; 04:5672 ?
    dw   data_04_6b3f, data_04_77c7                    ;; 04:5673 ????
    db   $01                                           ;; 04:5677 ?
    dw   data_04_6b3c, data_04_77da                    ;; 04:5678 ????
    db   $01                                           ;; 04:567c ?
    dw   data_04_6b3f, data_04_77ed                    ;; 04:567d ????
    db   $01                                           ;; 04:5681 ?
    dw   data_04_6b3f, data_04_77c7                    ;; 04:5682 ????
    db   $01                                           ;; 04:5686 ?
    dw   data_04_6b3c, data_04_77da                    ;; 04:5687 ????
    db   $01                                           ;; 04:568b ?
    dw   data_04_6b3f, data_04_77ed                    ;; 04:568c ????
    db   $01                                           ;; 04:5690 ?
    dw   data_04_6b3f, data_04_78a2                    ;; 04:5691 ????
    db   $01                                           ;; 04:5695 ?
    dw   data_04_6b3c, data_04_78c1                    ;; 04:5696 ????
    db   $01                                           ;; 04:569a ?
    dw   data_04_6b3f, data_04_78e0                    ;; 04:569b ????
    db   $01                                           ;; 04:569f ?
    dw   data_04_6b3c, data_04_78ff                    ;; 04:56a0 ????
    db   $01                                           ;; 04:56a4 ?
    dw   data_04_6b3f, data_04_791e                    ;; 04:56a5 ????
    db   $ff, $ff                                      ;; 04:56a9 ??

data_04_56ab:
    db   $01                                           ;; 04:56ab ?
    dw   data_04_691d, data_04_7889                    ;; 04:56ac ????
    db   $ff, $ff                                      ;; 04:56b0 ??

data_04_56b2:
    db   $01                                           ;; 04:56b2 ?
    dw   data_04_691d, data_04_7800                    ;; 04:56b3 ????
    db   $ff, $ff                                      ;; 04:56b7 ??

data_04_56b9:
    db   $01                                           ;; 04:56b9 ?
    dw   data_04_6b3c, data_04_7819                    ;; 04:56ba ????
    db   $01                                           ;; 04:56be ?
    dw   data_04_6b3f, data_04_7835                    ;; 04:56bf ????
    db   $01                                           ;; 04:56c3 ?
    dw   data_04_6b3c, data_04_7851                    ;; 04:56c4 ????
    db   $01                                           ;; 04:56c8 ?
    dw   data_04_6b3f, data_04_786d                    ;; 04:56c9 ????
    db   $01                                           ;; 04:56cd ?
    dw   data_04_6b3f, data_04_7835                    ;; 04:56ce ????
    db   $01                                           ;; 04:56d2 ?
    dw   data_04_6b3c, data_04_7851                    ;; 04:56d3 ????
    db   $01                                           ;; 04:56d7 ?
    dw   data_04_6b3f, data_04_786d                    ;; 04:56d8 ????
    db   $01                                           ;; 04:56dc ?
    dw   data_04_6b3f, data_04_78a2                    ;; 04:56dd ????
    db   $01                                           ;; 04:56e1 ?
    dw   data_04_6b3c, data_04_78c1                    ;; 04:56e2 ????
    db   $01                                           ;; 04:56e6 ?
    dw   data_04_6b3f, data_04_78e0                    ;; 04:56e7 ????
    db   $01                                           ;; 04:56eb ?
    dw   data_04_6b3c, data_04_78ff                    ;; 04:56ec ????
    db   $01                                           ;; 04:56f0 ?
    dw   data_04_6b3f, data_04_791e                    ;; 04:56f1 ????
    db   $ff, $ff                                      ;; 04:56f5 ??

data_04_56f7:
    db   $10                                           ;; 04:56f7 ?
    dw   data_04_6905, data_04_6b42                    ;; 04:56f8 ????
    db   $01                                           ;; 04:56fc ?
    dw   data_04_6914, data_04_6b9a                    ;; 04:56fd ????
    db   $08                                           ;; 04:5701 ?
    dw   data_04_6914, data_04_6b58                    ;; 04:5702 ????
    db   $08                                           ;; 04:5706 ?
    dw   data_04_6911, data_04_6b42                    ;; 04:5707 ????
    db   $ff                                           ;; 04:570b ?

data_04_570c:
    db   $01                                           ;; 04:570c ?
    dw   data_04_691a, data_04_6bc6                    ;; 04:570d ????
    db   $01                                           ;; 04:5711 ?
    dw   data_04_691a, data_04_6bc6                    ;; 04:5712 ????
    db   $08                                           ;; 04:5716 ?
    dw   data_04_691a, data_04_6b84                    ;; 04:5717 ????
    db   $08                                           ;; 04:571b ?
    dw   data_04_6908, data_04_6b42                    ;; 04:571c ????
    db   $01                                           ;; 04:5720 ?
    dw   data_04_6914, data_04_6b9a                    ;; 04:5721 ????
    db   $01                                           ;; 04:5725 ?
    dw   data_04_6914, data_04_6b9a                    ;; 04:5726 ????
    db   $08                                           ;; 04:572a ?
    dw   data_04_6914, data_04_6b58                    ;; 04:572b ????
    db   $08                                           ;; 04:572f ?
    dw   data_04_690b, data_04_6b42                    ;; 04:5730 ????
    db   $ff                                           ;; 04:5734 ?

data_04_5735:
    db   $01                                           ;; 04:5735 ?
    dw   data_04_691a, data_04_6bc6                    ;; 04:5736 ????
    db   $01                                           ;; 04:573a ?
    dw   data_04_691a, data_04_6bc6                    ;; 04:573b ????
    db   $08                                           ;; 04:573f ?
    dw   data_04_691a, data_04_6b84                    ;; 04:5740 ????
    db   $08                                           ;; 04:5744 ?
    dw   data_04_690b, data_04_6b42                    ;; 04:5745 ????
    db   $01                                           ;; 04:5749 ?
    dw   data_04_6914, data_04_6b9a                    ;; 04:574a ????
    db   $01                                           ;; 04:574e ?
    dw   data_04_6914, data_04_6b9a                    ;; 04:574f ????
    db   $08                                           ;; 04:5753 ?
    dw   data_04_6914, data_04_6b58                    ;; 04:5754 ????
    db   $08                                           ;; 04:5758 ?
    dw   data_04_6908, data_04_6b42                    ;; 04:5759 ????
    db   $ff                                           ;; 04:575d ?

data_04_575e:
    db   $01                                           ;; 04:575e ?
    dw   data_04_6917, data_04_6bb0                    ;; 04:575f ????
    db   $01                                           ;; 04:5763 ?
    dw   data_04_6917, data_04_6bb0                    ;; 04:5764 ????
    db   $08                                           ;; 04:5768 ?
    dw   data_04_6917, data_04_6b6e                    ;; 04:5769 ????
    db   $08                                           ;; 04:576d ?
    dw   data_04_690e, data_04_6b42                    ;; 04:576e ????
    db   $01                                           ;; 04:5772 ?
    dw   data_04_6914, data_04_6b9a                    ;; 04:5773 ????
    db   $01                                           ;; 04:5777 ?
    dw   data_04_6914, data_04_6b9a                    ;; 04:5778 ????
    db   $08                                           ;; 04:577c ?
    dw   data_04_6914, data_04_6b58                    ;; 04:577d ????
    db   $08                                           ;; 04:5781 ?
    dw   data_04_6911, data_04_6b42                    ;; 04:5782 ????
    db   $ff                                           ;; 04:5786 ?

data_04_5787:
    db   $01                                           ;; 04:5787 ?
    dw   data_04_6917, data_04_6bb0                    ;; 04:5788 ????
    db   $01                                           ;; 04:578c ?
    dw   data_04_6917, data_04_6bb0                    ;; 04:578d ????
    db   $08                                           ;; 04:5791 ?
    dw   data_04_6917, data_04_6b6e                    ;; 04:5792 ????
    db   $08                                           ;; 04:5796 ?
    dw   data_04_6911, data_04_6b42                    ;; 04:5797 ????
    db   $01                                           ;; 04:579b ?
    dw   data_04_6914, data_04_6b9a                    ;; 04:579c ????
    db   $01                                           ;; 04:57a0 ?
    dw   data_04_6914, data_04_6b9a                    ;; 04:57a1 ????
    db   $08                                           ;; 04:57a5 ?
    dw   data_04_6914, data_04_6b58                    ;; 04:57a6 ????
    db   $08                                           ;; 04:57aa ?
    dw   data_04_690e, data_04_6b42                    ;; 04:57ab ????
    db   $ff                                           ;; 04:57af ?

data_04_57b0:
    db   $02                                           ;; 04:57b0 ?
    dw   data_04_6920, data_04_6bdc                    ;; 04:57b1 ????
    db   $01                                           ;; 04:57b5 ?
    dw   data_04_6920, data_04_6bef                    ;; 04:57b6 ????
    db   $01                                           ;; 04:57ba ?
    dw   data_04_6920, data_04_6c02                    ;; 04:57bb ????
    db   $01                                           ;; 04:57bf ?
    dw   data_04_6920, data_04_6c15                    ;; 04:57c0 ????
    db   $01                                           ;; 04:57c4 ?
    dw   data_04_6920, data_04_6c28                    ;; 04:57c5 ????
    db   $02                                           ;; 04:57c9 ?
    dw   data_04_6920, data_04_6c3b                    ;; 04:57ca ????
    db   $06                                           ;; 04:57ce ?
    dw   data_04_692c, data_04_6bdc                    ;; 04:57cf ????
    db   $05                                           ;; 04:57d3 ?
    dw   data_04_692c, data_04_6bef                    ;; 04:57d4 ????
    db   $05                                           ;; 04:57d8 ?
    dw   data_04_692c, data_04_6c02                    ;; 04:57d9 ????
    db   $05                                           ;; 04:57dd ?
    dw   data_04_6926, data_04_6c15                    ;; 04:57de ????
    db   $05                                           ;; 04:57e2 ?
    dw   data_04_6926, data_04_6c28                    ;; 04:57e3 ????
    db   $06                                           ;; 04:57e7 ?
    dw   data_04_6926, data_04_6c3b                    ;; 04:57e8 ????
    db   $ff                                           ;; 04:57ec ?

data_04_57ed:
    db   $02                                           ;; 04:57ed ?
    dw   data_04_6920, data_04_6bdc                    ;; 04:57ee ????
    db   $01                                           ;; 04:57f2 ?
    dw   data_04_6920, data_04_6bef                    ;; 04:57f3 ????
    db   $01                                           ;; 04:57f7 ?
    dw   data_04_6920, data_04_6c02                    ;; 04:57f8 ????
    db   $01                                           ;; 04:57fc ?
    dw   data_04_6920, data_04_6c15                    ;; 04:57fd ????
    db   $01                                           ;; 04:5801 ?
    dw   data_04_6920, data_04_6c28                    ;; 04:5802 ????
    db   $02                                           ;; 04:5806 ?
    dw   data_04_6920, data_04_6c3b                    ;; 04:5807 ????
    db   $03                                           ;; 04:580b ?
    dw   data_04_692c, data_04_6bdc                    ;; 04:580c ????
    db   $03                                           ;; 04:5810 ?
    dw   data_04_692c, data_04_6bef                    ;; 04:5811 ????
    db   $02                                           ;; 04:5815 ?
    dw   data_04_692c, data_04_6c02                    ;; 04:5816 ????
    db   $02                                           ;; 04:581a ?
    dw   data_04_6926, data_04_6c15                    ;; 04:581b ????
    db   $03                                           ;; 04:581f ?
    dw   data_04_6926, data_04_6c28                    ;; 04:5820 ????
    db   $03                                           ;; 04:5824 ?
    dw   data_04_6926, data_04_6c3b                    ;; 04:5825 ????
    db   $ff                                           ;; 04:5829 ?

data_04_582a:
    db   $02                                           ;; 04:582a ?
    dw   data_04_6923, data_04_6bdc                    ;; 04:582b ????
    db   $01                                           ;; 04:582f ?
    dw   data_04_6923, data_04_6bef                    ;; 04:5830 ????
    db   $01                                           ;; 04:5834 ?
    dw   data_04_6923, data_04_6c02                    ;; 04:5835 ????
    db   $01                                           ;; 04:5839 ?
    dw   data_04_6923, data_04_6c15                    ;; 04:583a ????
    db   $01                                           ;; 04:583e ?
    dw   data_04_6923, data_04_6c28                    ;; 04:583f ????
    db   $02                                           ;; 04:5843 ?
    dw   data_04_6923, data_04_6c3b                    ;; 04:5844 ????
    db   $06                                           ;; 04:5848 ?
    dw   data_04_692c, data_04_6bdc                    ;; 04:5849 ????
    db   $05                                           ;; 04:584d ?
    dw   data_04_692c, data_04_6bef                    ;; 04:584e ????
    db   $05                                           ;; 04:5852 ?
    dw   data_04_692c, data_04_6c02                    ;; 04:5853 ????
    db   $05                                           ;; 04:5857 ?
    dw   data_04_6926, data_04_6c15                    ;; 04:5858 ????
    db   $05                                           ;; 04:585c ?
    dw   data_04_6926, data_04_6c28                    ;; 04:585d ????
    db   $06                                           ;; 04:5861 ?
    dw   data_04_6926, data_04_6c3b                    ;; 04:5862 ????
    db   $ff                                           ;; 04:5866 ?

data_04_5867:
    db   $02                                           ;; 04:5867 ?
    dw   data_04_6923, data_04_6bdc                    ;; 04:5868 ????
    db   $01                                           ;; 04:586c ?
    dw   data_04_6923, data_04_6bef                    ;; 04:586d ????
    db   $01                                           ;; 04:5871 ?
    dw   data_04_6923, data_04_6c02                    ;; 04:5872 ????
    db   $01                                           ;; 04:5876 ?
    dw   data_04_6923, data_04_6c15                    ;; 04:5877 ????
    db   $01                                           ;; 04:587b ?
    dw   data_04_6923, data_04_6c28                    ;; 04:587c ????
    db   $02                                           ;; 04:5880 ?
    dw   data_04_6923, data_04_6c3b                    ;; 04:5881 ????
    db   $03                                           ;; 04:5885 ?
    dw   data_04_692c, data_04_6bdc                    ;; 04:5886 ????
    db   $03                                           ;; 04:588a ?
    dw   data_04_692c, data_04_6bef                    ;; 04:588b ????
    db   $02                                           ;; 04:588f ?
    dw   data_04_692c, data_04_6c02                    ;; 04:5890 ????
    db   $02                                           ;; 04:5894 ?
    dw   data_04_6926, data_04_6c15                    ;; 04:5895 ????
    db   $03                                           ;; 04:5899 ?
    dw   data_04_6926, data_04_6c28                    ;; 04:589a ????
    db   $03                                           ;; 04:589e ?
    dw   data_04_6926, data_04_6c3b                    ;; 04:589f ????
    db   $ff                                           ;; 04:58a3 ?

data_04_58a4:
    db   $02                                           ;; 04:58a4 ?
    dw   data_04_6926, data_04_6c4e                    ;; 04:58a5 ????
    db   $02                                           ;; 04:58a9 ?
    dw   data_04_6929, data_04_6c58                    ;; 04:58aa ????
    db   $02                                           ;; 04:58ae ?
    dw   data_04_6926, data_04_6c4e                    ;; 04:58af ????
    db   $02                                           ;; 04:58b3 ?
    dw   data_04_6929, data_04_6c58                    ;; 04:58b4 ????
    db   $ff                                           ;; 04:58b8 ?

data_04_58b9:
    db   $02                                           ;; 04:58b9 ?
    dw   data_04_692c, data_04_6c4e                    ;; 04:58ba ????
    db   $02                                           ;; 04:58be ?
    dw   data_04_692f, data_04_6c58                    ;; 04:58bf ????
    db   $02                                           ;; 04:58c3 ?
    dw   data_04_692c, data_04_6c4e                    ;; 04:58c4 ????
    db   $02                                           ;; 04:58c8 ?
    dw   data_04_692f, data_04_6c58                    ;; 04:58c9 ????
    db   $ff                                           ;; 04:58cd ?

data_04_58ce:
    db   $01                                           ;; 04:58ce ?
    dw   data_04_6932, data_04_6c4e                    ;; 04:58cf ????
    db   $01                                           ;; 04:58d3 ?
    dw   data_04_6935, data_04_6c4e                    ;; 04:58d4 ????
    db   $01                                           ;; 04:58d8 ?
    dw   data_04_6938, data_04_6c58                    ;; 04:58d9 ????
    db   $01                                           ;; 04:58dd ?
    dw   data_04_693b, data_04_6c58                    ;; 04:58de ????
    db   $02                                           ;; 04:58e2 ?
    dw   data_04_693e, data_04_6c4e                    ;; 04:58e3 ????
    db   $01                                           ;; 04:58e7 ?
    dw   data_04_6941, data_04_6c58                    ;; 04:58e8 ????
    db   $01                                           ;; 04:58ec ?
    dw   data_04_6944, data_04_6c58                    ;; 04:58ed ????
    db   $01                                           ;; 04:58f1 ?
    dw   data_04_6947, data_04_6c4e                    ;; 04:58f2 ????
    db   $01                                           ;; 04:58f6 ?
    dw   data_04_691d, data_04_6c8a                    ;; 04:58f7 ????
    db   $01                                           ;; 04:58fb ?
    dw   data_04_691d, data_04_6c6c                    ;; 04:58fc ????
    db   $01                                           ;; 04:5900 ?
    dw   data_04_691d, data_04_6c76                    ;; 04:5901 ????
    db   $01                                           ;; 04:5905 ?
    dw   data_04_691d, data_04_6c80                    ;; 04:5906 ????
    db   $01                                           ;; 04:590a ?
    dw   data_04_691d, data_04_6c62                    ;; 04:590b ????
    db   $01                                           ;; 04:590f ?
    dw   data_04_691d, data_04_6c6c                    ;; 04:5910 ????
    db   $01                                           ;; 04:5914 ?
    dw   data_04_691d, data_04_6c76                    ;; 04:5915 ????
    db   $01                                           ;; 04:5919 ?
    dw   data_04_691d, data_04_6c80                    ;; 04:591a ????
    db   $01                                           ;; 04:591e ?
    dw   data_04_691d, data_04_6c62                    ;; 04:591f ????
    db   $01                                           ;; 04:5923 ?
    dw   data_04_691d, data_04_6c6c                    ;; 04:5924 ????
    db   $01                                           ;; 04:5928 ?
    dw   data_04_691d, data_04_6c76                    ;; 04:5929 ????
    db   $01                                           ;; 04:592d ?
    dw   data_04_691d, data_04_6c80                    ;; 04:592e ????
    db   $01                                           ;; 04:5932 ?
    dw   data_04_694a, data_04_6c4e                    ;; 04:5933 ????
    db   $01                                           ;; 04:5937 ?
    dw   data_04_694d, data_04_6c4e                    ;; 04:5938 ????
    db   $01                                           ;; 04:593c ?
    dw   data_04_6950, data_04_6c58                    ;; 04:593d ????
    db   $01                                           ;; 04:5941 ?
    dw   data_04_6953, data_04_6c58                    ;; 04:5942 ????
    db   $02                                           ;; 04:5946 ?
    dw   data_04_6956, data_04_6c4e                    ;; 04:5947 ????
    db   $01                                           ;; 04:594b ?
    dw   data_04_6959, data_04_6c58                    ;; 04:594c ????
    db   $01                                           ;; 04:5950 ?
    dw   data_04_695c, data_04_6c58                    ;; 04:5951 ????
    db   $01                                           ;; 04:5955 ?
    dw   data_04_695f, data_04_6c4e                    ;; 04:5956 ????
    db   $ff                                           ;; 04:595a ?

data_04_595b:
    db   $01                                           ;; 04:595b ?
    dw   data_04_695f, data_04_6c4e                    ;; 04:595c ????
    db   $01                                           ;; 04:5960 ?
    dw   data_04_6962, data_04_6c4e                    ;; 04:5961 ????
    db   $01                                           ;; 04:5965 ?
    dw   data_04_6965, data_04_6c58                    ;; 04:5966 ????
    db   $01                                           ;; 04:596a ?
    dw   data_04_6968, data_04_6c58                    ;; 04:596b ????
    db   $02                                           ;; 04:596f ?
    dw   data_04_696b, data_04_6c4e                    ;; 04:5970 ????
    db   $01                                           ;; 04:5974 ?
    dw   data_04_696e, data_04_6c58                    ;; 04:5975 ????
    db   $01                                           ;; 04:5979 ?
    dw   data_04_6971, data_04_6c58                    ;; 04:597a ????
    db   $01                                           ;; 04:597e ?
    dw   data_04_6947, data_04_6c4e                    ;; 04:597f ????
    db   $03                                           ;; 04:5983 ?
    dw   data_04_691d, data_04_6c4e                    ;; 04:5984 ????
    db   $01                                           ;; 04:5988 ?
    dw   data_04_691d, data_04_6c8a                    ;; 04:5989 ????
    db   $01                                           ;; 04:598d ?
    dw   data_04_694a, data_04_6c4e                    ;; 04:598e ????
    db   $01                                           ;; 04:5992 ?
    dw   data_04_6974, data_04_6c4e                    ;; 04:5993 ????
    db   $01                                           ;; 04:5997 ?
    dw   data_04_6977, data_04_6c58                    ;; 04:5998 ????
    db   $01                                           ;; 04:599c ?
    dw   data_04_697a, data_04_6c58                    ;; 04:599d ????
    db   $02                                           ;; 04:59a1 ?
    dw   data_04_697d, data_04_6c4e                    ;; 04:59a2 ????
    db   $01                                           ;; 04:59a6 ?
    dw   data_04_6980, data_04_6c58                    ;; 04:59a7 ????
    db   $01                                           ;; 04:59ab ?
    dw   data_04_6983, data_04_6c58                    ;; 04:59ac ????
    db   $01                                           ;; 04:59b0 ?
    dw   data_04_6932, data_04_6c4e                    ;; 04:59b1 ????
    db   $ff                                           ;; 04:59b5 ?

data_04_59b6:
    db   $01                                           ;; 04:59b6 ?
    dw   data_04_6932, data_04_6c4e                    ;; 04:59b7 ????
    db   $01                                           ;; 04:59bb ?
    dw   data_04_6986, data_04_6c4e                    ;; 04:59bc ????
    db   $01                                           ;; 04:59c0 ?
    dw   data_04_6980, data_04_6c58                    ;; 04:59c1 ????
    db   $01                                           ;; 04:59c5 ?
    dw   data_04_697a, data_04_6c58                    ;; 04:59c6 ????
    db   $02                                           ;; 04:59ca ?
    dw   data_04_697d, data_04_6c4e                    ;; 04:59cb ????
    db   $01                                           ;; 04:59cf ?
    dw   data_04_6977, data_04_6c58                    ;; 04:59d0 ????
    db   $01                                           ;; 04:59d4 ?
    dw   data_04_6989, data_04_6c58                    ;; 04:59d5 ????
    db   $01                                           ;; 04:59d9 ?
    dw   data_04_694a, data_04_6c4e                    ;; 04:59da ????
    db   $01                                           ;; 04:59de ?
    dw   data_04_691d, data_04_6c8a                    ;; 04:59df ????
    db   $01                                           ;; 04:59e3 ?
    dw   data_04_691d, data_04_6c6c                    ;; 04:59e4 ????
    db   $01                                           ;; 04:59e8 ?
    dw   data_04_691d, data_04_6c76                    ;; 04:59e9 ????
    db   $01                                           ;; 04:59ed ?
    dw   data_04_691d, data_04_6c80                    ;; 04:59ee ????
    db   $01                                           ;; 04:59f2 ?
    dw   data_04_691d, data_04_6c62                    ;; 04:59f3 ????
    db   $01                                           ;; 04:59f7 ?
    dw   data_04_691d, data_04_6c6c                    ;; 04:59f8 ????
    db   $01                                           ;; 04:59fc ?
    dw   data_04_691d, data_04_6c76                    ;; 04:59fd ????
    db   $01                                           ;; 04:5a01 ?
    dw   data_04_691d, data_04_6c80                    ;; 04:5a02 ????
    db   $01                                           ;; 04:5a06 ?
    dw   data_04_691d, data_04_6c62                    ;; 04:5a07 ????
    db   $01                                           ;; 04:5a0b ?
    dw   data_04_691d, data_04_6c6c                    ;; 04:5a0c ????
    db   $01                                           ;; 04:5a10 ?
    dw   data_04_691d, data_04_6c76                    ;; 04:5a11 ????
    db   $01                                           ;; 04:5a15 ?
    dw   data_04_691d, data_04_6c80                    ;; 04:5a16 ????
    db   $01                                           ;; 04:5a1a ?
    dw   data_04_6947, data_04_6c4e                    ;; 04:5a1b ????
    db   $01                                           ;; 04:5a1f ?
    dw   data_04_698c, data_04_6c4e                    ;; 04:5a20 ????
    db   $01                                           ;; 04:5a24 ?
    dw   data_04_696e, data_04_6c58                    ;; 04:5a25 ????
    db   $01                                           ;; 04:5a29 ?
    dw   data_04_6968, data_04_6c58                    ;; 04:5a2a ????
    db   $02                                           ;; 04:5a2e ?
    dw   data_04_696b, data_04_6c4e                    ;; 04:5a2f ????
    db   $01                                           ;; 04:5a33 ?
    dw   data_04_6965, data_04_6c58                    ;; 04:5a34 ????
    db   $01                                           ;; 04:5a38 ?
    dw   data_04_698f, data_04_6c58                    ;; 04:5a39 ????
    db   $01                                           ;; 04:5a3d ?
    dw   data_04_695f, data_04_6c4e                    ;; 04:5a3e ????
    db   $ff                                           ;; 04:5a42 ?

data_04_5a43:
    db   $01                                           ;; 04:5a43 ?
    dw   data_04_695f, data_04_6c4e                    ;; 04:5a44 ????
    db   $01                                           ;; 04:5a48 ?
    dw   data_04_6992, data_04_6c4e                    ;; 04:5a49 ????
    db   $01                                           ;; 04:5a4d ?
    dw   data_04_6959, data_04_6c58                    ;; 04:5a4e ????
    db   $01                                           ;; 04:5a52 ?
    dw   data_04_6953, data_04_6c58                    ;; 04:5a53 ????
    db   $02                                           ;; 04:5a57 ?
    dw   data_04_6956, data_04_6c4e                    ;; 04:5a58 ????
    db   $01                                           ;; 04:5a5c ?
    dw   data_04_6950, data_04_6c58                    ;; 04:5a5d ????
    db   $01                                           ;; 04:5a61 ?
    dw   data_04_6995, data_04_6c58                    ;; 04:5a62 ????
    db   $01                                           ;; 04:5a66 ?
    dw   data_04_694a, data_04_6c4e                    ;; 04:5a67 ????
    db   $03                                           ;; 04:5a6b ?
    dw   data_04_691d, data_04_6c4e                    ;; 04:5a6c ????
    db   $01                                           ;; 04:5a70 ?
    dw   data_04_691d, data_04_6c8a                    ;; 04:5a71 ????
    db   $01                                           ;; 04:5a75 ?
    dw   data_04_6947, data_04_6c4e                    ;; 04:5a76 ????
    db   $01                                           ;; 04:5a7a ?
    dw   data_04_6998, data_04_6c4e                    ;; 04:5a7b ????
    db   $01                                           ;; 04:5a7f ?
    dw   data_04_6941, data_04_6c58                    ;; 04:5a80 ????
    db   $01                                           ;; 04:5a84 ?
    dw   data_04_693b, data_04_6c58                    ;; 04:5a85 ????
    db   $02                                           ;; 04:5a89 ?
    dw   data_04_693e, data_04_6c4e                    ;; 04:5a8a ????
    db   $01                                           ;; 04:5a8e ?
    dw   data_04_6938, data_04_6c58                    ;; 04:5a8f ????
    db   $01                                           ;; 04:5a93 ?
    dw   data_04_699b, data_04_6c58                    ;; 04:5a94 ????
    db   $01                                           ;; 04:5a98 ?
    dw   data_04_6932, data_04_6c4e                    ;; 04:5a99 ????
    db   $ff                                           ;; 04:5a9d ?

data_04_5a9e:
    db   $01                                           ;; 04:5a9e ?
    dw   data_04_6947, data_04_6c4e                    ;; 04:5a9f ????
    db   $01                                           ;; 04:5aa3 ?
    dw   data_04_6998, data_04_6c4e                    ;; 04:5aa4 ????
    db   $01                                           ;; 04:5aa8 ?
    dw   data_04_6941, data_04_6c58                    ;; 04:5aa9 ????
    db   $01                                           ;; 04:5aad ?
    dw   data_04_693b, data_04_6c58                    ;; 04:5aae ????
    db   $02                                           ;; 04:5ab2 ?
    dw   data_04_693e, data_04_6c4e                    ;; 04:5ab3 ????
    db   $01                                           ;; 04:5ab7 ?
    dw   data_04_6938, data_04_6c58                    ;; 04:5ab8 ????
    db   $01                                           ;; 04:5abc ?
    dw   data_04_699b, data_04_6c58                    ;; 04:5abd ????
    db   $01                                           ;; 04:5ac1 ?
    dw   data_04_6932, data_04_6c4e                    ;; 04:5ac2 ????
    db   $01                                           ;; 04:5ac6 ?
    dw   data_04_691d, data_04_6c8a                    ;; 04:5ac7 ????
    db   $01                                           ;; 04:5acb ?
    dw   data_04_691d, data_04_6c6c                    ;; 04:5acc ????
    db   $01                                           ;; 04:5ad0 ?
    dw   data_04_691d, data_04_6c76                    ;; 04:5ad1 ????
    db   $01                                           ;; 04:5ad5 ?
    dw   data_04_691d, data_04_6c80                    ;; 04:5ad6 ????
    db   $01                                           ;; 04:5ada ?
    dw   data_04_691d, data_04_6c62                    ;; 04:5adb ????
    db   $01                                           ;; 04:5adf ?
    dw   data_04_691d, data_04_6c6c                    ;; 04:5ae0 ????
    db   $01                                           ;; 04:5ae4 ?
    dw   data_04_691d, data_04_6c76                    ;; 04:5ae5 ????
    db   $01                                           ;; 04:5ae9 ?
    dw   data_04_691d, data_04_6c80                    ;; 04:5aea ????
    db   $01                                           ;; 04:5aee ?
    dw   data_04_691d, data_04_6c62                    ;; 04:5aef ????
    db   $01                                           ;; 04:5af3 ?
    dw   data_04_691d, data_04_6c6c                    ;; 04:5af4 ????
    db   $01                                           ;; 04:5af8 ?
    dw   data_04_691d, data_04_6c76                    ;; 04:5af9 ????
    db   $01                                           ;; 04:5afd ?
    dw   data_04_691d, data_04_6c80                    ;; 04:5afe ????
    db   $01                                           ;; 04:5b02 ?
    dw   data_04_695f, data_04_6c4e                    ;; 04:5b03 ????
    db   $01                                           ;; 04:5b07 ?
    dw   data_04_6962, data_04_6c4e                    ;; 04:5b08 ????
    db   $01                                           ;; 04:5b0c ?
    dw   data_04_6965, data_04_6c58                    ;; 04:5b0d ????
    db   $01                                           ;; 04:5b11 ?
    dw   data_04_6968, data_04_6c58                    ;; 04:5b12 ????
    db   $02                                           ;; 04:5b16 ?
    dw   data_04_696b, data_04_6c4e                    ;; 04:5b17 ????
    db   $01                                           ;; 04:5b1b ?
    dw   data_04_696e, data_04_6c58                    ;; 04:5b1c ????
    db   $01                                           ;; 04:5b20 ?
    dw   data_04_6971, data_04_6c58                    ;; 04:5b21 ????
    db   $01                                           ;; 04:5b25 ?
    dw   data_04_6947, data_04_6c4e                    ;; 04:5b26 ????
    db   $ff                                           ;; 04:5b2a ?

data_04_5b2b:
    db   $01                                           ;; 04:5b2b ?
    dw   data_04_6947, data_04_6c4e                    ;; 04:5b2c ????
    db   $01                                           ;; 04:5b30 ?
    dw   data_04_698c, data_04_6c4e                    ;; 04:5b31 ????
    db   $01                                           ;; 04:5b35 ?
    dw   data_04_696e, data_04_6c58                    ;; 04:5b36 ????
    db   $01                                           ;; 04:5b3a ?
    dw   data_04_6968, data_04_6c58                    ;; 04:5b3b ????
    db   $02                                           ;; 04:5b3f ?
    dw   data_04_696b, data_04_6c4e                    ;; 04:5b40 ????
    db   $01                                           ;; 04:5b44 ?
    dw   data_04_6965, data_04_6c58                    ;; 04:5b45 ????
    db   $01                                           ;; 04:5b49 ?
    dw   data_04_698f, data_04_6c58                    ;; 04:5b4a ????
    db   $01                                           ;; 04:5b4e ?
    dw   data_04_695f, data_04_6c4e                    ;; 04:5b4f ????
    db   $03                                           ;; 04:5b53 ?
    dw   data_04_691d, data_04_6c4e                    ;; 04:5b54 ????
    db   $01                                           ;; 04:5b58 ?
    dw   data_04_691d, data_04_6c8a                    ;; 04:5b59 ????
    db   $01                                           ;; 04:5b5d ?
    dw   data_04_6932, data_04_6c4e                    ;; 04:5b5e ????
    db   $01                                           ;; 04:5b62 ?
    dw   data_04_6935, data_04_6c4e                    ;; 04:5b63 ????
    db   $01                                           ;; 04:5b67 ?
    dw   data_04_6938, data_04_6c58                    ;; 04:5b68 ????
    db   $01                                           ;; 04:5b6c ?
    dw   data_04_693b, data_04_6c58                    ;; 04:5b6d ????
    db   $02                                           ;; 04:5b71 ?
    dw   data_04_693e, data_04_6c4e                    ;; 04:5b72 ????
    db   $01                                           ;; 04:5b76 ?
    dw   data_04_6941, data_04_6c58                    ;; 04:5b77 ????
    db   $01                                           ;; 04:5b7b ?
    dw   data_04_6944, data_04_6c58                    ;; 04:5b7c ????
    db   $01                                           ;; 04:5b80 ?
    dw   data_04_6947, data_04_6c4e                    ;; 04:5b81 ????
    db   $ff                                           ;; 04:5b85 ?

data_04_5b86:
    db   $01                                           ;; 04:5b86 ?
    dw   data_04_694a, data_04_6c4e                    ;; 04:5b87 ????
    db   $01                                           ;; 04:5b8b ?
    dw   data_04_6974, data_04_6c4e                    ;; 04:5b8c ????
    db   $01                                           ;; 04:5b90 ?
    dw   data_04_6977, data_04_6c58                    ;; 04:5b91 ????
    db   $01                                           ;; 04:5b95 ?
    dw   data_04_697a, data_04_6c58                    ;; 04:5b96 ????
    db   $02                                           ;; 04:5b9a ?
    dw   data_04_697d, data_04_6c4e                    ;; 04:5b9b ????
    db   $01                                           ;; 04:5b9f ?
    dw   data_04_6980, data_04_6c58                    ;; 04:5ba0 ????
    db   $01                                           ;; 04:5ba4 ?
    dw   data_04_6983, data_04_6c58                    ;; 04:5ba5 ????
    db   $01                                           ;; 04:5ba9 ?
    dw   data_04_6932, data_04_6c4e                    ;; 04:5baa ????
    db   $01                                           ;; 04:5bae ?
    dw   data_04_691d, data_04_6c8a                    ;; 04:5baf ????
    db   $01                                           ;; 04:5bb3 ?
    dw   data_04_691d, data_04_6c6c                    ;; 04:5bb4 ????
    db   $01                                           ;; 04:5bb8 ?
    dw   data_04_691d, data_04_6c76                    ;; 04:5bb9 ????
    db   $01                                           ;; 04:5bbd ?
    dw   data_04_691d, data_04_6c80                    ;; 04:5bbe ????
    db   $01                                           ;; 04:5bc2 ?
    dw   data_04_691d, data_04_6c62                    ;; 04:5bc3 ????
    db   $01                                           ;; 04:5bc7 ?
    dw   data_04_691d, data_04_6c6c                    ;; 04:5bc8 ????
    db   $01                                           ;; 04:5bcc ?
    dw   data_04_691d, data_04_6c76                    ;; 04:5bcd ????
    db   $01                                           ;; 04:5bd1 ?
    dw   data_04_691d, data_04_6c80                    ;; 04:5bd2 ????
    db   $01                                           ;; 04:5bd6 ?
    dw   data_04_691d, data_04_6c62                    ;; 04:5bd7 ????
    db   $01                                           ;; 04:5bdb ?
    dw   data_04_691d, data_04_6c6c                    ;; 04:5bdc ????
    db   $01                                           ;; 04:5be0 ?
    dw   data_04_691d, data_04_6c76                    ;; 04:5be1 ????
    db   $01                                           ;; 04:5be5 ?
    dw   data_04_691d, data_04_6c80                    ;; 04:5be6 ????
    db   $01                                           ;; 04:5bea ?
    dw   data_04_695f, data_04_6c4e                    ;; 04:5beb ????
    db   $01                                           ;; 04:5bef ?
    dw   data_04_6992, data_04_6c4e                    ;; 04:5bf0 ????
    db   $01                                           ;; 04:5bf4 ?
    dw   data_04_6959, data_04_6c58                    ;; 04:5bf5 ????
    db   $01                                           ;; 04:5bf9 ?
    dw   data_04_6953, data_04_6c58                    ;; 04:5bfa ????
    db   $02                                           ;; 04:5bfe ?
    dw   data_04_6956, data_04_6c4e                    ;; 04:5bff ????
    db   $01                                           ;; 04:5c03 ?
    dw   data_04_6950, data_04_6c58                    ;; 04:5c04 ????
    db   $01                                           ;; 04:5c08 ?
    dw   data_04_6995, data_04_6c58                    ;; 04:5c09 ????
    db   $01                                           ;; 04:5c0d ?
    dw   data_04_694a, data_04_6c4e                    ;; 04:5c0e ????
    db   $ff                                           ;; 04:5c12 ?

data_04_5c13:
    db   $01                                           ;; 04:5c13 ?
    dw   data_04_694a, data_04_6c4e                    ;; 04:5c14 ????
    db   $01                                           ;; 04:5c18 ?
    dw   data_04_694d, data_04_6c4e                    ;; 04:5c19 ????
    db   $01                                           ;; 04:5c1d ?
    dw   data_04_6950, data_04_6c58                    ;; 04:5c1e ????
    db   $01                                           ;; 04:5c22 ?
    dw   data_04_6953, data_04_6c58                    ;; 04:5c23 ????
    db   $02                                           ;; 04:5c27 ?
    dw   data_04_6956, data_04_6c4e                    ;; 04:5c28 ????
    db   $01                                           ;; 04:5c2c ?
    dw   data_04_6959, data_04_6c58                    ;; 04:5c2d ????
    db   $01                                           ;; 04:5c31 ?
    dw   data_04_695c, data_04_6c58                    ;; 04:5c32 ????
    db   $01                                           ;; 04:5c36 ?
    dw   data_04_695f, data_04_6c4e                    ;; 04:5c37 ????
    db   $03                                           ;; 04:5c3b ?
    dw   data_04_691d, data_04_6c4e                    ;; 04:5c3c ????
    db   $01                                           ;; 04:5c40 ?
    dw   data_04_691d, data_04_6c8a                    ;; 04:5c41 ????
    db   $01                                           ;; 04:5c45 ?
    dw   data_04_6932, data_04_6c4e                    ;; 04:5c46 ????
    db   $01                                           ;; 04:5c4a ?
    dw   data_04_6986, data_04_6c4e                    ;; 04:5c4b ????
    db   $01                                           ;; 04:5c4f ?
    dw   data_04_6980, data_04_6c58                    ;; 04:5c50 ????
    db   $01                                           ;; 04:5c54 ?
    dw   data_04_697a, data_04_6c58                    ;; 04:5c55 ????
    db   $02                                           ;; 04:5c59 ?
    dw   data_04_697d, data_04_6c4e                    ;; 04:5c5a ????
    db   $01                                           ;; 04:5c5e ?
    dw   data_04_6977, data_04_6c58                    ;; 04:5c5f ????
    db   $01                                           ;; 04:5c63 ?
    dw   data_04_6989, data_04_6c58                    ;; 04:5c64 ????
    db   $01                                           ;; 04:5c68 ?
    dw   data_04_694a, data_04_6c4e                    ;; 04:5c69 ????
    db   $ff                                           ;; 04:5c6d ?

data_04_5c6e:
    db   $01                                           ;; 04:5c6e ?
    dw   data_04_6929, data_04_6c94                    ;; 04:5c6f ????
    db   $01                                           ;; 04:5c73 ?
    dw   data_04_6929, data_04_6cd6                    ;; 04:5c74 ????
    db   $01                                           ;; 04:5c78 ?
    dw   data_04_6929, data_04_6cec                    ;; 04:5c79 ????
    db   $01                                           ;; 04:5c7d ?
    dw   data_04_6926, data_04_6d02                    ;; 04:5c7e ????
    db   $01                                           ;; 04:5c82 ?
    dw   data_04_6926, data_04_6d18                    ;; 04:5c83 ????
    db   $01                                           ;; 04:5c87 ?
    dw   data_04_6926, data_04_6d2e                    ;; 04:5c88 ????
    db   $01                                           ;; 04:5c8c ?
    dw   data_04_692f, data_04_6caa                    ;; 04:5c8d ????
    db   $01                                           ;; 04:5c91 ?
    dw   data_04_692f, data_04_6cd6                    ;; 04:5c92 ????
    db   $01                                           ;; 04:5c96 ?
    dw   data_04_692f, data_04_6cec                    ;; 04:5c97 ????
    db   $01                                           ;; 04:5c9b ?
    dw   data_04_692c, data_04_6d02                    ;; 04:5c9c ????
    db   $01                                           ;; 04:5ca0 ?
    dw   data_04_692c, data_04_6d18                    ;; 04:5ca1 ????
    db   $01                                           ;; 04:5ca5 ?
    dw   data_04_692c, data_04_6d2e                    ;; 04:5ca6 ????
    db   $ff                                           ;; 04:5caa ?

data_04_5cab:
    db   $01                                           ;; 04:5cab ?
    dw   data_04_692f, data_04_6c94                    ;; 04:5cac ????
    db   $01                                           ;; 04:5cb0 ?
    dw   data_04_692f, data_04_6cd6                    ;; 04:5cb1 ????
    db   $01                                           ;; 04:5cb5 ?
    dw   data_04_692f, data_04_6cec                    ;; 04:5cb6 ????
    db   $01                                           ;; 04:5cba ?
    dw   data_04_692c, data_04_6d02                    ;; 04:5cbb ????
    db   $01                                           ;; 04:5cbf ?
    dw   data_04_692c, data_04_6d18                    ;; 04:5cc0 ????
    db   $01                                           ;; 04:5cc4 ?
    dw   data_04_692c, data_04_6d2e                    ;; 04:5cc5 ????
    db   $01                                           ;; 04:5cc9 ?
    dw   data_04_6929, data_04_6caa                    ;; 04:5cca ????
    db   $01                                           ;; 04:5cce ?
    dw   data_04_6929, data_04_6cd6                    ;; 04:5ccf ????
    db   $01                                           ;; 04:5cd3 ?
    dw   data_04_6929, data_04_6cec                    ;; 04:5cd4 ????
    db   $01                                           ;; 04:5cd8 ?
    dw   data_04_6926, data_04_6d02                    ;; 04:5cd9 ????
    db   $01                                           ;; 04:5cdd ?
    dw   data_04_6926, data_04_6d18                    ;; 04:5cde ????
    db   $01                                           ;; 04:5ce2 ?
    dw   data_04_6926, data_04_6d2e                    ;; 04:5ce3 ????
    db   $ff                                           ;; 04:5ce7 ?

data_04_5ce8:
    db   $01                                           ;; 04:5ce8 .
    dw   data_04_69a7, data_04_6dac                    ;; 04:5ce9 ....
    db   $04                                           ;; 04:5ced .
    dw   data_04_6914, data_04_6dac                    ;; 04:5cee ....
    db   $01                                           ;; 04:5cf2 .
    dw   data_04_69aa, data_04_6d9c                    ;; 04:5cf3 ....
    db   $04                                           ;; 04:5cf7 .
    dw   data_04_6917, data_04_6d9c                    ;; 04:5cf8 ....
    db   $01                                           ;; 04:5cfc .
    dw   data_04_69ad, data_04_6dac                    ;; 04:5cfd ....
    db   $04                                           ;; 04:5d01 .
    dw   data_04_6914, data_04_6dac                    ;; 04:5d02 ....
    db   $01                                           ;; 04:5d06 .
    dw   data_04_69b0, data_04_6d9c                    ;; 04:5d07 ....
    db   $04                                           ;; 04:5d0b .
    dw   data_04_6917, data_04_6d9c                    ;; 04:5d0c ....
    db   $01                                           ;; 04:5d10 .
    dw   data_04_69b3, data_04_6dac                    ;; 04:5d11 ....
    db   $04                                           ;; 04:5d15 .
    dw   data_04_6914, data_04_6dac                    ;; 04:5d16 ....
    db   $01                                           ;; 04:5d1a .
    dw   data_04_69b6, data_04_6d9c                    ;; 04:5d1b ....
    db   $04                                           ;; 04:5d1f .
    dw   data_04_6917, data_04_6d9c                    ;; 04:5d20 ....
    db   $01                                           ;; 04:5d24 .
    dw   data_04_69b9, data_04_6dac                    ;; 04:5d25 ....
    db   $04                                           ;; 04:5d29 .
    dw   data_04_6914, data_04_6dac                    ;; 04:5d2a ....
    db   $01                                           ;; 04:5d2e .
    dw   data_04_69bc, data_04_6d9c                    ;; 04:5d2f ....
    db   $04                                           ;; 04:5d33 .
    dw   data_04_6917, data_04_6d9c                    ;; 04:5d34 ....
    db   $01                                           ;; 04:5d38 .
    dw   data_04_69bf, data_04_6dac                    ;; 04:5d39 ....
    db   $ff                                           ;; 04:5d3d .

data_04_5d3e:
    db   $01                                           ;; 04:5d3e .
    dw   data_04_69c2, data_04_6d9c                    ;; 04:5d3f ....
    db   $04                                           ;; 04:5d43 .
    dw   data_04_6917, data_04_6d9c                    ;; 04:5d44 ....
    db   $01                                           ;; 04:5d48 .
    dw   data_04_69c5, data_04_6dac                    ;; 04:5d49 ....
    db   $04                                           ;; 04:5d4d .
    dw   data_04_6914, data_04_6dac                    ;; 04:5d4e ....
    db   $01                                           ;; 04:5d52 .
    dw   data_04_69c8, data_04_6d9c                    ;; 04:5d53 ....
    db   $04                                           ;; 04:5d57 .
    dw   data_04_6917, data_04_6d9c                    ;; 04:5d58 ....
    db   $01                                           ;; 04:5d5c .
    dw   data_04_69cb, data_04_6dac                    ;; 04:5d5d ....
    db   $04                                           ;; 04:5d61 .
    dw   data_04_6914, data_04_6dac                    ;; 04:5d62 ....
    db   $01                                           ;; 04:5d66 .
    dw   data_04_69ce, data_04_6d9c                    ;; 04:5d67 ....
    db   $04                                           ;; 04:5d6b .
    dw   data_04_6917, data_04_6d9c                    ;; 04:5d6c ....
    db   $01                                           ;; 04:5d70 .
    dw   data_04_69d1, data_04_6dac                    ;; 04:5d71 ....
    db   $04                                           ;; 04:5d75 .
    dw   data_04_6914, data_04_6dac                    ;; 04:5d76 ....
    db   $01                                           ;; 04:5d7a .
    dw   data_04_69d4, data_04_6d9c                    ;; 04:5d7b ....
    db   $04                                           ;; 04:5d7f .
    dw   data_04_6917, data_04_6d9c                    ;; 04:5d80 ....
    db   $01                                           ;; 04:5d84 .
    dw   data_04_69d7, data_04_6dac                    ;; 04:5d85 ....
    db   $04                                           ;; 04:5d89 .
    dw   data_04_6914, data_04_6dac                    ;; 04:5d8a ....
    db   $01                                           ;; 04:5d8e .
    dw   data_04_69da, data_04_6d9c                    ;; 04:5d8f ....
    db   $ff                                           ;; 04:5d93 .

data_04_5d94:
    db   $0c                                           ;; 04:5d94 ?
    dw   data_04_69e3, data_04_6dbc                    ;; 04:5d95 ????
    db   $0c                                           ;; 04:5d99 ?
    dw   data_04_69e0, data_04_6dbc                    ;; 04:5d9a ????
    db   $ff                                           ;; 04:5d9e ?

data_04_5d9f:
    db   $0c                                           ;; 04:5d9f ?
    dw   data_04_69e6, data_04_6dbc                    ;; 04:5da0 ????
    db   $0c                                           ;; 04:5da4 ?
    dw   data_04_69e0, data_04_6dbc                    ;; 04:5da5 ????
    db   $ff                                           ;; 04:5da9 ?

data_04_5daa:
    db   $0c                                           ;; 04:5daa ?
    dw   data_04_69dd, data_04_6dbc                    ;; 04:5dab ????
    db   $0c                                           ;; 04:5daf ?
    dw   data_04_69e0, data_04_6dbc                    ;; 04:5db0 ????
    db   $ff                                           ;; 04:5db4 ?

data_04_5db5:
    db   $02                                           ;; 04:5db5 ?
    dw   data_04_6914, data_04_6dac                    ;; 04:5db6 ????
    db   $ff, $02, $17, $69, $9c, $6d, $ff             ;; 04:5dba ???????

data_04_5dc1:
    db   $04                                           ;; 04:5dc1 .
    dw   data_04_69dd, data_04_6dbc                    ;; 04:5dc2 ....
    db   $ff                                           ;; 04:5dc6 .

data_04_5dc7:
    db   $01                                           ;; 04:5dc7 ?
    dw   data_04_69a7, data_04_6dcc                    ;; 04:5dc8 ????
    db   $01                                           ;; 04:5dcc ?
    dw   data_04_6914, data_04_6dcc                    ;; 04:5dcd ????
    db   $01                                           ;; 04:5dd1 ?
    dw   data_04_69aa, data_04_6dcc                    ;; 04:5dd2 ????
    db   $01                                           ;; 04:5dd6 ?
    dw   data_04_6917, data_04_6dcc                    ;; 04:5dd7 ????
    db   $01                                           ;; 04:5ddb ?
    dw   data_04_6917, data_04_6deb                    ;; 04:5ddc ????
    db   $01                                           ;; 04:5de0 ?
    dw   data_04_69ad, data_04_6dcc                    ;; 04:5de1 ????
    db   $01                                           ;; 04:5de5 ?
    dw   data_04_6914, data_04_6dcc                    ;; 04:5de6 ????
    db   $01                                           ;; 04:5dea ?
    dw   data_04_69b0, data_04_6dcc                    ;; 04:5deb ????
    db   $01                                           ;; 04:5def ?
    dw   data_04_6917, data_04_6dcc                    ;; 04:5df0 ????
    db   $01                                           ;; 04:5df4 ?
    dw   data_04_69b3, data_04_6dcc                    ;; 04:5df5 ????
    db   $01                                           ;; 04:5df9 ?
    dw   data_04_6914, data_04_6dcc                    ;; 04:5dfa ????
    db   $01                                           ;; 04:5dfe ?
    dw   data_04_69b6, data_04_6dcc                    ;; 04:5dff ????
    db   $01                                           ;; 04:5e03 ?
    dw   data_04_6917, data_04_6dcc                    ;; 04:5e04 ????
    db   $01                                           ;; 04:5e08 ?
    dw   data_04_69b9, data_04_6dcc                    ;; 04:5e09 ????
    db   $01                                           ;; 04:5e0d ?
    dw   data_04_6914, data_04_6dcc                    ;; 04:5e0e ????
    db   $01                                           ;; 04:5e12 ?
    dw   data_04_69bc, data_04_6dcc                    ;; 04:5e13 ????
    db   $01                                           ;; 04:5e17 ?
    dw   data_04_6917, data_04_6dcc                    ;; 04:5e18 ????
    db   $01                                           ;; 04:5e1c ?
    dw   data_04_69bf, data_04_6dcc                    ;; 04:5e1d ????
    db   $ff                                           ;; 04:5e21 ?

data_04_5e22:
    db   $01                                           ;; 04:5e22 ?
    dw   data_04_69c2, data_04_6dcc                    ;; 04:5e23 ????
    db   $01                                           ;; 04:5e27 ?
    dw   data_04_6917, data_04_6dcc                    ;; 04:5e28 ????
    db   $01                                           ;; 04:5e2c ?
    dw   data_04_69c5, data_04_6dcc                    ;; 04:5e2d ????
    db   $01                                           ;; 04:5e31 ?
    dw   data_04_6914, data_04_6dcc                    ;; 04:5e32 ????
    db   $01                                           ;; 04:5e36 ?
    dw   data_04_69c8, data_04_6dcc                    ;; 04:5e37 ????
    db   $01                                           ;; 04:5e3b ?
    dw   data_04_6917, data_04_6dcc                    ;; 04:5e3c ????
    db   $01                                           ;; 04:5e40 ?
    dw   data_04_69cb, data_04_6dcc                    ;; 04:5e41 ????
    db   $01                                           ;; 04:5e45 ?
    dw   data_04_6914, data_04_6dcc                    ;; 04:5e46 ????
    db   $01                                           ;; 04:5e4a ?
    dw   data_04_6917, data_04_6deb                    ;; 04:5e4b ????
    db   $01                                           ;; 04:5e4f ?
    dw   data_04_69ce, data_04_6dcc                    ;; 04:5e50 ????
    db   $01                                           ;; 04:5e54 ?
    dw   data_04_6917, data_04_6dcc                    ;; 04:5e55 ????
    db   $01                                           ;; 04:5e59 ?
    dw   data_04_69d1, data_04_6dcc                    ;; 04:5e5a ????
    db   $01                                           ;; 04:5e5e ?
    dw   data_04_6914, data_04_6dcc                    ;; 04:5e5f ????
    db   $01                                           ;; 04:5e63 ?
    dw   data_04_69d4, data_04_6dcc                    ;; 04:5e64 ????
    db   $01                                           ;; 04:5e68 ?
    dw   data_04_6917, data_04_6dcc                    ;; 04:5e69 ????
    db   $01                                           ;; 04:5e6d ?
    dw   data_04_69d7, data_04_6dcc                    ;; 04:5e6e ????
    db   $01                                           ;; 04:5e72 ?
    dw   data_04_6914, data_04_6dcc                    ;; 04:5e73 ????
    db   $01                                           ;; 04:5e77 ?
    dw   data_04_69da, data_04_6dcc                    ;; 04:5e78 ????
    db   $ff                                           ;; 04:5e7c ?

data_04_5e7d:
    db   $0c                                           ;; 04:5e7d ?
    dw   data_04_69e3, data_04_6e0a                    ;; 04:5e7e ????
    db   $0c                                           ;; 04:5e82 ?
    dw   data_04_69e0, data_04_6e0a                    ;; 04:5e83 ????
    db   $ff                                           ;; 04:5e87 ?

data_04_5e88:
    db   $0c                                           ;; 04:5e88 ?
    dw   data_04_69e6, data_04_6e0a                    ;; 04:5e89 ????
    db   $0c                                           ;; 04:5e8d ?
    dw   data_04_69e0, data_04_6e0a                    ;; 04:5e8e ????
    db   $ff                                           ;; 04:5e92 ?

data_04_5e93:
    db   $0c                                           ;; 04:5e93 ?
    dw   data_04_69dd, data_04_6e0a                    ;; 04:5e94 ????
    db   $0c                                           ;; 04:5e98 ?
    dw   data_04_69e0, data_04_6e0a                    ;; 04:5e99 ????
    db   $ff                                           ;; 04:5e9d ?

data_04_5e9e:
    db   $02                                           ;; 04:5e9e ?
    dw   data_04_6914, data_04_6dcc                    ;; 04:5e9f ????
    db   $ff                                           ;; 04:5ea3 ?

data_04_5ea4:
    db   $01                                           ;; 04:5ea4 ?
    dw   data_04_6914, data_04_6dcc                    ;; 04:5ea5 ????
    db   $01                                           ;; 04:5ea9 ?
    dw   data_04_6917, data_04_6deb                    ;; 04:5eaa ????
    db   $ff                                           ;; 04:5eae ?

data_04_5eaf:
    db   $01                                           ;; 04:5eaf ?
    dw   data_04_693e, data_04_6ede                    ;; 04:5eb0 ????
    db   $01                                           ;; 04:5eb4 ?
    dw   data_04_693e, data_04_6ecb                    ;; 04:5eb5 ????
    db   $01                                           ;; 04:5eb9 ?
    dw   data_04_693e, data_04_6eb8                    ;; 04:5eba ????
    db   $02                                           ;; 04:5ebe ?
    dw   data_04_693e, data_04_6ea5                    ;; 04:5ebf ????
    db   $01                                           ;; 04:5ec3 ?
    dw   data_04_693e, data_04_6eb8                    ;; 04:5ec4 ????
    db   $01                                           ;; 04:5ec8 ?
    dw   data_04_693e, data_04_6ecb                    ;; 04:5ec9 ????
    db   $02                                           ;; 04:5ecd ?
    dw   data_04_693e, data_04_6ede                    ;; 04:5ece ????
    db   $01                                           ;; 04:5ed2 ?
    dw   data_04_693e, data_04_6ecb                    ;; 04:5ed3 ????
    db   $01                                           ;; 04:5ed7 ?
    dw   data_04_697d, data_04_6eb8                    ;; 04:5ed8 ????
    db   $02                                           ;; 04:5edc ?
    dw   data_04_697d, data_04_6ea5                    ;; 04:5edd ????
    db   $01                                           ;; 04:5ee1 ?
    dw   data_04_697d, data_04_6eb8                    ;; 04:5ee2 ????
    db   $01                                           ;; 04:5ee6 ?
    dw   data_04_697d, data_04_6ecb                    ;; 04:5ee7 ????
    db   $01                                           ;; 04:5eeb ?
    dw   data_04_697d, data_04_6ede                    ;; 04:5eec ????
    db   $ff                                           ;; 04:5ef0 ?

data_04_5ef1:
    db   $01                                           ;; 04:5ef1 ?
    dw   data_04_696b, data_04_6ede                    ;; 04:5ef2 ????
    db   $01                                           ;; 04:5ef6 ?
    dw   data_04_696b, data_04_6ecb                    ;; 04:5ef7 ????
    db   $01                                           ;; 04:5efb ?
    dw   data_04_696b, data_04_6eb8                    ;; 04:5efc ????
    db   $02                                           ;; 04:5f00 ?
    dw   data_04_696b, data_04_6ea5                    ;; 04:5f01 ????
    db   $01                                           ;; 04:5f05 ?
    dw   data_04_696b, data_04_6eb8                    ;; 04:5f06 ????
    db   $01                                           ;; 04:5f0a ?
    dw   data_04_696b, data_04_6ecb                    ;; 04:5f0b ????
    db   $02                                           ;; 04:5f0f ?
    dw   data_04_696b, data_04_6ede                    ;; 04:5f10 ????
    db   $01                                           ;; 04:5f14 ?
    dw   data_04_696b, data_04_6ecb                    ;; 04:5f15 ????
    db   $01                                           ;; 04:5f19 ?
    dw   data_04_6956, data_04_6eb8                    ;; 04:5f1a ????
    db   $02                                           ;; 04:5f1e ?
    dw   data_04_6956, data_04_6ea5                    ;; 04:5f1f ????
    db   $01                                           ;; 04:5f23 ?
    dw   data_04_6956, data_04_6eb8                    ;; 04:5f24 ????
    db   $01                                           ;; 04:5f28 ?
    dw   data_04_6956, data_04_6ecb                    ;; 04:5f29 ????
    db   $01                                           ;; 04:5f2d ?
    dw   data_04_6956, data_04_6ede                    ;; 04:5f2e ????
    db   $ff                                           ;; 04:5f32 ?

data_04_5f33:
    db   $01                                           ;; 04:5f33 ?
    dw   data_04_691d, data_04_6ede                    ;; 04:5f34 ????
    db   $01                                           ;; 04:5f38 ?
    dw   data_04_691d, data_04_6ecb                    ;; 04:5f39 ????
    db   $01                                           ;; 04:5f3d ?
    dw   data_04_691d, data_04_6eb8                    ;; 04:5f3e ????
    db   $01                                           ;; 04:5f42 ?
    dw   data_04_691d, data_04_6ea5                    ;; 04:5f43 ????
    db   $01                                           ;; 04:5f47 ?
    dw   data_04_691d, data_04_6eb8                    ;; 04:5f48 ????
    db   $01                                           ;; 04:5f4c ?
    dw   data_04_691d, data_04_6ecb                    ;; 04:5f4d ????
    db   $01                                           ;; 04:5f51 ?
    dw   data_04_691d, data_04_6ede                    ;; 04:5f52 ????
    db   $01                                           ;; 04:5f56 ?
    dw   data_04_691d, data_04_6ecb                    ;; 04:5f57 ????
    db   $01                                           ;; 04:5f5b ?
    dw   data_04_691d, data_04_6eb8                    ;; 04:5f5c ????
    db   $01                                           ;; 04:5f60 ?
    dw   data_04_691d, data_04_6ea5                    ;; 04:5f61 ????
    db   $01                                           ;; 04:5f65 ?
    dw   data_04_691d, data_04_6eb8                    ;; 04:5f66 ????
    db   $01                                           ;; 04:5f6a ?
    dw   data_04_691d, data_04_6ecb                    ;; 04:5f6b ????
    db   $ff                                           ;; 04:5f6f ?

data_04_5f70:
    db   $01                                           ;; 04:5f70 ?
    dw   data_04_69e9, data_04_6ede                    ;; 04:5f71 ????
    db   $01                                           ;; 04:5f75 ?
    dw   data_04_69ec, data_04_6ecb                    ;; 04:5f76 ????
    db   $01                                           ;; 04:5f7a ?
    dw   data_04_69ef, data_04_6eb8                    ;; 04:5f7b ????
    db   $01                                           ;; 04:5f7f ?
    dw   data_04_69f2, data_04_6ea5                    ;; 04:5f80 ????
    db   $01                                           ;; 04:5f84 ?
    dw   data_04_69f5, data_04_6ea5                    ;; 04:5f85 ????
    db   $01                                           ;; 04:5f89 ?
    dw   data_04_69f5, data_04_6eb8                    ;; 04:5f8a ????
    db   $01                                           ;; 04:5f8e ?
    dw   data_04_69f5, data_04_6ecb                    ;; 04:5f8f ????
    db   $01                                           ;; 04:5f93 ?
    dw   data_04_69f5, data_04_6ede                    ;; 04:5f94 ????
    db   $01                                           ;; 04:5f98 ?
    dw   data_04_69f5, data_04_6ecb                    ;; 04:5f99 ????
    db   $01                                           ;; 04:5f9d ?
    dw   data_04_69f5, data_04_6eb8                    ;; 04:5f9e ????
    db   $01                                           ;; 04:5fa2 ?
    dw   data_04_69f5, data_04_6ea5                    ;; 04:5fa3 ????
    db   $01                                           ;; 04:5fa7 ?
    dw   data_04_69f5, data_04_6eb8                    ;; 04:5fa8 ????
    db   $01                                           ;; 04:5fac ?
    dw   data_04_6914, data_04_6ef1                    ;; 04:5fad ????
    db   $03                                           ;; 04:5fb1 ?
    dw   data_04_6914, data_04_6f04                    ;; 04:5fb2 ????
    db   $01                                           ;; 04:5fb6 ?
    dw   data_04_6914, data_04_6ef1                    ;; 04:5fb7 ????
    db   $01                                           ;; 04:5fbb ?
    dw   data_04_69e9, data_04_6ecb                    ;; 04:5fbc ????
    db   $01                                           ;; 04:5fc0 ?
    dw   data_04_69e9, data_04_6eb8                    ;; 04:5fc1 ????
    db   $01                                           ;; 04:5fc5 ?
    dw   data_04_69e9, data_04_6ea5                    ;; 04:5fc6 ????
    db   $01                                           ;; 04:5fca ?
    dw   data_04_69e9, data_04_6eb8                    ;; 04:5fcb ????
    db   $01                                           ;; 04:5fcf ?
    dw   data_04_69e9, data_04_6ecb                    ;; 04:5fd0 ????
    db   $01                                           ;; 04:5fd4 ?
    dw   data_04_69e9, data_04_6ede                    ;; 04:5fd5 ????
    db   $ff                                           ;; 04:5fd9 ?

data_04_5fda:
    db   $02                                           ;; 04:5fda ?
    dw   data_04_6923, data_04_6f17                    ;; 04:5fdb ????
    db   $02                                           ;; 04:5fdf ?
    dw   data_04_69a4, data_04_6f27                    ;; 04:5fe0 ????
    db   $02                                           ;; 04:5fe4 ?
    dw   data_04_6923, data_04_6f17                    ;; 04:5fe5 ????
    db   $02                                           ;; 04:5fe9 ?
    dw   data_04_69a4, data_04_6f27                    ;; 04:5fea ????
    db   $02                                           ;; 04:5fee ?
    dw   data_04_6914, data_04_6f27                    ;; 04:5fef ????
    db   $02                                           ;; 04:5ff3 ?
    dw   data_04_6902, data_04_6f17                    ;; 04:5ff4 ????
    db   $01                                           ;; 04:5ff8 ?
    dw   data_04_6914, data_04_6f27                    ;; 04:5ff9 ????
    db   $01                                           ;; 04:5ffd ?
    dw   data_04_6914, data_04_6f37                    ;; 04:5ffe ????
    db   $02                                           ;; 04:6002 ?
    dw   data_04_6902, data_04_6f17                    ;; 04:6003 ????
    db   $02                                           ;; 04:6007 ?
    dw   data_04_6914, data_04_6f27                    ;; 04:6008 ????
    db   $02                                           ;; 04:600c ?
    dw   data_04_6920, data_04_6f17                    ;; 04:600d ????
    db   $02                                           ;; 04:6011 ?
    dw   data_04_69a1, data_04_6f27                    ;; 04:6012 ????
    db   $02                                           ;; 04:6016 ?
    dw   data_04_6920, data_04_6f17                    ;; 04:6017 ????
    db   $02                                           ;; 04:601b ?
    dw   data_04_69a1, data_04_6f27                    ;; 04:601c ????
    db   $ff                                           ;; 04:6020 ?

data_04_6021:
    db   $02                                           ;; 04:6021 ?
    dw   data_04_6926, data_04_6f17                    ;; 04:6022 ????
    db   $02                                           ;; 04:6026 ?
    dw   data_04_6929, data_04_6f27                    ;; 04:6027 ????
    db   $02                                           ;; 04:602b ?
    dw   data_04_6926, data_04_6f17                    ;; 04:602c ????
    db   $02                                           ;; 04:6030 ?
    dw   data_04_6929, data_04_6f27                    ;; 04:6031 ????
    db   $ff                                           ;; 04:6035 ?

data_04_6036:
    db   $02                                           ;; 04:6036 ?
    dw   data_04_692c, data_04_6f17                    ;; 04:6037 ????
    db   $02                                           ;; 04:603b ?
    dw   data_04_692f, data_04_6f27                    ;; 04:603c ????
    db   $02                                           ;; 04:6040 ?
    dw   data_04_692c, data_04_6f17                    ;; 04:6041 ????
    db   $02                                           ;; 04:6045 ?
    dw   data_04_692f, data_04_6f27                    ;; 04:6046 ????
    db   $ff                                           ;; 04:604a ?

data_04_604b:
    db   $01                                           ;; 04:604b ?
    dw   data_04_694a, data_04_6f17                    ;; 04:604c ????
    db   $01                                           ;; 04:6050 ?
    dw   data_04_694d, data_04_6f17                    ;; 04:6051 ????
    db   $01                                           ;; 04:6055 ?
    dw   data_04_6950, data_04_6f27                    ;; 04:6056 ????
    db   $01                                           ;; 04:605a ?
    dw   data_04_6953, data_04_6f27                    ;; 04:605b ????
    db   $02                                           ;; 04:605f ?
    dw   data_04_6956, data_04_6f17                    ;; 04:6060 ????
    db   $01                                           ;; 04:6064 ?
    dw   data_04_6959, data_04_6f27                    ;; 04:6065 ????
    db   $01                                           ;; 04:6069 ?
    dw   data_04_695c, data_04_6f27                    ;; 04:606a ????
    db   $01                                           ;; 04:606e ?
    dw   data_04_695f, data_04_6f17                    ;; 04:606f ????
    db   $02                                           ;; 04:6073 ?
    dw   data_04_6914, data_04_6f27                    ;; 04:6074 ????
    db   $02                                           ;; 04:6078 ?
    dw   data_04_6902, data_04_6f17                    ;; 04:6079 ????
    db   $01                                           ;; 04:607d ?
    dw   data_04_6914, data_04_6f27                    ;; 04:607e ????
    db   $01                                           ;; 04:6082 ?
    dw   data_04_6914, data_04_6f37                    ;; 04:6083 ????
    db   $02                                           ;; 04:6087 ?
    dw   data_04_6902, data_04_6f17                    ;; 04:6088 ????
    db   $02                                           ;; 04:608c ?
    dw   data_04_6914, data_04_6f27                    ;; 04:608d ????
    db   $01                                           ;; 04:6091 ?
    dw   data_04_6932, data_04_6f17                    ;; 04:6092 ????
    db   $01                                           ;; 04:6096 ?
    dw   data_04_6935, data_04_6f17                    ;; 04:6097 ????
    db   $01                                           ;; 04:609b ?
    dw   data_04_6938, data_04_6f27                    ;; 04:609c ????
    db   $01                                           ;; 04:60a0 ?
    dw   data_04_693b, data_04_6f27                    ;; 04:60a1 ????
    db   $02                                           ;; 04:60a5 ?
    dw   data_04_693e, data_04_6f17                    ;; 04:60a6 ????
    db   $01                                           ;; 04:60aa ?
    dw   data_04_6941, data_04_6f27                    ;; 04:60ab ????
    db   $01                                           ;; 04:60af ?
    dw   data_04_6944, data_04_6f27                    ;; 04:60b0 ????
    db   $01                                           ;; 04:60b4 ?
    dw   data_04_6947, data_04_6f17                    ;; 04:60b5 ????
    db   $ff                                           ;; 04:60b9 ?

data_04_60ba:
    db   $01                                           ;; 04:60ba ?
    dw   data_04_6947, data_04_6f17                    ;; 04:60bb ????
    db   $01                                           ;; 04:60bf ?
    dw   data_04_698c, data_04_6f17                    ;; 04:60c0 ????
    db   $01                                           ;; 04:60c4 ?
    dw   data_04_696e, data_04_6f27                    ;; 04:60c5 ????
    db   $01                                           ;; 04:60c9 ?
    dw   data_04_6968, data_04_6f27                    ;; 04:60ca ????
    db   $02                                           ;; 04:60ce ?
    dw   data_04_696b, data_04_6f17                    ;; 04:60cf ????
    db   $01                                           ;; 04:60d3 ?
    dw   data_04_6965, data_04_6f27                    ;; 04:60d4 ????
    db   $01                                           ;; 04:60d8 ?
    dw   data_04_698f, data_04_6f27                    ;; 04:60d9 ????
    db   $01                                           ;; 04:60dd ?
    dw   data_04_695f, data_04_6f17                    ;; 04:60de ????
    db   $02                                           ;; 04:60e2 ?
    dw   data_04_6914, data_04_6f27                    ;; 04:60e3 ????
    db   $02                                           ;; 04:60e7 ?
    dw   data_04_6902, data_04_6f17                    ;; 04:60e8 ????
    db   $01                                           ;; 04:60ec ?
    dw   data_04_6914, data_04_6f27                    ;; 04:60ed ????
    db   $01                                           ;; 04:60f1 ?
    dw   data_04_6914, data_04_6f37                    ;; 04:60f2 ????
    db   $02                                           ;; 04:60f6 ?
    dw   data_04_6902, data_04_6f17                    ;; 04:60f7 ????
    db   $02                                           ;; 04:60fb ?
    dw   data_04_6914, data_04_6f27                    ;; 04:60fc ????
    db   $01                                           ;; 04:6100 ?
    dw   data_04_6932, data_04_6f17                    ;; 04:6101 ????
    db   $01                                           ;; 04:6105 ?
    dw   data_04_6986, data_04_6f17                    ;; 04:6106 ????
    db   $01                                           ;; 04:610a ?
    dw   data_04_6980, data_04_6f27                    ;; 04:610b ????
    db   $01                                           ;; 04:610f ?
    dw   data_04_697a, data_04_6f27                    ;; 04:6110 ????
    db   $02                                           ;; 04:6114 ?
    dw   data_04_697d, data_04_6f17                    ;; 04:6115 ????
    db   $01                                           ;; 04:6119 ?
    dw   data_04_6977, data_04_6f27                    ;; 04:611a ????
    db   $01                                           ;; 04:611e ?
    dw   data_04_6989, data_04_6f27                    ;; 04:611f ????
    db   $01                                           ;; 04:6123 ?
    dw   data_04_694a, data_04_6f17                    ;; 04:6124 ????
    db   $ff                                           ;; 04:6128 ?

data_04_6129:
    db   $08                                           ;; 04:6129 ?
    dw   data_04_690b, data_04_6f17                    ;; 04:612a ????
    db   $10                                           ;; 04:612e ?
    dw   data_04_6911, data_04_6f17                    ;; 04:612f ????
    db   $02                                           ;; 04:6133 ?
    dw   data_04_690b, data_04_6f17                    ;; 04:6134 ????
    db   $02                                           ;; 04:6138 ?
    dw   data_04_69fb, data_04_6f27                    ;; 04:6139 ????
    db   $02                                           ;; 04:613d ?
    dw   data_04_690b, data_04_6f17                    ;; 04:613e ????
    db   $02                                           ;; 04:6142 ?
    dw   data_04_69fb, data_04_6f27                    ;; 04:6143 ????
    db   $02                                           ;; 04:6147 ?
    dw   data_04_6908, data_04_6f17                    ;; 04:6148 ????
    db   $02                                           ;; 04:614c ?
    dw   data_04_69f8, data_04_6f27                    ;; 04:614d ????
    db   $02                                           ;; 04:6151 ?
    dw   data_04_6908, data_04_6f17                    ;; 04:6152 ????
    db   $02                                           ;; 04:6156 ?
    dw   data_04_69f8, data_04_6f27                    ;; 04:6157 ????
    db   $10                                           ;; 04:615b ?
    dw   data_04_690e, data_04_6f17                    ;; 04:615c ????
    db   $08                                           ;; 04:6160 ?
    dw   data_04_6908, data_04_6f17                    ;; 04:6161 ????
    db   $ff                                           ;; 04:6165 ?

data_04_6166:
    db   $08                                           ;; 04:6166 ?
    dw   data_04_6911, data_04_6f17                    ;; 04:6167 ????
    db   $10                                           ;; 04:616b ?
    dw   data_04_690b, data_04_6f17                    ;; 04:616c ????
    db   $02                                           ;; 04:6170 ?
    dw   data_04_6911, data_04_6f17                    ;; 04:6171 ????
    db   $02                                           ;; 04:6175 ?
    dw   data_04_6a01, data_04_6f27                    ;; 04:6176 ????
    db   $02                                           ;; 04:617a ?
    dw   data_04_6911, data_04_6f17                    ;; 04:617b ????
    db   $02                                           ;; 04:617f ?
    dw   data_04_6a01, data_04_6f27                    ;; 04:6180 ????
    db   $02                                           ;; 04:6184 ?
    dw   data_04_690e, data_04_6f17                    ;; 04:6185 ????
    db   $02                                           ;; 04:6189 ?
    dw   data_04_69fe, data_04_6f27                    ;; 04:618a ????
    db   $02                                           ;; 04:618e ?
    dw   data_04_690e, data_04_6f17                    ;; 04:618f ????
    db   $02                                           ;; 04:6193 ?
    dw   data_04_69fe, data_04_6f27                    ;; 04:6194 ????
    db   $10                                           ;; 04:6198 ?
    dw   data_04_6908, data_04_6f17                    ;; 04:6199 ????
    db   $08                                           ;; 04:619d ?
    dw   data_04_690e, data_04_6f17                    ;; 04:619e ????
    db   $ff                                           ;; 04:61a2 ?

data_04_61a3:
    db   $02                                           ;; 04:61a3 ?
    dw   data_04_6920, data_04_6f87                    ;; 04:61a4 ????
    db   $02                                           ;; 04:61a8 ?
    dw   data_04_6920, data_04_6fa0                    ;; 04:61a9 ????
    db   $02                                           ;; 04:61ad ?
    dw   data_04_6920, data_04_7004                    ;; 04:61ae ????
    db   $02                                           ;; 04:61b2 ?
    dw   data_04_6920, data_04_6fd2                    ;; 04:61b3 ????
    db   $02                                           ;; 04:61b7 ?
    dw   data_04_6920, data_04_6f87                    ;; 04:61b8 ????
    db   $02                                           ;; 04:61bc ?
    dw   data_04_6920, data_04_6fa0                    ;; 04:61bd ????
    db   $ff                                           ;; 04:61c1 ?

data_04_61c2:
    db   $02                                           ;; 04:61c2 ?
    dw   data_04_6923, data_04_6f87                    ;; 04:61c3 ????
    db   $02                                           ;; 04:61c7 ?
    dw   data_04_6923, data_04_6fa0                    ;; 04:61c8 ????
    db   $02                                           ;; 04:61cc ?
    dw   data_04_6923, data_04_7004                    ;; 04:61cd ????
    db   $02                                           ;; 04:61d1 ?
    dw   data_04_6923, data_04_6fd2                    ;; 04:61d2 ????
    db   $02                                           ;; 04:61d6 ?
    dw   data_04_6923, data_04_6f87                    ;; 04:61d7 ????
    db   $02                                           ;; 04:61db ?
    dw   data_04_6923, data_04_6fa0                    ;; 04:61dc ????
    db   $ff                                           ;; 04:61e0 ?

data_04_61e1:
    db   $01                                           ;; 04:61e1 ?
    dw   data_04_6a6a, data_04_6f87                    ;; 04:61e2 ????
    db   $01                                           ;; 04:61e6 ?
    dw   data_04_6a6a, data_04_6fa0                    ;; 04:61e7 ????
    db   $01                                           ;; 04:61eb ?
    dw   data_04_6a6a, data_04_6fb9                    ;; 04:61ec ????
    db   $01                                           ;; 04:61f0 ?
    dw   data_04_6a6a, data_04_6fd2                    ;; 04:61f1 ????
    db   $01                                           ;; 04:61f5 ?
    dw   data_04_6a6a, data_04_6f87                    ;; 04:61f6 ????
    db   $01                                           ;; 04:61fa ?
    dw   data_04_6a6a, data_04_6fa0                    ;; 04:61fb ????
    db   $01                                           ;; 04:61ff ?
    dw   data_04_6a6a, data_04_6fb9                    ;; 04:6200 ????
    db   $01                                           ;; 04:6204 ?
    dw   data_04_6a6a, data_04_6fd2                    ;; 04:6205 ????
    db   $01                                           ;; 04:6209 ?
    dw   data_04_6a6a, data_04_6f87                    ;; 04:620a ????
    db   $01                                           ;; 04:620e ?
    dw   data_04_6a6a, data_04_6fa0                    ;; 04:620f ????
    db   $04                                           ;; 04:6213 ?
    dw   data_04_691d, data_04_6feb                    ;; 04:6214 ????
    db   $01                                           ;; 04:6218 ?
    dw   data_04_6a6d, data_04_6f87                    ;; 04:6219 ????
    db   $01                                           ;; 04:621d ?
    dw   data_04_6a6d, data_04_6fa0                    ;; 04:621e ????
    db   $01                                           ;; 04:6222 ?
    dw   data_04_6a6d, data_04_6fb9                    ;; 04:6223 ????
    db   $01                                           ;; 04:6227 ?
    dw   data_04_6a6d, data_04_6fd2                    ;; 04:6228 ????
    db   $01                                           ;; 04:622c ?
    dw   data_04_6a6d, data_04_6f87                    ;; 04:622d ????
    db   $01                                           ;; 04:6231 ?
    dw   data_04_6a6d, data_04_6fa0                    ;; 04:6232 ????
    db   $01                                           ;; 04:6236 ?
    dw   data_04_6a6d, data_04_6fb9                    ;; 04:6237 ????
    db   $01                                           ;; 04:623b ?
    dw   data_04_6a6d, data_04_6fd2                    ;; 04:623c ????
    db   $01                                           ;; 04:6240 ?
    dw   data_04_6a6d, data_04_6f87                    ;; 04:6241 ????
    db   $01                                           ;; 04:6245 ?
    dw   data_04_6a6d, data_04_6fa0                    ;; 04:6246 ????
    db   $ff                                           ;; 04:624a ?

data_04_624b:
    db   $02                                           ;; 04:624b ?
    dw   data_04_6926, data_04_701d                    ;; 04:624c ????
    db   $02                                           ;; 04:6250 ?
    dw   data_04_6929, data_04_7030                    ;; 04:6251 ????
    db   $02                                           ;; 04:6255 ?
    dw   data_04_6926, data_04_701d                    ;; 04:6256 ????
    db   $02                                           ;; 04:625a ?
    dw   data_04_6929, data_04_7030                    ;; 04:625b ????
    db   $02                                           ;; 04:625f ?
    dw   data_04_692c, data_04_701d                    ;; 04:6260 ????
    db   $02                                           ;; 04:6264 ?
    dw   data_04_692f, data_04_7030                    ;; 04:6265 ????
    db   $02                                           ;; 04:6269 ?
    dw   data_04_692c, data_04_701d                    ;; 04:626a ????
    db   $02                                           ;; 04:626e ?
    dw   data_04_692f, data_04_7030                    ;; 04:626f ????
    db   $ff                                           ;; 04:6273 ?

data_04_6274:
    db   $02                                           ;; 04:6274 ?
    dw   data_04_692c, data_04_701d                    ;; 04:6275 ????
    db   $02                                           ;; 04:6279 ?
    dw   data_04_692f, data_04_7030                    ;; 04:627a ????
    db   $02                                           ;; 04:627e ?
    dw   data_04_692c, data_04_701d                    ;; 04:627f ????
    db   $02                                           ;; 04:6283 ?
    dw   data_04_692f, data_04_7030                    ;; 04:6284 ????
    db   $02                                           ;; 04:6288 ?
    dw   data_04_6926, data_04_701d                    ;; 04:6289 ????
    db   $02                                           ;; 04:628d ?
    dw   data_04_6929, data_04_7030                    ;; 04:628e ????
    db   $02                                           ;; 04:6292 ?
    dw   data_04_6926, data_04_701d                    ;; 04:6293 ????
    db   $02                                           ;; 04:6297 ?
    dw   data_04_6929, data_04_7030                    ;; 04:6298 ????
    db   $ff                                           ;; 04:629c ?

data_04_629d:
    db   $02                                           ;; 04:629d ?
    dw   data_04_690b, data_04_7043                    ;; 04:629e ????
    db   $02                                           ;; 04:62a2 ?
    dw   data_04_69fb, data_04_7056                    ;; 04:62a3 ????
    db   $02                                           ;; 04:62a7 ?
    dw   data_04_690b, data_04_7043                    ;; 04:62a8 ????
    db   $02                                           ;; 04:62ac ?
    dw   data_04_69fb, data_04_7056                    ;; 04:62ad ????
    db   $02                                           ;; 04:62b1 ?
    dw   data_04_6911, data_04_7043                    ;; 04:62b2 ????
    db   $02                                           ;; 04:62b6 ?
    dw   data_04_6a01, data_04_7056                    ;; 04:62b7 ????
    db   $02                                           ;; 04:62bb ?
    dw   data_04_6911, data_04_7043                    ;; 04:62bc ????
    db   $02                                           ;; 04:62c0 ?
    dw   data_04_6a01, data_04_7056                    ;; 04:62c1 ????
    db   $02                                           ;; 04:62c5 ?
    dw   data_04_6911, data_04_7043                    ;; 04:62c6 ????
    db   $02                                           ;; 04:62ca ?
    dw   data_04_6a01, data_04_7056                    ;; 04:62cb ????
    db   $02                                           ;; 04:62cf ?
    dw   data_04_6911, data_04_7043                    ;; 04:62d0 ????
    db   $02                                           ;; 04:62d4 ?
    dw   data_04_6a01, data_04_7056                    ;; 04:62d5 ????
    db   $02                                           ;; 04:62d9 ?
    dw   data_04_690b, data_04_7043                    ;; 04:62da ????
    db   $02                                           ;; 04:62de ?
    dw   data_04_69fb, data_04_7056                    ;; 04:62df ????
    db   $02                                           ;; 04:62e3 ?
    dw   data_04_690b, data_04_7043                    ;; 04:62e4 ????
    db   $02                                           ;; 04:62e8 ?
    dw   data_04_69fb, data_04_7056                    ;; 04:62e9 ????
    db   $02                                           ;; 04:62ed ?
    dw   data_04_6908, data_04_7043                    ;; 04:62ee ????
    db   $02                                           ;; 04:62f2 ?
    dw   data_04_69f8, data_04_7056                    ;; 04:62f3 ????
    db   $02                                           ;; 04:62f7 ?
    dw   data_04_6908, data_04_7043                    ;; 04:62f8 ????
    db   $02                                           ;; 04:62fc ?
    dw   data_04_69f8, data_04_7056                    ;; 04:62fd ????
    db   $02                                           ;; 04:6301 ?
    dw   data_04_690e, data_04_7043                    ;; 04:6302 ????
    db   $02                                           ;; 04:6306 ?
    dw   data_04_69fe, data_04_7056                    ;; 04:6307 ????
    db   $02                                           ;; 04:630b ?
    dw   data_04_690e, data_04_7043                    ;; 04:630c ????
    db   $02                                           ;; 04:6310 ?
    dw   data_04_69fe, data_04_7056                    ;; 04:6311 ????
    db   $02                                           ;; 04:6315 ?
    dw   data_04_690e, data_04_7043                    ;; 04:6316 ????
    db   $02                                           ;; 04:631a ?
    dw   data_04_69fe, data_04_7056                    ;; 04:631b ????
    db   $02                                           ;; 04:631f ?
    dw   data_04_690e, data_04_7043                    ;; 04:6320 ????
    db   $02                                           ;; 04:6324 ?
    dw   data_04_69fe, data_04_7056                    ;; 04:6325 ????
    db   $02                                           ;; 04:6329 ?
    dw   data_04_6908, data_04_7043                    ;; 04:632a ????
    db   $02                                           ;; 04:632e ?
    dw   data_04_69f8, data_04_7056                    ;; 04:632f ????
    db   $02                                           ;; 04:6333 ?
    dw   data_04_6908, data_04_7043                    ;; 04:6334 ????
    db   $02                                           ;; 04:6338 ?
    dw   data_04_69f8, data_04_7056                    ;; 04:6339 ????
    db   $ff                                           ;; 04:633d ?

data_04_633e:
    db   $02                                           ;; 04:633e ?
    dw   data_04_6a0a, data_04_701d                    ;; 04:633f ????
    db   $02                                           ;; 04:6343 ?
    dw   data_04_6a0d, data_04_7030                    ;; 04:6344 ????
    db   $02                                           ;; 04:6348 ?
    dw   data_04_6a0a, data_04_701d                    ;; 04:6349 ????
    db   $02                                           ;; 04:634d ?
    dw   data_04_6a0d, data_04_7030                    ;; 04:634e ????
    db   $02                                           ;; 04:6352 ?
    dw   data_04_6a04, data_04_701d                    ;; 04:6353 ????
    db   $02                                           ;; 04:6357 ?
    dw   data_04_6a07, data_04_7030                    ;; 04:6358 ????
    db   $02                                           ;; 04:635c ?
    dw   data_04_6a04, data_04_701d                    ;; 04:635d ????
    db   $02                                           ;; 04:6361 ?
    dw   data_04_6a07, data_04_7030                    ;; 04:6362 ????
    db   $ff                                           ;; 04:6366 ?

data_04_6367:
    db   $02                                           ;; 04:6367 ?
    dw   data_04_6a10, data_04_701d                    ;; 04:6368 ????
    db   $02                                           ;; 04:636c ?
    dw   data_04_6a13, data_04_7030                    ;; 04:636d ????
    db   $02                                           ;; 04:6371 ?
    dw   data_04_6a10, data_04_701d                    ;; 04:6372 ????
    db   $02                                           ;; 04:6376 ?
    dw   data_04_6a13, data_04_7030                    ;; 04:6377 ????
    db   $02                                           ;; 04:637b ?
    dw   data_04_6a16, data_04_701d                    ;; 04:637c ????
    db   $02                                           ;; 04:6380 ?
    dw   data_04_6a19, data_04_7030                    ;; 04:6381 ????
    db   $02                                           ;; 04:6385 ?
    dw   data_04_6a16, data_04_701d                    ;; 04:6386 ????
    db   $02                                           ;; 04:638a ?
    dw   data_04_6a19, data_04_7030                    ;; 04:638b ????
    db   $ff                                           ;; 04:638f ?

data_04_6390:
    db   $0a                                           ;; 04:6390 ?
    dw   data_04_6a3a, data_04_7069                    ;; 04:6391 ????
    db   $02                                           ;; 04:6395 ?
    dw   data_04_6a43, data_04_7095                    ;; 04:6396 ????
    db   $02                                           ;; 04:639a ?
    dw   data_04_6a40, data_04_7069                    ;; 04:639b ????
    db   $02                                           ;; 04:639f ?
    dw   data_04_6a49, data_04_7095                    ;; 04:63a0 ????
    db   $02                                           ;; 04:63a4 ?
    dw   data_04_6a46, data_04_7069                    ;; 04:63a5 ????
    db   $02                                           ;; 04:63a9 ?
    dw   data_04_6a49, data_04_7095                    ;; 04:63aa ????
    db   $02                                           ;; 04:63ae ?
    dw   data_04_6a46, data_04_7069                    ;; 04:63af ????
    db   $02                                           ;; 04:63b3 ?
    dw   data_04_6a49, data_04_7095                    ;; 04:63b4 ????
    db   $04                                           ;; 04:63b8 ?
    dw   data_04_6a4c, data_04_7069                    ;; 04:63b9 ????
    db   $04                                           ;; 04:63bd ?
    dw   data_04_6a4f, data_04_7095                    ;; 04:63be ????
    db   $04                                           ;; 04:63c2 ?
    dw   data_04_6a4c, data_04_7069                    ;; 04:63c3 ????
    db   $04                                           ;; 04:63c7 ?
    dw   data_04_6a4f, data_04_7095                    ;; 04:63c8 ????
    db   $04                                           ;; 04:63cc ?
    dw   data_04_6a4c, data_04_7069                    ;; 04:63cd ????
    db   $04                                           ;; 04:63d1 ?
    dw   data_04_6a4f, data_04_7095                    ;; 04:63d2 ????
    db   $ff                                           ;; 04:63d6 ?

data_04_63d7:
    db   $0a                                           ;; 04:63d7 ?
    dw   data_04_6a1c, data_04_707f                    ;; 04:63d8 ????
    db   $02                                           ;; 04:63dc ?
    dw   data_04_6a25, data_04_70ab                    ;; 04:63dd ????
    db   $02                                           ;; 04:63e1 ?
    dw   data_04_6a22, data_04_707f                    ;; 04:63e2 ????
    db   $02                                           ;; 04:63e6 ?
    dw   data_04_6a2b, data_04_70ab                    ;; 04:63e7 ????
    db   $02                                           ;; 04:63eb ?
    dw   data_04_6a28, data_04_707f                    ;; 04:63ec ????
    db   $02                                           ;; 04:63f0 ?
    dw   data_04_6a2b, data_04_70ab                    ;; 04:63f1 ????
    db   $02                                           ;; 04:63f5 ?
    dw   data_04_6a28, data_04_707f                    ;; 04:63f6 ????
    db   $02                                           ;; 04:63fa ?
    dw   data_04_6a2b, data_04_70ab                    ;; 04:63fb ????
    db   $04                                           ;; 04:63ff ?
    dw   data_04_6a2e, data_04_707f                    ;; 04:6400 ????
    db   $04                                           ;; 04:6404 ?
    dw   data_04_6a31, data_04_70ab                    ;; 04:6405 ????
    db   $04                                           ;; 04:6409 ?
    dw   data_04_6a2e, data_04_707f                    ;; 04:640a ????
    db   $04                                           ;; 04:640e ?
    dw   data_04_6a31, data_04_70ab                    ;; 04:640f ????
    db   $04                                           ;; 04:6413 ?
    dw   data_04_6a2e, data_04_707f                    ;; 04:6414 ????
    db   $04                                           ;; 04:6418 ?
    dw   data_04_6a31, data_04_70ab                    ;; 04:6419 ????
    db   $ff                                           ;; 04:641d ?

data_04_641e:
    db   $04                                           ;; 04:641e ?
    dw   data_04_6a52, data_04_7069                    ;; 04:641f ????
    db   $04                                           ;; 04:6423 ?
    dw   data_04_6a55, data_04_7095                    ;; 04:6424 ????
    db   $04                                           ;; 04:6428 ?
    dw   data_04_6a52, data_04_7069                    ;; 04:6429 ????
    db   $04                                           ;; 04:642d ?
    dw   data_04_6a55, data_04_7095                    ;; 04:642e ????
    db   $ff                                           ;; 04:6432 ?

data_04_6433:
    db   $04                                           ;; 04:6433 ?
    dw   data_04_6a34, data_04_707f                    ;; 04:6434 ????
    db   $04                                           ;; 04:6438 ?
    dw   data_04_6a37, data_04_70ab                    ;; 04:6439 ????
    db   $04                                           ;; 04:643d ?
    dw   data_04_6a34, data_04_707f                    ;; 04:643e ????
    db   $04                                           ;; 04:6442 ?
    dw   data_04_6a37, data_04_70ab                    ;; 04:6443 ????
    db   $ff                                           ;; 04:6447 ?

data_04_6448:
    db   $04                                           ;; 04:6448 ?
    dw   data_04_6a52, data_04_7069                    ;; 04:6449 ????
    db   $01                                           ;; 04:644d ?
    dw   data_04_6a55, data_04_70c1                    ;; 04:644e ????
    db   $02                                           ;; 04:6452 ?
    dw   data_04_6a55, data_04_7095                    ;; 04:6453 ????
    db   $01                                           ;; 04:6457 ?
    dw   data_04_6a55, data_04_70c1                    ;; 04:6458 ????
    db   $04                                           ;; 04:645c ?
    dw   data_04_6a52, data_04_7069                    ;; 04:645d ????
    db   $04                                           ;; 04:6461 ?
    dw   data_04_6a55, data_04_7095                    ;; 04:6462 ????
    db   $04                                           ;; 04:6466 ?
    dw   data_04_6a52, data_04_7069                    ;; 04:6467 ????
    db   $04                                           ;; 04:646b ?
    dw   data_04_6a55, data_04_7095                    ;; 04:646c ????
    db   $04                                           ;; 04:6470 ?
    dw   data_04_6a52, data_04_7069                    ;; 04:6471 ????
    db   $04                                           ;; 04:6475 ?
    dw   data_04_6a55, data_04_7095                    ;; 04:6476 ????
    db   $ff                                           ;; 04:647a ?

data_04_647b:
    db   $04                                           ;; 04:647b ?
    dw   data_04_6a34, data_04_707f                    ;; 04:647c ????
    db   $01                                           ;; 04:6480 ?
    dw   data_04_6a37, data_04_70d7                    ;; 04:6481 ????
    db   $02                                           ;; 04:6485 ?
    dw   data_04_6a37, data_04_70ab                    ;; 04:6486 ????
    db   $01                                           ;; 04:648a ?
    dw   data_04_6a37, data_04_70d7                    ;; 04:648b ????
    db   $04                                           ;; 04:648f ?
    dw   data_04_6a34, data_04_707f                    ;; 04:6490 ????
    db   $04                                           ;; 04:6494 ?
    dw   data_04_6a37, data_04_70ab                    ;; 04:6495 ????
    db   $04                                           ;; 04:6499 ?
    dw   data_04_6a34, data_04_707f                    ;; 04:649a ????
    db   $04                                           ;; 04:649e ?
    dw   data_04_6a37, data_04_70ab                    ;; 04:649f ????
    db   $04                                           ;; 04:64a3 ?
    dw   data_04_6a34, data_04_707f                    ;; 04:64a4 ????
    db   $04                                           ;; 04:64a8 ?
    dw   data_04_6a37, data_04_70ab                    ;; 04:64a9 ????
    db   $ff                                           ;; 04:64ad ?

data_04_64ae:
    db   $02                                           ;; 04:64ae ?
    dw   data_04_6a58, data_04_70ed                    ;; 04:64af ????
    db   $02                                           ;; 04:64b3 ?
    dw   data_04_6a58, data_04_7106                    ;; 04:64b4 ????
    db   $02                                           ;; 04:64b8 ?
    dw   data_04_6a58, data_04_70ed                    ;; 04:64b9 ????
    db   $02                                           ;; 04:64bd ?
    dw   data_04_6a58, data_04_711f                    ;; 04:64be ????
    db   $02                                           ;; 04:64c2 ?
    dw   data_04_6a58, data_04_70ed                    ;; 04:64c3 ????
    db   $02                                           ;; 04:64c7 ?
    dw   data_04_6a58, data_04_7106                    ;; 04:64c8 ????
    db   $02                                           ;; 04:64cc ?
    dw   data_04_6a5e, data_04_70ed                    ;; 04:64cd ????
    db   $02                                           ;; 04:64d1 ?
    dw   data_04_6a5e, data_04_7106                    ;; 04:64d2 ????
    db   $02                                           ;; 04:64d6 ?
    dw   data_04_6a5e, data_04_70ed                    ;; 04:64d7 ????
    db   $02                                           ;; 04:64db ?
    dw   data_04_6a5e, data_04_7106                    ;; 04:64dc ????
    db   $02                                           ;; 04:64e0 ?
    dw   data_04_69a1, data_04_7138                    ;; 04:64e1 ????
    db   $02                                           ;; 04:64e5 ?
    dw   data_04_69a1, data_04_716a                    ;; 04:64e6 ????
    db   $02                                           ;; 04:64ea ?
    dw   data_04_69a1, data_04_7138                    ;; 04:64eb ????
    db   $02                                           ;; 04:64ef ?
    dw   data_04_69a1, data_04_7151                    ;; 04:64f0 ????
    db   $02                                           ;; 04:64f4 ?
    dw   data_04_6a64, data_04_7138                    ;; 04:64f5 ????
    db   $02                                           ;; 04:64f9 ?
    dw   data_04_6a64, data_04_7151                    ;; 04:64fa ????
    db   $02                                           ;; 04:64fe ?
    dw   data_04_6a64, data_04_7138                    ;; 04:64ff ????
    db   $02                                           ;; 04:6503 ?
    dw   data_04_6a64, data_04_7151                    ;; 04:6504 ????
    db   $02                                           ;; 04:6508 ?
    dw   data_04_6a67, data_04_7138                    ;; 04:6509 ????
    db   $02                                           ;; 04:650d ?
    dw   data_04_6a67, data_04_716a                    ;; 04:650e ????
    db   $02                                           ;; 04:6512 ?
    dw   data_04_6a67, data_04_7138                    ;; 04:6513 ????
    db   $02                                           ;; 04:6517 ?
    dw   data_04_6a67, data_04_7151                    ;; 04:6518 ????
    db   $02                                           ;; 04:651c ?
    dw   data_04_6a64, data_04_7138                    ;; 04:651d ????
    db   $02                                           ;; 04:6521 ?
    dw   data_04_6a64, data_04_7151                    ;; 04:6522 ????
    db   $02                                           ;; 04:6526 ?
    dw   data_04_6a67, data_04_7138                    ;; 04:6527 ????
    db   $02                                           ;; 04:652b ?
    dw   data_04_6a67, data_04_7151                    ;; 04:652c ????
    db   $02                                           ;; 04:6530 ?
    dw   data_04_6a64, data_04_7138                    ;; 04:6531 ????
    db   $02                                           ;; 04:6535 ?
    dw   data_04_6a64, data_04_716a                    ;; 04:6536 ????
    db   $02                                           ;; 04:653a ?
    dw   data_04_6a64, data_04_7138                    ;; 04:653b ????
    db   $02                                           ;; 04:653f ?
    dw   data_04_6a64, data_04_7151                    ;; 04:6540 ????
    db   $02                                           ;; 04:6544 ?
    dw   data_04_6a67, data_04_7138                    ;; 04:6545 ????
    db   $02                                           ;; 04:6549 ?
    dw   data_04_6a67, data_04_7151                    ;; 04:654a ????
    db   $02                                           ;; 04:654e ?
    dw   data_04_6a67, data_04_7138                    ;; 04:654f ????
    db   $02                                           ;; 04:6553 ?
    dw   data_04_6a67, data_04_7151                    ;; 04:6554 ????
    db   $02                                           ;; 04:6558 ?
    dw   data_04_6923, data_04_70ed                    ;; 04:6559 ????
    db   $02                                           ;; 04:655d ?
    dw   data_04_6923, data_04_711f                    ;; 04:655e ????
    db   $02                                           ;; 04:6562 ?
    dw   data_04_6923, data_04_70ed                    ;; 04:6563 ????
    db   $02                                           ;; 04:6567 ?
    dw   data_04_6923, data_04_7106                    ;; 04:6568 ????
    db   $02                                           ;; 04:656c ?
    dw   data_04_6a61, data_04_70ed                    ;; 04:656d ????
    db   $02                                           ;; 04:6571 ?
    dw   data_04_6a61, data_04_7106                    ;; 04:6572 ????
    db   $02                                           ;; 04:6576 ?
    dw   data_04_6a61, data_04_70ed                    ;; 04:6577 ????
    db   $02                                           ;; 04:657b ?
    dw   data_04_6a61, data_04_7106                    ;; 04:657c ????
    db   $02                                           ;; 04:6580 ?
    dw   data_04_6a58, data_04_70ed                    ;; 04:6581 ????
    db   $02                                           ;; 04:6585 ?
    dw   data_04_6a58, data_04_7106                    ;; 04:6586 ????
    db   $02                                           ;; 04:658a ?
    dw   data_04_6a58, data_04_70ed                    ;; 04:658b ????
    db   $02                                           ;; 04:658f ?
    dw   data_04_6a58, data_04_711f                    ;; 04:6590 ????
    db   $02                                           ;; 04:6594 ?
    dw   data_04_6a58, data_04_70ed                    ;; 04:6595 ????
    db   $02                                           ;; 04:6599 ?
    dw   data_04_6a58, data_04_7106                    ;; 04:659a ????
    db   $ff                                           ;; 04:659e ?

data_04_659f:
    db   $02                                           ;; 04:659f ?
    dw   data_04_6a5b, data_04_7138                    ;; 04:65a0 ????
    db   $02                                           ;; 04:65a4 ?
    dw   data_04_6a5b, data_04_7151                    ;; 04:65a5 ????
    db   $02                                           ;; 04:65a9 ?
    dw   data_04_6a5b, data_04_7138                    ;; 04:65aa ????
    db   $02                                           ;; 04:65ae ?
    dw   data_04_6a5b, data_04_716a                    ;; 04:65af ????
    db   $02                                           ;; 04:65b3 ?
    dw   data_04_6a5b, data_04_7138                    ;; 04:65b4 ????
    db   $02                                           ;; 04:65b8 ?
    dw   data_04_6a5b, data_04_7151                    ;; 04:65b9 ????
    db   $02                                           ;; 04:65bd ?
    dw   data_04_6a64, data_04_7138                    ;; 04:65be ????
    db   $02                                           ;; 04:65c2 ?
    dw   data_04_6a64, data_04_7151                    ;; 04:65c3 ????
    db   $02                                           ;; 04:65c7 ?
    dw   data_04_6a64, data_04_7138                    ;; 04:65c8 ????
    db   $02                                           ;; 04:65cc ?
    dw   data_04_6a64, data_04_7151                    ;; 04:65cd ????
    db   $02                                           ;; 04:65d1 ?
    dw   data_04_6920, data_04_70ed                    ;; 04:65d2 ????
    db   $02                                           ;; 04:65d6 ?
    dw   data_04_6920, data_04_711f                    ;; 04:65d7 ????
    db   $02                                           ;; 04:65db ?
    dw   data_04_6920, data_04_70ed                    ;; 04:65dc ????
    db   $02                                           ;; 04:65e0 ?
    dw   data_04_6920, data_04_7106                    ;; 04:65e1 ????
    db   $02                                           ;; 04:65e5 ?
    dw   data_04_6a5e, data_04_70ed                    ;; 04:65e6 ????
    db   $02                                           ;; 04:65ea ?
    dw   data_04_6a5e, data_04_7106                    ;; 04:65eb ????
    db   $02                                           ;; 04:65ef ?
    dw   data_04_6a5e, data_04_70ed                    ;; 04:65f0 ????
    db   $02                                           ;; 04:65f4 ?
    dw   data_04_6a5e, data_04_7106                    ;; 04:65f5 ????
    db   $02                                           ;; 04:65f9 ?
    dw   data_04_6a61, data_04_70ed                    ;; 04:65fa ????
    db   $02                                           ;; 04:65fe ?
    dw   data_04_6a61, data_04_7106                    ;; 04:65ff ????
    db   $02                                           ;; 04:6603 ?
    dw   data_04_6a61, data_04_70ed                    ;; 04:6604 ????
    db   $02                                           ;; 04:6608 ?
    dw   data_04_6a61, data_04_711f                    ;; 04:6609 ????
    db   $02                                           ;; 04:660d ?
    dw   data_04_6a5e, data_04_70ed                    ;; 04:660e ????
    db   $02                                           ;; 04:6612 ?
    dw   data_04_6a5e, data_04_7106                    ;; 04:6613 ????
    db   $02                                           ;; 04:6617 ?
    dw   data_04_6a61, data_04_70ed                    ;; 04:6618 ????
    db   $02                                           ;; 04:661c ?
    dw   data_04_6a61, data_04_7106                    ;; 04:661d ????
    db   $02                                           ;; 04:6621 ?
    dw   data_04_6a5e, data_04_70ed                    ;; 04:6622 ????
    db   $02                                           ;; 04:6626 ?
    dw   data_04_6a5e, data_04_711f                    ;; 04:6627 ????
    db   $02                                           ;; 04:662b ?
    dw   data_04_6a5e, data_04_70ed                    ;; 04:662c ????
    db   $02                                           ;; 04:6630 ?
    dw   data_04_6a5e, data_04_7106                    ;; 04:6631 ????
    db   $02                                           ;; 04:6635 ?
    dw   data_04_6a61, data_04_70ed                    ;; 04:6636 ????
    db   $02                                           ;; 04:663a ?
    dw   data_04_6a61, data_04_7106                    ;; 04:663b ????
    db   $02                                           ;; 04:663f ?
    dw   data_04_6a61, data_04_70ed                    ;; 04:6640 ????
    db   $02                                           ;; 04:6644 ?
    dw   data_04_6a61, data_04_7106                    ;; 04:6645 ????
    db   $02                                           ;; 04:6649 ?
    dw   data_04_69a4, data_04_7138                    ;; 04:664a ????
    db   $02                                           ;; 04:664e ?
    dw   data_04_69a4, data_04_7151                    ;; 04:664f ????
    db   $02                                           ;; 04:6653 ?
    dw   data_04_69a4, data_04_7138                    ;; 04:6654 ????
    db   $02                                           ;; 04:6658 ?
    dw   data_04_69a4, data_04_716a                    ;; 04:6659 ????
    db   $02                                           ;; 04:665d ?
    dw   data_04_6a67, data_04_7138                    ;; 04:665e ????
    db   $02                                           ;; 04:6662 ?
    dw   data_04_6a67, data_04_7151                    ;; 04:6663 ????
    db   $02                                           ;; 04:6667 ?
    dw   data_04_6a67, data_04_7138                    ;; 04:6668 ????
    db   $02                                           ;; 04:666c ?
    dw   data_04_6a67, data_04_7151                    ;; 04:666d ????
    db   $02                                           ;; 04:6671 ?
    dw   data_04_6a5b, data_04_7138                    ;; 04:6672 ????
    db   $02                                           ;; 04:6676 ?
    dw   data_04_6a5b, data_04_7151                    ;; 04:6677 ????
    db   $02                                           ;; 04:667b ?
    dw   data_04_6a5b, data_04_7138                    ;; 04:667c ????
    db   $02                                           ;; 04:6680 ?
    dw   data_04_6a5b, data_04_716a                    ;; 04:6681 ????
    db   $02                                           ;; 04:6685 ?
    dw   data_04_6a5b, data_04_7138                    ;; 04:6686 ????
    db   $02                                           ;; 04:668a ?
    dw   data_04_6a5b, data_04_7151                    ;; 04:668b ????
    db   $ff                                           ;; 04:668f ?

data_04_6690:
    db   $01                                           ;; 04:6690 ?
    dw   data_04_6a70, data_04_71f5                    ;; 04:6691 ????
    db   $01                                           ;; 04:6695 ?
    dw   data_04_6a73, data_04_71cf                    ;; 04:6696 ????
    db   $01                                           ;; 04:669a ?
    dw   data_04_6a76, data_04_71cf                    ;; 04:669b ????
    db   $01                                           ;; 04:669f ?
    dw   data_04_6a79, data_04_71cf                    ;; 04:66a0 ????
    db   $01                                           ;; 04:66a4 ?
    dw   data_04_6a7c, data_04_71f5                    ;; 04:66a5 ????
    db   $01                                           ;; 04:66a9 ?
    dw   data_04_6a7f, data_04_7183                    ;; 04:66aa ????
    db   $01                                           ;; 04:66ae ?
    dw   data_04_6a82, data_04_7196                    ;; 04:66af ????
    db   $01                                           ;; 04:66b3 ?
    dw   data_04_6a85, data_04_7183                    ;; 04:66b4 ????
    db   $01                                           ;; 04:66b8 ?
    dw   data_04_6a88, data_04_7196                    ;; 04:66b9 ????
    db   $02                                           ;; 04:66bd ?
    dw   data_04_6a8b, data_04_7183                    ;; 04:66be ????
    db   $01                                           ;; 04:66c2 ?
    dw   data_04_6a88, data_04_7196                    ;; 04:66c3 ????
    db   $01                                           ;; 04:66c7 ?
    dw   data_04_6a85, data_04_7183                    ;; 04:66c8 ????
    db   $01                                           ;; 04:66cc ?
    dw   data_04_6a82, data_04_7196                    ;; 04:66cd ????
    db   $01                                           ;; 04:66d1 ?
    dw   data_04_6a7f, data_04_7183                    ;; 04:66d2 ????
    db   $01                                           ;; 04:66d6 ?
    dw   data_04_6a8e, data_04_7196                    ;; 04:66d7 ????
    db   $01                                           ;; 04:66db ?
    dw   data_04_6a91, data_04_7183                    ;; 04:66dc ????
    db   $01                                           ;; 04:66e0 ?
    dw   data_04_6a94, data_04_7196                    ;; 04:66e1 ????
    db   $01                                           ;; 04:66e5 ?
    dw   data_04_6a97, data_04_7183                    ;; 04:66e6 ????
    db   $01                                           ;; 04:66ea ?
    dw   data_04_6a9a, data_04_7196                    ;; 04:66eb ????
    db   $ff                                           ;; 04:66ef ?

data_04_66f0:
    db   $01                                           ;; 04:66f0 ?
    dw   data_04_6a9d, data_04_7208                    ;; 04:66f1 ????
    db   $01                                           ;; 04:66f5 ?
    dw   data_04_6aa0, data_04_71e2                    ;; 04:66f6 ????
    db   $01                                           ;; 04:66fa ?
    dw   data_04_6aa3, data_04_71e2                    ;; 04:66fb ????
    db   $01                                           ;; 04:66ff ?
    dw   data_04_6aa6, data_04_71e2                    ;; 04:6700 ????
    db   $01                                           ;; 04:6704 ?
    dw   data_04_6aa9, data_04_7208                    ;; 04:6705 ????
    db   $ff                                           ;; 04:6709 ?

data_04_670a:
    db   $01                                           ;; 04:670a ?
    dw   data_04_6aac, data_04_71a9                    ;; 04:670b ????
    db   $01                                           ;; 04:670f ?
    dw   data_04_6aaf, data_04_71bc                    ;; 04:6710 ????
    db   $01                                           ;; 04:6714 ?
    dw   data_04_6ab2, data_04_71a9                    ;; 04:6715 ????
    db   $01                                           ;; 04:6719 ?
    dw   data_04_6ab5, data_04_71bc                    ;; 04:671a ????
    db   $02                                           ;; 04:671e ?
    dw   data_04_6ab8, data_04_71a9                    ;; 04:671f ????
    db   $01                                           ;; 04:6723 ?
    dw   data_04_6ab5, data_04_71bc                    ;; 04:6724 ????
    db   $01                                           ;; 04:6728 ?
    dw   data_04_6ab2, data_04_71a9                    ;; 04:6729 ????
    db   $01                                           ;; 04:672d ?
    dw   data_04_6aaf, data_04_71bc                    ;; 04:672e ????
    db   $01                                           ;; 04:6732 ?
    dw   data_04_6aac, data_04_71a9                    ;; 04:6733 ????
    db   $ff                                           ;; 04:6737 ?

data_04_6738:
    db   $01                                           ;; 04:6738 ?
    dw   data_04_6abb, data_04_71bc                    ;; 04:6739 ????
    db   $01                                           ;; 04:673d ?
    dw   data_04_6abe, data_04_71a9                    ;; 04:673e ????
    db   $01                                           ;; 04:6742 ?
    dw   data_04_6ac1, data_04_71bc                    ;; 04:6743 ????
    db   $01                                           ;; 04:6747 ?
    dw   data_04_6ac4, data_04_71a9                    ;; 04:6748 ????
    db   $01                                           ;; 04:674c ?
    dw   data_04_6ac7, data_04_71bc                    ;; 04:674d ????
    db   $ff                                           ;; 04:6751 ?

data_04_6752:
    db   $02                                           ;; 04:6752 ?
    dw   lich_new, data_04_7387                        ;; 04:6753 ????
    db   $03                                           ;; 04:6757 ?
    dw   data_04_6902, data_04_721b                    ;; 04:6758 ????
    db   $02                                           ;; 04:675c ?
    dw   data_04_691d, data_04_7253                    ;; 04:675d ????
    db   $01                                           ;; 04:6761 ?
    dw   data_04_691d, data_04_728b                    ;; 04:6762 ????
    db   $01                                           ;; 04:6766 ?
    dw   data_04_691d, data_04_72a7                    ;; 04:6767 ????
    db   $01                                           ;; 04:676b ?
    dw   data_04_691d, data_04_72c3                    ;; 04:676c ????
    db   $ff                                           ;; 04:6770 ?

data_04_6771:
    db   $01                                           ;; 04:6771 ?
    dw   data_04_699e, data_04_72df                    ;; 04:6772 ????
    db   $01                                           ;; 04:6776 ?
    dw   data_04_699e, data_04_72fb                    ;; 04:6777 ????
    db   $ff                                           ;; 04:677b ?

data_04_677c:
    db   $01                                           ;; 04:677c ?
    dw   data_04_699e, data_04_72df                    ;; 04:677d ????
    db   $03                                           ;; 04:6781 ?
    dw   data_04_699e, data_04_72fb                    ;; 04:6782 ????
    db   $01                                           ;; 04:6786 ?
    dw   data_04_699e, data_04_72df                    ;; 04:6787 ????
    db   $01                                           ;; 04:678b ?
    dw   data_04_691d, data_04_72c3                    ;; 04:678c ????
    db   $ff                                           ;; 04:6790 ?

data_04_6791:
    db   $01                                           ;; 04:6791 ?
    dw   data_04_699e, data_04_72df                    ;; 04:6792 ????
    db   $01                                           ;; 04:6796 ?
    dw   data_04_691d, data_04_72c3                    ;; 04:6797 ????
    db   $ff                                           ;; 04:679b ?

data_04_679c:
    db   $01                                           ;; 04:679c ?
    dw   data_04_699e, data_04_72df                    ;; 04:679d ????
    db   $03                                           ;; 04:67a1 ?
    dw   data_04_691d, data_04_72c3                    ;; 04:67a2 ????
    db   $01                                           ;; 04:67a6 ?
    dw   data_04_699e, data_04_72df                    ;; 04:67a7 ????
    db   $01                                           ;; 04:67ab ?
    dw   data_04_699e, data_04_72fb                    ;; 04:67ac ????
    db   $ff                                           ;; 04:67b0 ?

data_04_67b1:
    db   $01                                           ;; 04:67b1 ?
    dw   data_04_691d, data_04_7317                    ;; 04:67b2 ????
    db   $04                                           ;; 04:67b6 ?
    dw   data_04_691d, data_04_7333                    ;; 04:67b7 ????
    db   $01                                           ;; 04:67bb ?
    dw   data_04_691d, data_04_7317                    ;; 04:67bc ????
    db   $01                                           ;; 04:67c0 ?
    dw   data_04_691d, data_04_72c3                    ;; 04:67c1 ????
    db   $ff                                           ;; 04:67c5 ?

data_04_67c6:
    db   $01                                           ;; 04:67c6 ?
    dw   data_04_699e, data_04_734f                    ;; 04:67c7 ????
    db   $04                                           ;; 04:67cb ?
    dw   data_04_699e, data_04_736b                    ;; 04:67cc ????
    db   $01                                           ;; 04:67d0 ?
    dw   data_04_699e, data_04_734f                    ;; 04:67d1 ????
    db   $01                                           ;; 04:67d5 ?
    dw   data_04_699e, data_04_72fb                    ;; 04:67d6 ????
    db   $ff                                           ;; 04:67da ?

data_04_67db:
    db   $01                                           ;; 04:67db ?
    dw   data_04_6aca, data_04_74d9                    ;; 04:67dc ????
    db   $01                                           ;; 04:67e0 ?
    dw   data_04_6acd, data_04_74d9                    ;; 04:67e1 ????
    db   $01                                           ;; 04:67e5 ?
    dw   data_04_6ad0, data_04_74d9                    ;; 04:67e6 ????
    db   $01                                           ;; 04:67ea ?
    dw   data_04_6ad3, data_04_74d9                    ;; 04:67eb ????
    db   $01                                           ;; 04:67ef ?
    dw   data_04_6ad6, data_04_74d9                    ;; 04:67f0 ????
    db   $01                                           ;; 04:67f4 ?
    dw   data_04_6ad9, data_04_74d9                    ;; 04:67f5 ????
    db   $01                                           ;; 04:67f9 ?
    dw   data_04_6adc, data_04_74d9                    ;; 04:67fa ????
    db   $01                                           ;; 04:67fe ?
    dw   data_04_6adf, data_04_74d9                    ;; 04:67ff ????
    db   $01                                           ;; 04:6803 ?
    dw   data_04_6ae2, data_04_74d9                    ;; 04:6804 ????
    db   $02                                           ;; 04:6808 ?
    dw   data_04_6ae5, data_04_74d9                    ;; 04:6809 ????
    db   $01                                           ;; 04:680d ?
    dw   data_04_6ae8, data_04_74d9                    ;; 04:680e ????
    db   $01                                           ;; 04:6812 ?
    dw   data_04_6aeb, data_04_74d9                    ;; 04:6813 ????
    db   $01                                           ;; 04:6817 ?
    dw   data_04_6aee, data_04_74d9                    ;; 04:6818 ????
    db   $01                                           ;; 04:681c ?
    dw   data_04_6af1, data_04_74d9                    ;; 04:681d ????
    db   $01                                           ;; 04:6821 ?
    dw   data_04_6af4, data_04_74d9                    ;; 04:6822 ????
    db   $01                                           ;; 04:6826 ?
    dw   data_04_6af7, data_04_74d9                    ;; 04:6827 ????
    db   $01                                           ;; 04:682b ?
    dw   data_04_6afa, data_04_74d9                    ;; 04:682c ????
    db   $01                                           ;; 04:6830 ?
    dw   data_04_6afd, data_04_74d9                    ;; 04:6831 ????
    db   $01                                           ;; 04:6835 ?
    dw   data_04_6b00, data_04_74d9                    ;; 04:6836 ????
    db   $ff                                           ;; 04:683a ?

data_04_683b:
    db   $01                                           ;; 04:683b ?
    dw   data_04_6b03, data_04_74d9                    ;; 04:683c ????
    db   $01                                           ;; 04:6840 ?
    dw   data_04_6b06, data_04_74d9                    ;; 04:6841 ????
    db   $01                                           ;; 04:6845 ?
    dw   data_04_6b09, data_04_74d9                    ;; 04:6846 ????
    db   $01                                           ;; 04:684a ?
    dw   data_04_6b0c, data_04_74d9                    ;; 04:684b ????
    db   $01                                           ;; 04:684f ?
    dw   data_04_6b0f, data_04_74d9                    ;; 04:6850 ????
    db   $ff                                           ;; 04:6854 ?

data_04_6855:
    db   $02                                           ;; 04:6855 ?
    dw   data_04_6b03, data_04_73a3                    ;; 04:6856 ????
    db   $02                                           ;; 04:685a ?
    dw   data_04_6b06, data_04_73c2                    ;; 04:685b ????
    db   $02                                           ;; 04:685f ?
    dw   data_04_6b09, data_04_73e1                    ;; 04:6860 ????
    db   $02                                           ;; 04:6864 ?
    dw   data_04_6b0c, data_04_7400                    ;; 04:6865 ????
    db   $02                                           ;; 04:6869 ?
    dw   data_04_6b0f, data_04_741f                    ;; 04:686a ????
    db   $02                                           ;; 04:686e ?
    dw   data_04_6b03, data_04_743e                    ;; 04:686f ????
    db   $02                                           ;; 04:6873 ?
    dw   data_04_6b06, data_04_745d                    ;; 04:6874 ????
    db   $02                                           ;; 04:6878 ?
    dw   data_04_6b09, data_04_747c                    ;; 04:6879 ????
    db   $02                                           ;; 04:687d ?
    dw   data_04_6b0c, data_04_749b                    ;; 04:687e ????
    db   $02                                           ;; 04:6882 ?
    dw   data_04_6b0f, data_04_74ba                    ;; 04:6883 ????
    db   $ff                                           ;; 04:6887 ?

data_04_6888:
    db   $01                                           ;; 04:6888 ?
    dw   data_04_6b12, data_04_74d9                    ;; 04:6889 ????
    db   $01                                           ;; 04:688d ?
    dw   data_04_6b15, data_04_74d9                    ;; 04:688e ????
    db   $01                                           ;; 04:6892 ?
    dw   data_04_6b18, data_04_74d9                    ;; 04:6893 ????
    db   $01                                           ;; 04:6897 ?
    dw   data_04_6b1b, data_04_74d9                    ;; 04:6898 ????
    db   $02                                           ;; 04:689c ?
    dw   data_04_6b1e, data_04_74d9                    ;; 04:689d ????
    db   $01                                           ;; 04:68a1 ?
    dw   data_04_6b21, data_04_74d9                    ;; 04:68a2 ????
    db   $01                                           ;; 04:68a6 ?
    dw   data_04_6b24, data_04_74d9                    ;; 04:68a7 ????
    db   $01                                           ;; 04:68ab ?
    dw   data_04_6b27, data_04_74d9                    ;; 04:68ac ????
    db   $01                                           ;; 04:68b0 ?
    dw   data_04_6b2a, data_04_74d9                    ;; 04:68b1 ????
    db   $ff                                           ;; 04:68b5 ?

data_04_68b6:
    db   $01                                           ;; 04:68b6 ?
    dw   data_04_6b2d, data_04_74d9                    ;; 04:68b7 ????
    db   $01                                           ;; 04:68bb ?
    dw   data_04_6b30, data_04_74d9                    ;; 04:68bc ????
    db   $01                                           ;; 04:68c0 ?
    dw   data_04_6b33, data_04_74d9                    ;; 04:68c1 ????
    db   $01                                           ;; 04:68c5 ?
    dw   data_04_6b36, data_04_74d9                    ;; 04:68c6 ????
    db   $01                                           ;; 04:68ca ?
    dw   data_04_6b39, data_04_74d9                    ;; 04:68cb ????
    db   $ff                                           ;; 04:68cf ?

data_04_68d0:
    db   $0a                                           ;; 04:68d0 ?
    dw   data_04_691d, data_04_7601                    ;; 04:68d1 ????
    db   $01                                           ;; 04:68d5 ?
    dw   data_04_691d, data_04_75eb                    ;; 04:68d6 ????
    db   $01                                           ;; 04:68da ?
    dw   data_04_691d, data_04_75d5                    ;; 04:68db ????
    db   $01                                           ;; 04:68df ?
    dw   data_04_691d, data_04_75bf                    ;; 04:68e0 ????
    db   $01                                           ;; 04:68e4 ?
    dw   data_04_691d, data_04_75a9                    ;; 04:68e5 ????
    db   $01                                           ;; 04:68e9 ?
    dw   data_04_691d, data_04_7593                    ;; 04:68ea ????
    db   $01                                           ;; 04:68ee ?
    dw   data_04_691d, data_04_7617                    ;; 04:68ef ????
    db   $24                                           ;; 04:68f3 ?
    dw   data_04_691d, data_04_7593                    ;; 04:68f4 ????
    db   $ff                                           ;; 04:68f8 ?

data_04_68f9:
    db   $20                                           ;; 04:68f9 ?
    dw   data_04_691d, data_04_7593                    ;; 04:68fa ????
    db   $ff, $0c, $00, $ff                            ;; 04:68fe ????

data_04_6902:
    db   $06, $00, $ff                                 ;; 04:6902 ???

data_04_6905:
    db   $06, $02, $ff                                 ;; 04:6905 ???

data_04_6908:
    db   $06, $6e, $ff                                 ;; 04:6908 ???

data_04_690b:
    db   $06, $62, $ff                                 ;; 04:690b ???

data_04_690e:
    db   $06, $ae, $ff                                 ;; 04:690e ???

data_04_6911:
    db   $06, $a2, $ff                                 ;; 04:6911 ???

data_04_6914:
    db   $07, $00, $ff                                 ;; 04:6914 ...

data_04_6917:
    db   $06, $00, $ff                                 ;; 04:6917 ...

data_04_691a:
    db   $07, $00, $ff                                 ;; 04:691a ???

data_04_691d:
    db   $00, $00, $ff                                 ;; 04:691d ???

data_04_6920:
    db   $00, $02, $ff                                 ;; 04:6920 ???

data_04_6923:
    db   $00, $0e, $ff                                 ;; 04:6923 ???

data_04_6926:
    db   $00, $40, $ff                                 ;; 04:6926 ???

data_04_6929:
    db   $02, $40, $ff                                 ;; 04:6929 ???

data_04_692c:
    db   $00, $c0, $ff                                 ;; 04:692c ???

data_04_692f:
    db   $02, $c0, $ff                                 ;; 04:692f ???

data_04_6932:
    db   $00, $03, $ff                                 ;; 04:6932 ???

data_04_6935:
    db   $00, $13, $ff                                 ;; 04:6935 ???

data_04_6938:
    db   $02, $12, $ff                                 ;; 04:6938 ???

data_04_693b:
    db   $02, $22, $ff                                 ;; 04:693b ???

data_04_693e:
    db   $00, $22, $ff                                 ;; 04:693e ???

data_04_6941:
    db   $02, $21, $ff                                 ;; 04:6941 ???

data_04_6944:
    db   $02, $31, $ff                                 ;; 04:6944 ???

data_04_6947:
    db   $00, $30, $ff                                 ;; 04:6947 ???

data_04_694a:
    db   $00, $d0, $ff                                 ;; 04:694a ???

data_04_694d:
    db   $00, $df, $ff                                 ;; 04:694d ???

data_04_6950:
    db   $02, $ef, $ff                                 ;; 04:6950 ???

data_04_6953:
    db   $02, $ee, $ff                                 ;; 04:6953 ???

data_04_6956:
    db   $00, $ee, $ff                                 ;; 04:6956 ???

data_04_6959:
    db   $02, $fe, $ff                                 ;; 04:6959 ???

data_04_695c:
    db   $02, $fd, $ff                                 ;; 04:695c ???

data_04_695f:
    db   $00, $0d, $ff                                 ;; 04:695f ???

data_04_6962:
    db   $00, $1d, $ff                                 ;; 04:6962 ???

data_04_6965:
    db   $02, $1e, $ff                                 ;; 04:6965 ???

data_04_6968:
    db   $02, $2e, $ff                                 ;; 04:6968 ???

data_04_696b:
    db   $00, $2e, $ff                                 ;; 04:696b ???

data_04_696e:
    db   $02, $2f, $ff                                 ;; 04:696e ???

data_04_6971:
    db   $02, $3f, $ff                                 ;; 04:6971 ???

data_04_6974:
    db   $00, $d1, $ff                                 ;; 04:6974 ???

data_04_6977:
    db   $02, $e1, $ff                                 ;; 04:6977 ???

data_04_697a:
    db   $02, $e2, $ff                                 ;; 04:697a ???

data_04_697d:
    db   $00, $e2, $ff                                 ;; 04:697d ???

data_04_6980:
    db   $02, $f2, $ff                                 ;; 04:6980 ???

data_04_6983:
    db   $02, $f3, $ff                                 ;; 04:6983 ???

data_04_6986:
    db   $00, $f3, $ff                                 ;; 04:6986 ???

data_04_6989:
    db   $02, $d1, $ff                                 ;; 04:6989 ???

data_04_698c:
    db   $00, $3f, $ff                                 ;; 04:698c ???

data_04_698f:
    db   $02, $1d, $ff                                 ;; 04:698f ???

data_04_6992:
    db   $00, $fd, $ff                                 ;; 04:6992 ???

data_04_6995:
    db   $02, $df, $ff                                 ;; 04:6995 ???

data_04_6998:
    db   $00, $31, $ff                                 ;; 04:6998 ???

data_04_699b:
    db   $02, $13, $ff                                 ;; 04:699b ???

data_04_699e:
    db   $02, $00, $ff                                 ;; 04:699e ???

data_04_69a1:
    db   $02, $02, $ff                                 ;; 04:69a1 ???

data_04_69a4:
    db   $02, $0e, $ff                                 ;; 04:69a4 ???

data_04_69a7:
    db   $07, $33, $ff                                 ;; 04:69a7 ...

data_04_69aa:
    db   $06, $47, $ff                                 ;; 04:69aa ...

data_04_69ad:
    db   $07, $67, $ff                                 ;; 04:69ad ...

data_04_69b0:
    db   $06, $75, $ff                                 ;; 04:69b0 ...

data_04_69b3:
    db   $07, $70, $ff                                 ;; 04:69b3 ...

data_04_69b6:
    db   $06, $7b, $ff                                 ;; 04:69b6 ...

data_04_69b9:
    db   $07, $68, $ff                                 ;; 04:69b9 ...

data_04_69bc:
    db   $06, $48, $ff                                 ;; 04:69bc ...

data_04_69bf:
    db   $07, $3d, $ff                                 ;; 04:69bf ...

data_04_69c2:
    db   $06, $d3, $ff                                 ;; 04:69c2 ...

data_04_69c5:
    db   $07, $c7, $ff                                 ;; 04:69c5 ...

data_04_69c8:
    db   $06, $a7, $ff                                 ;; 04:69c8 ...

data_04_69cb:
    db   $07, $95, $ff                                 ;; 04:69cb ...

data_04_69ce:
    db   $06, $90, $ff                                 ;; 04:69ce ...

data_04_69d1:
    db   $07, $9b, $ff                                 ;; 04:69d1 ...

data_04_69d4:
    db   $06, $a9, $ff                                 ;; 04:69d4 ...

data_04_69d7:
    db   $07, $c9, $ff                                 ;; 04:69d7 ...

data_04_69da:
    db   $06, $dd, $ff                                 ;; 04:69da ...

data_04_69dd:
    db   $0a, $07, $ff                                 ;; 04:69dd ...

data_04_69e0:
    db   $0a, $09, $ff                                 ;; 04:69e0 ???

data_04_69e3:
    db   $0a, $47, $ff                                 ;; 04:69e3 ???

data_04_69e6:
    db   $0a, $c7, $ff                                 ;; 04:69e6 ???

data_04_69e9:
    db   $00, $70, $ff                                 ;; 04:69e9 ???

data_04_69ec:
    db   $00, $40, $ff                                 ;; 04:69ec ???

data_04_69ef:
    db   $00, $30, $ff                                 ;; 04:69ef ???

data_04_69f2:
    db   $00, $20, $ff                                 ;; 04:69f2 ???

data_04_69f5:
    db   $00, $80, $ff                                 ;; 04:69f5 ???

data_04_69f8:
    db   $07, $6e, $ff                                 ;; 04:69f8 ???

data_04_69fb:
    db   $07, $62, $ff                                 ;; 04:69fb ???

data_04_69fe:
    db   $07, $ae, $ff                                 ;; 04:69fe ???

data_04_6a01:
    db   $07, $a2, $ff                                 ;; 04:6a01 ???

data_04_6a04:
    db   $00, $a4, $ff                                 ;; 04:6a04 ???

data_04_6a07:
    db   $02, $a4, $ff                                 ;; 04:6a07 ???

data_04_6a0a:
    db   $00, $64, $ff                                 ;; 04:6a0a ???

data_04_6a0d:
    db   $02, $64, $ff                                 ;; 04:6a0d ???

data_04_6a10:
    db   $00, $ac, $ff                                 ;; 04:6a10 ???

data_04_6a13:
    db   $02, $ac, $ff                                 ;; 04:6a13 ???

data_04_6a16:
    db   $00, $6c, $ff                                 ;; 04:6a16 ???

data_04_6a19:
    db   $02, $6c, $ff                                 ;; 04:6a19 ???

data_04_6a1c:
    db   $16, $c4, $ff, $19, $c4, $ff                  ;; 04:6a1c ??????

data_04_6a22:
    db   $16, $c2, $ff                                 ;; 04:6a22 ???

data_04_6a25:
    db   $1b, $c2, $ff                                 ;; 04:6a25 ???

data_04_6a28:
    db   $16, $c0, $ff                                 ;; 04:6a28 ???

data_04_6a2b:
    db   $1b, $c0, $ff                                 ;; 04:6a2b ???

data_04_6a2e:
    db   $16, $0e, $ff                                 ;; 04:6a2e ???

data_04_6a31:
    db   $1b, $0e, $ff                                 ;; 04:6a31 ???

data_04_6a34:
    db   $16, $00, $ff                                 ;; 04:6a34 ???

data_04_6a37:
    db   $1b, $00, $ff                                 ;; 04:6a37 ???

data_04_6a3a:
    db   $02, $44, $ff                                 ;; 04:6a3a ???

lich_new:
    db   $18, $00, $ff

data_04_6a40:
    db   $02, $42, $ff                                 ;; 04:6a40 ???

data_04_6a43:
    db   $04, $42, $ff                                 ;; 04:6a43 ???

data_04_6a46:
    db   $02, $40, $ff                                 ;; 04:6a46 ???

data_04_6a49:
    db   $04, $40, $ff                                 ;; 04:6a49 ???

data_04_6a4c:
    db   $02, $0e, $ff                                 ;; 04:6a4c ???

data_04_6a4f:
    db   $04, $0e, $ff                                 ;; 04:6a4f ???

data_04_6a52:
    db   $02, $00, $ff                                 ;; 04:6a52 ???

data_04_6a55:
    db   $04, $00, $ff                                 ;; 04:6a55 ???

data_04_6a58:
    db   $00, $20, $ff                                 ;; 04:6a58 ???

data_04_6a5b:
    db   $02, $e0, $ff                                 ;; 04:6a5b ???

data_04_6a5e:
    db   $00, $22, $ff                                 ;; 04:6a5e ???

data_04_6a61:
    db   $00, $2e, $ff                                 ;; 04:6a61 ???

data_04_6a64:
    db   $02, $e2, $ff                                 ;; 04:6a64 ???

data_04_6a67:
    db   $02, $ee, $ff                                 ;; 04:6a67 ???

data_04_6a6a:
    db   $00, $90, $ff                                 ;; 04:6a6a ???

data_04_6a6d:
    db   $00, $70, $ff                                 ;; 04:6a6d ???

data_04_6a70:
    db   $0b, $19, $ff                                 ;; 04:6a70 ???

data_04_6a73:
    db   $0b, $49, $ff                                 ;; 04:6a73 ???

data_04_6a76:
    db   $0b, $5b, $ff                                 ;; 04:6a76 ???

data_04_6a79:
    db   $0b, $7c, $ff                                 ;; 04:6a79 ???

data_04_6a7c:
    db   $0b, $7f, $ff                                 ;; 04:6a7c ???

data_04_6a7f:
    db   $03, $71, $ff                                 ;; 04:6a7f ???

data_04_6a82:
    db   $03, $74, $ff                                 ;; 04:6a82 ???

data_04_6a85:
    db   $03, $55, $ff                                 ;; 04:6a85 ???

data_04_6a88:
    db   $03, $47, $ff                                 ;; 04:6a88 ???

data_04_6a8b:
    db   $03, $17, $ff                                 ;; 04:6a8b ???

data_04_6a8e:
    db   $03, $7f, $ff                                 ;; 04:6a8e ???

data_04_6a91:
    db   $03, $7c, $ff                                 ;; 04:6a91 ???

data_04_6a94:
    db   $03, $5b, $ff                                 ;; 04:6a94 ???

data_04_6a97:
    db   $03, $49, $ff                                 ;; 04:6a97 ???

data_04_6a9a:
    db   $03, $19, $ff                                 ;; 04:6a9a ???

data_04_6a9d:
    db   $19, $f9, $ff                                 ;; 04:6a9d ???

data_04_6aa0:
    db   $19, $c9, $ff                                 ;; 04:6aa0 ???

data_04_6aa3:
    db   $19, $bb, $ff                                 ;; 04:6aa3 ???

data_04_6aa6:
    db   $19, $9c, $ff                                 ;; 04:6aa6 ???

data_04_6aa9:
    db   $19, $9f, $ff                                 ;; 04:6aa9 ???

data_04_6aac:
    db   $0b, $91, $ff                                 ;; 04:6aac ???

data_04_6aaf:
    db   $0b, $94, $ff                                 ;; 04:6aaf ???

data_04_6ab2:
    db   $0b, $b5, $ff                                 ;; 04:6ab2 ???

data_04_6ab5:
    db   $0b, $c7, $ff                                 ;; 04:6ab5 ???

data_04_6ab8:
    db   $0b, $f7, $ff                                 ;; 04:6ab8 ???

data_04_6abb:
    db   $0b, $9f, $ff                                 ;; 04:6abb ???

data_04_6abe:
    db   $0b, $9c, $ff                                 ;; 04:6abe ???

data_04_6ac1:
    db   $0b, $bb, $ff                                 ;; 04:6ac1 ???

data_04_6ac4:
    db   $0b, $c9, $ff                                 ;; 04:6ac4 ???

data_04_6ac7:
    db   $0b, $f9, $ff                                 ;; 04:6ac7 ???

data_04_6aca:
    db   $c3, $19, $ff                                 ;; 04:6aca ???

data_04_6acd:
    db   $c3, $49, $ff                                 ;; 04:6acd ???

data_04_6ad0:
    db   $c4, $5b, $ff                                 ;; 04:6ad0 ???

data_04_6ad3:
    db   $c4, $7c, $ff                                 ;; 04:6ad3 ???

data_04_6ad6:
    db   $c5, $7f, $ff                                 ;; 04:6ad6 ???

data_04_6ad9:
    db   $c5, $71, $ff                                 ;; 04:6ad9 ???

data_04_6adc:
    db   $c5, $74, $ff                                 ;; 04:6adc ???

data_04_6adf:
    db   $c5, $55, $ff                                 ;; 04:6adf ???

data_04_6ae2:
    db   $c5, $47, $ff                                 ;; 04:6ae2 ???

data_04_6ae5:
    db   $c0, $17, $ff                                 ;; 04:6ae5 ???

data_04_6ae8:
    db   $c0, $47, $ff                                 ;; 04:6ae8 ???

data_04_6aeb:
    db   $c0, $55, $ff                                 ;; 04:6aeb ???

data_04_6aee:
    db   $c0, $74, $ff                                 ;; 04:6aee ???

data_04_6af1:
    db   $c0, $71, $ff                                 ;; 04:6af1 ???

data_04_6af4:
    db   $c0, $7f, $ff                                 ;; 04:6af4 ???

data_04_6af7:
    db   $c4, $7c, $ff                                 ;; 04:6af7 ???

data_04_6afa:
    db   $c4, $5b, $ff                                 ;; 04:6afa ???

data_04_6afd:
    db   $c3, $49, $ff                                 ;; 04:6afd ???

data_04_6b00:
    db   $c3, $19, $ff                                 ;; 04:6b00 ???

data_04_6b03:
    db   $c3, $f9, $ff                                 ;; 04:6b03 ???

data_04_6b06:
    db   $c1, $c9, $ff                                 ;; 04:6b06 ???

data_04_6b09:
    db   $c1, $bb, $ff                                 ;; 04:6b09 ???

data_04_6b0c:
    db   $c1, $9c, $ff                                 ;; 04:6b0c ???

data_04_6b0f:
    db   $c2, $9f, $ff                                 ;; 04:6b0f ???

data_04_6b12:
    db   $c2, $91, $ff                                 ;; 04:6b12 ???

data_04_6b15:
    db   $c2, $94, $ff                                 ;; 04:6b15 ???

data_04_6b18:
    db   $c2, $b5, $ff                                 ;; 04:6b18 ???

data_04_6b1b:
    db   $c2, $c7, $ff                                 ;; 04:6b1b ???

data_04_6b1e:
    db   $c0, $f7, $ff                                 ;; 04:6b1e ???

data_04_6b21:
    db   $c0, $c7, $ff                                 ;; 04:6b21 ???

data_04_6b24:
    db   $c2, $b5, $ff                                 ;; 04:6b24 ???

data_04_6b27:
    db   $c2, $94, $ff                                 ;; 04:6b27 ???

data_04_6b2a:
    db   $c2, $91, $ff                                 ;; 04:6b2a ???

data_04_6b2d:
    db   $c2, $9f, $ff                                 ;; 04:6b2d ???

data_04_6b30:
    db   $c1, $9c, $ff                                 ;; 04:6b30 ???

data_04_6b33:
    db   $c1, $bb, $ff                                 ;; 04:6b33 ???

data_04_6b36:
    db   $c1, $c9, $ff                                 ;; 04:6b36 ???

data_04_6b39:
    db   $c3, $f9, $ff                                 ;; 04:6b39 ???

data_04_6b3c:
    db   $0c, $00, $ff                                 ;; 04:6b3c ...

data_04_6b3f:
    db   $0d, $00, $ff                                 ;; 04:6b3f ...

data_04_6b42:
    db   $01, $00, $f0, $02, $f0, $00, $00, $f0        ;; 04:6b42 ????????
    db   $f0, $06, $00, $00, $01, $00, $f0, $02        ;; 04:6b4a ????????
    db   $f0, $00, $00, $f0, $f0, $ff                  ;; 04:6b52 ??????

data_04_6b58:
    db   $05, $00, $f0, $03, $f0, $00, $04, $f0        ;; 04:6b58 ????????
    db   $f0, $0b, $10, $00, $08, $10, $f0, $0a        ;; 04:6b60 ????????
    db   $e0, $00, $09, $e0, $f0, $ff                  ;; 04:6b68 ??????

data_04_6b6e:
    db   $01, $00, $f0, $03, $f0, $00, $04, $f0        ;; 04:6b6e ????????
    db   $f0, $06, $00, $00, $01, $00, $f0, $0a        ;; 04:6b76 ????????
    db   $e0, $00, $09, $e0, $f0, $ff                  ;; 04:6b7e ??????

data_04_6b84:
    db   $05, $00, $f0, $02, $f0, $00, $00, $f0        ;; 04:6b84 ????????
    db   $f0, $0b, $10, $00, $08, $10, $f0, $02        ;; 04:6b8c ????????
    db   $f0, $00, $00, $f0, $f0, $ff                  ;; 04:6b94 ??????

data_04_6b9a:
    db   $05, $00, $f0, $03, $f0, $00, $04, $f0        ;; 04:6b9a ????????
    db   $f0, $0b, $10, $00, $48, $10, $f0, $0a        ;; 04:6ba2 ????????
    db   $e0, $00, $49, $e0, $f0, $ff                  ;; 04:6baa ??????

data_04_6bb0:
    db   $01, $00, $f0, $03, $f0, $00, $04, $f0        ;; 04:6bb0 ????????
    db   $f0, $06, $00, $00, $01, $00, $f0, $0a        ;; 04:6bb8 ????????
    db   $e0, $00, $49, $e0, $f0, $ff                  ;; 04:6bc0 ??????

data_04_6bc6:
    db   $05, $00, $f0, $02, $f0, $00, $00, $f0        ;; 04:6bc6 ????????
    db   $f0, $0b, $10, $00, $48, $10, $f0, $02        ;; 04:6bce ????????
    db   $f0, $00, $00, $f0, $f0, $ff                  ;; 04:6bd6 ??????

data_04_6bdc:
    db   $01, $d0, $f0, $02, $e0, $e0, $03, $f0        ;; 04:6bdc ????????
    db   $e0, $04, $e0, $f0, $06, $f0, $f0, $08        ;; 04:6be4 ????????
    db   $f0, $00, $ff                                 ;; 04:6bec ???

data_04_6bef:
    db   $01, $e0, $e0, $02, $d0, $00, $03, $f0        ;; 04:6bef ????????
    db   $e0, $0a, $f0, $f0, $05, $e0, $00, $08        ;; 04:6bf7 ????????
    db   $f0, $00, $ff                                 ;; 04:6bff ???

data_04_6c02:
    db   $01, $d0, $00, $02, $d0, $f0, $04, $e0        ;; 04:6c02 ????????
    db   $f0, $0b, $f0, $f0, $05, $e0, $00, $08        ;; 04:6c0a ????????
    db   $f0, $00, $ff                                 ;; 04:6c12 ???

data_04_6c15:
    db   $01, $d0, $f0, $02, $e0, $e0, $03, $f0        ;; 04:6c15 ????????
    db   $e0, $04, $e0, $f0, $07, $f0, $f0, $08        ;; 04:6c1d ????????
    db   $f0, $00, $ff                                 ;; 04:6c25 ???

data_04_6c28:
    db   $41, $e0, $e0, $02, $d0, $00, $03, $f0        ;; 04:6c28 ????????
    db   $e0, $0a, $f0, $f0, $05, $e0, $00, $09        ;; 04:6c30 ????????
    db   $f0, $00, $ff                                 ;; 04:6c38 ???

data_04_6c3b:
    db   $01, $d0, $00, $02, $d0, $f0, $04, $e0        ;; 04:6c3b ????????
    db   $f0, $0b, $f0, $f0, $05, $e0, $00, $08        ;; 04:6c43 ????????
    db   $f0, $00, $ff                                 ;; 04:6c4b ???

data_04_6c4e:
    db   $12, $f0, $f0, $13, $00, $f0, $01, $f0        ;; 04:6c4e ????????
    db   $00, $ff                                      ;; 04:6c56 ??

data_04_6c58:
    db   $06, $f0, $f0, $10, $00, $f0, $11, $f0        ;; 04:6c58 ????????
    db   $00, $ff                                      ;; 04:6c60 ??

data_04_6c62:
    db   $0f, $f0, $f0, $0a, $00, $f0, $01, $f0        ;; 04:6c62 ????????
    db   $00, $ff                                      ;; 04:6c6a ??

data_04_6c6c:
    db   $49, $f0, $f0, $04, $00, $f0, $01, $f0        ;; 04:6c6c ????????
    db   $00, $ff                                      ;; 04:6c74 ??

data_04_6c76:
    db   $0e, $f0, $f0, $03, $00, $f0, $01, $f0        ;; 04:6c76 ????????
    db   $00, $ff                                      ;; 04:6c7e ??

data_04_6c80:
    db   $05, $f0, $f0, $48, $00, $f0, $01, $f0        ;; 04:6c80 ????????
    db   $00, $ff                                      ;; 04:6c88 ??

data_04_6c8a:
    db   $47, $f0, $f0, $4b, $00, $f0, $01, $f0        ;; 04:6c8a ????????
    db   $00, $ff                                      ;; 04:6c92 ??

data_04_6c94:
    db   $03, $f0, $f0, $04, $00, $f0, $01, $f0        ;; 04:6c94 ????????
    db   $00, $4e, $f8, $d0, $4e, $f8, $20, $0f        ;; 04:6c9c ????????
    db   $20, $f8, $0f, $d0, $f8, $ff                  ;; 04:6ca4 ??????

data_04_6caa:
    db   $03, $f0, $f0, $04, $00, $f0, $01, $f0        ;; 04:6caa ????????
    db   $00, $0e, $f8, $d0, $0e, $f8, $20, $4f        ;; 04:6cb2 ????????
    db   $20, $f8, $4f, $d0, $f8, $ff, $03, $f0        ;; 04:6cba ????????
    db   $f0, $04, $00, $f0, $01, $f0, $00, $0e        ;; 04:6cc2 ????????
    db   $f8, $d0, $0e, $f8, $20, $0f, $20, $f8        ;; 04:6cca ????????
    db   $0f, $d0, $f8, $ff                            ;; 04:6cd2 ????

data_04_6cd6:
    db   $03, $f0, $f0, $04, $00, $f0, $01, $f0        ;; 04:6cd6 ????????
    db   $00, $0f, $ec, $d2, $0f, $04, $1e, $0e        ;; 04:6cde ????????
    db   $1e, $ec, $0e, $d2, $04, $ff                  ;; 04:6ce6 ??????

data_04_6cec:
    db   $03, $f0, $f0, $04, $00, $f0, $01, $f0        ;; 04:6cec ????????
    db   $00, $0e, $e1, $d7, $0e, $0f, $19, $0f        ;; 04:6cf4 ????????
    db   $19, $e1, $0f, $d7, $0f, $ff                  ;; 04:6cfc ??????

data_04_6d02:
    db   $05, $f0, $f0, $08, $00, $f0, $11, $f0        ;; 04:6d02 ????????
    db   $00, $0f, $d7, $df, $0f, $19, $11, $0e        ;; 04:6d0a ????????
    db   $11, $d7, $0e, $df, $19, $ff                  ;; 04:6d12 ??????

data_04_6d18:
    db   $05, $f0, $f0, $08, $00, $f0, $11, $f0        ;; 04:6d18 ????????
    db   $00, $0e, $cf, $e8, $0e, $21, $08, $0f        ;; 04:6d20 ????????
    db   $08, $cf, $0f, $e8, $21, $ff                  ;; 04:6d28 ??????

data_04_6d2e:
    db   $05, $f0, $f0, $08, $00, $f0, $11, $f0        ;; 04:6d2e ????????
    db   $00, $0f, $ca, $f4, $0f, $26, $fc, $0e        ;; 04:6d36 ????????
    db   $fc, $ca, $0e, $f4, $26, $ff                  ;; 04:6d3e ??????

data_04_6d44:
    db   $85, $f0, $f0, $08, $00, $f0, $11, $f0        ;; 04:6d44 ????????
    db   $00, $11, $f0, $00, $11, $f0, $00, $11        ;; 04:6d4c ????????
    db   $f0, $00, $11, $f0, $00, $ff                  ;; 04:6d54 ??????

data_04_6d5a:
    db   $05, $f0, $f0, $0c, $f8, $f1, $11, $f0        ;; 04:6d5a ????????
    db   $00, $0d, $e8, $f1, $0c, $f5, $12, $0d        ;; 04:6d62 ????????
    db   $ef, $f1, $0c, $ee, $09, $ff                  ;; 04:6d6a ??????

data_04_6d70:
    db   $0d, $f6, $ee, $08, $00, $f0, $0c, $ff        ;; 04:6d70 ????????
    db   $04, $0d, $f9, $e5, $0c, $11, $15, $0d        ;; 04:6d78 ????????
    db   $12, $f0, $0c, $e0, $09, $ff                  ;; 04:6d80 ??????

data_04_6d86:
    db   $05, $f0, $f0, $0d, $03, $f0, $0d, $f0        ;; 04:6d86 ????????
    db   $00, $0d, $e0, $ef, $0c, $f3, $0e, $0d        ;; 04:6d8e ????????
    db   $e0, $f3, $0c, $f4, $11, $ff                  ;; 04:6d96 ??????

data_04_6d9c:
    db   $00, $f0, $f0, $02, $00, $f0, $01, $f0        ;; 04:6d9c ........
    db   $00, $01, $f0, $00, $01, $f0, $00, $ff        ;; 04:6da4 .......?

data_04_6dac:
    db   $04, $f0, $f0, $05, $00, $f0, $03, $f0        ;; 04:6dac ........
    db   $00, $03, $f0, $00, $03, $f0, $00, $ff        ;; 04:6db4 .......?

data_04_6dbc:
    db   $08, $f0, $f0, $0b, $00, $f0, $09, $f0        ;; 04:6dbc ........
    db   $00, $09, $f0, $00, $09, $f0, $00, $ff        ;; 04:6dc4 .......?

data_04_6dcc:
    db   $00, $e0, $f0, $01, $f0, $f0, $08, $00        ;; 04:6dcc ????????
    db   $f0, $05, $10, $f0, $03, $e0, $00, $02        ;; 04:6dd4 ????????
    db   $f0, $00, $0f, $10, $00, $13, $f0, $10        ;; 04:6ddc ????????
    db   $0b, $00, $10, $0b, $00, $10, $ff             ;; 04:6de4 ???????

data_04_6deb:
    db   $00, $e0, $f0, $01, $f0, $f0, $08, $00        ;; 04:6deb ????????
    db   $f0, $05, $10, $f0, $43, $e0, $00, $02        ;; 04:6df3 ????????
    db   $f0, $00, $4f, $10, $00, $53, $f0, $10        ;; 04:6dfb ????????
    db   $4b, $00, $10, $0b, $00, $10, $ff             ;; 04:6e03 ???????

data_04_6e0a:
    db   $00, $e0, $f0, $01, $f0, $f0, $08, $00        ;; 04:6e0a ????????
    db   $f0, $05, $10, $f0, $0e, $e0, $00, $09        ;; 04:6e12 ????????
    db   $f0, $00, $10, $10, $00, $13, $f0, $10        ;; 04:6e1a ????????
    db   $11, $00, $10, $12, $00, $20, $ff             ;; 04:6e22 ???????

data_04_6e29:
    db   $80, $e0, $f0, $01, $f0, $f0, $08, $00        ;; 04:6e29 ????????
    db   $f0, $05, $10, $f0, $03, $e0, $00, $02        ;; 04:6e31 ????????
    db   $f0, $00, $0f, $10, $00, $13, $f0, $10        ;; 04:6e39 ????????
    db   $0b, $00, $10, $0b, $00, $10, $ff             ;; 04:6e41 ???????

data_04_6e48:
    db   $00, $e0, $f0, $0c, $f2, $f1, $08, $00        ;; 04:6e48 ????????
    db   $f0, $0d, $09, $f3, $03, $e0, $00, $0c        ;; 04:6e50 ????????
    db   $f0, $00, $0c, $13, $f8, $13, $f0, $10        ;; 04:6e58 ????????
    db   $0c, $15, $12, $0b, $00, $10, $ff             ;; 04:6e60 ???????

data_04_6e67:
    db   $0d, $e4, $f2, $01, $f0, $f0, $0d, $fd        ;; 04:6e67 ????????
    db   $f2, $0c, $13, $f1, $03, $e0, $00, $02        ;; 04:6e6f ????????
    db   $f0, $00, $0c, $08, $03, $13, $f0, $10        ;; 04:6e77 ????????
    db   $0d, $02, $0d, $0c, $03, $10, $ff             ;; 04:6e7f ???????

data_04_6e86:
    db   $00, $e0, $f0, $0d, $f2, $f0, $08, $00        ;; 04:6e86 ????????
    db   $f0, $05, $10, $f0, $0d, $e0, $00, $0d        ;; 04:6e8e ????????
    db   $08, $06, $0f, $10, $00, $0c, $f1, $10        ;; 04:6e96 ????????
    db   $0b, $00, $10, $0c, $04, $0f, $ff             ;; 04:6e9e ???????

data_04_6ea5:
    db   $06, $10, $f0, $09, $10, $00, $05, $00        ;; 04:6ea5 ????????
    db   $10, $08, $10, $10, $0e, $30, $f0, $0f        ;; 04:6ead ????????
    db   $20, $f0, $ff                                 ;; 04:6eb5 ???

data_04_6eb8:
    db   $06, $10, $f0, $09, $10, $00, $01, $00        ;; 04:6eb8 ????????
    db   $10, $04, $10, $10, $0e, $20, $f0, $0e        ;; 04:6ec0 ????????
    db   $20, $f0, $ff                                 ;; 04:6ec8 ???

data_04_6ecb:
    db   $02, $10, $f0, $03, $10, $00, $05, $00        ;; 04:6ecb ????????
    db   $10, $08, $10, $10, $0d, $00, $f0, $0d        ;; 04:6ed3 ????????
    db   $00, $f0, $ff                                 ;; 04:6edb ???

data_04_6ede:
    db   $02, $10, $f0, $03, $10, $00, $01, $00        ;; 04:6ede ????????
    db   $10, $04, $10, $10, $0d, $f0, $f0, $0f        ;; 04:6ee6 ????????
    db   $00, $f0, $ff                                 ;; 04:6eee ???

data_04_6ef1:
    db   $0b, $10, $00, $0a, $00, $10, $0c, $10        ;; 04:6ef1 ????????
    db   $10, $0d, $f0, $0c, $0d, $f0, $0c, $0d        ;; 04:6ef9 ????????
    db   $f0, $0c, $ff                                 ;; 04:6f01 ???

data_04_6f04:
    db   $0b, $10, $00, $0a, $00, $10, $0c, $10        ;; 04:6f04 ????????
    db   $10, $0d, $e0, $0c, $0f, $f0, $0c, $0f        ;; 04:6f0c ????????
    db   $f0, $0c, $ff                                 ;; 04:6f14 ???

data_04_6f17:
    db   $01, $e0, $f0, $0f, $f0, $f0, $05, $00        ;; 04:6f17 ????????
    db   $f0, $08, $10, $f0, $04, $f0, $00, $ff        ;; 04:6f1f ????????

data_04_6f27:
    db   $09, $f0, $f0, $0e, $00, $f0, $0b, $e0        ;; 04:6f27 ????????
    db   $00, $0a, $f0, $00, $03, $10, $00, $ff        ;; 04:6f2f ????????

data_04_6f37:
    db   $09, $f0, $f0, $0e, $00, $f0, $4b, $e0        ;; 04:6f37 ????????
    db   $00, $0a, $f0, $00, $43, $10, $00, $ff        ;; 04:6f3f ????????

data_04_6f47:
    db   $81, $e0, $f0, $0f, $f0, $f0, $05, $00        ;; 04:6f47 ????????
    db   $f0, $08, $10, $f0, $04, $f0, $00, $ff        ;; 04:6f4f ????????

data_04_6f57:
    db   $01, $e0, $f0, $0c, $ee, $f3, $05, $00        ;; 04:6f57 ????????
    db   $f0, $08, $10, $f0, $0d, $f2, $04, $ff        ;; 04:6f5f ????????

data_04_6f67:
    db   $0c, $e3, $ef, $0d, $f0, $f0, $05, $00        ;; 04:6f67 ????????
    db   $f0, $0d, $10, $f0, $04, $f4, $fc, $ff        ;; 04:6f6f ????????

data_04_6f77:
    db   $01, $e0, $f0, $0d, $f0, $f0, $0c, $fc        ;; 04:6f77 ????????
    db   $f2, $0d, $11, $f4, $04, $f0, $00, $ff        ;; 04:6f7f ????????

data_04_6f87:
    db   $08, $f0, $00, $06, $10, $00, $0e, $f0        ;; 04:6f87 ????????
    db   $10, $01, $00, $10, $07, $10, $10, $03        ;; 04:6f8f ????????
    db   $f0, $20, $04, $00, $20, $15, $10, $20        ;; 04:6f97 ????????
    db   $ff                                           ;; 04:6f9f ?

data_04_6fa0:
    db   $05, $f0, $00, $0f, $10, $00, $09, $f0        ;; 04:6fa0 ????????
    db   $10, $02, $00, $10, $10, $10, $10, $14        ;; 04:6fa8 ????????
    db   $f0, $20, $0b, $00, $20, $0a, $10, $20        ;; 04:6fb0 ????????
    db   $ff                                           ;; 04:6fb8 ?

data_04_6fb9:
    db   $05, $f0, $00, $0f, $10, $00, $09, $f0        ;; 04:6fb9 ????????
    db   $10, $01, $00, $10, $10, $10, $10, $03        ;; 04:6fc1 ????????
    db   $f0, $20, $04, $00, $20, $15, $10, $20        ;; 04:6fc9 ????????
    db   $ff                                           ;; 04:6fd1 ?

data_04_6fd2:
    db   $08, $f0, $00, $06, $10, $00, $0e, $f0        ;; 04:6fd2 ????????
    db   $10, $02, $00, $10, $07, $10, $10, $14        ;; 04:6fda ????????
    db   $f0, $20, $0b, $00, $20, $0a, $10, $20        ;; 04:6fe2 ????????
    db   $ff                                           ;; 04:6fea ?

data_04_6feb:
    db   $05, $f0, $00, $0f, $10, $00, $09, $f0        ;; 04:6feb ????????
    db   $10, $01, $00, $10, $10, $10, $10, $11        ;; 04:6ff3 ????????
    db   $e0, $20, $12, $f0, $20, $13, $00, $20        ;; 04:6ffb ????????
    db   $ff                                           ;; 04:7003 ?

data_04_7004:
    db   $45, $f0, $00, $0f, $10, $00, $49, $f0        ;; 04:7004 ????????
    db   $10, $01, $00, $10, $10, $10, $10, $03        ;; 04:700c ????????
    db   $f0, $20, $04, $00, $20, $15, $10, $20        ;; 04:7014 ????????
    db   $ff                                           ;; 04:701c ?

data_04_701d:
    db   $03, $f0, $f0, $05, $00, $f0, $16, $10        ;; 04:701d ????????
    db   $f0, $01, $e0, $00, $04, $f0, $00, $17        ;; 04:7025 ????????
    db   $10, $00, $ff                                 ;; 04:702d ???

data_04_7030:
    db   $18, $f0, $f0, $0b, $00, $f0, $09, $10        ;; 04:7030 ????????
    db   $f0, $19, $f0, $00, $0a, $10, $00, $08        ;; 04:7038 ????????
    db   $20, $00, $ff                                 ;; 04:7040 ???

data_04_7043:
    db   $0e, $f8, $f0, $10, $08, $f0, $0f, $f8        ;; 04:7043 ????????
    db   $00, $11, $08, $00, $11, $08, $00, $11        ;; 04:704b ????????
    db   $08, $00, $ff                                 ;; 04:7053 ???

data_04_7056:
    db   $14, $f8, $f0, $12, $08, $f0, $15, $f8        ;; 04:7056 ????????
    db   $00, $13, $08, $00, $13, $08, $00, $13        ;; 04:705e ????????
    db   $08, $00, $ff                                 ;; 04:7066 ???

data_04_7069:
    db   $03, $f0, $f0, $06, $00, $f0, $08, $10        ;; 04:7069 ????????
    db   $f0, $05, $f0, $00, $09, $10, $00, $07        ;; 04:7071 ????????
    db   $00, $10, $0a, $10, $10, $ff                  ;; 04:7079 ??????

data_04_707f:
    db   $18, $f0, $f0, $15, $00, $f0, $13, $10        ;; 04:707f ????????
    db   $f0, $19, $f0, $00, $14, $10, $00, $1a        ;; 04:7087 ????????
    db   $f0, $10, $17, $00, $10, $ff                  ;; 04:708f ??????

data_04_7095:
    db   $0b, $f0, $00, $10, $10, $00, $0e, $f0        ;; 04:7095 ????????
    db   $10, $0f, $00, $10, $11, $10, $10, $12        ;; 04:709d ????????
    db   $20, $10, $12, $20, $10, $ff                  ;; 04:70a5 ??????

data_04_70ab:
    db   $1d, $f0, $00, $00, $10, $00, $1f, $e0        ;; 04:70ab ????????
    db   $10, $1e, $f0, $10, $1c, $00, $10, $01        ;; 04:70b3 ????????
    db   $10, $10, $01, $10, $10, $ff                  ;; 04:70bb ??????

data_04_70c1:
    db   $0b, $f0, $00, $10, $10, $00, $4e, $f0        ;; 04:70c1 ????????
    db   $10, $0f, $00, $10, $11, $10, $10, $52        ;; 04:70c9 ????????
    db   $20, $10, $12, $20, $10, $ff                  ;; 04:70d1 ??????

data_04_70d7:
    db   $1b, $f0, $00, $17, $10, $00, $5d, $e0        ;; 04:70d7 ????????
    db   $10, $1c, $f0, $10, $1a, $00, $10, $58        ;; 04:70df ????????
    db   $10, $10, $18, $10, $10, $ff                  ;; 04:70e7 ??????

data_04_70ed:
    db   $01, $f0, $f0, $03, $00, $f0, $04, $10        ;; 04:70ed ????????
    db   $f0, $05, $f0, $00, $06, $10, $00, $07        ;; 04:70f5 ????????
    db   $f0, $10, $08, $00, $10, $09, $10, $10        ;; 04:70fd ????????
    db   $ff                                           ;; 04:7105 ?

data_04_7106:
    db   $01, $f0, $f0, $03, $00, $f0, $04, $10        ;; 04:7106 ????????
    db   $f0, $0a, $f0, $00, $0b, $10, $00, $0c        ;; 04:710e ????????
    db   $f0, $10, $0d, $00, $10, $0e, $10, $10        ;; 04:7116 ????????
    db   $ff                                           ;; 04:711e ?

data_04_711f:
    db   $01, $f0, $f0, $03, $00, $f0, $04, $10        ;; 04:711f ????????
    db   $f0, $0a, $f0, $00, $0b, $10, $00, $0c        ;; 04:7127 ????????
    db   $f0, $10, $0d, $00, $10, $4e, $10, $10        ;; 04:712f ????????
    db   $ff                                           ;; 04:7137 ?

data_04_7138:
    db   $11, $f0, $f0, $10, $00, $f0, $0f, $10        ;; 04:7138 ????????
    db   $f0, $13, $f0, $00, $12, $10, $00, $15        ;; 04:7140 ????????
    db   $00, $10, $14, $10, $10, $16, $f0, $10        ;; 04:7148 ????????
    db   $ff                                           ;; 04:7150 ?

data_04_7151:
    db   $11, $f0, $f0, $10, $00, $f0, $0f, $10        ;; 04:7151 ????????
    db   $f0, $18, $f0, $00, $17, $10, $00, $1a        ;; 04:7159 ????????
    db   $00, $10, $19, $10, $10, $1b, $f0, $10        ;; 04:7161 ????????
    db   $ff                                           ;; 04:7169 ?

data_04_716a:
    db   $11, $f0, $f0, $10, $00, $f0, $0f, $10        ;; 04:716a ????????
    db   $f0, $18, $f0, $00, $17, $10, $00, $1a        ;; 04:7172 ????????
    db   $00, $10, $19, $10, $10, $5b, $f0, $10        ;; 04:717a ????????
    db   $ff                                           ;; 04:7182 ?

data_04_7183:
    db   $00, $f0, $f0, $01, $00, $f0, $02, $f0        ;; 04:7183 ????????
    db   $00, $04, $f0, $10, $05, $00, $10, $05        ;; 04:718b ????????
    db   $00, $10, $ff                                 ;; 04:7193 ???

data_04_7196:
    db   $00, $f0, $f0, $01, $00, $f0, $02, $f0        ;; 04:7196 ????????
    db   $00, $04, $f0, $10, $06, $00, $10, $06        ;; 04:719e ????????
    db   $00, $10, $ff                                 ;; 04:71a6 ???

data_04_71a9:
    db   $11, $f0, $f0, $10, $00, $f0, $12, $f0        ;; 04:71a9 ????????
    db   $00, $14, $f0, $10, $13, $00, $10, $13        ;; 04:71b1 ????????
    db   $00, $10, $ff                                 ;; 04:71b9 ???

data_04_71bc:
    db   $11, $f0, $f0, $10, $00, $f0, $12, $f0        ;; 04:71bc ????????
    db   $00, $15, $f0, $10, $13, $00, $10, $13        ;; 04:71c4 ????????
    db   $00, $10, $ff                                 ;; 04:71cc ???

data_04_71cf:
    db   $07, $f0, $f0, $08, $00, $f0, $09, $10        ;; 04:71cf ????????
    db   $f0, $0a, $f0, $00, $0e, $f0, $10, $0f        ;; 04:71d7 ????????
    db   $00, $10, $ff                                 ;; 04:71df ???

data_04_71e2:
    db   $18, $e0, $f0, $17, $f0, $f0, $16, $00        ;; 04:71e2 ????????
    db   $f0, $1a, $f0, $00, $1c, $f0, $10, $1b        ;; 04:71ea ????????
    db   $00, $10, $ff                                 ;; 04:71f2 ???

data_04_71f5:
    db   $07, $f0, $f0, $08, $00, $f0, $49, $10        ;; 04:71f5 ????????
    db   $f0, $0a, $f0, $00, $0e, $f0, $10, $0f        ;; 04:71fd ????????
    db   $00, $10, $ff                                 ;; 04:7205 ???

data_04_7208:
    db   $58, $e0, $f0, $17, $f0, $f0, $16, $00        ;; 04:7208 ????????
    db   $f0, $1a, $f0, $00, $1c, $f0, $10, $1b        ;; 04:7210 ????????
    db   $00, $10, $ff                                 ;; 04:7218 ???

data_04_721b:
    db   $05, $f0, $00, $05, $f0, $00, $05, $f0        ;; 04:721b ????????
    db   $00, $05, $f0, $00, $05, $f0, $00, $05        ;; 04:7223 ????????
    db   $f0, $00, $05, $f0, $00, $05, $f0, $00        ;; 04:722b ????????
    db   $05, $f0, $00, $ff, $12, $f0, $00, $12        ;; 04:7233 ????????
    db   $f0, $00, $12, $f0, $00, $12, $f0, $00        ;; 04:723b ????????
    db   $12, $f0, $00, $12, $f0, $00, $12, $f0        ;; 04:7243 ????????
    db   $00, $12, $f0, $00, $12, $f0, $00, $ff        ;; 04:724b ????????

data_04_7253:
    db   $01, $f0, $f0, $03, $00, $f0, $04, $f0        ;; 04:7253 ????????
    db   $00, $04, $f0, $00, $04, $f0, $00, $04        ;; 04:725b ????????
    db   $f0, $00, $04, $f0, $00, $04, $f0, $00        ;; 04:7263 ????????
    db   $04, $f0, $00, $ff, $10, $f0, $f0, $0f        ;; 04:726b ????????
    db   $00, $f0, $11, $f0, $00, $11, $f0, $00        ;; 04:7273 ????????
    db   $11, $f0, $00, $11, $f0, $00, $11, $f0        ;; 04:727b ????????
    db   $00, $11, $f0, $00, $11, $f0, $00, $ff        ;; 04:7283 ????????

data_04_728b:
    db   $01, $f0, $f0, $03, $00, $f0, $04, $f0        ;; 04:728b ????????
    db   $00, $07, $e0, $00, $04, $f0, $00, $04        ;; 04:7293 ????????
    db   $f0, $00, $04, $f0, $00, $04, $f0, $00        ;; 04:729b ????????
    db   $04, $f0, $00, $ff                            ;; 04:72a3 ????

data_04_72a7:
    db   $01, $f0, $f0, $03, $00, $f0, $04, $f0        ;; 04:72a7 ????????
    db   $00, $09, $e0, $00, $08, $e0, $f0, $04        ;; 04:72af ????????
    db   $f0, $00, $04, $f0, $00, $04, $f0, $00        ;; 04:72b7 ????????
    db   $04, $f0, $00, $ff                            ;; 04:72bf ????

data_04_72c3:
    db   $01, $f0, $f0, $03, $00, $f0, $04, $f0        ;; 04:72c3 ????????
    db   $00, $15, $e0, $00, $16, $e0, $f0, $08        ;; 04:72cb ????????
    db   $e0, $e0, $07, $10, $00, $04, $f0, $00        ;; 04:72d3 ????????
    db   $04, $f0, $00, $ff                            ;; 04:72db ????

data_04_72df:
    db   $10, $f0, $f0, $0f, $00, $f0, $11, $f0        ;; 04:72df ????????
    db   $00, $09, $e0, $00, $08, $e0, $f0, $15        ;; 04:72e7 ????????
    db   $10, $00, $14, $10, $f0, $11, $f0, $00        ;; 04:72ef ????????
    db   $11, $f0, $00, $ff                            ;; 04:72f7 ????

data_04_72fb:
    db   $10, $f0, $f0, $0f, $00, $f0, $11, $f0        ;; 04:72fb ????????
    db   $00, $07, $e0, $00, $09, $10, $00, $0a        ;; 04:7303 ????????
    db   $10, $f0, $08, $10, $e0, $11, $f0, $00        ;; 04:730b ????????
    db   $11, $f0, $00, $ff                            ;; 04:7313 ????

data_04_7317:
    db   $01, $f0, $f0, $03, $00, $f0, $04, $f0        ;; 04:7317 ????????
    db   $00, $09, $e0, $00, $0a, $e0, $f0, $16        ;; 04:731f ????????
    db   $e0, $e0, $0b, $e0, $d0, $0e, $f0, $d0        ;; 04:7327 ????????
    db   $04, $f0, $00, $ff                            ;; 04:732f ????

data_04_7333:
    db   $01, $f0, $f0, $03, $00, $f0, $04, $f0        ;; 04:7333 ????????
    db   $00, $15, $e0, $00, $16, $e0, $f0, $0a        ;; 04:733b ????????
    db   $e0, $e0, $1d, $e0, $d0, $1c, $f0, $d0        ;; 04:7343 ????????
    db   $0e, $00, $d0, $ff                            ;; 04:734b ????

data_04_734f:
    db   $10, $f0, $f0, $0f, $00, $f0, $11, $f0        ;; 04:734f ????????
    db   $00, $1a, $00, $d0, $19, $10, $d0, $0a        ;; 04:7357 ????????
    db   $10, $e0, $16, $10, $f0, $15, $10, $00        ;; 04:735f ????????
    db   $11, $f0, $00, $ff                            ;; 04:7367 ????

data_04_736b:
    db   $10, $f0, $f0, $0f, $00, $f0, $11, $f0        ;; 04:736b ????????
    db   $00, $1a, $f0, $d0, $17, $00, $d0, $1b        ;; 04:7373 ????????
    db   $10, $d0, $16, $10, $e0, $0a, $10, $f0        ;; 04:737b ????????
    db   $09, $10, $00, $ff                            ;; 04:7383 ????

data_04_7387:
    db   $18, $f0, $f0, $18, $f0, $f0, $18, $f0        ;; 04:7387 ????????
    db   $f0, $18, $f0, $f0, $18, $f0, $f0, $18        ;; 04:738f ????????
    db   $f0, $f0, $18, $f0, $f0, $18, $f0, $f0        ;; 04:7397 ????????
    db   $18, $f0, $f0, $ff                            ;; 04:739f ????

data_04_73a3:
    db   $06, $00, $00, $06, $00, $00, $06, $00        ;; 04:73a3 ????????
    db   $00, $06, $00, $00, $06, $00, $00, $06        ;; 04:73ab ????????
    db   $00, $00, $06, $00, $00, $06, $00, $00        ;; 04:73b3 ????????
    db   $06, $00, $00, $06, $00, $00, $ff             ;; 04:73bb ???????

data_04_73c2:
    db   $c6, $00, $00, $06, $00, $00, $06, $00        ;; 04:73c2 ????????
    db   $00, $06, $00, $00, $06, $00, $00, $06        ;; 04:73ca ????????
    db   $00, $00, $06, $00, $00, $06, $00, $00        ;; 04:73d2 ????????
    db   $06, $00, $00, $06, $00, $00, $ff             ;; 04:73da ???????

data_04_73e1:
    db   $c6, $00, $00, $c6, $00, $00, $06, $00        ;; 04:73e1 ????????
    db   $00, $06, $00, $00, $06, $00, $00, $06        ;; 04:73e9 ????????
    db   $00, $00, $06, $00, $00, $06, $00, $00        ;; 04:73f1 ????????
    db   $06, $00, $00, $06, $00, $00, $ff             ;; 04:73f9 ???????

data_04_7400:
    db   $c6, $00, $00, $c6, $00, $00, $c6, $00        ;; 04:7400 ????????
    db   $00, $06, $00, $00, $06, $00, $00, $06        ;; 04:7408 ????????
    db   $00, $00, $06, $00, $00, $06, $00, $00        ;; 04:7410 ????????
    db   $06, $00, $00, $06, $00, $00, $ff             ;; 04:7418 ???????

data_04_741f:
    db   $c6, $00, $00, $c6, $00, $00, $c6, $00        ;; 04:741f ????????
    db   $00, $c6, $00, $00, $06, $00, $00, $06        ;; 04:7427 ????????
    db   $00, $00, $06, $00, $00, $06, $00, $00        ;; 04:742f ????????
    db   $06, $00, $00, $06, $00, $00, $ff             ;; 04:7437 ???????

data_04_743e:
    db   $c6, $00, $00, $c6, $00, $00, $c6, $00        ;; 04:743e ????????
    db   $00, $c6, $00, $00, $c6, $00, $00, $06        ;; 04:7446 ????????
    db   $00, $00, $06, $00, $00, $06, $00, $00        ;; 04:744e ????????
    db   $06, $00, $00, $06, $00, $00, $ff             ;; 04:7456 ???????

data_04_745d:
    db   $c6, $00, $00, $c6, $00, $00, $c6, $00        ;; 04:745d ????????
    db   $00, $c6, $00, $00, $c6, $00, $00, $c6        ;; 04:7465 ????????
    db   $00, $00, $06, $00, $00, $06, $00, $00        ;; 04:746d ????????
    db   $06, $00, $00, $06, $00, $00, $ff             ;; 04:7475 ???????

data_04_747c:
    db   $c6, $00, $00, $c6, $00, $00, $c6, $00        ;; 04:747c ????????
    db   $00, $c6, $00, $00, $c6, $00, $00, $c6        ;; 04:7484 ????????
    db   $00, $00, $c6, $00, $00, $06, $00, $00        ;; 04:748c ????????
    db   $06, $00, $00, $06, $00, $00, $ff             ;; 04:7494 ???????

data_04_749b:
    db   $c6, $00, $00, $c6, $00, $00, $c6, $00        ;; 04:749b ????????
    db   $00, $c6, $00, $00, $c6, $00, $00, $c6        ;; 04:74a3 ????????
    db   $00, $00, $c6, $00, $00, $c6, $00, $00        ;; 04:74ab ????????
    db   $06, $00, $00, $06, $00, $00, $ff             ;; 04:74b3 ???????

data_04_74ba:
    db   $c6, $00, $00, $c6, $00, $00, $c6, $00        ;; 04:74ba ????????
    db   $00, $c6, $00, $00, $c6, $00, $00, $c6        ;; 04:74c2 ????????
    db   $00, $00, $c6, $00, $00, $c6, $00, $00        ;; 04:74ca ????????
    db   $c6, $00, $00, $06, $00, $00, $ff             ;; 04:74d2 ???????

data_04_74d9:
    db   $c6, $00, $00, $c6, $00, $00, $c6, $00        ;; 04:74d9 ????????
    db   $00, $c6, $00, $00, $c6, $00, $00, $c6        ;; 04:74e1 ????????
    db   $00, $00, $c6, $00, $00, $c6, $00, $00        ;; 04:74e9 ????????
    db   $c6, $00, $00, $c6, $00, $00, $ff             ;; 04:74f1 ???????

data_04_74f8:
    db   $86, $00, $00, $06, $00, $00, $06, $00        ;; 04:74f8 ????????
    db   $00, $06, $00, $00, $06, $00, $00, $06        ;; 04:7500 ????????
    db   $00, $00, $06, $00, $00, $06, $00, $00        ;; 04:7508 ????????
    db   $06, $00, $00, $06, $00, $00, $ff             ;; 04:7510 ???????

data_04_7517:
    db   $06, $00, $00, $06, $00, $00, $06, $00        ;; 04:7517 ????????
    db   $00, $06, $00, $00, $06, $00, $00, $06        ;; 04:751f ????????
    db   $00, $00, $06, $00, $00, $06, $00, $00        ;; 04:7527 ????????
    db   $0d, $00, $00, $0c, $00, $00, $ff             ;; 04:752f ???????

data_04_7536:
    db   $06, $00, $00, $06, $00, $00, $06, $00        ;; 04:7536 ????????
    db   $00, $06, $00, $00, $06, $00, $00, $06        ;; 04:753e ????????
    db   $00, $00, $0c, $00, $00, $0d, $00, $00        ;; 04:7546 ????????
    db   $0c, $00, $00, $0d, $00, $00, $ff             ;; 04:754e ???????

data_04_7555:
    db   $06, $00, $00, $06, $00, $00, $06, $00        ;; 04:7555 ????????
    db   $00, $06, $00, $00, $0d, $00, $00, $0c        ;; 04:755d ????????
    db   $00, $00, $0d, $00, $00, $0c, $00, $00        ;; 04:7565 ????????
    db   $0d, $00, $00, $0c, $00, $00, $ff             ;; 04:756d ???????

data_04_7574:
    db   $0c, $00, $00, $0d, $00, $00, $0c, $00        ;; 04:7574 ????????
    db   $00, $0d, $00, $00, $0c, $00, $00, $0d        ;; 04:757c ????????
    db   $00, $00, $0c, $00, $00, $0d, $00, $00        ;; 04:7584 ????????
    db   $0c, $00, $00, $0d, $00, $00, $ff             ;; 04:758c ???????

data_04_7593:
    db   $01, $f0, $00, $02, $f0, $10, $03, $00        ;; 04:7593 ????????
    db   $10, $04, $f0, $20, $05, $00, $20, $08        ;; 04:759b ????????
    db   $18, $10, $06, $d8, $10, $ff                  ;; 04:75a3 ??????

data_04_75a9:
    db   $01, $f0, $00, $02, $f0, $10, $03, $00        ;; 04:75a9 ????????
    db   $10, $04, $f0, $20, $05, $00, $20, $08        ;; 04:75b1 ????????
    db   $12, $18, $06, $de, $18, $ff                  ;; 04:75b9 ??????

data_04_75bf:
    db   $01, $f0, $00, $02, $f0, $10, $03, $00        ;; 04:75bf ????????
    db   $10, $04, $f0, $20, $05, $00, $20, $09        ;; 04:75c7 ????????
    db   $0d, $20, $07, $e3, $20, $ff                  ;; 04:75cf ??????

data_04_75d5:
    db   $01, $f0, $00, $02, $f0, $10, $03, $00        ;; 04:75d5 ????????
    db   $10, $04, $f0, $20, $05, $00, $20, $09        ;; 04:75dd ????????
    db   $08, $26, $07, $e8, $26, $ff                  ;; 04:75e5 ??????

data_04_75eb:
    db   $01, $f0, $00, $02, $f0, $10, $03, $00        ;; 04:75eb ????????
    db   $10, $04, $f0, $20, $05, $00, $20, $09        ;; 04:75f3 ????????
    db   $05, $2a, $07, $eb, $2a, $ff                  ;; 04:75fb ??????

data_04_7601:
    db   $01, $f0, $00, $02, $f0, $10, $03, $00        ;; 04:7601 ????????
    db   $10, $04, $f0, $20, $05, $00, $20, $09        ;; 04:7609 ????????
    db   $04, $2c, $07, $ec, $2c, $ff                  ;; 04:7611 ??????

data_04_7617:
    db   $01, $f0, $00, $02, $f0, $10, $03, $00        ;; 04:7617 ????????
    db   $10, $04, $f0, $20, $05, $00, $20, $48        ;; 04:761f ????????
    db   $18, $10, $46, $d8, $10, $ff                  ;; 04:7627 ??????

data_04_762d:
    db   $81, $00, $f0, $06, $f0, $00, $00, $f0        ;; 04:762d ????????
    db   $f0, $00, $f0, $f0, $00, $f0, $f0, $00        ;; 04:7635 ????????
    db   $f0, $f0, $00, $f0, $f0, $ff                  ;; 04:763d ??????

data_04_7643:
    db   $01, $00, $f0, $06, $f0, $00, $00, $f0        ;; 04:7643 ????????
    db   $f0, $0c, $ed, $e9, $0d, $08, $0a, $0c        ;; 04:764b ????????
    db   $0a, $f1, $0d, $f0, $08, $ff                  ;; 04:7653 ??????

data_04_7659:
    db   $01, $00, $f0, $06, $f0, $00, $00, $f0        ;; 04:7659 ????????
    db   $f0, $0d, $ef, $ea, $0c, $0d, $10, $0d        ;; 04:7661 ????????
    db   $f2, $f1, $0c, $f3, $0a, $ff                  ;; 04:7669 ??????

data_04_766f:
    db   $01, $00, $f0, $06, $f0, $00, $00, $f0        ;; 04:766f ????????
    db   $f0, $0c, $0c, $e9, $0d, $ec, $0c, $0c        ;; 04:7677 ????????
    db   $11, $04, $0d, $f6, $00, $ff                  ;; 04:767f ??????

; The first frame of the Jackal/Golem death animation.
; There was a chunk missing at the bottom right that was possible to easily restore.
data_04_7685:
    db   $80, $f0, $f0
    db   $02, $00, $f0
    db   $01, $f0, $00
    db   $06, $00, $00
    db   $01, $f0, $00
    db   $ff

data_04_7695:
    db   $00, $f0, $f0, $02, $00, $f0, $01, $f0        ;; 04:7695 ........
    db   $00, $0c, $ed, $e9, $0d, $08, $0a, $ff        ;; 04:769d .......?

data_04_76a5:
    db   $00, $f0, $f0, $02, $00, $f0, $01, $f0        ;; 04:76a5 ........
    db   $00, $0d, $ea, $ef, $0c, $08, $ec, $ff        ;; 04:76ad .......?

data_04_76b5:
    db   $00, $f0, $f0, $02, $00, $f0, $01, $f0        ;; 04:76b5 ........
    db   $00, $0d, $00, $08, $0c, $f8, $e4, $ff        ;; 04:76bd .......?

data_04_76c5:
    db   $00, $f0, $f0, $02, $00, $f0, $01, $f0        ;; 04:76c5 ........
    db   $00, $0c, $e5, $0f, $0d, $07, $0c, $ff        ;; 04:76cd .......?

data_04_76d5:
    db   $81, $d0, $f0, $02, $e0, $e0, $03, $f0        ;; 04:76d5 ????????
    db   $e0, $04, $e0, $f0, $06, $f0, $f0, $08        ;; 04:76dd ????????
    db   $f0, $00, $ff                                 ;; 04:76e5 ???

data_04_76e8:
    db   $01, $d0, $f0, $02, $e0, $e0, $0c, $f3        ;; 04:76e8 ????????
    db   $e2, $04, $e0, $f0, $0d, $f5, $ee, $08        ;; 04:76f0 ????????
    db   $f0, $00, $ff                                 ;; 04:76f8 ???

data_04_76fb:
    db   $01, $d0, $f0, $0c, $ea, $e4, $03, $f0        ;; 04:76fb ????????
    db   $e0, $04, $e0, $f0, $06, $f0, $f0, $0d        ;; 04:7703 ????????
    db   $f5, $f8, $ff                                 ;; 04:770b ???

data_04_770e:
    db   $0d, $e0, $f5, $02, $e0, $e0, $03, $f0        ;; 04:770e ????????
    db   $e0, $0c, $e0, $f0, $0d, $f4, $ee, $08        ;; 04:7716 ????????
    db   $f0, $00, $ff                                 ;; 04:771e ???

data_04_7721:
    db   $01, $d0, $f0, $0c, $f1, $e9, $0d, $f0        ;; 04:7721 ????????
    db   $e1, $04, $e0, $f0, $06, $f0, $f0, $08        ;; 04:7729 ????????
    db   $f0, $00, $ff                                 ;; 04:7731 ???

data_04_7734:
    db   $87, $f0, $f0, $0b, $00, $f0, $01, $f0        ;; 04:7734 ????????
    db   $00, $ff                                      ;; 04:773c ??

data_04_773e:
    db   $07, $f0, $f0, $0c, $03, $f1, $01, $f0        ;; 04:773e ????????
    db   $00, $ff                                      ;; 04:7746 ??

data_04_7748:
    db   $0d, $f2, $ee, $0b, $00, $f0, $01, $f0        ;; 04:7748 ????????
    db   $00, $ff                                      ;; 04:7750 ??

data_04_7752:
    db   $0c, $f0, $f0, $0b, $00, $f0, $0d, $ef        ;; 04:7752 ????????
    db   $04, $ff                                      ;; 04:775a ??

data_04_775c:
    db   $01, $f0, $00, $02, $f0, $10, $03, $00        ;; 04:775c ????????
    db   $10, $04, $f0, $20, $05, $00, $20, $0c        ;; 04:7764 ????????
    db   $10, $18, $0d, $e8, $28, $ff                  ;; 04:776c ??????

data_04_7772:
    db   $01, $f0, $00, $02, $f0, $10, $03, $00        ;; 04:7772 ????????
    db   $10, $04, $f0, $20, $05, $00, $20, $0d        ;; 04:777a ????????
    db   $18, $14, $0c, $e0, $2c, $ff                  ;; 04:7782 ??????

data_04_7788:
    db   $01, $f0, $00, $02, $f0, $10, $03, $00        ;; 04:7788 ????????
    db   $10, $04, $f0, $20, $05, $00, $20, $0c        ;; 04:7790 ????????
    db   $0a, $f4, $0d, $e0, $28, $ff                  ;; 04:7798 ??????

data_04_779e:
    db   $81, $f0, $00, $02, $f0, $10, $03, $00        ;; 04:779e ????????
    db   $10, $04, $f0, $20, $05, $00, $20, $0c        ;; 04:77a6 ????????
    db   $0e, $1c, $0d, $f0, $f8, $ff                  ;; 04:77ae ??????

data_04_77b4:
    db   $83, $f0, $f0, $05, $00, $f0, $16, $10        ;; 04:77b4 ????????
    db   $f0, $01, $e0, $00, $04, $f0, $00, $17        ;; 04:77bc ????????
    db   $10, $00, $ff                                 ;; 04:77c4 ???

data_04_77c7:
    db   $0c, $f2, $ed, $05, $00, $f0, $0d, $15        ;; 04:77c7 ????????
    db   $e8, $01, $e0, $00, $0c, $f0, $f6, $0c        ;; 04:77cf ????????
    db   $13, $02, $ff                                 ;; 04:77d7 ???

data_04_77da:
    db   $03, $f0, $f0, $0c, $05, $f3, $16, $10        ;; 04:77da ????????
    db   $f0, $0d, $e2, $f7, $0c, $f2, $f9, $17        ;; 04:77e2 ????????
    db   $10, $00, $ff                                 ;; 04:77ea ???

data_04_77ed:
    db   $0d, $e1, $f2, $0c, $03, $f1, $16, $10        ;; 04:77ed ????????
    db   $f0, $01, $e0, $00, $0c, $f2, $ff, $0d        ;; 04:77f5 ????????
    db   $10, $00, $ff                                 ;; 04:77fd ???

data_04_7800:
    db   $88, $f0, $00, $06, $10, $00, $0e, $f0        ;; 04:7800 ????????
    db   $10, $01, $00, $10, $07, $10, $10, $03        ;; 04:7808 ????????
    db   $f0, $20, $04, $00, $20, $15, $10, $20        ;; 04:7810 ????????
    db   $ff                                           ;; 04:7818 ?

data_04_7819:
    db   $90, $f0, $f0, $0f, $00, $f0, $11, $f0        ;; 04:7819 ????????
    db   $00, $09, $e0, $00, $08, $e0, $f0, $15        ;; 04:7821 ????????
    db   $10, $00, $14, $10, $f0, $11, $f0, $00        ;; 04:7829 ????????
    db   $11, $f0, $00, $ff                            ;; 04:7831 ????

data_04_7835:
    db   $10, $f0, $f0, $0c, $00, $f0, $11, $f0        ;; 04:7835 ????????
    db   $00, $0d, $e0, $00, $08, $e0, $f0, $0c        ;; 04:783d ????????
    db   $18, $02, $14, $10, $f0, $0d, $e1, $02        ;; 04:7845 ????????
    db   $0c, $f1, $f8, $ff                            ;; 04:784d ????

data_04_7851:
    db   $0c, $f2, $f1, $0d, $00, $f0, $11, $f0        ;; 04:7851 ????????
    db   $00, $09, $e0, $00, $0c, $e5, $ed, $0d        ;; 04:7859 ????????
    db   $12, $05, $14, $10, $f0, $0c, $f0, $06        ;; 04:7861 ????????
    db   $11, $f0, $00, $ff                            ;; 04:7869 ????

data_04_786d:
    db   $10, $f0, $f0, $0c, $fd, $f3, $11, $f0        ;; 04:786d ????????
    db   $00, $0d, $e0, $03, $0c, $e5, $ef, $15        ;; 04:7875 ????????
    db   $10, $00, $0d, $12, $f0, $11, $f0, $00        ;; 04:787d ????????
    db   $11, $f0, $00, $ff                            ;; 04:7885 ????

data_04_7889:
    db   $81, $f0, $f0, $03, $00, $f0, $04, $10        ;; 04:7889 ????????
    db   $f0, $05, $f0, $00, $06, $10, $00, $07        ;; 04:7891 ????????
    db   $f0, $10, $08, $00, $10, $09, $10, $10        ;; 04:7899 ????????
    db   $ff                                           ;; 04:78a1 ?

data_04_78a2:
    db   $0c, $f8, $f8, $0d, $f8, $f8, $0c, $f8        ;; 04:78a2 ........
    db   $f8, $0d, $f8, $f8, $0c, $f8, $f8, $0c        ;; 04:78aa .......?
    db   $f8, $f8, $0d, $f8, $f8, $0c, $f8, $f8        ;; 04:78b2 ????????
    db   $0d, $f8, $f8, $0c, $f8, $f8, $ff             ;; 04:78ba ???????

data_04_78c1:
    db   $0d, $ff, $f4, $0c, $04, $fc, $0d, $f6        ;; 04:78c1 ........
    db   $01, $0c, $ef, $f7, $0d, $f4, $ea, $0d        ;; 04:78c9 .......?
    db   $f4, $ff, $0c, $fc, $04, $0d, $01, $f6        ;; 04:78d1 ????????
    db   $0c, $f7, $ef, $0d, $ea, $f4, $ff             ;; 04:78d9 ???????

data_04_78e0:
    db   $0c, $06, $f0, $0d, $0e, $01, $0c, $f2        ;; 04:78e0 ........
    db   $09, $0d, $e8, $f6, $0c, $f1, $df, $0c        ;; 04:78e8 .......?
    db   $f0, $06, $0d, $01, $0e, $0c, $09, $f2        ;; 04:78f0 ????????
    db   $0d, $f6, $e8, $0c, $df, $f1, $ff             ;; 04:78f8 ???????

data_04_78ff:
    db   $0d, $0a, $ee, $0c, $eb, $04, $0d, $f0        ;; 04:78ff ........
    db   $0f, $0c, $e3, $f6, $0d, $f0, $d7, $0d        ;; 04:7907 .......?
    db   $ee, $0a, $0c, $04, $eb, $0d, $0f, $f0        ;; 04:790f ????????
    db   $0c, $f6, $e3, $0d, $d7, $f0, $ff             ;; 04:7917 ???????

data_04_791e:
    db   $0c, $0b, $ed, $0d, $e9, $05, $0c, $ef        ;; 04:791e ........
    db   $10, $0d, $e2, $f6, $0c, $ef, $d5, $0c        ;; 04:7926 .......?
    db   $ed, $0b, $0d, $05, $e9, $0c, $10, $ef        ;; 04:792e ????????
    db   $0d, $f6, $e2, $0c, $d5, $ef, $ff             ;; 04:7936 ???????

tileorderVampire:
    db   $00, $02, $01, $03, $04, $06, $05, $07        ;; 04:793d ????????
    db   $08, $0a, $09, $0b, $0c, $0e, $0d, $0f        ;; 04:7945 ????????
    db   $10, $12, $11, $13, $14, $16, $15, $17        ;; 04:794d ????????
    db   $ff, $ff                                      ;; 04:7955 ??

tileorderHydraDragonZombie:
    db   $00, $02, $01, $03, $04, $06, $05, $07        ;; 04:7957 ????????
    db   $08, $0a, $09, $0b, $0c, $0e, $0d, $0f        ;; 04:795f ????????
    db   $10, $12, $11, $13, $14, $16, $15, $17        ;; 04:7967 ????????
    db   $18, $19, $2f, $1a, $1b, $1d, $1c, $1e        ;; 04:796f ????????
    db   $1f, $21, $20, $22, $23, $25, $24, $26        ;; 04:7977 ????????
    db   $27, $29, $28, $2a, $2b, $2d, $2c, $2e        ;; 04:797f ????????

tileorderCommon:
    db   $00, $02, $01, $03, $04, $06, $05, $07        ;; 04:7987 ........
    db   $08, $0a, $09, $0b, $0c, $0e, $0d, $0f        ;; 04:798f ........
    db   $10, $12, $11, $13, $14, $16, $15, $17        ;; 04:7997 ........
    db   $18, $1a, $19, $1b, $1c, $1e, $1d, $1f        ;; 04:799f ........
    db   $20, $22, $21, $23, $24, $26, $25, $27        ;; 04:79a7 ????????
    db   $28, $2a, $29, $2b, $2c, $2e, $2d, $2f        ;; 04:79af ????????
    db   $30, $32, $31, $33, $34, $36, $35, $37        ;; 04:79b7 ????????
    db   $38, $3a, $39, $3b, $20, $22, $21, $23        ;; 04:79bf ????????

tileorderIflyteMetalCrab:
    db   $00, $02, $01, $03, $04, $06, $05, $07        ;; 04:79c7 ????????
    db   $08, $0a, $09, $0b, $0c, $0e, $0d, $0f        ;; 04:79cf ????????
    db   $10, $12, $11, $13, $14, $16, $15, $17        ;; 04:79d7 ????????
    db   $18, $1a, $19, $1b, $1d, $1f, $1e, $20        ;; 04:79df ????????
    db   $21, $23, $22, $24, $25, $27, $26, $28        ;; 04:79e7 ????????
    db   $29, $2b, $2a, $2c                            ;; 04:79ef ????

tileorderDavias:
    db   $60, $01, $00, $02, $03, $05, $04, $06        ;; 04:79f3 ????????
    db   $07, $08, $60, $09, $0a, $0c, $0b, $0d        ;; 04:79fb ????????
    db   $60, $0f, $0e, $10, $11, $13, $12, $14        ;; 04:7a03 ????????
    db   $15, $16, $60, $17, $18, $1a, $19, $1b        ;; 04:7a0b ????????

tileorderJulius2:
    db   $00, $02, $01, $03, $04, $06, $05, $07        ;; 04:7a13 ????????
    db   $08, $0a, $09, $0b, $0c, $0e, $0d, $0f        ;; 04:7a1b ????????
    db   $10, $12, $11, $13, $14, $16, $15, $17        ;; 04:7a23 ????????
    db   $18, $1a, $19, $1b, $1c, $6c, $1d, $1e        ;; 04:7a2b ????????
    db   $1f, $21, $20, $22                            ;; 04:7a33 ????

tileorderCyclops:
    db   $00, $02, $01, $03, $04, $53, $05, $06        ;; 04:7a37 ????????
    db   $07, $08, $53, $09, $0a, $0c, $0b, $0d        ;; 04:7a3f ????????
    db   $0e, $10, $0f, $11, $12, $14, $13, $15        ;; 04:7a47 ????????
    db   $16, $53, $17, $18, $19, $1b, $1a, $1c        ;; 04:7a4f ????????
    db   $1d, $1f, $1e, $20, $21, $23, $22, $24        ;; 04:7a57 ????????
    db   $25, $27, $26, $28, $29, $2b, $2a, $2c        ;; 04:7a5f ????????
    db   $2d, $2f, $2e, $30, $31, $33, $32, $34        ;; 04:7a67 ????????
    db   $35, $36                                      ;; 04:7a6f ??

tileorderKary:
    db   $0d, $2a, $0e, $2b, $00, $01, $7f, $02        ;; 04:7a71 ????????
    db   $03, $05, $04, $06, $7f, $7f, $07, $08        ;; 04:7a79 ????????
    db   $09, $0b, $0a, $0c, $0d, $0f, $0e, $10        ;; 04:7a81 ????????
    db   $11, $13, $12, $14, $15, $17, $16, $18        ;; 04:7a89 ????????
    db   $19, $1b, $1a, $1c, $1d, $1f, $1e, $7f        ;; 04:7a91 ????????
    db   $7f, $20, $7f, $21, $22, $24, $23, $25        ;; 04:7a99 ????????
    db   $26, $28, $27, $29                            ;; 04:7aa1 ????

tileorderGaruda:
    db   $00, $02, $01, $03, $04, $06, $05, $07        ;; 04:7aa5 ????????
    db   $08, $0a, $09, $0b, $0c, $0e, $0d, $0f        ;; 04:7aad ????????
    db   $10, $12, $11, $13, $14, $16, $15, $17        ;; 04:7ab5 ????????
    db   $18, $1a, $19, $1b, $1c, $1e, $1d, $1f        ;; 04:7abd ????????
    db   $20, $22, $21, $23, $24, $26, $25, $27        ;; 04:7ac5 ????????
    db   $28, $2a, $29, $2b, $2c, $2e, $2d, $2f        ;; 04:7acd ????????
    db   $30, $31, $37, $32, $33, $35, $34, $37        ;; 04:7ad5 ????????
    db   $36, $37, $37, $37                            ;; 04:7add ????

tileorderDragon:
    db   $00, $06, $01, $07, $02, $08, $03, $09        ;; 04:7ae1 ????????
    db   $04, $0a, $05, $0b, $0c, $12, $0d, $13        ;; 04:7ae9 ????????
    db   $0e, $14, $0f, $15, $10, $16, $11, $17        ;; 04:7af1 ????????
    db   $18, $1e, $19, $1f, $1a, $20, $1b, $21        ;; 04:7af9 ????????
    db   $1c, $22, $1d, $23, $24, $26, $25, $27        ;; 04:7b01 ????????
    db   $28, $2a, $29, $2b, $2c, $32, $2d, $33        ;; 04:7b09 ????????
    db   $2e, $34, $2f, $35, $30, $36, $31, $37        ;; 04:7b11 ????????

tileorderLich:
    db   $00, $04, $01, $05, $02, $06, $03, $07        ;; 04:7b19 ????????
    db   $08, $0c, $09, $0d, $0a, $0e, $0b, $0f        ;; 04:7b21 ????????
    db   $10, $14, $11, $15, $12, $16, $13, $17        ;; 04:7b29 ????????
    db   $18, $1a, $19, $1b, $1c, $22, $1d, $23        ;; 04:7b31 ????????
    db   $1e, $24, $1f, $25, $20, $26, $21, $27        ;; 04:7b39 ????????
    db   $28, $2c, $29, $2d, $2a, $2e, $2b, $2f        ;; 04:7b41 ????????
    db   $30, $34, $31, $35, $32, $36, $33, $37        ;; 04:7b49 ????????

tileorderKraken:
    db   $38, $38, $00, $03, $01, $04, $02, $05        ;; 04:7b51 ????????
    db   $06, $0a, $07, $0b, $08, $0c, $09, $0d        ;; 04:7b59 ????????
    db   $0e, $11, $0f, $12, $10, $13, $14, $16        ;; 04:7b61 ????????
    db   $15, $17, $18, $1a, $19, $1b, $1c, $1e        ;; 04:7b69 ????????
    db   $1d, $1f, $20, $22, $21, $23, $24, $26        ;; 04:7b71 ????????
    db   $25, $27, $28, $2a, $29, $2b, $2c, $2e        ;; 04:7b79 ????????
    db   $2d, $2f, $30, $32, $31, $33                  ;; 04:7b81 ??????

tileorderJulius3:
    db   $00, $04, $01, $05, $02, $06, $03, $07        ;; 04:7b87 ????????
    db   $08, $0c, $09, $0d, $0a, $0e, $0b, $0f        ;; 04:7b8f ????????
    db   $10, $14, $11, $15, $12, $16, $13, $17        ;; 04:7b97 ????????
    db   $18, $1a, $19, $1b, $1c, $1e, $1d, $1f        ;; 04:7b9f ????????
