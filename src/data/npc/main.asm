;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy


;@npc_data amount=191
; Main NPC data. Indexed by spawn data.
; Offset $00: Collision flags, see wObjectRuntimeData
; Offset $01: index into the monster stat table
; Offset $02: Tile index to load
; Offset $03: Amount of tiles to load
; Offset $04: Pointer to graphics (bank 8 and up)
; Offset $06: Pointer to tile index order to load
; Offset $08: Pointer to metasprites
; Offset $0A-$0F: Unknown
; Offset $10: Movement pattern, one selected at random (4 bytes)
; Offset $14: script index value (2 bytes)
; Offset $16: chest script index value, or zero if never drops a chest (2 bytes)
npcDataTable:
    NPC_DATA $a9, $00, $74, $02, gfxSnowman, tileorderNpc, snowmanMetaspriteTable, $00, $00, $00, $00, $00, $00, $19, $19, $19, $19, script_003d, $0000 ;; 03:5f5a NPC_SNOWMAN_STILL
    NPC_DATA $d9, $01, $20, $08, gfxNpcGirl, tileorderNpc, metaspritesCompanionRed, $00, $01, $01, $01, $00, $00, $05, $05, $05, $05, script_0202, $0000 ;; 03:5f72 NPC_FUJI_FOLLOWING
    NPC_DATA $d9, $02, $20, $08, gfxNpcMysteryMan, tileorderNpc, metaspritesCompanionRed, $00, $01, $01, $01, $00, $00, $06, $06, $06, $06, script_0203, $0000 ;; 03:5f8a NPC_MYSTERYMAN_FOLLOWING
    NPC_DATA $d9, $03, $20, $08, gfxNpcWatts, tileorderNpc, metaspritesCompanion, $00, $01, $01, $01, $01, $00, $06, $06, $06, $06, script_0204, $0000 ;; 03:5fa2 NPC_WATTS_FOLLOWING
    NPC_DATA $d9, $04, $20, $08, gfxNpcBogard, tileorderNpc, metaspritesCompanion, $00, $01, $01, $01, $01, $00, $06, $06, $06, $06, script_0205, $0000 ;; 03:5fba NPC_BOGARD_FOLLOWING

IF DEF(GLADIATOR_DUKE)
    NPC_DATA $d9, $05, $20, $08, gfxNpcDuke, tileorderNpc, metaspritesCompanion, $00, $01, $01, $01, $01, $00, $06, $06, $06, $06, script_0206, $0000 ;; 03:5fd2 NPC_AMANDA_FOLLOWING
ELSE
    NPC_DATA $d9, $05, $20, $08, gfxNpcAmanda, tileorderNpc, metaspritesCompanion, $00, $01, $01, $01, $01, $00, $06, $06, $06, $06, script_0206, $0000 ;; 03:5fd2 NPC_AMANDA_FOLLOWING
ENDC

    NPC_DATA $d9, $06, $20, $08, gfxNpcLester, tileorderNpc, metaspritesCompanion, $00, $01, $01, $01, $01, $00, $06, $06, $06, $06, script_01ff, $0000 ;; 03:5fea NPC_LESTER_FOLLOWING
    NPC_DATA $d9, $07, $20, $08, gfxNpcMarcie, tileorderNpc, metaspritesCompanion, $00, $01, $01, $01, $01, $00, $06, $06, $06, $06, script_0200, $0000 ;; 03:6002 NPC_MARCIE_FOLLOWING
    NPC_DATA $d9, $08, $20, $08, gfxNpcChocobot, tileorderNpc, metaspritesCompanionRed, $00, $01, $01, $01, $00, $00, $05, $05, $05, $05, script_0470, $0000 ;; 03:601a NPC_CHOCOBOT_FOLLOWING
    NPC_DATA $d9, $09, $20, $08, gfxNpcChocobo, tileorderNpc, metaspritesCompanionRed, $00, $01, $01, $01, $00, $00, $05, $05, $05, $05, script_0470, $0000 ;; 03:6032 NPC_CHOCOBO_FOLLOWING
    NPC_DATA $91, $25, $50, $08, gfxEnemyWerewolf, tileorderNpc, metaspritesTabel50Normal, $00, $01, $00, $00, $01, $00, $0f, $05, $05, $05, script_003d, $0000 ;; 03:604a NPC_KETTS_BUTTLER_WEREWOLF
    NPC_DATA $81, $5e, $6e, $01, gfxBlankTiles09, tileorderNpc, metaspritesInvisible, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_01f1, $0000 ;; 03:6062 NPC_INV_CURE
    NPC_DATA $87, $0c, $78, $02, gfxChest, tileorderNpc, chest1MetaspriteTable, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_000b, $0000 ;; 03:607a NPC_CHEST_1
    NPC_DATA $87, $0d, $78, $02, gfxChest, tileorderNpc, chest2MetaspriteTable, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_000f, $0000 ;; 03:6092 NPC_CHEST_2
    NPC_DATA $87, $0e, $78, $02, gfxChest, tileorderNpc, chest3MetaspriteTable, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_0013, $0000 ;; 03:60aa NPC_CHEST_3
    NPC_DATA $a9, $00, $7c, $02, gfxChest, tileorderOpenChest, chestEmpty1MetaspriteTable, $00, $00, $00, $00, $00, $00, $19, $19, $19, $19, script_003d, $0000 ;; 03:60c2 NPC_CHEST_EMPTY
    NPC_DATA $91, $10, $40, $04, gfxEnemyChibidevil, tileorderNpc, metaspritesTable40FrontFacing, $00, $01, $00, $00, $00, $00, $0d, $0e, $0d, $0d, script_003d, script_0438 ;; 03:60da NPC_CHIBIDEVIL
    NPC_DATA $91, $11, $50, $06, gfxEnemyRabite, tileorderNpc, metaspritesRabiteFlowerFlameRed, $00, $01, $02, $00, $00, $00, $0f, $10, $10, $10, script_003d, $0000 ;; 03:60f2 NPC_RABBITE
    NPC_DATA $91, $12, $40, $08, gfxEnemyGoblin, tileorderNpc, metaspritesTabel40Normal, $00, $01, $00, $00, $00, $00, $02, $02, $03, $03, script_003d, script_0438 ;; 03:610a NPC_GOBLIN
    NPC_DATA $91, $13, $50, $04, gfxEnemyMyconid, tileorderNpc, metaspritesMyconid, $00, $01, $01, $00, $00, $00, $02, $02, $02, $02, script_003d, $0000 ;; 03:6122 NPC_MUSHROOM
    NPC_DATA $93, $14, $40, $04, gfxEnemyGrell, tileorderNpc, metaspritesRoper, $00, $01, $01, $00, $00, $00, $12, $12, $0b, $0b, script_003d, $0000 ;; 03:613a NPC_JELLYFISH
    NPC_DATA $91, $15, $50, $04, gfxEnemyMudman, tileorderNpc, metaspritesTable50FrontFacing, $01, $01, $00, $00, $00, $00, $16, $16, $16, $16, script_003d, script_044b ;; 03:6152 NPC_SWAMPMAN
    NPC_DATA $91, $16, $60, $08, gfxEnemyLizardman, tileorderNpc, metaspritesTabel60Normal, $00, $01, $01, $00, $00, $00, $02, $02, $03, $03, script_003d, script_043a ;; 03:616a NPC_LIZARDMAN
    NPC_DATA $91, $17, $50, $04, gfxEnemyDeathFlower, tileorderNpc, metaspritesRabiteFlowerFlameRed, $00, $01, $01, $00, $01, $00, $0d, $00, $0d, $0d, script_003d, script_043c ;; 03:6182 NPC_FLOWER
    NPC_DATA $91, $18, $40, $06, gfxEnemyGreenSlime, tileorderNpc, metaspritesTable40FrontFacing, $00, $01, $00, $00, $02, $00, $0f, $0d, $10, $10, script_003d, script_0443 ;; 03:619a NPC_GREEN_SLIME
    NPC_DATA $91, $19, $50, $08, gfxEnemySkeleton, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $03, $02, $03, $03, script_003d, script_0442 ;; 03:61b2 NPC_SKELETON
    NPC_DATA $91, $1a, $40, $04, gfxEnemyRoper, tileorderNpc, metaspritesRoper, $01, $02, $00, $00, $00, $00, $16, $16, $16, $16, script_003d, $0000 ;; 03:61ca NPC_ROPER
    NPC_DATA $91, $1b, $50, $04, gfxEnemyLandLeech, tileorderNpc, metaspritesTable50FrontFacing, $00, $01, $01, $00, $00, $00, $0d, $0d, $07, $08, script_003d, script_0443 ;; 03:61e2 NPC_LAND_LEECH
    NPC_DATA $91, $1c, $40, $06, gfxEnemyZombie, tileorderNpc, metaspritesZombie, $00, $01, $01, $00, $00, $00, $05, $02, $05, $05, script_003d, script_0439 ;; 03:61fa NPC_ZOMBIE
    NPC_DATA $91, $1d, $50, $08, gfxEnemyWarerat, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $02, $02, $07, $08, script_003d, script_043a ;; 03:6212 NPC_WERERAT
    NPC_DATA $91, $1e, $40, $06, gfxEnemyPumpkinBomb, tileorderNpc, metaspritesPumpkin, $00, $01, $02, $02, $00, $00, $18, $18, $18, $18, script_003d, script_0453 ;; 03:622a NPC_PUMPKIN
    NPC_DATA $91, $1f, $50, $06, gfxEnemyBloodOwl, tileorderNpc, metaspritesTable50FrontFacing, $01, $02, $00, $00, $00, $00, $0b, $0b, $0d, $0d, script_003d, script_0447 ;; 03:6242 NPC_OWL
    NPC_DATA $93, $20, $40, $04, gfxEnemyKillerBee, tileorderNpc, metaspritesTable40FrontFacing, $00, $01, $01, $00, $00, $00, $0b, $0b, $0b, $0b, script_003d, $0000 ;; 03:625a NPC_BEE
    NPC_DATA $93, $21, $50, $06, gfxEnemyGasCloud, tileorderNpc, metaspritesTable50FrontFacing, $00, $01, $01, $00, $02, $00, $01, $03, $12, $12, script_003d, script_0440 ;; 03:6272 NPC_CLOUD
    NPC_DATA $91, $22, $40, $08, gfxEnemyOrc, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $02, $03, $03, $03, script_003d, script_0445 ;; 03:628a NPC_ORC
    NPC_DATA $91, $23, $50, $06, gfxEnemyDeathCrab, tileorderNpc, metaspritesRabiteFlowerFlameRed, $00, $01, $01, $00, $02, $00, $0e, $0d, $0e, $0e, script_003d, script_0459 ;; 03:62a2 NPC_CRAB
    NPC_DATA $91, $24, $40, $08, gfxEnemyTarantula, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $02, $00, $03, $02, $03, $03, script_003d, $0000 ;; 03:62ba NPC_SPIDER
    NPC_DATA $81, $0a, $6e, $01, gfxBlankTiles09, tileorderNpc, metaspritesInvisible, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_01fa, $0000 ;; 03:62d2 NPC_INV_OPEN_NORTH
    NPC_DATA $81, $0a, $6e, $01, gfxBlankTiles09, tileorderNpc, metaspritesInvisible, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_01fb, $0000 ;; 03:62ea NPC_INV_OPEN_SOUTH
    NPC_DATA $81, $0a, $6e, $01, gfxBlankTiles09, tileorderNpc, metaspritesInvisible, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_01fc, $0000 ;; 03:6302 NPC_INV_OPEN_EAST
    NPC_DATA $81, $0a, $6e, $01, gfxBlankTiles09, tileorderNpc, metaspritesInvisible, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_01fd, $0000 ;; 03:631a NPC_INV_OPEN_WEST
    NPC_DATA $91, $26, $60, $06, gfxEnemyMimic, tileorderNpc, metaspritesTable60FrontFacing, $00, $01, $00, $00, $02, $00, $1b, $1b, $0f, $0f, script_003d, script_0445 ;; 03:6332 NPC_MIMIC_CHEST
    NPC_DATA $91, $27, $50, $04, gfxEnemyRuster, tileorderNpc, metaspritesTable50FrontFacing, $00, $00, $01, $00, $00, $00, $0f, $10, $0f, $0f, script_003d, $0000 ;; 03:634a NPC_HOPPING_BUG
    NPC_DATA $91, $28, $50, $0a, gfxEnemyPorcupine, tileorderNpc, metaspritesPakkunPorcupine, $00, $01, $02, $00, $02, $00, $02, $03, $03, $03, script_003d, script_0445 ;; 03:6362 NPC_PORCUPINE
    NPC_DATA $91, $29, $40, $06, gfxEnemyMandrake, tileorderNpc, metaspritesTable40FrontFacing, $00, $01, $02, $02, $02, $02, $01, $00, $03, $03, script_003d, $0000 ;; 03:637a NPC_CARROT
    NPC_DATA $91, $2a, $40, $08, gfxEnemyEyeSpy, tileorderNpc, metaspritesEyeSpy, $00, $01, $01, $02, $02, $00, $00, $00, $01, $01, script_003d, script_044b ;; 03:6392 NPC_EYE_SPY
    NPC_DATA $91, $2b, $50, $08, gfxEnemyWerewolf, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $11, $05, $03, $03, script_003d, script_043a ;; 03:63aa NPC_WEREWOLF_2
    NPC_DATA $93, $2c, $60, $04, gfxEnemyGhost, tileorderNpc, metaspritesTable60FrontFacing, $00, $01, $01, $00, $00, $00, $0b, $12, $12, $12, script_003d, script_0439 ;; 03:63c2 NPC_GHOST
    NPC_DATA $91, $2d, $40, $04, gfxEnemyBasilisk, tileorderNpc, metaspritesTable40FrontFacing, $00, $01, $01, $01, $00, $00, $0b, $0b, $0b, $0b, script_003d, script_0455 ;; 03:63da NPC_BASILISK
    NPC_DATA $91, $2e, $50, $06, gfxEnemyDeathScorpion, tileorderNpc, metaspritesRabiteFlowerFlameRed, $00, $01, $01, $01, $02, $00, $01, $02, $01, $01, script_003d, $0000 ;; 03:63f2 NPC_SCORPION
    NPC_DATA $91, $2f, $60, $08, gfxEnemySaurus, tileorderNpc, metaspritesTabel60Normal, $00, $01, $01, $00, $00, $00, $02, $02, $02, $02, script_003d, script_0444 ;; 03:640a NPC_SAURUS
    NPC_DATA $91, $31, $40, $04, gfxEnemyMummy, tileorderNpc, metaspritesTable40FrontFacing, $00, $01, $01, $00, $00, $00, $02, $02, $05, $05, script_003d, script_0457 ;; 03:6422 NPC_MUMMY
    NPC_DATA $91, $30, $50, $0a, gfxEnemyPakkunLizard, tileorderNpc, metaspritesPakkunPorcupine, $00, $01, $01, $02, $02, $00, $05, $02, $02, $02, script_003d, $0000 ;; 03:643a NPC_PAKKUN_LIZARD
    NPC_DATA $91, $32, $50, $08, gfxEnemyCobra, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $02, $02, $0d, $0d, script_003d, $0000 ;; 03:6452 NPC_SNAKE
    NPC_DATA $91, $33, $60, $06, gfxEnemyShadowZero, tileorderNpc, metaspritesShadowZero, $00, $01, $01, $00, $00, $00, $16, $16, $07, $08, script_003d, script_0439 ;; 03:646a NPC_SHADOW
    NPC_DATA $91, $34, $58, $0c, gfxEnemyMagician, tileorderNpc, metaspritesJulius, $00, $01, $01, $02, $02, $00, $03, $13, $13, $13, script_003d, script_0458 ;; 03:6482 NPC_BLACK_WIZARD
    NPC_DATA $91, $35, $50, $04, gfxEnemyRedWisp, tileorderNpc, metaspritesRabiteFlowerFlameRed, $00, $01, $01, $00, $00, $00, $0d, $0d, $14, $14, script_003d, script_043e ;; 03:649a NPC_FLAME
    NPC_DATA $91, $36, $60, $08, gfxEnemyGargoyle, tileorderNpc, metaspritesTabel60Normal, $00, $01, $01, $00, $00, $00, $00, $00, $07, $08, script_003d, script_0447 ;; 03:64b2 NPC_GARGOYLE
    NPC_DATA $91, $37, $40, $08, gfxEnemyApe, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $02, $02, $02, $02, script_003d, $0000 ;; 03:64ca NPC_MONKEY
    NPC_DATA $91, $38, $50, $08, gfxEnemyMolebear, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $02, $02, $03, $03, script_003d, $0000 ;; 03:64e2 NPC_MOLEBEAR
    NPC_DATA $91, $39, $40, $08, gfxEnemyOrge, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $03, $03, $03, $03, script_003d, script_043e ;; 03:64fa NPC_OGRE
    NPC_DATA $91, $3a, $50, $04, gfxEnemyBarnaclejack, tileorderNpc, metaspritesTable50FrontFacing, $01, $00, $00, $00, $00, $00, $0f, $10, $0f, $0f, script_003d, script_0455 ;; 03:6512 NPC_BARNACLEJACK
    NPC_DATA $91, $3b, $40, $08, gfxEnemyPhantasm, tileorderNpc, metaspritesPhantasm, $00, $01, $01, $01, $00, $00, $0c, $0c, $12, $12, script_003d, script_0449 ;; 03:652a NPC_PHANTASM
    NPC_DATA $91, $3c, $50, $08, gfxEnemyMinotaur, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $03, $02, $03, $03, script_003d, script_043a ;; 03:6542 NPC_MINOTAUR
    NPC_DATA $91, $3d, $40, $0c, gfxEnemyWizard, tileorderNpc, metaspritesWizard, $00, $01, $01, $02, $02, $00, $13, $12, $14, $14, script_003d, script_0449 ;; 03:655a NPC_GLAIVE_MAGE
    NPC_DATA $91, $3e, $58, $0c, gfxEnemyDarkStalker, tileorderNpc, metaspritesDarkStalker, $00, $01, $01, $00, $00, $00, $03, $02, $03, $03, script_003d, script_043e ;; 03:6572 NPC_GLAIVE_KNIGHT
    NPC_DATA $91, $3f, $40, $0c, gfxEnemyDarkLord, tileorderNpc, metaspritesShadowKnight, $00, $01, $01, $00, $00, $00, $06, $06, $07, $08, script_003d, $0000 ;; 03:658a NPC_SHADOW_KNIGHT
    NPC_DATA $91, $40, $40, $04, gfxEnemyMegaXorn, tileorderNpc, metaspritesTable40FrontFacing, $00, $01, $01, $00, $00, $00, $03, $02, $01, $01, script_003d, script_0467 ;; 03:65a2 NPC_MEGA_FLYTRAP
    NPC_DATA $93, $41, $50, $04, gfxEnemyDragonfly, tileorderNpc, metaspritesTable50FrontFacing, $00, $01, $01, $00, $00, $00, $0c, $0b, $0b, $0b, script_003d, script_0457 ;; 03:65ba NPC_DRAGONFLY
    NPC_DATA $91, $42, $60, $04, gfxEnemyBulette, tileorderNpc, metaspritesTable60FrontFacing, $00, $01, $01, $00, $00, $00, $02, $02, $07, $08, script_003d, script_045a ;; 03:65d2 NPC_ARMADILLO
    NPC_DATA $91, $43, $40, $04, gfxEnemySnowman, tileorderNpc, metaspritesTable40FrontFacing, $00, $01, $01, $00, $00, $00, $0d, $0d, $0d, $0d, script_003d, $0000 ;; 03:65ea NPC_SNOWMAN_MOVING
    NPC_DATA $91, $44, $50, $04, gfxEnemySabercat, tileorderNpc, metaspritesTable50FrontFacing, $00, $01, $01, $00, $00, $00, $10, $02, $02, $02, script_003d, $0000 ;; 03:6602 NPC_SABER_CAT
    NPC_DATA $91, $45, $60, $04, gfxEnemyWalrus, tileorderNpc, metaspritesTable60FrontFacing, $00, $01, $01, $00, $00, $00, $03, $02, $10, $10, script_003d, script_0458 ;; 03:661a NPC_WALRUS
    NPC_DATA $91, $46, $40, $08, gfxEnemyDuckSolder, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $02, $02, $01, $01, script_003d, $0000 ;; 03:6632 NPC_DUCK_SOLDIER
    NPC_DATA $91, $47, $50, $04, gfxEnemyPoto, tileorderNpc, metaspritesTable50FrontFacing, $00, $00, $01, $01, $00, $00, $0f, $10, $10, $10, script_003d, script_0449 ;; 03:664a NPC_POTO_RABBIT
    NPC_DATA $91, $48, $40, $06, gfxEnemyAirElemental, tileorderNpc, metaspritesAirElemental, $00, $01, $01, $00, $00, $00, $0b, $0b, $07, $08, script_003d, $0000 ;; 03:6662 NPC_CYCLONE
    NPC_DATA $93, $49, $50, $08, gfxEnemyBeholder, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $02, $00, $00, $0c, $0b, $14, $14, script_003d, $0000 ;; 03:667a NPC_BEHOLDER_EYE
    NPC_DATA $93, $4a, $40, $04, gfxEnemyMantaRay, tileorderNpc, metaspritesTable40FrontFacing, $00, $01, $01, $00, $00, $00, $0d, $0d, $0d, $0d, script_003d, script_0452 ;; 03:6692 NPC_MANTA_RAY
    NPC_DATA $91, $4b, $50, $04, gfxEnemyGriffinHand, tileorderNpc, metaspritesTable50FrontFacing, $00, $01, $01, $00, $00, $00, $0f, $10, $0f, $0f, script_003d, script_0456 ;; 03:66aa NPC_JUMPING_HAND
    NPC_DATA $91, $4c, $40, $08, gfxEnemyTortoiseKnight, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $02, $00, $01, $03, $02, $03, $03, script_003d, script_043e ;; 03:66c2 NPC_TORTOISE
    NPC_DATA $91, $4d, $40, $04, gfxEnemyFireMoth, tileorderNpc, metaspritesTable40FrontFacing, $00, $01, $01, $00, $00, $00, $0b, $0b, $0b, $0b, script_003d, $0000 ;; 03:66da NPC_FIRE_MOTH
    NPC_DATA $91, $4e, $50, $06, gfxEnemyEarthElemental, tileorderNpc, metaspritesEarthElemental, $00, $01, $01, $00, $00, $00, $16, $16, $16, $16, script_003d, script_0449 ;; 03:66f2 NPC_EARTH_DIGGER
    NPC_DATA $91, $4f, $40, $04, gfxEnemyDenden, tileorderNpc, metaspritesTable40FrontFacing, $00, $01, $01, $00, $00, $00, $0d, $0d, $0d, $0d, script_003d, script_043e ;; 03:670a NPC_DENDEN_SNAIL
    NPC_DATA $91, $50, $50, $06, gfxEnemyDoppelMirror, tileorderNpc, metaspritesDoppelMirror, $00, $01, $01, $00, $00, $00, $12, $12, $13, $13, script_003d, script_044a ;; 03:6722 NPC_DOPPEL_MIRROR
    NPC_DATA $91, $51, $60, $04, gfxEnemyGuardian, tileorderNpc, metaspritesGuardian, $00, $01, $01, $00, $00, $00, $02, $02, $03, $03, script_003d, script_0452 ;; 03:673a NPC_GUARDIAN
    NPC_DATA $91, $52, $40, $04, gfxEnemyEvilSword, tileorderNpc, metaspritesEvilSword, $00, $01, $01, $00, $00, $00, $02, $02, $07, $08, script_003d, $0000 ;; 03:6752 NPC_EVIL_SWORD
    NPC_DATA $91, $53, $50, $0c, gfxEnemyDeathGauntlet, tileorderNpc, metaspritesDeathGauntlet, $00, $01, $01, $00, $00, $00, $02, $02, $12, $12, script_003d, script_0449 ;; 03:676a NPC_GAUNTLET
    NPC_DATA $91, $54, $40, $08, gfxEnemyGarasha, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $02, $02, $03, $03, script_003d, script_043e ;; 03:6782 NPC_GARASHA_DUCK
    NPC_DATA $91, $55, $50, $04, gfxEnemyWonder, tileorderNpc, metaspritesTable50FrontFacing, $00, $01, $01, $00, $00, $00, $03, $03, $12, $12, script_003d, $0000 ;; 03:679a NPC_FUZZY_WONDER
    NPC_DATA $91, $56, $40, $04, gfxEnemyMammoth, tileorderNpc, metaspritesTable40FrontFacing, $00, $01, $01, $00, $00, $00, $03, $02, $0d, $0d, script_003d, script_044d ;; 03:67b2 NPC_ELEPHANT
    NPC_DATA $91, $57, $50, $08, gfxEnemyNinja, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $15, $02, $09, $0a, script_003d, script_044e ;; 03:67ca NPC_NINJA
    NPC_DATA $91, $58, $58, $0c, gfxEnemyJulius, tileorderNpc, metaspritesJulius, $00, $01, $01, $00, $02, $00, $0c, $13, $15, $15, script_003d, $0000 ;; 03:67e2 NPC_JULIUS
    NPC_DATA $91, $59, $40, $04, gfxEnemyDemon, tileorderNpc, metaspritesTable40FrontFacing, $00, $01, $01, $00, $00, $00, $14, $14, $14, $14, script_003d, script_044f ;; 03:67fa NPC_DEMON_HEAD
    NPC_DATA $91, $5a, $6e, $01, gfxBlankTiles09, tileorderNpc, metaspritesInvisible, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, script_01e5, $0000 ;; 03:6812 NPC_INV_DESSERT_CAVE_STONE
    NPC_DATA $95, $5b, $60, $08, gfxEnemySahagin, tileorderNpc, metaspritesTabel60Normal, $00, $01, $01, $00, $00, $00, $06, $13, $06, $06, script_003d, $0000 ;; 03:682a NPC_SAHAGIN
    NPC_DATA $95, $5c, $60, $06, gfxEnemySeaDragon, tileorderNpc, metaspritesTable60FrontFacing, $00, $01, $01, $02, $02, $02, $01, $16, $17, $17, script_003d, $0000 ;; 03:6842 NPC_SEA_DRAGON
    NPC_DATA $93, $5d, $60, $08, gfxEnemyGalFish, tileorderNpc, metaspritesTabel60Normal, $00, $01, $00, $00, $00, $00, $05, $05, $07, $08, script_003d, $0000 ;; 03:685a NPC_GALL_FISH
    NPC_DATA $81, $5e, $60, $02, gfxNpcWilly, tileorderNpc, metaspritesWilly, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_0264, $0000 ;; 03:6872 NPC_WILLY
    NPC_DATA $81, $5e, $40, $08, gfxNpcMysteryMan, tileorderNpc, metaspritesTable40Red, $00, $01, $01, $00, $02, $00, $04, $04, $04, $04, script_0259, $0000 ;; 03:688a NPC_MYSTERYMAN_1

IF DEF(GLADIATOR_DUKE)
    NPC_DATA $81, $5f, $60, $08, gfxNpcDuke, tileorderNpc, metaspritesTabel60Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0261, $0000 ;; 03:68a2 NPC_AMANDA_1
    NPC_DATA $91, $60, $40, $02, gfxNpcDukeIll, tileorderNpc, metaspritesTable40FrontFacing, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_0226, $0000 ;; 03:68ba NPC_AMANDA_ILL
    NPC_DATA $81, $5e, $5c, $02, gfxNpcDukeDead, tileorderNpc, metaspritesTable5cUnmoving, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_0228, $0000 ;; 03:68d2 NPC_AMANDA_DEAD
ELSE
    NPC_DATA $81, $5f, $60, $08, gfxNpcAmanda, tileorderNpc, metaspritesTabel60Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0261, $0000 ;; 03:68a2 NPC_AMANDA_1
    NPC_DATA $91, $60, $40, $02, gfxNpcAmandaIll, tileorderNpc, metaspritesTable40FrontFacing, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_0226, $0000 ;; 03:68ba NPC_AMANDA_ILL
    NPC_DATA $81, $5e, $5c, $02, gfxNpcAmandaDead, tileorderNpc, metaspritesTable5cUnmoving, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_0228, $0000 ;; 03:68d2 NPC_AMANDA_DEAD
ENDC

    NPC_DATA $81, $01, $20, $08, gfxNpcGirl, tileorderNpc, metaspritesCompanionRed, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, script_0258, $0000 ;; 03:68ea NPC_FUJI_1
    NPC_DATA $81, $5e, $40, $02, gfxNpcGirlWindow, tileorderNpc, metaspritesTable40UnmovingRed, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_0207, $0000 ;; 03:6902 NPC_FUJI_WINDOW
    NPC_DATA $81, $5e, $5c, $02, gfxNpcMother, tileorderNpc, metaspritesTable5cUnmoving, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_01fe, $0000 ;; 03:691a NPC_MOTHER
    NPC_DATA $81, $5f, $60, $08, gfxNpcBogard, tileorderNpc, metaspritesTabel60Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0257, $0000 ;; 03:6932 NPC_BOGARD_1
    NPC_DATA $81, $5e, $40, $08, gfxNpcBogard, tileorderNpc, metaspritesTable40Unmoving, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_0257, $0000 ;; 03:694a NPC_BOGARD_2
    NPC_DATA $81, $5f, $40, $08, data_09_6900, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, script_01e0, $0000 ;; 03:6962 NPC_KETTS_BUTTLER
    NPC_DATA $81, $5e, $6e, $01, gfxBlankTiles09, tileorderNpc, metaspritesInvisible, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_01e3, $0000 ;; 03:697a NPC_INV_FUJI_COFFIN
    NPC_DATA $81, $5f, $60, $08, gfxNpcCibba, tileorderNpc, metaspritesTabel60Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_025a, $0000 ;; 03:6992 NPC_CIBBA
    NPC_DATA $81, $5e, $40, $08, data_09_5f00, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_01e6, $0000 ;; 03:69aa NPC_GUY_WENDEL
    NPC_DATA $81, $5e, $40, $08, gfxNpcWatts, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, script_01f8, $0000 ;; 03:69c2 NPC_WATTS
    NPC_DATA $81, $5e, $5c, $02, gfxNpcMinecart, tileorderNpc, metaspritesTable5cUnmovingRed, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_01f9, $0000 ;; 03:69da NPC_MINECART
    NPC_DATA $81, $5e, $40, $04, gfxNpcEgg, tileorderNpc, metaspritesTable40FrontFacing, $00, $00, $00, $00, $00, $00, $19, $19, $19, $19, script_0217, $0000 ;; 03:69f2 NPC_CHOCOBO_EGG
    NPC_DATA $81, $5f, $40, $08, gfxNpcDavias, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, script_0218, $0000 ;; 03:6a0a NPC_DAVIAS
    NPC_DATA $81, $5e, $5c, $02, gfxNpcLesterInstrument, tileorderNpc, metaspritesTable5cUnmoving, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_0222, $0000 ;; 03:6a22 NPC_LESTER_1
    NPC_DATA $81, $5f, $50, $04, gfxNpcParrot, tileorderNpc, metaspritesTable50FrontFacing, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, script_0219, $0000 ;; 03:6a3a NPC_LESTER_PARROT
    NPC_DATA $81, $5e, $40, $08, gfxNpcBowow, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_022f, $0000 ;; 03:6a52 NPC_BOWOW
    NPC_DATA $81, $5f, $60, $08, data_09_6000, tileorderNpc, metaspritesTabel60Normal, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, script_0231, $0000 ;; 03:6a6a NPC_SARAH
    NPC_DATA $81, $5e, $40, $08, gfxNpcMarcie, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_023d, $0000 ;; 03:6a82 NPC_MARCIE_1
    NPC_DATA $81, $5f, $60, $08, data_09_6500, tileorderNpc, metaspritesTabel60Normal, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, script_0250, $0000 ;; 03:6a9a NPC_KING_OF_LORIM
    NPC_DATA $81, $5e, $40, $08, gfxGladiatorFriend, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0265, $0000 ;; 03:6ab2 NPC_GLADIATOR_FRIEND
    NPC_DATA $81, $5e, $6e, $01, gfxBlankTiles09, tileorderNpc, metaspritesInvisible, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, script_025f, $0000 ;; 03:6aca NPC_INV_INN
    NPC_DATA $81, $61, $50, $08, data_09_6000, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0266, $0000 ;; 03:6ae2 NPC_GIRL_TOPPLE
    NPC_DATA $81, $0b, $40, $08, data_09_5f00, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0267, $0000 ;; 03:6afa NPC_GUY_TOPPLE
    NPC_DATA $81, $0b, $40, $08, data_09_6100, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0268, $0000 ;; 03:6b12 NPC_GUY_TOPPLE_HOUSE
    NPC_DATA $81, $61, $50, $08, data_09_6000, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0269, $0000 ;; 03:6b2a NPC_GIRL_TOPPLE_HOUSE
    NPC_DATA $81, $61, $60, $08, data_09_6400, tileorderNpc, metaspritesTabel60Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_026a, $0000 ;; 03:6b42 NPC_OLDMAN_TOPPLE
    NPC_DATA $81, $0b, $50, $08, data_09_5f00, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_01e1, $0000 ;; 03:6b5a NPC_GUY_KETTS
    NPC_DATA $81, $0b, $60, $08, data_09_6600, tileorderNpc, metaspritesTabel60Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_01e2, $0000 ;; 03:6b72 NPC_GIRL_KETTS
    NPC_DATA $81, $61, $40, $08, data_09_6000, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_01e9, $0000 ;; 03:6b8a NPC_GIRL_CIBBA
    NPC_DATA $81, $0b, $40, $08, data_09_6100, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_01ea, $0000 ;; 03:6ba2 NPC_GUY_WENDEL2
    NPC_DATA $81, $0b, $50, $08, data_09_5f00, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_01eb, $0000 ;; 03:6bba NPC_GUY_WENDEL_HOUSE
    NPC_DATA $81, $0b, $50, $08, data_09_6200, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_01ec, $0000 ;; 03:6bd2 NPC_WOMAN_CIBBA
    NPC_DATA $81, $61, $60, $08, data_09_6400, tileorderNpc, metaspritesTabel60Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_01ed, $0000 ;; 03:6bea NPC_OLDMAN_WENDEL
    NPC_DATA $81, $0b, $40, $08, data_09_6700, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_01f2, $0000 ;; 03:6c02 NPC_DWARF_1
    NPC_DATA $81, $61, $40, $08, data_09_6700, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_01f3, $0000 ;; 03:6c1a NPC_DWARF_2
    NPC_DATA $81, $0b, $50, $08, data_09_6700, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_01f4, $0000 ;; 03:6c32 NPC_DWARF_3
    NPC_DATA $81, $0b, $40, $08, data_09_6700, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_01f5, $0000 ;; 03:6c4a NPC_DWARF_4
    NPC_DATA $81, $61, $50, $08, data_09_6700, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_01f6, $0000 ;; 03:6c62 NPC_DWARF_5
    NPC_DATA $81, $0b, $50, $08, data_09_5f00, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0209, $0000 ;; 03:6c7a NPC_GUY_AIRSHIP_1
    NPC_DATA $81, $0b, $40, $08, data_09_5f00, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_020b, $0000 ;; 03:6c92 NPC_GUY_AIRSHIP_2
    NPC_DATA $81, $0b, $50, $08, data_09_5f00, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_020d, $0000 ;; 03:6caa NPC_GUY_AIRSHIP_3
    NPC_DATA $81, $0b, $60, $08, data_09_5f00, tileorderNpc, metaspritesTabel60Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_020e, $0000 ;; 03:6cc2 NPC_GUY_AIRSHIP_4
    NPC_DATA $81, $61, $40, $08, data_09_6400, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0211, $0000 ;; 03:6cda NPC_OLDMAN_MENOS_1
    NPC_DATA $81, $0b, $50, $08, data_09_6100, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0212, $0000 ;; 03:6cf2 NPC_GUY_MENOS
    NPC_DATA $81, $0b, $40, $08, data_09_6600, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0213, $0000 ;; 03:6d0a NPC_GIRL_MENOS_1
    NPC_DATA $81, $61, $50, $08, data_09_6400, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0214, $0000 ;; 03:6d22 NPC_OLDMAN_MENOS_2
    NPC_DATA $81, $0b, $50, $08, data_09_6000, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0215, $0000 ;; 03:6d3a NPC_GIRL_MENOS
    NPC_DATA $81, $0b, $40, $08, data_09_6200, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0216, $0000 ;; 03:6d52 NPC_WOMAN_MENOS_2
    NPC_DATA $81, $0b, $60, $08, data_09_5e00, tileorderNpc, metaspritesTabel60Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_021a, $0000 ;; 03:6d6a NPC_GIRL_JADD_1
    NPC_DATA $81, $61, $40, $08, data_09_6400, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_021b, $0000 ;; 03:6d82 NPC_OLDMAN_JADD
    NPC_DATA $81, $0b, $50, $08, data_09_6200, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_021c, $0000 ;; 03:6d9a NPC_GIRL_JADD_2
    NPC_DATA $81, $0b, $40, $08, data_09_6100, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_021d, $0000 ;; 03:6db2 NPC_GUY_JADD
    NPC_DATA $81, $0b, $50, $08, data_09_6700, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_021e, $0000 ;; 03:6dca NPC_DWARF_JADD
    NPC_DATA $81, $0b, $60, $08, data_09_6300, tileorderNpc, metaspritesTabel60Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_021f, $0000 ;; 03:6de2 NPC_SALESMAN_JADD
    NPC_DATA $81, $0b, $40, $08, data_09_6000, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0220, $0000 ;; 03:6dfa NPC_GIRL_JADD_3
    NPC_DATA $81, $0b, $50, $08, data_09_5f00, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0221, $0000 ;; 03:6e12 NPC_BOY_JADD
    NPC_DATA $81, $61, $40, $08, data_09_6400, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0230, $0000 ;; 03:6e2a NPC_OLDMAN_ISH
    NPC_DATA $81, $0b, $50, $08, data_09_5f00, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0233, $0000 ;; 03:6e42 NPC_GUY_ISH_1
    NPC_DATA $81, $0b, $40, $08, data_09_5f00, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0234, $0000 ;; 03:6e5a NPC_GUY_ISH_2
    NPC_DATA $81, $61, $50, $08, data_09_6000, tileorderNpc, metaspritesTabel50Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0235, $0000 ;; 03:6e72 NPC_GIRL_ISH
    NPC_DATA $81, $0b, $40, $08, data_09_5f00, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0236, $0000 ;; 03:6e8a NPC_GUY_ISH_3
    NPC_DATA $81, $0b, $40, $08, data_09_6100, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0237, $0000 ;; 03:6ea2 NPC_GUY_ISH_4
    NPC_DATA $81, $5e, $6e, $01, gfxBlankTiles09, tileorderNpc, metaspritesInvisible, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_023e, $0000 ;; 03:6eba NPC_INV_STONE_1
    NPC_DATA $81, $5e, $6e, $01, gfxBlankTiles09, tileorderNpc, metaspritesInvisible, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_023f, $0000 ;; 03:6ed2 NPC_INV_STONE_2
    NPC_DATA $81, $5e, $6e, $01, gfxBlankTiles09, tileorderNpc, metaspritesInvisible, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_0240, $0000 ;; 03:6eea NPC_INV_STONE_3
    NPC_DATA $81, $5e, $6e, $01, gfxBlankTiles09, tileorderNpc, metaspritesInvisible, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_0241, $0000 ;; 03:6f02 NPC_INV_STONE_4
    NPC_DATA $81, $5e, $6e, $01, gfxBlankTiles09, tileorderNpc, metaspritesInvisible, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_0242, $0000 ;; 03:6f1a NPC_INV_STONE_5
    NPC_DATA $81, $5e, $6e, $01, gfxBlankTiles09, tileorderNpc, metaspritesInvisible, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_0243, $0000 ;; 03:6f32 NPC_INV_STONE_6
    NPC_DATA $81, $5e, $6e, $01, gfxBlankTiles09, tileorderNpc, metaspritesInvisible, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_0244, $0000 ;; 03:6f4a NPC_INV_STONE_7
    NPC_DATA $81, $5e, $6e, $01, gfxBlankTiles09, tileorderNpc, metaspritesInvisible, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_0245, $0000 ;; 03:6f62 NPC_INV_STONE_8
    NPC_DATA $81, $5e, $50, $08, data_09_5f00, tileorderNpc, metaspritesTable5cUnmoving, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, script_0251, $0000 ;; 03:6f7a NPC_GUY_LORIM_FROZEN
    NPC_DATA $81, $5e, $40, $08, data_09_5f00, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0252, $0000 ;; 03:6f92 NPC_GUY_LORIM_1
    NPC_DATA $81, $5e, $40, $08, data_09_5f00, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_0253, $0000 ;; 03:6faa NPC_GUY_LORIM_2
    NPC_DATA $81, $5f, $40, $08, data_09_6300, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, script_025d, $0000 ;; 03:6fc2 NPC_SALESMAN
    NPC_DATA $81, $5e, $6e, $01, gfxBlankTiles09, tileorderNpc, metaspritesInvisible, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, script_0260, $0000 ;; 03:6fda NPC_INV_SALESMAN_1
    NPC_DATA $81, $5f, $40, $08, gfxNpcGirl, tileorderNpc, metaspritesTable40Red, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, script_0258, $0000 ;; 03:6ff2 NPC_FUJI_2
    NPC_DATA $81, $5e, $6e, $01, gfxBlankTiles09, tileorderNpc, metaspritesInvisible, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, script_025e, $0000 ;; 03:700a NPC_INV_SALESMAN_2
    NPC_DATA $81, $02, $20, $08, gfxNpcMysteryMan, tileorderNpc, metaspritesCompanionRed, $00, $01, $01, $01, $00, $00, $02, $02, $02, $02, script_0259, $0000 ;; 03:7022 NPC_MYSTERYMAN_2
    NPC_DATA $81, $04, $20, $08, gfxNpcBogard, tileorderNpc, metaspritesCompanion, $00, $01, $01, $01, $01, $00, $02, $02, $02, $02, script_0257, $0000 ;; 03:703a NPC_BOGARD_3

IF DEF(GLADIATOR_DUKE)
    NPC_DATA $81, $05, $20, $08, gfxNpcDuke, tileorderNpc, metaspritesCompanion, $00, $01, $01, $01, $01, $00, $02, $02, $02, $02, script_003d, $0000 ;; 03:7052 NPC_AMANDA_2
ELSE
    NPC_DATA $81, $05, $20, $08, gfxNpcAmanda, tileorderNpc, metaspritesCompanion, $00, $01, $01, $01, $01, $00, $02, $02, $02, $02, script_003d, $0000 ;; 03:7052 NPC_AMANDA_2
ENDC

    NPC_DATA $81, $06, $20, $08, gfxNpcLester, tileorderNpc, metaspritesCompanion, $00, $01, $01, $01, $01, $00, $02, $02, $02, $02, script_003d, $0000 ;; 03:706a NPC_LESTER_2
    NPC_DATA $81, $07, $20, $08, gfxNpcMarcie, tileorderNpc, metaspritesCompanion, $00, $01, $01, $01, $01, $00, $02, $02, $02, $02, script_003d, $0000 ;; 03:7082 NPC_MARCIE_2
    NPC_DATA $81, $08, $20, $08, gfxNpcChocobot, tileorderNpc, metaspritesCompanionRed, $00, $01, $01, $01, $00, $00, $02, $02, $02, $02, script_0472, $0000 ;; 03:709a NPC_CHOCOBOT
    NPC_DATA $81, $09, $50, $08, gfxNpcChocobo, tileorderNpc, metaspritesTabel50Normal, $00, $01, $00, $01, $00, $00, $00, $00, $00, $00, script_0472, $0000 ;; 03:70b2 NPC_CHOCOBO_1
    NPC_DATA $81, $09, $20, $08, gfxNpcChocobo, tileorderNpc, metaspritesCompanionRed, $00, $01, $01, $01, $00, $00, $02, $02, $02, $02, script_0472, $0000 ;; 03:70ca NPC_CHOCOBO_2
    NPC_DATA $81, $5e, $5c, $02, gfxNpcPrisonBars, tileorderNpc, metaspritesTable5cUnmoving, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_0258, $0000 ;; 03:70e2 NPC_PRISION_BARS
    NPC_DATA $81, $5f, $40, $04, gfxNpcMusic, tileorderNpc, metaspritesRoper, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, script_003d, $0000 ;; 03:70fa NPC_MUSIC_NOTES
    NPC_DATA $81, $5e, $40, $08, gfxNpcMagicMerchant, tileorderNpc, metaspritesTabel40Normal, $00, $01, $01, $00, $00, $00, $04, $04, $04, $04, script_025d, $0000 ;; 03:7112 NPC_MAGIC_SALESMAN

; A NPC styled like the PC but without the shield for certain cutscenes.
IF DEF(PLAYER_GRAPHICS_AMANDA)
    NPC_DATA $91, $05, $50, $08, gfxNpcAmanda, tileorderNpc, metaspritesShieldlessPC, $00, $01, $01, $00, $00, $00, $06, $03, $07, $08, script_003d, $0000 ;; 03:712a NPC_HERO_SHIELDLESS
ELIF DEF(PLAYER_GRAPHICS_ORIGINAL)
    NPC_DATA $91, $05, $50, $08, gfxNpcDuke, tileorderNpc, metaspritesShieldlessPC, $00, $01, $01, $00, $00, $00, $06, $03, $07, $08, script_003d, $0000 ;; 03:712a NPC_HERO_SHIELDLESS
ENDC
; New faster Shadow Knight to push you off the waterfall.
    NPC_DATA $91, $0e, $40, $0c, gfxEnemyDarkLord, tileorderNpc, metaspritesShadowKnight, $00, $01, $01, $00, $00, $00, $06, $06, $07, $08, script_003d, $0000 ;; 03:501a NPC_SHADOW_KNIGHT_FAST

; Added so they can have different color palettes than Willy.
    NPC_DATA $81, $5e, $60, $02, gfxNpcWilly, tileorderNpc, metaspritesWilly, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_0256, $0000 ;; 03:6872 NPC_HASIM
    NPC_DATA $81, $5e, $60, $02, gfxNpcWilly, tileorderNpc, metaspritesWilly, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_01e7, $0000 ;; 03:6872 NPC_HURT_WENDEL

; Chests for use by enemy drops to allow use of the dropping enemy's color palette.
    NPC_DATA $87, $0c, $78, $02, gfxChest, tileorderNpc, chest1MetaspriteTable, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_000b, $0000 ;; 03:607a NPC_CHEST_DROP_1
    NPC_DATA $87, $0d, $78, $02, gfxChest, tileorderNpc, chest2MetaspriteTable, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_000f, $0000 ;; 03:6092 NPC_CHEST_DROP_2
    NPC_DATA $87, $0e, $78, $02, gfxChest, tileorderNpc, chest3MetaspriteTable, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, script_0013, $0000 ;; 03:60aa NPC_CHEST_DROP_3
    NPC_DATA $a9, $00, $7c, $02, gfxChest, tileorderOpenChest, chestEmpty1MetaspriteTable, $00, $00, $00, $00, $00, $00, $19, $19, $19, $19, script_003d, $0000 ;; 03:60c2 NPC_CHEST_DROP_EMPTY_1
    NPC_DATA $a9, $00, $7c, $02, gfxChest, tileorderOpenChest, chestEmpty2MetaspriteTable, $00, $00, $00, $00, $00, $00, $19, $19, $19, $19, script_003d, $0000 ;; 03:60c2 NPC_CHEST_DROP_EMPTY_2
    NPC_DATA $a9, $00, $7c, $02, gfxChest, tileorderOpenChest, chestEmpty3MetaspriteTable, $00, $00, $00, $00, $00, $00, $19, $19, $19, $19, script_003d, $0000 ;; 03:60c2 NPC_CHEST_DROP_EMPTY_3
