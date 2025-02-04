;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"
INCLUDE "include/oam_attributes.inc"

SECTION "bank02", ROMX[$4000], BANK[$02]

;@call_to_bank_jumptable amount=58
entryPointTableBank02:
ds 2 ; Unused trampoline target
ds 2 ; Unused trampoline target
    call_to_bank_target spriteShuffleDoFlash           ;; 02:4004 pP
    call_to_bank_target spriteShuffleShowHidden        ;; 02:4006 pP
    call_to_bank_target hideSpritesBehindWindow        ;; 02:4008 pP
    call_to_bank_target showSpritesBehindWindow        ;; 02:400a pP
    call_to_bank_target scrollMoveSprites              ;; 02:400c pP
    call_to_bank_target checkNpcsForCollisions         ;; 02:400e pP
    call_to_bank_target hideAndSaveMenuMetasprites     ;; 02:4010 pP
    call_to_bank_target showMenuFingerPointing_1       ;; 02:4012 ??
    call_to_bank_target menuTrashCanLoadTiles          ;; 02:4014 ??
    call_to_bank_target call_02_67f9                   ;; 02:4016 ??
    call_to_bank_target loadRegisterState1             ;; 02:4018 ??
    call_to_bank_target loadRegisterState2             ;; 02:401a pP
    call_to_bank_target windowInitContents             ;; 02:401c pP
    call_to_bank_target indexIntoTable                 ;; 02:401e ??
    call_to_bank_target saveRegisterState1             ;; 02:4020 ??
    call_to_bank_target saveRegisterState2             ;; 02:4022 pP
    call_to_bank_target gameStateMenu                  ;; 02:4024 pP
    call_to_bank_target windowCloseAndRestoreHidden    ;; 02:4026 pP
    call_to_bank_target drawWindow                     ;; 02:4028 pP
    call_to_bank_target windowMenuStartSpecial         ;; 02:402a pP
    call_to_bank_target windowPrintMenuText            ;; 02:402c ??
    call_to_bank_target initStartingStatsAndTimers     ;; 02:402e pP
    call_to_bank_target giveItem                       ;; 02:4030 pP
    call_to_bank_target giveMagic                      ;; 02:4032 ??
    call_to_bank_target giveEquipmentAndStorePowers    ;; 02:4034 ??
    call_to_bank_target removeItemFromInventory        ;; 02:4036 ??
    call_to_bank_target removeEquipmentFromInventory   ;; 02:4038 ??
    call_to_bank_target removeMagicFromInventory       ;; 02:403a ??
    call_to_bank_target getEquippedHelmElementalResistances ;; 02:403c pP
    call_to_bank_target getEquippedShieldBlockElements ;; 02:403e pP
    call_to_bank_target getEquippedWeaponBonusTypes    ;; 02:4040 pP
    call_to_bank_target getSpellOrBookPower            ;; 02:4042 ??
    call_to_bank_target showFullscreenWindow           ;; 02:4044 pP
    call_to_bank_target drawDefaultStatusBar           ;; 02:4046 ??
    call_to_bank_target drawHPOnStatusBar_2            ;; 02:4048 pP
    call_to_bank_target drawManaOnStatusBar_2          ;; 02:404a pP
    call_to_bank_target drawMoneyOnStatusBar           ;; 02:404c pP
    call_to_bank_target doSpellOrItemEffect            ;; 02:404e pP
ds 2 ; Unused trampoline target
    call_to_bank_target attackWithWeaponUseWill        ;; 02:4052 pP
    call_to_bank_target giveStatusEffect               ;; 02:4054 pP
ds 2 ; Unused trampoline target
    call_to_bank_target updateStatusEffects            ;; 02:4058 pP
    call_to_bank_target getSpellOffset0band0cinHL      ;; 02:405a ??
    call_to_bank_target drawWillBarCharge              ;; 02:405c pP
    call_to_bank_target drawEmptyWillBar               ;; 02:405e pP
    call_to_bank_target titleScreenInit                ;; 02:4060 pP
    call_to_bank_target gameStateTitleScreen           ;; 02:4062 pP
    call_to_bank_target castEquippedSpellIfSufficientMana ;; 02:4064 pP
    call_to_bank_target getScriptOpcodeFunction        ;; 02:4066 pP
    call_to_bank_target endPoisStatusEffect            ;; 02:4068 ??
    call_to_bank_target endDarkStatusEffect            ;; 02:406a ??
    call_to_bank_target endStonStatusEffect            ;; 02:406c ??
    call_to_bank_target endMoogStatusEffect            ;; 02:406e ??
    call_to_bank_target endFujiStatusEffect            ;; 02:4070 ??
    call_to_bank_target getEquippedArmorElementalResistances ;; 02:4072 pP

ds 464 ; Free space

; Given an object, check if it overlaps any of the Npc objects (objects 7 and up).
; Technically, this includes followers, non-player projectiles, and bosses as well.
; If a collision is found it stops searching, which may be the source of certain bugs.
; A = object collision flags
; C = object id
; DE = object yx location
; Return: A = unmodified if a collision is found, otherwise set to 0.
checkNpcsForCollisions:
    push AF                                            ;; 02:4244 $f5
    ld   B, C                                          ;; 02:4245 $41
    ld   C, $07                                        ;; 02:4246 $0e $07
    ld   A, C                                          ;; 02:4248 $79
    push DE                                            ;; 02:4249 $d5
    ld   DE, wObjectRuntimeData.npc1                   ;; 02:424a $11 $70 $c2
.loop:
    cp   A, B                                          ;; 02:424d $b8
    jr   Z, .next                                      ;; 02:424e $28 $44
    ld   A, [DE]                                       ;; 02:4250 $1a
    cp   A, $ff                                        ;; 02:4251 $fe $ff
    jr   Z, .next                                      ;; 02:4253 $28 $3f
    ld   HL, $04                                       ;; 02:4255 $21 $04 $00
    add  HL, DE                                        ;; 02:4258 $19
    ld   A, [HL]                                       ;; 02:4259 $7e
    pop  HL                                            ;; 02:425a $e1
    push HL                                            ;; 02:425b $e5
    sub  A, H                                          ;; 02:425c $94
    jr   NC, .jr_02_4261                               ;; 02:425d $30 $02
    cpl                                                ;; 02:425f $2f
    inc  A                                             ;; 02:4260 $3c
.jr_02_4261:
    ld   H, A                                          ;; 02:4261 $67
    cp   A, $10                                        ;; 02:4262 $fe $10
    jr   NC, .next                                     ;; 02:4264 $30 $2e
    push HL                                            ;; 02:4266 $e5
    ld   HL, $05                                       ;; 02:4267 $21 $05 $00
    add  HL, DE                                        ;; 02:426a $19
    ld   A, [HL]                                       ;; 02:426b $7e
    pop  HL                                            ;; 02:426c $e1
    sub  A, L                                          ;; 02:426d $95
    jr   NC, .jr_02_4272                               ;; 02:426e $30 $02
    cpl                                                ;; 02:4270 $2f
    inc  A                                             ;; 02:4271 $3c
.jr_02_4272:
    ld   L, A                                          ;; 02:4272 $6f
    cp   A, $10                                        ;; 02:4273 $fe $10
    jr   NC, .next                                     ;; 02:4275 $30 $1d
    push DE                                            ;; 02:4277 $d5
    push HL                                            ;; 02:4278 $e5
    pop  DE                                            ;; 02:4279 $d1
    push BC                                            ;; 02:427a $c5
    push DE                                            ;; 02:427b $d5
    ld   HL, SP+9                                      ;; 02:427c $f8 $09
    ld   A, [HL]                                       ;; 02:427e $7e
    call mainCollisionHandling                         ;; 02:427f $cd $a5 $42
    pop  HL                                            ;; 02:4282 $e1
    pop  BC                                            ;; 02:4283 $c1
    pop  DE                                            ;; 02:4284 $d1
    cp   A, $00                                        ;; 02:4285 $fe $00
    jr   Z, .next                                      ;; 02:4287 $28 $0b
    pop  DE                                            ;; 02:4289 $d1
    push HL                                            ;; 02:428a $e5
    push BC                                            ;; 02:428b $c5
    call getObjectCollisionFlags                       ;; 02:428c $cd $6d $0c
    pop  BC                                            ;; 02:428f $c1
    ld   B, A                                          ;; 02:4290 $47
    pop  DE                                            ;; 02:4291 $d1
    pop  AF                                            ;; 02:4292 $f1
    ret                                                ;; 02:4293 $c9
.next:
    ld   HL, $10                                       ;; 02:4294 $21 $10 $00
    add  HL, DE                                        ;; 02:4297 $19
    ld   D, H                                          ;; 02:4298 $54
    ld   E, L                                          ;; 02:4299 $5d
    inc  C                                             ;; 02:429a $0c
    ld   A, C                                          ;; 02:429b $79
    cp   A, $14                                        ;; 02:429c $fe $14
    jr   C, .loop                                      ;; 02:429e $38 $ad
    pop  HL                                            ;; 02:42a0 $e1
    pop  AF                                            ;; 02:42a1 $f1
    ld   A, $00                                        ;; 02:42a2 $3e $00
    ret                                                ;; 02:42a4 $c9

; Return: A = unmodified if a collision is found, otherwise set to 0.
mainCollisionHandling:
    push AF                                            ;; 02:42a5 $f5
    push BC                                            ;; 02:42a6 $c5
    push DE                                            ;; 02:42a7 $d5
    call getObjectCollisionFlags                       ;; 02:42a8 $cd $6d $0c
    pop  DE                                            ;; 02:42ab $d1
    pop  BC                                            ;; 02:42ac $c1
    and  A, $f0                                        ;; 02:42ad $e6 $f0
    cp   A, $c0                                        ;; 02:42af $fe $c0
    jr   Z, .player                                    ;; 02:42b1 $28 $2c
    cp   A, $40                                        ;; 02:42b3 $fe $40
    jr   Z, .playerOrFollowerAttack                    ;; 02:42b5 $28 $2d
    cp   A, $50                                        ;; 02:42b7 $fe $50
    jr   Z, .playerOrFollowerAttack                    ;; 02:42b9 $28 $29
    cp   A, $30                                        ;; 02:42bb $fe $30
    jr   Z, .playerOrFollowerAttack                    ;; 02:42bd $28 $25
    cp   A, $a0                                        ;; 02:42bf $fe $a0
    jr   Z, .pushable                                  ;; 02:42c1 $28 $30
    cp   A, $b0                                        ;; 02:42c3 $fe $b0
    jr   Z, .pushable                                  ;; 02:42c5 $28 $2c
    cp   A, $80                                        ;; 02:42c7 $fe $80
    jr   Z, .npcScriptOnTouch                          ;; 02:42c9 $28 $1e
    cp   A, $90                                        ;; 02:42cb $fe $90
    jr   Z, .npcDamageOnTouch                          ;; 02:42cd $28 $1f
    cp   A, $60                                        ;; 02:42cf $fe $60
    jr   Z, .enemyProjectile                           ;; 02:42d1 $28 $25
    cp   A, $70                                        ;; 02:42d3 $fe $70
    jr   Z, .enemyProjectile                           ;; 02:42d5 $28 $21
    cp   A, $20                                        ;; 02:42d7 $fe $20
    jr   Z, .boss                                      ;; 02:42d9 $28 $22
    pop  AF                                            ;; 02:42db $f1
    xor a
    ret                                                ;; 02:42de $c9
.player:
    pop  AF                                            ;; 02:42df $f1
    and a, $f0
    cp $d0
    ret z
    xor a
    ret                                                ;; 02:42e3 $c9
.playerOrFollowerAttack:
    pop  AF                                            ;; 02:42e4 $f1
    xor a
    ret                                                ;; 02:42e8 $c9
.npcScriptOnTouch:
    pop  AF                                            ;; 02:42e9 $f1
    call friendlyCollisionHandling_trampoline          ;; 02:42ea $cd $4d $28
    ret                                                ;; 02:42ed $c9
.npcDamageOnTouch:
    pop  AF                                            ;; 02:42ee $f1
    call enemyCollisionHandling_trampoline             ;; 02:42ef $cd $b6 $28
    ret                                                ;; 02:42f2 $c9
.pushable:
    pop  AF                                            ;; 02:42f3 $f1
    call pushableCollisionHandling                     ;; 02:42f4 $cd $22 $2d
    ret                                                ;; 02:42f7 $c9
.enemyProjectile:
    pop  AF                                            ;; 02:42f8 $f1
    call projectileCollisionHandling_trampoline        ;; 02:42f9 $cd $03 $2c
    ret                                                ;; 02:42fc $c9
.boss:
    pop  AF                                            ;; 02:42fd $f1
    call bossCollisionHandling_trampoline              ;; 02:42fe $cd $11 $05
    ret                                                ;; 02:4301 $c9

processPhysicsForObjectDependingOnCollisionFlags:
    ld   B, A                                          ;; 02:4302 $47
    push BC                                            ;; 02:4303 $c5
    call getObjectCollisionFlags                       ;; 02:4304 $cd $6d $0c
    pop  BC                                            ;; 02:4307 $c1
    and  A, $f0                                        ;; 02:4308 $e6 $f0
    cp   A, $c0                                        ;; 02:430a $fe $c0
    jr   Z, .player                                    ;; 02:430c $28 $3b
    cp   A, $e0                                        ;; 02:430e $fe $e0
    jr   Z, .player                                    ;; 02:4310 $28 $37
    cp   A, $f0                                        ;; 02:4312 $fe $f0
    jr   Z, .player                                    ;; 02:4314 $28 $33
    cp   A, $40                                        ;; 02:4316 $fe $40
    jr   Z, .player                                    ;; 02:4318 $28 $2f
    cp   A, $50                                        ;; 02:431a $fe $50
    jr   Z, .player                                    ;; 02:431c $28 $2b
    cp   A, $a0                                        ;; 02:431e $fe $a0
    jr   Z, .npc                                       ;; 02:4320 $28 $20
    cp   A, $b0                                        ;; 02:4322 $fe $b0
    jr   Z, .npc                                       ;; 02:4324 $28 $1c
    cp   A, $80                                        ;; 02:4326 $fe $80
    jr   Z, .npc                                       ;; 02:4328 $28 $18
    cp   A, $90                                        ;; 02:432a $fe $90
    jr   Z, .npc                                       ;; 02:432c $28 $14
    cp   A, $10                                        ;; 02:432e $fe $10
    jr   Z, .npc                                       ;; 02:4330 $28 $10
    cp   A, $30                                        ;; 02:4332 $fe $30
    jr   Z, .projectile                                ;; 02:4334 $28 $1a
    cp   A, $60                                        ;; 02:4336 $fe $60
    jr   Z, .projectile                                ;; 02:4338 $28 $16
    cp   A, $70                                        ;; 02:433a $fe $70
    jr   Z, .projectile                                ;; 02:433c $28 $12
    cp   A, $20                                        ;; 02:433e $fe $20
    jr   Z, .boss                                      ;; 02:4340 $28 $15
.npc:
    ld   A, B                                          ;; 02:4342 $78
    ld   B, $00                                        ;; 02:4343 $06 $00
    call processPhysicsForObject_3_trampoline          ;; 02:4345 $cd $d7 $27
    ret                                                ;; 02:4348 $c9
.player:
    ld   A, B                                          ;; 02:4349 $78
    ld   B, $00                                        ;; 02:434a $06 $00
    call processPhysicsForPlayer_trampoline            ;; 02:434c $cd $38 $02
    ret                                                ;; 02:434f $c9
.projectile:
    ld   A, B                                          ;; 02:4350 $78
    ld   B, $00                                        ;; 02:4351 $06 $00
    call processPhysicsForObject_9_trampoline          ;; 02:4353 $cd $d7 $2b
    ret                                                ;; 02:4356 $c9
.boss:
    ld   A, B                                          ;; 02:4357 $78
    ld   B, $00                                        ;; 02:4358 $06 $00
    call processPhysicsForObject_4_trampoline          ;; 02:435a $cd $17 $05
    ret                                                ;; 02:435d $c9

; Move objects with screenscroll. Destroy those that fall behind.
; Enemies and NPCs are meant to be left behind but jumpers can survive the scroll.
; A = top: $b, bottom: scrolling direction
; B = room scroll sprite speed
; C = object ID
scrollMoveObject:
    push AF                                            ;; 02:435e $f5
; Reset bit 7 of the object's direction, which is set if it is moving off grid.
    push BC                                            ;; 02:435f $c5
    call getObjectDirection                            ;; 02:4360 $cd $99 $0c
    cp   A, $ff                                        ;; 02:4363 $fe $ff
    jr   Z, .move                                      ;; 02:4365 $28 $5f
    pop  BC                                            ;; 02:4367 $c1
    push BC                                            ;; 02:4368 $c5
    and  A, $7f                                        ;; 02:4369 $e6 $7f
    call setObjectDirection                            ;; 02:436b $cd $a6 $0c
    pop  BC                                            ;; 02:436e $c1
; Set the object's speed so it keeps up with the room scroll.
    push BC                                            ;; 02:436f $c5
    ld   A, B                                          ;; 02:4370 $78
    cp   A, $00                                        ;; 02:4371 $fe $00
    jr   Z, .jr_02_437a                                ;; 02:4373 $28 $05
    call setObjectSpeed                                ;; 02:4375 $cd $5d $0c
    set  7, A                                          ;; 02:4378 $cb $ff
.jr_02_437a:
    pop  BC                                            ;; 02:437a $c1
    ld   B, A                                          ;; 02:437b $47
    pop  AF                                            ;; 02:437c $f1
    push AF                                            ;; 02:437d $f5
    push BC                                            ;; 02:437e $c5
    call processPhysicsForObjectDependingOnCollisionFlags ;; 02:437f $cd $02 $43
    pop  BC                                            ;; 02:4382 $c1
    push BC                                            ;; 02:4383 $c5
    ld   A, B                                          ;; 02:4384 $78
    cp   A, $00                                        ;; 02:4385 $fe $00
    jr   Z, .jr_02_438e                                ;; 02:4387 $28 $05
    res  7, A                                          ;; 02:4389 $cb $bf
    call setObjectSpeed                                ;; 02:438b $cd $5d $0c
.jr_02_438e:
    pop  BC                                            ;; 02:438e $c1
    ld   B, A                                          ;; 02:438f $47
    push BC                                            ;; 02:4390 $c5
    call GetObjectX                                    ;; 02:4391 $cd $2d $0c
    cp   A, SCRN_X + 1                                 ;; 02:4394 $fe $a1
    jr   NC, .offscreen                                ;; 02:4396 $30 $12
    pop  BC                                            ;; 02:4398 $c1
    push BC                                            ;; 02:4399 $c5
    call GetObjectY                                    ;; 02:439a $cd $3e $0c
    sub  A, $08                                        ;; 02:439d $d6 $08
    ld   D, A                                          ;; 02:439f $57
    ld   A, [wRoomHeightInTiles]                       ;; 02:43a0 $fa $40 $c3
    add  A, A                                          ;; 02:43a3 $87
    add  A, A                                          ;; 02:43a4 $87
    add  A, A                                          ;; 02:43a5 $87
    inc  A                                             ;; 02:43a6 $3c
    cp   A, D                                          ;; 02:43a7 $ba
    jr   NC, .move                                     ;; 02:43a8 $30 $1c
.offscreen:
    pop  BC                                            ;; 02:43aa $c1
    push BC                                            ;; 02:43ab $c5
    call getObjectCollisionFlags                       ;; 02:43ac $cd $6d $0c
    and  A, $f0                                        ;; 02:43af $e6 $f0
; More efficient branching to save space.
    cp a, $d0
    jr z, .follower
    and a, $c0
    cp a, $c0
    jr z, .move
    pop  BC                                            ;; 02:43c1 $c1
    push BC                                            ;; 02:43c2 $c5
    call destroyObject                                 ;; 02:43c3 $cd $e3 $0a
.move:
    pop  BC                                            ;; 02:43c6 $c1
    pop  AF                                            ;; 02:43c7 $f1
    ret                                                ;; 02:43c8 $c9
; Teleport to the player
.follower:
    call getPlayerY                                    ;; 02:43c9 $cd $99 $02
    ld   D, A                                          ;; 02:43cc $57
    push DE                                            ;; 02:43cd $d5
    call getPlayerX                                    ;; 02:43ce $cd $93 $02
    pop  DE                                            ;; 02:43d1 $d1
    ld   E, A                                          ;; 02:43d2 $5f
    pop  BC                                            ;; 02:43d3 $c1
    pop  AF                                            ;; 02:43d4 $f1
    push AF                                            ;; 02:43d5 $f5
    push BC                                            ;; 02:43d6 $c5
    call updateObjectPosition                          ;; 02:43d7 $cd $11 $06
    jr .move

ds 4 ; Free space

; Manages objects during the screen scroll transition.
; Enemies and NPCs are meant to be left behind but jumpers can survive the scroll, which is a bug.
; A = top: $b, bottom: scrolling direction
scrollMoveSprites:
    ld b, ROOM_SCROLL_SPEED
    ld   C, $04                                        ;; 02:43e2 $0e $04
    call scrollMoveObject                              ;; 02:43e5 $cd $5e $43
    push AF                                            ;; 02:43e8 $f5
    ld   C, $07                                        ;; 02:43e9 $0e $07

; Fix a subtle bug:
;  When the player is in chocobo form and the screen is scrolling, the chocobo follower would be shown under the player.
    ld a, [wOAMBuffer+$38] ; Y position of your follower. If you are riding your chocobo this will be 0.
    or a
    jr nz, .loop
    inc c

.loop:
    pop  AF                                            ;; 02:43eb $f1
    call scrollMoveObject                              ;; 02:43ec $cd $5e $43
    push AF                                            ;; 02:43ef $f5
    inc  C                                             ;; 02:43f0 $0c
    ld   A, C                                          ;; 02:43f1 $79
    cp   A, $14                                        ;; 02:43f2 $fe $14
    jr   NZ, .loop                                     ;; 02:43f4 $20 $f5
    pop  AF                                            ;; 02:43f6 $f1
    ret                                                ;; 02:43f7 $c9

; DE = window yx tile coordinate
; HL = window yx tile dimensions (minus one)
; Return: Pixel coordinates, BC = right+8,left+1, DE = bottom+16,top+1
windowBorderConvertToPixelCoords:
    sla  D                                             ;; 02:43f8 $cb $22
    sla  D                                             ;; 02:43fa $cb $22
    sla  D                                             ;; 02:43fc $cb $22
    sla  E                                             ;; 02:43fe $cb $23
    sla  E                                             ;; 02:4400 $cb $23
    sla  E                                             ;; 02:4402 $cb $23
    sla  H                                             ;; 02:4404 $cb $24
    sla  H                                             ;; 02:4406 $cb $24
    sla  H                                             ;; 02:4408 $cb $24
    sla  L                                             ;; 02:440a $cb $25
    sla  L                                             ;; 02:440c $cb $25
    sla  L                                             ;; 02:440e $cb $25
    ld   C, E                                          ;; 02:4410 $4b
    inc  C                                             ;; 02:4411 $0c
    ld   A, E                                          ;; 02:4412 $7b
    add  A, L                                          ;; 02:4413 $85
    add  A, $08                                        ;; 02:4414 $c6 $08
    ld   B, A                                          ;; 02:4416 $47
    ld   E, D                                          ;; 02:4417 $5a
    inc  E                                             ;; 02:4418 $1c
    ld   A, D                                          ;; 02:4419 $7a
    add  A, H                                          ;; 02:441a $84
    add  A, $10                                        ;; 02:441b $c6 $10
    ld   D, A                                          ;; 02:441d $57
    ret                                                ;; 02:441e $c9

checkSpriteXBetweenCAndB:
    inc  HL                                            ;; 02:441f $23
    ld   A, [HL-]                                      ;; 02:4420 $3a
    cp   A, C                                          ;; 02:4421 $b9
    jr   C, .outside_bounds                            ;; 02:4422 $38 $05
    cp   A, B                                          ;; 02:4424 $b8
    jr   NC, .outside_bounds                           ;; 02:4425 $30 $02
    or   A, A                                          ;; 02:4427 $b7
    ret                                                ;; 02:4428 $c9
.outside_bounds:
    xor  A, A                                          ;; 02:4429 $af
    ret                                                ;; 02:442a $c9

hideSpritesBehindWindow:
    ld   A, D                                          ;; 02:442b $7a
    cp   A, $12                                        ;; 02:442c $fe $12
    ret  NC                                            ;; 02:442e $d0
    ld   A, E                                          ;; 02:442f $7b
    cp   A, $14                                        ;; 02:4430 $fe $14
    ret  NC                                            ;; 02:4432 $d0
    call windowBorderConvertToPixelCoords              ;; 02:4433 $cd $f8 $43
    push BC                                            ;; 02:4436 $c5
    ld   HL, wOAMBuffer                                ;; 02:4437 $21 $00 $c0
    ld   B, $28                                        ;; 02:443a $06 $28
.loop:
    ld   A, [HL]                                       ;; 02:443c $7e
    cp   A, E                                          ;; 02:443d $bb
    jr   C, .jr_02_4460                                ;; 02:443e $38 $20
    cp   A, D                                          ;; 02:4440 $ba
    jr   NC, .jr_02_4460                               ;; 02:4441 $30 $1d
    ld   A, B                                          ;; 02:4443 $78
    pop  BC                                            ;; 02:4444 $c1
    push AF                                            ;; 02:4445 $f5
    push DE                                            ;; 02:4446 $d5
    call checkSpriteXBetweenCAndB                      ;; 02:4447 $cd $1f $44
    jr   Z, .jr_02_445c                                ;; 02:444a $28 $10
    ld   A, [HL]                                       ;; 02:444c $7e
    ld   [HL], $cf                                     ;; 02:444d $36 $cf
    push HL                                            ;; 02:444f $e5
    srl  L                                             ;; 02:4450 $cb $3d
    srl  L                                             ;; 02:4452 $cb $3d
    ld   H, $00                                        ;; 02:4454 $26 $00
    ld   DE, hiddenSpritesYPositions                   ;; 02:4456 $11 $a2 $c4
    add  HL, DE                                        ;; 02:4459 $19
    ld   [HL], A                                       ;; 02:445a $77
    pop  HL                                            ;; 02:445b $e1
.jr_02_445c:
    pop  DE                                            ;; 02:445c $d1
    pop  AF                                            ;; 02:445d $f1
    push BC                                            ;; 02:445e $c5
    ld   B, A                                          ;; 02:445f $47
.jr_02_4460:
    ld   A, $04                                        ;; 02:4460 $3e $04
    add  A, L                                          ;; 02:4462 $85
    ld   L, A                                          ;; 02:4463 $6f
    dec  B                                             ;; 02:4464 $05
    jr   NZ, .loop                                     ;; 02:4465 $20 $d5
    pop  BC                                            ;; 02:4467 $c1
    ret                                                ;; 02:4468 $c9

showSpritesBehindWindow:
    ld   A, D                                          ;; 02:4469 $7a
    cp   A, $12                                        ;; 02:446a $fe $12
    ret  NC                                            ;; 02:446c $d0
    ld   A, E                                          ;; 02:446d $7b
    cp   A, $14                                        ;; 02:446e $fe $14
    ret  NC                                            ;; 02:4470 $d0
    call windowBorderConvertToPixelCoords              ;; 02:4471 $cd $f8 $43
    push BC                                            ;; 02:4474 $c5
    ld   HL, hiddenSpritesYPositions                   ;; 02:4475 $21 $a2 $c4
    ld   B, $28                                        ;; 02:4478 $06 $28
.loop:
    ld   A, [HL+]                                      ;; 02:447a $2a
    cp   A, E                                          ;; 02:447b $bb
    jr   C, .jr_02_44ac                                ;; 02:447c $38 $2e
    cp   A, D                                          ;; 02:447e $ba
    jr   NC, .jr_02_44ac                               ;; 02:447f $30 $2b
    ld   A, B                                          ;; 02:4481 $78
    pop  BC                                            ;; 02:4482 $c1
    push AF                                            ;; 02:4483 $f5
    push DE                                            ;; 02:4484 $d5
    dec  HL                                            ;; 02:4485 $2b
    push HL                                            ;; 02:4486 $e5
    push BC                                            ;; 02:4487 $c5
    ld   DE, hiddenSpritesYPositions                   ;; 02:4488 $11 $a2 $c4
    call sub_HL_DE                                     ;; 02:448b $cd $ab $2b
    pop  BC                                            ;; 02:448e $c1
    sla  L                                             ;; 02:448f $cb $25
    sla  L                                             ;; 02:4491 $cb $25
    ld   H, $c0                                        ;; 02:4493 $26 $c0
    ld   A, [HL]                                       ;; 02:4495 $7e
    cp   A, $cf                                        ;; 02:4496 $fe $cf
    jr   NZ, .jr_02_44a6                               ;; 02:4498 $20 $0c
    call checkSpriteXBetweenCAndB                      ;; 02:449a $cd $1f $44
    jr   Z, .jr_02_44a6                                ;; 02:449d $28 $07
    pop  DE                                            ;; 02:449f $d1
    push DE                                            ;; 02:44a0 $d5
    ld   A, [DE]                                       ;; 02:44a1 $1a
    ld   [HL], A                                       ;; 02:44a2 $77
    ld   A, $00                                        ;; 02:44a3 $3e $00
    ld   [DE], A                                       ;; 02:44a5 $12
.jr_02_44a6:
    pop  HL                                            ;; 02:44a6 $e1
    inc  HL                                            ;; 02:44a7 $23
    pop  DE                                            ;; 02:44a8 $d1
    pop  AF                                            ;; 02:44a9 $f1
    push BC                                            ;; 02:44aa $c5
    ld   B, A                                          ;; 02:44ab $47
.jr_02_44ac:
    dec  B                                             ;; 02:44ac $05
    jr   NZ, .loop                                     ;; 02:44ad $20 $cb
    pop  BC                                            ;; 02:44af $c1
    ret                                                ;; 02:44b0 $c9

; HL = shadow OAM address of the sprite's y position.
spriteShuffleShowSprite:
    push AF                                            ;; 02:44b1 $f5
    push DE                                            ;; 02:44b2 $d5
    push HL                                            ;; 02:44b3 $e5
    srl  L                                             ;; 02:44b4 $cb $3d
    srl  L                                             ;; 02:44b6 $cb $3d
    ld   H, $00                                        ;; 02:44b8 $26 $00
    ld   DE, hiddenSpritesYPositions                   ;; 02:44ba $11 $a2 $c4
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
    ld   DE, hiddenSpritesYPositions                   ;; 02:44f3 $11 $a2 $c4
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

ds 5 ; Free space

getScriptOpcodeFunction:
    ld   A, [wScriptCommand]                           ;; 02:4567 $fa $5a $d8
    ld   C, A                                          ;; 02:456a $4f
    ld   B, $00                                        ;; 02:456b $06 $00
    ld   HL, scriptOpcodeTable                         ;; 02:456d $21 $76 $45
    add  HL, BC                                        ;; 02:4570 $09
    add  HL, BC                                        ;; 02:4571 $09
    ld   A, [HL+]                                      ;; 02:4572 $2a
    ld   H, [HL]                                       ;; 02:4573 $66
    ld   L, A                                          ;; 02:4574 $6f
    ret                                                ;; 02:4575 $c9

INCLUDE "code/script/opcodetable.asm"

menuTrashCanLoadTiles:
    ld   A, [wWindowSecondaryFlags]                    ;; 02:4776 $fa $72 $d8
    bit  2, A                                          ;; 02:4779 $cb $57
    ret  NZ                                            ;; 02:477b $c0
    set  2, A                                          ;; 02:477c $cb $d7
    ld   [wWindowSecondaryFlags], A                    ;; 02:477e $ea $72 $d8
    push HL                                            ;; 02:4781 $e5
    ld   HL, menuTrashCanTileLoads                     ;; 02:4782 $21 $b8 $47
    ld   B, $04                                        ;; 02:4785 $06 $04
    ld   A, BANK(trashcanGfx)                          ;; 02:4787 $3e $0b
    call menuLoadTiles                                 ;; 02:4789 $cd $8e $47
    pop  HL                                            ;; 02:478c $e1
    ret                                                ;; 02:478d $c9

; Used only for the trash can tiles
menuLoadTiles:
    push AF                                            ;; 02:478e $f5
    push BC                                            ;; 02:478f $c5
    push DE                                            ;; 02:4790 $d5
    push HL                                            ;; 02:4791 $e5
    call clearPlayerAnimation                          ;; 02:4792 $cd $30 $1a
    pop  HL                                            ;; 02:4795 $e1
    pop  DE                                            ;; 02:4796 $d1
    pop  BC                                            ;; 02:4797 $c1
    pop  AF                                            ;; 02:4798 $f1
.loop:
    push BC                                            ;; 02:4799 $c5
    push AF                                            ;; 02:479a $f5
    ld   E, [HL]                                       ;; 02:479b $5e
    inc  HL                                            ;; 02:479c $23
    ld   D, [HL]                                       ;; 02:479d $56
    inc  HL                                            ;; 02:479e $23
    ld   C, [HL]                                       ;; 02:479f $4e
    inc  HL                                            ;; 02:47a0 $23
    ld   B, [HL]                                       ;; 02:47a1 $46
    inc  HL                                            ;; 02:47a2 $23
    pop  AF                                            ;; 02:47a3 $f1
    push HL                                            ;; 02:47a4 $e5
    ld   H, B                                          ;; 02:47a5 $60
    ld   L, C                                          ;; 02:47a6 $69
    push AF                                            ;; 02:47a7 $f5
    call addTileGraphicCopyRequest                     ;; 02:47a8 $cd $f5 $2d
    pop  AF                                            ;; 02:47ab $f1
    pop  HL                                            ;; 02:47ac $e1
    pop  BC                                            ;; 02:47ad $c1
    dec  B                                             ;; 02:47ae $05
    jr   NZ, .loop                                     ;; 02:47af $20 $e8
    ret                                                ;; 02:47b1 $c9

menuTrashCanTiles:
    db   $0c, $0e                                      ;; 02:47b2 ..

menuFingerPointingTiles:
    db   $12, $14                                      ;; 02:47b4 ..

menuFingerCurledTiles:
    db   $12, $16                                      ;; 02:47b6 ..

;@data format=pp amount=4
menuTrashCanTileLoads:
    dw   _VRAM8000+$c0, trashcanGfx
    dw   _VRAM8000+$d0, trashcanGfx+$20
    dw   _VRAM8000+$e0, trashcanGfx+$10
    dw   _VRAM8000+$f0, trashcanGfx+$30

;@jumptable amount=59
gameStateMenuJumptable:
    dw   windowInitMenu                                ;; 02:47c8 pP $00
    dw   windowInitMain                                ;; 02:47ca pP $01
    dw   windowInitAdjustments                         ;; 02:47cc pP $02
    dw   windowMenuIdle                                ;; 02:47ce pP $03
    dw   call_02_4ae4                                  ;; 02:47d0 pP $04
    dw   call_02_4c0e                                  ;; 02:47d2 pP $05
    dw   call_02_4c53                                  ;; 02:47d4 pP $06
    dw   call_02_4c64                                  ;; 02:47d6 pP $07
    dw   call_02_4cf7                                  ;; 02:47d8 pP $08
    dw   call_02_4c9a                                  ;; 02:47da ?? $09
    dw   call_02_4cc7                                  ;; 02:47dc ?? $0a
    dw   call_02_4d36                                  ;; 02:47de pP $0b
    dw   call_02_4d89                                  ;; 02:47e0 pP $0c
    dw   swapActiveEquipment                           ;; 02:47e2 pP $0d
    dw   call_02_4e5b                                  ;; 02:47e4 pP $0e
    dw   call_02_4e7b                                  ;; 02:47e6 pP $0f
    dw   call_02_4b7b                                  ;; 02:47e8 pP $10
    dw   call_02_5709                                  ;; 02:47ea pP $11
    dw   call_02_57a0                                  ;; 02:47ec pP $12
    dw   windowInitExistingFrame                       ;; 02:47ee pP $13
    dw   call_02_4e14                                  ;; 02:47f0 pP $14
    dw   call_02_4fe8                                  ;; 02:47f2 ?? $15
    dw   call_02_4e37                                  ;; 02:47f4 pP $16
    dw   call_02_5895                                  ;; 02:47f6 pP $17
    dw   windowPrintMenuText                           ;; 02:47f8 pP $18
    dw   call_02_4aa2                                  ;; 02:47fa ?? $19
    dw   call_02_4c79                                  ;; 02:47fc ?? $1a
    dw   call_02_4a14                                  ;; 02:47fe pP $1b
    dw   call_02_4da4                                  ;; 02:4800 pP $1c
    dw   call_02_4d77                                  ;; 02:4802 ?? $1d
    dw   windowClearRectangle                          ;; 02:4804 ?? $1e
    dw   call_02_5880                                  ;; 02:4806 ?? $1f
    dw   call_02_4b4b                                  ;; 02:4808 pP $20
    dw   call_02_4b72                                  ;; 02:480a pP $21
    dw   call_02_4b2e                                  ;; 02:480c pP $22
    dw   windowDismiss                                 ;; 02:480e pP $23
    dw   windowVendorShowBuyMessageWindow              ;; 02:4810 pP $24
    dw   windowVendorShowBuyMessage                    ;; 02:4812 pP $25
    dw   windowVendorBuyWaitAnyButton                  ;; 02:4814 pP $26
    dw   windowVendorCantCarryOpen                     ;; 02:4816 ?? $27
    dw   windowVendorCantCarryShowText                 ;; 02:4818 ?? $28
    dw   windowVendorCantCarryWaitAnyButton            ;; 02:481a ?? $29
    dw   windowInitMoreWindows                         ;; 02:481c pP $2a
    dw   call_02_498c                                  ;; 02:481e pP $2b
    dw   call_02_492b                                  ;; 02:4820 pP $2c
    dw   openStatusScreen                              ;; 02:4822 pP $2d
    dw   call_02_504f                                  ;; 02:4824 pP $2e
    dw   levelUpDrawPreviewAPDP                        ;; 02:4826 pP $2f
    dw   levelUpDrawPreviewStatsAndYesNoWindow         ;; 02:4828 pP $30
    dw   call_02_4cba                                  ;; 02:482a ?? $31
    dw   call_02_5292                                  ;; 02:482c pP $32
    dw   openLoadSaveBottomWindow                      ;; 02:482e pP $33
    dw   openSaveScreen                                ;; 02:4830 pP $34
    dw   openLoadScreen                                ;; 02:4832 ?? $35
    dw   runMinimapScript                              ;; 02:4834 pP $36
    dw   openLevelUpStatusScreen                       ;; 02:4836 pP $37
    dw   windowOpenStatusEffectInflicted               ;; 02:4838 ?? $38
    dw   windowStatusEffectInflictedDrawStatus         ;; 02:483a ?? $39
    dw   windowCloseStatusEffectInflicted              ;; 02:483c ?? $3a

; Used by START, SELECT, and leveling up
; a = window number
windowMenuStartSpecial:
    ld   B, A                                          ;; 02:483e $47
    ld   A, [wMainGameStateFlags]                      ;; 02:483f $fa $a1 $c0
    bit  1, A                                          ;; 02:4842 $cb $4f
    ret  NZ                                            ;; 02:4844 $c0
    ld   A, B                                          ;; 02:4845 $78
    ld   [wDialogType], A                              ;; 02:4846 $ea $4a $d8
    call copyStatsToLevelUpTmp                         ;; 02:4849 $cd $0b $6d
    call pauseTimers                                   ;; 02:484c $cd $e7 $79
    ld   A, [wMainGameState]                           ;; 02:484f $fa $a0 $c0
    ld   [wWindowMainGameStateBackup], A               ;; 02:4852 $ea $62 $d8
    ld   A, $00                                        ;; 02:4855 $3e $00
    ld   [wMenuStateCurrentFunction], A                ;; 02:4857 $ea $53 $d8
    ld   A, $0f                                        ;; 02:485a $3e $0f
    ld   [wMainGameState], A                           ;; 02:485c $ea $a0 $c0
    ret                                                ;; 02:485f $c9

gameStateMenu:
.loop:
    ld   HL, gameStateMenuJumptable                    ;; 02:4860 $21 $c8 $47
    ld   A, [wMenuStateCurrentFunction]                ;; 02:4863 $fa $53 $d8
    and  A, $7f                                        ;; 02:4866 $e6 $7f
    call callJumptable
; Check if there's time to run another step.
    ldh a, [rLY]
    cp $60
    ret nc
    ld a, [wMenuStateCurrentFunction]
    and a, $7f
; $17 and $18 are used to draw menu text.
    cp $17
    jr z, .loop
    cp $18
    jr z, .loop
    ret                                                ;; 02:4873 $c9

; The repeat delay was originally initialized to 1 so there was no initial delay,
; but changes to speed up windows made it too easy to make a mistake.
; For instance, the Yes/No choice window was easy to accidentally select Yes.
windowInitMenu:
    ld   a, $07
    ld   [wMenuSelectionMoveRepeatDelay], A            ;; 02:4880 $ea $57 $d8
    ld hl, wMenuStateCurrentFunction
    inc [hl]
    ret                                                ;; 02:4888 $c9

ds 1 ; Free space

windowInitMain:
    ld   HL, wEquippedItemAndWeaponCopy                ;; 02:4889 $21 $f1 $d6
    ld   A, [wEquippedItem]                            ;; 02:488c $fa $ef $d6
    ld   [HL+], A                                      ;; 02:488f $22
    ld   A, [wEquippedWeapon]                          ;; 02:4890 $fa $e9 $d6
    and  A, $7f                                        ;; 02:4893 $e6 $7f
    add  A, $41                                        ;; 02:4895 $c6 $41
    ld   [HL], A                                       ;; 02:4897 $77
    call drawWindow                                    ;; 02:489b $cd $00 $67
    ld   B, $13                                        ;; 02:489e $06 $13
    call setMenuStateCurrentFunction                   ;; 02:48a0 $cd $98 $6c
    ld   A, [wMenuStateCurrentFunction]                ;; 02:48a3 $fa $53 $d8
    and  A, $80                                        ;; 02:48a6 $e6 $80
    ret  NZ                                            ;; 02:48a8 $c0

windowInitExistingFrame:
    ld   A, [wDialogType]                              ;; 02:48a9 $fa $4a $d8
    push AF                                            ;; 02:48ac $f5
    call windowInitContents                            ;; 02:48ad $cd $93 $76
    pop  AF                                            ;; 02:48b0 $f1
    cp   A, WINDOW_SAVE_LOAD_FILE_1                    ;; 02:48b1 $fe $1b
    jr   Z, .saveload_top_window                       ;; 02:48b3 $28 $13
    cp   A, WINDOW_START_MENU_STATUS                   ;; 02:48b5 $fe $09
    jr   Z, start_menu_status_effect_window            ;; 02:48b7 $28 $1f
    cp   A, WINDOW_VENDOR_TEXT_TOP                     ;; 02:48b9 $fe $0f
    jr   Z, vendor_text_menu                           ;; 02:48bb $28 $22
    cp   A, WINDOW_NAMING_SCREEN_TOP                   ;; 02:48bd $fe $1d
    jr   Z, windowInitMoreWindows                      ;; 02:48bf $28 $2f
    cp   A, WINDOW_STATUS_SCREEN_RIGHT                 ;; 02:48c1 $fe $12
    jr   Z, windowInitMoreWindows                      ;; 02:48c3 $28 $2b
    jp   windowInitAdjustments                         ;; 02:48c5 $c3 $c7 $49
.saveload_top_window:
    ld   A, $33                                        ;; 02:48c8 $3e $33
    jp   jp_02_5877                                    ;; 02:48ca $c3 $77 $58

ds 3 ; Free space

openLoadSaveBottomWindow:
    ld   A, WINDOW_SAVE_LOAD_FILE_2                    ;; 02:48cd $3e $1c
    ld   [wDialogType], A                              ;; 02:48cf $ea $4a $d8
    ld   B, $01                                        ;; 02:48d2 $06 $01
    call setMenuStateCurrentFunction                   ;; 02:48d4 $cd $98 $6c
    ret                                                ;; 02:48d7 $c9

; Used to move the Start Menu status effect window's backup entry before the other windows are drawn.
; This window has been slightly enlarged to show longer status effect names.
; b = number of bytes to copy, four (for x,y,w,h) plus w*h (8*4).
; DE = where to move it to.
start_menu_status_effect_window:
    ld b, (4 + (8 * 4))
    ld   DE, wWindowBackgroundSaveBuffer + $0101       ;; 02:48da $11 $ac $d5
    jr   jr_02_48e4                                    ;; 02:48dd $18 $05

; Used to move the vendors' text window's backup entry before the other windows are drawn.
; b = number of bytes to copy, four (for x,y,w,h) plus w*h (20*10).
; There is a bug because the source area and the destination area overlap,
; but the backup seems to never be restored.
vendor_text_menu:
    ld   B, (4 + (20 * 10))                            ;; 02:48df $06 $cc
    ld   DE, wWindowBackgroundSaveBuffer.end - $cc - 1 ;; 02:48e1 $11 $46 $d5

jr_02_48e4:
    ld   HL, wDialogX                                  ;; 02:48e4 $21 $a7 $d4
    call copyHLtoDE                                    ;; 02:48e7 $cd $49 $2b
    ld   B, $2a                                        ;; 02:48ea $06 $2a
    call setMenuStateCurrentFunction                   ;; 02:48ec $cd $98 $6c
    ret                                                ;; 02:48ef $c9

windowInitMoreWindows:
    ld   A, [wDialogType]                              ;; 02:48f0 $fa $4a $d8
    ld   HL, window_list_start                         ;; 02:48f3 $21 $97 $49
    cp   A, WINDOW_START_MENU_STATUS                   ;; 02:48f6 $fe $09
    jr   Z, .load                                      ;; 02:48f8 $28 $17
    ld   HL, window_list_vendor                        ;; 02:48fa $21 $a3 $49
    cp   A, WINDOW_VENDOR_TEXT_TOP                     ;; 02:48fd $fe $0f
    jr   Z, .load                                      ;; 02:48ff $28 $10
    ld   HL, window_list_status                        ;; 02:4901 $21 $af $49
    cp   A, WINDOW_STATUS_SCREEN_RIGHT                 ;; 02:4904 $fe $12
    jr   Z, .load                                      ;; 02:4906 $28 $09
    ld   HL, window_list_naming                        ;; 02:4908 $21 $91 $49
    cp   A, WINDOW_NAMING_SCREEN_TOP                   ;; 02:490b $fe $1d
    jr   Z, .load                                      ;; 02:490d $28 $02
; Dead code. Never reached.
    jr   call_02_492b                                  ;; 02:490f $18 $1a
.load:
    ld   E, [HL]                                       ;; 02:4911 $5e
    inc  HL                                            ;; 02:4912 $23
    ld   D, [HL]                                       ;; 02:4913 $56
    inc  HL                                            ;; 02:4914 $23
    ld   A, H                                          ;; 02:4915 $7c
    ld   [wRegisterSave1.H], A                         ;; 02:4916 $ea $a3 $d8
    ld   A, L                                          ;; 02:4919 $7d
    ld   [wRegisterSave1], A                           ;; 02:491a $ea $a2 $d8
    ld   A, D                                          ;; 02:491d $7a
    ld   [wWindowSecondPointer.high], A                ;; 02:491e $ea $95 $d8
    ld   A, E                                          ;; 02:4921 $7b
    ld   [wWindowSecondPointer], A                     ;; 02:4922 $ea $94 $d8
    ld   B, $2b                                        ;; 02:4925 $06 $2b
    call setMenuStateCurrentFunction                   ;; 02:4927 $cd $98 $6c
    ret                                                ;; 02:492a $c9

call_02_492b:
    call loadRegisterState1                            ;; 02:492b $cd $5b $6d
    ld   A, [HL]                                       ;; 02:492e $7e
    ld   [wDialogType], A                              ;; 02:492f $ea $4a $d8
    push HL                                            ;; 02:4932 $e5
    call drawWindow                                    ;; 02:4933 $cd $00 $67
    pop  HL                                            ;; 02:4936 $e1
    call saveRegisterState1                            ;; 02:4937 $cd $34 $6d
    ld   A, [wMenuStateCurrentFunction]                ;; 02:493a $fa $53 $d8
    bit  7, A                                          ;; 02:493d $cb $7f
    ret  NZ                                            ;; 02:493f $c0
    push HL                                            ;; 02:4940 $e5
    ld   A, [wDialogType]                              ;; 02:4941 $fa $4a $d8
    call windowInitContents                            ;; 02:4944 $cd $93 $76
    pop  HL                                            ;; 02:4947 $e1
    inc  HL                                            ;; 02:4948 $23
    ld   A, [HL]                                       ;; 02:4949 $7e
    inc  A                                             ;; 02:494a $3c
    jp   NZ, .jp_02_4968                               ;; 02:494b $c2 $68 $49
    inc  HL                                            ;; 02:494e $23
    ld   A, [HL+]                                      ;; 02:494f $2a
    ld   H, [HL]                                       ;; 02:4950 $66
    ld   L, A                                          ;; 02:4951 $6f
    push HL                                            ;; 02:4952 $e5
    ld   A, [wDialogType]                              ;; 02:4953 $fa $4a $d8
    call windowInitContents                            ;; 02:4956 $cd $93 $76
    pop  HL                                            ;; 02:4959 $e1
    call saveRegisterState1                            ;; 02:495a $cd $34 $6d
    ld   A, H                                          ;; 02:495d $7c
    ld   [wWindowSecondPointer.high], A                ;; 02:495e $ea $95 $d8
    ld   A, L                                          ;; 02:4961 $7d
    ld   [wWindowSecondPointer], A                     ;; 02:4962 $ea $94 $d8
    jp   jp_02_49f7                                    ;; 02:4965 $c3 $f7 $49
.jp_02_4968:
    dec  A                                             ;; 02:4968 $3d
    ld   B, A                                          ;; 02:4969 $47
    inc  HL                                            ;; 02:496a $23
    ld   E, [HL]                                       ;; 02:496b $5e
    inc  HL                                            ;; 02:496c $23
    ld   D, [HL]                                       ;; 02:496d $56
    inc  HL                                            ;; 02:496e $23
    push HL                                            ;; 02:496f $e5
    ld   HL, wDialogX                                  ;; 02:4970 $21 $a7 $d4
    call copyHLtoDE                                    ;; 02:4973 $cd $49 $2b
    pop  HL                                            ;; 02:4976 $e1
    ld   E, [HL]                                       ;; 02:4977 $5e
    inc  HL                                            ;; 02:4978 $23
    ld   D, [HL]                                       ;; 02:4979 $56
    inc  HL                                            ;; 02:497a $23
    call saveRegisterState1                            ;; 02:497b $cd $34 $6d
    ld   A, D                                          ;; 02:497e $7a
    ld   [wWindowSecondPointer.high], A                ;; 02:497f $ea $95 $d8
    ld   A, E                                          ;; 02:4982 $7b
    ld   [wWindowSecondPointer], A                     ;; 02:4983 $ea $94 $d8
    ld   B, $2b                                        ;; 02:4986 $06 $2b
    call setMenuStateCurrentFunction                   ;; 02:4988 $cd $98 $6c
    ret                                                ;; 02:498b $c9

call_02_498c:
    ld   A, $2c                                        ;; 02:498c $3e $2c
    jp   jp_02_5877                                    ;; 02:498e $c3 $77 $58


; Lists are one or more entries with:
; offset 0: pointer to the menu options for the previous window.
; offset 2: window id to open
; offset 3: size of the window's backup record,
;           or $ff to indicate the final entry in the list,
;           or $01 if moving the backup record is not needed.
;           This code actually uses a copy routine that is safe to use for a zero length copy.
; offset 4: If not the final entry then the location to copy the backup record to,
;           else pointer to the menu options for this window.
window_list_naming:
    data_pbbp nameLabel, \                             ;; 02:4991 ......
              WINDOW_NAMING_SCREEN_BOTTOM, \
              $ff, \
              nameEntryInputOptions

window_list_start:
    data_pbbp statusEffectLabels, \                    ;; 02:4997 ....pP $00
              WINDOW_START_MENU_EQUIPPED, \
              $54, \ 
              wWindowBackgroundSaveBuffer + $0101 - $54
    data_pbbp wEquippedItemAndWeaponCopy, \            ;; 02:499d ...... $01
              WINDOW_START_MENU, \
              $ff, \
              startMenuOptions

window_list_vendor:
    data_pbbp venderGreetingText, \                    ;; 02:49a3 ....pP $00
              WINDOW_VENDOR_MONEY, \
              $01, \
              wWindowBackgroundSaveBuffer.end - 1
    data_pbbp $0000, \                                 ;; 02:49a9 ...... $01
              WINDOW_VENDOR_BUY_SELL_EXIT, \
              $ff, \
              vendorOptions

window_list_status:
    data_pbbp statusScreenStatLabels, \                ;; 02:49af ....pP $00
              WINDOW_STATUS_SCREEN_MONEY, \
              $01, \
              wWindowBackgroundSaveBuffer.end - 1
    data_pbbp $0000, \                                 ;; 02:49b5 ....pP $01
              WINDOW_STATUS_SCREEN_HP_MP, \
              $01, \
              wWindowBackgroundSaveBuffer.end - 1
    data_pbbp statusScreenHPLabel, \                   ;; 02:49bb ....pP $02
              WINDOW_STATUS_SCREEN_AP_DP, \
              $01, \
              wWindowBackgroundSaveBuffer.end - 1
    data_pbbp wStatusScreenAPDP, \                     ;; 02:49c1 ...... $03
              WINDOW_STATUS_SCREEN_TOP, \
              $ff, \
              $0000

windowInitAdjustments:
    ld   A, [wDialogType]                              ;; 02:49c7 $fa $4a $d8
    push AF                                            ;; 02:49ca $f5
    cp   A, WINDOW_EQUIP_BOTTOM                        ;; 02:49cb $fe $04
    call Z, windowEquipScreenSetBottomWindowActive     ;; 02:49cd $cc $b9 $57
    call windowInitContents                            ;; 02:49d0 $cd $93 $76
    call saveRegisterState2                            ;; 02:49d3 $cd $80 $6d
    pop  AF                                            ;; 02:49d6 $f1
    cp   A, WINDOW_SELECT_MENU                         ;; 02:49d7 $fe $11
    jr   NZ, .jr_02_49e8                               ;; 02:49d9 $20 $0d
    push AF                                            ;; 02:49db $f5
    ld   HL, selectMenuOptions                         ;; 02:49dc $21 $09 $7d
    ld   A, H                                          ;; 02:49df $7c
    ld   [wWindowSecondPointer.high], A                ;; 02:49e0 $ea $95 $d8
    ld   A, L                                          ;; 02:49e3 $7d
    ld   [wWindowSecondPointer], A                     ;; 02:49e4 $ea $94 $d8
    pop  AF                                            ;; 02:49e7 $f1
.jr_02_49e8:
    cp   A, WINDOW_EQUIP_TOP                           ;; 02:49e8 $fe $03
    jp   NZ, jp_02_49f7                                ;; 02:49ea $c2 $f7 $49
    ld   A, WINDOW_EQUIP_BOTTOM                        ;; 02:49ed $3e $04
    ld   [wDialogType], A                              ;; 02:49ef $ea $4a $d8
    ld   A, $02                                        ;; 02:49f2 $3e $02
    jp   jp_02_5877                                    ;; 02:49f4 $c3 $77 $58

jp_02_49f7:
    ld   A, $96                                        ;; 02:49f7 $3e $96
    ld   [wLevelUpFanfareDelay], A                     ;; 02:49f9 $ea $7f $d8
    ld   A, [wDialogType]                              ;; 02:49fc $fa $4a $d8
    cp   A, WINDOW_VENDOR_SELL_TOP                     ;; 02:49ff $fe $0d
    ld   A, $1b                                        ;; 02:4a01 $3e $1b
    jp   NZ, jp_02_5877                                ;; 02:4a03 $c2 $77 $58
    push AF                                            ;; 02:4a06 $f5
    ld   A, [wD8DA]                                    ;; 02:4a07 $fa $da $d8
    ld   [wD848], A                                    ;; 02:4a0a $ea $48 $d8
    ld   [wD846], A                                    ;; 02:4a0d $ea $46 $d8
    pop  AF                                            ;; 02:4a10 $f1
    jp   jp_02_5877                                    ;; 02:4a11 $c3 $77 $58

call_02_4a14:
    ld   A, [wDialogType]                              ;; 02:4a14 $fa $4a $d8
    cp   A, WINDOW_LEVELUP_FANFARE                     ;; 02:4a17 $fe $21
    jr   Z, .wait_music                                ;; 02:4a19 $28 $56
    ld   H, $01                                        ;; 02:4a1b $26 $01
    ld   DE, $400                                      ;; 02:4a1d $11 $00 $04
    cp   A, WINDOW_TITLE_SCREEN                        ;; 02:4a20 $fe $1f
    jr   Z, .jr_02_4a4c                                ;; 02:4a22 $28 $28
    cp   A, WINDOW_VENDOR_SELL_TOP                     ;; 02:4a24 $fe $0d
    jr   Z, .vendor_sell_menu_top                      ;; 02:4a26 $28 $10
    cp   A, WINDOW_SAVE_LOAD_FILE_1                    ;; 02:4a28 $fe $1b
    jr   NZ, .jr_02_4a53                               ;; 02:4a2a $20 $27
    ld   A, [wWindowSecondaryFlags]                    ;; 02:4a2c $fa $72 $d8
    bit  5, A                                          ;; 02:4a2f $cb $6f
    jr   Z, .jr_02_4a53                                ;; 02:4a31 $28 $20
    ld   DE, $a00                                      ;; 02:4a33 $11 $00 $0a
    jr   .jr_02_4a58                                   ;; 02:4a36 $18 $20
.vendor_sell_menu_top:
    ld   A, [wD8D9]                                    ;; 02:4a38 $fa $d9 $d8
    ld   [wD868], A                                    ;; 02:4a3b $ea $68 $d8
    ld   A, [wWindowVendorSellItemIndex]               ;; 02:4a3e $fa $76 $d8
    ld   H, A                                          ;; 02:4a41 $67
    ld   A, [wWindowVendorSellPointerSavedY]           ;; 02:4a42 $fa $d8 $d8
    ld   D, A                                          ;; 02:4a45 $57
    ld   A, [wWindowVendorSellPointerSavedX]           ;; 02:4a46 $fa $d7 $d8
    ld   E, A                                          ;; 02:4a49 $5f
    jr   .jr_02_4a58                                   ;; 02:4a4a $18 $0c
.jr_02_4a4c:
    ld   A, [wWindowFlags]                             ;; 02:4a4c $fa $74 $d8
    and  A, $18                                        ;; 02:4a4f $e6 $18
    jr   NZ, .jr_02_4a58                               ;; 02:4a51 $20 $05
.jr_02_4a53:
    ld   H, $00                                        ;; 02:4a53 $26 $00
    ld   DE, $200                                      ;; 02:4a55 $11 $00 $02
.jr_02_4a58:
    call showMenuFingerPointing_1                      ;; 02:4a58 $cd $be $6b
    call saveRegisterState1                            ;; 02:4a5b $cd $34 $6d
    ld   B, $03                                        ;; 02:4a5e $06 $03
    ld   A, B                                          ;; 02:4a60 $78
    call setMenuStateCurrentFunction                   ;; 02:4a61 $cd $98 $6c
    ld   A, [wDialogType]                              ;; 02:4a64 $fa $4a $d8
    cp   A, WINDOW_TITLE_SCREEN                        ;; 02:4a67 $fe $1f
    ret  NZ                                            ;; 02:4a69 $c0
    ld   HL, $0b                                       ;; 02:4a6a $21 $0b $00
    call runScriptByIndex                              ;; 02:4a6d $cd $ad $31
    ret                                                ;; 02:4a70 $c9
.wait_music:
    ld   HL, wLevelUpFanfareDelay                      ;; 02:4a71 $21 $7f $d8
    dec  [HL]                                          ;; 02:4a74 $35
    ret  NZ                                            ;; 02:4a75 $c0
    jp   openLevelUpStatusScreen                       ;; 02:4a76 $c3 $e1 $4e

windowMenuIdle:
    ld   A, [wDialogType]                              ;; 02:4a79 $fa $4a $d8
    cp   A, WINDOW_TITLE_SCREEN                        ;; 02:4a7c $fe $1f
    jr   NZ, .jr_02_4a85                               ;; 02:4a7e $20 $05
    ld   A, $00                                        ;; 02:4a80 $3e $00
    ld   [wWindowMainGameStateBackup], A               ;; 02:4a82 $ea $62 $d8
.jr_02_4a85:
    ld   A, [wDialogType]                              ;; 02:4a85 $fa $4a $d8
    cp   A, WINDOW_LEVELUP_YES_NO                      ;; 02:4a88 $fe $19
    jp   Z, call_02_4c53                               ;; 02:4a8a $ca $53 $4c
    call loadRegisterState1                            ;; 02:4a8d $cd $5b $6d
    ld   B, $19                                        ;; 02:4a90 $06 $19
    call call_02_67f9                                  ;; 02:4a92 $cd $f9 $67
    call saveRegisterState1                            ;; 02:4a95 $cd $34 $6d
    ld   A, [wMenuFlags]                               ;; 02:4a98 $fa $49 $d8
    and  A, $30                                        ;; 02:4a9b $e6 $30
    ld   A, $03                                        ;; 02:4a9d $3e $03
    jp   NZ, jp_02_5877                                ;; 02:4a9f $c2 $77 $58

call_02_4aa2:
    ld   A, [wWindowFlags]                             ;; 02:4aa2 $fa $74 $d8
    bit  6, A                                          ;; 02:4aa5 $cb $77
    jr   Z, .jr_02_4ab9                                ;; 02:4aa7 $28 $10
    res  6, A                                          ;; 02:4aa9 $cb $b7
    ld   [wWindowFlags], A                             ;; 02:4aab $ea $74 $d8
    ld   A, WINDOW_NAMING_SCREEN_TOP                   ;; 02:4aae $3e $1d
    ld   [wDialogType], A                              ;; 02:4ab0 $ea $4a $d8
    ld   A, $01                                        ;; 02:4ab3 $3e $01
    ld   [wMenuStateCurrentFunction], A                ;; 02:4ab5 $ea $53 $d8
    ret                                                ;; 02:4ab8 $c9
.jr_02_4ab9:
    call loadRegisterState1                            ;; 02:4ab9 $cd $5b $6d
    ld   A, H                                          ;; 02:4abc $7c
    inc  A                                             ;; 02:4abd $3c
    push BC                                            ;; 02:4abe $c5
    ld   B, $03                                        ;; 02:4abf $06 $03
    call setMenuStateCurrentFunction                   ;; 02:4ac1 $cd $98 $6c
    pop  BC                                            ;; 02:4ac4 $c1
    ret  NZ                                            ;; 02:4ac5 $c0
    ld   A, [wDialogType]                              ;; 02:4ac6 $fa $4a $d8
    cp   A, WINDOW_STATUS_SCREEN_TOP                   ;; 02:4ac9 $fe $15
    ld   A, B                                          ;; 02:4acb $78
    ld   [wSelectedMenuIndex], A                       ;; 02:4acc $ea $4b $d8
    ld   [wSelectedMenuIndex2], A                      ;; 02:4acf $ea $4c $d8
    call saveRegisterState1                            ;; 02:4ad2 $cd $34 $6d
    jr   Z, .jr_02_4ade                                ;; 02:4ad5 $28 $07
    inc  A                                             ;; 02:4ad7 $3c
    ld   B, $04                                        ;; 02:4ad8 $06 $04
    call setMenuStateCurrentFunction                   ;; 02:4ada $cd $98 $6c
    ret  Z                                             ;; 02:4add $c8
.jr_02_4ade:
    ld   B, $05                                        ;; 02:4ade $06 $05
    call setMenuStateCurrentFunction                   ;; 02:4ae0 $cd $98 $6c
    ret                                                ;; 02:4ae3 $c9

call_02_4ae4:
    ld   A, [wDialogType]                              ;; 02:4ae4 $fa $4a $d8
    cp   A, WINDOW_NAMING_SCREEN_BOTTOM                ;; 02:4ae7 $fe $1e
    jp   Z, windowNamingEntryRubLetter                 ;; 02:4ae9 $ca $a1 $4b
    push AF                                            ;; 02:4aec $f5
    call hideAndSaveMenuMetasprites                    ;; 02:4aed $cd $51 $6b
    pop  AF                                            ;; 02:4af0 $f1
    ld   B, A                                          ;; 02:4af1 $47
    ld   DE, .window_list                              ;; 02:4af2 $11 $08 $4b
    ld   HL, .function_list                            ;; 02:4af5 $21 $11 $4b
.loop:
    ld   A, [DE]                                       ;; 02:4af8 $1a
    and  A, A                                          ;; 02:4af9 $a7
    jr   Z, .not_matched                               ;; 02:4afa $28 $25
    cp   A, B                                          ;; 02:4afc $b8
    jr   Z, .matched                                   ;; 02:4afd $28 $05
    inc  DE                                            ;; 02:4aff $13
    inc  HL                                            ;; 02:4b00 $23
    inc  HL                                            ;; 02:4b01 $23
    jr   .loop                                         ;; 02:4b02 $18 $f4
.matched:
    ld   A, [HL+]                                      ;; 02:4b04 $2a
    ld   H, [HL]                                       ;; 02:4b05 $66
    ld   L, A                                          ;; 02:4b06 $6f
    jp   HL                                            ;; 02:4b07 $e9
.window_list:
    db WINDOW_VENDOR_SELL_TOP
    db WINDOW_VENDOR_TEXT_TOP
    db WINDOW_VENDOR_SELL_NO
    db WINDOW_VENDOR_BUY_TOP
    db WINDOW_STATUS_SCREEN_TOP
    db WINDOW_LEVELUP_JOBS
    db WINDOW_TITLE_SCREEN
    db WINDOW_SAVE_LOAD_FILE_1
    db   $00                                           ;; 02:4b10 .
;@jumptable amount=8
.function_list:
    dw   call_02_522d                                  ;; 02:4b11 pP $00
    dw   call_02_522d                                  ;; 02:4b13 ?? $01
    dw   call_02_522d                                  ;; 02:4b15 ?? $02
    dw   call_02_522d                                  ;; 02:4b17 pP $03
    dw   fullscreenWindowShowGameScreen                ;; 02:4b19 ?? $04
    dw   windowMenuIdle                                ;; 02:4b1b ?? $05
    dw   call_02_4a14                                  ;; 02:4b1d ?? $06
    dw   reopenSelectWindowAfterSaveScreen             ;; 02:4b1f pP $07
.not_matched:
    call windowCloseAndRestoreHidden                   ;; 02:4b21 $cd $7a $66
    ld   B, $23                                        ;; 02:4b24 $06 $23
    ld   A, B                                          ;; 02:4b26 $78
    ld   [wD85E], A                                    ;; 02:4b27 $ea $5e $d8
    call setMenuStateCurrentFunction                   ;; 02:4b2a $cd $98 $6c
    ret  NZ                                            ;; 02:4b2d $c0

call_02_4b2e:
    ld   A, [wDialogType]                              ;; 02:4b2e $fa $4a $d8
    cp   A, WINDOW_DIALOG_YES_NO                       ;; 02:4b31 $fe $07
    jp   Z, jp_02_4e9b                                 ;; 02:4b33 $ca $9b $4e
    cp   A, $00                                        ;; 02:4b36 $fe $00
    ld   A, [wD85E]                                    ;; 02:4b38 $fa $5e $d8
    ld   B, A                                          ;; 02:4b3b $47
    call setMenuStateCurrentFunction                   ;; 02:4b3c $cd $98 $6c
    ret  NZ                                            ;; 02:4b3f $c0
    ld   A, $02                                        ;; 02:4b40 $3e $02
    ld   [wD85C], A                                    ;; 02:4b42 $ea $5c $d8
    ld   B, $20                                        ;; 02:4b45 $06 $20
    call setMenuStateCurrentFunction                   ;; 02:4b47 $cd $98 $6c
    ret                                                ;; 02:4b4a $c9

call_02_4b4b:
    ld   HL, .data_02_4b6c                             ;; 02:4b4b $21 $6c $4b
    ld   A, [wD85C]                                    ;; 02:4b4e $fa $5c $d8
    dec  A                                             ;; 02:4b51 $3d
    ld   E, A                                          ;; 02:4b52 $5f
    add  A, A                                          ;; 02:4b53 $87
    add  A, E                                          ;; 02:4b54 $83
    ld   E, A                                          ;; 02:4b55 $5f
    ld   D, $00                                        ;; 02:4b56 $16 $00
    add  HL, DE                                        ;; 02:4b58 $19
    ld   E, [HL]                                       ;; 02:4b59 $5e
    inc  HL                                            ;; 02:4b5a $23
    ld   D, [HL]                                       ;; 02:4b5b $56
    inc  HL                                            ;; 02:4b5c $23
    ld   B, [HL]                                       ;; 02:4b5d $46
    push DE                                            ;; 02:4b5e $d5
    pop  HL                                            ;; 02:4b5f $e1
    ld   DE, wDialogX                                  ;; 02:4b60 $11 $a7 $d4
    call copyHLtoDE                                    ;; 02:4b63 $cd $49 $2b
    ld   B, $21                                        ;; 02:4b66 $06 $21
    call setMenuStateCurrentFunction                   ;; 02:4b68 $cd $98 $6c
    ret                                                ;; 02:4b6b $c9

.data_02_4b6c:
; Used when closing multiple windows to shuffle backed up tile ids to where they need to be.
; Format is a pointer to the data and a length. Data is four bytes (x,y,w,h) plus w*h bytes long.
    dw wWindowBackgroundSaveBuffer + $0101 - $54
    db $54
; For the Start menu status effect window
; This window has been slightly enlarged to show longer status effect names.
    dw wWindowBackgroundSaveBuffer + $0101
    db 4 + (8 * 4)

call_02_4b72:
    call windowCloseAndRestoreHidden                   ;; 02:4b72 $cd $7a $66
    ld   B, $10                                        ;; 02:4b75 $06 $10
    call setMenuStateCurrentFunction                   ;; 02:4b77 $cd $98 $6c
    ret                                                ;; 02:4b7a $c9

call_02_4b7b:
    ld   A, [wD85C]                                    ;; 02:4b7b $fa $5c $d8
    and  A, A                                          ;; 02:4b7e $a7
    jr   Z, .jr_02_4b8b                                ;; 02:4b7f $28 $0a
    dec  A                                             ;; 02:4b81 $3d
    ld   [wD85C], A                                    ;; 02:4b82 $ea $5c $d8
    ld   B, $20                                        ;; 02:4b85 $06 $20
    call setMenuStateCurrentFunction                   ;; 02:4b87 $cd $98 $6c
    ret  NZ                                            ;; 02:4b8a $c0
.jr_02_4b8b:
    ld   A, [wD85E]                                    ;; 02:4b8b $fa $5e $d8
    ld   B, A                                          ;; 02:4b8e $47
    call setMenuStateCurrentFunction                   ;; 02:4b8f $cd $98 $6c
    ret                                                ;; 02:4b92 $c9

windowDismiss:
    ld   B, $00                                        ;; 02:4b93 $06 $00
    call setMenuStateCurrentFunction                   ;; 02:4b95 $cd $98 $6c
    ld   A, [wDialogType]                              ;; 02:4b98 $fa $4a $d8
    cp   A, WINDOW_VENDOR_BUY_SELL_EXIT                ;; 02:4b9b $fe $0b
; Vendor
    jp   Z, windowReturnToScript                       ;; 02:4b9d $ca $38 $56
    ret                                                ;; 02:4ba0 $c9

windowNamingEntryRubLetter:
    ld   A, [wSRAMSaveHeader._a]                       ;; 02:4ba1 $fa $b1 $d7
    ld   [wSelectedMenuIndex2], A                      ;; 02:4ba4 $ea $4c $d8
; Check that the name is of non zero length before deleting a letter.
    ld   A, [wNameEntryNameLength]                     ;; 02:4ba7 $fa $85 $d8
    and  A, A                                          ;; 02:4baa $a7
    jr   Z, .finished                                  ;; 02:4bab $28 $32
    dec  A                                             ;; 02:4bad $3d
    push AF                                            ;; 02:4bae $f5
    ld   [wNameEntryNameLength], A                     ;; 02:4baf $ea $85 $d8
    ld   HL, wSRAMSaveHeader                           ;; 02:4bb2 $21 $a7 $d7
    ld   A, [wNameEntryNameLength]                     ;; 02:4bb5 $fa $85 $d8
    ld   E, A                                          ;; 02:4bb8 $5f
    ld   D, $00                                        ;; 02:4bb9 $16 $00
    add  HL, DE                                        ;; 02:4bbb $19
    xor  A, A                                          ;; 02:4bbc $af
    ld   [HL], A                                       ;; 02:4bbd $77
    ld   HL, windowData.namingScreenTop                ;; 02:4bbe $21 $cc $5c
    ld   A, WINDOW_NAMING_SCREEN_TOP                   ;; 02:4bc1 $3e $1d
    call setActiveWindow                               ;; 02:4bc3 $cd $c4 $57
    pop  AF                                            ;; 02:4bc6 $f1
    ld   DE, $108                                      ;; 02:4bc7 $11 $08 $01
    add  A, E                                          ;; 02:4bca $83
    ld   E, A                                          ;; 02:4bcb $5f
    ld   A, $7f                                        ;; 02:4bcc $3e $7f
    call storeTileAatDialogPositionDE                  ;; 02:4bce $cd $44 $38
    inc  D                                             ;; 02:4bd1 $14
    ld   A, $7f                                        ;; 02:4bd2 $3e $7f
    call storeTileAatDialogPositionDE                  ;; 02:4bd4 $cd $44 $38
    ld   HL, windowData.namingScreenBottom             ;; 02:4bd7 $21 $d6 $5c
    ld   A, WINDOW_NAMING_SCREEN_BOTTOM                ;; 02:4bda $3e $1e
    call setActiveWindow                               ;; 02:4bdc $cd $c4 $57
.finished:
    ld   A, [wSelectedMenuIndex2]                      ;; 02:4bdf $fa $4c $d8
    ld   [wRegisterSave1.H], A                         ;; 02:4be2 $ea $a3 $d8
    ld   A, $03                                        ;; 02:4be5 $3e $03
    ld   [wMenuStateCurrentFunction], A                ;; 02:4be7 $ea $53 $d8
    ret                                                ;; 02:4bea $c9

reopenSelectWindowAfterSaveScreen:
    ld   A, $03                                        ;; 02:4beb $3e $03
    ld   [wMenuStateCurrentFunction], A                ;; 02:4bed $ea $53 $d8
    ld   HL, wWindowFlags                              ;; 02:4bf0 $21 $74 $d8
    bit  2, [HL]                                       ;; 02:4bf3 $cb $56
    jr   NZ, .jr_02_4c08                               ;; 02:4bf5 $20 $11
    call clearSaveLoadScreen                           ;; 02:4bf7 $cd $ac $72
    call fullscreenWindowShowGameScreen                ;; 02:4bfa $cd $62 $50
    ld   A, WINDOW_SELECT_MENU                         ;; 02:4bfd $3e $11
    ld   [wDialogType], A                              ;; 02:4bff $ea $4a $d8
    ld   A, $01                                        ;; 02:4c02 $3e $01
    ld   [wMenuStateCurrentFunction], A                ;; 02:4c04 $ea $53 $d8
    ret                                                ;; 02:4c07 $c9
.jr_02_4c08:
    ld   A, $1b                                        ;; 02:4c08 $3e $1b
    ld   [wMenuStateCurrentFunction], A                ;; 02:4c0a $ea $53 $d8
    ret                                                ;; 02:4c0d $c9

call_02_4c0e:
    call call_02_56c9                                  ;; 02:4c0e $cd $c9 $56
    ret  NZ                                            ;; 02:4c11 $c0
    ld   B, $08                                        ;; 02:4c12 $06 $08
    call setMenuStateCurrentFunction                   ;; 02:4c14 $cd $98 $6c
    ld   A, [wMenuFlags]                               ;; 02:4c17 $fa $49 $d8
    bit  1, A                                          ;; 02:4c1a $cb $4f
    ret  Z                                             ;; 02:4c1c $c8
    call loadRegisterState1                            ;; 02:4c1d $cd $5b $6d
    call call_02_6be8                                  ;; 02:4c20 $cd $e8 $6b
    ld   A, D                                          ;; 02:4c23 $7a
    ld   [wD89D], A                                    ;; 02:4c24 $ea $9d $d8
    ld   A, E                                          ;; 02:4c27 $7b
    ld   [wD89C], A                                    ;; 02:4c28 $ea $9c $d8
    ld   A, [wD848]                                    ;; 02:4c2b $fa $48 $d8
    ld   [wD843], A                                    ;; 02:4c2e $ea $43 $d8
    ld   A, [wD868]                                    ;; 02:4c31 $fa $68 $d8
    ld   [wD869], A                                    ;; 02:4c34 $ea $69 $d8
    call saveRegisterState1                            ;; 02:4c37 $cd $34 $6d
    ld   A, [wDialogType]                              ;; 02:4c3a $fa $4a $d8
    cp   A, WINDOW_LEVELUP_JOBS                        ;; 02:4c3d $fe $18
    jp   Z, jp_02_4f19                                 ;; 02:4c3f $ca $19 $4f
    ld   B, $06                                        ;; 02:4c42 $06 $06
    call setMenuStateCurrentFunction                   ;; 02:4c44 $cd $98 $6c
    ld   A, [wMenuFlags]                               ;; 02:4c47 $fa $49 $d8
    bit  7, A                                          ;; 02:4c4a $cb $7f
    ret  Z                                             ;; 02:4c4c $c8
    set  6, A                                          ;; 02:4c4d $cb $f7
    ld   [wMenuFlags], A                               ;; 02:4c4f $ea $49 $d8
    ret                                                ;; 02:4c52 $c9

call_02_4c53:
    call loadRegisterState1                            ;; 02:4c53 $cd $5b $6d
    ld   A, [wSelectedMenuIndex]                       ;; 02:4c56 $fa $4b $d8
    ld   H, A                                          ;; 02:4c59 $67
    call saveRegisterState1                            ;; 02:4c5a $cd $34 $6d
    ld   B, $07                                        ;; 02:4c5d $06 $07
    ld   A, B                                          ;; 02:4c5f $78
    call setMenuStateCurrentFunction                   ;; 02:4c60 $cd $98 $6c
    ret                                                ;; 02:4c63 $c9

call_02_4c64:
    call loadRegisterState1                            ;; 02:4c64 $cd $5b $6d
    ld   B, $1a                                        ;; 02:4c67 $06 $1a
    call call_02_67f9                                  ;; 02:4c69 $cd $f9 $67
    call saveRegisterState1                            ;; 02:4c6c $cd $34 $6d
    ld   A, [wMenuFlags]                               ;; 02:4c6f $fa $49 $d8
    and  A, $30                                        ;; 02:4c72 $e6 $30
    ld   A, $07                                        ;; 02:4c74 $3e $07
    jp   NZ, jp_02_5877                                ;; 02:4c76 $c2 $77 $58

call_02_4c79:
    call loadRegisterState1                            ;; 02:4c79 $cd $5b $6d
    ld   A, H                                          ;; 02:4c7c $7c
    inc  A                                             ;; 02:4c7d $3c
    push BC                                            ;; 02:4c7e $c5
    ld   B, $07                                        ;; 02:4c7f $06 $07
    call setMenuStateCurrentFunction                   ;; 02:4c81 $cd $98 $6c
    pop  BC                                            ;; 02:4c84 $c1
    ret  NZ                                            ;; 02:4c85 $c0
    ld   A, B                                          ;; 02:4c86 $78
    ld   [wSelectedMenuIndex2], A                      ;; 02:4c87 $ea $4c $d8
    call saveRegisterState1                            ;; 02:4c8a $cd $34 $6d
    inc  A                                             ;; 02:4c8d $3c
    ld   B, $08                                        ;; 02:4c8e $06 $08
    call setMenuStateCurrentFunction                   ;; 02:4c90 $cd $98 $6c
    ret  NZ                                            ;; 02:4c93 $c0
    ld   B, $09                                        ;; 02:4c94 $06 $09
    call setMenuStateCurrentFunction                   ;; 02:4c96 $cd $98 $6c
    ret                                                ;; 02:4c99 $c9

call_02_4c9a:
    ld   A, [wDialogType]                              ;; 02:4c9a $fa $4a $d8
    cp   A, WINDOW_LEVELUP_YES_NO                      ;; 02:4c9d $fe $19
    jr   Z, call_02_4cba                               ;; 02:4c9f $28 $19
    call clearFirstMetasprite                          ;; 02:4ca1 $cd $84 $6b
    ld   A, [wD89D]                                    ;; 02:4ca4 $fa $9d $d8
    ld   D, A                                          ;; 02:4ca7 $57
    ld   A, [wD89C]                                    ;; 02:4ca8 $fa $9c $d8
    ld   E, A                                          ;; 02:4cab $5f
    call showMenuFingerPointing_1                      ;; 02:4cac $cd $be $6b
    call call_02_57fe                                  ;; 02:4caf $cd $fe $57
    call saveRegisterState2                            ;; 02:4cb2 $cd $80 $6d
    ld   A, $0a                                        ;; 02:4cb5 $3e $0a
    jp   jp_02_5877                                    ;; 02:4cb7 $c3 $77 $58

call_02_4cba:
    call windowCloseAndRestoreHidden                   ;; 02:4cba $cd $7a $66
    ret  NZ                                            ;; 02:4cbd $c0
    call hideAndSaveMenuMetasprites                    ;; 02:4cbe $cd $51 $6b
    call copyStatsToLevelUpTmp                         ;; 02:4cc1 $cd $0b $6d
    jp   jp_02_4f19                                    ;; 02:4cc4 $c3 $19 $4f

call_02_4cc7:
    ld   A, [wMenuFlags]                               ;; 02:4cc7 $fa $49 $d8
    and  A, $40                                        ;; 02:4cca $e6 $40
    push AF                                            ;; 02:4ccc $f5
    call NZ, showTrashcan                              ;; 02:4ccd $c4 $0b $6c
    pop  AF                                            ;; 02:4cd0 $f1
    call Z, hideTrashcan                               ;; 02:4cd1 $cc $74 $6b
    ld   A, [wMenuFlags]                               ;; 02:4cd4 $fa $49 $d8
    and  A, $bf                                        ;; 02:4cd7 $e6 $bf
    ld   [wMenuFlags], A                               ;; 02:4cd9 $ea $49 $d8
    ld   A, [wD869]                                    ;; 02:4cdc $fa $69 $d8
    ld   [wD868], A                                    ;; 02:4cdf $ea $68 $d8
    ld   A, [wD89D]                                    ;; 02:4ce2 $fa $9d $d8
    ld   D, A                                          ;; 02:4ce5 $57
    ld   A, [wD89C]                                    ;; 02:4ce6 $fa $9c $d8
    ld   E, A                                          ;; 02:4ce9 $5f
    ld   A, [wSelectedMenuIndex]                       ;; 02:4cea $fa $4b $d8
    ld   H, A                                          ;; 02:4ced $67
    call saveRegisterState1                            ;; 02:4cee $cd $34 $6d
    ld   B, $03                                        ;; 02:4cf1 $06 $03
    call setMenuStateCurrentFunction                   ;; 02:4cf3 $cd $98 $6c
    ret                                                ;; 02:4cf6 $c9

call_02_4cf7:
    ld   A, [wMenuFlags]                               ;; 02:4cf7 $fa $49 $d8
    and  A, $02                                        ;; 02:4cfa $e6 $02
    call NZ, call_02_56c9                              ;; 02:4cfc $c4 $c9 $56
    ret  NZ                                            ;; 02:4cff $c0
    ld   A, [wDialogType]                              ;; 02:4d00 $fa $4a $d8
    cp   A, WINDOW_SELECT_MENU                         ;; 02:4d03 $fe $11
    jp   Z, menuSelectChoice                           ;; 02:4d05 $ca $a7 $4e
    cp   A, WINDOW_STATUS_SCREEN_TOP                   ;; 02:4d08 $fe $15
    jp   Z, menuStatusScreenChoice                     ;; 02:4d0a $ca $3a $50
    cp   A, WINDOW_LEVELUP_YES_NO                      ;; 02:4d0d $fe $19
    jp   Z, menuLevelupYesNoChoice                     ;; 02:4d0f $ca $1c $53
    cp   A, WINDOW_SAVE_LOAD_FILE_1                    ;; 02:4d12 $fe $1b
    jp   Z, menuSaveLoadChoice                         ;; 02:4d14 $ca $fb $71
    cp   A, WINDOW_NAMING_SCREEN_BOTTOM                ;; 02:4d17 $fe $1e
    jp   Z, windowNamingEntryAddLetter                 ;; 02:4d19 $ca $c6 $52
    cp   A, WINDOW_TITLE_SCREEN                        ;; 02:4d1c $fe $1f
    jp   Z, menuSelectionTitleScreen                   ;; 02:4d1e $ca $9f $7b
    call loadRegisterState1                            ;; 02:4d21 $cd $5b $6d
    call call_02_4fc8                                  ;; 02:4d24 $cd $c8 $4f
    call saveRegisterState1                            ;; 02:4d27 $cd $34 $6d
    ld   B, $06                                        ;; 02:4d2a $06 $06
    call setMenuStateCurrentFunction                   ;; 02:4d2c $cd $98 $6c
    ret  Z                                             ;; 02:4d2f $c8
    ld   B, $0b                                        ;; 02:4d30 $06 $0b
    call setMenuStateCurrentFunction                   ;; 02:4d32 $cd $98 $6c
    ret                                                ;; 02:4d35 $c9

call_02_4d36:
    call loadRegisterState1                            ;; 02:4d36 $cd $5b $6d
    call getSelectedMenuIndexes                        ;; 02:4d39 $cd $b0 $57
    ld   A, $fe                                        ;; 02:4d3c $3e $fe
    cp   A, B                                          ;; 02:4d3e $b8
    jr   Z, .jr_02_4d45                                ;; 02:4d3f $28 $04
    cp   A, C                                          ;; 02:4d41 $b9
    jr   NZ, jr_02_4d83                                ;; 02:4d42 $20 $3f
    ld   C, B                                          ;; 02:4d44 $48
.jr_02_4d45:
    ld   B, $00                                        ;; 02:4d45 $06 $00
    ld   A, [wWindowSecondPointer.high]                ;; 02:4d47 $fa $95 $d8
    ld   H, A                                          ;; 02:4d4a $67
    ld   A, [wWindowSecondPointer]                     ;; 02:4d4b $fa $94 $d8
    ld   L, A                                          ;; 02:4d4e $6f
    add  HL, BC                                        ;; 02:4d4f $09
    ld   A, [HL]                                       ;; 02:4d50 $7e
    push BC                                            ;; 02:4d51 $c5
    call getEquipmentFlags1And2                        ;; 02:4d52 $cd $8a $56
    ld   A, C                                          ;; 02:4d55 $79
    bit  6, A                                          ;; 02:4d56 $cb $77
    pop  BC                                            ;; 02:4d58 $c1
    jr   NZ, .jr_02_4d6f                               ;; 02:4d59 $20 $14
    ld   A, [HL]                                       ;; 02:4d5b $7e
    cp   A, $80                                        ;; 02:4d5c $fe $80
    jr   Z, .jr_02_4d6f                                ;; 02:4d5e $28 $0f
    push BC                                            ;; 02:4d60 $c5
    xor  A, A                                          ;; 02:4d61 $af
    ld   [HL], A                                       ;; 02:4d62 $77
    ld   A, [wWindowFirstPointer.high]                 ;; 02:4d63 $fa $93 $d8
    ld   H, A                                          ;; 02:4d66 $67
    ld   A, [wWindowFirstPointer]                      ;; 02:4d67 $fa $92 $d8
    ld   L, A                                          ;; 02:4d6a $6f
    pop  BC                                            ;; 02:4d6b $c1
    add  HL, BC                                        ;; 02:4d6c $09
    xor  A, A                                          ;; 02:4d6d $af
    ld   [HL], A                                       ;; 02:4d6e $77
.jr_02_4d6f:
    call call_02_4fd3                                  ;; 02:4d6f $cd $d3 $4f
    ld   A, $1d                                        ;; 02:4d72 $3e $1d
    jp   jp_02_5877                                    ;; 02:4d74 $c3 $77 $58

call_02_4d77:
    call call_02_4fe8                                  ;; 02:4d77 $cd $e8 $4f
    call saveRegisterState1                            ;; 02:4d7a $cd $34 $6d
    ld   B, $03                                        ;; 02:4d7d $06 $03
    call setMenuStateCurrentFunction                   ;; 02:4d7f $cd $98 $6c
    ret                                                ;; 02:4d82 $c9

jr_02_4d83:
    ld   B, $0c                                        ;; 02:4d83 $06 $0c
    call setMenuStateCurrentFunction                   ;; 02:4d85 $cd $98 $6c
    ret                                                ;; 02:4d88 $c9

call_02_4d89:
    call loadRegisterState1                            ;; 02:4d89 $cd $5b $6d
    call getSelectedMenuIndexes                        ;; 02:4d8c $cd $b0 $57
    cp   A, B                                          ;; 02:4d8f $b8
    jr   NZ, .jr_02_4d99                               ;; 02:4d90 $20 $07
    rrca                                               ;; 02:4d92 $0f
    ld   B, $0d                                        ;; 02:4d93 $06 $0d
    call setMenuStateCurrentFunction                   ;; 02:4d95 $cd $98 $6c
    ret                                                ;; 02:4d98 $c9
.jr_02_4d99:
    call inventoryMoveItems                            ;; 02:4d99 $cd $0b $58
    call call_02_4fd3                                  ;; 02:4d9c $cd $d3 $4f
    ld   A, $1c                                        ;; 02:4d9f $3e $1c
    jp   jp_02_5877                                    ;; 02:4da1 $c3 $77 $58

call_02_4da4:
    call call_02_4fe8                                  ;; 02:4da4 $cd $e8 $4f
    call saveRegisterState1                            ;; 02:4da7 $cd $34 $6d
    ld   B, $03                                        ;; 02:4daa $06 $03
    call setMenuStateCurrentFunction                   ;; 02:4dac $cd $98 $6c
    ret                                                ;; 02:4daf $c9

; Swaps out the current equipment when a double click
; is performed in the EQUIP menu
swapActiveEquipment:
    call loadRegisterState1                            ;; 02:4db0 $cd $5b $6d
    ld   A, [wDialogType]                              ;; 02:4db3 $fa $4a $d8
    cp   A, WINDOW_EQUIP_BOTTOM                        ;; 02:4db6 $fe $04
    jp   NZ, jp_02_4e4c                                ;; 02:4db8 $c2 $4c $4e
    call saveRegisterState1                            ;; 02:4dbb $cd $34 $6d
    call getSelectedMenuIndexes                        ;; 02:4dbe $cd $b0 $57

    ; Swap out equipment indices
    ld HL, wWindowSecondPointer
    ld A, [HL+]
    ld H, [HL]
    ld L, A
    ld   B, $00
    add  HL, BC
    ld   A, [HL]
    and  A, A
    call Z, playWindowErrorSound
    jr   Z, .cleanup
    push BC
    push HL
    ld   BC, currentlyEquippedEquipmentList
    call findSlotForEquipmentType                      ;; 02:4dd1 $cd $3c $58
    pop  HL                                            ;; 02:4dd4 $e1
    ld   A, [DE]                                       ;; 02:4dd5 $1a
    ld   B, [HL]                                       ;; 02:4dd6 $46
    ld   [HL], A                                       ;; 02:4dd7 $77
    ld   A, B                                          ;; 02:4dd8 $78
    ld   [DE], A                                       ;; 02:4dd9 $12

    ; Swap equipment powers
    ld HL, wWindowFirstPointer
    ld A, [HL+]
    ld H, [HL]
    ld L, A
    pop BC
    add  HL, BC
    push HL
    ld   BC, currentlyEquippedEquipmentPowerList
    call findSlotForEquipmentType                      ;; 02:4dec $cd $3c $58
    pop  HL                                            ;; 02:4def $e1
    ld   A, [DE]                                       ;; 02:4df0 $1a
    ld   B, [HL]                                       ;; 02:4df1 $46
    ld   [HL], A                                       ;; 02:4df2 $77
    ld   A, B                                          ;; 02:4df3 $78
    ld   [DE], A                                       ;; 02:4df4 $12
.cleanup:
    ld   A, [wMenuFlags]                               ;; 02:4df5 $fa $49 $d8
    ld   [wMenuFlagsBackup], A                         ;; 02:4df8 $ea $4e $d8
    ld   A, [wD848]                                    ;; 02:4dfb $fa $48 $d8
    ld   [wD84F], A                                    ;; 02:4dfe $ea $4f $d8
    ld   A, WINDOW_EQUIP_TOP                           ;; 02:4e01 $3e $03
    ld   HL, windowData.equipmentScreenTop             ;; 02:4e03 $21 $c8 $5b
    call setActiveWindow                               ;; 02:4e06 $cd $c4 $57
    call windowInitContents                            ;; 02:4e09 $cd $93 $76
    call saveRegisterState2                            ;; 02:4e0c $cd $80 $6d
    ld   A, $14                                        ;; 02:4e0f $3e $14
    jp   jp_02_5877                                    ;; 02:4e11 $c3 $77 $58

ds 1 ; Free space

call_02_4e14:
    ld   A, WINDOW_EQUIP_BOTTOM                        ;; 02:4e14 $3e $04
    call windowInitContents                            ;; 02:4e16 $cd $93 $76
    ld   A, [wD84F]                                    ;; 02:4e19 $fa $4f $d8
    ld   [wD848], A                                    ;; 02:4e1c $ea $48 $d8
    ld   [wD846], A                                    ;; 02:4e1f $ea $46 $d8
    rrca                                               ;; 02:4e22 $0f
    call windowEquipScreenSetBottomWindowActive        ;; 02:4e23 $cd $b9 $57
    call Z, windowInitContents                         ;; 02:4e26 $cc $93 $76
    ld   A, [wD869]                                    ;; 02:4e29 $fa $69 $d8
    ld   [wD868], A                                    ;; 02:4e2c $ea $68 $d8
    call saveRegisterState2                            ;; 02:4e2f $cd $80 $6d
    ld   A, $16                                        ;; 02:4e32 $3e $16
    jp   jp_02_5877                                    ;; 02:4e34 $c3 $77 $58

call_02_4e37:
    ld   A, [wMenuFlagsBackup]                         ;; 02:4e37 $fa $4e $d8
    ld   [wMenuFlags], A                               ;; 02:4e3a $ea $49 $d8
    rlca                                               ;; 02:4e3d $07
    call C, showTrashcan                               ;; 02:4e3e $dc $0b $6c
    call clearFirstMetasprite                          ;; 02:4e41 $cd $84 $6b
    call loadRegisterState1                            ;; 02:4e44 $cd $5b $6d
    ld   A, [wSelectedMenuIndex2]                      ;; 02:4e47 $fa $4c $d8
    ld   H, A                                          ;; 02:4e4a $67
    xor  A, A                                          ;; 02:4e4b $af

jp_02_4e4c:
    call saveRegisterState1                            ;; 02:4e4c $cd $34 $6d
    ld   B, $03                                        ;; 02:4e4f $06 $03
    call setMenuStateCurrentFunction                   ;; 02:4e51 $cd $98 $6c
    ret  Z                                             ;; 02:4e54 $c8
    ld   B, $0e                                        ;; 02:4e55 $06 $0e
    call setMenuStateCurrentFunction                   ;; 02:4e57 $cd $98 $6c
    ret                                                ;; 02:4e5a $c9

call_02_4e5b:
    call loadRegisterState1                            ;; 02:4e5b $cd $5b $6d
    call call_02_4fff                                  ;; 02:4e5e $cd $ff $4f
    call saveRegisterState1                            ;; 02:4e61 $cd $34 $6d
    ld   B, $0f                                        ;; 02:4e64 $06 $0f
    call setMenuStateCurrentFunction                   ;; 02:4e66 $cd $98 $6c
    ret  NZ                                            ;; 02:4e69 $c0
    ld   A, [wMenuFlags]                               ;; 02:4e6a $fa $49 $d8
    bit  1, A                                          ;; 02:4e6d $cb $4f
    ld   B, $03                                        ;; 02:4e6f $06 $03
    call setMenuStateCurrentFunction                   ;; 02:4e71 $cd $98 $6c
    ret  Z                                             ;; 02:4e74 $c8
    ld   B, $06                                        ;; 02:4e75 $06 $06
    call setMenuStateCurrentFunction                   ;; 02:4e77 $cd $98 $6c
    ret                                                ;; 02:4e7a $c9

call_02_4e7b:
    ld   A, [wMenuStateCurrentFunction]                ;; 02:4e7b $fa $53 $d8
    bit  7, A                                          ;; 02:4e7e $cb $7f
    call Z, hideAndSaveMenuMetasprites                 ;; 02:4e80 $cc $51 $6b
    call windowCloseAndRestoreHidden                   ;; 02:4e83 $cd $7a $66
    ld   B, $11                                        ;; 02:4e86 $06 $11
    ld   A, B                                          ;; 02:4e88 $78
    ld   [wD85E], A                                    ;; 02:4e89 $ea $5e $d8
    call setMenuStateCurrentFunction                   ;; 02:4e8c $cd $98 $6c
    ret  NZ                                            ;; 02:4e8f $c0
    ld   B, $22                                        ;; 02:4e90 $06 $22
    call setMenuStateCurrentFunction                   ;; 02:4e92 $cd $98 $6c
    ld   A, [wDialogType]                              ;; 02:4e95 $fa $4a $d8
    cp   A, WINDOW_DIALOG_YES_NO                       ;; 02:4e98 $fe $07
    ret  NZ                                            ;; 02:4e9a $c0

jp_02_4e9b:
    ld   A, [wWindowMainGameStateBackup]               ;; 02:4e9b $fa $62 $d8
    ld   [wMainGameState], A                           ;; 02:4e9e $ea $a0 $c0
    ld   B, $00                                        ;; 02:4ea1 $06 $00
    call runVirtualScriptOpCodeFF                      ;; 02:4ea3 $cd $69 $3c
    ret                                                ;; 02:4ea6 $c9

menuSelectChoice:
    ld   A, [wDialogType]                              ;; 02:4ea7 $fa $4a $d8
    ld   [wSelectedMenuIndex], A                       ;; 02:4eaa $ea $4b $d8
    ld   A, [wSelectedMenuIndex2]                      ;; 02:4ead $fa $4c $d8
    ld   B, $34                                        ;; 02:4eb0 $06 $34
    call setMenuStateCurrentFunction                   ;; 02:4eb2 $cd $98 $6c
    and  A, A                                          ;; 02:4eb5 $a7
    jp   Z, openSaveScreen                             ;; 02:4eb6 $ca $e4 $71
    dec  A                                             ;; 02:4eb9 $3d
    jr   Z, runMinimapScript                           ;; 02:4eba $28 $07
    ld   B, $2d                                        ;; 02:4ebc $06 $2d
    call setMenuStateCurrentFunction                   ;; 02:4ebe $cd $98 $6c
    jr   openStatusScreen                              ;; 02:4ec1 $18 $3a

runMinimapScript:
    ld   A, $36                                        ;; 02:4ec3 $3e $36
    ld   [wMenuStateCurrentFunction], A                ;; 02:4ec5 $ea $53 $d8
    call windowCloseAndRestoreHidden                   ;; 02:4ec8 $cd $7a $66
    ret  NZ                                            ;; 02:4ecb $c0
    call hideAndSaveMenuMetasprites                    ;; 02:4ecc $cd $51 $6b
    ld   A, [wWindowMainGameStateBackup]               ;; 02:4ecf $fa $62 $d8
    ld   [wMainGameState], A                           ;; 02:4ed2 $ea $a0 $c0
    ld   B, $00                                        ;; 02:4ed5 $06 $00
    call setMenuStateCurrentFunction                   ;; 02:4ed7 $cd $98 $6c
    ld   HL, $1f                                       ;; 02:4eda $21 $1f $00
    call runScriptByIndex                              ;; 02:4edd $cd $ad $31
    ret                                                ;; 02:4ee0 $c9

openLevelUpStatusScreen:
    ld   A, $37                                        ;; 02:4ee1 $3e $37
    ld   [wMenuStateCurrentFunction], A                ;; 02:4ee3 $ea $53 $d8
    call windowCloseAndRestoreHidden                   ;; 02:4ee6 $cd $7a $66
    ret  NZ                                            ;; 02:4ee9 $c0
    call showFullscreenWindow                          ;; 02:4eea $cd $57 $51
    ld   A, WINDOW_STATUS_SCREEN_RIGHT                 ;; 02:4eed $3e $12
    ld   [wDialogType], A                              ;; 02:4eef $ea $4a $d8
    ld   A, $01                                        ;; 02:4ef2 $3e $01
    ld   [wMenuStateCurrentFunction], A                ;; 02:4ef4 $ea $53 $d8
    ld   A, [wCurrentMusicLevelUpBackup]               ;; 02:4ef7 $fa $42 $d8
    ldh  [hCurrentMusic], A                            ;; 02:4efa $e0 $90
    ret                                                ;; 02:4efc $c9

openStatusScreen:
    call windowCloseAndRestoreHidden                   ;; 02:4efd $cd $7a $66
    ret  NZ                                            ;; 02:4f00 $c0
    call showFullscreenWindow                          ;; 02:4f01 $cd $57 $51
    ld   A, WINDOW_STATUS_SCREEN_RIGHT                 ;; 02:4f04 $3e $12
    ld   [wDialogType], A                              ;; 02:4f06 $ea $4a $d8
    call hideAndSaveMenuMetasprites                    ;; 02:4f09 $cd $51 $6b
    ld   HL, wWindowSecondaryFlags                     ;; 02:4f0c $21 $72 $d8
    set  0, [HL]                                       ;; 02:4f0f $cb $c6
    res  1, [HL]                                       ;; 02:4f11 $cb $8e
    ld   A, $01                                        ;; 02:4f13 $3e $01
    ld   [wMenuStateCurrentFunction], A                ;; 02:4f15 $ea $53 $d8
    ret                                                ;; 02:4f18 $c9

jp_02_4f19:
    ld   HL, windowData.statusScreenRight              ;; 02:4f19 $21 $5e $5c
    ld   E, [HL]                                       ;; 02:4f1c $5e
    inc  HL                                            ;; 02:4f1d $23
    ld   D, [HL]                                       ;; 02:4f1e $56
    inc  HL                                            ;; 02:4f1f $23
    ld   C, [HL]                                       ;; 02:4f20 $4e
    inc  HL                                            ;; 02:4f21 $23
    ld   B, [HL]                                       ;; 02:4f22 $46
    call setWindowDimensions                           ;; 02:4f23 $cd $73 $7a
    ld   A, WINDOW_STATUS_SCREEN_RIGHT                 ;; 02:4f26 $3e $12
    ld   [wDialogType], A                              ;; 02:4f28 $ea $4a $d8
    call windowInitContents                            ;; 02:4f2b $cd $93 $76
    ld   A, [wWindowSecondaryFlags]                    ;; 02:4f2e $fa $72 $d8
    bit  6, A                                          ;; 02:4f31 $cb $77
    jr   NZ, .jr_02_4f5a                               ;; 02:4f33 $20 $25
    ld   A, [wSelectedMenuIndex]                       ;; 02:4f35 $fa $4b $d8
    ld   HL, wLevelUpStatChoicesCopy                   ;; 02:4f38 $21 $31 $d8
    add  A, A                                          ;; 02:4f3b $87
    add  A, A                                          ;; 02:4f3c $87
    ld   B, $00                                        ;; 02:4f3d $06 $00
    ld   C, A                                          ;; 02:4f3f $4f
    add  HL, BC                                        ;; 02:4f40 $09
    ld   A, $04                                        ;; 02:4f41 $3e $04
    ld   DE, wStatStaminaLevelUpTmp                    ;; 02:4f43 $11 $8f $d7
    ld   BC, wStatStamina                              ;; 02:4f46 $01 $c1 $d7
.jr_02_4f49:
    push AF                                            ;; 02:4f49 $f5
    ld   A, [BC]                                       ;; 02:4f4a $0a
    add  A, [HL]                                       ;; 02:4f4b $86
    cp   A, $64                                        ;; 02:4f4c $fe $64
    jr   C, .jr_02_4f52                                ;; 02:4f4e $38 $02
    ld   A, $63                                        ;; 02:4f50 $3e $63
.jr_02_4f52:
    ld   [DE], A                                       ;; 02:4f52 $12
    inc  BC                                            ;; 02:4f53 $03
    inc  DE                                            ;; 02:4f54 $13
    inc  HL                                            ;; 02:4f55 $23
    pop  AF                                            ;; 02:4f56 $f1
    dec  A                                             ;; 02:4f57 $3d
    jr   NZ, .jr_02_4f49                               ;; 02:4f58 $20 $ef
.jr_02_4f5a:
    ld   A, $2f                                        ;; 02:4f5a $3e $2f
    jp   jp_02_5877                                    ;; 02:4f5c $c3 $77 $58

levelUpDrawPreviewAPDP:
; Draw the window, although this returns early.
    ld   A, WINDOW_STATUS_SCREEN_AP_DP                 ;; 02:4f5f $3e $1a
    ld   [wDialogType], A                              ;; 02:4f61 $ea $4a $d8
    call drawWindow                                    ;; 02:4f64 $cd $00 $67
    ld a, WINDOW_STATUS_SCREEN_AP_DP
    call windowInitContents                            ;; 02:4f67 $cd $93 $76
; Calculate the preview AP.
    ld   HL, wTotalAP                                  ;; 02:4f6a $21 $df $d7
    ld   A, [wStatPowerLevelUpTmp]                     ;; 02:4f6d $fa $90 $d7
    ld   B, A                                          ;; 02:4f70 $47
    call getEquippedWeaponAP                           ;; 02:4f71 $cd $9d $5b
    add  A, B                                          ;; 02:4f74 $80
    ld   [HL+], A                                      ;; 02:4f75 $22
    ld   [wDupTotalAP], A                              ;; 02:4f76 $ea $c1 $d6
; Calculate the preview DP.
    ld   A, [wStatStaminaLevelUpTmp]                   ;; 02:4f79 $fa $8f $d7
    ld   B, A                                          ;; 02:4f7c $47
    ld   A, [wEquippedArmorDefense]                    ;; 02:4f7d $fa $c2 $d6
    add  A, B                                          ;; 02:4f80 $80
    ld   B, A                                          ;; 02:4f81 $47
    ld   A, [wEquippedHelmetDefense]                   ;; 02:4f82 $fa $c0 $d6
    add  A, B                                          ;; 02:4f85 $80
    ld   [HL], A                                       ;; 02:4f86 $77
    ld   [wDupTotalDP], A                              ;; 02:4f87 $ea $c3 $d6
    ld   A, [wStatusEffect]                            ;; 02:4f8a $fa $c0 $d7
; Set DP to zero if moogled. This call has the side effect of initializing the moogle DP backup.
    bit  3, A                                          ;; 02:4f8d $cb $5f
    call NZ, moogleTempZeroDP                          ;; 02:4f8f $c4 $b8 $78
; Move on to the next step.
    ld   A, $30                                        ;; 02:4f92 $3e $30
    ld [wMenuStateFunctionNew], a
    jp call_02_5880

ds 11 ; Free space

levelUpDrawPreviewStatsAndYesNoWindow:
    xor  A, A                                          ;; 02:4fa7 $af
    ld   [wSelectedMenuIndex], A                       ;; 02:4fa8 $ea $4b $d8
    ld   HL, wWindowSecondaryFlags                     ;; 02:4fab $21 $72 $d8
    bit  6, [HL]                                       ;; 02:4fae $cb $76
    jr   NZ, .jr_02_4fbc                               ;; 02:4fb0 $20 $0a
    set  6, [HL]                                       ;; 02:4fb2 $cb $f6
    ld   A, WINDOW_LEVELUP_YES_NO                      ;; 02:4fb4 $3e $19
    ld   [wDialogType], A                              ;; 02:4fb6 $ea $4a $d8
    jp   windowInitMain                                ;; 02:4fb9 $c3 $89 $48
.jr_02_4fbc:
    res  6, [HL]                                       ;; 02:4fbc $cb $b6
    res  7, [HL]                                       ;; 02:4fbe $cb $be
    ld   A, WINDOW_LEVELUP_JOBS                        ;; 02:4fc0 $3e $18
    ld   [wDialogType], A                              ;; 02:4fc2 $ea $4a $d8
    jp   windowInitMain                                ;; 02:4fc5 $c3 $89 $48

call_02_4fc8:
    call getSelectedMenuIndexes                        ;; 02:4fc8 $cd $b0 $57
    cp   A, B                                          ;; 02:4fcb $b8
    ret  NZ                                            ;; 02:4fcc $c0
    ld   A, $fe                                        ;; 02:4fcd $3e $fe
    cp   A, B                                          ;; 02:4fcf $b8
    ret  NZ                                            ;; 02:4fd0 $c0
    xor  A, A                                          ;; 02:4fd1 $af
    ret                                                ;; 02:4fd2 $c9

call_02_4fd3:
    ld   A, D                                          ;; 02:4fd3 $7a
    ld   [wD89F], A                                    ;; 02:4fd4 $ea $9f $d8
    ld   A, E                                          ;; 02:4fd7 $7b
    ld   [wD89E], A                                    ;; 02:4fd8 $ea $9e $d8
    ld   A, [wD848]                                    ;; 02:4fdb $fa $48 $d8
    ld   [wD843], A                                    ;; 02:4fde $ea $43 $d8
    call call_02_57fe                                  ;; 02:4fe1 $cd $fe $57
    call saveRegisterState2                            ;; 02:4fe4 $cd $80 $6d
    ret                                                ;; 02:4fe7 $c9

call_02_4fe8:
    call clearFirstMetasprite                          ;; 02:4fe8 $cd $84 $6b
    ld   A, [wMenuFlags]                               ;; 02:4feb $fa $49 $d8
    rlca                                               ;; 02:4fee $07
    call C, showTrashcan                               ;; 02:4fef $dc $0b $6c
    ld   A, [wSelectedMenuIndex2]                      ;; 02:4ff2 $fa $4c $d8
    ld   H, A                                          ;; 02:4ff5 $67
    ld   A, [wD89F]                                    ;; 02:4ff6 $fa $9f $d8
    ld   D, A                                          ;; 02:4ff9 $57
    ld   A, [wD89E]                                    ;; 02:4ffa $fa $9e $d8
    ld   E, A                                          ;; 02:4ffd $5f
    ret                                                ;; 02:4ffe $c9

call_02_4fff:
    call getSelectedMenuIndexes                        ;; 02:4fff $cd $b0 $57
    inc  A                                             ;; 02:5002 $3c
    jr   Z, .jr_02_5038                                ;; 02:5003 $28 $33
    ld   A, [wDialogType]                              ;; 02:5005 $fa $4a $d8
    and  A, A                                          ;; 02:5008 $a7
    jr   Z, .jr_02_5038                                ;; 02:5009 $28 $2d
    ld   A, $fe                                        ;; 02:500b $3e $fe
    cp   A, B                                          ;; 02:500d $b8
    jp   Z, jp_02_56c1                                 ;; 02:500e $ca $c1 $56
    ld   A, [wDialogType]                              ;; 02:5011 $fa $4a $d8
    cp   A, WINDOW_VENDOR_BUY_SELL_EXIT                ;; 02:5014 $fe $0b
    jp   Z, jp_02_54a6                                 ;; 02:5016 $ca $a6 $54
    cp   A, WINDOW_VENDOR_BUY_TOP                      ;; 02:5019 $fe $0e
    jr   Z, purchaseFromVendor                         ;; 02:501b $28 $69
    cp   A, WINDOW_VENDOR_SELL_TOP                     ;; 02:501d $fe $0d
    jp   Z, call_02_5292                               ;; 02:501f $ca $92 $52
    cp   A, WINDOW_VENDOR_SELL_NO                      ;; 02:5022 $fe $10
    jp   Z, sellToVendor                               ;; 02:5024 $ca $fb $51
    ld   B, $00                                        ;; 02:5027 $06 $00
    ld   A, [wWindowSecondPointer.high]                ;; 02:5029 $fa $95 $d8
    ld   H, A                                          ;; 02:502c $67
    ld   A, [wWindowSecondPointer]                     ;; 02:502d $fa $94 $d8
    ld   L, A                                          ;; 02:5030 $6f
    add  HL, BC                                        ;; 02:5031 $09
    ld   A, [HL]                                       ;; 02:5032 $7e
    and  A, $7f                                        ;; 02:5033 $e6 $7f
    jp   Z, jp_02_56c1                                 ;; 02:5035 $ca $c1 $56
.jr_02_5038:
    rrca                                               ;; 02:5038 $0f
    ret                                                ;; 02:5039 $c9

menuStatusScreenChoice:
    ld   HL, wWindowSecondaryFlags                     ;; 02:503a $21 $72 $d8
    bit  0, [HL]                                       ;; 02:503d $cb $46
    jr   NZ, fullscreenWindowShowGameScreen            ;; 02:503f $20 $21
    call increaseLevel                                 ;; 02:5041 $cd $99 $53
    ld   A, WINDOW_LEVELUP_MESSAGE                     ;; 02:5044 $3e $17
    ld   [wDialogType], A                              ;; 02:5046 $ea $4a $d8
    ld   A, $2e                                        ;; 02:5049 $3e $2e
    ld   [wMenuStateCurrentFunction], A                ;; 02:504b $ea $53 $d8
    ret                                                ;; 02:504e $c9

call_02_504f:
    call drawWindow                                    ;; 02:504f $cd $00 $67
    ld   A, [wMenuStateCurrentFunction]                ;; 02:5052 $fa $53 $d8
    rlca                                               ;; 02:5055 $07
    ret  C                                             ;; 02:5056 $d8
    ld   A, [wDialogType]                              ;; 02:5057 $fa $4a $d8
    call windowInitContents                            ;; 02:505a $cd $93 $76
    ld   A, $26                                        ;; 02:505d $3e $26
    jp   jp_02_5877                                    ;; 02:505f $c3 $77 $58

; Used for the Save screen, the Stats screen, and the Level up! screen.
fullscreenWindowShowGameScreen:
    call hideAndSaveMenuMetasprites                    ;; 02:5062 $cd $51 $6b
; These next two calls have been switched in order to prevent a brief visual glitch.
    call hideFullscreenWindow
    call clearSaveLoadScreen
; When leaving the Save screen return to the Select window.
    ld   A, [wDialogType]                              ;; 02:506b $fa $4a $d8
    cp   A, WINDOW_SAVE_LOAD_FILE_1                    ;; 02:506e $fe $1b
    jr   Z, .clear_temp                                ;; 02:5070 $28 $09
; Exit back to gameplay.
    ld   A, $00                                        ;; 02:5072 $3e $00
    ld   [wMenuStateCurrentFunction], A                ;; 02:5074 $ea $53 $d8
    ld   B, A                                          ;; 02:5077 $47
    call setMenuStateCurrentFunction                   ;; 02:5078 $cd $98 $6c
.clear_temp:
    ld   HL, wLevelUpStatChoicesCopy                   ;; 02:507b $21 $31 $d8
    ld   B, $10                                        ;; 02:507e $06 $10
    xor  A, A                                          ;; 02:5080 $af
.loop:
    ld   [HL+], A                                      ;; 02:5081 $22
    dec  B                                             ;; 02:5082 $05
    jr   NZ, .loop                                     ;; 02:5083 $20 $fc
    ret                                                ;; 02:5085 $c9

purchaseFromVendor:
    ld   B, $00                                        ;; 02:5086 $06 $00
    ld   HL, wMoneyLow
    ld   A, [HL+]
    ld   D, [HL]
    ld   E, A
    ld   HL, wVendorBuyPrices                          ;; 02:5088 $21 $01 $d7
    add  HL, BC                                        ;; 02:508b $09
    add  HL, BC                                        ;; 02:508c $09
    ld   A, [HL+]                                      ;; 02:508d $2a
    ld   H, [HL]                                       ;; 02:508e $66
    ld   L, A                                          ;; 02:508f $6f
    ld   A, [wStatusEffect]
    bit  7, A
    jr   NZ, .continue_purchase
    ld   A, D                                          ;; 02:5098 $7a
    cp   A, H                                          ;; 02:5099 $bc
    jr   C, .not_enough_money
    jr   NZ, .continue_purchase                        ;; 02:509d $20 $05
    ld   A, E                                          ;; 02:509f $7b
    cp   A, L                                          ;; 02:50a0 $bd
    jr   C, .not_enough_money
.continue_purchase:
    call finalizePurchase                              ;; 02:50a5 $cd $b5 $50
    xor  A, A                                          ;; 02:50a8 $af
    ret                                                ;; 02:50a9 $c9
.not_enough_money:
    ld   HL, wMiscFlags                                ;; 02:50aa $21 $6f $d8
    set  0, [HL]                                       ;; 02:50ad $cb $c6
    ld   B, $a4                                        ;; 02:50af $06 $a4
    jp   setMenuStateCurrentFunction

finalizePurchase:
    ld   HL, wMiscFlags                                ;; 02:50b5 $21 $6f $d8
    res  0, [HL]                                       ;; 02:50b8 $cb $86
    ld   HL, wVendorBuyIDs                             ;; 02:50bd $21 $f3 $d6
    add  HL, BC                                        ;; 02:50c0 $09
    ld   A, [HL]                                       ;; 02:50c1 $7e
    and  A, $7f                                        ;; 02:50c2 $e6 $7f
    jp   Z, .jp_02_5149                                ;; 02:50c4 $ca $49 $51
    ld   [wVendorPurchaseID], A                        ;; 02:50c7 $ea $5d $d8
    cp   A, $3a                                        ;; 02:50ca $fe $3a
    ld   A, [HL]                                       ;; 02:50cc $7e
    push AF                                            ;; 02:50cd $f5
    call C, giveItem                                   ;; 02:50ce $dc $19 $54
    ld   A, [wMiscFlags]                               ;; 02:50d1 $fa $6f $d8
    bit  1, A                                          ;; 02:50d4 $cb $4f
    jr   NZ, .jr_02_5147                               ;; 02:50d6 $20 $6f
    pop  AF                                            ;; 02:50d8 $f1
    push AF                                            ;; 02:50d9 $f5
    sub  A, $39                                        ;; 02:50da $d6 $39
    ld   C, A                                          ;; 02:50dc $4f
    pop  AF                                            ;; 02:50dd $f1
    ld   A, C                                          ;; 02:50de $79
    call NC, giveEquipmentAndStorePowers               ;; 02:50df $d4 $f0 $53
    ld   A, [wMiscFlags]                               ;; 02:50e2 $fa $6f $d8
    bit  1, A                                          ;; 02:50e5 $cb $4f
    jr   NZ, .jr_02_5147                               ;; 02:50e7 $20 $5e
    ld   HL, windowData.vendorScreenGold               ;; 02:50e9 $21 $22 $5c
    ld   A, [HL+]                                      ;; 02:50ec $2a
    ld   H, [HL]                                       ;; 02:50ed $66
    ld   L, A                                          ;; 02:50ee $6f
    ld   A, H                                          ;; 02:50ef $7c
    ld   [wDialogY], A                                 ;; 02:50f0 $ea $a8 $d4
    ld   A, L                                          ;; 02:50f3 $7d
    ld   [wDialogX], A                                 ;; 02:50f4 $ea $a7 $d4
    push HL                                            ;; 02:50f7 $e5
    pop  DE                                            ;; 02:50f8 $d1
    ld   B, $05                                        ;; 02:50f9 $06 $05
.loop_1:
    ld   A, $7f                                        ;; 02:50fb $3e $7f
    call storeTileAatDialogPositionDE                  ;; 02:50fd $cd $44 $38
    dec  E                                             ;; 02:5100 $1d
    dec  B                                             ;; 02:5101 $05
    jr   NZ, .loop_1                                   ;; 02:5102 $20 $f7
    call getSelectedMenuIndexes                        ;; 02:5104 $cd $b0 $57
    ld   B, $00                                        ;; 02:5107 $06 $00
    ld   HL, wMoneyLow
    ld   A, [HL+]
    ld   D, [HL]
    ld   E, A
    ld   HL, wVendorBuyPrices                          ;; 02:5109 $21 $01 $d7
    add  HL, BC                                        ;; 02:510c $09
    add  HL, BC                                        ;; 02:510d $09
    ld   A, [HL+]                                      ;; 02:510e $2a
    ld   H, [HL]                                       ;; 02:510f $66
    ld   L, A                                          ;; 02:5110 $6f
    ld   A, E                                          ;; 02:5119 $7b
    sub  A, L                                          ;; 02:511a $95
    ld   E, A                                          ;; 02:511b $5f
    ld   A, D                                          ;; 02:511c $7a
    sbc  A, H                                          ;; 02:511d $9c
    ld   D, A                                          ;; 02:511e $57
    jr   NC, .set_money
    ld   HL, wStatusEffect
    res  7, [HL]
.set_money
    ld   HL, wMoneyLow
    ld   A, E                                          ;; 02:5123 $7b
    ld   [HL+], A
    ld   [HL], D
    ld   DE, $206                                      ;; 02:5127 $11 $06 $02
    ld   B, $05                                        ;; 02:512a $06 $05
.loop_2:
    ld   A, $7f                                        ;; 02:512c $3e $7f
    push DE                                            ;; 02:512e $d5
    push BC                                            ;; 02:512f $c5
    call storeTileAatDialogPositionDE                  ;; 02:5130 $cd $44 $38
    pop  BC                                            ;; 02:5133 $c1
    pop  DE                                            ;; 02:5134 $d1
    dec  E                                             ;; 02:5135 $1d
    dec  B                                             ;; 02:5136 $05
    jr   NZ, .loop_2                                   ;; 02:5137 $20 $f3
    ld   A, WINDOW_VENDOR_MONEY                        ;; 02:5139 $3e $0c
    ld   [wDialogType], A                              ;; 02:513b $ea $4a $d8
    call drawMoneyOnDialog                             ;; 02:513e $cd $f4 $75
    ld   B, $a4                                        ;; 02:5141 $06 $a4
    jp   setMenuStateCurrentFunction
.jr_02_5147:
    pop  AF                                            ;; 02:5147 $f1
    ret                                                ;; 02:5148 $c9
.jp_02_5149:
    call playWindowErrorSound                          ;; 02:5149 $cd $1f $7a
    ld   A, WINDOW_VENDOR_TEXT_TOP                     ;; 02:514c $3e $0f
    ld   [wDialogType], A                              ;; 02:514e $ea $4a $d8
    ld   A, $81                                        ;; 02:5151 $3e $81
    ld   [wMenuStateCurrentFunction], A                ;; 02:5153 $ea $53 $d8
    ret                                                ;; 02:5156 $c9

; Used by Save/Load/Status windows to fullscreen the hardware Window
showFullscreenWindow:
    ld   A, [wVideoWY]                                 ;; 02:5157 $fa $a9 $c0
    ld   [wVideoWYBackup], A                           ;; 02:515a $ea $84 $d8
; Clear the HUD's area.
    ld b, $02
    ld hl, _SCRN1
    call clearVRAMArea
    xor  A, A                                          ;; 02:516f $af
    ld   [wVideoWY], A                                 ;; 02:5170 $ea $a9 $c0
    ret                                                ;; 02:5173 $c9

ds 10 ; Free space

windowVendorShowBuyMessageWindow:
    ld   A, WINDOW_VENDOR_TEXT_TOP                     ;; 02:5174 $3e $0f
    ld   [wDialogType], A                              ;; 02:5176 $ea $4a $d8
    call drawWindow                                    ;; 02:5179 $cd $00 $67
    ld   B, $25                                        ;; 02:517c $06 $25
    call setMenuStateCurrentFunction                   ;; 02:517e $cd $98 $6c
    ret                                                ;; 02:5181 $c9

windowVendorShowBuyMessage:
    ld   A, [wDialogType]                              ;; 02:5182 $fa $4a $d8
    call windowInitContents                            ;; 02:5185 $cd $93 $76
    ld   A, [wMiscFlags]                               ;; 02:5188 $fa $6f $d8
    and  A, $01                                        ;; 02:518b $e6 $01
    ld   HL, venderNotEnoughMoneyText                  ;; 02:518d $21 $76 $7d
    ld   B, $11                                        ;; 02:5190 $06 $10
    jr   NZ, .vendorCannotAfford                       ;; 02:5192 $20 $36
    ld   A, [wVendorPurchaseID]                        ;; 02:5194 $fa $5d $d8
    ld   HL, itemDataTable                             ;; 02:5197 $21 $5a $5e
    cp   A, $3a                                        ;; 02:519a $fe $3a
    jr   C, .jr_02_51a3                                ;; 02:519c $38 $05
    ld   HL, equipmentDataTable                        ;; 02:519e $21 $ea $61
    sub  A, $39                                        ;; 02:51a1 $d6 $39
.jr_02_51a3:
    push HL                                            ;; 02:51a3 $e5
    push AF                                            ;; 02:51a4 $f5
    ld   HL, vendorBoughtText                          ;; 02:51a5 $21 $56 $7d
    push DE                                            ;; 02:51a8 $d5
    ld   B, $07                                        ;; 02:51a9 $06 $07
    call drawText                                      ;; 02:51ab $cd $77 $37
    pop  DE                                            ;; 02:51ae $d1
    pop  AF                                            ;; 02:51af $f1
    pop  HL                                            ;; 02:51b0 $e1
    call indexIntoTable                                ;; 02:51b1 $cd $82 $76
    ld   A, $07                                        ;; 02:51b4 $3e $07
    add  A, E                                          ;; 02:51b6 $83
    ld   E, A                                          ;; 02:51b7 $5f
    ld   B, $08                                        ;; 02:51b8 $06 $08
    call drawText                                      ;; 02:51ba $cd $77 $37
    ld   A, [wWindowTextInsertionPointFinalY]          ;; 02:51bd $fa $c6 $d8
    ld   D, A                                          ;; 02:51c0 $57
    ld   A, [wWindowTextInsertionPointFinalX]          ;; 02:51c1 $fa $c5 $d8
    ld   E, A                                          ;; 02:51c4 $5f
    ld   HL, .period                                   ;; 02:51c5 $21 $d3 $51
    ld   B, $02                                        ;; 02:51c8 $06 $02
.vendorCannotAfford:
    call drawText                                      ;; 02:51ca $cd $77 $37
    ld   B, $26                                        ;; 02:51cd $06 $26
    call setMenuStateCurrentFunction                   ;; 02:51cf $cd $98 $6c
    ret                                                ;; 02:51d2 $c9
;@ffa_text
.period:
    TXT  ".<00>"                                       ;; 02:51d3 ..

windowVendorBuyWaitAnyButton:
; Joypad input is in d and e.
    ld   A, E                                          ;; 02:51d8 $7b
    and  A, D                                          ;; 02:51d9 $a2
    ret  Z                                             ;; 02:51da $c8
    ld   B, $0f                                        ;; 02:51db $06 $0f
    ld   A, [wDialogType]                              ;; 02:51dd $fa $4a $d8
    cp   A, WINDOW_STATUS_BEGIN                        ;; 02:51e0 $fe $20
    jp   Z, .window_status_effect_inflicted            ;; 02:51e2 $ca $f5 $51
    cp   A, WINDOW_LEVELUP_MESSAGE                     ;; 02:51e5 $fe $17
    jr   NZ, .jr_02_51eb                               ;; 02:51e7 $20 $02
    ld   B, WINDOW_LEVELUP_JOBS                        ;; 02:51e9 $06 $18
.jr_02_51eb:
    ld   A, B                                          ;; 02:51eb $78
    ld   [wDialogType], A                              ;; 02:51ec $ea $4a $d8
    ld   A, $81                                        ;; 02:51ef $3e $81
    ld   [wMenuStateCurrentFunction], A                ;; 02:51f1 $ea $53 $d8
    ret                                                ;; 02:51f4 $c9
.window_status_effect_inflicted:
    ld   A, $39                                        ;; 02:51f5 $3e $39
    ld   [wMenuStateCurrentFunction], A                ;; 02:51f7 $ea $53 $d8
    ret                                                ;; 02:51fa $c9

ds 3 ; Free space

sellToVendor:
    call getSelectedMenuIndexes                        ;; 02:51fb $cd $b0 $57
    and  A, A
    jr   NZ, call_02_522d                              ;; 02:5200 $20 $2b
    ld   A, [wWindowVendorSellItemIndex]               ;; 02:5202 $fa $76 $d8
    ld   C, A                                          ;; 02:5205 $4f
    ld   B, $00                                        ;; 02:5206 $06 $00
    ld   HL, wVendorSellPrices                         ;; 02:5208 $21 $4f $d7
    add  HL, BC                                        ;; 02:520b $09
    add  HL, BC                                        ;; 02:520c $09
    xor  A, A                                          ;; 02:520d $af
    ld   C, [HL]                                       ;; 02:520e $4e
    ld   [HL+], A                                      ;; 02:520f $22
    ld   B, [HL]                                       ;; 02:5210 $46
    ld   [HL+], A                                      ;; 02:5211 $22
    push BC                                            ;; 02:5212 $c5
    pop  HL                                            ;; 02:5213 $e1
    call addMoneyAdjustValues
    call vendorRemoveSoldItem                          ;; 02:522a $cd $3c $52
    jr   call_02_522d

ds 18 ; Free space

call_02_522d:
    xor  A, A                                          ;; 02:522d $af
    ld   [wDrawWindowStep], A                          ;; 02:522e $ea $54 $d8
    ld   A, WINDOW_VENDOR_TEXT_TOP                     ;; 02:5231 $3e $0f
    ld   [wDialogType], A                              ;; 02:5233 $ea $4a $d8
    ld   A, $81                                        ;; 02:5236 $3e $81
    ld   [wMenuStateCurrentFunction], A                ;; 02:5238 $ea $53 $d8
    ret                                                ;; 02:523b $c9

vendorRemoveSoldItem:
    ld   A, [wWindowVendorSellItemIndex]               ;; 02:523c $fa $76 $d8
    inc  A                                             ;; 02:523f $3c
    ld   C, A                                          ;; 02:5240 $4f
    ld   HL, wItemInventory                            ;; 02:5241 $21 $c5 $d6
    ld   DE, wItemInventoryAmount                      ;; 02:5244 $11 $9b $d6
    ld   B, SAVE_ITEM_INVENTORY_SIZE + 1               ;; 02:5247 $06 $11
    call vendorFindAndRemoveSoldItem                   ;; 02:5249 $cd $5c $52
    and  A, A                                          ;; 02:524c $a7
    ret  Z                                             ;; 02:524d $c8
    ld   HL, wEquipmentInventory                       ;; 02:524e $21 $dd $d6
    ld   DE, wEquipmentInventoryPowers                 ;; 02:5251 $11 $b3 $d6
    ld   B, SAVE_EQUIP_INVENTORY_SIZE + 1              ;; 02:5254 $06 $0d
    set  7, C                                          ;; 02:5256 $cb $f9
    call vendorFindAndRemoveSoldItem                   ;; 02:5258 $cd $5c $52
    ret                                                ;; 02:525b $c9

; Calls its self recursively rather than looping
vendorFindAndRemoveSoldItem:
    ld   A, [HL+]                                      ;; 02:525c $2a
    inc  DE                                            ;; 02:525d $13
    dec  B                                             ;; 02:525e $05
    jr   Z, .not_found                                 ;; 02:525f $28 $17
    and  A, $7f                                        ;; 02:5261 $e6 $7f
    jr   Z, vendorFindAndRemoveSoldItem                ;; 02:5263 $28 $f7
    call getItemOrEquipmentFlags1                      ;; 02:5265 $cd $7b $52
    bit  6, A                                          ;; 02:5268 $cb $77
    jr   NZ, vendorFindAndRemoveSoldItem               ;; 02:526a $20 $f0
    dec  C                                             ;; 02:526c $0d
    ld   A, C                                          ;; 02:526d $79
    and  A, $7f                                        ;; 02:526e $e6 $7f
    jr   NZ, vendorFindAndRemoveSoldItem               ;; 02:5270 $20 $ea
    xor  A, A                                          ;; 02:5272 $af
    dec  HL                                            ;; 02:5273 $2b
    dec  DE                                            ;; 02:5274 $1b
    ld   [HL], A                                       ;; 02:5275 $77
    ld   [DE], A                                       ;; 02:5276 $12
    ret                                                ;; 02:5277 $c9
.not_found:
    ld   A, $01                                        ;; 02:5278 $3e $01
    ret                                                ;; 02:527a $c9

getItemOrEquipmentFlags1:
    push HL                                            ;; 02:527b $e5
    ld   HL, itemDataTable + $08                       ;; 02:527c $21 $62 $5e
    bit  7, C                                          ;; 02:527f $cb $79
    jr   Z, .jr_02_5286                                ;; 02:5281 $28 $03
    ld   HL, equipmentDataTable + $08                  ;; 02:5283 $21 $f2 $61
.jr_02_5286:
    call indexIntoTable                                ;; 02:5286 $cd $82 $76
    ld   A, [HL]                                       ;; 02:5289 $7e
    pop  HL                                            ;; 02:528a $e1
    ret                                                ;; 02:528b $c9
    db   $d6, $39, $cd, $c8, $53, $c9                  ;; 02:528c ??????

call_02_5292:
    ld   A, [wMenuStateCurrentFunction]                ;; 02:5292 $fa $53 $d8
    bit  7, A                                          ;; 02:5295 $cb $7f
    jr   NZ, .jr_02_52ad                               ;; 02:5297 $20 $14
    ld   A, D                                          ;; 02:5299 $7a
    ld   [wWindowVendorSellPointerSavedY], A           ;; 02:529a $ea $d8 $d8
    ld   A, E                                          ;; 02:529d $7b
    ld   [wWindowVendorSellPointerSavedX], A           ;; 02:529e $ea $d7 $d8
    ld   A, [wD848]                                    ;; 02:52a1 $fa $48 $d8
    ld   [wD8DA], A                                    ;; 02:52a4 $ea $da $d8
    ld   A, [wD868]                                    ;; 02:52a7 $fa $68 $d8
    ld   [wD8D9], A                                    ;; 02:52aa $ea $d9 $d8
.jr_02_52ad:
    ld   A, [wSelectedMenuIndex]                       ;; 02:52ad $fa $4b $d8
    ld   [wWindowVendorSellItemIndex], A               ;; 02:52b0 $ea $76 $d8
    ld   A, $b2                                        ;; 02:52b3 $3e $b2
    ld   [wMenuStateCurrentFunction], A                ;; 02:52b5 $ea $53 $d8
    ld   A, WINDOW_VENDOR_SELL_NO                      ;; 02:52b8 $3e $10
    ld   [wDialogType], A                              ;; 02:52ba $ea $4a $d8
    call drawWindow                                    ;; 02:52bd $cd $00 $67
    ld   B, $93                                        ;; 02:52c0 $06 $93
    call setMenuStateCurrentFunction                   ;; 02:52c2 $cd $98 $6c
    ret                                                ;; 02:52c5 $c9

windowNamingEntryAddLetter:
    call getSelectedMenuIndexes                        ;; 02:52c6 $cd $b0 $57
    push DE                                            ;; 02:52c9 $d5
    push HL                                            ;; 02:52ca $e5
    ld   E, A                                          ;; 02:52cb $5f
    ld   D, $00                                        ;; 02:52cc $16 $00
    ld   HL, nameEntryInputOptions                     ;; 02:52ce $21 $01 $7e
    add  HL, DE                                        ;; 02:52d1 $19
    ld   A, [HL]                                       ;; 02:52d2 $7e
    ld   C, A                                          ;; 02:52d3 $4f
    ld   A, WINDOW_NAMING_SCREEN_TOP                   ;; 02:52d4 $3e $1d
    ld   HL, windowData.namingScreenTop                ;; 02:52d6 $21 $cc $5c
    call setActiveWindow                               ;; 02:52d9 $cd $c4 $57
    ld   DE, $208                                      ;; 02:52dc $11 $08 $02
    ld   HL, wNameEntryNameLength                      ;; 02:52df $21 $85 $d8
    ld   A, [HL]                                       ;; 02:52e2 $7e
    inc  A                                             ;; 02:52e3 $3c
; Check that the maximum length has not been reached before adding a letter.
    cp   A, SAVE_MAX_NAME_LENGTH + 1                   ;; 02:52e4 $fe $05
    jr   NC, .finished                                 ;; 02:52e6 $30 $1e
    ld   [HL], A                                       ;; 02:52e8 $77
    dec  A                                             ;; 02:52e9 $3d
    push AF                                            ;; 02:52ea $f5
    add  A, E                                          ;; 02:52eb $83
    ld   E, A                                          ;; 02:52ec $5f
    pop  AF                                            ;; 02:52ed $f1
    ld   HL, wSRAMSaveHeader                           ;; 02:52ee $21 $a7 $d7
    ld   D, $00                                        ;; 02:52f1 $16 $00
    ld   E, A                                          ;; 02:52f3 $5f
    add  HL, DE                                        ;; 02:52f4 $19
    ld   A, C                                          ;; 02:52f5 $79
    ld   [HL], A                                       ;; 02:52f6 $77
    ld   A, [wNameEntryNameLength]                     ;; 02:52f7 $fa $85 $d8
    ld   B, A                                          ;; 02:52fa $47
    ld   C, $01                                        ;; 02:52fb $0e $01
    ld   HL, wSRAMSaveHeader                           ;; 02:52fd $21 $a7 $d7
    ld   DE, $208                                      ;; 02:5300 $11 $08 $02
    call drawText                                      ;; 02:5303 $cd $77 $37
.finished:
    ld   A, WINDOW_NAMING_SCREEN_BOTTOM                ;; 02:5306 $3e $1e
    ld   HL, windowData.namingScreenBottom             ;; 02:5308 $21 $d6 $5c
    call setActiveWindow                               ;; 02:530b $cd $c4 $57
    pop  HL                                            ;; 02:530e $e1
    pop  DE                                            ;; 02:530f $d1
    ld   A, [wSelectedMenuIndex2]                      ;; 02:5310 $fa $4c $d8
    ld   [wRegisterSave1.H], A                         ;; 02:5313 $ea $a3 $d8
    ld   A, $03                                        ;; 02:5316 $3e $03
    ld   [wMenuStateCurrentFunction], A                ;; 02:5318 $ea $53 $d8
    ret                                                ;; 02:531b $c9

menuLevelupYesNoChoice:
    call getSelectedMenuIndexes                        ;; 02:531c $cd $b0 $57
    dec  A                                             ;; 02:531f $3d
    ld   B, $31                                        ;; 02:5320 $06 $31
    call setMenuStateCurrentFunction                   ;; 02:5322 $cd $98 $6c
    ret  Z                                             ;; 02:5325 $c8
    ld   B, $04                                        ;; 02:5326 $06 $04
    ld   DE, wStatStamina                              ;; 02:5328 $11 $c1 $d7
    ld   HL, wStatStaminaLevelUpTmp                    ;; 02:532b $21 $8f $d7
.loop:
    ld   A, [HL+]                                      ;; 02:532e $2a
    ld   [DE], A                                       ;; 02:532f $12
    inc  DE                                            ;; 02:5330 $13
    dec  B                                             ;; 02:5331 $05
    jr   NZ, .loop                                     ;; 02:5332 $20 $fa
    ld   H, $00                                        ;; 02:5334 $26 $00
    ld   A, [wStatStamina]                             ;; 02:5336 $fa $c1 $d7
    ld   L, A                                          ;; 02:5339 $6f
    call MultiplyHL_by_A                               ;; 02:533a $cd $7b $2b
    ld   A, $0a                                        ;; 02:533d $3e $0a
    call divMod                                        ;; 02:533f $cd $8b $2b
    ld   DE, $13                                       ;; 02:5342 $11 $13 $00
    add  HL, DE                                        ;; 02:5345 $19
    ld   DE, $3e7                                      ;; 02:5346 $11 $e7 $03
    ld   A, L                                          ;; 02:5349 $7d
    sub  A, E                                          ;; 02:534a $93
    ld   A, H                                          ;; 02:534b $7c
    sbc  A, D                                          ;; 02:534c $9a
    jr   C, .jr_02_5352                                ;; 02:534d $38 $03
; Cap HP at 999
    ld   HL, $3e7                                      ;; 02:534f $21 $e7 $03
.jr_02_5352:
    ld   A, H                                          ;; 02:5352 $7c
    ld   [wMaxHPHigh], A                               ;; 02:5353 $ea $b5 $d7
    ld   A, L                                          ;; 02:5356 $7d
    ld   [wMaxHPLow], A                                ;; 02:5357 $ea $b4 $d7
    ld   A, H                                          ;; 02:535a $7c
    ld   [wHPHigh], A                                  ;; 02:535b $ea $b3 $d7
    ld   A, L                                          ;; 02:535e $7d
    ld   [wHPLow], A                                   ;; 02:535f $ea $b2 $d7
    ld   A, [wStatWisdom]                              ;; 02:5362 $fa $c3 $d7
; The original math for MP was (((Wisdom * 94) / 100) + 5).
; This gave a max of 98 MP at 99 Wisdom, with cases where a point of Wisdom resulted in no additional MP.
; New equation is (Wisdom + 4),  capped at 99.
; The plus four keeps the same starting MP (6).
    add  A, $04

; Log message on level up.
    ld hl, debugMsgLevelUp
    call logger.hl

    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    cp   A, $63                                        ;; 02:5375 $fe $63
    jr   C, .jr_02_537b                                ;; 02:5377 $38 $02
    ld   A, $63                                        ;; 02:5379 $3e $63
.jr_02_537b:
    ld   [wMaxManaLow], A                              ;; 02:537b $ea $b8 $d7
    ld   [wManaLow], A                                 ;; 02:537e $ea $b6 $d7
    call hideAndSaveMenuMetasprites                    ;; 02:5384 $cd $51 $6b
    ld   HL, wWindowSecondaryFlags                     ;; 02:5387 $21 $72 $d8
    set  0, [HL]                                       ;; 02:538a $cb $c6
    res  1, [HL]                                       ;; 02:538c $cb $8e
    ld   A, WINDOW_STATUS_SCREEN_RIGHT                 ;; 02:538e $3e $12
    ld   [wDialogType], A                              ;; 02:5390 $ea $4a $d8
    ld   A, $01                                        ;; 02:5393 $3e $01
    ld   [wMenuStateCurrentFunction], A                ;; 02:5395 $ea $53 $d8
    ret                                                ;; 02:5398 $c9

ds 3 ; Free space

increaseLevel:
    ld   HL, wLevel                                    ;; 02:5399 $21 $ba $d7
    ld   A, [HL]                                       ;; 02:539c $7e
    inc  A                                             ;; 02:539d $3c
    ld   [HL], A                                       ;; 02:539e $77
    cp   A, $64                                        ;; 02:539f $fe $64
    call NC, capAtLevel100                             ;; 02:53a1 $d4 $b6 $53
    call setNextXPLevel                                ;; 02:53a4 $cd $a3 $3e
    ld   HL, levelUpStatChoices                        ;; 02:53a7 $21 $fe $5c
    ld   DE, wLevelUpStatChoicesCopy                   ;; 02:53aa $11 $31 $d8
    ld   B, $10                                        ;; 02:53ad $06 $10
.loop:
    ld   A, [HL+]                                      ;; 02:53af $2a
    ld   [DE], A                                       ;; 02:53b0 $12
    inc  DE                                            ;; 02:53b1 $13
    dec  B                                             ;; 02:53b2 $05
    jr   NZ, .loop                                     ;; 02:53b3 $20 $fa
    ret                                                ;; 02:53b5 $c9

capAtLevel100:
    ld   A, $63                                        ;; 02:53b6 $3e $63
    ld   [HL], A                                       ;; 02:53b8 $77
    inc  A                                             ;; 02:53b9 $3c
    ret                                                ;; 02:53ba $c9

removeItemFromInventory:
    ld   HL, wItemInventory                            ;; 02:53bb $21 $c5 $d6
    ld   DE, wItemInventoryAmount                      ;; 02:53be $11 $9b $d6
    ld   B, SAVE_ITEM_INVENTORY_SIZE                   ;; 02:53c1 $06 $10
    ld   C, A                                          ;; 02:53c3 $4f
    call removeItemFromList                            ;; 02:53c4 $cd $e2 $53
    ret                                                ;; 02:53c7 $c9

removeEquipmentFromInventory:
    ld   HL, wEquipmentInventory                       ;; 02:53c8 $21 $dd $d6
    ld   DE, wEquipmentInventoryPowers                 ;; 02:53cb $11 $b3 $d6
    ld   B, SAVE_EQUIP_INVENTORY_SIZE                  ;; 02:53ce $06 $0c
    ld   C, A                                          ;; 02:53d0 $4f
    call removeItemFromList                            ;; 02:53d1 $cd $e2 $53
    ret                                                ;; 02:53d4 $c9

removeMagicFromInventory:
    ld   HL, wMagicInventory                           ;; 02:53d5 $21 $d5 $d6
    ld   DE, wEquippedWeaponPower                      ;; 02:53d8 $11 $bf $d6
    ld   B, SAVE_MAGIC_INVENTORY_SIZE                  ;; 02:53db $06 $08
    ld   C, A                                          ;; 02:53dd $4f
    call removeItemFromList                            ;; 02:53de $cd $e2 $53
    ret                                                ;; 02:53e1 $c9

removeItemFromList:
    ld   A, [HL+]                                      ;; 02:53e2 $2a
    and  A, $7f                                        ;; 02:53e3 $e6 $7f
    cp   A, C                                          ;; 02:53e5 $b9
    jr   Z, .found                                     ;; 02:53e6 $28 $04
    dec  B                                             ;; 02:53e8 $05
    jr   NZ, removeItemFromList                        ;; 02:53e9 $20 $f7
    ret                                                ;; 02:53eb $c9
.found:
    dec  HL                                            ;; 02:53ec $2b
    xor  A, A                                          ;; 02:53ed $af
    ld   [HL], A                                       ;; 02:53ee $77
    ret                                                ;; 02:53ef $c9

giveEquipmentAndStorePowers:
    ld   B, SAVE_EQUIP_INVENTORY_SIZE                  ;; 02:53f0 $06 $0c
    ld   C, A                                          ;; 02:53f2 $4f
    ld   HL, wEquipmentInventory                       ;; 02:53f3 $21 $dd $d6
    push HL                                            ;; 02:53f6 $e5
    call giveEquipment                                 ;; 02:53f7 $cd $10 $54
    pop  HL                                            ;; 02:53fa $e1
    ld   DE, wEquipmentInventoryPowers                 ;; 02:53fb $11 $b3 $d6
    ld   B, SAVE_EQUIP_INVENTORY_SIZE                  ;; 02:53fe $06 $0c
.loop:
    ld   A, [HL+]                                      ;; 02:5400 $2a
    push HL                                            ;; 02:5401 $e5
    ld   HL, equipmentDataTable + $0c                  ;; 02:5402 $21 $f6 $61
    call indexIntoTable                                ;; 02:5405 $cd $82 $76
    ld   A, [HL]                                       ;; 02:5408 $7e
    pop  HL                                            ;; 02:5409 $e1
    ld   [DE], A                                       ;; 02:540a $12
    inc  DE                                            ;; 02:540b $13
    dec  B                                             ;; 02:540c $05
    jr   NZ, .loop                                     ;; 02:540d $20 $f1
    ret                                                ;; 02:540f $c9

giveEquipment:
    ld   DE, equipmentDataTable + $08                  ;; 02:5410 $11 $f2 $61
    push DE                                            ;; 02:5413 $d5
    ld   DE, wEquipmentInventoryPowers                 ;; 02:5414 $11 $b3 $d6
    jr   giveEquipmentItemMagic                        ;; 02:5417 $18 $1c

giveItem:
    ld   B, SAVE_ITEM_INVENTORY_SIZE                   ;; 02:5419 $06 $10
    ld   C, A                                          ;; 02:541b $4f
    ld   HL, wItemInventory                            ;; 02:541c $21 $c5 $d6
    ld   DE, itemDataTable + $08                       ;; 02:541f $11 $62 $5e
    push DE                                            ;; 02:5422 $d5
    ld   DE, wItemInventoryAmount                      ;; 02:5423 $11 $9b $d6
    jr   giveEquipmentItemMagic                        ;; 02:5426 $18 $0d

giveMagic:
    ld   B, SAVE_MAGIC_INVENTORY_SIZE                  ;; 02:5428 $06 $08
    ld   C, A                                          ;; 02:542a $4f
    ld   HL, wMagicInventory                           ;; 02:542b $21 $d5 $d6
    ld   DE, spellDataTable + $08                      ;; 02:542e $11 $e2 $5d
    push DE                                            ;; 02:5431 $d5
    ld   DE, wKnownMagicSpells                         ;; 02:5432 $11 $ab $d6

giveEquipmentItemMagic:
    ld   A, $05                                        ;; 02:5435 $3e $05
    call clearScriptFlag                               ;; 02:5437 $cd $ee $3b
    ld   A, [HL+]                                      ;; 02:543a $2a
    inc  DE                                            ;; 02:543b $13
    or   A, A                                          ;; 02:543c $b7
    jr   Z, .jr_02_5444                                ;; 02:543d $28 $05
    dec  B                                             ;; 02:543f $05
    jr   NZ, giveEquipmentItemMagic                    ;; 02:5440 $20 $f3
    jr   .cant_carry                                   ;; 02:5442 $18 $20
.jr_02_5444:
    ld   A, C                                          ;; 02:5444 $79
    dec  DE                                            ;; 02:5445 $1b
    dec  HL                                            ;; 02:5446 $2b
    ld   [HL], A                                       ;; 02:5447 $77
    pop  BC                                            ;; 02:5448 $c1
    push DE                                            ;; 02:5449 $d5
    push HL                                            ;; 02:544a $e5
    push BC                                            ;; 02:544b $c5
    pop  HL                                            ;; 02:544c $e1
    call indexIntoTable                                ;; 02:544d $cd $82 $76
    ld   A, [HL+]                                      ;; 02:5450 $2a
    ld   B, [HL]                                       ;; 02:5451 $46
    pop  HL                                            ;; 02:5452 $e1
    pop  DE                                            ;; 02:5453 $d1
    res  7, [HL]                                       ;; 02:5454 $cb $be
    bit  7, A                                          ;; 02:5456 $cb $7f
    jr   Z, .jr_02_545c                                ;; 02:5458 $28 $02
    set  7, [HL]                                       ;; 02:545a $cb $fe
.jr_02_545c:
    ld   A, B                                          ;; 02:545c $78
    and  A, $70                                        ;; 02:545d $e6 $70
    swap A                                             ;; 02:545f $cb $37
    ld   [DE], A                                       ;; 02:5461 $12
    rrca                                               ;; 02:5462 $0f
    ret                                                ;; 02:5463 $c9
.cant_carry:
    pop  DE                                            ;; 02:5464 $d1
    ld   HL, wMiscFlags                                ;; 02:5465 $21 $6f $d8
    set  1, [HL]                                       ;; 02:5468 $cb $ce
    ld   A, WINDOW_VENDOR_TEXT_TOP                     ;; 02:546a $3e $0f
    ld   [wDialogType], A                              ;; 02:546c $ea $4a $d8
    ld   A, $a7                                        ;; 02:546f $3e $a7
    ld   [wMenuStateCurrentFunction], A                ;; 02:5471 $ea $53 $d8
    ret                                                ;; 02:5474 $c9

windowVendorCantCarryOpen:
    call drawWindow                                    ;; 02:5475 $cd $00 $67
    ld   B, $28                                        ;; 02:5478 $06 $28
    call setMenuStateCurrentFunction                   ;; 02:547a $cd $98 $6c
    ret                                                ;; 02:547d $c9

windowVendorCantCarryShowText:
    ld   A, [wDialogType]                              ;; 02:547e $fa $4a $d8
    call windowInitContents                            ;; 02:5481 $cd $93 $76
    ld   HL, cantCarryTextLabel                        ;; 02:5484 $21 $10 $3f
    call drawText                                      ;; 02:5487 $cd $77 $37
    ld   A, $29                                        ;; 02:548a $3e $29
    ld   [wMenuStateCurrentFunction], A                ;; 02:548c $ea $53 $d8
    ret                                                ;; 02:548f $c9

windowVendorCantCarryWaitAnyButton:
; Joypad input is in d and e.
    ld   A, D                                          ;; 02:5493 $7a
    and  A, A                                          ;; 02:5494 $a7
    ret  Z                                             ;; 02:5495 $c8
    ld   HL, wMiscFlags                                ;; 02:5496 $21 $6f $d8
    res  1, [HL]                                       ;; 02:5499 $cb $8e
    ld   A, WINDOW_VENDOR_TEXT_TOP                     ;; 02:549b $3e $0f
    ld   [wDialogType], A                              ;; 02:549d $ea $4a $d8
    ld   A, $01                                        ;; 02:54a0 $3e $01
    ld   [wMenuStateCurrentFunction], A                ;; 02:54a2 $ea $53 $d8
    ret                                                ;; 02:54a5 $c9

ds 3 ; Free space

jp_02_54a6:
    push BC                                            ;; 02:54a6 $c5
    call call_02_55c6                                  ;; 02:54a7 $cd $c6 $55
    pop  BC                                            ;; 02:54aa $c1
    inc  C                                             ;; 02:54ab $0c
    dec  C                                             ;; 02:54ac $0d
    jp   Z, .jp_02_55bb                                ;; 02:54ad $ca $bb $55
    dec  C                                             ;; 02:54b0 $0d
    jp   NZ, windowReturnToScript                      ;; 02:54b1 $c2 $38 $56
    ld   B, $40                                        ;; 02:54b4 $06 $40
    ld   HL, wVendorSellIDs                            ;; 02:54b6 $21 $0f $d7
    push HL                                            ;; 02:54b9 $e5
    xor  A, A                                          ;; 02:54ba $af
.loop_1:
    ld   [HL+], A                                      ;; 02:54bb $22
    dec  B                                             ;; 02:54bc $05
    jr   NZ, .loop_1                                   ;; 02:54bd $20 $fc
    pop  DE                                            ;; 02:54bf $d1
    ld   C, $00                                        ;; 02:54c0 $0e $00
    ld   B, $00                                        ;; 02:54c2 $06 $00
    ld   HL, wVendorSellQuantities                     ;; 02:54c4 $21 $2f $d7
.jr_02_54c7:
    push HL                                            ;; 02:54c7 $e5
    ld   HL, wItemInventory                            ;; 02:54c8 $21 $c5 $d6
    add  HL, BC                                        ;; 02:54cb $09
    ld   A, [HL]                                       ;; 02:54cc $7e
    and  A, $7f                                        ;; 02:54cd $e6 $7f
    jr   Z, .jr_02_54f2                                ;; 02:54cf $28 $21
    push BC                                            ;; 02:54d1 $c5
    call getItemFlags1And2                             ;; 02:54d2 $cd $9c $56
    pop  BC                                            ;; 02:54d5 $c1
    bit  6, A                                          ;; 02:54d6 $cb $77
    ld   A, [HL]                                       ;; 02:54d8 $7e
    pop  HL                                            ;; 02:54d9 $e1
    jr   Z, .jr_02_54e1                                ;; 02:54da $28 $05
    xor  A, A                                          ;; 02:54dc $af
    ld   [DE], A                                       ;; 02:54dd $12
    ld   [HL], A                                       ;; 02:54de $77
    jr   .jr_02_54f3                                   ;; 02:54df $18 $12
.jr_02_54e1:
    ld   [DE], A                                       ;; 02:54e1 $12
    push HL                                            ;; 02:54e2 $e5
    ld   HL, wItemInventoryAmount                      ;; 02:54e3 $21 $9b $d6
    add  HL, BC                                        ;; 02:54e6 $09
    ld   A, [HL]                                       ;; 02:54e7 $7e
    pop  HL                                            ;; 02:54e8 $e1
    ld   [HL], A                                       ;; 02:54e9 $77
    and  A, A                                          ;; 02:54ea $a7
    jr   NZ, .jr_02_54f3                               ;; 02:54eb $20 $06
    ld   A, $01                                        ;; 02:54ed $3e $01
    ld   [HL], A                                       ;; 02:54ef $77
    jr   .jr_02_54f3                                   ;; 02:54f0 $18 $01
.jr_02_54f2:
    pop  HL                                            ;; 02:54f2 $e1
.jr_02_54f3:
    inc  HL                                            ;; 02:54f3 $23
    inc  DE                                            ;; 02:54f4 $13
    inc  C                                             ;; 02:54f5 $0c
    ld   A, C                                          ;; 02:54f6 $79
    cp   A, $10                                        ;; 02:54f7 $fe $10
    jr   NZ, .jr_02_54c7                               ;; 02:54f9 $20 $cc
    ld   C, $00                                        ;; 02:54fb $0e $00
    ld   B, $00                                        ;; 02:54fd $06 $00
.jr_02_54ff:
    push HL                                            ;; 02:54ff $e5
    ld   HL, wEquipmentInventory                       ;; 02:5500 $21 $dd $d6
    add  HL, BC                                        ;; 02:5503 $09
    ld   A, [HL]                                       ;; 02:5504 $7e
    and  A, $7f                                        ;; 02:5505 $e6 $7f
    jr   Z, .jr_02_5523                                ;; 02:5507 $28 $1a
    add  A, $39                                        ;; 02:5509 $c6 $39
    push BC                                            ;; 02:550b $c5
    call getItemFlags1And2                             ;; 02:550c $cd $9c $56
    pop  BC                                            ;; 02:550f $c1
    bit  6, A                                          ;; 02:5510 $cb $77
    ld   A, [HL]                                       ;; 02:5512 $7e
    pop  HL                                            ;; 02:5513 $e1
    jr   Z, .jr_02_551b                                ;; 02:5514 $28 $05
    xor  A, A                                          ;; 02:5516 $af
    ld   [DE], A                                       ;; 02:5517 $12
    ld   [HL], A                                       ;; 02:5518 $77
    jr   .jr_02_5524                                   ;; 02:5519 $18 $09
.jr_02_551b:
    add  A, $39                                        ;; 02:551b $c6 $39
    ld   [DE], A                                       ;; 02:551d $12
    ld   A, $01                                        ;; 02:551e $3e $01
    ld   [HL], A                                       ;; 02:5520 $77
    jr   .jr_02_5524                                   ;; 02:5521 $18 $01
.jr_02_5523:
    pop  HL                                            ;; 02:5523 $e1
.jr_02_5524:
    inc  HL                                            ;; 02:5524 $23
    inc  DE                                            ;; 02:5525 $13
    inc  C                                             ;; 02:5526 $0c
    ld   A, C                                          ;; 02:5527 $79
    cp   A, $0c                                        ;; 02:5528 $fe $0c
    jr   NZ, .jr_02_54ff                               ;; 02:552a $20 $d3
    ld   HL, wVendorSellIDs                            ;; 02:552c $21 $0f $d7
    call call_02_6ce4                                  ;; 02:552f $cd $e4 $6c
    ld   HL, wVendorSellQuantities                     ;; 02:5532 $21 $2f $d7
    call call_02_6ce4                                  ;; 02:5535 $cd $e4 $6c
    ld   HL, wVendorSellIDs                            ;; 02:5538 $21 $0f $d7
    ld   DE, wVendorSellPrices                         ;; 02:553b $11 $4f $d7
    push DE                                            ;; 02:553e $d5
    push BC                                            ;; 02:553f $c5
    ld   B, $40                                        ;; 02:5540 $06 $40
    xor  A, A                                          ;; 02:5542 $af
.loop_2:
    ld   [DE], A                                       ;; 02:5543 $12
    inc  DE                                            ;; 02:5544 $13
    dec  B                                             ;; 02:5545 $05
    jr   NZ, .loop_2                                   ;; 02:5546 $20 $fb
    pop  BC                                            ;; 02:5548 $c1
    pop  DE                                            ;; 02:5549 $d1
.jr_02_554a:
    ld   A, [HL+]                                      ;; 02:554a $2a
    and  A, $7f                                        ;; 02:554b $e6 $7f
    jr   Z, .jr_02_558e                                ;; 02:554d $28 $3f
    push HL                                            ;; 02:554f $e5
    push DE                                            ;; 02:5550 $d5
    ld   C, A                                          ;; 02:5551 $4f
    ld   HL, wVendorBuyIDs                             ;; 02:5552 $21 $f3 $d6
    ld   B, $07                                        ;; 02:5555 $06 $07
.loop_3:
    ld   A, [HL+]                                      ;; 02:5557 $2a
    cp   A, C                                          ;; 02:5558 $b9
    jr   Z, .jr_02_5564                                ;; 02:5559 $28 $09
    dec  B                                             ;; 02:555b $05
    jr   NZ, .loop_3                                   ;; 02:555c $20 $f9
    ld   A, C                                          ;; 02:555e $79
    call getBuyFromVendorPrice                         ;; 02:555f $cd $b1 $56
    jr   .jr_02_5572                                   ;; 02:5562 $18 $0e
.jr_02_5564:
    ld   A, $07                                        ;; 02:5564 $3e $07
    sub  A, B                                          ;; 02:5566 $90
    ld   E, A                                          ;; 02:5567 $5f
    ld   D, $00                                        ;; 02:5568 $16 $00
    ld   HL, wVendorBuyPrices                          ;; 02:556a $21 $01 $d7
    add  HL, DE                                        ;; 02:556d $19
    add  HL, DE                                        ;; 02:556e $19
    ld   A, [HL+]                                      ;; 02:556f $2a
    ld   H, [HL]                                       ;; 02:5570 $66
    ld   L, A                                          ;; 02:5571 $6f
.jr_02_5572:
    srl  H                                             ;; 02:5572 $cb $3c
    rr   L                                             ;; 02:5574 $cb $1d
    push HL                                            ;; 02:5576 $e5
    ld   A, C                                          ;; 02:5577 $79
    call getItemFlags1And2                             ;; 02:5578 $cd $9c $56
    ld   A, B                                          ;; 02:557b $78
    and  A, $70                                        ;; 02:557c $e6 $70
    swap A                                             ;; 02:557e $cb $37
    pop  HL                                            ;; 02:5580 $e1
    call divMod                                        ;; 02:5581 $cd $8b $2b
    pop  DE                                            ;; 02:5584 $d1
    ld   A, L                                          ;; 02:5585 $7d
    ld   [DE], A                                       ;; 02:5586 $12
    inc  DE                                            ;; 02:5587 $13
    ld   A, H                                          ;; 02:5588 $7c
    ld   [DE], A                                       ;; 02:5589 $12
    inc  DE                                            ;; 02:558a $13
    pop  HL                                            ;; 02:558b $e1
    jr   .jr_02_554a                                   ;; 02:558c $18 $bc
.jr_02_558e:
    ld   HL, wVendorSellPrices                         ;; 02:558e $21 $4f $d7
    ld   DE, wVendorSellQuantities                     ;; 02:5591 $11 $2f $d7
.jr_02_5594:
    ld   A, [DE]                                       ;; 02:5594 $1a
    and  A, A                                          ;; 02:5595 $a7
    jr   Z, .jr_02_55b0                                ;; 02:5596 $28 $18
    inc  DE                                            ;; 02:5598 $13
    push AF                                            ;; 02:5599 $f5
    ld   C, [HL]                                       ;; 02:559a $4e
    inc  HL                                            ;; 02:559b $23
    ld   B, [HL]                                       ;; 02:559c $46
    dec  HL                                            ;; 02:559d $2b
    pop  AF                                            ;; 02:559e $f1
    push HL                                            ;; 02:559f $e5
    push BC                                            ;; 02:55a0 $c5
    pop  HL                                            ;; 02:55a1 $e1
    push DE                                            ;; 02:55a2 $d5
    call MultiplyHL_by_A                               ;; 02:55a3 $cd $7b $2b
    pop  DE                                            ;; 02:55a6 $d1
    push HL                                            ;; 02:55a7 $e5
    pop  BC                                            ;; 02:55a8 $c1
    pop  HL                                            ;; 02:55a9 $e1
    ld   [HL], C                                       ;; 02:55aa $71
    inc  HL                                            ;; 02:55ab $23
    ld   [HL], B                                       ;; 02:55ac $70
    inc  HL                                            ;; 02:55ad $23
    jr   .jr_02_5594                                   ;; 02:55ae $18 $e4
.jr_02_55b0:
    ld   A, WINDOW_VENDOR_SELL_TOP                     ;; 02:55b0 $3e $0d
    ld   [wDialogType], A                              ;; 02:55b2 $ea $4a $d8
    ld   A, $81                                        ;; 02:55b5 $3e $81
    ld   [wMenuStateCurrentFunction], A                ;; 02:55b7 $ea $53 $d8
    ret                                                ;; 02:55ba $c9
.jp_02_55bb:
    ld   A, WINDOW_VENDOR_BUY_TOP                      ;; 02:55bb $3e $0e
    ld   [wDialogType], A                              ;; 02:55bd $ea $4a $d8
    ld   B, $81                                        ;; 02:55c0 $06 $81
    call setMenuStateCurrentFunction                   ;; 02:55c2 $cd $98 $6c
    ret                                                ;; 02:55c5 $c9

call_02_55c6:
    ld   A, [wVendorNumber]                            ;; 02:55c6 $fa $6d $d8
    ld   L, A                                          ;; 02:55c9 $6f
    ld   H, $00                                        ;; 02:55ca $26 $00
    add  HL, HL                                        ;; 02:55cc $29
    add  HL, HL                                        ;; 02:55cd $29
    add  HL, HL                                        ;; 02:55ce $29
    add  HL, HL                                        ;; 02:55cf $29
    push HL                                            ;; 02:55d0 $e5
    pop  BC                                            ;; 02:55d1 $c1
    ld   HL, vendorInventories + $02                   ;; 02:55d2 $21 $ec $64
    add  HL, BC                                        ;; 02:55d5 $09
    ld   B, $07                                        ;; 02:55d6 $06 $07
    ld   DE, $00                                       ;; 02:55d8 $11 $00 $00
.loop_1:
    ld   A, [HL+]                                      ;; 02:55db $2a
    push HL                                            ;; 02:55dc $e5
    inc  A                                             ;; 02:55dd $3c
    jr   NZ, .jr_02_55e2                               ;; 02:55de $20 $02
    ld   A, $80                                        ;; 02:55e0 $3e $80
.jr_02_55e2:
    ld   HL, wVendorBuyIDs                             ;; 02:55e2 $21 $f3 $d6
    add  HL, DE                                        ;; 02:55e5 $19
    ld   [HL], A                                       ;; 02:55e6 $77
    pop  HL                                            ;; 02:55e7 $e1
    ld   A, [HL+]                                      ;; 02:55e8 $2a
    push HL                                            ;; 02:55e9 $e5
    ld   HL, wVendorBuyQuantities                      ;; 02:55ea $21 $fa $d6
    add  HL, DE                                        ;; 02:55ed $19
    ld   [HL], A                                       ;; 02:55ee $77
    pop  HL                                            ;; 02:55ef $e1
    inc  DE                                            ;; 02:55f0 $13
    dec  B                                             ;; 02:55f1 $05
    jr   NZ, .loop_1                                   ;; 02:55f2 $20 $e7
    ld   B, $07                                        ;; 02:55f4 $06 $07
    ld   C, $00                                        ;; 02:55f6 $0e $00
.loop_2:
    push BC                                            ;; 02:55f8 $c5
    ld   B, $00                                        ;; 02:55f9 $06 $00
    ld   HL, wVendorBuyIDs                             ;; 02:55fb $21 $f3 $d6
    add  HL, BC                                        ;; 02:55fe $09
    ld   A, [HL]                                       ;; 02:55ff $7e
    call getBuyFromVendorPrice                         ;; 02:5600 $cd $b1 $56
    push HL                                            ;; 02:5603 $e5
    pop  DE                                            ;; 02:5604 $d1
    ld   HL, wVendorBuyPrices                          ;; 02:5605 $21 $01 $d7
    add  HL, BC                                        ;; 02:5608 $09
    add  HL, BC                                        ;; 02:5609 $09
    ld   [HL], E                                       ;; 02:560a $73
    inc  HL                                            ;; 02:560b $23
    ld   [HL], D                                       ;; 02:560c $72
    pop  BC                                            ;; 02:560d $c1
    inc  C                                             ;; 02:560e $0c
    dec  B                                             ;; 02:560f $05
    jr   NZ, .loop_2                                   ;; 02:5610 $20 $e6
    ld   B, $07                                        ;; 02:5612 $06 $07
    ld   C, $00                                        ;; 02:5614 $0e $00
.loop_3:
    push BC                                            ;; 02:5616 $c5
    ld   B, $00                                        ;; 02:5617 $06 $00
    ld   HL, wVendorBuyIDs                             ;; 02:5619 $21 $f3 $d6
    add  HL, BC                                        ;; 02:561c $09
    ld   A, [HL]                                       ;; 02:561d $7e
    push BC                                            ;; 02:561e $c5
    call getItemFlags1And2                             ;; 02:561f $cd $9c $56
    ld   A, C                                          ;; 02:5622 $79
    and  A, $80                                        ;; 02:5623 $e6 $80
    or   A, [HL]                                       ;; 02:5625 $b6
    ld   [HL], A                                       ;; 02:5626 $77
    ld   A, B                                          ;; 02:5627 $78
    pop  BC                                            ;; 02:5628 $c1
    and  A, $70                                        ;; 02:5629 $e6 $70
    swap A                                             ;; 02:562b $cb $37
    ld   HL, wVendorBuyQuantities                      ;; 02:562d $21 $fa $d6
    add  HL, BC                                        ;; 02:5630 $09
    ld   [HL], A                                       ;; 02:5631 $77
    pop  BC                                            ;; 02:5632 $c1
    inc  C                                             ;; 02:5633 $0c
    dec  B                                             ;; 02:5634 $05
    jr   NZ, .loop_3                                   ;; 02:5635 $20 $df
    ret                                                ;; 02:5637 $c9

; Used by script triggered windows (naming, save/load, and status) to continue the script.
windowReturnToScript:
    ld   A, [wWindowMainGameStateBackup]               ;; 02:5638 $fa $62 $d8
    ld   [wMainGameState], A                           ;; 02:563b $ea $a0 $c0
    ld   A, $05                                        ;; 02:563e $3e $05
    ld   [wVirtualScriptOpCodeFFArgument], A           ;; 02:5640 $ea $6b $d8
    ld   A, $ff                                        ;; 02:5643 $3e $ff
    ld   [wScriptCommand], A                           ;; 02:5645 $ea $5a $d8
    call clearSaveLoadScreen                           ;; 02:5648 $cd $4c $56
    ret                                                ;; 02:564b $c9

clearSaveLoadScreen:
    call hideAndSaveMenuMetasprites                    ;; 02:5658 $cd $51 $6b
; Clear the second screen, except the first two lines where the HUD will be drawn.
    ld hl, _SCRN1 + 2 * SCRN_VX_B
    ld b, SCRN_Y_B - $02
    call clearVRAMArea                                 ;; 02:5660 $cd $6a $56
    call drawDefaultStatusBar                          ;; 02:564c $cd $16 $6f
    call drawHPOnStatusBar_trampoline                  ;; 02:564f $cd $29 $6f
    call drawManaOnStatusBar_trampoline                ;; 02:5652 $cd $3f $6f
    call drawMoneyOnStatusBar_trampoline
    call drawEmptyWillBar                              ;; 02:5663 $cd $fa $65
    call drawWillBarCharge                             ;; 02:5666 $cd $23 $66
    ret                                                ;; 02:5669 $c9

; This clears a section of VRAM. This code takes a rather brute-force approach.
; Originally it cleared the entire memory area even though the part past the 20th tile on a line was never used.
; It also used a the VBlank tile transfer function to transfer tile ids, which is why it was worth rewriting.
; Its fake tile was not aligned to a 16 byte boundary, which prevented optimizing VBlank tile transfer.
; b = number of lines of tiles to clear.
; hl = VRAM address to begin at.
clearVRAMArea:
    ld   A, $7f                                        ;; 02:566a $3e $7f
; de is used to skip from the end of one line to the beginning of the next.
    ld de, $0020 - $0014
.loop_outer:
    ld c, $14
.loop_inner:
; Rather than checking PPU mode this loop just keeps trying to write until successful.
    ld [hl], a
    cp [hl]
    jr nz, .loop_inner
    inc hl
    dec c
    jr nz, .loop_inner
    add hl, de
    dec b
    jr nz, .loop_outer
    ret

ds 12 ; Free space

getEquipmentFlags1And2:
    or   A, A                                          ;; 02:568a $b7
    jr   Z, jr_02_56ad                                 ;; 02:568b $28 $20
    ld   B, A                                          ;; 02:568d $47
    ld   A, [wDialogType]                              ;; 02:568e $fa $4a $d8
    cp   A, WINDOW_ITEMS                               ;; 02:5691 $fe $01
    ld   A, B                                          ;; 02:5693 $78
    jr   Z, getItemFlags1And2                          ;; 02:5694 $28 $06
    push HL                                            ;; 02:5696 $e5
    ld   HL, equipmentDataTable + $08                  ;; 02:5697 $21 $f2 $61
    jr   jr_02_56a3                                    ;; 02:569a $18 $07

getItemFlags1And2:
    or   A, A                                          ;; 02:569c $b7
    jr   Z, jr_02_56ad                                 ;; 02:569d $28 $0e
    push HL                                            ;; 02:569f $e5
    ld   HL, itemDataTable + $08                       ;; 02:56a0 $21 $62 $5e

jr_02_56a3:
    and  A, $7f                                        ;; 02:56a3 $e6 $7f
    call indexIntoTable                                ;; 02:56a5 $cd $82 $76
    ld   A, [HL+]                                      ;; 02:56a8 $2a
    ld   C, A                                          ;; 02:56a9 $4f
    ld   B, [HL]                                       ;; 02:56aa $46
    pop  HL                                            ;; 02:56ab $e1
    ret                                                ;; 02:56ac $c9

jr_02_56ad:
    ld   A, $ff                                        ;; 02:56ad $3e $ff
    ld   C, A                                          ;; 02:56af $4f
    ret                                                ;; 02:56b0 $c9

getBuyFromVendorPrice:
    ld   HL, $00                                       ;; 02:56b1 $21 $00 $00
    and  A, $7f                                        ;; 02:56b4 $e6 $7f
    ret  Z                                             ;; 02:56b6 $c8
    ld   HL, itemDataTable + $0d                       ;; 02:56b7 $21 $67 $5e
    call indexIntoTable                                ;; 02:56ba $cd $82 $76
    ld   A, [HL+]                                      ;; 02:56bd $2a
    ld   H, [HL]                                       ;; 02:56be $66
    ld   L, A                                          ;; 02:56bf $6f
    ret                                                ;; 02:56c0 $c9

jp_02_56c1:
    call playWindowErrorSound                          ;; 02:56c1 $cd $1f $7a
    ld   A, [wSelectedMenuIndex]                       ;; 02:56c4 $fa $4b $d8
    ld   H, A                                          ;; 02:56c7 $67
    ret                                                ;; 02:56c8 $c9

call_02_56c9:
    call loadRegisterState1                            ;; 02:56c9 $cd $5b $6d
    ld   A, [wD860]                                    ;; 02:56cc $fa $60 $d8
    and  A, $80                                        ;; 02:56cf $e6 $80
    jr   NZ, .jr_02_56f5                               ;; 02:56d1 $20 $22
    call showMenuFingerCurled                          ;; 02:56d3 $cd $ad $6b
    ld   A, [wD898]                                    ;; 02:56d6 $fa $98 $d8
    cp   A, E                                          ;; 02:56d9 $bb
    jr   NZ, .jr_02_56e0                               ;; 02:56da $20 $04
    ld   A, [wD899]                                    ;; 02:56dc $fa $99 $d8
    cp   A, D                                          ;; 02:56df $ba
.jr_02_56e0:
    call NZ, call_02_6b20                              ;; 02:56e0 $c4 $20 $6b
    call updateJoypadInput
    bit  4, C                                          ;; 02:56e6 $cb $61
    ret  NZ                                            ;; 02:56e8 $c0
    call showMenuFingerPointing_1                      ;; 02:56e9 $cd $be $6b
    ld   A, [wD860]                                    ;; 02:56ec $fa $60 $d8
    or   A, $80                                        ;; 02:56ef $f6 $80
    ld   [wD860], A                                    ;; 02:56f1 $ea $60 $d8
    ret                                                ;; 02:56f4 $c9
.jr_02_56f5:
    ld   A, [wD860]                                    ;; 02:56f5 $fa $60 $d8
    and  A, $7f                                        ;; 02:56f8 $e6 $7f
    dec  A                                             ;; 02:56fa $3d
    push AF                                            ;; 02:56fb $f5
    or   A, $80                                        ;; 02:56fc $f6 $80
    ld   [wD860], A                                    ;; 02:56fe $ea $60 $d8
    pop  AF                                            ;; 02:5701 $f1
    ret  NZ                                            ;; 02:5702 $c0
    ld   A, $01                                        ;; 02:5703 $3e $01
    ld   [wD860], A                                    ;; 02:5705 $ea $60 $d8
    ret                                                ;; 02:5708 $c9

call_02_5709:
    ld   B, $01                                        ;; 02:5709 $06 $01
    call setMenuStateCurrentFunction                   ;; 02:570b $cd $98 $6c
    ld   A, [wSelectedMenuIndex]                       ;; 02:570e $fa $4b $d8
    inc  A                                             ;; 02:5711 $3c
    ld   B, A                                          ;; 02:5712 $47
    ld   A, [wDialogType]                              ;; 02:5713 $fa $4a $d8
    ld   C, A                                          ;; 02:5716 $4f
    cp   A, WINDOW_START_MENU                          ;; 02:5717 $fe $00
    jr   NZ, .jr_02_5734                               ;; 02:5719 $20 $19
    ld   A, B                                          ;; 02:571b $78
    ld   [wDialogType], A                              ;; 02:571c $ea $4a $d8
    cp   A, WINDOW_EQUIP_BOTTOM                        ;; 02:571f $fe $04
    ret  NZ                                            ;; 02:5721 $c0
    ld   B, $00                                        ;; 02:5722 $06 $00
    call setMenuStateCurrentFunction                   ;; 02:5724 $cd $98 $6c
    call getFollowerScript                             ;; 02:5727 $cd $0d $29
    ld   A, L                                          ;; 02:572a $7d
    or   A, H                                          ;; 02:572b $b4
    jr   NZ, .jr_02_5730                               ;; 02:572c $20 $02
    ld   L, $20                                        ;; 02:572e $2e $20
.jr_02_5730:
    call runScriptByIndex                              ;; 02:5730 $cd $ad $31
    ret                                                ;; 02:5733 $c9
.jr_02_5734:
    ld   A, C                                          ;; 02:5734 $79
    ld   [wSelectedMenuIndex], A                       ;; 02:5735 $ea $4b $d8
    ld   A, [wSelectedMenuIndex2]                      ;; 02:5738 $fa $4c $d8
    ld   C, A                                          ;; 02:573b $4f
    ld   B, $00                                        ;; 02:573c $06 $00
    ld   A, [wWindowSecondPointer.high]                ;; 02:573e $fa $95 $d8
    ld   H, A                                          ;; 02:5741 $67
    ld   A, [wWindowSecondPointer]                     ;; 02:5742 $fa $94 $d8
    ld   L, A                                          ;; 02:5745 $6f
    add  HL, BC                                        ;; 02:5746 $09
    ld   A, [HL]                                       ;; 02:5747 $7e
    ld   [wSelectedMenuIndex2], A                      ;; 02:5748 $ea $4c $d8
    push HL                                            ;; 02:574b $e5
    ld   A, [wWindowFirstPointer.high]                 ;; 02:574c $fa $93 $d8
    ld   H, A                                          ;; 02:574f $67
    ld   A, [wWindowFirstPointer]                      ;; 02:5750 $fa $92 $d8
    ld   L, A                                          ;; 02:5753 $6f
    add  HL, BC                                        ;; 02:5754 $09
    ld   A, [HL]                                       ;; 02:5755 $7e
    push AF                                            ;; 02:5756 $f5
    ld   A, [wEquippedItem]                            ;; 02:5757 $fa $ef $d6
    cp   A, $80                                        ;; 02:575a $fe $80
    jr   Z, .jr_02_5781                                ;; 02:575c $28 $23
    ld   HL, wItemInventory                            ;; 02:575e $21 $c5 $d6
    ld   DE, wItemInventoryAmount                      ;; 02:5761 $11 $9b $d6
    ld   B, $18                                        ;; 02:5764 $06 $18
.loop:
    ld   A, [HL+]                                      ;; 02:5766 $2a
    inc  DE                                            ;; 02:5767 $13
    cp   A, $80                                        ;; 02:5768 $fe $80
    jr   Z, .break                                     ;; 02:576a $28 $03
    dec  B                                             ;; 02:576c $05
    jr   NZ, .loop                                     ;; 02:576d $20 $f7
.break:
    ld   A, [wEquippedItem]                            ;; 02:576f $fa $ef $d6
    cp   A, $09                                        ;; 02:5772 $fe $09
    jr   C, .jr_02_5778                                ;; 02:5774 $38 $02
    sub  A, $08                                        ;; 02:5776 $d6 $08
.jr_02_5778:
    dec  HL                                            ;; 02:5778 $2b
    ld   [HL], A                                       ;; 02:5779 $77
    dec  DE                                            ;; 02:577a $1b
    ld   A, [wEquippedItemAmount]                      ;; 02:577b $fa $f0 $d6
    ld   [DE], A                                       ;; 02:577e $12
    jr   .jr_02_578f                                   ;; 02:577f $18 $0e
.jr_02_5781:
    ld   [HL], A                                       ;; 02:5781 $77
    ld   A, [wWindowFirstPointer.high]                 ;; 02:5782 $fa $93 $d8
    ld   H, A                                          ;; 02:5785 $67
    ld   A, [wWindowFirstPointer]                      ;; 02:5786 $fa $92 $d8
    ld   L, A                                          ;; 02:5789 $6f
    add  HL, BC                                        ;; 02:578a $09
    ld   A, [wEquippedItemAmount]                      ;; 02:578b $fa $f0 $d6
    ld   [HL], A                                       ;; 02:578e $77
.jr_02_578f:
    pop  AF                                            ;; 02:578f $f1
    ld   [wEquippedItemAmount], A                      ;; 02:5790 $ea $f0 $d6
    pop  HL                                            ;; 02:5793 $e1
    ld   A, $80                                        ;; 02:5794 $3e $80
    ld   [HL], A                                       ;; 02:5796 $77
    ld   B, $12                                        ;; 02:5797 $06 $12
    call setMenuStateCurrentFunction                   ;; 02:5799 $cd $98 $6c
    call saveRegisterState1                            ;; 02:579c $cd $34 $6d
    ret                                                ;; 02:579f $c9

call_02_57a0:
    call hideAndSaveMenuMetasprites                    ;; 02:57a0 $cd $51 $6b
    call windowCloseAndRestoreHidden                   ;; 02:57a3 $cd $7a $66
    ld   B, $23                                        ;; 02:57a6 $06 $23
    ld   A, B                                          ;; 02:57a8 $78
    ld   [wD85E], A                                    ;; 02:57a9 $ea $5e $d8
    call setMenuStateCurrentFunction                   ;; 02:57ac $cd $98 $6c
    ret                                                ;; 02:57af $c9

getSelectedMenuIndexes:
    ld   A, [wSelectedMenuIndex]                       ;; 02:57b0 $fa $4b $d8
    ld   B, A                                          ;; 02:57b3 $47
    ld   A, [wSelectedMenuIndex2]                      ;; 02:57b4 $fa $4c $d8
    ld   C, A                                          ;; 02:57b7 $4f
    ret                                                ;; 02:57b8 $c9

; On the Equipment screen the top window is drawn in front but the bottom window is the menu.
windowEquipScreenSetBottomWindowActive:
    ld   A, WINDOW_EQUIP_BOTTOM                        ;; 02:57b9 $3e $04
    push AF                                            ;; 02:57bb $f5
    ld   HL, windowData.equipmentScreenBottom          ;; 02:57bc $21 $d2 $5b
    call setActiveWindow                               ;; 02:57bf $cd $c4 $57
    pop  AF                                            ;; 02:57c2 $f1
    ret                                                ;; 02:57c3 $c9

; Used when multiple windows are active to switch which one will be drawn to.
; a = window number
; hl = window data pointer
setActiveWindow:
    push DE                                            ;; 02:57c4 $d5
    push BC                                            ;; 02:57c5 $c5
    ld   [wDialogType], A                              ;; 02:57c6 $ea $4a $d8
    ld   E, [HL]                                       ;; 02:57c9 $5e
    inc  HL                                            ;; 02:57ca $23
    ld   D, [HL]                                       ;; 02:57cb $56
    inc  HL                                            ;; 02:57cc $23
    ld   C, [HL]                                       ;; 02:57cd $4e
    inc  HL                                            ;; 02:57ce $23
    ld   B, [HL]                                       ;; 02:57cf $46
    call setWindowDimensions                           ;; 02:57d0 $cd $73 $7a
    pop  BC                                            ;; 02:57d3 $c1
    pop  DE                                            ;; 02:57d4 $d1
    ret                                                ;; 02:57d5 $c9

calulateAPDP:
    ld   A, [wStatusEffect]                            ;; 02:57d6 $fa $c0 $d7
    bit  3, A                                          ;; 02:57d9 $cb $5f
    ret  NZ                                            ;; 02:57db $c0
    call getEquippedWeaponAP                           ;; 02:57dc $cd $9d $5b
    ld   B, A                                          ;; 02:57df $47
    ld   A, [wStatPower]                               ;; 02:57e0 $fa $c2 $d7
    add  A, B                                          ;; 02:57e3 $80
    ld   [wDupTotalAP], A                              ;; 02:57e4 $ea $c1 $d6
    ld   [wTotalAP], A                                 ;; 02:57e7 $ea $df $d7
    ld   A, [wEquippedHelmetDefense]                   ;; 02:57ea $fa $c0 $d6
    ld   B, A                                          ;; 02:57ed $47
    ld   A, [wEquippedArmorDefense]                    ;; 02:57ee $fa $c2 $d6
    ld   C, A                                          ;; 02:57f1 $4f
    ld   A, [wStatStamina]                             ;; 02:57f2 $fa $c1 $d7
    add  A, B                                          ;; 02:57f5 $80
    add  A, C                                          ;; 02:57f6 $81
    ld   [wDupTotalDP], A                              ;; 02:57f7 $ea $c3 $d6
    ld   [wTotalDP], A                                 ;; 02:57fa $ea $e0 $d7
    ret                                                ;; 02:57fd $c9

call_02_57fe:
    ld   A, [wD843]                                    ;; 02:57fe $fa $43 $d8
    ld   [wD848], A                                    ;; 02:5801 $ea $48 $d8
    ld   [wD846], A                                    ;; 02:5804 $ea $46 $d8
    ld   DE, $202                                      ;; 02:5807 $11 $02 $02
    ret                                                ;; 02:580a $c9

; Handles swapping slots in ITEM or EQUIP
inventoryMoveItems:
    ld   A, [wWindowSecondPointer.high]                ;; 02:580b $fa $95 $d8
    ld   H, A                                          ;; 02:580e $67
    ld   A, [wWindowSecondPointer]                     ;; 02:580f $fa $94 $d8
    ld   L, A                                          ;; 02:5812 $6f
    call .swap                                         ;; 02:5813 $cd $22 $58
    ld   A, [wWindowFirstPointer.high]                 ;; 02:5816 $fa $93 $d8
    ld   H, A                                          ;; 02:5819 $67
    ld   A, [wWindowFirstPointer]                      ;; 02:581a $fa $92 $d8
    ld   L, A                                          ;; 02:581d $6f
    call .swap                                         ;; 02:581e $cd $22 $58
    ret                                                ;; 02:5821 $c9
.swap:
    push DE                                            ;; 02:5822 $d5
    push HL                                            ;; 02:5823 $e5
    ld   A, [wSelectedMenuIndex]                       ;; 02:5824 $fa $4b $d8
    ld   C, A                                          ;; 02:5827 $4f
    ld   B, $00                                        ;; 02:5828 $06 $00
    add  HL, BC                                        ;; 02:582a $09
    ld   D, H                                          ;; 02:582b $54
    ld   E, L                                          ;; 02:582c $5d
    pop  HL                                            ;; 02:582d $e1
    ld   A, [wSelectedMenuIndex2]                      ;; 02:582e $fa $4c $d8
    ld   C, A                                          ;; 02:5831 $4f
    ld   B, $00                                        ;; 02:5832 $06 $00
    add  HL, BC                                        ;; 02:5834 $09
    ld   A, [DE]                                       ;; 02:5835 $1a
    ld   B, [HL]                                       ;; 02:5836 $46
    ld   [HL], A                                       ;; 02:5837 $77
    ld   A, B                                          ;; 02:5838 $78
    ld   [DE], A                                       ;; 02:5839 $12
    pop  DE                                            ;; 02:583a $d1
    ret                                                ;; 02:583b $c9

findSlotForEquipmentType:
    ld   HL, wEquipmentInventory                       ;; 02:583d $21 $dd $d6
    ld   A, [wSelectedMenuIndex2]                      ;; 02:5840 $fa $4c $d8
    ld   E, A
    ld   D, $00
    add  HL, DE
    ld   A, [HL]                                       ;; 02:5847 $7e
    and A, A
    ret Z ; Return early for invalid selection
    ld   HL, equipmentDataTable + $09                  ;; 02:5848 $21 $f3 $61
    call indexIntoTable                                ;; 02:584b $cd $82 $76
    ld   A, [HL]                                       ;; 02:584e $7e
    and  A, $0f                                        ;; 02:584f $e6 $0f
    ld   HL, .equipmentTypeFlags                       ;; 02:5851 $21 $63 $58
.loop:
    cp   A, [HL]                                       ;; 02:5855 $be
    jr   Z, .found                                     ;; 02:5856 $28 $05
    inc  HL                                            ;; 02:5858 $23
    inc  BC                                            ;; 02:5859 $03
    inc  BC                                            ;; 02:585a $03
    jr   .loop                                         ;; 02:585b $18 $f8
.found:
    ld   A, [BC]                                       ;; 02:585d $0a
    ld   E, A                                          ;; 02:585e $5f
    inc  BC                                            ;; 02:585f $03
    ld   A, [BC]                                       ;; 02:5860 $0a
    ld   D, A                                          ;; 02:5861 $57
    ret                                                ;; 02:5862 $c9
; 1=weapon, 2=armor, 4=helm, 8=shield
.equipmentTypeFlags:
    db   $01, $02, $04, $08                            ;; 02:5863 ????

;@data format=p amount=4
currentlyEquippedEquipmentPowerList:
    dw   wEquippedWeaponPower                          ;; 02:5867 pP $00
    dw   wEquippedArmorDefense                         ;; 02:5869 ?? $01
    dw   wEquippedHelmetDefense                        ;; 02:586b ?? $02
    dw   $d6c4                                         ;; 02:586d ?? $03

;@data format=p amount=4
currentlyEquippedEquipmentList:
    dw   wEquippedWeapon                               ;; 02:586f pP $00
    dw   wEquippedArmor                                ;; 02:5871 ?? $01
    dw   wEquippedHelm                                 ;; 02:5873 ?? $02
    dw   wEquippedShield                               ;; 02:5875 ?? $03

jp_02_5877:
    ld   [wMenuStateFunctionNew], A                    ;; 02:5877 $ea $50 $d8
    ld   A, [wDialogType]                              ;; 02:587a $fa $4a $d8
    call calulateAPDP                                  ;; 02:587d $cd $d6 $57

call_02_5880:
    ld   A, [wWindowTextLength]                        ;; 02:5880 $fa $9b $d8
    ld   B, A                                          ;; 02:5883 $47
    ld   A, [wWindowTextRows]                          ;; 02:5884 $fa $9a $d8
    ld   C, A                                          ;; 02:5887 $4f
    ld   A, B                                          ;; 02:5888 $78
    ld   [wRegisterSave2.B], A                         ;; 02:5889 $ea $af $d8
    ld   A, C                                          ;; 02:588c $79
    ld   [wRegisterSave2.C], A                         ;; 02:588d $ea $ae $d8
    ld   A, $17                                        ;; 02:5890 $3e $17
    ld   [wMenuStateCurrentFunction], A                ;; 02:5892 $ea $53 $d8

call_02_5895:
    ld   A, [wDialogType]                              ;; 02:5895 $fa $4a $d8
    ld   B, A                                          ;; 02:5898 $47
    ld   HL, .windows                                  ;; 02:5899 $21 $a7 $58
.loop:
    ld   A, [HL+]                                      ;; 02:589c $2a
    inc  A                                             ;; 02:589d $3c
    jr   Z, .not_matched                               ;; 02:589e $28 $17
    dec  A                                             ;; 02:58a0 $3d
    cp   A, B                                          ;; 02:58a1 $b8
    jr   NZ, .loop                                     ;; 02:58a2 $20 $f8
    jp   jp_02_5b2c                                    ;; 02:58a4 $c3 $2c $5b
.windows:
    db WINDOW_START_MENU
    db WINDOW_DIALOG_YES_NO
    db WINDOW_VENDOR_BUY_SELL_EXIT
    db WINDOW_VENDOR_SELL_NO
    db WINDOW_SELECT_MENU
    db WINDOW_VENDOR_TEXT_TOP
    db WINDOW_STATUS_SCREEN_RIGHT
    db WINDOW_STATUS_SCREEN_HP_MP
    db WINDOW_LEVELUP_MESSAGE
    db WINDOW_LEVELUP_JOBS
    db WINDOW_LEVELUP_YES_NO
    db WINDOW_NAMING_SCREEN_TOP
    db WINDOW_NAMING_SCREEN_BOTTOM
    db WINDOW_TITLE_SCREEN
    db WINDOW_LEVELUP_FANFARE
    db $ff
.not_matched:
    ld   A, B                                          ;; 02:58b7 $78
    cp   A, WINDOW_STATUS_SCREEN_TOP                   ;; 02:58b8 $fe $15
    jp   Z, jp_02_5959                                 ;; 02:58ba $ca $59 $59
    cp   A, WINDOW_STATUS_SCREEN_MONEY                 ;; 02:58bd $fe $13
    jp   Z, .jp_02_58d6                                ;; 02:58bf $ca $d6 $58
    cp   A, WINDOW_START_MENU_STATUS                   ;; 02:58c2 $fe $09
    jp   Z, jp_02_5aac                                 ;; 02:58c4 $ca $ac $5a
    cp   A, WINDOW_SAVE_LOAD_FILE_1                    ;; 02:58c7 $fe $1b
    jp   Z, drawLoadSaveWindowContents_top             ;; 02:58c9 $ca $62 $5a
    cp   A, WINDOW_SAVE_LOAD_FILE_2                    ;; 02:58cc $fe $1c
    jp   Z, drawLoadSaveWindowContents_bottom          ;; 02:58ce $ca $69 $5a
    cp   A, WINDOW_VENDOR_MONEY                        ;; 02:58d1 $fe $0c
    jp   NZ, .jp_02_58db                               ;; 02:58d3 $c2 $db $58
.jp_02_58d6:
    call drawMoneyOnDialog                             ;; 02:58d6 $cd $f4 $75
    jr   jp_02_5922                                    ;; 02:58d9 $18 $47
.jp_02_58db:
    call loadRegisterState2                            ;; 02:58db $cd $a7 $6d
    ld   A, C                                          ;; 02:58de $79
    and  A, A                                          ;; 02:58df $a7
    jr   Z, jp_02_5922                                 ;; 02:58e0 $28 $40
    push BC                                            ;; 02:58e2 $c5
    ld   A, [wWindowNumberOfSelections]                ;; 02:58e3 $fa $45 $d8
    ld   B, A                                          ;; 02:58e6 $47
    ld   A, [wD846]                                    ;; 02:58e7 $fa $46 $d8
    cp   A, B                                          ;; 02:58ea $b8
    pop  BC                                            ;; 02:58eb $c1
    jr   NC, jp_02_5922                                ;; 02:58ec $30 $34
    push DE                                            ;; 02:58ee $d5
    push BC                                            ;; 02:58ef $c5
    call call_02_75c5                                  ;; 02:58f0 $cd $c5 $75
    call drawText                                      ;; 02:58f3 $cd $77 $37
    call call_02_59fe                                  ;; 02:58f6 $cd $fe $59
    push AF                                            ;; 02:58f9 $f5
    ld   A, [wDialogType]                              ;; 02:58fa $fa $4a $d8
    cp   A, WINDOW_VENDOR_BUY_TOP                      ;; 02:58fd $fe $0e
    jr   Z, .jr_02_5909                                ;; 02:58ff $28 $08
    cp   A, WINDOW_STATUS_SCREEN_AP_DP                 ;; 02:5901 $fe $1a
    jr   Z, .jr_02_5909                                ;; 02:5903 $28 $04
    cp   A, WINDOW_VENDOR_SELL_TOP                     ;; 02:5905 $fe $0d
    jr   NZ, .jr_02_590b                               ;; 02:5907 $20 $02
.jr_02_5909:
    dec  D                                             ;; 02:5909 $15
    dec  D                                             ;; 02:590a $15
.jr_02_590b:
    pop  AF                                            ;; 02:590b $f1
    call C, call_02_5ae0                               ;; 02:590c $dc $e0 $5a
    ld   A, [wDialogType]                              ;; 02:590f $fa $4a $d8
    cp   A, WINDOW_VENDOR_BUY_TOP                      ;; 02:5912 $fe $0e
    jr   Z, .jr_02_5918                                ;; 02:5914 $28 $02
    cp   A, WINDOW_VENDOR_SELL_TOP                     ;; 02:5916 $fe $0d
.jr_02_5918:
    call Z, call_02_5a18                               ;; 02:5918 $cc $18 $5a
    pop  BC                                            ;; 02:591b $c1
    pop  DE                                            ;; 02:591c $d1
    call menuNextItemPosition                          ;; 02:591d $cd $0b $38
    scf                                                ;; 02:5920 $37
    ret  NZ                                            ;; 02:5921 $c0

jp_02_5922:
    push HL                                            ;; 02:5922 $e5
    call saveRegisterState2                            ;; 02:5923 $cd $80 $6d
    call NC, showTrashcan                              ;; 02:5926 $d4 $0b $6c
    ld   HL, titleScreenLicenseText                    ;; 02:5929 $21 $62 $7e
    ld   DE, $071a                                     ;; 02:592c $11 $1b $07
    ld   BC, $1f01                                     ;; 02:592f $01 $01 $1f
    ld   A, [wDialogType]                              ;; 02:5932 $fa $4a $d8
    cp   A, WINDOW_TITLE_SCREEN                        ;; 02:5935 $fe $1f
    push AF                                            ;; 02:5937 $f5
    call Z, drawText                                   ;; 02:5938 $cc $77 $37
    ld   DE, $061b                                     ;; 02:593b $11 $1c $06
    ld   BC, $1f01                                     ;; 02:593e $01 $01 $1f
    pop  AF                                            ;; 02:5941 $f1
    call Z, drawText                                   ;; 02:5942 $cc $77 $37
    ld   A, [wMenuStateFunctionNew]                    ;; 02:5945 $fa $50 $d8
    ld   [wMenuStateCurrentFunction], A                ;; 02:5948 $ea $53 $d8
    ld   B, A                                          ;; 02:594b $47
    call runVirtualScriptOpCodeFF                      ;; 02:594c $cd $69 $3c
    ld   A, [wMenuFlags]                               ;; 02:594f $fa $49 $d8
    and  A, $cf                                        ;; 02:5952 $e6 $cf
    ld   [wMenuFlags], A                               ;; 02:5954 $ea $49 $d8
    pop  HL                                            ;; 02:5957 $e1
    ret                                                ;; 02:5958 $c9

jp_02_5959:
    call loadRegisterState2                            ;; 02:5959 $cd $a7 $6d
    ld   HL, wBoyName                                  ;; 02:595c $21 $9d $d7
    call drawText                                      ;; 02:595f $cd $77 $37
    dec  E                                             ;; 02:5962 $1d
    dec  E                                             ;; 02:5963 $1d
    ld   A, $45                                        ;; 02:5964 $3e $45
    call storeTileAatDialogPositionDE                  ;; 02:5966 $cd $44 $38
    inc  E                                             ;; 02:5969 $1c
    inc  E                                             ;; 02:596a $1c
    ld   A, [wLevel]                                   ;; 02:596b $fa $ba $d7
    ld   H, $00                                        ;; 02:596e $26 $00
    ld   L, A                                          ;; 02:5970 $6f
    push DE                                            ;; 02:5971 $d5
    call drawNumberAtDialogPositionDE                  ;; 02:5972 $cd $18 $5b
    pop  DE                                            ;; 02:5975 $d1
    inc  E                                             ;; 02:5976 $1c
    inc  E                                             ;; 02:5977 $1c
    inc  E                                             ;; 02:5978 $1c
    push DE                                            ;; 02:5979 $d5
    call call_02_5aaf                                  ;; 02:597a $cd $af $5a
    pop  DE                                            ;; 02:597d $d1
    call menuNextItemPosition                          ;; 02:597e $cd $0b $38
    ld   A, $3e                                        ;; 02:5981 $3e $3e
    call storeTileAatDialogPositionDE                  ;; 02:5983 $cd $44 $38
    inc  E                                             ;; 02:5986 $1c
    ld   A, [wXPHigh]                                  ;; 02:5987 $fa $bc $d7
    ld   H, A                                          ;; 02:598a $67
    ld   A, [wXPLow]                                   ;; 02:598b $fa $bb $d7
    ld   L, A                                          ;; 02:598e $6f
    ld   A, [wXPHighExt]                               ;; 02:598f $fa $bd $d7
    ld   C, A                                          ;; 02:5992 $4f
    call drawNumber24bitOnDialog                       ;; 02:5993 $cd $ae $59
    ld   A, $76                                        ;; 02:5996 $3e $76
    call storeTileAatDialogPositionDE                  ;; 02:5998 $cd $44 $38
    inc  E                                             ;; 02:599b $1c
    ld   A, [wNextXPLevelHigh]                         ;; 02:599c $fa $c1 $d8
    ld   H, A                                          ;; 02:599f $67
    ld   A, [wNextXPLevelLow]                          ;; 02:59a0 $fa $c0 $d8
    ld   L, A                                          ;; 02:59a3 $6f
    ld   A, [wNextXPLevelHighExt]                      ;; 02:59a4 $fa $c2 $d8
    ld   C, A                                          ;; 02:59a7 $4f
    call drawNumber24bitOnDialog                       ;; 02:59a8 $cd $ae $59
    jp   jp_02_5922                                    ;; 02:59ab $c3 $22 $59

; Draws the 24bit number CHL to dialog position DE
drawNumber24bitOnDialog:
    push BC                                            ;; 02:59ae $c5
    push DE                                            ;; 02:59af $d5
    push HL                                            ;; 02:59b0 $e5
    pop  DE                                            ;; 02:59b1 $d1
    ld   A, C                                          ;; 02:59b2 $79
    or   A, D                                          ;; 02:59b3 $b2
    jr   NZ, .not_zero                                 ;; 02:59b4 $20 $11
    or   A, E                                          ;; 02:59b6 $b3
    jr   NZ, .not_zero                                 ;; 02:59b7 $20 $0e
    pop  DE                                            ;; 02:59b9 $d1
    ld   A, $06                                        ;; 02:59ba $3e $06
    add  A, E                                          ;; 02:59bc $83
    ld   E, A                                          ;; 02:59bd $5f
    xor  A, A                                          ;; 02:59be $af
    add  A, $30                                        ;; 02:59bf $c6 $30
    call storeTileAatDialogPositionDE                  ;; 02:59c1 $cd $44 $38
    pop  BC                                            ;; 02:59c4 $c1
    inc  E                                             ;; 02:59c5 $1c
    ret                                                ;; 02:59c6 $c9
.not_zero:
    ld   HL, wSRAMSaveHeader._1                        ;; 02:59c7 $21 $a8 $d7
    push HL                                            ;; 02:59ca $e5
    call convertToUnpackedBCD                          ;; 02:59cb $cd $63 $29
    pop  HL                                            ;; 02:59ce $e1
    inc  HL                                            ;; 02:59cf $23
    ld   B, $07                                        ;; 02:59d0 $06 $07
    pop  DE                                            ;; 02:59d2 $d1
.loop:
    ld   A, [wMiscFlags]                               ;; 02:59d3 $fa $6f $d8
    bit  7, A                                          ;; 02:59d6 $cb $7f
    jr   Z, .jr_02_59e2                                ;; 02:59d8 $28 $08
    ld   A, [HL+]                                      ;; 02:59da $2a
    add  A, $30                                        ;; 02:59db $c6 $30
    call storeTileAatDialogPositionDE                  ;; 02:59dd $cd $44 $38
    jr   .jr_02_59f3                                   ;; 02:59e0 $18 $11
.jr_02_59e2:
    ld   A, [HL+]                                      ;; 02:59e2 $2a
    and  A, A                                          ;; 02:59e3 $a7
    jr   Z, .jr_02_59f3                                ;; 02:59e4 $28 $0d
    add  A, $30                                        ;; 02:59e6 $c6 $30
    call storeTileAatDialogPositionDE                  ;; 02:59e8 $cd $44 $38
    ld   A, [wMiscFlags]                               ;; 02:59eb $fa $6f $d8
    set  7, A                                          ;; 02:59ee $cb $ff
    ld   [wMiscFlags], A                               ;; 02:59f0 $ea $6f $d8
.jr_02_59f3:
    inc  E                                             ;; 02:59f3 $1c
    dec  B                                             ;; 02:59f4 $05
    jr   NZ, .loop                                     ;; 02:59f5 $20 $dc
    ld   HL, wMiscFlags                                ;; 02:59f7 $21 $6f $d8
    res  7, [HL]                                       ;; 02:59fa $cb $be
    pop  BC                                            ;; 02:59fc $c1
    ret                                                ;; 02:59fd $c9

call_02_59fe:
    ld   A, [wWindowSecondPointer.high]                ;; 02:59fe $fa $95 $d8
    ld   H, A                                          ;; 02:5a01 $67
    ld   A, [wWindowSecondPointer]                     ;; 02:5a02 $fa $94 $d8
    ld   L, A                                          ;; 02:5a05 $6f
    ld   A, [wD846]                                    ;; 02:5a06 $fa $46 $d8
    dec  A                                             ;; 02:5a09 $3d
    ld   C, A                                          ;; 02:5a0a $4f
    ld   B, $00                                        ;; 02:5a0b $06 $00
    push BC                                            ;; 02:5a0d $c5
    add  HL, BC                                        ;; 02:5a0e $09
    ld   A, [HL]                                       ;; 02:5a0f $7e
    ld   B, A                                          ;; 02:5a10 $47
    and  A, $80                                        ;; 02:5a11 $e6 $80
    ld   A, B                                          ;; 02:5a13 $78
    pop  BC                                            ;; 02:5a14 $c1
    ret  Z                                             ;; 02:5a15 $c8
    scf                                                ;; 02:5a16 $37
    ret                                                ;; 02:5a17 $c9

call_02_5a18:
    push BC                                            ;; 02:5a18 $c5
    ld   E, $0a                                        ;; 02:5a19 $1e $0a
    ld   B, $09                                        ;; 02:5a1b $06 $09
.loop_1:
    ld   A, $7f                                        ;; 02:5a1d $3e $7f
    call storeTileAatDialogPositionDE                  ;; 02:5a1f $cd $44 $38
    inc  E                                             ;; 02:5a22 $1c
    dec  B                                             ;; 02:5a23 $05
    jr   NZ, .loop_1                                   ;; 02:5a24 $20 $f7
    pop  BC                                            ;; 02:5a26 $c1
    ld   E, $10                                        ;; 02:5a27 $1e $10
    push DE                                            ;; 02:5a29 $d5
    ld   HL, wVendorBuyPrices                          ;; 02:5a2a $21 $01 $d7
    ld   A, [wDialogType]                              ;; 02:5a2d $fa $4a $d8
    cp   A, WINDOW_VENDOR_BUY_TOP                      ;; 02:5a30 $fe $0e
    jr   Z, .jr_02_5a37                                ;; 02:5a32 $28 $03
    ld   HL, wVendorSellPrices                         ;; 02:5a34 $21 $4f $d7
.jr_02_5a37:
    add  HL, BC                                        ;; 02:5a37 $09
    add  HL, BC                                        ;; 02:5a38 $09
    ld   A, [HL+]                                      ;; 02:5a39 $2a
    ld   H, [HL]                                       ;; 02:5a3a $66
    ld   L, A                                          ;; 02:5a3b $6f
    ld   A, H                                          ;; 02:5a3c $7c
    or   A, L                                          ;; 02:5a3d $b5
    jr   Z, .jr_02_5a50                                ;; 02:5a3e $28 $10
    ld   B, $06                                        ;; 02:5a40 $06 $06
    call drawNumberAtDialogPositionDE                  ;; 02:5a42 $cd $18 $5b
    pop  DE                                            ;; 02:5a45 $d1
    inc  DE                                            ;; 02:5a46 $13
    ld   B, $02                                        ;; 02:5a47 $06 $02
    ld   HL, statusScreenGoldLabel                     ;; 02:5a49 $21 $9a $7d
    call drawText                                      ;; 02:5a4c $cd $77 $37
    ret                                                ;; 02:5a4f $c9
.jr_02_5a50:
    ld   B, $06                                        ;; 02:5a50 $06 $06
    inc  DE                                            ;; 02:5a52 $13
.loop_2:
    push DE                                            ;; 02:5a53 $d5
    push BC                                            ;; 02:5a54 $c5
    ld   A, $7f                                        ;; 02:5a55 $3e $7f
    call storeTileAatDialogPositionDE                  ;; 02:5a57 $cd $44 $38
    pop  BC                                            ;; 02:5a5a $c1
    pop  DE                                            ;; 02:5a5b $d1
    dec  DE                                            ;; 02:5a5c $1b
    dec  B                                             ;; 02:5a5d $05
    jr   NZ, .loop_2                                   ;; 02:5a5e $20 $f3
    pop  DE                                            ;; 02:5a60 $d1
    ret                                                ;; 02:5a61 $c9

drawLoadSaveWindowContents_top:
    ld   HL, sSave1Body                                ;; 02:5a62 $21 $06 $a0
    ld   B, $08                                        ;; 02:5a65 $06 $08
    jr   drawLoadSaveWindowContents_common             ;; 02:5a67 $18 $05

drawLoadSaveWindowContents_bottom:
    ld   HL, sSave2Body                                ;; 02:5a69 $21 $06 $a1
    ld   B, $10                                        ;; 02:5a6c $06 $10

drawLoadSaveWindowContents_common:
    ld   A, [wWindowFlags]                             ;; 02:5a6e $fa $74 $d8
    and  A, B                                          ;; 02:5a71 $a0
    jr   Z, .jr_02_5a8d                                ;; 02:5a72 $28 $19
    call enableSRAM                                    ;; 02:5a74 $cd $58 $74
    call drawSaveNameFromSRAM                          ;; 02:5a77 $cd $d5 $74
    ld   DE, $08                                       ;; 02:5a7a $11 $08 $00
    add  HL, DE                                        ;; 02:5a7d $19
    call drawSaveHPFromSRAM                            ;; 02:5a7e $cd $f4 $74
    call drawSaveMPFromSRAM                            ;; 02:5a81 $cd $2e $75
    call drawLevelFromSRAM                             ;; 02:5a84 $cd $66 $75
    call drawExperienceFromSRAM                        ;; 02:5a87 $cd $89 $75
    call disableSRAM                                   ;; 02:5a8a $cd $5e $74
.jr_02_5a8d:
    ld   A, [wMenuStateFunctionNew]                    ;; 02:5a8d $fa $50 $d8
    ld   [wMenuStateCurrentFunction], A                ;; 02:5a90 $ea $53 $d8
    ld   A, [wDialogType]                              ;; 02:5a93 $fa $4a $d8
    cp   A, WINDOW_SAVE_LOAD_FILE_2                    ;; 02:5a96 $fe $1c
    ret  NZ                                            ;; 02:5a98 $c0
    ld   HL, wDialogType                               ;; 02:5a99 $21 $4a $d8
    dec  [HL]                                          ;; 02:5a9c $35
    ld   A, [HL]                                       ;; 02:5a9d $7e
    call getWindowData                                 ;; 02:5a9e $cd $88 $6c
    ld   E, [HL]                                       ;; 02:5aa1 $5e
    inc  HL                                            ;; 02:5aa2 $23
    ld   D, [HL]                                       ;; 02:5aa3 $56
    inc  HL                                            ;; 02:5aa4 $23
    ld   C, [HL]                                       ;; 02:5aa5 $4e
    inc  HL                                            ;; 02:5aa6 $23
    ld   B, [HL]                                       ;; 02:5aa7 $46
    call setWindowDimensions                           ;; 02:5aa8 $cd $73 $7a
    ret                                                ;; 02:5aab $c9

jp_02_5aac:
    call loadRegisterState2                            ;; 02:5aac $cd $a7 $6d

; Deals with printing text on a status effect window.
; This window has been slightly enlarged to show longer status effect names.
call_02_5aaf:
    push BC                                            ;; 02:5aaf $c5
    ld bc, $0400
    ld h, c
    ld   A, [wStatusEffect]                            ;; 02:5ab4 $fa $c0 $d7
.loop:
    rrca                                               ;; 02:5ab7 $0f
    jr   C, .break                                     ;; 02:5ab8 $38 $04
    inc  C                                             ;; 02:5aba $0c
    dec  B                                             ;; 02:5abb $05
    jr   NZ, .loop                                     ;; 02:5abc $20 $f9
.break:
; Status effect names are now up to six letters.
    ld a, c
    add a
    add c
    add a
    ld l, a
    ld   BC, statusEffectLabels                        ;; 02:5ac3 $01 $e5 $7d
    add  HL, BC                                        ;; 02:5ac6 $09
    pop  BC                                            ;; 02:5ac7 $c1
    dec  E                                             ;; 02:5ac8 $1d
    call drawText                                      ;; 02:5ac9 $cd $77 $37
    jp   jp_02_5922                                    ;; 02:5acc $c3 $22 $59

windowStatusScreenPrintStatValue:
    ld   A, [wD846]                                    ;; 02:5acf $fa $46 $d8
    ld   C, A                                          ;; 02:5ad2 $4f
    ld   B, $00                                        ;; 02:5ad3 $06 $00
    ld   A, E                                          ;; 02:5ad5 $7b
    add  A, $06                                        ;; 02:5ad6 $c6 $06
    ld   E, A                                          ;; 02:5ad8 $5f
    call call_02_5b05                                  ;; 02:5ad9 $cd $05 $5b
    call menuNextItemPosition                          ;; 02:5adc $cd $0b $38
    ret                                                ;; 02:5adf $c9

call_02_5ae0:
    cp   A, $80                                        ;; 02:5ae0 $fe $80
    ret  Z                                             ;; 02:5ae2 $c8
    ld   A, [wDialogType]                              ;; 02:5ae3 $fa $4a $d8
    cp   A, WINDOW_VENDOR_BUY_TOP                      ;; 02:5ae6 $fe $0e
    jr   Z, .jr_02_5af4                                ;; 02:5ae8 $28 $0a
    cp   A, WINDOW_VENDOR_SELL_TOP                     ;; 02:5aea $fe $0d
    jr   Z, .jr_02_5af4                                ;; 02:5aec $28 $06
    cp   A, WINDOW_STATUS_SCREEN_AP_DP                 ;; 02:5aee $fe $1a
    jr   NZ, .jr_02_5afa                               ;; 02:5af0 $20 $08
    dec  E                                             ;; 02:5af2 $1d
    dec  E                                             ;; 02:5af3 $1d
.jr_02_5af4:
    ld   A, $07                                        ;; 02:5af4 $3e $07
    add  A, E                                          ;; 02:5af6 $83
    ld   E, A                                          ;; 02:5af7 $5f
    jr   jr_02_5b0b                                    ;; 02:5af8 $18 $11
.jr_02_5afa:
    ld   A, [wDialogW]                                 ;; 02:5afa $fa $a9 $d4
    dec  A                                             ;; 02:5afd $3d
    ld   E, A                                          ;; 02:5afe $5f
    ld   A, [wD846]                                    ;; 02:5aff $fa $46 $d8
    rrca                                               ;; 02:5b02 $0f
    jr   C, jr_02_5b09                                 ;; 02:5b03 $38 $04

call_02_5b05:
    dec  D                                             ;; 02:5b05 $15
    dec  D                                             ;; 02:5b06 $15
    jr   jr_02_5b0b                                    ;; 02:5b07 $18 $02

jr_02_5b09:
    rrc  E                                             ;; 02:5b09 $cb $0b

jr_02_5b0b:
    ld   A, [wWindowFirstPointer.high]                 ;; 02:5b0b $fa $93 $d8
    ld   H, A                                          ;; 02:5b0e $67
    ld   A, [wWindowFirstPointer]                      ;; 02:5b0f $fa $92 $d8
    ld   L, A                                          ;; 02:5b12 $6f
    add  HL, BC                                        ;; 02:5b13 $09
    ld   A, [HL]                                       ;; 02:5b14 $7e
    ld   H, $00                                        ;; 02:5b15 $26 $00
    ld   L, A                                          ;; 02:5b17 $6f

; Draws a number stored in HL to the dialog position, drawing to the left
drawNumberAtDialogPositionDE:
    ld   A, $0a                                        ;; 02:5b18 $3e $0a
    push BC                                            ;; 02:5b1a $c5
    push DE                                            ;; 02:5b1b $d5
    call divMod                                        ;; 02:5b1c $cd $8b $2b
    pop  DE                                            ;; 02:5b1f $d1
    pop  BC                                            ;; 02:5b20 $c1
    add  A, $30                                        ;; 02:5b21 $c6 $30
    call storeTileAatDialogPositionDE                  ;; 02:5b23 $cd $44 $38
    dec  E                                             ;; 02:5b26 $1d
    ld   A, H                                          ;; 02:5b27 $7c
    or   A, L                                          ;; 02:5b28 $b5
    ret  Z                                             ;; 02:5b29 $c8
    jr   drawNumberAtDialogPositionDE                  ;; 02:5b2a $18 $ec

jp_02_5b2c:
    call loadRegisterState2                            ;; 02:5b2c $cd $a7 $6d
    ld   A, [wWindowSecondPointer.high]                ;; 02:5b2f $fa $95 $d8
    ld   H, A                                          ;; 02:5b32 $67
    ld   A, [wWindowSecondPointer]                     ;; 02:5b33 $fa $94 $d8
    ld   L, A                                          ;; 02:5b36 $6f
    ld   A, [wDialogType]                              ;; 02:5b37 $fa $4a $d8
    push AF                                            ;; 02:5b3a $f5
    cp   A, WINDOW_NAMING_SCREEN_TOP                   ;; 02:5b3b $fe $1d
    jr   NZ, .jr_02_5b49                               ;; 02:5b3d $20 $0a
    ld   A, [wWindowFlags]                             ;; 02:5b3f $fa $74 $d8
    bit  5, A                                          ;; 02:5b42 $cb $6f
    jr   Z, .jr_02_5b49                                ;; 02:5b44 $28 $03
; Use the same label for both since their sprite is shown.
    ld   HL, nameLabel                                 ;; 02:5b46 $21 $fd $7d
.jr_02_5b49:
    pop  AF                                            ;; 02:5b49 $f1
    cp   A, WINDOW_NAMING_SCREEN_BOTTOM                ;; 02:5b4a $fe $1e
    call Z, call_02_5b8e                               ;; 02:5b4c $cc $8e $5b
    ld   A, [wWindowTextLength]                        ;; 02:5b4f $fa $9b $d8
    ld   B, A                                          ;; 02:5b52 $47
    ld   A, [wWindowTextRows]                          ;; 02:5b53 $fa $9a $d8
    ld   C, A                                          ;; 02:5b56 $4f
    call saveRegisterState2                            ;; 02:5b57 $cd $80 $6d
    call initStatusHPMPCurrentAndMax                   ;; 02:5b5a $cd $2d $76
    ld   A, $98                                        ;; 02:5b5d $3e $98
    ld   [wMenuStateCurrentFunction], A                ;; 02:5b5f $ea $53 $d8
    ld   A, $0a                                        ;; 02:5b62 $3e $0a
    ld   B, A                                          ;; 02:5b64 $47
    call runVirtualScriptOpCodeFF                      ;; 02:5b65 $cd $69 $3c

; This isn't the only way of printing text to a window, but it is commonly used for plain text.
windowPrintMenuText:
    push HL                                            ;; 02:5b68 $e5
    call loadRegisterState2                            ;; 02:5b69 $cd $a7 $6d
    push BC                                            ;; 02:5b6c $c5
    call drawText                                      ;; 02:5b6d $cd $77 $37
    push HL                                            ;; 02:5b70 $e5
    ld   A, [wDialogType]                              ;; 02:5b71 $fa $4a $d8
    cp   A, WINDOW_STATUS_SCREEN_HP_MP                 ;; 02:5b74 $fe $14
    call Z, statusWindowPrintHPMPCurOrMax              ;; 02:5b76 $cc $5c $76
    cp   A, WINDOW_STATUS_SCREEN_RIGHT                 ;; 02:5b79 $fe $12
    call Z, windowStatusScreenPrintStatValue           ;; 02:5b7b $cc $cf $5a
    ld   HL, wD846                                     ;; 02:5b7e $21 $46 $d8
    inc  [HL]                                          ;; 02:5b81 $34
    pop  HL                                            ;; 02:5b82 $e1
    pop  BC                                            ;; 02:5b83 $c1
    dec  C                                             ;; 02:5b84 $0d
    call saveRegisterState2                            ;; 02:5b85 $cd $80 $6d
    pop  HL                                            ;; 02:5b88 $e1
    ret  NZ                                            ;; 02:5b89 $c0
    scf                                                ;; 02:5b8a $37
    jp   jp_02_5922                                    ;; 02:5b8b $c3 $22 $59

call_02_5b8e:
    ld   A, [wD846]                                    ;; 02:5b8e $fa $46 $d8
    push BC                                            ;; 02:5b91 $c5
    ld   B, A                                          ;; 02:5b92 $47
    add  A, A                                          ;; 02:5b93 $87
    add  A, A                                          ;; 02:5b94 $87
    add  A, A                                          ;; 02:5b95 $87
    add  A, B                                          ;; 02:5b96 $80
    ld   C, A                                          ;; 02:5b97 $4f
    ld   B, $00                                        ;; 02:5b98 $06 $00
    add  HL, BC                                        ;; 02:5b9a $09
    pop  BC                                            ;; 02:5b9b $c1
    ret                                                ;; 02:5b9c $c9

getEquippedWeaponAP:
    push HL                                            ;; 02:5b9d $e5
    ld   A, [wEquippedWeapon]                          ;; 02:5b9e $fa $e9 $d6
    ld   HL, equipmentDataTable + $0c                  ;; 02:5ba1 $21 $f6 $61
    call indexIntoTable                                ;; 02:5ba4 $cd $82 $76
    ld   A, [HL]                                       ;; 02:5ba7 $7e
    pop  HL                                            ;; 02:5ba8 $e1
    ret                                                ;; 02:5ba9 $c9

; There is a break in the table due to a non-aligned label that BadBoy doesn't handle. Real size is 34.
;@data amount=24 format=bbbbbbbbbb
; Window data for size/height/cursor.
;0-3: x, y, w, h
;4: Amount of rows to draw with text
;5: Length of each text to draw
;6: Amount of cursor positions
;7: Initial Flags:
;   bit 0: seems related to having multiple columns, but it's set on the START menu and a few others
;   bit 1: probably related to items. used by trash can logic.
;8: Amount of cursor columns
;9: Horizontal cursor shift for columns
; Start menu (ITEM MAGIC EQUIP ASK):
windowData:
    db   $01, $01, $07, $09, $04, $05, $04, $00, $01, $00 ;; 02:5baa .......... $00
; Items menu:
    db   $00, $00, $13, $11, $08, $08, $10, $03, $02, $09 ;; 02:5bb4 .......... $01
; Magic menu:
    db   $05, $01, $0d, $09, $04, $05, $08, $01, $02, $06 ;; 02:5bbe .......... $02
.equipmentScreenTop:
    db   $00, $00, $13, $07, $03, $08, $0e, $01, $00, $00 ;; 02:5bc8 .......... $03
.equipmentScreenBottom:
    db   $00, $08, $13, $09, $04, $08, $0c, $03, $02, $09 ;; 02:5bd2 .......... $04
; Unused:
    db   $00, $00, $13, $08, $03, $08, $00, $00, $00, $00 ;; 02:5bdc ?????????? $05
; Dialog window:
    db   $00, $0a, $13, $07, $04, $12, $04, $00, $00, $00 ;; 02:5be6 .......... $06
; Dialog Yes, No menu:
    db   $00, $00, $05, $05, $02, $03, $02, $00, $01, $00 ;; 02:5bf0 .......... $07
; Unused:
    db   $09, $00, $0a, $05, $02, $08, $02, $00, $00, $00 ;; 02:5bfa ?????????? $08
; Start menu status effect window (Good, Pois, Ston, Moog, Dark):
; This window has been slightly enlarged to show longer status effect names.
    db   $0c, $08, $06+1, $03, $01, $04+2, $01, $00, $00, $00 ;; 02:5c04 .......... $09
; Start menu equiped window:
    db   $00, $0c, $13, $03, $01, $08, $02, $01, $00, $00 ;; 02:5c0e .......... $0a
; Vendor Buy, Sell, Exit
    db   $00, $0a, $06, $07, $03, $04, $03, $00, $01, $00 ;; 02:5c18 .......... $0b
.vendorScreenGold:
    db   $0a, $0a, $09, $03, $01, $02, $01, $00, $00, $00 ;; 02:5c22 .......... $0c
; Vendor sell menu (top):
    db   $00, $00, $13, $09, $04, $08, $1c, $00, $01, $00 ;; 02:5c2c .......... $0d
; Vendor buy menu (top):
    db   $00, $00, $13, $09, $04, $08, $07, $00, $01, $00 ;; 02:5c36 .......... $0e
; Vendor text window (top):
    db   $00, $00, $13, $09, $04, $11, $02, $00, $00, $00 ;; 02:5c40 .......... $0f
; Vendor Sell, No:
    db   $08, $0e, $0b, $03, $02, $04, $02, $01, $02, $05 ;; 02:5c4a .......... $10
; Select menu (Save Map Status):
    db   $01, $0d, $11, $04, $03, $06, $03, $01, $03, $05 ;; 02:5c54 .......... $11
.statusScreenRight:
    db   $09, $04, $0a, $0b, $04, $07, $04, $00, $00, $00 ;; 02:5c5e .......... $12
; Status screen gold:
    db   $0a, $0f, $09, $02, $01, $02, $01, $00, $00, $00 ;; 02:5c68 .......... $13
; Status screen HP/MP:
    db   $00, $04, $09, $0d, $05, $03, $05, $00, $00, $00 ;; 02:5c72 .......... $14
; Status screen top window (name, level, status effect, experience):
; This window's text length has been slightly enlarged to show longer status effect names.
    db   $00, $00, $13, $05, $02, $04+2, $02, $01, $00, $00 ;; 02:5c7c .......... $15
; Unused:
    db   $0e, $00, $05, $03, $01, $04, $01, $00, $00, $00 ;; 02:5c86 ?????????? $16
; Levelup message ("Level up! Select your growth type."):
    db   $00, $00, $13, $05, $02, $11, $02, $00, $00, $00 ;; 02:5c90 .......... $17
.selectLevelupStats:
    db   $00, $00, $13, $05, $04, $07, $04, $03, $02, $09 ;; 02:5c9a .......... $18
; Levelup Yes, No:
    db   $00, $06, $09, $05, $02, $05, $02, $02, $01, $00 ;; 02:5ca4 .......... $19
; Status screen AP, DP (this has an invisible border, but is a different window):
    db   $00, $0b, $06, $09, $02, $05, $02, $00, $01, $00 ;; 02:5cae .......... $1a
; Save/Load top window:
    db   $00, $02, $13, $06, $01, $0f, $02, $00, $02, $00 ;; 02:5cb8 .......... $1b
; Save/Load bottom window:
    db   $00, $0a, $13, $06, $01, $0f, $02, $00, $02, $00 ;; 02:5cc2 .......... $1c
.namingScreenTop:
    db   $00, $00, $0e, $03, $01, $05, $01, $00, $00, $00 ;; 02:5ccc .......... $1d
.namingScreenBottom:
    db   $00, $04, $13, $0d, $06, $09, $51, $01, $09, $02 ;; 02:5cd6 .......... $1e
; Title screen menu (New Game, Continue):
    db   $06, $09, $09, $05, $02, $08, $02, $00, $01, $00 ;; 02:5ce0 .......... $1f
; Status effect inflicted message (Pois, Ston, Moog, Dark):
    db   $0b, $01, $07, $03, $01, $04, $01, $00, $00, $00 ;; 02:5cea ?????????? $20
; Levelup HP/MP recovered message:
    db   $00, $0a, $13, $07, $03, $10, $04, $00, $00, $00 ;; 02:5cf4 .......... $21

;@data amount=4 format=bbbb
levelUpStatChoices:
    db   $01, $02, $00, $01                            ;; 02:5cfe .... $00
    db   $01, $00, $02, $01                            ;; 02:5d02 .... $01
    db   $02, $01, $00, $01                            ;; 02:5d06 .... $02
    db   $01, $00, $01, $02                            ;; 02:5d0a .... $03

; These three tables store pointers to tables or text used by windows.
; Each of the windows have their own entry.
;@data format=p amount=34
windowThirdPointers:
    dw   startMenuOptions                              ;; 02:5d0e .. $00
    dw   itemDataTable                                 ;; 02:5d10 .. $01
    dw   spellDataTable                                ;; 02:5d12 .. $02
    dw   equipmentDataTable                            ;; 02:5d14 .. $03
    dw   equipmentDataTable                            ;; 02:5d16 .. $04
    dw   $0000                                         ;; 02:5d18 ?? $05
    dw   $0000                                         ;; 02:5d1a .. $06
    dw   yesNoTextLabels                               ;; 02:5d1c .. $07
    dw   $0000                                         ;; 02:5d1e ?? $08
    dw   statusEffectLabels                            ;; 02:5d20 .. $09
    dw   spellDataTable                                ;; 02:5d22 .. $0a
    dw   vendorOptions                                 ;; 02:5d24 .. $0b
    dw   $0000                                         ;; 02:5d26 .. $0c
    dw   itemDataTable                                 ;; 02:5d28 .. $0d
    dw   itemDataTable                                 ;; 02:5d2a .. $0e
    dw   $0000                                         ;; 02:5d2c .. $0f
    dw   venderConfirmSell                             ;; 02:5d2e .. $10
    dw   selectMenuOptions                             ;; 02:5d30 .. $11
    dw   statusScreenStatLabels                        ;; 02:5d32 .. $12
    dw   $0000                                         ;; 02:5d34 .. $13
    dw   statusScreenHPLabel                           ;; 02:5d36 .. $14
    dw   $0000                                         ;; 02:5d38 .. $15
    dw   statusEffectLabels                            ;; 02:5d3a ?? $16
    dw   levelUpText2                                  ;; 02:5d3c .. $17
    dw   levelUpStatOptions                            ;; 02:5d3e .. $18
    dw   yesNoOptions                                  ;; 02:5d40 .. $19
    dw   itemAPDPLabelsDataTable                       ;; 02:5d42 .. $1a
    dw   $0000                                         ;; 02:5d44 .. $1b
    dw   $0000                                         ;; 02:5d46 .. $1c
    dw   nameLabel                                     ;; 02:5d48 .. $1d
    dw   nameEntryInputOptions                         ;; 02:5d4a .. $1e
    dw   titleScreenOptions                            ;; 02:5d4c .. $1f
    dw   statusEffectLabels                            ;; 02:5d4e ?? $20
    dw   levelUpText1                                  ;; 02:5d50 .. $21

;@data format=p amount=34
windowFirstPointers:
    dw   $0000                                         ;; 02:5d52 .. $00
    dw   wItemInventoryAmount                          ;; 02:5d54 .. $01
    dw   wKnownMagicSpells                             ;; 02:5d56 .. $02
    dw   wEquippedWeaponPower                          ;; 02:5d58 .. $03
    dw   wEquipmentInventoryPowers                     ;; 02:5d5a .. $04
    dw   $0000                                         ;; 02:5d5c ?? $05
    dw   $0000                                         ;; 02:5d5e .. $06
    dw   $0000                                         ;; 02:5d60 .. $07
    dw   $0000                                         ;; 02:5d62 ?? $08
    dw   $0000                                         ;; 02:5d64 .. $09
    dw   wEquippedItemAmount                           ;; 02:5d66 .. $0a
    dw   $0000                                         ;; 02:5d68 .. $0b
    dw   $0000                                         ;; 02:5d6a .. $0c
    dw   wVendorSellQuantities                         ;; 02:5d6c .. $0d
    dw   wVendorBuyQuantities                          ;; 02:5d6e .. $0e
    dw   $0000                                         ;; 02:5d70 .. $0f
    dw   $0000                                         ;; 02:5d72 .. $10
    dw   $0000                                         ;; 02:5d74 .. $11
    dw   wStatStaminaLevelUpTmp                        ;; 02:5d76 .. $12
    dw   $0000                                         ;; 02:5d78 .. $13
    dw   wStatusHPMPCurrentAndMax                      ;; 02:5d7a .. $14
    dw   $d841                                         ;; 02:5d7c .. $15
    dw   $0000                                         ;; 02:5d7e ?? $16
    dw   $0000                                         ;; 02:5d80 .. $17
    dw   $0000                                         ;; 02:5d82 .. $18
    dw   $0000                                         ;; 02:5d84 .. $19
    dw   wTotalAP                                      ;; 02:5d86 .. $1a
    dw   $0000                                         ;; 02:5d88 .. $1b
    dw   $0000                                         ;; 02:5d8a .. $1c
    dw   $0000                                         ;; 02:5d8c .. $1d
    dw   $0000                                         ;; 02:5d8e .. $1e
    dw   $0000                                         ;; 02:5d90 .. $1f
    dw   $0000                                         ;; 02:5d92 ?? $20
    dw   $0000                                         ;; 02:5d94 .. $21

;@data format=p amount=34
windowSecondPointers:
    dw   startMenuOptions                              ;; 02:5d96 .. $00
    dw   wItemInventory                                ;; 02:5d98 .. $01
    dw   wMagicInventory                               ;; 02:5d9a .. $02
    dw   wEquippedWeapon                               ;; 02:5d9c .. $03
    dw   wEquipmentInventory                           ;; 02:5d9e .. $04
    dw   $0000                                         ;; 02:5da0 ?? $05
    dw   $0000                                         ;; 02:5da2 .. $06
    dw   yesNoTextLabels                               ;; 02:5da4 .. $07
    dw   $0000                                         ;; 02:5da6 ?? $08
    dw   $d7dc                                         ;; 02:5da8 .. $09
    dw   wEquippedItemAndWeaponCopy                    ;; 02:5daa .. $0a
    dw   vendorOptions                                 ;; 02:5dac .. $0b
    dw   $0000                                         ;; 02:5dae .. $0c
    dw   wVendorSellIDs                                ;; 02:5db0 .. $0d
    dw   wVendorBuyIDs                                 ;; 02:5db2 .. $0e
    dw   venderGreetingText                            ;; 02:5db4 .. $0f
    dw   venderConfirmSell                             ;; 02:5db6 .. $10
    dw   selectMenuOptions                             ;; 02:5db8 .. $11
    dw   statusScreenStatLabels                        ;; 02:5dba .. $12
    dw   $0000                                         ;; 02:5dbc .. $13
    dw   statusScreenHPLabel                           ;; 02:5dbe .. $14
    dw   $0000                                         ;; 02:5dc0 .. $15
    dw   $0000                                         ;; 02:5dc2 ?? $16
    dw   levelUpText2                                  ;; 02:5dc4 .. $17
    dw   levelUpStatOptions                            ;; 02:5dc6 .. $18
    dw   yesNoOptions                                  ;; 02:5dc8 .. $19
    dw   wStatusScreenAPDP                             ;; 02:5dca .. $1a
    dw   $0000                                         ;; 02:5dcc .. $1b
    dw   $0000                                         ;; 02:5dce .. $1c
    dw   nameLabel                                     ;; 02:5dd0 .. $1d
    dw   nameEntryInputOptions                         ;; 02:5dd2 .. $1e
    dw   titleScreenOptions                            ;; 02:5dd4 .. $1f
    dw   $d7dc                                         ;; 02:5dd6 ?? $20
    dw   levelUpText1                                  ;; 02:5dd8 .. $21

INCLUDE "data/items.asm"

; Vendor inventories allow seven items/weapons/spells.
; They start with two bytes giving the vendor number, but this is unused by code.
; After that each item is followed by the byte $0a.
; If a vendor sells fewer than seven things, that entry is $ff, $00.
;@data format=wbbbbbbbbbbbbbb amount=17
vendorInventories:
    data_wbbbbbbbbbbbbbb $0000, $00, $0a, $05, $0a, $06, $0a, $16, $0a, $ff, $00, $ff, $00, $ff, $00 ;; 02:64ea ??.............. $00
    data_wbbbbbbbbbbbbbb $0101, $00, $0a, $05, $0a, $06, $0a, $16, $0a, $35, $0a, $ff, $00, $ff, $00 ;; 02:64fa ??.............. $01
    data_wbbbbbbbbbbbbbb $0202, $00, $0a, $05, $0a, $06, $0a, $16, $0a, $35, $0a, $24, $0a, $ff, $00 ;; 02:650a ???????????????? $02
    data_wbbbbbbbbbbbbbb $0303, $01, $0a, $05, $0a, $06, $0a, $07, $0a, $08, $0a, $16, $0a, $35, $0a ;; 02:651a ???????????????? $03
    data_wbbbbbbbbbbbbbb $0404, $39, $0a, $60, $0a, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ;; 02:652a ??.............. $04
    data_wbbbbbbbbbbbbbb $0505, $39, $0a, $60, $0a, $55, $0a, $4a, $0a, $ff, $00, $ff, $00, $ff, $00 ;; 02:653a ???????????????? $05
    data_wbbbbbbbbbbbbbb $0606, $4b, $0a, $56, $0a, $3d, $0a, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ;; 02:654a ???????????????? $06
    data_wbbbbbbbbbbbbbb $0707, $61, $0a, $00, $0a, $02, $0a, $16, $0a, $35, $0a, $ff, $00, $ff, $00 ;; 02:655a ???????????????? $07
    data_wbbbbbbbbbbbbbb $0808, $3e, $0a, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ;; 02:656a ???????????????? $08
    data_wbbbbbbbbbbbbbb $0909, $57, $0a, $62, $0a, $4c, $0a, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ;; 02:657a ???????????????? $09
    data_wbbbbbbbbbbbbbb $0a0a, $51, $0a, $63, $0a, $5b, $0a, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ;; 02:658a ???????????????? $0a
    data_wbbbbbbbbbbbbbb $0b0b, $4d, $0a, $58, $0a, $43, $0a, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ;; 02:659a ???????????????? $0b
    data_wbbbbbbbbbbbbbb $0c0c, $4e, $0a, $5c, $0a, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ;; 02:65aa ???????????????? $0c
    data_wbbbbbbbbbbbbbb $0d0d, $47, $0a, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ;; 02:65ba ???????????????? $0d
    data_wbbbbbbbbbbbbbb $0e0e, $02, $0a, $03, $0a, $0e, $0a, $0f, $0a, $0a, $0a, $0b, $0a, $ff, $00 ;; 02:65ca ???????????????? $0e
    data_wbbbbbbbbbbbbbb $0f0f, $02, $0a, $0e, $0a, $0f, $0a, $11, $0a, $0a, $0a, $0b, $0a, $ff, $00 ;; 02:65da ???????????????? $0f
    data_wbbbbbbbbbbbbbb $1010, $03, $0a, $0e, $0a, $0f, $0a, $11, $0a, $12, $0a, $13, $0a, $ff, $00 ;; 02:65ea ???????????????? $10

drawEmptyWillBar:
    ld hl, _SCRN1 + SCRN_VX_B
    ld de, $7ff8
    ld b, $09
.loop:
    call storeDEinVRAM
    ld de, $fafa
    dec b
    jr nz, .loop
    ld de, $fe7f
    call storeDEinVRAM
    ret

ds 17 ; Free space

drawWillBarCharge:
    ld   A, [wWillCharge]                              ;; 02:6623 $fa $58 $d8
    and  A, A                                          ;; 02:6626 $a7
    ret  Z                                             ;; 02:6627 $c8
    push AF                                            ;; 02:6628 $f5
    and  A, $03                                        ;; 02:6629 $e6 $03
    ld   C, A                                          ;; 02:662b $4f
    pop  AF                                            ;; 02:662c $f1
    rrca                                               ;; 02:662d $0f
    rrca                                               ;; 02:662e $0f
    and  A, $3f                                        ;; 02:662f $e6 $3f
    ld   DE, $102                                      ;; 02:6631 $11 $02 $01
    call NZ, .drawFullTiles                            ;; 02:6634 $c4 $41 $66
    ld   A, C                                          ;; 02:6637 $79
    or   A, A                                          ;; 02:6638 $b7
    ret  Z                                             ;; 02:6639 $c8
    ld   C, $fa                                        ;; 02:663a $0e $fa
    add  A, C                                          ;; 02:663c $81
    call storeTileAatWindowPositionDE                  ;; 02:663d $cd $66 $38
    ret                                                ;; 02:6640 $c9
.drawFullTiles:
    push BC                                            ;; 02:6641 $c5
    ld   B, A                                          ;; 02:6642 $47
    ld   A, $f9                                        ;; 02:6643 $3e $f9
    call .drawFullTilesLoop                            ;; 02:6645 $cd $4a $66
    pop  BC                                            ;; 02:6648 $c1
    ret                                                ;; 02:6649 $c9
.drawFullTilesLoop:
    ld   C, A                                          ;; 02:664a $4f
    push DE                                            ;; 02:664b $d5
    call storeTileAatWindowPositionDE                  ;; 02:664c $cd $66 $38
    pop  DE                                            ;; 02:664f $d1
    inc  DE                                            ;; 02:6650 $13
    ld   A, C                                          ;; 02:6651 $79
    dec  B                                             ;; 02:6652 $05
    jr   NZ, .drawFullTilesLoop                        ;; 02:6653 $20 $f5
    ret                                                ;; 02:6655 $c9

castEquippedSpellIfSufficientMana:
    ld   A, [wEquippedItem]                            ;; 02:6656 $fa $ef $d6
    and  A, $7f                                        ;; 02:6659 $e6 $7f
    jr   Z, .jr_02_6675                                ;; 02:665b $28 $18
    cp   A, $09                                        ;; 02:665d $fe $09
    jr   NC, .jr_02_666f                               ;; 02:665f $30 $0e
    ld   HL, spellDataTable + $08                      ;; 02:6661 $21 $e2 $5d
    call indexIntoTable                                ;; 02:6664 $cd $82 $76
    ld   A, [HL]                                       ;; 02:6667 $7e
    and  A, $1f                                        ;; 02:6668 $e6 $1f
    ld   B, A                                          ;; 02:666a $47
    ld   A, [wManaLow]                                 ;; 02:666b $fa $b6 $d7
    sub  A, B                                          ;; 02:666e $90
.jr_02_666f:
    push AF                                            ;; 02:666f $f5
    call useItemOrSpell                                ;; 02:6670 $cd $a2 $71
    pop  AF                                            ;; 02:6673 $f1
    ret                                                ;; 02:6674 $c9
.jr_02_6675:
    call useItemOrSpell                                ;; 02:6675 $cd $a2 $71
    scf                                                ;; 02:6678 $37
    ret                                                ;; 02:6679 $c9

; Takes care of restoring the background, the status bar, and  hidden sprites.
; Return: z set if finished.
windowCloseAndRestoreHidden:
.loop:
    ld   A, [wWindowCloseStep]                         ;; 02:667d $fa $59 $d8
    or a
; This used the jumptable pattern but it's faster and the smaller to convert to two calls.
    call z, windowCloseInit
    call windowCloseMain
    ret z
    ldh a, [rLY]
    cp $60
    jr c, .loop
; If rLY was exactly $60 then z is set. Unset it with a decrement.
    dec a
    ret

windowCloseInit:
    ld hl, wMenuStateCurrentFunction
    set 7, [hl]
    call getWindowDimensions                           ;; 02:6690 $cd $67 $7a
    ld   A, [wDialogType]                              ;; 02:6693 $fa $4a $d8
; Clearing rectangle for the titlescreen "window" (used for the New Game and Continue options) includes a tiny piece of the logo, so move it a tile to the right.
    cp a, WINDOW_TITLE_SCREEN
    jr nz, .not_titlescreen
    inc e
.not_titlescreen
    cp   A, WINDOW_EQUIP_BOTTOM                        ;; 02:6696 $fe $04
    jr   NZ, .jr_02_66a0                               ;; 02:6698 $20 $06
    ld   DE, $00                                       ;; 02:669a $11 $00 $00
    ld   BC, $1113                                     ;; 02:669d $01 $13 $11
.jr_02_66a0:
    inc  B                                             ;; 02:66a0 $04
    inc  C                                             ;; 02:66a1 $0c
    call saveRegisterState2
    ld hl, wWindowCloseStep
    inc [hl]
    ret

windowCloseMain:
    call loadRegisterState2                            ;; 02:66ab $cd $a7 $6d
    push DE                                            ;; 02:66ae $d5
    push BC                                            ;; 02:66af $c5
.loop:
    ld   A, [HL+]                                      ;; 02:66b0 $2a
    call storeTileAatScreenPositionDE                  ;; 02:66b1 $cd $91 $38
    inc  E                                             ;; 02:66b4 $1c
    dec  C                                             ;; 02:66b5 $0d
    jr   NZ, .loop                                     ;; 02:66b6 $20 $f8
    pop  BC                                            ;; 02:66b8 $c1
    pop  DE                                            ;; 02:66b9 $d1
    inc  D                                             ;; 02:66ba $14
    dec  B                                             ;; 02:66bb $05
    call saveRegisterState2                            ;; 02:66bc $cd $80 $6d
    ret  NZ                                            ;; 02:66bf $c0
    ld   A, D                                          ;; 02:66c0 $7a
    cp   A, $0f                                        ;; 02:66c1 $fe $0f
    call NC, enableStatusBarEffect                     ;; 02:66c3 $d4 $3a $7a
    ld hl, wMenuStateCurrentFunction
    res 7, [hl]
    xor  A, A                                          ;; 02:66ce $af
    ld   [wMenuFlags], A                               ;; 02:66cf $ea $49 $d8
    ld   [wWindowCloseStep], A                         ;; 02:66d2 $ea $59 $d8
    call getWindowDimensions                           ;; 02:66d5 $cd $67 $7a
    inc  B                                             ;; 02:66d8 $04
    inc  C                                             ;; 02:66d9 $0c
    push BC                                            ;; 02:66da $c5
    pop  HL                                            ;; 02:66db $e1
    ld   A, [wDialogType]                              ;; 02:66dc $fa $4a $d8
    cp   A, WINDOW_EQUIP_BOTTOM                        ;; 02:66df $fe $04
    jr   Z, .jr_02_66ee                                ;; 02:66e1 $28 $0b
    cp   A, WINDOW_SAVE_LOAD_FILE_1                    ;; 02:66e3 $fe $1b
    jr   Z, .jr_02_66ee                                ;; 02:66e5 $28 $07
    cp   A, WINDOW_LEVELUP_YES_NO                      ;; 02:66e7 $fe $19
    ret  Z                                             ;; 02:66e9 $c8
    cp   A, WINDOW_VENDOR_MONEY                        ;; 02:66ea $fe $0c
    jr   NZ, .jr_02_66f4                               ;; 02:66ec $20 $06
.jr_02_66ee:
    ld   HL, $1214                                     ;; 02:66ee $21 $14 $12
    ld   DE, $00                                       ;; 02:66f1 $11 $00 $00
.jr_02_66f4:
    call showSpritesBehindWindow
    ret                                                ;; 02:66f7 $c9

;@jumptable amount=4
drawWindowJumptable:
    dw   drawWindowStart                               ;; 02:66f8 pP $00
    dw   drawWindowTopOrBottom                         ;; 02:66fa pP $01
    dw   windowDrawMiddle                              ;; 02:66fc pP $02
    dw   windowDrawBottom                              ;; 02:66fe pP $03

; Draw window now does its own rate limiting instead of drawing only one line of tiles per frame.
; This results in a drastic speedup.
drawWindow:
    ld   A, [wDrawWindowStep]                          ;; 02:6703 $fa $54 $d8
.loop:
    ld hl, drawWindowJumptable
    call callJumptable
; The level up preview screen draws the stats window and the Yes/No window in parallel.
; They could be detangled but it's easier to just let them be slow.
    ld a, [wDialogType]
    cp WINDOW_LEVELUP_JOBS
    ret z
    cp WINDOW_LEVELUP_YES_NO
    ret z
; If scanline is 96 or above, return.
    ldh a, [rLY]
    cp $60
    ret nc
; Return if finished.
    ld a, [wDrawWindowStep]
    or a
    jr nz, .loop
    ret                                                ;; 02:6709 $c9

drawWindowStart:
; Backup the first three sprites. Windows may use up to three sprites:
; Two hand pointers and a trashcan.
    ld   HL, wOAMBuffer                                ;; 02:670a $21 $00 $c0
    ld   DE, wOAMBufferBackup                          ;; 02:670d $11 $83 $d6
    ld   B, $18                                        ;; 02:6710 $06 $18
    call copyHLtoDE                                    ;; 02:6712 $cd $49 $2b
    ld   A, [wDialogType]                              ;; 02:6715 $fa $4a $d8
    push AF                                            ;; 02:6718 $f5
    call getWindowData                                 ;; 02:6719 $cd $88 $6c
    ld   E, [HL]                                       ;; 02:671c $5e
    inc  HL                                            ;; 02:671d $23
    ld   D, [HL]                                       ;; 02:671e $56
    pop  AF                                            ;; 02:671f $f1
    cp   A, WINDOW_LEVELUP_FANFARE                     ;; 02:6720 $fe $21
    jr   Z, .moveWindowIfOverlapsPlayer                ;; 02:6722 $28 $04
    cp   A, WINDOW_DIALOG                              ;; 02:6724 $fe $06
    jr   NZ, .set_dimensions                           ;; 02:6726 $20 $11
.moveWindowIfOverlapsPlayer:
    ; This handles moving the dialog window (or the initial level up window).
    ; There is exactly a 16 pixel gap between the two window locations.
    ; So if the player is in the middle there is a decision to be made on where to position the window.
    ; Originally the window was biased towards the top of the screen,
    ; but biasing it to the bottom means covering the status bar and less of the play field.
    ; An exception is made if the player is facing south, which likely implies talking to a character there.
    ld a, [wObjectRuntimeData.player]
    bit 3, a                                           ; the bit for facing south
    ld a, [wObjectRuntimeData.player + 4]              ; y coordinate of the bottom of the player sprite
    jr z, .check_position
    ; If the player's facing is south then changing the position check by just one pixel is enough
    inc a
.check_position:
    cp a, $51                                          ;  height of the window plus the player plus one (64+16+1=81)
    jr   C, .set_dimensions                            ;; 02:6735 $38 $02
    ld   D, $00                                        ;; 02:6737 $16 $00
.set_dimensions:
    inc  HL                                            ;; 02:6739 $23
    ld   C, [HL]                                       ;; 02:673a $4e
    inc  HL                                            ;; 02:673b $23
    ld   B, [HL]                                       ;; 02:673c $46
    call setWindowDimensions                           ;; 02:673d $cd $73 $7a
    call saveRegisterState2                            ;; 02:6740 $cd $80 $6d
    inc  B                                             ;; 02:6743 $04
    inc  C                                             ;; 02:6744 $0c
    push BC                                            ;; 02:6745 $c5
    pop  HL                                            ;; 02:6746 $e1
    ld   A, [wDialogType]                              ;; 02:6747 $fa $4a $d8
    cp   A, WINDOW_EQUIP_TOP                           ;; 02:674a $fe $03
    jr   Z, .jr_02_675a                                ;; 02:674c $28 $0c
    cp   A, WINDOW_SAVE_LOAD_FILE_1                    ;; 02:674e $fe $1b
    jr   Z, .jr_02_675a                                ;; 02:6750 $28 $08
    cp   A, WINDOW_STATUS_SCREEN_RIGHT                 ;; 02:6752 $fe $12
    jr   Z, .jr_02_675a                                ;; 02:6754 $28 $04
    cp   A, WINDOW_VENDOR_MONEY                        ;; 02:6756 $fe $0c
    jr   NZ, .jr_02_6760                               ;; 02:6758 $20 $06
.jr_02_675a:
    ld   HL, $1214                                     ;; 02:675a $21 $14 $12
    ld   DE, $00                                       ;; 02:675d $11 $00 $00
.jr_02_6760:
    push DE                                            ;; 02:6760 $d5
    call hideSpritesBehindWindow
    pop  DE                                            ;; 02:6764 $d1
    ld hl, wMenuStateCurrentFunction
    set 7, [hl]
    ld   A, $77                                        ;; 02:676d $3e $77
    ld   [wDialogBorderTile], A                        ;; 02:676f $ea $63 $d8
    ld   A, [wDialogType]                              ;; 02:6772 $fa $4a $d8
    cp   A, WINDOW_STATUS_SCREEN_AP_DP                 ;; 02:6775 $fe $1a
    jr   Z, windowDrawFinished                         ;; 02:6777 $28 $3e
    cp   A, WINDOW_TITLE_SCREEN                        ;; 02:6779 $fe $1f
    jr   Z, windowDrawFinished                         ;; 02:677b $28 $3a
    ld hl, wDrawWindowStep
    inc [hl]
    ret                                                ;; 02:6782 $c9

drawWindowTopOrBottom:
    call loadRegisterState2                            ;; 02:6783 $cd $a7 $6d
    push DE                                            ;; 02:6786 $d5
    push BC                                            ;; 02:6787 $c5
    call drawDialogTopOrBottomLine                     ;; 02:6788 $cd $6e $68
    pop  BC                                            ;; 02:678b $c1
    pop  DE                                            ;; 02:678c $d1
    dec  B                                             ;; 02:678d $05
    inc  D                                             ;; 02:678e $14
    call saveRegisterState2                            ;; 02:678f $cd $80 $6d
    ld   A, $02                                        ;; 02:6792 $3e $02
    ld   [wDrawWindowStep], A                          ;; 02:6794 $ea $54 $d8
    ret                                                ;; 02:6797 $c9

windowDrawMiddle:
    call loadRegisterState2                            ;; 02:6798 $cd $a7 $6d
    push DE                                            ;; 02:679b $d5
    push BC                                            ;; 02:679c $c5
; Inlined from drawDialogCenterLine (now removed)
    ld   a, $7a
    call storeTileAatScreenPositionDE
    ld   [hl+], a
    dec  c
    inc  e
.loop:
    ld   a, $7f
    call storeTileAatScreenPositionDE
    ld   [hl+], a
    inc  e
    dec  c
    jr   nz, .loop
    ld   a, $7b
    call storeTileAatScreenPositionDE
    ld   [hl+], a
    pop  BC                                            ;; 02:67a0 $c1
    pop  DE                                            ;; 02:67a1 $d1
    inc  D                                             ;; 02:67a2 $14
    dec  B                                             ;; 02:67a3 $05
    call saveRegisterState2                            ;; 02:67a4 $cd $80 $6d
    ret  NZ                                            ;; 02:67a7 $c0
    ld   A, $7c                                        ;; 02:67a8 $3e $7c
    ld   [wDialogBorderTile], A                        ;; 02:67aa $ea $63 $d8
    ld hl, wDrawWindowStep
    inc [hl]
    ret                                                ;; 02:67b3 $c9

windowDrawBottom:
    call drawWindowTopOrBottom                         ;; 02:67b4 $cd $83 $67

windowDrawFinished:
    ld   A, D                                          ;; 02:67b7 $7a
; Check the bottom y coordinate for overlap with the status bar
; and disable the sprite hiding effect if needed.
    cp a, $11
    call NC, disableStatusBarEffect                    ;; 02:67ba $d4 $44 $7a
    ld   DE, $800                                      ;; 02:67c2 $11 $00 $08
    ld   BC, $913                                      ;; 02:67c5 $01 $13 $09
    call saveRegisterState2                            ;; 02:67c8 $cd $80 $6d
    ld   A, [wDialogType]                              ;; 02:67cb $fa $4a $d8
    cp   A, WINDOW_EQUIP_TOP                           ;; 02:67ce $fe $03
    jr   Z, .draw_equipment_screen_bottom              ;; 02:67d0 $28 $18
    ld hl, wMenuStateCurrentFunction
    res 7, [hl]
    ld hl, wDrawWindowStep
    ld [hl], $00
    cp   A, $04                                        ;; 02:67e1 $fe $04
    ret  NZ                                            ;; 02:67e3 $c0
    ld   A, WINDOW_EQUIP_TOP                           ;; 02:67e4 $3e $03
    ld   [wDialogType], A                              ;; 02:67e6 $ea $4a $d8
    ret                                                ;; 02:67e9 $c9
.draw_equipment_screen_bottom:
    ld   A, WINDOW_EQUIP_BOTTOM                        ;; 02:67ea $3e $04
    ld   [wDialogType], A                              ;; 02:67ec $ea $4a $d8
    ld   A, $02                                        ;; 02:67ef $3e $02
    ld   [wDrawWindowStep], A                          ;; 02:67f1 $ea $54 $d8
    ret                                                ;; 02:67f4 $c9

;@jumptable amount=2
data_02_67f5:
    dw   call_02_680e                                  ;; 02:67f5 pP $00
    dw   call_02_6840                                  ;; 02:67f7 pP $01

call_02_67f9:
    ld   A, [wMenuStateCurrentFunction]                ;; 02:67f9 $fa $53 $d8
    or   A, $80                                        ;; 02:67fc $f6 $80
    ld   [wMenuStateCurrentFunction], A                ;; 02:67fe $ea $53 $d8
    ld   A, [wD856]                                    ;; 02:6801 $fa $56 $d8
    call saveRegisterState2                            ;; 02:6804 $cd $80 $6d
    ld   HL, data_02_67f5                              ;; 02:6807 $21 $f5 $67
    call callJumptable
    ret                                                ;; 02:680d $c9

call_02_680e:
    ld   A, B                                          ;; 02:680e $78
    ld   [wMenuStateFunctionNew], A                    ;; 02:680f $ea $50 $d8
    call loadRegisterState2                            ;; 02:6812 $cd $a7 $6d
    ld   A, [wMenuFlags]                               ;; 02:6815 $fa $49 $d8
    and  A, $cf                                        ;; 02:6818 $e6 $cf
    ld   [wMenuFlags], A                               ;; 02:681a $ea $49 $d8
    push HL                                            ;; 02:681d $e5
    push DE                                            ;; 02:681e $d5
    call updateJoypadInput
    pop  DE                                            ;; 02:6822 $d1
    pop  HL                                            ;; 02:6823 $e1
    push BC                                            ;; 02:6824 $c5
    call call_02_6b20                                  ;; 02:6825 $cd $20 $6b
    pop  BC                                            ;; 02:6828 $c1
    ld   A, C                                          ;; 02:6829 $79
    and  A, A                                          ;; 02:682a $a7
    ret  Z                                             ;; 02:682b $c8
    call processWindowInput                            ;; 02:682c $cd $93 $68
    call showMenuFingerPointing_1                      ;; 02:682f $cd $be $6b
    call saveRegisterState1                            ;; 02:6832 $cd $34 $6d
    ld   A, $01                                        ;; 02:6835 $3e $01
    ld   [wD856], A                                    ;; 02:6837 $ea $56 $d8
    ld   A, [wMenuFlags]                               ;; 02:683a $fa $49 $d8
    and  A, $30                                        ;; 02:683d $e6 $30
    ret                                                ;; 02:683f $c9

call_02_6840:
    call loadRegisterState2                            ;; 02:6840 $cd $a7 $6d
    push HL                                            ;; 02:6843 $e5
    ld   HL, wMenuSelectionMoveRepeatDelay             ;; 02:6844 $21 $57 $d8
    dec  [HL]                                          ;; 02:6847 $35
    pop  HL                                            ;; 02:6848 $e1
    ret  NZ                                            ;; 02:6849 $c0
    ld   A, $07                                        ;; 02:684a $3e $06
    ld   [wMenuSelectionMoveRepeatDelay], A            ;; 02:684c $ea $57 $d8
    ld   A, $00                                        ;; 02:684f $3e $00
    ld   [wD856], A                                    ;; 02:6851 $ea $56 $d8
    ret                                                ;; 02:6854 $c9

; C=width of line
; DE=position on the screen
; HL=backup location for overwritten tiles
drawDialogTopOrBottomLine:
    ld   A, [wDialogBorderTile]                        ;; 02:686e $fa $63 $d8
    push AF                                            ;; 02:6871 $f5
    call storeTileAatScreenPositionDE                  ;; 02:6872 $cd $91 $38
    ld   [HL+], A                                      ;; 02:6875 $22
    pop  AF                                            ;; 02:6876 $f1
    inc  A                                             ;; 02:6877 $3c
    ld   [wDialogBorderTile], A                        ;; 02:6878 $ea $63 $d8
    inc  E                                             ;; 02:687b $1c
    dec  C                                             ;; 02:687c $0d
.loop:
    ld   A, [wDialogBorderTile]                        ;; 02:687d $fa $63 $d8
    call storeTileAatScreenPositionDE                  ;; 02:6881 $cd $91 $38
    ld   [HL+], A                                      ;; 02:6884 $22
    inc  E                                             ;; 02:6886 $1c
    dec  C                                             ;; 02:6887 $0d
    jr   NZ, .loop                                     ;; 02:6888 $20 $f3
    ld   A, [wDialogBorderTile]                        ;; 02:688a $fa $63 $d8
    inc  A                                             ;; 02:688d $3c
    call storeTileAatScreenPositionDE                  ;; 02:688e $cd $91 $38
    ld   [HL+], A                                      ;; 02:6891 $22
    ret                                                ;; 02:6892 $c9

processWindowInput:
    ld   A, [wDialogType]                              ;; 02:6893 $fa $4a $d8
    cp   A, WINDOW_STATUS_SCREEN_TOP                   ;; 02:6896 $fe $15
    jr   Z, .check_buttons                             ;; 02:6898 $28 $12
    bit  0, C                                          ;; 02:689a $cb $41
    jr   NZ, .dpad_right                               ;; 02:689c $20 $3d
    bit  1, C                                          ;; 02:689e $cb $49
    jr   NZ, .dpad_left                                ;; 02:68a0 $20 $64
    bit  2, C                                          ;; 02:68a2 $cb $51
    jp   NZ, .dpad_up                                  ;; 02:68a4 $c2 $2d $69
    bit  3, C                                          ;; 02:68a7 $cb $59
    jp   NZ, .dpad_down                                ;; 02:68a9 $c2 $38 $69
.check_buttons:
    bit  4, C                                          ;; 02:68ac $cb $61
    jr   NZ, .button                                   ;; 02:68ae $20 $14
    bit  7, C                                          ;; 02:68b0 $cb $79
    jp   NZ, .start_button                             ;; 02:68b2 $c2 $43 $69
    bit  5, C                                          ;; 02:68b5 $cb $69
    ret  Z                                             ;; 02:68b7 $c8
; B button
    ld   A, [wDialogType]                              ;; 02:68b8 $fa $4a $d8
    cp   A, WINDOW_LEVELUP_JOBS                        ;; 02:68bb $fe $18
    ret  Z                                             ;; 02:68bd $c8
    ld   A, H                                          ;; 02:68be $7c
    ld   [wSRAMSaveHeader._a], A                       ;; 02:68bf $ea $b1 $d7
    ld   H, $ff                                        ;; 02:68c2 $26 $ff
.button:
    ld   A, [wMenuFlags]                               ;; 02:68c4 $fa $49 $d8
    or   A, $08                                        ;; 02:68c7 $f6 $08
    ld   [wMenuFlags], A                               ;; 02:68c9 $ea $49 $d8
    ld   B, H                                          ;; 02:68cc $44
    ld   H, $ff                                        ;; 02:68cd $26 $ff
    ld   A, [wD88D]                                    ;; 02:68cf $fa $8d $d8
    ld   [wMenuStateCurrentFunction], A                ;; 02:68d2 $ea $53 $d8
    ld   A, $12                                        ;; 02:68d5 $3e $12
    call playSFX                                       ;; 02:68d7 $cd $7d $29
    ret                                                ;; 02:68da $c9
.dpad_right:
    ld   A, [wMenuFlags]                               ;; 02:68db $fa $49 $d8
    rrca                                               ;; 02:68de $0f
    ret  NC                                            ;; 02:68df $d0
    ld   A, [wWindowNumberOfSelections]                ;; 02:68e0 $fa $45 $d8
    cp   A, H                                          ;; 02:68e3 $bc
    ret  C                                             ;; 02:68e4 $d8
    ld   A, [wCursorColumns]                           ;; 02:68e5 $fa $66 $d8
    ld   B, A                                          ;; 02:68e8 $47
    inc  B                                             ;; 02:68e9 $04
    ld   A, [wD868]                                    ;; 02:68ea $fa $68 $d8
    inc  A                                             ;; 02:68ed $3c
    cp   A, B                                          ;; 02:68ee $b8
    ret  NC                                            ;; 02:68ef $d0
    ld   [wD868], A                                    ;; 02:68f0 $ea $68 $d8
    ld   A, [wCursorColumnWidth]                       ;; 02:68f3 $fa $67 $d8
    add  A, E                                          ;; 02:68f6 $83
    ld   E, A                                          ;; 02:68f7 $5f
    inc  H                                             ;; 02:68f8 $24
    ld   A, [wDialogType]                              ;; 02:68f9 $fa $4a $d8
    cp   A, WINDOW_SELECT_MENU                         ;; 02:68fc $fe $11
    ret  NZ                                            ;; 02:68fe $c0
    ld   A, H                                          ;; 02:68ff $7c
    inc  A                                             ;; 02:6900 $3c
    and  A, $01                                        ;; 02:6901 $e6 $01
    ret  Z                                             ;; 02:6903 $c8
    dec  E                                             ;; 02:6904 $1d
    ret                                                ;; 02:6905 $c9
.dpad_left:
    ld   A, [wMenuFlags]                               ;; 02:6906 $fa $49 $d8
    rrca                                               ;; 02:6909 $0f
    ret  NC                                            ;; 02:690a $d0
    ld   A, [wWindowNumberOfSelections]                ;; 02:690b $fa $45 $d8
    cp   A, H                                          ;; 02:690e $bc
    ret  C                                             ;; 02:690f $d8
    ld   A, [wD868]                                    ;; 02:6910 $fa $68 $d8
    dec  A                                             ;; 02:6913 $3d
    ret  Z                                             ;; 02:6914 $c8
    ld   [wD868], A                                    ;; 02:6915 $ea $68 $d8
    ld   A, [wCursorColumnWidth]                       ;; 02:6918 $fa $67 $d8
    ld   B, A                                          ;; 02:691b $47
    ld   A, E                                          ;; 02:691c $7b
    sub  A, B                                          ;; 02:691d $90
    ld   E, A                                          ;; 02:691e $5f
    dec  H                                             ;; 02:691f $25
    ld   A, [wDialogType]                              ;; 02:6920 $fa $4a $d8
    cp   A, WINDOW_SELECT_MENU                         ;; 02:6923 $fe $11
    ret  NZ                                            ;; 02:6925 $c0
    ld   A, H                                          ;; 02:6926 $7c
    inc  A                                             ;; 02:6927 $3c
    and  A, $01                                        ;; 02:6928 $e6 $01
    ret  NZ                                            ;; 02:692a $c0
    inc  E                                             ;; 02:692b $1c
    ret                                                ;; 02:692c $c9
.dpad_up:
    call call_02_6a59                                  ;; 02:692d $cd $59 $6a
    push HL                                            ;; 02:6930 $e5
    push DE                                            ;; 02:6931 $d5
    call NC, call_02_6a35                              ;; 02:6932 $d4 $35 $6a
    pop  DE                                            ;; 02:6935 $d1
    pop  HL                                            ;; 02:6936 $e1
    ret                                                ;; 02:6937 $c9
.dpad_down:
    call call_02_69aa                                  ;; 02:6938 $cd $aa $69
    push HL                                            ;; 02:693b $e5
    push DE                                            ;; 02:693c $d5
    call NC, call_02_6a09                              ;; 02:693d $d4 $09 $6a
    pop  DE                                            ;; 02:6940 $d1
    pop  HL                                            ;; 02:6941 $e1
    ret                                                ;; 02:6942 $c9
.start_button:
    ld   A, [wDialogType]                              ;; 02:6943 $fa $4a $d8
    cp   A, WINDOW_NAMING_SCREEN_BOTTOM                ;; 02:6946 $fe $1e
    ret  NZ                                            ;; 02:6948 $c0
; Everything from here on deals with the naming screen
    ld   A, [wNameEntryNameLength]                     ;; 02:6949 $fa $85 $d8
    and  A, A                                          ;; 02:694c $a7
    ret  Z                                             ;; 02:694d $c8
    push HL                                            ;; 02:694e $e5
    push DE                                            ;; 02:694f $d5
    push BC                                            ;; 02:6950 $c5
    ld   HL, wSRAMSaveHeader                           ;; 02:6951 $21 $a7 $d7
    ld   DE, wBoyName                                  ;; 02:6954 $11 $9d $d7
    ld   B, SAVE_MAX_NAME_LENGTH                       ;; 02:6957 $06 $04
    ld   A, [wWindowFlags]                             ;; 02:6959 $fa $74 $d8
    bit  5, A                                          ;; 02:695c $cb $6f
    push AF                                            ;; 02:695e $f5
    jr   Z, .copy_name_loop                            ;; 02:695f $28 $03
    ld   DE, wGirlName                                 ;; 02:6961 $11 $a2 $d7
.copy_name_loop:
    ld a, [hl]
    ld [de], a
    xor a, a
    ld [hl+], a
    inc de
    dec b
    jr   nz, .copy_name_loop
    ld   [hl], a
    pop  AF                                            ;; 02:6975 $f1
    pop  BC                                            ;; 02:6976 $c1
    pop  DE                                            ;; 02:6977 $d1
    pop  HL                                            ;; 02:6978 $e1
; Modified to be run twice for the two names instead of prompting for both.
    set 5, a
    ld   [wWindowFlags], A                             ;; 02:6981 $ea $74 $d8
    xor  A, A                                          ;; 02:698e $af
    ld   [wDrawWindowStep], A                          ;; 02:698f $ea $54 $d8
    ld   [wMenuStateCurrentFunction], A                ;; 02:6992 $ea $53 $d8
    ld   A, [wScriptPointerHigh]                       ;; 02:6995 $fa $b7 $d8
    ld   H, A                                          ;; 02:6998 $67
    ld   A, [wScriptPointerLow]                        ;; 02:6999 $fa $b6 $d8
    ld   L, A                                          ;; 02:699c $6f
    dec  HL                                            ;; 02:699d $2b
    dec  HL                                            ;; 02:699e $2b
    ld   A, H                                          ;; 02:699f $7c
    ld   [wScriptPointerHigh], A                       ;; 02:69a0 $ea $b7 $d8
    ld   A, L                                          ;; 02:69a3 $7d
    ld   [wScriptPointerLow], A                        ;; 02:69a4 $ea $b6 $d8
    jp   windowReturnToScript                          ;; 02:69a7 $c3 $38 $56

ds 23 ; Free space

call_02_69aa:
    ld   A, [wDialogType]                              ;; 02:69aa $fa $4a $d8
    cp   A, WINDOW_SAVE_LOAD_FILE_1                    ;; 02:69ad $fe $1b
    jr   Z, .jr_02_69fe                                ;; 02:69af $28 $4d
    cp   A, WINDOW_SELECT_MENU                         ;; 02:69b1 $fe $11
    scf                                                ;; 02:69b3 $37
    ret  Z                                             ;; 02:69b4 $c8
    ld   A, [wWindowNumberOfSelections]                ;; 02:69b5 $fa $45 $d8
    dec  A                                             ;; 02:69b8 $3d
    cp   A, H                                          ;; 02:69b9 $bc
    ret  C                                             ;; 02:69ba $d8
    ld   A, [wDialogType]                              ;; 02:69bb $fa $4a $d8
    cp   A, WINDOW_NAMING_SCREEN_BOTTOM                ;; 02:69be $fe $1e
    jr   NZ, .jr_02_69c6                               ;; 02:69c0 $20 $04
    ld   A, $09                                        ;; 02:69c2 $3e $09
    jr   .jr_02_69cc                                   ;; 02:69c4 $18 $06
.jr_02_69c6:
    ld   A, [wMenuFlags]                               ;; 02:69c6 $fa $49 $d8
    and  A, $01                                        ;; 02:69c9 $e6 $01
    inc  A                                             ;; 02:69cb $3c
.jr_02_69cc:
    add  A, H                                          ;; 02:69cc $84
    ld   L, A                                          ;; 02:69cd $6f
    ld   A, [wWindowNumberOfSelections]                ;; 02:69ce $fa $45 $d8
    dec  A                                             ;; 02:69d1 $3d
    cp   A, L                                          ;; 02:69d2 $bd
    jr   NC, .jr_02_69f0                               ;; 02:69d3 $30 $1b
    ld   A, [wDialogType]                              ;; 02:69d5 $fa $4a $d8
    and  A, A                                          ;; 02:69d8 $a7
    ret  Z                                             ;; 02:69d9 $c8
    ld   A, [wMenuFlags]                               ;; 02:69da $fa $49 $d8
    and  A, $02                                        ;; 02:69dd $e6 $02
    ccf                                                ;; 02:69df $3f
    ret  Z                                             ;; 02:69e0 $c8
    ld   A, [wDialogType]                              ;; 02:69e1 $fa $4a $d8
    cp   A, WINDOW_LEVELUP_YES_NO                      ;; 02:69e4 $fe $19
    ccf                                                ;; 02:69e6 $3f
    ret  Z                                             ;; 02:69e7 $c8
    cp   A, WINDOW_LEVELUP_JOBS                        ;; 02:69e8 $fe $18
    ccf                                                ;; 02:69ea $3f
    ret  Z                                             ;; 02:69eb $c8
    ld   L, $fe                                        ;; 02:69ec $2e $fe
    ld   E, $0e                                        ;; 02:69ee $1e $0e
.jr_02_69f0:
    ld   H, L                                          ;; 02:69f0 $65
    ld   A, D                                          ;; 02:69f1 $7a
    add  A, $02                                        ;; 02:69f2 $c6 $02
    ld   L, A                                          ;; 02:69f4 $6f
    ld   A, [wDialogH]                                 ;; 02:69f5 $fa $aa $d4
    dec  A                                             ;; 02:69f8 $3d
    cp   A, L                                          ;; 02:69f9 $bd
    ccf                                                ;; 02:69fa $3f
    ret  NC                                            ;; 02:69fb $d0
    ld   D, L                                          ;; 02:69fc $55
    ret                                                ;; 02:69fd $c9
.jr_02_69fe:
    ld   A, H                                          ;; 02:69fe $7c
    dec  A                                             ;; 02:69ff $3d
    scf                                                ;; 02:6a00 $37
    ret  Z                                             ;; 02:6a01 $c8
    inc  H                                             ;; 02:6a02 $24
    ld   A, $08                                        ;; 02:6a03 $3e $08
    add  A, D                                          ;; 02:6a05 $82
    ld   D, A                                          ;; 02:6a06 $57
    scf                                                ;; 02:6a07 $37
    ret                                                ;; 02:6a08 $c9

call_02_6a09:
    ld   A, [wMenuFlags]                               ;; 02:6a09 $fa $49 $d8
    or   A, $10                                        ;; 02:6a0c $f6 $10
    ld   [wMenuFlags], A                               ;; 02:6a0e $ea $49 $d8
    ld   L, $01                                        ;; 02:6a11 $2e $01
    ld   A, [wDialogType]                              ;; 02:6a13 $fa $4a $d8
    cp   A, WINDOW_NAMING_SCREEN_BOTTOM                ;; 02:6a16 $fe $1e
    jr   Z, .jr_02_6a21                                ;; 02:6a18 $28 $07
    ld   A, [wMenuFlags]                               ;; 02:6a1a $fa $49 $d8
    and  A, $01                                        ;; 02:6a1d $e6 $01
    inc  A                                             ;; 02:6a1f $3c
    ld   L, A                                          ;; 02:6a20 $6f
.jr_02_6a21:
    ld   A, [wD848]                                    ;; 02:6a21 $fa $48 $d8
    add  A, L                                          ;; 02:6a24 $85
    ld   [wD848], A                                    ;; 02:6a25 $ea $48 $d8
    ld   [wD846], A                                    ;; 02:6a28 $ea $46 $d8
    ld   A, [wD899]                                    ;; 02:6a2b $fa $99 $d8
    sub  A, $02                                        ;; 02:6a2e $d6 $02
    ld   [wD899], A                                    ;; 02:6a30 $ea $99 $d8
    jr   jr_02_6a47                                    ;; 02:6a33 $18 $12

call_02_6a35:
    ld   A, [wD899]                                    ;; 02:6a35 $fa $99 $d8
    add  A, $02                                        ;; 02:6a38 $c6 $02
    ld   [wD899], A                                    ;; 02:6a3a $ea $99 $d8
    ld   A, [wMenuFlags]                               ;; 02:6a3d $fa $49 $d8
    and  A, $7f                                        ;; 02:6a40 $e6 $7f
    or   A, $20                                        ;; 02:6a42 $f6 $20
    ld   [wMenuFlags], A                               ;; 02:6a44 $ea $49 $d8

jr_02_6a47:
    call call_02_6ae7                                  ;; 02:6a47 $cd $e7 $6a
    ld   A, [wWindowTextLength]                        ;; 02:6a4a $fa $9b $d8
    ld   B, A                                          ;; 02:6a4d $47
    ld   A, [wWindowTextRows]                          ;; 02:6a4e $fa $9a $d8
    ld   C, A                                          ;; 02:6a51 $4f
    ld   DE, $202                                      ;; 02:6a52 $11 $02 $02
    call saveRegisterState2                            ;; 02:6a55 $cd $80 $6d
    ret                                                ;; 02:6a58 $c9

call_02_6a59:
    ld   A, [wDialogType]                              ;; 02:6a59 $fa $4a $d8
    cp   A, WINDOW_SAVE_LOAD_FILE_1                    ;; 02:6a5c $fe $1b
    jr   Z, .jr_02_6aa5                                ;; 02:6a5e $28 $45
    cp   A, WINDOW_NAMING_SCREEN_BOTTOM                ;; 02:6a60 $fe $1e
    jr   NZ, .jr_02_6a68                               ;; 02:6a62 $20 $04
    ld   A, WINDOW_START_MENU_STATUS                   ;; 02:6a64 $3e $09
    jr   .jr_02_6a6e                                   ;; 02:6a66 $18 $06
.jr_02_6a68:
    ld   A, [wMenuFlags]                               ;; 02:6a68 $fa $49 $d8
    and  A, $01                                        ;; 02:6a6b $e6 $01
    inc  A                                             ;; 02:6a6d $3c
.jr_02_6a6e:
    ld   L, A                                          ;; 02:6a6e $6f
    ld   A, H                                          ;; 02:6a6f $7c
    sub  A, L                                          ;; 02:6a70 $95
    ret  C                                             ;; 02:6a71 $d8
    ld   A, [wMenuFlags]                               ;; 02:6a72 $fa $49 $d8
    and  A, $01                                        ;; 02:6a75 $e6 $01
    inc  A                                             ;; 02:6a77 $3c
    ld   L, A                                          ;; 02:6a78 $6f
    ld   A, D                                          ;; 02:6a79 $7a
    dec  A                                             ;; 02:6a7a $3d
    dec  A                                             ;; 02:6a7b $3d
    sub  A, L                                          ;; 02:6a7c $95
    jr   NC, .jr_02_6ab0                               ;; 02:6a7d $30 $31
    ld   A, [wDialogType]                              ;; 02:6a7f $fa $4a $d8
    cp   A, WINDOW_NAMING_SCREEN_BOTTOM                ;; 02:6a82 $fe $1e
    jr   NZ, .jr_02_6a88                               ;; 02:6a84 $20 $02
    ld   L, $01                                        ;; 02:6a86 $2e $01
.jr_02_6a88:
    ld   A, [wD848]                                    ;; 02:6a88 $fa $48 $d8
    sub  A, L                                          ;; 02:6a8b $95
    ret  C                                             ;; 02:6a8c $d8
    push AF                                            ;; 02:6a8d $f5
    call hideTrashcan                                  ;; 02:6a8e $cd $74 $6b
    pop  AF                                            ;; 02:6a91 $f1
    ld   [wD848], A                                    ;; 02:6a92 $ea $48 $d8
    ld   [wD846], A                                    ;; 02:6a95 $ea $46 $d8
    ld   A, [wDialogType]                              ;; 02:6a98 $fa $4a $d8
    cp   A, WINDOW_NAMING_SCREEN_BOTTOM                ;; 02:6a9b $fe $1e
    jr   NZ, .jr_02_6aa1                               ;; 02:6a9d $20 $02
    ld   L, $09                                        ;; 02:6a9f $2e $09
.jr_02_6aa1:
    ld   A, H                                          ;; 02:6aa1 $7c
    sub  A, L                                          ;; 02:6aa2 $95
    ld   H, A                                          ;; 02:6aa3 $67
    ret                                                ;; 02:6aa4 $c9
.jr_02_6aa5:
    ld   A, H                                          ;; 02:6aa5 $7c
    dec  A                                             ;; 02:6aa6 $3d
    scf                                                ;; 02:6aa7 $37
    ret  NZ                                            ;; 02:6aa8 $c0
    dec  H                                             ;; 02:6aa9 $25
    ld   A, D                                          ;; 02:6aaa $7a
    sub  A, $08                                        ;; 02:6aab $d6 $08
    ld   D, A                                          ;; 02:6aad $57
    scf                                                ;; 02:6aae $37
    ret                                                ;; 02:6aaf $c9
.jr_02_6ab0:
    ld   A, H                                          ;; 02:6ab0 $7c
    cp   A, $fe                                        ;; 02:6ab1 $fe $fe
    jr   Z, .jr_02_6ad0                                ;; 02:6ab3 $28 $1b
    ld   A, [wDialogType]                              ;; 02:6ab5 $fa $4a $d8
    cp   A, WINDOW_NAMING_SCREEN_BOTTOM                ;; 02:6ab8 $fe $1e
    jr   NZ, .jr_02_6ac0                               ;; 02:6aba $20 $04
    ld   A, WINDOW_START_MENU_STATUS                   ;; 02:6abc $3e $09
    jr   .jr_02_6ac6                                   ;; 02:6abe $18 $06
.jr_02_6ac0:
    ld   A, [wMenuFlags]                               ;; 02:6ac0 $fa $49 $d8
    and  A, $01                                        ;; 02:6ac3 $e6 $01
    inc  A                                             ;; 02:6ac5 $3c
.jr_02_6ac6:
    ld   L, A                                          ;; 02:6ac6 $6f
    ld   A, H                                          ;; 02:6ac7 $7c
    sub  A, L                                          ;; 02:6ac8 $95
    ld   H, A                                          ;; 02:6ac9 $67
    ld   A, D                                          ;; 02:6aca $7a
    sub  A, $02                                        ;; 02:6acb $d6 $02
    ld   D, A                                          ;; 02:6acd $57
    scf                                                ;; 02:6ace $37
    ret                                                ;; 02:6acf $c9
.jr_02_6ad0:
    ld   A, [wWindowNumberOfSelections]                ;; 02:6ad0 $fa $45 $d8
    dec  A                                             ;; 02:6ad3 $3d
    dec  A                                             ;; 02:6ad4 $3d
    ld   H, A                                          ;; 02:6ad5 $67
    ld   A, D                                          ;; 02:6ad6 $7a
    sub  A, L                                          ;; 02:6ad7 $95
    ld   D, A                                          ;; 02:6ad8 $57
    ld   E, $00                                        ;; 02:6ad9 $1e $00
    ld   A, [wCursorColumns]                           ;; 02:6adb $fa $66 $d8
    dec  A                                             ;; 02:6ade $3d
    ld   [wD868], A                                    ;; 02:6adf $ea $68 $d8
    call processWindowInput.dpad_right                 ;; 02:6ae2 $cd $db $68
    scf                                                ;; 02:6ae5 $37
    ret                                                ;; 02:6ae6 $c9

call_02_6ae7:
    ld   A, [wOAMBuffer]                               ;; 02:6ae7 $fa $00 $c0
    and  A, A                                          ;; 02:6aea $a7
    ret  Z                                             ;; 02:6aeb $c8
    push HL                                            ;; 02:6aec $e5
    push DE                                            ;; 02:6aed $d5
    ld   A, [wDialogType]                              ;; 02:6aee $fa $4a $d8
    cp   A, WINDOW_LEVELUP_YES_NO                      ;; 02:6af1 $fe $19
    call Z, call_02_6b18                               ;; 02:6af3 $cc $18 $6b
    ld   A, [wD898]                                    ;; 02:6af6 $fa $98 $d8
    ld   E, A                                          ;; 02:6af9 $5f
    ld   A, [wD899]                                    ;; 02:6afa $fa $99 $d8
    ld   D, A                                          ;; 02:6afd $57
    and  A, A                                          ;; 02:6afe $a7
    jr   Z, .jr_02_6b12                                ;; 02:6aff $28 $11
    ld   A, [wDialogH]                                 ;; 02:6b01 $fa $aa $d4
    cp   A, D                                          ;; 02:6b04 $ba
    jr   C, .jr_02_6b12                                ;; 02:6b05 $38 $0b
    call showMenuFingerPointing_2                      ;; 02:6b07 $cd $a0 $6b
    ld   HL, wWindowSecondaryFlags                     ;; 02:6b0a $21 $72 $d8
    res  7, [HL]                                       ;; 02:6b0d $cb $be
    pop  DE                                            ;; 02:6b0f $d1
    pop  HL                                            ;; 02:6b10 $e1
    ret                                                ;; 02:6b11 $c9
.jr_02_6b12:
    call call_02_6b3a                                  ;; 02:6b12 $cd $3a $6b
    pop  DE                                            ;; 02:6b15 $d1
    pop  HL                                            ;; 02:6b16 $e1
    ret                                                ;; 02:6b17 $c9

call_02_6b18:
    push HL                                            ;; 02:6b18 $e5
    ld   HL, wWindowSecondaryFlags                     ;; 02:6b19 $21 $72 $d8
    set  7, [HL]                                       ;; 02:6b1c $cb $fe
    pop  HL                                            ;; 02:6b1e $e1
    ret                                                ;; 02:6b1f $c9

call_02_6b20:
    ld   A, [wOAMBuffer]                               ;; 02:6b20 $fa $00 $c0
    and  A, A                                          ;; 02:6b23 $a7
    ret  Z                                             ;; 02:6b24 $c8
    ld   A, [wWindowFingerBlinkTimerNumber]            ;; 02:6b25 $fa $44 $d8
    call timerCheckExpiredOrTickAllTimers              ;; 02:6b28 $cd $0a $30
    ret  NZ                                            ;; 02:6b2b $c0
    ld   A, [wOAMBuffer]                               ;; 02:6b2c $fa $00 $c0
    dec  A                                             ;; 02:6b2f $3d
    jr   Z, .jr_02_6b36                                ;; 02:6b30 $28 $04
    call call_02_6b3a                                  ;; 02:6b32 $cd $3a $6b
    ret                                                ;; 02:6b35 $c9
.jr_02_6b36:
    call call_02_6ae7                                  ;; 02:6b36 $cd $e7 $6a
    ret                                                ;; 02:6b39 $c9

call_02_6b3a:
    ld   A, [wDialogType]                              ;; 02:6b3a $fa $4a $d8
    cp   A, WINDOW_LEVELUP_YES_NO                      ;; 02:6b3d $fe $19
    jr   Z, .jr_02_6b48                                ;; 02:6b3f $28 $07
    ld   A, [wSelectedMenuIndex]                       ;; 02:6b41 $fa $4b $d8
    cp   A, H                                          ;; 02:6b44 $bc
    call Z, clearSecondMetasprite                      ;; 02:6b45 $cc $8c $6b
.jr_02_6b48:
    call clearFirstMetasprite                          ;; 02:6b48 $cd $84 $6b
    ld   A, $01                                        ;; 02:6b4b $3e $01
    ld   [wOAMBuffer], A                               ;; 02:6b4d $ea $00 $c0
    ret                                                ;; 02:6b50 $c9

hideAndSaveMenuMetasprites:
    push HL                                            ;; 02:6b51 $e5
    push DE                                            ;; 02:6b52 $d5
    push BC                                            ;; 02:6b53 $c5
; Restore the first three sprites.
    ld   DE, wOAMBuffer                                ;; 02:6b54 $11 $00 $c0
    ld   HL, wOAMBufferBackup                          ;; 02:6b57 $21 $83 $d6
    ld   B, $18                                        ;; 02:6b5a $06 $18
    call copyHLtoDE                                    ;; 02:6b5c $cd $49 $2b
; Then clear the first three sprites.
    call clearSecondMetasprite                         ;; 02:6b5f $cd $8c $6b
    call clearFirstMetasprite                          ;; 02:6b62 $cd $84 $6b
    call hideTrashcan                                  ;; 02:6b65 $cd $74 $6b
    pop  BC                                            ;; 02:6b68 $c1
    pop  DE                                            ;; 02:6b69 $d1
    pop  HL                                            ;; 02:6b6a $e1
    ld   A, [wWindowSecondaryFlags]                    ;; 02:6b6b $fa $72 $d8
    res  2, A                                          ;; 02:6b6e $cb $97
    ld   [wWindowSecondaryFlags], A                    ;; 02:6b70 $ea $72 $d8
    ret                                                ;; 02:6b73 $c9

; Hides the trash can that is used in the ITEMS and EQUIP windows.
; This is called unnecessarily a lot by window functions.
hideTrashcan:
    ld   A, [wMenuFlags]                               ;; 02:6b74 $fa $49 $d8
    and  A, $7f                                        ;; 02:6b77 $e6 $7f
    ld   [wMenuFlags], A                               ;; 02:6b79 $ea $49 $d8
    push HL                                            ;; 02:6b7c $e5
    push DE                                            ;; 02:6b7d $d5
    push BC                                            ;; 02:6b7e $c5
    ld   HL, wOAMBuffer._10                            ;; 02:6b7f $21 $10 $c0
    jr   clearMetasprite                               ;; 02:6b82 $18 $11

; Used for a hand sprite in menus where there are two hands.
clearFirstMetasprite:
    push HL                                            ;; 02:6b84 $e5
    push DE                                            ;; 02:6b85 $d5
    push BC                                            ;; 02:6b86 $c5
    ld   HL, wOAMBuffer                                ;; 02:6b87 $21 $00 $c0
    jr   clearMetasprite                               ;; 02:6b8a $18 $09

; Used for a hand sprite in menus
clearSecondMetasprite:
    push HL                                            ;; 02:6b8c $e5
    push DE                                            ;; 02:6b8d $d5
    push BC                                            ;; 02:6b8e $c5
    ld   HL, wOAMBuffer._08                            ;; 02:6b8f $21 $08 $c0
    ld   B, $08                                        ;; 02:6b92 $06 $08
    xor  A, A                                          ;; 02:6b94 $af

clearMetasprite:
    ld   B, $08                                        ;; 02:6b95 $06 $08
    xor  A, A                                          ;; 02:6b97 $af
.loop:
    ld   [HL+], A                                      ;; 02:6b98 $22
    dec  B                                             ;; 02:6b99 $05
    jr   NZ, .loop                                     ;; 02:6b9a $20 $fc
    pop  BC                                            ;; 02:6b9c $c1
    pop  DE                                            ;; 02:6b9d $d1
    pop  HL                                            ;; 02:6b9e $e1
    ret                                                ;; 02:6b9f $c9

showMenuFingerPointing_2:
    ld   A, [wOAMBuffer]                               ;; 02:6ba0 $fa $00 $c0
    and  A, A                                          ;; 02:6ba3 $a7
    ret  Z                                             ;; 02:6ba4 $c8
    push HL                                            ;; 02:6ba5 $e5
    push DE                                            ;; 02:6ba6 $d5
    push BC                                            ;; 02:6ba7 $c5
    ld   HL, wOAMBuffer                                ;; 02:6ba8 $21 $00 $c0
    jr   showMenuFingerPointing                        ;; 02:6bab $18 $1d

showMenuFingerCurled:
    ld   A, [wDialogType]                              ;; 02:6bad $fa $4a $d8
    cp   A, WINDOW_STATUS_SCREEN_TOP                   ;; 02:6bb0 $fe $15
    ret  Z                                             ;; 02:6bb2 $c8
    push HL                                            ;; 02:6bb3 $e5
    push DE                                            ;; 02:6bb4 $d5
    push BC                                            ;; 02:6bb5 $c5
    ld   HL, wOAMBuffer._08                            ;; 02:6bb6 $21 $08 $c0
    ld   BC, menuFingerCurledTiles                     ;; 02:6bb9 $01 $b6 $47
    jr   showMenuFinger                                ;; 02:6bbc $18 $0f

showMenuFingerPointing_1:
    ld   A, [wDialogType]                              ;; 02:6bbe $fa $4a $d8
    cp   A, WINDOW_STATUS_SCREEN_TOP                   ;; 02:6bc1 $fe $15
    ret  Z                                             ;; 02:6bc3 $c8
    push HL                                            ;; 02:6bc4 $e5
    push DE                                            ;; 02:6bc5 $d5
    push BC                                            ;; 02:6bc6 $c5
    ld   HL, wOAMBuffer._08                            ;; 02:6bc7 $21 $08 $c0

showMenuFingerPointing:
    ld   BC, menuFingerPointingTiles                   ;; 02:6bca $01 $b4 $47

showMenuFinger:
    call windowShowSprite                              ;; 02:6bcd $cd $d8 $6b
    inc  E                                             ;; 02:6bd0 $1c
    call windowShowSprite                              ;; 02:6bd1 $cd $d8 $6b
    pop  BC                                            ;; 02:6bd4 $c1
    pop  DE                                            ;; 02:6bd5 $d1
    pop  HL                                            ;; 02:6bd6 $e1
    ret                                                ;; 02:6bd7 $c9

; bc = pointer to tile number
; de = y and x positions in tiles relative to the window's top left corner
; hl = address of sprite in wOAMBuffer
; This is the only place I know of that does not use the normal metasprite abstraction
windowShowSprite:
    push DE                                            ;; 02:6bd8 $d5
IF DEF(COLOR)
; Loads the palette for menu sprites, including the pointer hands and the trashcan.
; Also calls windowGetOffsetXYPosition before returning.
    call loadMenuSpritePalette
ELSE
    call windowGetOffsetXYPosition                     ;; 02:6bd9 $cd $5d $6c
ENDC
    ld   [HL], D                                       ;; 02:6bdc $72
    inc  HL                                            ;; 02:6bdd $23
    ld   [HL], E                                       ;; 02:6bde $73
    inc  HL                                            ;; 02:6bdf $23
    ld   A, [BC]                                       ;; 02:6be0 $0a
    inc  BC                                            ;; 02:6be1 $03
    ld   [HL+], A                                      ;; 02:6be2 $22
    ld   A, PAL_ATTACK                                 ;; 02:6be3 $3e $00
    ld   [HL+], A                                      ;; 02:6be5 $22
    pop  DE                                            ;; 02:6be6 $d1
    ret                                                ;; 02:6be7 $c9

call_02_6be8:
    ld   A, [wWindowFingerBlinkTimerNumber]            ;; 02:6be8 $fa $44 $d8
    call timerStart                                    ;; 02:6beb $cd $d4 $2f
    ld   A, D                                          ;; 02:6bee $7a
    ld   [wD899], A                                    ;; 02:6bef $ea $99 $d8
    ld   A, E                                          ;; 02:6bf2 $7b
    ld   [wD898], A                                    ;; 02:6bf3 $ea $98 $d8
    push HL                                            ;; 02:6bf6 $e5
    push DE                                            ;; 02:6bf7 $d5
    push BC                                            ;; 02:6bf8 $c5
    ld   B, $08                                        ;; 02:6bf9 $06 $08
    ld   DE, wOAMBuffer._08                            ;; 02:6bfb $11 $08 $c0
    ld   HL, wOAMBuffer                                ;; 02:6bfe $21 $00 $c0
.loop:
    ld   A, [DE]                                       ;; 02:6c01 $1a
    ld   [HL+], A                                      ;; 02:6c02 $22
    inc  DE                                            ;; 02:6c03 $13
    dec  B                                             ;; 02:6c04 $05
    jr   NZ, .loop                                     ;; 02:6c05 $20 $fa
    pop  BC                                            ;; 02:6c07 $c1
    pop  DE                                            ;; 02:6c08 $d1
    pop  HL                                            ;; 02:6c09 $e1
    ret                                                ;; 02:6c0a $c9

; Shows the trash can if the window has one (the ITEMS and EQUIP screens).
showTrashcan:
    ld   A, [wMenuFlags]                               ;; 02:6c0b $fa $49 $d8
    and  A, $02                                        ;; 02:6c0e $e6 $02
    ret  Z                                             ;; 02:6c10 $c8
    push HL                                            ;; 02:6c11 $e5
    push DE                                            ;; 02:6c12 $d5
    push BC                                            ;; 02:6c13 $c5
    call menuTrashCanLoadTiles                         ;; 02:6c14 $cd $76 $47
    ld   DE, $f10                                      ;; 02:6c17 $11 $10 $0f
    ld   A, [wDialogType]                              ;; 02:6c1a $fa $4a $d8
    cp   A, WINDOW_EQUIP_BOTTOM                        ;; 02:6c1d $fe $04
    jr   NZ, .jr_02_6c23                               ;; 02:6c1f $20 $02
    ld   D, $07                                        ;; 02:6c21 $16 $07
.jr_02_6c23:
    push DE                                            ;; 02:6c23 $d5
    ld   E, $02                                        ;; 02:6c24 $1e $02
    call windowClearLine                               ;; 02:6c26 $cd $4b $6c
    pop  DE                                            ;; 02:6c29 $d1
    push DE                                            ;; 02:6c2a $d5
    inc  D                                             ;; 02:6c2b $14
    ld   E, $02                                        ;; 02:6c2c $1e $02
    call windowClearLine                               ;; 02:6c2e $cd $4b $6c
    pop  DE                                            ;; 02:6c31 $d1
    ld   HL, wOAMBuffer._10                            ;; 02:6c32 $21 $10 $c0
    ld   BC, menuTrashCanTiles                         ;; 02:6c35 $01 $b2 $47
    call windowShowSprite                              ;; 02:6c38 $cd $d8 $6b
    inc  E                                             ;; 02:6c3b $1c
    call windowShowSprite                              ;; 02:6c3c $cd $d8 $6b
    ld   A, [wMenuFlags]                               ;; 02:6c3f $fa $49 $d8
    or   A, $80                                        ;; 02:6c42 $f6 $80
    ld   [wMenuFlags], A                               ;; 02:6c44 $ea $49 $d8
    pop  BC                                            ;; 02:6c47 $c1
    pop  DE                                            ;; 02:6c48 $d1
    pop  HL                                            ;; 02:6c49 $e1
    ret                                                ;; 02:6c4a $c9

; de = y and x left coordinate in tiles
windowClearLine:
    ld   A, [wDialogW]                                 ;; 02:6c4b $fa $a9 $d4
    ld   B, A                                          ;; 02:6c4e $47
    dec  B                                             ;; 02:6c4f $05
    dec  B                                             ;; 02:6c50 $05
.loop:
    ld   A, $7f                                        ;; 02:6c51 $3e $7f
    push BC                                            ;; 02:6c53 $c5
    call storeTileAatDialogPositionDE                  ;; 02:6c54 $cd $44 $38
    pop  BC                                            ;; 02:6c57 $c1
    inc  E                                             ;; 02:6c58 $1c
    dec  B                                             ;; 02:6c59 $05
    jr   NZ, .loop                                     ;; 02:6c5a $20 $f5
    ret                                                ;; 02:6c5c $c9

; de = y and x offsets in tiles from a window's upper left corner
; Return: de = y and x locations in pixels
windowGetOffsetXYPosition:
    push HL                                            ;; 02:6c5d $e5
    ld   HL, wDialogY                                  ;; 02:6c5e $21 $a8 $d4
    ld   A, [wWindowSecondaryFlags]                    ;; 02:6c61 $fa $72 $d8
    bit  7, A                                          ;; 02:6c64 $cb $7f
    jr   Z, .jr_02_6c6b                                ;; 02:6c66 $28 $03
    ld   HL, windowData.selectLevelupStats + $01       ;; 02:6c68 $21 $9b $5c
.jr_02_6c6b:
    ld   A, [HL-]                                      ;; 02:6c6b $3a
    add  A, D                                          ;; 02:6c6c $82
    add  A, A                                          ;; 02:6c6d $87
    add  A, A                                          ;; 02:6c6e $87
    add  A, A                                          ;; 02:6c6f $87
    add  A, $10                                        ;; 02:6c70 $c6 $10
    ld   D, A                                          ;; 02:6c72 $57
    ld   A, [HL]                                       ;; 02:6c73 $7e
    add  A, E                                          ;; 02:6c74 $83
    add  A, A                                          ;; 02:6c75 $87
    add  A, A                                          ;; 02:6c76 $87
    add  A, A                                          ;; 02:6c77 $87
    add  A, $08                                        ;; 02:6c78 $c6 $08
    ld   E, A                                          ;; 02:6c7a $5f
    pop  HL                                            ;; 02:6c7b $e1
    ret                                                ;; 02:6c7c $c9

; HL = HL[A*2]
indexPointerTable:
    push BC                                            ;; 02:6c7d $c5
    ld   B, $00                                        ;; 02:6c7e $06 $00
    ld   C, A                                          ;; 02:6c80 $4f
    add  HL, BC                                        ;; 02:6c81 $09
    add  HL, BC                                        ;; 02:6c82 $09
    ld   A, [HL+]                                      ;; 02:6c83 $2a
    ld   H, [HL]                                       ;; 02:6c84 $66
    ld   L, A                                          ;; 02:6c85 $6f
    pop  BC                                            ;; 02:6c86 $c1
    ret                                                ;; 02:6c87 $c9

getWindowData:
    push DE                                            ;; 02:6c88 $d5
    ld   H, $00                                        ;; 02:6c89 $26 $00
    ld   L, A                                          ;; 02:6c8b $6f
    add  HL, HL                                        ;; 02:6c8c $29
    push HL                                            ;; 02:6c8d $e5
    add  HL, HL                                        ;; 02:6c8e $29
    add  HL, HL                                        ;; 02:6c8f $29
    pop  DE                                            ;; 02:6c90 $d1
    add  HL, DE                                        ;; 02:6c91 $19
    ld   DE, windowData                                ;; 02:6c92 $11 $aa $5b
    add  HL, DE                                        ;; 02:6c95 $19
    pop  DE                                            ;; 02:6c96 $d1
    ret                                                ;; 02:6c97 $c9

; Only does the set if the previous function finished (bit 7 is clear).
; If the new function is 0 it also does some some processing to resume the game.
; B = new function number
; Return: NZ unless the new function is 0, and also (as far as I can tell) if the Slep spell is not currently active it returns Z.
; The Slep related behavior is almost certainly a bug, unless the game is very careful to only test the return when Slep can't be active.
; Callers also often check wMenuStateCurrentFunction afterwards.
setMenuStateCurrentFunction:
    push AF                                            ;; 02:6c98 $f5
    ld   A, [wMenuStateCurrentFunction]                ;; 02:6c99 $fa $53 $d8
    and  A, $80                                        ;; 02:6c9c $e6 $80
    jr   NZ, .jr_02_6cb9                               ;; 02:6c9e $20 $19
    ld   A, B                                          ;; 02:6ca0 $78
    ld   [wMenuStateCurrentFunction], A                ;; 02:6ca1 $ea $53 $d8
    and  A, A                                          ;; 02:6ca4 $a7
    jr   NZ, .jr_02_6cb9                               ;; 02:6ca5 $20 $12
    call menuSelectButtonBItemOrSpell                  ;; 02:6ca7 $cd $bb $6c
    call getEquippedWeaponElements                     ;; 02:6caa $cd $56 $71
    call getEquippedItemElements                       ;; 02:6cad $cd $65 $71
    call unpauseTimers                                 ;; 02:6cb0 $cd $00 $7a
    ld   A, [wWindowMainGameStateBackup]               ;; 02:6cb3 $fa $62 $d8
    ld   [wMainGameState], A                           ;; 02:6cb6 $ea $a0 $c0
.jr_02_6cb9:
    pop  AF                                            ;; 02:6cb9 $f1
    ret                                                ;; 02:6cba $c9

; When you select something in the ITEM or MAGIC window this equips it.
menuSelectButtonBItemOrSpell:
    ld   A, [wEquippedWeapon]                          ;; 02:6cbb $fa $e9 $d6
    dec  A                                             ;; 02:6cbe $3d
    call getEquippedWeaponAnimationType_trampoline     ;; 02:6cbf $cd $d9 $2e
    ld   A, [wDialogType]                              ;; 02:6cc2 $fa $4a $d8
    cp   A, WINDOW_START_MENU                          ;; 02:6cc5 $fe $00
    ret  Z                                             ;; 02:6cc7 $c8
    cp   A, WINDOW_EQUIP_TOP                           ;; 02:6cc8 $fe $03
    ret  NC                                            ;; 02:6cca $d0
; Only continue for ITEMS (1), MAGIC (2), or EQUIP (3).
    ld   B, INV_MAGIC_CURE - 1                         ;; 02:6ccb $06 $00
    cp   A, WINDOW_ITEMS                               ;; 02:6ccd $fe $01
    jr   NZ, .jr_02_6cd3                               ;; 02:6ccf $20 $02
    ld   B, INV_ITEM_POTION_CURE - 1                   ;; 02:6cd1 $06 $08
.jr_02_6cd3:
    ld   A, [wSelectedMenuIndex2]                      ;; 02:6cd3 $fa $4c $d8
    inc  A                                             ;; 02:6cd6 $3c
    ret  Z                                             ;; 02:6cd7 $c8
    dec  A                                             ;; 02:6cd8 $3d
    add  A, B                                          ;; 02:6cd9 $80
    ld   [wEquippedItem], A                            ;; 02:6cda $ea $ef $d6
    dec  A                                             ;; 02:6cdd $3d
    and  A, $7f                                        ;; 02:6cde $e6 $7f
    call getEquippedItemAnimationType_trampoline       ;; 02:6ce0 $cd $df $2e
    ret                                                ;; 02:6ce3 $c9

call_02_6ce4:
    ld   B, $21                                        ;; 02:6ce4 $06 $21
    ld   C, $20                                        ;; 02:6ce6 $0e $20
    push HL                                            ;; 02:6ce8 $e5
    pop  DE                                            ;; 02:6ce9 $d1
.loop_1:
    ld   A, [HL+]                                      ;; 02:6cea $2a
    dec  B                                             ;; 02:6ceb $05
    jr   Z, .loop_2                                    ;; 02:6cec $28 $08
    and  A, A                                          ;; 02:6cee $a7
    jr   Z, .loop_1                                    ;; 02:6cef $28 $f9
    ld   [DE], A                                       ;; 02:6cf1 $12
    inc  DE                                            ;; 02:6cf2 $13
    dec  C                                             ;; 02:6cf3 $0d
    jr   .loop_1                                       ;; 02:6cf4 $18 $f4
.loop_2:
    xor  A, A                                          ;; 02:6cf6 $af
    ld   [DE], A                                       ;; 02:6cf7 $12
    inc  DE                                            ;; 02:6cf8 $13
    dec  C                                             ;; 02:6cf9 $0d
    jr   NZ, .loop_2                                   ;; 02:6cfa $20 $fa
    ret                                                ;; 02:6cfc $c9
    db   $f5, $21, $a7, $d4, $11, $a6, $d5, $06        ;; 02:6cfd ????????
    db   $6c, $cd, $49, $2b, $f1, $c9                  ;; 02:6d05 ??????

copyStatsToLevelUpTmp:
    ld   HL, wStatStamina                              ;; 02:6d0b $21 $c1 $d7
    ld   DE, wStatStaminaLevelUpTmp                    ;; 02:6d0e $11 $8f $d7
    ld   B, $04                                        ;; 02:6d11 $06 $04
.loop:
    ld   A, [HL+]                                      ;; 02:6d13 $2a
    ld   [DE], A                                       ;; 02:6d14 $12
    inc  DE                                            ;; 02:6d15 $13
    dec  B                                             ;; 02:6d16 $05
    jr   NZ, .loop                                     ;; 02:6d17 $20 $fa
    ld   A, [wStatPower]                               ;; 02:6d19 $fa $c2 $d7
    ld   [wStatPowerLevelUpTmp], A                     ;; 02:6d1c $ea $90 $d7
    ld   A, [wStatStamina]                             ;; 02:6d1f $fa $c1 $d7
    ld   [wStatStaminaLevelUpTmp], A                   ;; 02:6d22 $ea $8f $d7
    ret                                                ;; 02:6d25 $c9

ds 14 ; Free space

SECTION "bank02_align_6d34", ROMX[$6d34], BANK[$02]

; save all registers to a backup state (dialog related?)
saveRegisterState1:
    push AF                                            ;; 02:6d34 $f5
    push BC                                            ;; 02:6d35 $c5
    push AF                                            ;; 02:6d36 $f5
    ld   A, H                                          ;; 02:6d37 $7c
    ld   [wRegisterSave1.H], A                         ;; 02:6d38 $ea $a3 $d8
    ld   A, L                                          ;; 02:6d3b $7d
    ld   [wRegisterSave1], A                           ;; 02:6d3c $ea $a2 $d8
    ld   A, D                                          ;; 02:6d3f $7a
    ld   [wRegisterSave1.D], A                         ;; 02:6d40 $ea $a5 $d8
    ld   A, E                                          ;; 02:6d43 $7b
    ld   [wRegisterSave1.E], A                         ;; 02:6d44 $ea $a4 $d8
    ld   A, B                                          ;; 02:6d47 $78
    ld   [wRegisterSave1.B], A                         ;; 02:6d48 $ea $a7 $d8
    ld   A, C                                          ;; 02:6d4b $79
    ld   [wRegisterSave1.C], A                         ;; 02:6d4c $ea $a6 $d8
    pop  BC                                            ;; 02:6d4f $c1
    ld   A, B                                          ;; 02:6d50 $78
    ld   [wRegisterSave1.A], A                         ;; 02:6d51 $ea $a9 $d8
    ld   A, C                                          ;; 02:6d54 $79
    ld   [wRegisterSave1.F], A                         ;; 02:6d55 $ea $a8 $d8
    pop  BC                                            ;; 02:6d58 $c1
    pop  AF                                            ;; 02:6d59 $f1
    ret                                                ;; 02:6d5a $c9

; Load all registers from a backup state (dialog related?)
loadRegisterState1:
    ld   A, [wRegisterSave1.H]                         ;; 02:6d5b $fa $a3 $d8
    ld   H, A                                          ;; 02:6d5e $67
    ld   A, [wRegisterSave1]                           ;; 02:6d5f $fa $a2 $d8
    ld   L, A                                          ;; 02:6d62 $6f
    ld   A, [wRegisterSave1.D]                         ;; 02:6d63 $fa $a5 $d8
    ld   D, A                                          ;; 02:6d66 $57
    ld   A, [wRegisterSave1.E]                         ;; 02:6d67 $fa $a4 $d8
    ld   E, A                                          ;; 02:6d6a $5f
    ld   A, [wRegisterSave1.B]                         ;; 02:6d6b $fa $a7 $d8
    ld   B, A                                          ;; 02:6d6e $47
    ld   A, [wRegisterSave1.C]                         ;; 02:6d6f $fa $a6 $d8
    ld   C, A                                          ;; 02:6d72 $4f
    push BC                                            ;; 02:6d73 $c5
    ld   A, [wRegisterSave1.A]                         ;; 02:6d74 $fa $a9 $d8
    ld   B, A                                          ;; 02:6d77 $47
    ld   A, [wRegisterSave1.F]                         ;; 02:6d78 $fa $a8 $d8
    ld   C, A                                          ;; 02:6d7b $4f
    push BC                                            ;; 02:6d7c $c5
    pop  AF                                            ;; 02:6d7d $f1
    pop  BC                                            ;; 02:6d7e $c1
    ret                                                ;; 02:6d7f $c9

; save all registers to a backup state (dialog related?)
saveRegisterState2:
    push AF                                            ;; 02:6d80 $f5
    push BC                                            ;; 02:6d81 $c5
    push AF                                            ;; 02:6d82 $f5
    ld   A, H                                          ;; 02:6d83 $7c
    ld   [wRegisterSave2.H], A                         ;; 02:6d84 $ea $ab $d8
    ld   A, L                                          ;; 02:6d87 $7d
    ld   [wRegisterSave2], A                           ;; 02:6d88 $ea $aa $d8
    ld   A, D                                          ;; 02:6d8b $7a
    ld   [wRegisterSave2.D], A                         ;; 02:6d8c $ea $ad $d8
    ld   A, E                                          ;; 02:6d8f $7b
    ld   [wRegisterSave2.E], A                         ;; 02:6d90 $ea $ac $d8
    ld   A, B                                          ;; 02:6d93 $78
    ld   [wRegisterSave2.B], A                         ;; 02:6d94 $ea $af $d8
    ld   A, C                                          ;; 02:6d97 $79
    ld   [wRegisterSave2.C], A                         ;; 02:6d98 $ea $ae $d8
    pop  BC                                            ;; 02:6d9b $c1
    ld   A, B                                          ;; 02:6d9c $78
    ld   [wRegisterSave2.A], A                         ;; 02:6d9d $ea $b1 $d8
    ld   A, C                                          ;; 02:6da0 $79
    ld   [wRegisterSave2.F], A                         ;; 02:6da1 $ea $b0 $d8
    pop  BC                                            ;; 02:6da4 $c1
    pop  AF                                            ;; 02:6da5 $f1
    ret                                                ;; 02:6da6 $c9

; Load all registers from a backup state (dialog related?)
loadRegisterState2:
    ld   A, [wRegisterSave2.H]                         ;; 02:6da7 $fa $ab $d8
    ld   H, A                                          ;; 02:6daa $67
    ld   A, [wRegisterSave2]                           ;; 02:6dab $fa $aa $d8
    ld   L, A                                          ;; 02:6dae $6f
    ld   A, [wRegisterSave2.D]                         ;; 02:6daf $fa $ad $d8
    ld   D, A                                          ;; 02:6db2 $57
    ld   A, [wRegisterSave2.E]                         ;; 02:6db3 $fa $ac $d8
    ld   E, A                                          ;; 02:6db6 $5f
    ld   A, [wRegisterSave2.B]                         ;; 02:6db7 $fa $af $d8
    ld   B, A                                          ;; 02:6dba $47
    ld   A, [wRegisterSave2.C]                         ;; 02:6dbb $fa $ae $d8
    ld   C, A                                          ;; 02:6dbe $4f
    push BC                                            ;; 02:6dbf $c5
    ld   A, [wRegisterSave2.A]                         ;; 02:6dc0 $fa $b1 $d8
    ld   B, A                                          ;; 02:6dc3 $47
    ld   A, [wRegisterSave2.F]                         ;; 02:6dc4 $fa $b0 $d8
    ld   C, A                                          ;; 02:6dc7 $4f
    push BC                                            ;; 02:6dc8 $c5
    pop  AF                                            ;; 02:6dc9 $f1
    pop  BC                                            ;; 02:6dca $c1
    ret                                                ;; 02:6dcb $c9

getEquippedWeaponBonusTypes:
    push HL                                            ;; 02:6dcc $e5
    ld   A, [wEquippedWeapon]                          ;; 02:6dcd $fa $e9 $d6
    jr   getEquipmentAOffset0c                         ;; 02:6dd0 $18 $19

getEquippedArmorElementalResistances:
    push HL                                            ;; 02:6dd2 $e5
    ld   A, [wEquippedArmor]                           ;; 02:6dd3 $fa $ec $d6
    jr   getEquipmentAOffset0c                         ;; 02:6dd6 $18 $13

; Probably intended to fetch for helmets. Now changed to actually check helmets.
getEquippedHelmElementalResistances:
    push HL                                            ;; 02:6dd8 $e5
    ld   A, [wEquippedHelm]
    jr   getEquipmentAOffset0c                         ;; 02:6ddc $18 $0d

getEquippedShieldBlockElements:
    push HL                                            ;; 02:6dde $e5
    ld   A, [wEquippedShield]                          ;; 02:6ddf $fa $ee $d6
    ld   HL, equipmentDataTable + $0a                  ;; 02:6de2 $21 $f4 $61
    call indexIntoTable                                ;; 02:6de5 $cd $82 $76
    ld   A, [HL]                                       ;; 02:6de8 $7e
    pop  HL                                            ;; 02:6de9 $e1
    ret                                                ;; 02:6dea $c9

getEquipmentAOffset0c:
    ld   HL, equipmentDataTable + $0b                  ;; 02:6deb $21 $f5 $61
    call indexIntoTable                                ;; 02:6dee $cd $82 $76
    ld   A, [HL]                                       ;; 02:6df1 $7e
    pop  HL                                            ;; 02:6df2 $e1
    ret                                                ;; 02:6df3 $c9

getSpellOrBookPower:
    ld   A, [wEquippedItem]                            ;; 02:6df4 $fa $ef $d6
    cp   A, $09                                        ;; 02:6df7 $fe $09
    jr   C, .jr_02_6e10                                ;; 02:6df9 $38 $15
    push HL                                            ;; 02:6dfb $e5
    push BC                                            ;; 02:6dfc $c5
    ld   HL, .itemsListSpellBooksDamage                ;; 02:6dfd $21 $1e $6e
    ld   A, [wCurrentItemOrSpellInUse]                 ;; 02:6e00 $fa $8b $d8
    and  A, $7f                                        ;; 02:6e03 $e6 $7f
    ld   B, A                                          ;; 02:6e05 $47
.jr_02_6e06:
    ld   A, [HL+]                                      ;; 02:6e06 $2a
    and  A, A                                          ;; 02:6e07 $a7
    jr   Z, .jr_02_6e1a                                ;; 02:6e08 $28 $10
    cp   A, B                                          ;; 02:6e0a $b8
    jr   NZ, .jr_02_6e06                               ;; 02:6e0b $20 $f9
    ld   A, B                                          ;; 02:6e0d $78
    pop  BC                                            ;; 02:6e0e $c1
    pop  HL                                            ;; 02:6e0f $e1
.jr_02_6e10:
    push HL                                            ;; 02:6e10 $e5
    ld   HL, spellDataTable + $0c                      ;; 02:6e11 $21 $e6 $5d
    call indexIntoTable                                ;; 02:6e14 $cd $82 $76
    ld   A, [HL]                                       ;; 02:6e17 $7e
    pop  HL                                            ;; 02:6e18 $e1
    ret                                                ;; 02:6e19 $c9
.jr_02_6e1a:
    pop  BC                                            ;; 02:6e1a $c1
    pop  HL                                            ;; 02:6e1b $e1
    xor  A, A                                          ;; 02:6e1c $af
    ret                                                ;; 02:6e1d $c9
.itemsListSpellBooksDamage:
    db   $17, $18, $19, $1a, $1b, $1c, $00             ;; 02:6e1e ???????

initStartingStatsAndTimers:
    ld   B, $2e                                        ;; 02:6e25 $06 $2e
    xor  A, A                                          ;; 02:6e27 $af
    ld   HL, wItemInventoryAmount                      ;; 02:6e28 $21 $9b $d6
.loop_1:
    ld   [HL+], A                                      ;; 02:6e2b $22
    dec  B                                             ;; 02:6e2c $05
    jr   NZ, .loop_1                                   ;; 02:6e2d $20 $fc
    ld   B, $2e                                        ;; 02:6e2f $06 $2e
    ld   HL, wItemInventory                            ;; 02:6e31 $21 $c5 $d6
.loop_2:
    ld   [HL+], A                                      ;; 02:6e34 $22
    dec  B                                             ;; 02:6e35 $05
    jr   NZ, .loop_2                                   ;; 02:6e36 $20 $fc
    ld   DE, wEquippedWeapon                           ;; 02:6e38 $11 $e9 $d6
    ld   HL, startingEquipment                         ;; 02:6e3b $21 $10 $6f
    ld   B, $06                                        ;; 02:6e3e $06 $06
.loop_3:
    ld   A, [HL+]                                      ;; 02:6e40 $2a
    ld   [DE], A                                       ;; 02:6e41 $12
    inc  DE                                            ;; 02:6e42 $13
    dec  B                                             ;; 02:6e43 $05
    jr   NZ, .loop_3                                   ;; 02:6e44 $20 $fa
    ld   B, $06                                        ;; 02:6e46 $06 $06
    ld   HL, wEquippedWeapon                           ;; 02:6e48 $21 $e9 $d6
    ld   DE, wEquippedWeaponPower                      ;; 02:6e4b $11 $bf $d6
.loop_4:
    ld   A, [HL+]                                      ;; 02:6e4e $2a
    and  A, $7f                                        ;; 02:6e4f $e6 $7f
    push HL                                            ;; 02:6e51 $e5
    ld   HL, equipmentDataTable + $0c                  ;; 02:6e52 $21 $f6 $61
    call indexIntoTable                                ;; 02:6e55 $cd $82 $76
    ld   A, [HL]                                       ;; 02:6e58 $7e
    pop  HL                                            ;; 02:6e59 $e1
    ld   [DE], A                                       ;; 02:6e5a $12
    inc  DE                                            ;; 02:6e5b $13
    dec  B                                             ;; 02:6e5c $05
    jr   NZ, .loop_4                                   ;; 02:6e5d $20 $ef
    ld   A, $80                                        ;; 02:6e5f $3e $80
    ld   [wEquippedItem], A                            ;; 02:6e61 $ea $ef $d6
    xor  A, A                                          ;; 02:6e64 $af
    ld   [wEquippedItemAmount], A                      ;; 02:6e65 $ea $f0 $d6
    ld   B, $04                                        ;; 02:6e68 $06 $04
    ld   A, $02                                        ;; 02:6e6a $3e $02
    ld   HL, wStatStamina                              ;; 02:6e6c $21 $c1 $d7
.loop_5:
    ld   [HL+], A                                      ;; 02:6e6f $22
    dec  B                                             ;; 02:6e70 $05
    jr   NZ, .loop_5                                   ;; 02:6e71 $20 $fc
    ld   DE, $13                                       ;; 02:6e73 $11 $13 $00
    ld   HL, wHPLow                                    ;; 02:6e76 $21 $b2 $d7
    ld   [HL], E                                       ;; 02:6e79 $73
    inc  HL                                            ;; 02:6e7a $23
    ld   [HL], D                                       ;; 02:6e7b $72
    inc  HL                                            ;; 02:6e7c $23
    ld   [HL], E                                       ;; 02:6e7d $73
    inc  HL                                            ;; 02:6e7e $23
    ld   [HL], D                                       ;; 02:6e7f $72
    ld   DE, $06                                       ;; 02:6e80 $11 $06 $00
    ld   HL, wManaLow                                  ;; 02:6e83 $21 $b6 $d7
    ld   [HL], E                                       ;; 02:6e86 $73
    inc  HL                                            ;; 02:6e87 $23
    ld   [HL], D                                       ;; 02:6e88 $72
    inc  HL                                            ;; 02:6e89 $23
    ld   [HL], E                                       ;; 02:6e8a $73
    inc  HL                                            ;; 02:6e8b $23
    ld   [HL], D                                       ;; 02:6e8c $72
    ld   HL, wStatusScreenAPDP                         ;; 02:6e8d $21 $dd $d7
    ld   A, $81                                        ;; 02:6e90 $3e $81
    ld   [HL+], A                                      ;; 02:6e92 $22
    inc  A                                             ;; 02:6e93 $3c
    ld   [HL+], A                                      ;; 02:6e94 $22
    ld   A, [wStatPower]                               ;; 02:6e95 $fa $c2 $d7
    ld   [wStatPowerLevelUpTmp], A                     ;; 02:6e98 $ea $90 $d7
    ld   A, [wStatStamina]                             ;; 02:6e9b $fa $c1 $d7
    ld   [wStatStaminaLevelUpTmp], A                   ;; 02:6e9e $ea $8f $d7
    call calulateAPDP                                  ;; 02:6ea1 $cd $d6 $57
    ld   HL, $00                                       ;; 02:6ea4 $21 $00 $00
    ld   A, H                                          ;; 02:6ea7 $7c
    ld   [wXPHigh], A                                  ;; 02:6ea8 $ea $bc $d7
    ld   A, L                                          ;; 02:6eab $7d
    ld   [wXPLow], A                                   ;; 02:6eac $ea $bb $d7
    xor  A, A                                          ;; 02:6eaf $af
    ld   [wXPHighExt], A                               ;; 02:6eb0 $ea $bd $d7
    inc  A                                             ;; 02:6eb3 $3c
    ld   [wLevel], A                                   ;; 02:6eb4 $ea $ba $d7
    call setNextXPLevel                                ;; 02:6eb7 $cd $a3 $3e
    ld   HL, wScriptStack.top                          ;; 02:6eba $21 $83 $d6
    ld   A, H                                          ;; 02:6ebd $7c
    ld   [wScriptStackPointer.high], A                 ;; 02:6ebe $ea $bd $d8
    ld   A, L                                          ;; 02:6ec1 $7d
    ld   [wScriptStackPointer], A                      ;; 02:6ec2 $ea $bc $d8
    ld   A, $01                                        ;; 02:6ec5 $3e $01
    ld   [wWillCharge], A                              ;; 02:6ec7 $ea $58 $d8
; Start the player with zero money.
    ld   HL, $0000
    ld   A, H                                          ;; 02:6ecd $7c
    ld   [wMoneyHigh], A                               ;; 02:6ece $ea $bf $d7
    ld   A, L                                          ;; 02:6ed1 $7d
    ld   [wMoneyLow], A                                ;; 02:6ed2 $ea $be $d7
    ld   A, $ff                                        ;; 02:6ed5 $3e $ff
    ld   [wNectarStaminaTimerNumber], A                ;; 02:6ed7 $ea $7e $d8
    xor  A, A                                          ;; 02:6eda $af
    ld   [wStatusEffect], A                            ;; 02:6edb $ea $c0 $d7
    call initTimers                                    ;; 02:6ede $cd $e2 $6e
    ret                                                ;; 02:6ee1 $c9

initTimers:
    ld   HL, $1e0                                      ;; 02:6ee2 $21 $e0 $01
    ld   DE, wPoisStatusEffectTimerNumber              ;; 02:6ee5 $11 $79 $d8
    ld   B, $05                                        ;; 02:6ee8 $06 $05
.loop:
    call timerNew                                      ;; 02:6eea $cd $9e $2f
    ld   [DE], A                                       ;; 02:6eed $12
    inc  DE                                            ;; 02:6eee $13
    dec  B                                             ;; 02:6eef $05
    jr   NZ, .loop                                     ;; 02:6ef0 $20 $f8
    ld   HL, $10                                       ;; 02:6ef2 $21 $10 $00
    call timerNew                                      ;; 02:6ef5 $cd $9e $2f
    ld   [wWindowFingerBlinkTimerNumber], A            ;; 02:6ef8 $ea $44 $d8
    ld   A, $01                                        ;; 02:6efb $3e $01
    ld   [wD860], A                                    ;; 02:6efd $ea $60 $d8
    ld   A, $07                                        ;; 02:6f00 $3e $06
    ld   [wMenuSelectionMoveRepeatDelay], A            ;; 02:6f02 $ea $57 $d8
    xor  A, A                                          ;; 02:6f05 $af
    ld   [wWindowFlags], A                             ;; 02:6f06 $ea $74 $d8
    call getEquippedItemElements                       ;; 02:6f09 $cd $65 $71
    call getEquippedWeaponElements                     ;; 02:6f0c $cd $56 $71
    ret                                                ;; 02:6f0f $c9

startingEquipment:
    db   $01, $27, $af, $11, $b0, $1c                  ;; 02:6f10 ......

drawDefaultStatusBar:
    ld   DE, $00                                       ;; 02:6f16 $11 $00 $00
    ld   B, $14                                        ;; 02:6f19 $06 $14
    ld   HL, statusBarTopRowDefault                    ;; 02:6f1b $21 $97 $6f
.loop:
    ld   A, [HL+]                                      ;; 02:6f1e $2a
    push DE                                            ;; 02:6f1f $d5
    call storeTileAatWindowPositionDE                  ;; 02:6f20 $cd $66 $38
    pop  DE                                            ;; 02:6f23 $d1
    inc  E                                             ;; 02:6f24 $1c
    dec  B                                             ;; 02:6f25 $05
    jr   NZ, .loop                                     ;; 02:6f26 $20 $f6
    ret                                                ;; 02:6f28 $c9

drawHPOnStatusBar_2:
    ld   DE, $06                                       ;; 02:6f29 $11 $06 $00
    push DE                                            ;; 02:6f2c $d5
    ld   B, $04                                        ;; 02:6f2d $06 $04
    call clearStatusBarSection                         ;; 02:6f2f $cd $6b $6f
    pop  DE                                            ;; 02:6f32 $d1
    ld   A, [wHPHigh]                                  ;; 02:6f33 $fa $b3 $d7
    ld   H, A                                          ;; 02:6f36 $67
    ld   A, [wHPLow]                                   ;; 02:6f37 $fa $b2 $d7
    ld   L, A                                          ;; 02:6f3a $6f
    call drawNumberOnStatusBar                         ;; 02:6f3b $cd $77 $6f
    ret                                                ;; 02:6f3e $c9

drawManaOnStatusBar_2:
    ld   DE, $0c                                       ;; 02:6f3f $11 $0c $00
    push DE                                            ;; 02:6f42 $d5
    ld   B, $03                                        ;; 02:6f43 $06 $03
    call clearStatusBarSection                         ;; 02:6f45 $cd $6b $6f
    pop  DE                                            ;; 02:6f48 $d1
    ld   A, [wManaHigh]                                ;; 02:6f49 $fa $b7 $d7
    ld   H, A                                          ;; 02:6f4c $67
    ld   A, [wManaLow]                                 ;; 02:6f4d $fa $b6 $d7
    ld   L, A                                          ;; 02:6f50 $6f
    call drawNumberOnStatusBar                         ;; 02:6f51 $cd $77 $6f
    ret                                                ;; 02:6f54 $c9

drawMoneyOnStatusBar:
    ld   DE, $13                                       ;; 02:6f55 $11 $13 $00
    push DE                                            ;; 02:6f58 $d5
    ld   B, $05                                        ;; 02:6f59 $06 $05
    call clearStatusBarSection                         ;; 02:6f5b $cd $6b $6f
    pop  DE                                            ;; 02:6f5e $d1
    ld   A, [wMoneyHigh]                               ;; 02:6f5f $fa $bf $d7
    ld   H, A                                          ;; 02:6f62 $67
    ld   A, [wMoneyLow]                                ;; 02:6f63 $fa $be $d7
    ld   L, A                                          ;; 02:6f66 $6f
    call drawNumberOnStatusBar                         ;; 02:6f67 $cd $77 $6f
    ret                                                ;; 02:6f6a $c9

clearStatusBarSection:
    ld   A, $7f                                        ;; 02:6f6b $3e $7f
    push DE                                            ;; 02:6f6d $d5
    call storeTileAatWindowPositionDE                  ;; 02:6f6e $cd $66 $38
    pop  DE                                            ;; 02:6f71 $d1
    dec  DE                                            ;; 02:6f72 $1b
    dec  B                                             ;; 02:6f73 $05
    jr   NZ, clearStatusBarSection                     ;; 02:6f74 $20 $f5
    ret                                                ;; 02:6f76 $c9

drawNumberOnStatusBar:
    ld   A, H                                          ;; 02:6f77 $7c
    or   A, L                                          ;; 02:6f78 $b5
    jr   Z, .jr_02_6f91                                ;; 02:6f79 $28 $16
.jr_02_6f7b:
    ld   A, $0a                                        ;; 02:6f7b $3e $0a
    push DE                                            ;; 02:6f7d $d5
    call divMod                                        ;; 02:6f7e $cd $8b $2b
    pop  DE                                            ;; 02:6f81 $d1
    push HL                                            ;; 02:6f82 $e5
    push DE                                            ;; 02:6f83 $d5

    call storeTileAatWindowPositionDE                  ;; 02:6f86 $cd $66 $38
    pop  DE                                            ;; 02:6f89 $d1
    dec  DE                                            ;; 02:6f8a $1b
    pop  HL                                            ;; 02:6f8b $e1
    ld   A, H                                          ;; 02:6f8c $7c
    or   A, L                                          ;; 02:6f8d $b5
    jr   NZ, .jr_02_6f7b                               ;; 02:6f8e $20 $eb
    ret                                                ;; 02:6f90 $c9

; Free space
    db $00, $00, $00

.jr_02_6f91:
    xor a, a
    call storeTileAatWindowPositionDE                  ;; 02:6f93 $cd $66 $38
    ret                                                ;; 02:6f96 $c9

; Graphic tile numbers that are shown on the status bar top row.
statusBarTopRowDefault:
    db   $7f, $f0, $f1, $0a, $0b, $0c, $0d, $f2        ;; 02:6f97 ........
    db   $f3, $f4, $0e, $0f, $7f, $7f, $7f, $7f        ;; 02:6f9f ........
    db   $7f, $7f, $7f, $7f                            ;; 02:6fa7 ....

attackWithWeaponUseWill:
    ld   HL, wMiscFlags                                ;; 02:6fab $21 $6f $d8
    res  6, [HL]                                       ;; 02:6fae $cb $b6
    call useWillCharge                                 ;; 02:6fb0 $cd $d0 $3e
    ret                                                ;; 02:6fb3 $c9

doSpellOrItemEffect:
    ld   HL, wMiscFlags                                ;; 02:6fb4 $21 $6f $d8
    set  6, [HL]                                       ;; 02:6fb7 $cb $f6
    ld   A, [wCurrentItemOrSpellInUse]                 ;; 02:6fb9 $fa $8b $d8
    and  A, $7f                                        ;; 02:6fbc $e6 $7f
    ld   C, A                                          ;; 02:6fbe $4f
    ret  Z                                             ;; 02:6fbf $c8
    push DE                                            ;; 02:6fc0 $d5
    ld   A, [wHPHigh]                                  ;; 02:6fc1 $fa $b3 $d7
    ld   D, A                                          ;; 02:6fc4 $57
    ld   A, [wHPLow]                                   ;; 02:6fc5 $fa $b2 $d7
    ld   E, A                                          ;; 02:6fc8 $5f
    or   A, D                                          ;; 02:6fc9 $b2
    pop  DE                                            ;; 02:6fca $d1
    ret  Z                                             ;; 02:6fcb $c8
    push BC                                            ;; 02:6fcc $c5
    ld   A, C                                          ;; 02:6fcd $79
    cp   A, $09                                        ;; 02:6fce $fe $09
    call C, castSpellIfSufficientMana                  ;; 02:6fd0 $dc $85 $71
    pop  BC                                            ;; 02:6fd3 $c1
    ret  C                                             ;; 02:6fd4 $d8
    ld   HL, itemsListCure                             ;; 02:6fd5 $21 $17 $7b
    call getItemOffsetBandCifInList                    ;; 02:6fd8 $cd $4b $71
    jr   NC, .notCure                                  ;; 02:6fdb $30 $79
    push HL                                            ;; 02:6fdd $e5
    ld   A, C                                          ;; 02:6fde $79
    cp   A, $01                                        ;; 02:6fdf $fe $01
    jr   NZ, .jr_02_7012                               ;; 02:6fe1 $20 $2f
    push BC                                            ;; 02:6fe3 $c5
    push HL                                            ;; 02:6fe4 $e5
    call getRandomByte                                 ;; 02:6fe5 $cd $1e $2b
    pop  HL                                            ;; 02:6fe8 $e1
    ld   L, A                                          ;; 02:6fe9 $6f
    ld   A, H                                          ;; 02:6fea $7c
    ld   H, $00                                        ;; 02:6feb $26 $00
    call divMod                                        ;; 02:6fed $cd $8b $2b
    ld   B, A                                          ;; 02:6ff0 $47
    ld   A, [wWillCharge]                              ;; 02:6ff1 $fa $58 $d8
    add  A, $40                                        ;; 02:6ff4 $c6 $40
    swap A                                             ;; 02:6ff6 $cb $37
    rrca                                               ;; 02:6ff8 $0f
    rrca                                               ;; 02:6ff9 $0f
    and  A, $03                                        ;; 02:6ffa $e6 $03
    ld   L, A                                          ;; 02:6ffc $6f
    ld   H, $00                                        ;; 02:6ffd $26 $00
    ld   A, [wStatWisdom]                              ;; 02:6fff $fa $c3 $d7
    push BC                                            ;; 02:7002 $c5
    call MultiplyHL_by_A                               ;; 02:7003 $cd $7b $2b
    pop  BC                                            ;; 02:7006 $c1
    ld   B, $00                                        ;; 02:7007 $06 $00
    add  HL, BC                                        ;; 02:7009 $09
    push HL                                            ;; 02:700a $e5
    call useWillCharge                                 ;; 02:700b $cd $d0 $3e
    pop  HL                                            ;; 02:700e $e1
    pop  BC                                            ;; 02:700f $c1
    jr   .jr_02_7015                                   ;; 02:7010 $18 $03
.jr_02_7012:
    ld   L, H                                          ;; 02:7012 $6c
    ld   H, $00                                        ;; 02:7013 $26 $00
.jr_02_7015:
    ld   A, [wHPHigh]                                  ;; 02:7015 $fa $b3 $d7
    ld   D, A                                          ;; 02:7018 $57
    ld   A, [wHPLow]                                   ;; 02:7019 $fa $b2 $d7
    ld   E, A                                          ;; 02:701c $5f
    add  HL, DE                                        ;; 02:701d $19
    ld   A, [wMaxHPHigh]                               ;; 02:701e $fa $b5 $d7
    ld   D, A                                          ;; 02:7021 $57
    ld   A, [wMaxHPLow]                                ;; 02:7022 $fa $b4 $d7
    ld   E, A                                          ;; 02:7025 $5f
    ld   A, H                                          ;; 02:7026 $7c
    cp   A, D                                          ;; 02:7027 $ba
    jr   C, .jr_02_7032                                ;; 02:7028 $38 $08
    jr   NZ, .jr_02_7030                               ;; 02:702a $20 $04
    ld   A, L                                          ;; 02:702c $7d
    cp   A, E                                          ;; 02:702d $bb
    jr   C, .jr_02_7032                                ;; 02:702e $38 $02
.jr_02_7030:
    push DE                                            ;; 02:7030 $d5
    pop  HL                                            ;; 02:7031 $e1
.jr_02_7032:
    ld   A, H                                          ;; 02:7032 $7c
    ld   [wHPHigh], A                                  ;; 02:7033 $ea $b3 $d7
    ld   A, L                                          ;; 02:7036 $7d
    ld   [wHPLow], A                                   ;; 02:7037 $ea $b2 $d7
    pop  HL                                            ;; 02:703a $e1
    ld   A, C                                          ;; 02:703b $79
    cp   A, $01                                        ;; 02:703c $fe $01
    jr   Z, .jr_02_704f                                ;; 02:703e $28 $0f
    ld   A, [wManaLow]                                 ;; 02:7040 $fa $b6 $d7
    add  A, L                                          ;; 02:7043 $85
    ld   B, A                                          ;; 02:7044 $47
    ld   A, [wMaxManaLow]                              ;; 02:7045 $fa $b8 $d7
    cp   A, B                                          ;; 02:7048 $b8
    jr   C, .jr_02_704c                                ;; 02:7049 $38 $01
    ld   A, B                                          ;; 02:704b $78
.jr_02_704c:
    ld   [wManaLow], A                                 ;; 02:704c $ea $b6 $d7
.jr_02_704f:
    call drawHPOnStatusBar_trampoline                  ;; 02:704f $cd $29 $6f
    call drawManaOnStatusBar_trampoline                ;; 02:7052 $cd $3f $6f
    ret                                                ;; 02:7055 $c9
.notCure:
    ld   HL, itemsListHealStatus                       ;; 02:7056 $21 $1f $7b
    call getItemOffsetBandCifInList                    ;; 02:7059 $cd $4b $71
    jr   NC, .notHeal                                  ;; 02:705c $30 $26
    ld   A, C                                          ;; 02:705e $79
    cp   A, $02                                        ;; 02:705f $fe $02
    jr   NZ, .jr_02_7065                               ;; 02:7061 $20 $02
    ld   H, $0f                                        ;; 02:7063 $26 $0f
.jr_02_7065:
    push AF                                            ;; 02:7065 $f5
    ld   A, H                                          ;; 02:7066 $7c
    rrca                                               ;; 02:7067 $0f
    push AF                                            ;; 02:7068 $f5
    call C, endPoisStatusEffect                        ;; 02:7069 $dc $90 $79
    pop  AF                                            ;; 02:706c $f1
    rrca                                               ;; 02:706d $0f
    push AF                                            ;; 02:706e $f5
    call C, endDarkStatusEffect                        ;; 02:706f $dc $9c $79
    pop  AF                                            ;; 02:7072 $f1
    rrca                                               ;; 02:7073 $0f
    push AF                                            ;; 02:7074 $f5
    call C, endStonStatusEffect                        ;; 02:7075 $dc $ab $79
    pop  AF                                            ;; 02:7078 $f1
    rrca                                               ;; 02:7079 $0f
    call C, endMoogStatusEffect                        ;; 02:707a $dc $ba $79
    pop  AF                                            ;; 02:707d $f1
    cp   A, $02                                        ;; 02:707e $fe $02
    call NZ, useWillCharge                             ;; 02:7080 $c4 $d0 $3e
    ret                                                ;; 02:7083 $c9
.notHeal:
    ld   HL, itemsListBuff                             ;; 02:7084 $21 $26 $7b
    call getItemOffsetBandCifInList                    ;; 02:7087 $cd $4b $71
    jr   NC, doSpellOrItemEffect_notBuff               ;; 02:708a $30 $57
    ld   A, [wNectarStaminaTimerNumber]                ;; 02:708c $fa $7e $d8
    cp   A, $ff                                        ;; 02:708f $fe $ff
    ret  NZ                                            ;; 02:7091 $c0
    push HL                                            ;; 02:7092 $e5
    ld   HL, wStatStamina                              ;; 02:7093 $21 $c1 $d7
    ld   DE, wStatStaminaBuffBackup                    ;; 02:7096 $11 $d8 $d7
    push HL                                            ;; 02:7099 $e5
    ld   B, $04                                        ;; 02:709a $06 $04
.loop:
    ld   A, [HL+]                                      ;; 02:709c $2a
    ld   [DE], A                                       ;; 02:709d $12
    inc  DE                                            ;; 02:709e $13
    dec  B                                             ;; 02:709f $05
    jr   NZ, .loop                                     ;; 02:70a0 $20 $fa
    pop  DE                                            ;; 02:70a2 $d1
    pop  HL                                            ;; 02:70a3 $e1
    ld   A, H                                          ;; 02:70a4 $7c
    push HL                                            ;; 02:70a5 $e5
    call useNectarOrStamina                            ;; 02:70a6 $cd $c8 $70
    pop  HL                                            ;; 02:70a9 $e1
    ld   A, L                                          ;; 02:70aa $7d
    call useNectarOrStamina                            ;; 02:70ab $cd $c8 $70
    ld   A, [wWillCharge]                              ;; 02:70ae $fa $58 $d8
    ld   L, A                                          ;; 02:70b1 $6f
    ld   H, $00                                        ;; 02:70b2 $26 $00
    add  HL, HL                                        ;; 02:70b4 $29
    push HL                                            ;; 02:70b5 $e5
    add  HL, HL                                        ;; 02:70b6 $29
    add  HL, HL                                        ;; 02:70b7 $29
    pop  BC                                            ;; 02:70b8 $c1
    add  HL, BC                                        ;; 02:70b9 $09
    ld   BC, $258                                      ;; 02:70ba $01 $58 $02
    add  HL, BC                                        ;; 02:70bd $09
    call timerNew                                      ;; 02:70be $cd $9e $2f
    ld   [wNectarStaminaTimerNumber], A                ;; 02:70c1 $ea $7e $d8
    call timerStart                                    ;; 02:70c4 $cd $d4 $2f
    ret                                                ;; 02:70c7 $c9

useNectarOrStamina:
    push AF                                            ;; 02:70c8 $f5
    swap A                                             ;; 02:70c9 $cb $37
    call applyBuff                                     ;; 02:70cd $cd $d7 $70
    pop  AF                                            ;; 02:70d0 $f1
    call applyBuff                                     ;; 02:70d3 $cd $d7 $70
; This fixes the Nectar and Stamina items to take effect on use instead of requiring opening a window.
; There is a second bug that Nectar and Stamina do not wear off until a window is opened which is unfixed.
    jp calulateAPDP

applyBuff:
    and $0f
    ld   B, A                                          ;; 02:70d7 $47
    ld   A, [DE]                                       ;; 02:70d8 $1a
    add  A, B                                          ;; 02:70d9 $80
    cp   A, $63                                        ;; 02:70da $fe $63
    jr   C, .jr_02_70e0                                ;; 02:70dc $38 $02
    ld   A, $63                                        ;; 02:70de $3e $63
.jr_02_70e0:
    ld   [DE], A                                       ;; 02:70e0 $12
    inc  DE                                            ;; 02:70e1 $13
    ret                                                ;; 02:70e2 $c9

doSpellOrItemEffect_notBuff:
    ld   HL, itemsListCrystal                          ;; 02:70e3 $21 $34 $7b
    call getItemOffsetBandCifInList                    ;; 02:70e6 $cd $4b $71
    jr   NC, .notCrystal                               ;; 02:70e9 $30 $05
    ld   A, H                                          ;; 02:70eb $7c
    call setWillBarMax                                 ;; 02:70ec $cd $97 $3e
    ret                                                ;; 02:70ef $c9
.notCrystal:
    ld   HL, itemsListSleep                            ;; 02:70f0 $21 $2b $7b
    call getItemOffsetBandCifInList                    ;; 02:70f3 $cd $4b $71
    jr   NC, .notSleep                                 ;; 02:70f6 $30 $0a
    call getWillTimes16PlusB                           ;; 02:70f8 $cd $39 $71
    call useSlep                                       ;; 02:70fb $cd $44 $2f
    call useWillCharge                                 ;; 02:70fe $cd $d0 $3e
    ret                                                ;; 02:7101 $c9
.notSleep:
    ld   HL, itemsListMute                             ;; 02:7102 $21 $2e $7b
    call getItemOffsetBandCifInList                    ;; 02:7105 $cd $4b $71
    jr   NC, .notMute                                  ;; 02:7108 $30 $0a
    call getWillTimes16PlusB                           ;; 02:710a $cd $39 $71
    call useMute                                       ;; 02:710d $cd $5d $2f
    call useWillCharge                                 ;; 02:7110 $cd $d0 $3e
    ret                                                ;; 02:7113 $c9
.notMute:
    ld   HL, itemsListLights                           ;; 02:7114 $21 $31 $7b
    call getItemOffsetBandCifInList                    ;; 02:7117 $cd $4b $71
    jr   NC, .notLight                                 ;; 02:711a $30 $12
    ld   L, A                                          ;; 02:711c $6f
    ld   H, $00                                        ;; 02:711d $26 $00
    add  HL, HL                                        ;; 02:711f $29
    add  HL, HL                                        ;; 02:7120 $29
    call timerNew                                      ;; 02:7121 $cd $9e $2f
    ld   [wLightStatusEffectTimerNumber], A            ;; 02:7124 $ea $81 $d8
    call timerStart                                    ;; 02:7127 $cd $d4 $2f
    call conditionallyClearDarkGraphicEffect           ;; 02:712a $cd $64 $11
    ret                                                ;; 02:712d $c9
.notLight:
    ld   HL, itemsListDamage                           ;; 02:712e $21 $36 $7b
    call getItemOffsetBandCifInList                    ;; 02:7131 $cd $4b $71
    ret  NC                                            ;; 02:7134 $d0
    call useWillCharge                                 ;; 02:7135 $cd $d0 $3e
    ret                                                ;; 02:7138 $c9

getWillTimes16PlusB:
    ld   B, A                                          ;; 02:7139 $47
    ld   A, [wWillCharge]                              ;; 02:713a $fa $58 $d8
    ld   H, $00                                        ;; 02:713d $26 $00
    ld   L, A                                          ;; 02:713f $6f
    add  HL, HL                                        ;; 02:7140 $29
    push HL                                            ;; 02:7141 $e5
    add  HL, HL                                        ;; 02:7142 $29
    add  HL, HL                                        ;; 02:7143 $29
    pop  DE                                            ;; 02:7144 $d1
    add  HL, HL                                        ;; 02:7145 $29
    ld   D, $00                                        ;; 02:7146 $16 $00
    ld   E, B                                          ;; 02:7148 $58
    add  HL, DE                                        ;; 02:7149 $19
    ret                                                ;; 02:714a $c9

; HL = pointer to a list of item/spell IDs
; C = id of a item/spell
; Return: H and A = offset $b, L = offset $c, and carry flag set (if found)
; Return: carry flag clear (if not found)
getItemOffsetBandCifInList:
    ld   A, [HL+]                                      ;; 02:714b $2a
    or   A, A                                          ;; 02:714c $b7
    ret  Z                                             ;; 02:714d $c8
    cp   A, C                                          ;; 02:714e $b9
    jr   NZ, getItemOffsetBandCifInList                ;; 02:714f $20 $fa
    call getSpellOffset0band0cinHL                     ;; 02:7151 $cd $7b $71
    scf                                                ;; 02:7154 $37
    ret                                                ;; 02:7155 $c9

getEquippedWeaponElements:
    push HL                                            ;; 02:7156 $e5
    ld   A, [wEquippedWeapon]                          ;; 02:7157 $fa $e9 $d6
    ld   HL, equipmentDataTable + $0a                  ;; 02:715a $21 $f4 $61
    call getTableEntryAtIndexA                         ;; 02:715d $cd $74 $71
    ld   [wEquippedWeaponElements], A                  ;; 02:7160 $ea $d7 $d7
    pop  HL                                            ;; 02:7163 $e1
    ret                                                ;; 02:7164 $c9

getEquippedItemElements:
    push HL                                            ;; 02:7165 $e5
    ld   A, [wEquippedItem]                            ;; 02:7166 $fa $ef $d6
    ld   HL, spellDataTable + $0a                      ;; 02:7169 $21 $e4 $5d
    call getTableEntryAtIndexA                         ;; 02:716c $cd $74 $71
    pop  HL                                            ;; 02:716f $e1
    ld   [wEquippedItemElements], A                    ;; 02:7170 $ea $51 $d8
    ret                                                ;; 02:7173 $c9

getTableEntryAtIndexA:
    and  A, $7f                                        ;; 02:7174 $e6 $7f
    call indexIntoTable                                ;; 02:7176 $cd $82 $76
    ld   A, [HL+]                                      ;; 02:7179 $2a
    ret                                                ;; 02:717a $c9

getSpellOffset0band0cinHL:
    ld   HL, spellDataTable + $0a                      ;; 02:717b $21 $e4 $5d
    call indexIntoTable                                ;; 02:717e $cd $82 $76
    ld   A, [HL+]                                      ;; 02:7181 $2a
    ld   L, [HL]                                       ;; 02:7182 $6e
    ld   H, A                                          ;; 02:7183 $67
    ret                                                ;; 02:7184 $c9

castSpellIfSufficientMana:
    push AF                                            ;; 02:7185 $f5
    ld   HL, spellDataTable + $08                      ;; 02:7186 $21 $e2 $5d
    call indexIntoTable                                ;; 02:7189 $cd $82 $76
    ld   A, [HL]                                       ;; 02:718c $7e
    and  A, $1f                                        ;; 02:718d $e6 $1f
    ld   B, A                                          ;; 02:718f $47
    ld   A, [wManaLow]                                 ;; 02:7190 $fa $b6 $d7
    sub  A, B                                          ;; 02:7193 $90
    jr   C, .jr_02_719f                                ;; 02:7194 $38 $09
    ld   [wManaLow], A                                 ;; 02:7196 $ea $b6 $d7
    call drawManaOnStatusBar_trampoline                ;; 02:7199 $cd $3f $6f
    pop  AF                                            ;; 02:719c $f1
    or   A, A                                          ;; 02:719d $b7
    ret                                                ;; 02:719e $c9
.jr_02_719f:
    pop  AF                                            ;; 02:719f $f1
    scf                                                ;; 02:71a0 $37
    ret                                                ;; 02:71a1 $c9

useItemOrSpell:
    ld   A, [wEquippedItem]                            ;; 02:71a2 $fa $ef $d6
    ld   [wCurrentItemOrSpellInUse], A                 ;; 02:71a5 $ea $8b $d8
    and  A, $7f                                        ;; 02:71a8 $e6 $7f
    cp   A, $09                                        ;; 02:71aa $fe $09
    ret  C                                             ;; 02:71ac $d8
    ld   HL, spellDataTable + $09                      ;; 02:71ad $21 $e3 $5d
    call indexIntoTable                                ;; 02:71b0 $cd $82 $76
    ld   A, [HL]                                       ;; 02:71b3 $7e
    and  A, $80                                        ;; 02:71b4 $e6 $80
    ret  Z                                             ;; 02:71b6 $c8
    ld   HL, wEquippedItemAmount                       ;; 02:71b7 $21 $f0 $d6
    ld   A, [HL]                                       ;; 02:71ba $7e
    and  A, A                                          ;; 02:71bb $a7
    jr   Z, .jr_02_71d3                                ;; 02:71bc $28 $15
    dec  [HL]                                          ;; 02:71be $35
    ret  NZ                                            ;; 02:71bf $c0
    ld   A, $80                                        ;; 02:71c0 $3e $80
    ld   [wEquippedItem], A                            ;; 02:71c2 $ea $ef $d6
    ld   [wEquippedItemAndWeaponCopy], A               ;; 02:71c5 $ea $f1 $d6
    ld   HL, wItemInventory                            ;; 02:71c8 $21 $c5 $d6
.jr_02_71cb:
    cp   A, [HL]                                       ;; 02:71cb $be
    inc  HL                                            ;; 02:71cc $23
    jr   NZ, .jr_02_71cb                               ;; 02:71cd $20 $fc
    dec  HL                                            ;; 02:71cf $2b
    xor  A, A                                          ;; 02:71d0 $af
    ld   [HL], A                                       ;; 02:71d1 $77
    ret                                                ;; 02:71d2 $c9
.jr_02_71d3:
    push AF                                            ;; 02:71d3 $f5
    ld   A, $1c                                        ;; 02:71d4 $3e $1c
    call getEquippedItemAnimationType_trampoline       ;; 02:71d6 $cd $df $2e
    pop  AF                                            ;; 02:71d9 $f1
    ret                                                ;; 02:71da $c9

ds 2 ; Free space

openLoadScreen:
    ld   HL, wWindowFlags                              ;; 02:71dd $21 $74 $d8
    set  2, [HL]                                       ;; 02:71e0 $cb $d6
    jr   openLoadSaveScreen_common                     ;; 02:71e2 $18 $05

; Bug: The first byte of this ($21) is read when attempting to equip an empty slot.
; Its distance from equipmentDataTable needs to be maintained.
openSaveScreen:
    ld   HL, wWindowFlags                              ;; 02:71e4 $21 $74 $d8
    res  2, [HL]                                       ;; 02:71e7 $cb $96

openLoadSaveScreen_common:
    call windowCloseAndRestoreHidden                   ;; 02:71e9 $cd $7a $66
    ret  NZ                                            ;; 02:71ec $c0
    call showFullscreenWindow                          ;; 02:71ed $cd $57 $51
    ld   A, WINDOW_SAVE_LOAD_FILE_1                    ;; 02:71f0 $3e $1b
    ld   [wDialogType], A                              ;; 02:71f2 $ea $4a $d8
    ld   B, $01                                        ;; 02:71f5 $06 $01
    call setMenuStateCurrentFunction                   ;; 02:71f7 $cd $98 $6c
    ret                                                ;; 02:71fa $c9

menuSaveLoadChoice:
    ld   HL, wWindowFlags                              ;; 02:71fb $21 $74 $d8
    bit  2, [HL]                                       ;; 02:71fe $cb $56
    jp   NZ, menuLoadScreenChoice                      ;; 02:7200 $c2 $be $72
    ld   HL, wWindowSecondaryFlags                     ;; 02:7203 $21 $72 $d8
    res  5, [HL]                                       ;; 02:7206 $cb $ae
    ld   HL, sSave1Header                              ;; 02:7208 $21 $00 $a0
    ld   A, [wSelectedMenuIndex]                       ;; 02:720b $fa $4b $d8
    and  A, A                                          ;; 02:720e $a7
    ld   B, $08                                        ;; 02:720f $06 $08
    jr   Z, .jr_02_721d                                ;; 02:7211 $28 $0a
    ld   HL, wWindowSecondaryFlags                     ;; 02:7213 $21 $72 $d8
    set  5, [HL]                                       ;; 02:7216 $cb $ee
    ld   HL, sSave2Header                              ;; 02:7218 $21 $00 $a1
    ld   B, $10                                        ;; 02:721b $06 $10
.jr_02_721d:
    ld   A, [wNectarStaminaTimerNumber]                ;; 02:721d $fa $7e $d8
    cp   A, $ff                                        ;; 02:7220 $fe $ff
    push AF                                            ;; 02:7222 $f5
    jr   Z, .jr_02_7236                                ;; 02:7223 $28 $11
    push BC                                            ;; 02:7225 $c5
    push DE                                            ;; 02:7226 $d5
    push HL                                            ;; 02:7227 $e5
    ld   HL, wStatStamina                              ;; 02:7228 $21 $c1 $d7
    ld   DE, wStatStaminaBuffBackup                    ;; 02:722b $11 $d8 $d7
    ld   B, $04                                        ;; 02:722e $06 $04
    call swapHL_DE                                     ;; 02:7230 $cd $b3 $72
    pop  HL                                            ;; 02:7233 $e1
    pop  DE                                            ;; 02:7234 $d1
    pop  BC                                            ;; 02:7235 $c1
.jr_02_7236:
    ld   A, [wWindowFlags]                             ;; 02:7236 $fa $74 $d8
    or   A, B                                          ;; 02:7239 $b0
    ld   [wWindowFlags], A                             ;; 02:723a $ea $74 $d8
    ld   A, [wDialogType]                              ;; 02:723d $fa $4a $d8
    ld   [wSelectedMenuIndex], A                       ;; 02:7240 $ea $4b $d8
    push HL                                            ;; 02:7243 $e5
    ld   DE, wSRAMSaveHeader._3                        ;; 02:7244 $11 $aa $d7
    ld   HL, wBoyName                                  ;; 02:7247 $21 $9d $d7
    ld   B, SAVE_MAX_NAME_LENGTH                       ;; 02:724a $06 $04
    call copyHLtoDE.loop                               ;; 02:724c $cd $51 $74
    ld   HL, wGirlName                                 ;; 02:724f $21 $a2 $d7
    ld   B, SAVE_MAX_NAME_LENGTH                       ;; 02:7252 $06 $04
    call copyHLtoDE.loop                               ;; 02:7254 $cd $51 $74
    call getGraphicsAndMusicState                      ;; 02:7257 $cd $35 $77

; Log message on save game.
    ld hl, debugMsgSaveGame
    call logger.hl

    ld   HL, wSRAMSaveHeader                           ;; 02:725a $21 $a7 $d7
    call formatSaveHeader                              ;; 02:725d $cd $72 $77
    push HL                                            ;; 02:7260 $e5
    pop  DE                                            ;; 02:7261 $d1
    pop  HL                                            ;; 02:7262 $e1
    call enableSRAM                                    ;; 02:7263 $cd $58 $74
    ld   DE, wSRAMSaveHeader                           ;; 02:7266 $11 $a7 $d7
    ld   B, $31                                        ;; 02:7269 $06 $31
    call writeDEtimesBtoSRAM                           ;; 02:726b $cd $48 $74
    ld   DE, wEquippedWeaponPower                      ;; 02:726e $11 $bf $d6
    ld   B, $32                                        ;; 02:7271 $06 $32
    call writeDEtimesBtoSRAM                           ;; 02:7273 $cd $48 $74
    ld   DE, wItemInventoryAmount                      ;; 02:7276 $11 $9b $d6
    ld   B, SAVE_ITEM_INVENTORY_SIZE                   ;; 02:7279 $06 $10
    call writeDEtimesBtoSRAM                           ;; 02:727b $cd $48 $74
    ld   DE, wDialogX                                  ;; 02:727e $11 $a7 $d4
    ld   B, $08                                        ;; 02:7281 $06 $08
    call writeDEtimesBtoSRAM                           ;; 02:7283 $cd $48 $74
; Every save game ends with the magic number with nibbles swapped.
    ld   A, LOW(((SAVE_MAGIC_NUMBER >> 4) & $0f) | (SAVE_MAGIC_NUMBER << 4)) ;; 02:7286 $3e $c6
    call writeSRAMByte                                 ;; 02:7288 $cd $64 $74
    call disableSRAM                                   ;; 02:728b $cd $5e $74
    ld   A, WINDOW_SAVE_LOAD_FILE_1                    ;; 02:728e $3e $1b
    ld   [wDialogType], A                              ;; 02:7290 $ea $4a $d8
    ld   A, $01                                        ;; 02:7293 $3e $01
    ld   [wMenuStateCurrentFunction], A                ;; 02:7295 $ea $53 $d8
    pop  AF                                            ;; 02:7298 $f1
    ret  Z                                             ;; 02:7299 $c8
    push BC                                            ;; 02:729a $c5
    push DE                                            ;; 02:729b $d5
    push HL                                            ;; 02:729c $e5
    ld   HL, wStatStaminaBuffBackup                    ;; 02:729d $21 $d8 $d7
    ld   DE, wStatStamina                              ;; 02:72a0 $11 $c1 $d7
    ld   B, $04                                        ;; 02:72a3 $06 $04
    call swapHL_DE                                     ;; 02:72a5 $cd $b3 $72
    pop  HL                                            ;; 02:72a8 $e1
    pop  DE                                            ;; 02:72a9 $d1
    pop  BC                                            ;; 02:72aa $c1
    ret                                                ;; 02:72ab $c9

ds 1 ; Free space

; Swap out the memory blocks at HL and DE with the size in B
swapHL_DE:
    ld   A, [HL]                                       ;; 02:72b3 $7e
    ld   C, A                                          ;; 02:72b4 $4f
    ld   A, [DE]                                       ;; 02:72b5 $1a
    ld   [HL+], A                                      ;; 02:72b6 $22
    ld   A, C                                          ;; 02:72b7 $79
    ld   [DE], A                                       ;; 02:72b8 $12
    inc  DE                                            ;; 02:72b9 $13
    dec  B                                             ;; 02:72ba $05
    jr   NZ, swapHL_DE                                 ;; 02:72bb $20 $f6
    ret                                                ;; 02:72bd $c9

menuLoadScreenChoice:
    ld   DE, wWindowSecondaryFlags                     ;; 02:72be $11 $72 $d8
    ld   A, [DE]                                       ;; 02:72c1 $1a
    res  5, A                                          ;; 02:72c2 $cb $af
    ld   [DE], A                                       ;; 02:72c4 $12
    ld   HL, sSave1Header                              ;; 02:72c5 $21 $00 $a0
    ld   A, [wSelectedMenuIndex]                       ;; 02:72c8 $fa $4b $d8
    and  A, A                                          ;; 02:72cb $a7
    ld   A, [wWindowFlags]                             ;; 02:72cc $fa $74 $d8
    jr   NZ, .jr_02_72de                               ;; 02:72cf $20 $0d
    bit  3, A                                          ;; 02:72d1 $cb $5f
    jr   NZ, .jr_02_72e9                               ;; 02:72d3 $20 $14
.jr_02_72d5:
    call playWindowErrorSound                          ;; 02:72d5 $cd $1f $7a
    ld   A, $97                                        ;; 02:72d8 $3e $97
    ld   [wMenuStateCurrentFunction], A                ;; 02:72da $ea $53 $d8
    ret                                                ;; 02:72dd $c9
.jr_02_72de:
    bit  4, A                                          ;; 02:72de $cb $67
    jr   Z, .jr_02_72d5                                ;; 02:72e0 $28 $f3
    ld   A, [DE]                                       ;; 02:72e2 $1a
    set  5, A                                          ;; 02:72e3 $cb $ef
    ld   [DE], A                                       ;; 02:72e5 $12
    ld   HL, sSave2Header                              ;; 02:72e6 $21 $00 $a1
.jr_02_72e9:
    ld   A, [wDialogType]                              ;; 02:72e9 $fa $4a $d8
    ld   [wSelectedMenuIndex], A                       ;; 02:72ec $ea $4b $d8
    call enableSRAM                                    ;; 02:72ef $cd $58 $74
    ld   DE, wSRAMSaveHeader                           ;; 02:72f2 $11 $a7 $d7
    ld   B, $31                                        ;; 02:72f5 $06 $31
    call readDEtimesBtoSRAM                            ;; 02:72f7 $cd $3f $74
    ld   DE, wEquippedWeaponPower                      ;; 02:72fa $11 $bf $d6
    ld   B, $32                                        ;; 02:72fd $06 $32
    call readDEtimesBtoSRAM                            ;; 02:72ff $cd $3f $74
    ld   DE, wItemInventoryAmount                      ;; 02:7302 $11 $9b $d6
    ld   B, SAVE_ITEM_INVENTORY_SIZE                   ;; 02:7305 $06 $10
    call readDEtimesBtoSRAM                            ;; 02:7307 $cd $3f $74
    ld   DE, wOpenChestScript3                         ;; 02:730a $11 $33 $d6
    ld   B, $08                                        ;; 02:730d $06 $08
    call readDEtimesBtoSRAM                            ;; 02:730f $cd $3f $74
    call disableSRAM                                   ;; 02:7312 $cd $5e $74
    call loadSRAMInitGame                              ;; 02:7315 $cd $22 $73
    call getEquippedWeaponElements                     ;; 02:7318 $cd $56 $71
    call getEquippedItemElements                       ;; 02:731b $cd $65 $71
    call loadGameFinish                                ;; 02:731e $cd $21 $74
    ret                                                ;; 02:7321 $c9

; Inits most of the game related things. Creates a script to load the proper room, follower, and more.
loadSRAMInitGame:
    ld   HL, wOpenChestScript1                         ;; 02:7322 $21 $13 $d6
    push HL                                            ;; 02:7325 $e5
    ld   HL, wSRAMSaveHeader._3                        ;; 02:7326 $21 $aa $d7
    ld   DE, wBoyName                                  ;; 02:7329 $11 $9d $d7
    ld   B, SAVE_MAX_NAME_LENGTH                       ;; 02:732c $06 $04
    call copyHLtoDE.loop                               ;; 02:732e $cd $51 $74
    xor  A, A                                          ;; 02:7331 $af
    ld   [DE], A                                       ;; 02:7332 $12
    inc  DE                                            ;; 02:7333 $13
    ld   B, SAVE_MAX_NAME_LENGTH                       ;; 02:7334 $06 $04
    call copyHLtoDE.loop                               ;; 02:7336 $cd $51 $74
    xor  A, A                                          ;; 02:7339 $af
    ld   [DE], A                                       ;; 02:733a $12
; Init the attack gauge.
    ld   A, $01                                        ;; 02:733b $3e $01
    ld   [wWillCharge], A                              ;; 02:733d $ea $58 $d8
; Init known magic spells from the magic inventory.
    ld   HL, wMagicInventory                           ;; 02:7340 $21 $d5 $d6
    ld   DE, wKnownMagicSpells                         ;; 02:7343 $11 $ab $d6
    ld   B, SAVE_MAGIC_INVENTORY_SIZE                  ;; 02:7346 $06 $08
.loop_magic:
    xor  A, A                                          ;; 02:7348 $af
    ld   [DE], A                                       ;; 02:7349 $12
    ld   A, [HL+]                                      ;; 02:734a $2a
    and  A, A                                          ;; 02:734b $a7
    jr   Z, .next_magic                                ;; 02:734c $28 $03
    ld   A, $01                                        ;; 02:734e $3e $01
    ld   [DE], A                                       ;; 02:7350 $12
.next_magic:
    inc  DE                                            ;; 02:7351 $13
    dec  B                                             ;; 02:7352 $05
    jr   NZ, .loop_magic                               ;; 02:7353 $20 $f3
; Init equipment powers from equipment inventory.
; This originally had a bug with empty slots before the last item that caused the Iron Helmet exploit used by speedrunners.
; It could also easily cause a major nerf for unsuspecting players.
    ld   HL, wEquipmentInventory                       ;; 02:7355 $21 $dd $d6
    ld   DE, wEquipmentInventoryPowers                 ;; 02:7358 $11 $b3 $d6
    ld   B, SAVE_EQUIP_INVENTORY_SIZE                  ;; 02:735b $06 $0c
.loop_equipment:
    push BC                                            ;; 02:735d $c5
    ld   A, [HL]                                       ;; 02:735e $7e
    call getItemFlags1And2                             ;; 02:735f $cd $9c $56
    inc  C                                             ;; 02:7363 $0c
    jr   Z, .equipment_next                            ;; 02:7364 $28 $15
    ld a, [hl]
    push HL                                            ;; 02:7369 $e5
    ld   HL, equipmentDataTable + $0c                  ;; 02:736a $21 $f6 $61
    call indexIntoTable                                ;; 02:736d $cd $82 $76
    ld   A, [HL]                                       ;; 02:7379 $7e
    pop  HL                                            ;; 02:737a $e1
    ld   [DE], A                                       ;; 02:737b $12
.equipment_next:
    inc hl
    inc  DE                                            ;; 02:737c $13
    pop  BC                                            ;; 02:737d $c1
    dec  B                                             ;; 02:737e $05
    jr   NZ, .loop_equipment                           ;; 02:737f $20 $dc
; Free space from the above fix:
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop

    ld   HL, wStatusScreenAPDP                         ;; 02:7381 $21 $dd $d7
    ld   A, $81                                        ;; 02:7384 $3e $81
    ld   [HL+], A                                      ;; 02:7386 $22
    inc  A                                             ;; 02:7387 $3c
    ld   [HL], A                                       ;; 02:7388 $77
    ld   HL, wTotalAP                                  ;; 02:7389 $21 $df $d7
    ld   A, [wDupTotalAP]                              ;; 02:738c $fa $c1 $d6
    ld   [HL+], A                                      ;; 02:738f $22
    ld   A, [wDupTotalDP]                              ;; 02:7390 $fa $c3 $d6
    ld   [HL], A                                       ;; 02:7393 $77
    ld   A, [wStatusEffect]                            ;; 02:7394 $fa $c0 $d7
    ld   C, A                                          ;; 02:7397 $4f
    ld   B, $00                                        ;; 02:7398 $06 $00
    call startStatusEffects                            ;; 02:739a $cd $59 $78
    ld   A, [wLevel]                                   ;; 02:739d $fa $ba $d7
    call setNextXPLevel                                ;; 02:73a0 $cd $a3 $3e
    pop  HL                                            ;; 02:73a3 $e1
    call loadSRAMCreateInitScript                      ;; 02:73a4 $cd $7f $7a
    call loadSRAMInitScriptOpenDoorIfInDoorway         ;; 02:73a7 $cd $bf $7a
    ld   A, [wOpenChestScript1._4]                     ;; 02:73aa $fa $17 $d6
    ld   D, A                                          ;; 02:73ad $57
    ld   A, [wOpenChestScript1._3]                     ;; 02:73ae $fa $16 $d6
    ld   E, A                                          ;; 02:73b1 $5f
    ld   A, [wScriptFlags0B]                           ;; 02:73b2 $fa $d1 $d7
    ld   B, A                                          ;; 02:73b5 $47
    rlc  B                                             ;; 02:73b6 $cb $00
    ld   A, [wScriptFlags0A]                           ;; 02:73b8 $fa $d0 $d7
    rla                                                ;; 02:73bb $17
    and  A, A                                          ;; 02:73bc $a7
    jr   Z, .jr_02_73f1                                ;; 02:73bd $28 $32
    push DE                                            ;; 02:73bf $d5
    ld   DE, .followerInitArgs                         ;; 02:73c0 $11 $06 $74
    ld   B, $07                                        ;; 02:73c3 $06 $07
.loop_3:
    rlca                                               ;; 02:73c5 $07
    jr   C, .jr_02_73d8                                ;; 02:73c6 $38 $10
    inc  DE                                            ;; 02:73c8 $13
    inc  DE                                            ;; 02:73c9 $13
    inc  DE                                            ;; 02:73ca $13
    dec  B                                             ;; 02:73cb $05
    jr   NZ, .loop_3                                   ;; 02:73cc $20 $f7
    ld   A, [wScriptFlags04]                           ;; 02:73ce $fa $ca $d7
    bit  6, A                                          ;; 02:73d1 $cb $77
    jr   NZ, .jr_02_73d8                               ;; 02:73d3 $20 $03
    inc  DE                                            ;; 02:73d5 $13
    inc  DE                                            ;; 02:73d6 $13
    inc  DE                                            ;; 02:73d7 $13
.jr_02_73d8:
; $fc = sSET_NPC_TYPES
    ld   A, $fc                                        ;; 02:73d8 $3e $fc
    ld   [HL+], A                                      ;; 02:73da $22
    ld   A, [DE]                                       ;; 02:73db $1a
    ld   [HL+], A                                      ;; 02:73dc $22
    inc  DE                                            ;; 02:73dd $13
; $fd = sSPAWN_NPC
    ld   A, $fd                                        ;; 02:73de $3e $fd
    ld   [HL+], A                                      ;; 02:73e0 $22
    ld   A, [DE]                                       ;; 02:73e1 $1a
    ld   [HL+], A                                      ;; 02:73e2 $22
    inc  DE                                            ;; 02:73e3 $13
; $9c = sGIVE_FOLLOWER
    ld   A, $9c                                        ;; 02:73e4 $3e $9c
    ld   [HL+], A                                      ;; 02:73e6 $22
    ld   A, [DE]                                       ;; 02:73e7 $1a
    ld   [HL+], A                                      ;; 02:73e8 $22
; $99 = sFOLLOWER_SET_POSITION
    ld   A, $99                                        ;; 02:73e9 $3e $99
    ld   [HL+], A                                      ;; 02:73eb $22
    pop  DE                                            ;; 02:73ec $d1
    ld   [HL], E                                       ;; 02:73ed $73
    inc  HL                                            ;; 02:73ee $23
    ld   [HL], D                                       ;; 02:73ef $72
    inc  HL                                            ;; 02:73f0 $23
.jr_02_73f1:
    ld   A, [wOpenChestScript3._4]                     ;; 02:73f1 $fa $37 $d6
    and  A, A                                          ;; 02:73f4 $a7
    jr   Z, .jr_02_73fa                                ;; 02:73f5 $28 $03
; $9f + 1 = sPLAYER_ON_CHOCOBO, and other forms follow from there.
    add  A, $9f                                        ;; 02:73f7 $c6 $9f
    ld   [HL+], A                                      ;; 02:73f9 $22
; $ec = sRUN_ROOM_SCRIPT
.jr_02_73fa:
    ld   A, $ec                                        ;; 02:73fa $3e $ec
    ld   [HL+], A                                      ;; 02:73fc $22
; $00 = sEND
    xor  A, A                                          ;; 02:73fd $af
    ld   [HL], A                                       ;; 02:73fe $77
    ld   HL, $0b                                       ;; 02:73ff $21 $0b $00
    call runScriptByIndex                              ;; 02:7402 $cd $ad $31
    ret                                                ;; 02:7405 $c9

; Arguments for three script commands in order to initialize a follower:
; 0: sSET_NPC_TYPES
; 1: sSPAWN_NPC
; 2: sGIVE_FOLLOWER
.followerInitArgs:
    db   $32, $01, $01 ; Fuji
    db   $4d, $00, $02 ; Traveler (Man/Mysterious Man/Traveling Man)
    db   $4e, $02, $03 ; Watts
    db   $4f, $00, $04 ; Bogard
    db   $51, $00, $05 ; Amanda (or Duke)
    db   $41, $02, $06 ; Lester
    db   $52, $00, $07 ; Marcie
    db   $65, $00, $08 ; Chocobot
    db   $50, $01, $09 ; Chocobo

; Dismiss the Load screen and start the game.
loadGameFinish:
    ld   A, [wEquippedItem]                            ;; 02:7424 $fa $ef $d6
    ld   [wEquippedItemAndWeaponCopy], A               ;; 02:7427 $ea $f1 $d6
    and  A, $7f                                        ;; 02:742a $e6 $7f
    dec  A                                             ;; 02:742c $3d
    call getEquippedItemAnimationType_trampoline       ;; 02:742d $cd $df $2e
    call hideAndSaveMenuMetasprites                    ;; 02:7430 $cd $51 $6b
; These next two calls have been switched in order to prevent a brief visual glitch.
    call hideFullscreenWindow

; Log message on load game.
    ld hl, debugMsgLoadGame
    call logger.hl

    call clearSaveLoadScreen
    ld   B, $00                                        ;; 02:7439 $06 $00
    call setMenuStateCurrentFunction                   ;; 02:743b $cd $98 $6c
    ret                                                ;; 02:743e $c9

ds 4 ; Free space

; Read a block of SRAM into memory pointing at DE
readDEtimesBtoSRAM:
    call readSRAMByte                                  ;; 02:743f $cd $6f $74
    ld   [DE], A                                       ;; 02:7442 $12
    inc  DE                                            ;; 02:7443 $13
    dec  B                                             ;; 02:7444 $05
    jr   NZ, readDEtimesBtoSRAM                        ;; 02:7445 $20 $f8
    ret                                                ;; 02:7447 $c9

; Write a block of SRAM from memory pointing at DE
writeDEtimesBtoSRAM:
    ld   A, [DE]                                       ;; 02:7448 $1a
    call writeSRAMByte                                 ;; 02:7449 $cd $64 $74
    inc  DE                                            ;; 02:744c $13
    dec  B                                             ;; 02:744d $05
    jr   NZ, writeDEtimesBtoSRAM                       ;; 02:744e $20 $f8
    ret                                                ;; 02:7450 $c9

SECTION "bank02_align_7458", ROMX[$7458], BANK[$02]

enableSRAM:
    ld   A, CART_SRAM_ENABLE                           ;; 02:7458 $3e $0a
    ld   [rRAMG], A                                    ;; 02:745a $ea $00 $00
    ret                                                ;; 02:745d $c9

disableSRAM:
    ld   A, $09                                        ;; 02:745e $3e $09
    ld   [rRAMG], A                                    ;; 02:7460 $ea $00 $00
    ret                                                ;; 02:7463 $c9

writeSRAMByte:
    push AF                                            ;; 02:7464 $f5
    and  A, $0f                                        ;; 02:7465 $e6 $0f
    ld   [HL+], A                                      ;; 02:7467 $22
    pop  AF                                            ;; 02:7468 $f1
    swap A                                             ;; 02:7469 $cb $37
    and  A, $0f                                        ;; 02:746b $e6 $0f
    ld   [HL+], A                                      ;; 02:746d $22
    ret                                                ;; 02:746e $c9

; FFA uses MBC2 SRAM, which only stores 4 bits per address
; This function reads two addresses from HL and combines those into a single byte in A
readSRAMByte:
    push BC                                            ;; 02:746f $c5
    ld   A, [HL+]                                      ;; 02:7470 $2a
    and  A, $0f                                        ;; 02:7471 $e6 $0f
    ld   B, A                                          ;; 02:7473 $47
    ld   A, [HL+]                                      ;; 02:7474 $2a
    and  A, $0f                                        ;; 02:7475 $e6 $0f
    swap A                                             ;; 02:7477 $cb $37
    or   A, B                                          ;; 02:7479 $b0
    pop  BC                                            ;; 02:747a $c1
    ret                                                ;; 02:747b $c9

; Check a save game's header byte and checksum.
; A = bit mask for bit to set/clear in wWindowFlags to indicate a valid/invalid save file.
; HL = beginning of save file
checkSaveGameIntegrity:
    push AF                                            ;; 02:747c $f5
    call enableSRAM                                    ;; 02:747d $cd $58 $74
    call readSRAMByte                                  ;; 02:7480 $cd $6f $74
    cp   A, SAVE_MAGIC_NUMBER                          ;; 02:7483 $fe $6c
    jr   NZ, .header_mismatch                          ;; 02:7485 $20 $1e
    call readSRAMByte                                  ;; 02:7487 $cd $6f $74
    ld   E, A                                          ;; 02:748a $5f
    call readSRAMByte                                  ;; 02:748b $cd $6f $74
    ld   D, A                                          ;; 02:748e $57
    push HL                                            ;; 02:748f $e5
    push DE                                            ;; 02:7490 $d5
    ld   DE, $00                                       ;; 02:7491 $11 $00 $00
    ld   B, $78                                        ;; 02:7494 $06 $78
    call getSRAMChecksum                               ;; 02:7496 $cd $c4 $74
    pop  DE                                            ;; 02:7499 $d1
    ld   A, D                                          ;; 02:749a $7a
    cp   A, H                                          ;; 02:749b $bc
    jr   NZ, .checksum_mismatch                        ;; 02:749c $20 $04
    ld   A, E                                          ;; 02:749e $7b
    cp   A, L                                          ;; 02:749f $bd
    jr   Z, .valid                                     ;; 02:74a0 $28 $14
.checksum_mismatch:
    pop  HL                                            ;; 02:74a2 $e1
    jr   .invalid                                      ;; 02:74a3 $18 $02
.header_mismatch:
    inc  HL                                            ;; 02:74a5 $23
    inc  HL                                            ;; 02:74a6 $23
.invalid:
    call disableSRAM                                   ;; 02:74a7 $cd $5e $74
    pop  AF                                            ;; 02:74aa $f1
    cpl                                                ;; 02:74ab $2f
    ld   B, A                                          ;; 02:74ac $47
    ld   A, [wWindowFlags]                             ;; 02:74ad $fa $74 $d8
    and  A, B                                          ;; 02:74b0 $a0
    ld   [wWindowFlags], A                             ;; 02:74b1 $ea $74 $d8
    scf                                                ;; 02:74b4 $37
    ret                                                ;; 02:74b5 $c9
.valid:
    call disableSRAM                                   ;; 02:74b6 $cd $5e $74
    pop  HL                                            ;; 02:74b9 $e1
    pop  AF                                            ;; 02:74ba $f1
    ld   B, A                                          ;; 02:74bb $47
    ld   A, [wWindowFlags]                             ;; 02:74bc $fa $74 $d8
    or   A, B                                          ;; 02:74bf $b0
    ld   [wWindowFlags], A                             ;; 02:74c0 $ea $74 $d8
    ret                                                ;; 02:74c3 $c9

; Get SRAM checksum, read B bytes from SRAM and accumulates them into HL, with DE as start value.
getSRAMChecksum:
    call readSRAMByte                                  ;; 02:74c4 $cd $6f $74
    ld   C, A                                          ;; 02:74c7 $4f
    add  A, E                                          ;; 02:74c8 $83
    ld   E, A                                          ;; 02:74c9 $5f
    ld   A, D                                          ;; 02:74ca $7a
    adc  A, $00                                        ;; 02:74cb $ce $00
    ld   D, A                                          ;; 02:74cd $57
    dec  B                                             ;; 02:74ce $05
    jr   NZ, getSRAMChecksum                           ;; 02:74cf $20 $f3
    push DE                                            ;; 02:74d1 $d5
    pop  HL                                            ;; 02:74d2 $e1
    ld   A, C                                          ;; 02:74d3 $79
    ret                                                ;; 02:74d4 $c9

drawSaveNameFromSRAM:
    ld   B, $04                                        ;; 02:74d5 $06 $04
    ld   DE, wSRAMSaveHeader._3                        ;; 02:74d7 $11 $aa $d7
    push DE                                            ;; 02:74da $d5
.loop:
    call readSRAMByte                                  ;; 02:74db $cd $6f $74
    ld   [DE], A                                       ;; 02:74de $12
    inc  DE                                            ;; 02:74df $13
    dec  B                                             ;; 02:74e0 $05
    jr   NZ, .loop                                     ;; 02:74e1 $20 $f8
    xor  A, A                                          ;; 02:74e3 $af
    ld   [DE], A                                       ;; 02:74e4 $12
    pop  DE                                            ;; 02:74e5 $d1
    push HL                                            ;; 02:74e6 $e5
    push DE                                            ;; 02:74e7 $d5
    pop  HL                                            ;; 02:74e8 $e1
    ld   DE, $202                                      ;; 02:74e9 $11 $02 $02
    ld   BC, $404                                      ;; 02:74ec $01 $04 $04
    call drawText                                      ;; 02:74ef $cd $77 $37
    pop  HL                                            ;; 02:74f2 $e1
    ret                                                ;; 02:74f3 $c9

drawSaveHPFromSRAM:
    push HL                                            ;; 02:74f4 $e5
    ld   DE, $207                                      ;; 02:74f5 $11 $07 $02
    ld   B, $03                                        ;; 02:74f8 $06 $03
    ld   HL, statusScreenHPLabel                       ;; 02:74fa $21 $b3 $7d
    call drawText                                      ;; 02:74fd $cd $77 $37
    pop  HL                                            ;; 02:7500 $e1
    call readSRAMByte                                  ;; 02:7501 $cd $6f $74
    ld   E, A                                          ;; 02:7504 $5f
    call readSRAMByte                                  ;; 02:7505 $cd $6f $74
    ld   D, A                                          ;; 02:7508 $57
    push HL                                            ;; 02:7509 $e5
    push DE                                            ;; 02:750a $d5
    pop  HL                                            ;; 02:750b $e1
    ld   DE, $20c                                      ;; 02:750c $11 $0c $02
    push DE                                            ;; 02:750f $d5
    call drawNumberAtDialogPositionDE                  ;; 02:7510 $cd $18 $5b
    pop  DE                                            ;; 02:7513 $d1
    inc  E                                             ;; 02:7514 $1c
    ld   A, $f7                                        ;; 02:7515 $3e $f7
    call storeTileAatDialogPositionDE                  ;; 02:7517 $cd $44 $38
    pop  HL                                            ;; 02:751a $e1
    call readSRAMByte                                  ;; 02:751b $cd $6f $74
    ld   E, A                                          ;; 02:751e $5f
    call readSRAMByte                                  ;; 02:751f $cd $6f $74
    ld   D, A                                          ;; 02:7522 $57
    push HL                                            ;; 02:7523 $e5
    push DE                                            ;; 02:7524 $d5
    pop  HL                                            ;; 02:7525 $e1
    ld   DE, $211                                      ;; 02:7526 $11 $11 $02
    call drawNumberAtDialogPositionDE                  ;; 02:7529 $cd $18 $5b
    pop  HL                                            ;; 02:752c $e1
    ret                                                ;; 02:752d $c9

drawSaveMPFromSRAM:
    push HL                                            ;; 02:752e $e5
    ld   DE, $307                                      ;; 02:752f $11 $07 $03
    ld   B, $03                                        ;; 02:7532 $06 $03
    ld   HL, statusScreenMPLabel                       ;; 02:7534 $21 $bc $7d
    call drawText                                      ;; 02:7537 $cd $77 $37
    pop  HL                                            ;; 02:753a $e1
    call readSRAMByte                                  ;; 02:753b $cd $6f $74
    ld   C, A                                          ;; 02:753e $4f
    call readSRAMByte                                  ;; 02:753f $cd $6f $74
    push HL                                            ;; 02:7542 $e5
    ld   H, A                                          ;; 02:7543 $67
    ld   L, C                                          ;; 02:7544 $69
    ld   DE, $30c                                      ;; 02:7545 $11 $0c $03
    push DE                                            ;; 02:7548 $d5
    call drawNumberAtDialogPositionDE                  ;; 02:7549 $cd $18 $5b
    pop  DE                                            ;; 02:754c $d1
    inc  E                                             ;; 02:754d $1c
    ld   A, $f7                                        ;; 02:754e $3e $f7
    call storeTileAatDialogPositionDE                  ;; 02:7550 $cd $44 $38
    pop  HL                                            ;; 02:7553 $e1
    call readSRAMByte                                  ;; 02:7554 $cd $6f $74
    ld   C, A                                          ;; 02:7557 $4f
    call readSRAMByte                                  ;; 02:7558 $cd $6f $74
    push HL                                            ;; 02:755b $e5
    ld   L, C                                          ;; 02:755c $69
    ld   H, A                                          ;; 02:755d $67
    ld   DE, $311                                      ;; 02:755e $11 $11 $03
    call drawNumberAtDialogPositionDE                  ;; 02:7561 $cd $18 $5b
    pop  HL                                            ;; 02:7564 $e1
    ret                                                ;; 02:7565 $c9

; Draw the level of the save as well as the E after it for the exp, but not the actual experience numbers
drawLevelFromSRAM:
    ld   DE, $402                                      ;; 02:7566 $11 $02 $04
    ld   A, $45                                        ;; 02:7569 $3e $45
    call storeTileAatDialogPositionDE                  ;; 02:756b $cd $44 $38
    inc  E                                             ;; 02:756e $1c
    inc  E                                             ;; 02:756f $1c
    inc  E                                             ;; 02:7570 $1c
    call readSRAMByte                                  ;; 02:7571 $cd $6f $74
    push HL                                            ;; 02:7574 $e5
    ld   L, A                                          ;; 02:7575 $6f
    ld   [wSRAMSaveHeader], A                          ;; 02:7576 $ea $a7 $d7
    ld   H, $00                                        ;; 02:7579 $26 $00
    push DE                                            ;; 02:757b $d5
    call drawNumberAtDialogPositionDE                  ;; 02:757c $cd $18 $5b
    pop  DE                                            ;; 02:757f $d1
    inc  E                                             ;; 02:7580 $1c
    inc  E                                             ;; 02:7581 $1c
    ld   A, $3e                                        ;; 02:7582 $3e $3e
    call storeTileAatDialogPositionDE                  ;; 02:7584 $cd $44 $38
    pop  HL                                            ;; 02:7587 $e1
    ret                                                ;; 02:7588 $c9

drawExperienceFromSRAM:
    call readSRAMByte                                  ;; 02:7589 $cd $6f $74
    ld   E, A                                          ;; 02:758c $5f
    call readSRAMByte                                  ;; 02:758d $cd $6f $74
    ld   D, A                                          ;; 02:7590 $57
    call readSRAMByte                                  ;; 02:7591 $cd $6f $74
    ld   C, A                                          ;; 02:7594 $4f
    push DE                                            ;; 02:7595 $d5
    pop  HL                                            ;; 02:7596 $e1
    ld   DE, $40b                                      ;; 02:7597 $11 $0b $04
    call drawNumber24bitOnDialog                       ;; 02:759a $cd $ae $59
    ld   DE, $509                                      ;; 02:759d $11 $09 $05
    ld   A, $f7                                        ;; 02:75a0 $3e $f7
    push DE                                            ;; 02:75a2 $d5
    call storeTileAatDialogPositionDE                  ;; 02:75a3 $cd $44 $38
    ld   A, [wSRAMSaveHeader]                          ;; 02:75a6 $fa $a7 $d7
    call setNextXPLevel                                ;; 02:75a9 $cd $a3 $3e
    ld   A, [wNextXPLevelHigh]                         ;; 02:75ac $fa $c1 $d8
    ld   H, A                                          ;; 02:75af $67
    ld   A, [wNextXPLevelLow]                          ;; 02:75b0 $fa $c0 $d8
    ld   L, A                                          ;; 02:75b3 $6f
    ld   A, [wNextXPLevelHighExt]                      ;; 02:75b4 $fa $c2 $d8
    ld   C, A                                          ;; 02:75b7 $4f
    pop  DE                                            ;; 02:75b8 $d1
    inc  E                                             ;; 02:75b9 $1c
    inc  E                                             ;; 02:75ba $1c
    call drawNumber24bitOnDialog                       ;; 02:75bb $cd $ae $59
    ld   A, [wLevel]                                   ;; 02:75be $fa $ba $d7
    call setNextXPLevel                                ;; 02:75c1 $cd $a3 $3e
    ret                                                ;; 02:75c4 $c9

call_02_75c5:
    push BC                                            ;; 02:75c5 $c5
    ld   A, [wWindowSecondPointer.high]                ;; 02:75c6 $fa $95 $d8
    ld   H, A                                          ;; 02:75c9 $67
    ld   A, [wWindowSecondPointer]                     ;; 02:75ca $fa $94 $d8
    ld   L, A                                          ;; 02:75cd $6f
    ld   A, [wD846]                                    ;; 02:75ce $fa $46 $d8
    ld   C, A                                          ;; 02:75d1 $4f
    ld   B, $00                                        ;; 02:75d2 $06 $00
    add  HL, BC                                        ;; 02:75d4 $09
    inc  A                                             ;; 02:75d5 $3c
    ld   [wD846], A                                    ;; 02:75d6 $ea $46 $d8
    ld   A, [HL]                                       ;; 02:75d9 $7e
    and  A, A                                          ;; 02:75da $a7
    pop  BC                                            ;; 02:75db $c1
    ret  Z                                             ;; 02:75dc $c8
    ld   HL, .data_02_75f3                             ;; 02:75dd $21 $f3 $75
    and  A, $7f                                        ;; 02:75e0 $e6 $7f
    ret  Z                                             ;; 02:75e2 $c8
    push AF                                            ;; 02:75e3 $f5
    ld   A, [wWindowThirdPointer.high]                 ;; 02:75e4 $fa $97 $d8
    ld   H, A                                          ;; 02:75e7 $67
    ld   A, [wWindowThirdPointer]                      ;; 02:75e8 $fa $96 $d8
    ld   L, A                                          ;; 02:75eb $6f
    pop  AF                                            ;; 02:75ec $f1
    push AF                                            ;; 02:75ed $f5
    call indexIntoTable                                ;; 02:75ee $cd $82 $76
    pop  AF                                            ;; 02:75f1 $f1
    ret                                                ;; 02:75f2 $c9
.data_02_75f3:
    db   $00                                           ;; 02:75f3 .

drawMoneyOnDialog:
    ld   A, [wDialogType]                              ;; 02:75f4 $fa $4a $d8
    push AF                                            ;; 02:75f7 $f5
    call windowInitContents                            ;; 02:75f8 $cd $93 $76
    ld   DE, $200                                      ;; 02:75fb $11 $07 $02
    pop  AF                                            ;; 02:75fe $f1
    cp   A, WINDOW_STATUS_SCREEN_MONEY                 ;; 02:75ff $fe $13
    jr   NZ, .jr_02_761c
    dec  D                                             ;; 02:7603 $15
.jr_02_761c:
    push BC                                            ;; 02:761d $c5
    ld   C, $00
    ld   A, [wStatusEffect]
    rla
    jr   NC, .draw_number
    inc  C
.draw_number:
    ld   HL, wMoneyLow
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    push DE
    call drawNumber24bitOnDialog
    pop  DE
    ld   B, $02
    ld   E, $07
    ld   HL, statusScreenGoldLabel
    call drawText
    pop  BC
    ret
    db   $00, $00, $00, $00, $00, $00, $00, $00

; Formatted for display in the Status window, with a blank in the middle
initStatusHPMPCurrentAndMax:
    ld   HL, wStatusHPMPCurrentAndMax                  ;; 02:762d $21 $93 $d7
    ld   A, [wHPHigh]                                  ;; 02:7630 $fa $b3 $d7
    ld   D, A                                          ;; 02:7633 $57
    ld   A, [wHPLow]                                   ;; 02:7634 $fa $b2 $d7
    ld   E, A                                          ;; 02:7637 $5f
    ld   [HL], E                                       ;; 02:7638 $73
    inc  HL                                            ;; 02:7639 $23
    ld   [HL], D                                       ;; 02:763a $72
    inc  HL                                            ;; 02:763b $23
    ld   A, [wMaxHPHigh]                               ;; 02:763c $fa $b5 $d7
    ld   D, A                                          ;; 02:763f $57
    ld   A, [wMaxHPLow]                                ;; 02:7640 $fa $b4 $d7
    ld   E, A                                          ;; 02:7643 $5f
    ld   [HL], E                                       ;; 02:7644 $73
    inc  HL                                            ;; 02:7645 $23
    ld   [HL], D                                       ;; 02:7646 $72
    inc  HL                                            ;; 02:7647 $23
    inc  HL                                            ;; 02:7648 $23
    inc  HL                                            ;; 02:7649 $23
    ld   D, $00                                        ;; 02:764a $16 $00
    ld   A, [wManaLow]                                 ;; 02:764c $fa $b6 $d7
    ld   E, A                                          ;; 02:764f $5f
    ld   [HL], E                                       ;; 02:7650 $73
    inc  HL                                            ;; 02:7651 $23
    ld   [HL], D                                       ;; 02:7652 $72
    inc  HL                                            ;; 02:7653 $23
    ld   A, [wMaxManaLow]                              ;; 02:7654 $fa $b8 $d7
    ld   E, A                                          ;; 02:7657 $5f
    ld   [HL], E                                       ;; 02:7658 $73
    inc  HL                                            ;; 02:7659 $23
    ld   [HL], D                                       ;; 02:765a $72
    ret                                                ;; 02:765b $c9

; Called five times to print HP, Max HP, Nothing, MP, Max MP
statusWindowPrintHPMPCurOrMax:
    push AF                                            ;; 02:765c $f5
    push HL                                            ;; 02:765d $e5
    push BC                                            ;; 02:765e $c5
    ld   HL, wStatusHPMPCurrentAndMax                  ;; 02:765f $21 $93 $d7
    ld   A, [wD846]                                    ;; 02:7662 $fa $46 $d8
    push AF                                            ;; 02:7665 $f5
    ld   C, A                                          ;; 02:7666 $4f
    ld   B, $00                                        ;; 02:7667 $06 $00
    add  HL, BC                                        ;; 02:7669 $09
    add  HL, BC                                        ;; 02:766a $09
    ld   A, [HL+]                                      ;; 02:766b $2a
    ld   H, [HL]                                       ;; 02:766c $66
    ld   L, A                                          ;; 02:766d $6f
    dec  D                                             ;; 02:766e $15
    dec  D                                             ;; 02:766f $15
    ld   A, E                                          ;; 02:7670 $7b
    add  A, $05                                        ;; 02:7671 $c6 $05
    ld   E, A                                          ;; 02:7673 $5f
    pop  AF                                            ;; 02:7674 $f1
    cp   A, $02                                        ;; 02:7675 $fe $02
    call NZ, drawNumberAtDialogPositionDE              ;; 02:7677 $c4 $18 $5b
    call menuNextItemPosition                          ;; 02:767a $cd $0b $38
    dec  D                                             ;; 02:767d $15
    pop  BC                                            ;; 02:767e $c1
    pop  HL                                            ;; 02:767f $e1
    pop  AF                                            ;; 02:7680 $f1
    ret                                                ;; 02:7681 $c9

; HL = HL + 1 + ((A & $7F) - 1) * 16
indexIntoTable:
    inc  HL                                            ;; 02:7682 $23
    push DE                                            ;; 02:7683 $d5
    and  A, $7f                                        ;; 02:7684 $e6 $7f
    dec  A                                             ;; 02:7686 $3d
    push HL                                            ;; 02:7687 $e5
    ld   L, A                                          ;; 02:7688 $6f
    ld   H, $00                                        ;; 02:7689 $26 $00
    add  HL, HL                                        ;; 02:768b $29
    add  HL, HL                                        ;; 02:768c $29
    add  HL, HL                                        ;; 02:768d $29
    add  HL, HL                                        ;; 02:768e $29
    pop  DE                                            ;; 02:768f $d1
    add  HL, DE                                        ;; 02:7690 $19
    pop  DE                                            ;; 02:7691 $d1
    ret                                                ;; 02:7692 $c9

; A = window number
windowInitContents:
    push AF                                            ;; 02:7693 $f5
    ld   HL, windowThirdPointers                       ;; 02:7694 $21 $0e $5d
    call indexPointerTable                             ;; 02:7697 $cd $7d $6c
    xor  A, A                                          ;; 02:769a $af
    ld   [wD848], A                                    ;; 02:769b $ea $48 $d8
    ld   A, H                                          ;; 02:769e $7c
    ld   [wWindowThirdPointer.high], A                 ;; 02:769f $ea $97 $d8
    ld   A, L                                          ;; 02:76a2 $7d
    ld   [wWindowThirdPointer], A                      ;; 02:76a3 $ea $96 $d8
    ld   DE, $202                                      ;; 02:76a6 $11 $02 $02
    pop  AF                                            ;; 02:76a9 $f1
    push AF                                            ;; 02:76aa $f5
    ld   HL, windowSecondPointers                      ;; 02:76ab $21 $96 $5d
    call indexPointerTable                             ;; 02:76ae $cd $7d $6c
    ld   A, H                                          ;; 02:76b1 $7c
    ld   [wWindowSecondPointer.high], A                ;; 02:76b2 $ea $95 $d8
    ld   A, L                                          ;; 02:76b5 $7d
    ld   [wWindowSecondPointer], A                     ;; 02:76b6 $ea $94 $d8
    pop  AF                                            ;; 02:76b9 $f1
    push AF                                            ;; 02:76ba $f5
    ld   HL, windowFirstPointers                       ;; 02:76bb $21 $52 $5d
    call indexPointerTable                             ;; 02:76be $cd $7d $6c
    ld   A, H                                          ;; 02:76c1 $7c
    ld   [wWindowFirstPointer.high], A                 ;; 02:76c2 $ea $93 $d8
    ld   A, L                                          ;; 02:76c5 $7d
    ld   [wWindowFirstPointer], A                      ;; 02:76c6 $ea $92 $d8
    pop  AF                                            ;; 02:76c9 $f1
    call getWindowData                                 ;; 02:76ca $cd $88 $6c
    ld   BC, $04                                       ;; 02:76cd $01 $04 $00
    add  HL, BC                                        ;; 02:76d0 $09
    ld   C, [HL]                                       ;; 02:76d1 $4e
    inc  HL                                            ;; 02:76d2 $23
    ld   B, [HL]                                       ;; 02:76d3 $46
    ld   A, B                                          ;; 02:76d4 $78
    ld   [wWindowTextLength], A                        ;; 02:76d5 $ea $9b $d8
    ld   A, C                                          ;; 02:76d8 $79
    ld   [wWindowTextRows], A                          ;; 02:76d9 $ea $9a $d8
    inc  HL                                            ;; 02:76dc $23
    ld   A, [HL+]                                      ;; 02:76dd $2a
    ld   [wWindowNumberOfSelections], A                ;; 02:76de $ea $45 $d8
    ld   A, [HL+]                                      ;; 02:76e1 $2a
    ld   [wMenuFlags], A                               ;; 02:76e2 $ea $49 $d8
    ld   A, [HL+]                                      ;; 02:76e5 $2a
    ld   [wCursorColumns], A                           ;; 02:76e6 $ea $66 $d8
    ld   A, $01                                        ;; 02:76e9 $3e $01
    ld   [wD868], A                                    ;; 02:76eb $ea $68 $d8
    ld   A, [HL]                                       ;; 02:76ee $7e
    ld   [wCursorColumnWidth], A                       ;; 02:76ef $ea $67 $d8
    ld   A, [wDialogX]                                 ;; 02:76f2 $fa $a7 $d4
    ld   H, A                                          ;; 02:76f5 $67
    ld   A, [wDialogW]                                 ;; 02:76f6 $fa $a9 $d4
    add  A, H                                          ;; 02:76f9 $84
    cp   A, $0e                                        ;; 02:76fa $fe $0e
    jr   C, .here                                      ;; 02:76fc $38 $00
.here:
    ld   A, [wD848]                                    ;; 02:76fe $fa $48 $d8
    ld   [wD846], A                                    ;; 02:7701 $ea $46 $d8
    ld   A, [wDialogType]                              ;; 02:7704 $fa $4a $d8
    cp   A, WINDOW_DIALOG                              ;; 02:7707 $fe $06
    jr   NZ, .not_dialog                               ;; 02:7709 $20 $05
    ld   DE, $201                                      ;; 02:770b $11 $01 $02
    jr   .jr_02_7720                                   ;; 02:770e $18 $10
.not_dialog:
    cp   A, WINDOW_STATUS_SCREEN_HP_MP                 ;; 02:7710 $fe $14
    jr   Z, .jr_02_771f                                ;; 02:7712 $28 $0b
    cp   A, WINDOW_STATUS_SCREEN_RIGHT                 ;; 02:7714 $fe $12
    jr   Z, .jr_02_771f                                ;; 02:7716 $28 $07
    cp   A, WINDOW_LEVELUP_MESSAGE                     ;; 02:7718 $fe $17
    jr   NZ, .jr_02_7720                               ;; 02:771a $20 $04
    dec  E                                             ;; 02:771c $1d
    jr   .jr_02_7720                                   ;; 02:771d $18 $01
.jr_02_771f:
    inc  D                                             ;; 02:771f $14
.jr_02_7720:
    ld   A, D                                          ;; 02:7720 $7a
    ld   [wWindowTextInsertionPointY], A               ;; 02:7721 $ea $b9 $d8
    ld   A, E                                          ;; 02:7724 $7b
    ld   [wWindowTextInsertionPointX], A               ;; 02:7725 $ea $b8 $d8
    ld   A, B                                          ;; 02:7728 $78
    ld   [wWindowTextLinesLeft], A                     ;; 02:7729 $ea $bb $d8
    ld   A, C                                          ;; 02:772c $79
    ld   [wWindowTextSpaceLeftOnLine], A               ;; 02:772d $ea $ba $d8
    call saveRegisterState2                            ;; 02:7730 $cd $80 $6d
    xor  A, A                                          ;; 02:7733 $af
    ret                                                ;; 02:7734 $c9

; Used to save game
getGraphicsAndMusicState:
    ld   HL, wDialogX                                  ;; 02:7735 $21 $a7 $d4
    push HL                                            ;; 02:7738 $e5
    ld a, [wMapNumber]
    pop  HL                                            ;; 02:773c $e1
    ld   [HL+], A                                      ;; 02:773d $22
    push HL                                            ;; 02:773e $e5
    call LoadRoomXY_to_A                               ;; 02:773f $cd $0e $22
    pop  HL                                            ;; 02:7742 $e1
    ld   [HL+], A                                      ;; 02:7743 $22
    push HL                                            ;; 02:7744 $e5
    call getPlayerNearestTilePosition                  ;; 02:7745 $cd $69 $01
    pop  HL                                            ;; 02:7748 $e1
    ld   [HL], E                                       ;; 02:7749 $73
    inc  HL                                            ;; 02:774a $23
    ld   [HL], D                                       ;; 02:774b $72
    inc  HL                                            ;; 02:774c $23
    push DE                                            ;; 02:774d $d5
    push HL                                            ;; 02:774e $e5
    call getPlayerForm                                 ;; 02:774f $cd $6f $01
    pop  HL                                            ;; 02:7752 $e1
    ld   [HL+], A                                      ;; 02:7753 $22
    ld   A, [wMusic]                                   ;; 02:7754 $fa $9b $d4
    ld   [HL+], A                                      ;; 02:7757 $22
    pop  DE                                            ;; 02:7758 $d1
    push HL                                            ;; 02:7759 $e5
    inc  D                                             ;; 02:775a $14
    push DE                                            ;; 02:775b $d5
    srl  E                                             ;; 02:775c $cb $3b
    srl  D                                             ;; 02:775e $cb $3a
    call getRoomMetatile                               ;; 02:7760 $cd $26 $24
    pop  DE                                            ;; 02:7763 $d1
    pop  HL                                            ;; 02:7764 $e1
    ld   [HL+], A                                      ;; 02:7765 $22
    push HL                                            ;; 02:7766 $e5
    inc  E                                             ;; 02:7767 $1c
    srl  E                                             ;; 02:7768 $cb $3b
    srl  D                                             ;; 02:776a $cb $3a
    call getRoomMetatile                               ;; 02:776c $cd $26 $24
    pop  HL                                            ;; 02:776f $e1
    ld   [HL], A                                       ;; 02:7770 $77
    ret                                                ;; 02:7771 $c9

formatSaveHeader:
    ld   A, SAVE_MAGIC_NUMBER                          ;; 02:7772 $3e $6c
    ld   [HL+], A                                      ;; 02:7774 $22
    call calculateChecksum                             ;; 02:7775 $cd $7d $77
    ld   [HL], E                                       ;; 02:7778 $73
    inc  HL                                            ;; 02:7779 $23
    ld   [HL], D                                       ;; 02:777a $72
    inc  HL                                            ;; 02:777b $23
    ret                                                ;; 02:777c $c9

calculateChecksum:
    ld   DE, $00                                       ;; 02:777d $11 $00 $00
    push HL                                            ;; 02:7780 $e5
    ld   HL, wSRAMSaveHeader._3                        ;; 02:7781 $21 $aa $d7
    ld   B, $2e                                        ;; 02:7784 $06 $2e
    call calculateChecksumForRange                     ;; 02:7786 $cd $a3 $77
    ld   HL, wEquippedWeaponPower                      ;; 02:7789 $21 $bf $d6
    ld   B, $32                                        ;; 02:778c $06 $32
    call calculateChecksumForRange                     ;; 02:778e $cd $a3 $77
    ld   HL, wItemInventoryAmount                      ;; 02:7791 $21 $9b $d6
    ld   B, $10                                        ;; 02:7794 $06 $10
    call calculateChecksumForRange                     ;; 02:7796 $cd $a3 $77
    ld   HL, wDialogX                                  ;; 02:7799 $21 $a7 $d4
    ld   B, $08                                        ;; 02:779c $06 $08
    call calculateChecksumForRange                     ;; 02:779e $cd $a3 $77
    pop  HL                                            ;; 02:77a1 $e1
    ret                                                ;; 02:77a2 $c9

calculateChecksumForRange:
    ld   A, [HL+]                                      ;; 02:77a3 $2a
    add  A, E                                          ;; 02:77a4 $83
    ld   E, A                                          ;; 02:77a5 $5f
    ld   A, D                                          ;; 02:77a6 $7a
    adc  A, $00                                        ;; 02:77a7 $ce $00
    ld   D, A                                          ;; 02:77a9 $57
    dec  B                                             ;; 02:77aa $05
    jr   NZ, calculateChecksumForRange                 ;; 02:77ab $20 $f6
    ret                                                ;; 02:77ad $c9

ds 1 ; Free space

giveStatusEffect:
    push AF                                            ;; 02:77af $f5
    ld   A, [wMainGameState]                           ;; 02:77b0 $fa $a0 $c0
    ld   [wWindowMainGameStateBackup], A               ;; 02:77b3 $ea $62 $d8
    ld   A, $0f                                        ;; 02:77b6 $3e $0f
    ld   [wMainGameState], A                           ;; 02:77b8 $ea $a0 $c0
    pop  AF                                            ;; 02:77bb $f1
    ld   [wStatusEffectNew], A                         ;; 02:77bc $ea $5f $d8
    bit  4, A                                          ;; 02:77bf $cb $67
    jr   NZ, startStatusEffectAfterWindow              ;; 02:77c1 $20 $64
    swap A                                             ;; 02:77c3 $cb $37
    ld   [wStatusEffectNew], A                         ;; 02:77c5 $ea $5f $d8
    ld   A, $06                                        ;; 02:77c8 $3e $06
    call playSFX                                       ;; 02:77ca $cd $7d $29
    ld   A, $38                                        ;; 02:77cd $3e $38
    ld   [wMenuStateCurrentFunction], A                ;; 02:77cf $ea $53 $d8
    ld   A, WINDOW_STATUS_BEGIN                        ;; 02:77d2 $3e $20
    ld   [wDialogType], A                              ;; 02:77d4 $ea $4a $d8
    ret                                                ;; 02:77d7 $c9

windowOpenStatusEffectInflicted:
    call drawWindow                                    ;; 02:77d8 $cd $00 $67
    ld   A, [wMenuStateCurrentFunction]                ;; 02:77db $fa $53 $d8
    rlca                                               ;; 02:77de $07
    ret  C                                             ;; 02:77df $d8
    ld   A, $05                                        ;; 02:77e0 $3e $05
    ld   [wStatusEffectLabelIndex], A                  ;; 02:77e2 $ea $8a $d8
    ld   A, $39                                        ;; 02:77e5 $3e $39
    ld   [wMenuStateCurrentFunction], A                ;; 02:77e7 $ea $53 $d8
    ld   A, [wDialogType]                              ;; 02:77ea $fa $4a $d8
    call windowInitContents                            ;; 02:77ed $cd $93 $76
    ret                                                ;; 02:77f0 $c9

; Only checks one status each time it's called, so Pois takes a full three frames more than Moog.
; Status effect names have been lengthened from four letters to six.
windowStatusEffectInflictedDrawStatus:
    ld   HL, wStatusEffectLabelIndex                   ;; 02:77f1 $21 $8a $d8
    dec  [HL]                                          ;; 02:77f4 $35
    ld   A, [HL]                                       ;; 02:77f5 $7e
    jr   Z, windowCloseStatusEffectInflicted           ;; 02:77f6 $28 $26
    ld   HL, wStatusEffectNew                          ;; 02:77f8 $21 $5f $d8
    rlc  [HL]                                          ;; 02:77fb $cb $06
    ret  NC                                            ;; 02:77fd $d0
    ld   B, A                                          ;; 02:77fe $47
    ld   DE, $00                                       ;; 02:77ff $11 $00 $00
.loop:
    dec  B                                             ;; 02:7802 $05
    jr   Z, .break                                     ;; 02:7803 $28 $06
    ld a, $06
    add  A, E                                          ;; 02:7807 $83
    ld   E, A                                          ;; 02:7808 $5f
    jr   .loop                                         ;; 02:7809 $18 $f7
.break:
    ld   HL, statusEffectLabels                        ;; 02:780b $21 $e5 $7d
    add  HL, DE                                        ;; 02:780e $19
    ld de, $0201
    ld bc, $0601
    call drawText                                      ;; 02:7815 $cd $77 $37
    ld   A, $26                                        ;; 02:7818 $3e $26
    ld   [wMenuStateCurrentFunction], A                ;; 02:781a $ea $53 $d8
    ret                                                ;; 02:781d $c9

windowCloseStatusEffectInflicted:
    ld   A, $3a                                        ;; 02:781e $3e $3a
    ld   [wMenuStateCurrentFunction], A                ;; 02:7820 $ea $53 $d8
    call windowCloseAndRestoreHidden                   ;; 02:7823 $cd $7a $66
    ret  NZ                                            ;; 02:7826 $c0

startStatusEffectAfterWindow:
    ld   A, [wStatusEffectNew]                         ;; 02:7827 $fa $5f $d8
    push AF                                            ;; 02:782a $f5
    and  A, $0f                                        ;; 02:782b $e6 $0f
    jr   Z, .jr_02_783b                                ;; 02:782d $28 $0c
    ld   B, $12                                        ;; 02:782f $06 $12
    bit  3, A                                          ;; 02:7831 $cb $5f
    jr   NZ, .jr_02_7837                               ;; 02:7833 $20 $02
    ld   B, $1e                                        ;; 02:7835 $06 $1e
.jr_02_7837:
    ld   A, B                                          ;; 02:7837 $78
    call setTemporaryMusic                             ;; 02:7838 $cd $a8 $11
.jr_02_783b:
    pop  AF                                            ;; 02:783b $f1
    ld   C, A                                          ;; 02:783c $4f
    ld   A, [wStatusEffect]                            ;; 02:783d $fa $c0 $d7
    ld   B, A                                          ;; 02:7840 $47
    and  A, C                                          ;; 02:7841 $a1
    jr   Z, startStatusEffects                         ;; 02:7842 $28 $15
; The player already has at least one status effect that is being requested.
    ld   A, C                                          ;; 02:7844 $79
    cpl                                                ;; 02:7845 $2f
    rrca                                               ;; 02:7846 $0f
    call NC, startPoisStatusEffect                     ;; 02:7847 $d4 $a1 $78
    rrca                                               ;; 02:784a $0f
    call NC, startDarkStatusEffect                     ;; 02:784b $d4 $95 $78
    rrca                                               ;; 02:784e $0f
    call NC, startStonStatusEffect                     ;; 02:784f $d4 $89 $78
    rrca                                               ;; 02:7852 $0f
    call NC, startMoogStatusEffect                     ;; 02:7853 $d4 $7f $78
    rrca                                               ;; 02:7856 $0f
    jr   startFujiStatusEffect                         ;; 02:7857 $18 $17

; Start one or more status effect.
; b = old status effect value
; c = new status effect value
startStatusEffects:
    ld   A, B                                          ;; 02:7859 $78
    or   A, C                                          ;; 02:785a $b1
; Takes care of any palette change necessary for color.
    call setStatusEffect
    ld   A, C                                          ;; 02:785e $79
    rrca                                               ;; 02:785f $0f
    call C, startPoisStatusEffect                      ;; 02:7860 $dc $a1 $78
    rrca                                               ;; 02:7863 $0f
    call C, startDarkStatusEffect                      ;; 02:7864 $dc $95 $78
    rrca                                               ;; 02:7867 $0f
    call C, startStonStatusEffect                      ;; 02:7868 $dc $89 $78
    rrca                                               ;; 02:786b $0f
    call C, startMoogStatusEffect                      ;; 02:786c $dc $7f $78
    rrca                                               ;; 02:786f $0f

startFujiStatusEffect:
    push AF                                            ;; 02:7870 $f5
    ld   A, $01                                        ;; 02:7871 $3e $01
    ld   [wFujiStatusEffectTimeBeforeNextTick], A      ;; 02:7873 $ea $78 $d8
    ld   A, [wFujiStatusEffectTimerNumber]             ;; 02:7876 $fa $7d $d8
    call timerStart                                    ;; 02:7879 $cd $d4 $2f
    pop  AF                                            ;; 02:787c $f1
    jr   startFujiStatusEffectContinued                ;; 02:787d $18 $30

startMoogStatusEffect:
    call C, setupMoogStatusEffect                      ;; 02:787f $dc $b5 $78
    ld   A, [wMoogStatusEffectTimerNumber]             ;; 02:7882 $fa $7c $d8
    call timerStart                                    ;; 02:7885 $cd $d4 $2f
    ret                                                ;; 02:7888 $c9

startStonStatusEffect:
    push AF                                            ;; 02:7889 $f5
    call C, setStonEffectFlag                          ;; 02:788a $dc $14 $02
    ld   A, [wStonStatusEffectTimerNumber]             ;; 02:788d $fa $7b $d8
    call timerStart                                    ;; 02:7890 $cd $d4 $2f
    pop  AF                                            ;; 02:7893 $f1
    ret                                                ;; 02:7894 $c9

startDarkStatusEffect:
    push AF                                            ;; 02:7895 $f5
    call C, setDarkGraphicEffect                       ;; 02:7896 $dc $f4 $01
    ld   A, [wDarkStatusEffectTimerNumber]             ;; 02:7899 $fa $7a $d8
    call timerStart                                    ;; 02:789c $cd $d4 $2f
    pop  AF                                            ;; 02:789f $f1
    ret                                                ;; 02:78a0 $c9

startPoisStatusEffect:
    push AF                                            ;; 02:78a1 $f5
    ; Pois ticks every sixty frames.
    ; Normally this starts the first frame after being afflicted so it can instakill.
    ; By setting initial timer to just less than the period total damage is unchanged
    ; but the player gets almost a full second to react.
    ld a, 59
    ld   [wPoisStatusEffectTimeBeforeNextTick], A      ;; 02:78a4 $ea $77 $d8
    ld   A, [wPoisStatusEffectTimerNumber]             ;; 02:78a7 $fa $79 $d8
    call timerStart                                    ;; 02:78aa $cd $d4 $2f
    pop  AF                                            ;; 02:78ad $f1
    ret                                                ;; 02:78ae $c9

startFujiStatusEffectContinued:
    ld   B, $00                                        ;; 02:78af $06 $00
    call setMenuStateCurrentFunction                   ;; 02:78b1 $cd $98 $6c
    ret                                                ;; 02:78b4 $c9

setupMoogStatusEffect:
    call setMoogEffectFlag                             ;; 02:78b5 $cd $20 $02

moogleTempZeroDP:
    ld   A, [wDupTotalDP]                              ;; 02:78b8 $fa $c3 $d6
    ld   [wMoogleSavedDp], A                           ;; 02:78bb $ea $82 $d8
    xor  A, A                                          ;; 02:78be $af
    ld   [wDupTotalDP], A                              ;; 02:78bf $ea $c3 $d6
    ld   [wTotalDP], A                                 ;; 02:78c2 $ea $e0 $d7
    ret                                                ;; 02:78c5 $c9

updateStatusEffects:
    ld   A, [wMainGameState]                           ;; 02:78c6 $fa $a0 $c0
; Fix Pois/Fuji not ticking while attacking.
    cp a, $0c
    ret nc
    ld   A, [wHPHigh]                                  ;; 02:78cc $fa $b3 $d7
    ld   B, A                                          ;; 02:78cf $47
    ld   A, [wHPLow]                                   ;; 02:78d0 $fa $b2 $d7
    ld   C, A                                          ;; 02:78d3 $4f
    or   A, B                                          ;; 02:78d4 $b0
    ret  Z                                             ;; 02:78d5 $c8
    ld   A, [wStatusEffect]                            ;; 02:78d6 $fa $c0 $d7
    and  A, A                                          ;; 02:78d9 $a7
    ret  Z                                             ;; 02:78da $c8
    bit  0, A                                          ;; 02:78db $cb $47
    push AF                                            ;; 02:78dd $f5
    call NZ, tickPoisStatusEffect                      ;; 02:78de $c4 $4e $79
    pop  AF                                            ;; 02:78e1 $f1
    bit  4, A                                          ;; 02:78e2 $cb $67
    call NZ, tickFujiStatusEffect                      ;; 02:78e4 $c4 $30 $79
    ld   A, [wFujiStatusEffectTimerNumber]             ;; 02:78e7 $fa $7d $d8
    call timerCheckExpiredOrTickAllTimers              ;; 02:78ea $cd $0a $30
    call Z, endFujiStatusEffect                        ;; 02:78ed $cc $87 $79
    ld   A, [wPoisStatusEffectTimerNumber]             ;; 02:78f0 $fa $79 $d8
    call timerCheckExpiredOrTickAllTimers              ;; 02:78f3 $cd $0a $30
    call Z, endPoisStatusEffect                        ;; 02:78f6 $cc $90 $79
    ld   A, [wDarkStatusEffectTimerNumber]             ;; 02:78f9 $fa $7a $d8
    call timerCheckExpiredOrTickAllTimers              ;; 02:78fc $cd $0a $30
    call Z, endDarkStatusEffect                        ;; 02:78ff $cc $9c $79
    ld   A, [wStonStatusEffectTimerNumber]             ;; 02:7902 $fa $7b $d8
    call timerCheckExpiredOrTickAllTimers              ;; 02:7905 $cd $0a $30
    call Z, endStonStatusEffect                        ;; 02:7908 $cc $ab $79
    ld   A, [wMoogStatusEffectTimerNumber]             ;; 02:790b $fa $7c $d8
    call timerCheckExpiredOrTickAllTimers              ;; 02:790e $cd $0a $30
    call Z, endMoogStatusEffect                        ;; 02:7911 $cc $ba $79
    ld   A, [wHPHigh]                                  ;; 02:7914 $fa $b3 $d7
    ld   D, A                                          ;; 02:7917 $57
    ld   A, [wHPLow]                                   ;; 02:7918 $fa $b2 $d7
    ld   E, A                                          ;; 02:791b $5f
    ld   A, [wLightStatusEffectTimerNumber]            ;; 02:791c $fa $81 $d8
    call timerCheckExpiredOrTickAllTimers              ;; 02:791f $cd $0a $30
    call Z, endLightStatusEffect                       ;; 02:7922 $cc $26 $79
    ret                                                ;; 02:7925 $c9

endLightStatusEffect:
    ld   A, [wLightStatusEffectTimerNumber]            ;; 02:7926 $fa $81 $d8
    call timerStop                                     ;; 02:7929 $cd $ea $2f
    call conditionallySetDarkGraphicEffect             ;; 02:792c $cd $6e $11
    ret                                                ;; 02:792f $c9

tickFujiStatusEffect:
    ld   HL, wFujiStatusEffectTimeBeforeNextTick       ;; 02:7930 $21 $78 $d8
    dec  [HL]                                          ;; 02:7933 $35
    ret  NZ                                            ;; 02:7934 $c0
    ld   A, $3c                                        ;; 02:7935 $3e $3c
    ld   [HL], A                                       ;; 02:7937 $77
    call getMaxHPdiv20AndCurrentHP                     ;; 02:7938 $cd $70 $79
    add  HL, DE                                        ;; 02:793b $19
    ld   A, [wMaxHPHigh]                               ;; 02:793c $fa $b5 $d7
    ld   D, A                                          ;; 02:793f $57
    ld   A, [wMaxHPLow]                                ;; 02:7940 $fa $b4 $d7
    ld   E, A                                          ;; 02:7943 $5f
    ld   A, E                                          ;; 02:7944 $7b
    sub  A, L                                          ;; 02:7945 $95
    ld   A, D                                          ;; 02:7946 $7a
    sbc  A, H                                          ;; 02:7947 $9c
    jr   C, tickFujiPoisStatusEffectUpdateHP           ;; 02:7948 $38 $1a
    push HL                                            ;; 02:794a $e5
    pop  DE                                            ;; 02:794b $d1
    jr   tickFujiPoisStatusEffectUpdateHP              ;; 02:794c $18 $16

tickPoisStatusEffect:
    ld   HL, wPoisStatusEffectTimeBeforeNextTick       ;; 02:794e $21 $77 $d8
    dec  [HL]                                          ;; 02:7951 $35
    ret  NZ                                            ;; 02:7952 $c0
    ld   A, $3c                                        ;; 02:7953 $3e $3c
    ld   [HL], A                                       ;; 02:7955 $77
    call getMaxHPdiv20AndCurrentHP                     ;; 02:7956 $cd $70 $79
    ld   A, E                                          ;; 02:7959 $7b
    sub  A, L                                          ;; 02:795a $95
    ld   E, A                                          ;; 02:795b $5f
    ld   A, D                                          ;; 02:795c $7a
    sbc  A, H                                          ;; 02:795d $9c
    ld   D, A                                          ;; 02:795e $57
    jr   NC, tickFujiPoisStatusEffectUpdateHP          ;; 02:795f $30 $03
    ld   DE, $00                                       ;; 02:7961 $11 $00 $00

tickFujiPoisStatusEffectUpdateHP:
    ld   A, D                                          ;; 02:7964 $7a
    ld   [wHPHigh], A                                  ;; 02:7965 $ea $b3 $d7
    ld   A, E                                          ;; 02:7968 $7b
    ld   [wHPLow], A                                   ;; 02:7969 $ea $b2 $d7
    call drawHPOnStatusBar_trampoline                  ;; 02:796c $cd $29 $6f
    ret                                                ;; 02:796f $c9

; return: HL = Max HP/20, DE = Current HP
getMaxHPdiv20AndCurrentHP:
    ld   A, [wMaxHPHigh]                               ;; 02:7970 $fa $b5 $d7
    ld   H, A                                          ;; 02:7973 $67
    ld   A, [wMaxHPLow]                                ;; 02:7974 $fa $b4 $d7
    ld   L, A                                          ;; 02:7977 $6f
    ld   A, $14                                        ;; 02:7978 $3e $14
    call divMod                                        ;; 02:797a $cd $8b $2b
    inc  HL                                            ;; 02:797d $23
    ld   A, [wHPHigh]                                  ;; 02:797e $fa $b3 $d7
    ld   D, A                                          ;; 02:7981 $57
    ld   A, [wHPLow]                                   ;; 02:7982 $fa $b2 $d7
    ld   E, A                                          ;; 02:7985 $5f
    ret                                                ;; 02:7986 $c9

endFujiStatusEffect:
    ld   A, [wFujiStatusEffectTimerNumber]             ;; 02:7987 $fa $7d $d8
    ld   B, $ef                                        ;; 02:798a $06 $ef
    call clearStatusEffects                            ;; 02:798c $cd $dd $79
    ret                                                ;; 02:798f $c9

endPoisStatusEffect:
    ld   A, [wPoisStatusEffectTimerNumber]             ;; 02:7990 $fa $79 $d8
    ld   B, $fe                                        ;; 02:7993 $06 $fe
    call clearStatusEffects                            ;; 02:7995 $cd $dd $79
    call endStatusEffectMusicIfGood                    ;; 02:7998 $cd $d2 $79
    ret                                                ;; 02:799b $c9

endDarkStatusEffect:
    call removeDarkGraphicEffect                       ;; 02:799c $cd $04 $02
    ld   A, [wDarkStatusEffectTimerNumber]             ;; 02:799f $fa $7a $d8
    ld   B, $fd                                        ;; 02:79a2 $06 $fd
    call clearStatusEffects                            ;; 02:79a4 $cd $dd $79
    call endStatusEffectMusicIfGood                    ;; 02:79a7 $cd $d2 $79
    ret                                                ;; 02:79aa $c9

endStonStatusEffect:
    call removeStonEffectFlag                          ;; 02:79ab $cd $1a $02
    ld   A, [wStonStatusEffectTimerNumber]             ;; 02:79ae $fa $7b $d8
    ld   B, $fb                                        ;; 02:79b1 $06 $fb
.clear:
    call clearStatusEffects                            ;; 02:79b3 $cd $dd $79
    call endStatusEffectMusicIfGood                    ;; 02:79b6 $cd $d2 $79
    ret                                                ;; 02:79b9 $c9

endMoogStatusEffect:
; Fix the notorious Heal-zero-DP bug.
; What was happening was attempting to clear the Moog condition would load the last saved DP.
; If you hadn't been turned into a moogle previously then this value was zero.
    ld hl, wPlayerSpecialFlags
    bit 3, [hl]
    ret z
    res 3, [hl]
    ld   A, [wMoogleSavedDp]                           ;; 02:79bd $fa $82 $d8
    ld   [wDupTotalDP], A                              ;; 02:79c0 $ea $c3 $d6
    ld   [wTotalDP], A                                 ;; 02:79c3 $ea $e0 $d7
    ld   A, [wMoogStatusEffectTimerNumber]             ;; 02:79c6 $fa $7c $d8
    ld   B, $f7                                        ;; 02:79c9 $06 $f7
    jr endStonStatusEffect.clear

endStatusEffectMusicIfGood:
    push BC                                            ;; 02:79d2 $c5
    ld   A, [wStatusEffect]                            ;; 02:79d3 $fa $c0 $d7
    and  A, $0f                                        ;; 02:79d6 $e6 $0f
    call Z, clearTemporaryMusic                        ;; 02:79d8 $cc $b1 $11
    pop  BC                                            ;; 02:79db $c1
    ret                                                ;; 02:79dc $c9

; Clear a status effects.
; a = timer number
; b = complement of the status bit to be cleared
clearStatusEffects:
    call timerStop                                     ;; 02:79dd $cd $ea $2f
    ld a, [wStatusEffect]
    and b
    jp setStatusEffect

pauseTimers:
    ld   HL, wPoisStatusEffectTimerNumber              ;; 02:79e7 $21 $79 $d8
    ld   B, $05                                        ;; 02:79ea $06 $05
.loop:
    ld   A, [HL+]                                      ;; 02:79ec $2a
    call timerDeactivate                               ;; 02:79ed $cd $f6 $2f
    dec  B                                             ;; 02:79f0 $05
    jr   NZ, .loop                                     ;; 02:79f1 $20 $f9
    ld   A, [wSlepTimerNumber]                         ;; 02:79f3 $fa $60 $cf
    call timerDeactivate                               ;; 02:79f6 $cd $f6 $2f
    ld   A, [wMuteTimerNumber]                         ;; 02:79f9 $fa $61 $cf
    call timerDeactivate                               ;; 02:79fc $cd $f6 $2f
    ret                                                ;; 02:79ff $c9

unpauseTimers:
    ld   A, [wStatusEffect]                            ;; 02:7a00 $fa $c0 $d7
    ld   C, A                                          ;; 02:7a03 $4f
    ld   B, $05                                        ;; 02:7a04 $06 $05
    ld   HL, wPoisStatusEffectTimerNumber              ;; 02:7a06 $21 $79 $d8
.loop:
    ld   A, [HL+]                                      ;; 02:7a09 $2a
    rrc  C                                             ;; 02:7a0a $cb $09
    call C, timerActivate                              ;; 02:7a0c $dc $00 $30
    dec  B                                             ;; 02:7a0f $05
    jr   NZ, .loop                                     ;; 02:7a10 $20 $f7
    ld   A, [wMuteTimerNumber]                         ;; 02:7a12 $fa $61 $cf
    call timerActivate                                 ;; 02:7a15 $cd $00 $30
    ld   A, [wSlepTimerNumber]                         ;; 02:7a18 $fa $60 $cf
    call timerActivate                                 ;; 02:7a1b $cd $00 $30
    ret                                                ;; 02:7a1e $c9

; Used by ITEMS and MAGIC windows if you try to select an empty slot
playWindowErrorSound:
    push AF                                            ;; 02:7a1f $f5
    ld   A, $0e                                        ;; 02:7a20 $3e $0e
    call playSFX                                       ;; 02:7a22 $cd $7d $29
    pop  AF                                            ;; 02:7a25 $f1
    ret                                                ;; 02:7a26 $c9

hideFullscreenWindow:
    call enableStatusBarEffect                         ;; 02:7a27 $cd $3a $7a
    ld   A, [wVideoWYBackup]                           ;; 02:7a2a $fa $84 $d8
    ld   [wVideoWY], A                                 ;; 02:7a2d $ea $a9 $c0
    ld   DE, $00                                       ;; 02:7a30 $11 $00 $00
    ld   HL, $1214                                     ;; 02:7a33 $21 $14 $12
    call showSpritesBehindWindow
    ret                                                ;; 02:7a39 $c9

enableStatusBarEffect:
    push DE                                            ;; 02:7a3a $d5
    ld   D, $8e                                        ;; 02:7a3b $16 $8e
    ld   E, $7e                                        ;; 02:7a3d $1e $7e
    call lcdcEffectChangeLYC                           ;; 02:7a3f $cd $4e $7a
    pop  DE                                            ;; 02:7a42 $d1
    ret                                                ;; 02:7a43 $c9

; If there's a window open (like the SELECT window) it would be inconvenient to have its sprites hidden.
disableStatusBarEffect:
    push DE                                            ;; 02:7a44 $d5
    ld   D, $7e                                        ;; 02:7a45 $16 $7e
    ld   E, $8e                                        ;; 02:7a47 $1e $8e
    call lcdcEffectChangeLYC                           ;; 02:7a49 $cd $4e $7a
    pop  DE                                            ;; 02:7a4c $d1
    ret                                                ;; 02:7a4d $c9

; Used to hide/show the status bar
; D = search (old) value
; E = new value
lcdcEffectChangeLYC:
    push HL                                            ;; 02:7a4e $e5
    push BC                                            ;; 02:7a4f $c5
    ld   HL, wLCDCEffectBuffer                         ;; 02:7a50 $21 $a0 $d3
    ld   B, $10                                        ;; 02:7a53 $06 $10
.loop:
    ld   A, [HL+]                                      ;; 02:7a55 $2a
    cp   A, D                                          ;; 02:7a56 $ba
    jr   Z, .change                                    ;; 02:7a57 $28 $09
    inc  HL                                            ;; 02:7a59 $23
    inc  HL                                            ;; 02:7a5a $23
    inc  HL                                            ;; 02:7a5b $23
    dec  B                                             ;; 02:7a5c $05
    jr   NZ, .loop                                     ;; 02:7a5d $20 $f6
    pop  BC                                            ;; 02:7a5f $c1
    pop  HL                                            ;; 02:7a60 $e1
    ret                                                ;; 02:7a61 $c9
.change:
    dec  HL                                            ;; 02:7a62 $2b
    ld   [HL], E                                       ;; 02:7a63 $73
    pop  BC                                            ;; 02:7a64 $c1
    pop  HL                                            ;; 02:7a65 $e1
    ret                                                ;; 02:7a66 $c9

; Return: e=x, d=y, c=width, b=height
; Return: HL = beginning of window backup buffer
getWindowDimensions:
    ld   HL, wDialogX                                  ;; 02:7a67 $21 $a7 $d4
    ld   E, [HL]                                       ;; 02:7a6a $5e
    inc  HL                                            ;; 02:7a6b $23
    ld   D, [HL]                                       ;; 02:7a6c $56
    inc  HL                                            ;; 02:7a6d $23
    ld   C, [HL]                                       ;; 02:7a6e $4e
    inc  HL                                            ;; 02:7a6f $23
    ld   B, [HL]                                       ;; 02:7a70 $46
    inc  HL                                            ;; 02:7a71 $23
    ret                                                ;; 02:7a72 $c9

; x=e, y=d, width=c, height=b
; Also, the final value of HL is used as a pointer to a buffer to back up the background
setWindowDimensions:
    ld   HL, wDialogX                                  ;; 02:7a73 $21 $a7 $d4
    ld   [HL], E                                       ;; 02:7a76 $73
    inc  HL                                            ;; 02:7a77 $23
    ld   [HL], D                                       ;; 02:7a78 $72
    inc  HL                                            ;; 02:7a79 $23
    ld   [HL], C                                       ;; 02:7a7a $71
    inc  HL                                            ;; 02:7a7b $23
    ld   [HL], B                                       ;; 02:7a7c $70
    inc  HL                                            ;; 02:7a7d $23
    ret                                                ;; 02:7a7e $c9

; Loading a save writes some data into the third temporary script.
; This copies it and adds opcodes to turn it into a real script.
loadSRAMCreateInitScript:
    ld   DE, wOpenChestScript3                         ;; 02:7a7f $11 $33 $d6
; $f4 = sLOAD_ROOM
    ld   A, $f4                                        ;; 02:7a82 $3e $f4
    ld   [HL+], A                                      ;; 02:7a84 $22
    ld   B, $04                                        ;; 02:7a85 $06 $04
.loop:
    ld   A, [DE]                                       ;; 02:7a87 $1a
    ld   [HL+], A                                      ;; 02:7a88 $22
    inc  DE                                            ;; 02:7a89 $13
    dec  B                                             ;; 02:7a8a $05
    jr   NZ, .loop                                     ;; 02:7a8b $20 $fa
    inc  DE                                            ;; 02:7a8d $13
    ld   A, [DE]                                       ;; 02:7a8e $1a
    inc  DE                                            ;; 02:7a8f $13
    ld   B, A                                          ;; 02:7a90 $47
; $f8 = sSET_MUSIC
    ld   A, $f8                                        ;; 02:7a91 $3e $f8
    ld   [HL+], A                                      ;; 02:7a93 $22
    ld   [HL], B                                       ;; 02:7a94 $70
    inc  HL                                            ;; 02:7a95 $23
    call loadSRAMInitScriptDisplayMetatile             ;; 02:7a96 $cd $a8 $7a
    ld   A, B                                          ;; 02:7a99 $78
    srl  A                                             ;; 02:7a9a $cb $3f
    ld   [HL+], A                                      ;; 02:7a9c $22
    inc  HL                                            ;; 02:7a9d $23
    call loadSRAMInitScriptDisplayMetatile             ;; 02:7a9e $cd $a8 $7a
    ld   A, B                                          ;; 02:7aa1 $78
    inc  A                                             ;; 02:7aa2 $3c
    srl  A                                             ;; 02:7aa3 $cb $3f
    ld   [HL+], A                                      ;; 02:7aa5 $22
    inc  HL                                            ;; 02:7aa6 $23
    ret                                                ;; 02:7aa7 $c9

; Adds a script opcode to display a metatile
; Then adds the tile number and the y coordinate (but not the x).
; Return: B = x coordinate
loadSRAMInitScriptDisplayMetatile:
; $b0 = sSET_ROOM_TILE
    ld   A, $b0                                        ;; 02:7aa8 $3e $b0
    ld   [HL+], A                                      ;; 02:7aaa $22
    ld   A, [DE]                                       ;; 02:7aab $1a
    inc  DE                                            ;; 02:7aac $13
    push DE                                            ;; 02:7aad $d5
    ld   [HL+], A                                      ;; 02:7aae $22
    ld   DE, wOpenChestScript1._3                      ;; 02:7aaf $11 $16 $d6
    ld   A, [DE]                                       ;; 02:7ab2 $1a
    inc  DE                                            ;; 02:7ab3 $13
    ld   B, A                                          ;; 02:7ab4 $47
    ld   A, [DE]                                       ;; 02:7ab5 $1a
    ld   C, A                                          ;; 02:7ab6 $4f
    inc  HL                                            ;; 02:7ab7 $23
    inc  C                                             ;; 02:7ab8 $0c
    srl  C                                             ;; 02:7ab9 $cb $39
    ld   [HL], C                                       ;; 02:7abb $71
    dec  HL                                            ;; 02:7abc $2b
    pop  DE                                            ;; 02:7abd $d1
    ret                                                ;; 02:7abe $c9

; Checks whether you are standing in a doorway and if so generates an open door script command for it.
loadSRAMInitScriptOpenDoorIfInDoorway:
    push HL                                            ;; 02:7abf $e5
    ld   A, [wOpenChestScript1._4]                     ;; 02:7ac0 $fa $17 $d6
    ld   D, A                                          ;; 02:7ac3 $57
    ld   A, [wOpenChestScript1._3]                     ;; 02:7ac4 $fa $16 $d6
    ld   E, A                                          ;; 02:7ac7 $5f
; $e0 = sOPEN_NORTH_DOOR
    ld   C, $e0                                        ;; 02:7ac8 $0e $e0
    ld   B, $04                                        ;; 02:7aca $06 $04
    ld   HL, .doorTileLocations                        ;; 02:7acc $21 $ed $7a
.loop_outer:
    push BC                                            ;; 02:7acf $c5
.loop_inner:
    ld   C, [HL]                                       ;; 02:7ad0 $4e
    inc  HL                                            ;; 02:7ad1 $23
    ld   B, [HL]                                       ;; 02:7ad2 $46
    inc  HL                                            ;; 02:7ad3 $23
    ld   A, B                                          ;; 02:7ad4 $78
    or   A, C                                          ;; 02:7ad5 $b1
    jr   Z, .break_inner                               ;; 02:7ad6 $28 $0d
    ld   A, B                                          ;; 02:7ad8 $78
    cp   A, D                                          ;; 02:7ad9 $ba
    jr   NZ, .loop_inner                               ;; 02:7ada $20 $f4
    ld   A, C                                          ;; 02:7adc $79
    cp   A, E                                          ;; 02:7add $bb
    jr   NZ, .loop_inner                               ;; 02:7ade $20 $f0
    pop  BC                                            ;; 02:7ae0 $c1
    pop  HL                                            ;; 02:7ae1 $e1
    ld   [HL], C                                       ;; 02:7ae2 $71
    inc  HL                                            ;; 02:7ae3 $23
    ret                                                ;; 02:7ae4 $c9
.break_inner:
    pop  BC                                            ;; 02:7ae5 $c1
    inc  C                                             ;; 02:7ae6 $0c
    inc  C                                             ;; 02:7ae7 $0c
    dec  B                                             ;; 02:7ae8 $05
    jr   NZ, .loop_outer                               ;; 02:7ae9 $20 $e4
    pop  HL                                            ;; 02:7aeb $e1
    ret                                                ;; 02:7aec $c9
.doorTileLocations:
    db   $09, $00, $09, $ff, $00, $00, $09, $0d        ;; 02:7aed ????????
    db   $09, $0e, $09, $0f, $00, $00, $11, $06        ;; 02:7af5 ????????
    db   $12, $06, $13, $06, $11, $07, $12, $07        ;; 02:7afd ????????
    db   $13, $07, $00, $00, $ff, $06, $00, $06        ;; 02:7b05 ????????
    db   $01, $06, $ff, $07, $00, $07, $01, $07        ;; 02:7b0d ????????
    db   $00, $00                                      ;; 02:7b15 ??

itemsListCure:
    db   $01, $09, $0a, $0b, $0c, $0d, $1d, $00        ;; 02:7b17 ........

itemsListHealStatus:
    db   $02, $0e, $0f, $10, $11, $12, $00             ;; 02:7b1f .......

itemsListBuff:
    db   $34, $35, $36, $37, $00                       ;; 02:7b26 .....

itemsListSleep:
    db   $04, $14, $00                                 ;; 02:7b2b ...

itemsListMute:
    db   $03, $13, $00                                 ;; 02:7b2e ...

; Unused items "Torch" and "Dwarf Lamp"
; Seem to be unusable despite some code checking for them
itemsListLights:
    db   $38, $39, $00                                 ;; 02:7b31 ...

itemsListCrystal:
    db   $32, $00                                      ;; 02:7b34 ..

itemsListDamage:
    db   $05, $07, $08, $17, $18, $00                  ;; 02:7b36 ......

titleScreenInit:
    ld   A, $11                                        ;; 02:7b3c $3e $11
    ld   [wMainGameState], A                           ;; 02:7b3e $ea $a0 $c0
; A delay before drawing the text on the title screen.
; Possibly to allow time for the title graphic to load completely.
; Originally this was a full second, but it has been reduced to half that.
    ld a, $1e
    ld   [wTitleScreenDelay], A                        ;; 02:7b43 $ea $8c $d8
    ld   HL, sSave1Header                              ;; 02:7b46 $21 $00 $a0
    ld   A, $08                                        ;; 02:7b49 $3e $08
    call checkSaveGameIntegrity                        ;; 02:7b4b $cd $7c $74
    ld   A, E                                          ;; 02:7b4e $7b
    ld   [wRndState0], A                               ;; 02:7b4f $ea $b0 $c0
    ld   HL, sSave2Header                              ;; 02:7b52 $21 $00 $a1
    ld   A, $10                                        ;; 02:7b55 $3e $10
    call checkSaveGameIntegrity                        ;; 02:7b57 $cd $7c $74
    ld   A, E                                          ;; 02:7b5a $7b
    ld   [wRndState1], A                               ;; 02:7b5b $ea $b1 $c0
    ld   HL, wOpenChestScript1                         ;; 02:7b5e $21 $13 $d6
    ld   DE, startTitleScreenMusicScript               ;; 02:7b61 $11 $9c $7b
.loop:
    ld   A, [DE]                                       ;; 02:7b64 $1a
    ld   [HL+], A                                      ;; 02:7b65 $22
    inc  DE                                            ;; 02:7b66 $13
    and  A, A                                          ;; 02:7b67 $a7
    jr   NZ, .loop                                     ;; 02:7b68 $20 $fa
; Load the title screen "map"
    ld   A, $07                                        ;; 02:7b6a $3e $07
    ld   DE, $101                                      ;; 02:7b6c $11 $01 $01
    call loadMapGraphics
    call drawRoomWithGuardOnTileTransfer
    ld   HL, wVideoWY                                  ;; 02:7b75 $21 $a9 $c0
    ld   A, [HL]                                       ;; 02:7b78 $7e
    ld   [wVideoWYBackup], A                           ;; 02:7b79 $ea $84 $d8
    ld   A, $ff                                        ;; 02:7b7c $3e $ff
    ld   [HL], A                                       ;; 02:7b7e $77
    ld   A, $04                                        ;; 02:7b7f $3e $04
    ld   [wTitleScreenState], A                        ;; 02:7b81 $ea $86 $d8
    ret                                                ;; 02:7b84 $c9

titleScreenShowMenu:
    ld   HL, wTitleScreenDelay                         ;; 02:7b85 $21 $8c $d8
    dec  [HL]                                          ;; 02:7b88 $35
    ret  NZ                                            ;; 02:7b89 $c0
    ld   A, $0f                                        ;; 02:7b8a $3e $0f
    ld   [wMainGameState], A                           ;; 02:7b8c $ea $a0 $c0
    ld   A, WINDOW_TITLE_SCREEN                        ;; 02:7b8f $3e $1f
    ld   [wDialogType], A                              ;; 02:7b91 $ea $4a $d8
    call gameStateMenu                                 ;; 02:7b94 $cd $60 $48
    xor  A, A                                          ;; 02:7b97 $af
    ld   [wTitleScreenState], A                        ;; 02:7b98 $ea $86 $d8
    ret                                                ;; 02:7b9b $c9

; This is a short script used to start the music on the title screen
startTitleScreenMusicScript:
    sSET_MUSIC 1
    sEND

menuSelectionTitleScreen:
    call hideAndSaveMenuMetasprites                    ;; 02:7b9f $cd $51 $6b
    ld   A, $7f                                        ;; 02:7ba2 $3e $7f
    ld   B, $3c                                        ;; 02:7ba4 $06 $3c
    ld   HL, wWindowBackgroundSaveBuffer               ;; 02:7ba6 $21 $ab $d4
.loop:
    ld   [HL+], A                                      ;; 02:7ba9 $22
    dec  B                                             ;; 02:7baa $05
    jr   NZ, .loop                                     ;; 02:7bab $20 $fc
    ld   A, [wSelectedMenuIndex]                       ;; 02:7bad $fa $4b $d8
    and  A, A                                          ;; 02:7bb0 $a7
    jr   NZ, .continue                                 ;; 02:7bb1 $20 $10
.new_game:
    xor  A, A                                          ;; 02:7bb3 $af
    ld   [wMenuStateCurrentFunction], A                ;; 02:7bb4 $ea $53 $d8
    ld   A, [wMainGameState]                           ;; 02:7bb7 $fa $a0 $c0
    ld   [wWindowMainGameStateBackup], A               ;; 02:7bba $ea $62 $d8
    ld   A, $11                                        ;; 02:7bbd $3e $11
    ld   [wMainGameState], A                           ;; 02:7bbf $ea $a0 $c0
    ret                                                ;; 02:7bc2 $c9
.continue:
    ld   A, [wWindowFlags]                             ;; 02:7bc3 $fa $74 $d8
    and  A, $18                                        ;; 02:7bc6 $e6 $18
    jr   Z, .new_game                                  ;; 02:7bc8 $28 $e9
    ld   A, [wVideoWYBackup]                           ;; 02:7bca $fa $84 $d8
    ld   [wVideoWY], A                                 ;; 02:7bcd $ea $a9 $c0
    ld   A, $0f                                        ;; 02:7bd0 $3e $0f
    ld   [wMainGameState], A                           ;; 02:7bd2 $ea $a0 $c0
    ld   B, $35                                        ;; 02:7bd5 $06 $35
    call setMenuStateCurrentFunction                   ;; 02:7bd7 $cd $98 $6c
    jp   openLoadScreen                                ;; 02:7bda $c3 $dd $71

gameStateTitleScreen:
    ld   A, [wTitleScreenState]                        ;; 02:7bdd $fa $86 $d8
    ld   HL, .titleScreenStatesJumptable               ;; 02:7be1 $21 $ec $7b
    jp   callJumptable
;@jumptable
.titleScreenStatesJumptable:
    dw   titleScreenIntroScrollStart                   ;; 02:7bec pP $00
    dw   titleScreenIntroScrollPrintLine               ;; 02:7bee pP $01
    dw   titleScreenIntroScrollLoop                    ;; 02:7bf0 pP $02
    dw   titleScreenIntroScrollInterupted              ;; 02:7bf2 pP $03
    dw   titleScreenShowMenu                           ;; 02:7bf4 pP $04

; Free space
db $00, $00, $00, $00, $00, $00

; Called when New Game is selected
titleScreenIntroScrollStart:
    ld   HL, wVideoSCY                                 ;; 02:7bf6 $21 $a7 $c0
    ld   A, [HL]                                       ;; 02:7bf9 $7e
    ld   [wIntroScrollSCYBackup], A                    ;; 02:7bfa $ea $88 $d8
    xor  A, A                                          ;; 02:7bfd $af
    ld   [HL], A                                       ;; 02:7bfe $77
    ld   [wMenuFlags], A                               ;; 02:7bff $ea $49 $d8
    ld   DE, $01                                       ;; 02:7c02 $11 $01 $00
    ld   BC, $1301                                     ;; 02:7c05 $01 $01 $13
    call setWindowDimensions                           ;; 02:7c08 $cd $73 $7a
    ld   BC, $1301                                     ;; 02:7c0b $01 $01 $13
    ld   A, B                                          ;; 02:7c0e $78
    ld   [wWindowTextLength], A                        ;; 02:7c0f $ea $9b $d8
    ld   A, C                                          ;; 02:7c12 $79
    ld   [wWindowTextRows], A                          ;; 02:7c13 $ea $9a $d8
    ld   DE, $1601                                     ;; 02:7c16 $11 $01 $16
    ld   A, D                                          ;; 02:7c19 $7a
    ld   [wRegisterSave2.D], A                         ;; 02:7c1a $ea $ad $d8
    ld   A, E                                          ;; 02:7c1d $7b
    ld   [wRegisterSave2.E], A                         ;; 02:7c1e $ea $ac $d8
    ld   HL, intoScrollText                            ;; 02:7c21 $21 $8a $7e
    ld   A, H                                          ;; 02:7c24 $7c
    ld   [wIntroScrollTextPointer.high], A             ;; 02:7c25 $ea $8f $d8
    ld   A, L                                          ;; 02:7c28 $7d
    ld   [wIntroScrollTextPointer], A                  ;; 02:7c29 $ea $8e $d8
    ld   A, $01                                        ;; 02:7c2c $3e $01
    ld   [wTitleScreenState], A                        ;; 02:7c2e $ea $86 $d8
    ld   A, $0f                                        ;; 02:7c31 $3e $0f
    ld   [wIntroScrollCounter2], A                     ;; 02:7c33 $ea $87 $d8
    ld   A, $05                                        ;; 02:7c36 $3e $05
    ld   [wIntroScrollCounter1], A                     ;; 02:7c38 $ea $89 $d8
    call prepareIntroScrollEffect_trampoline           ;; 02:7c3b $cd $aa $0d
    ret                                                ;; 02:7c3e $c9

titleScreenIntroScrollPrintLine:
    ld   A, [wIntroScrollTextPointer.high]             ;; 02:7c3f $fa $8f $d8
    ld   H, A                                          ;; 02:7c42 $67
    ld   A, [wIntroScrollTextPointer]                  ;; 02:7c43 $fa $8e $d8
    ld   L, A                                          ;; 02:7c46 $6f
    ld   A, [HL]                                       ;; 02:7c47 $7e
    cp   A, $01                                        ;; 02:7c48 $fe $01
    jp   Z, titleScreenIntroScrollEnd                  ;; 02:7c4a $ca $d8 $7c
    ld   BC, $1301                                     ;; 02:7c4d $01 $01 $13
    ld   A, [wRegisterSave2.D]                         ;; 02:7c50 $fa $ad $d8
    ld   D, A                                          ;; 02:7c53 $57
    ld   A, [wRegisterSave2.E]                         ;; 02:7c54 $fa $ac $d8
    ld   E, A                                          ;; 02:7c57 $5f
    dec  E                                             ;; 02:7c58 $1d
    dec  E                                             ;; 02:7c59 $1d
    ld   A, $7f                                        ;; 02:7c5a $3e $7f
    call storeTileAatDialogPositionDE                  ;; 02:7c5c $cd $44 $38
    inc  E                                             ;; 02:7c5f $1c
    call drawText                                      ;; 02:7c60 $cd $77 $37
    ld   A, H                                          ;; 02:7c63 $7c
    ld   [wIntroScrollTextPointer.high], A             ;; 02:7c64 $ea $8f $d8
    ld   A, L                                          ;; 02:7c67 $7d
    ld   [wIntroScrollTextPointer], A                  ;; 02:7c68 $ea $8e $d8
    ld   A, WINDOW_INTRO_SCROLL                        ;; 02:7c6b $3e $ff
    ld   [wDialogType], A                              ;; 02:7c6d $ea $4a $d8
    ld   A, [wRegisterSave2.D]                         ;; 02:7c70 $fa $ad $d8
    ld   D, A                                          ;; 02:7c73 $57
    ld   A, [wRegisterSave2.E]                         ;; 02:7c74 $fa $ac $d8
    ld   E, A                                          ;; 02:7c77 $5f
    ld   A, D                                          ;; 02:7c78 $7a
    cp   A, $1f                                        ;; 02:7c79 $fe $1f
    jr   C, .jr_02_7c7f                                ;; 02:7c7b $38 $02
    ld   D, $00                                        ;; 02:7c7d $16 $00
.jr_02_7c7f:
    ld   E, $01                                        ;; 02:7c7f $1e $01
    ld   A, D                                          ;; 02:7c81 $7a
    ld   [wRegisterSave2.D], A                         ;; 02:7c82 $ea $ad $d8
    ld   A, E                                          ;; 02:7c85 $7b
    ld   [wRegisterSave2.E], A                         ;; 02:7c86 $ea $ac $d8
    ld   A, $02                                        ;; 02:7c89 $3e $02
    ld   [wTitleScreenState], A                        ;; 02:7c8b $ea $86 $d8
    ret                                                ;; 02:7c8e $c9

titleScreenIntroScrollLoop:
; Joypad input is in d.
    bit 4, d
    jr   NZ, .a_button                                 ;; 02:7c94 $20 $25
    ld   HL, wIntroScrollCounter1                      ;; 02:7c96 $21 $89 $d8
    dec  [HL]                                          ;; 02:7c99 $35
    ret  NZ                                            ;; 02:7c9a $c0
    ld   A, $05                                        ;; 02:7c9b $3e $05
    ld   [HL], A                                       ;; 02:7c9d $77
    call introScrollEffectUpdateLCDEffect_trampoline   ;; 02:7c9e $cd $b0 $0d
    ld   A, [wVideoSCY]                                ;; 02:7ca1 $fa $a7 $c0
    inc  A                                             ;; 02:7ca4 $3c
    ld   [wVideoSCY], A                                ;; 02:7ca5 $ea $a7 $c0
    ld   A, [wIntroScrollCounter2]                     ;; 02:7ca8 $fa $87 $d8
    dec  A                                             ;; 02:7cab $3d
    ld   [wIntroScrollCounter2], A                     ;; 02:7cac $ea $87 $d8
    ret  NZ                                            ;; 02:7caf $c0
    ld   A, $0f                                        ;; 02:7cb0 $3e $0f
    ld   [wIntroScrollCounter2], A                     ;; 02:7cb2 $ea $87 $d8
    ld   A, $01                                        ;; 02:7cb5 $3e $01
    ld   [wTitleScreenState], A                        ;; 02:7cb7 $ea $86 $d8
    ret                                                ;; 02:7cba $c9
.a_button:
    ld b, $12
    ld hl, _SCRN0
    call clearVRAMArea                                 ;; 02:7cc0 $cd $6a $56
    ld   A, $03                                        ;; 02:7cc3 $3e $03
    ld   [wTitleScreenState], A                        ;; 02:7cc5 $ea $86 $d8
    ret                                                ;; 02:7cc8 $c9

ds 3 ; Free space

titleScreenIntroScrollInterupted:
    ld   A, [wIntroScrollSCYBackup]                    ;; 02:7cc9 $fa $88 $d8
    ld   [wVideoSCY], A                                ;; 02:7ccc $ea $a7 $c0
    call windowCloseAndRestoreHidden                   ;; 02:7ccf $cd $7a $66
    ld   A, [wMenuStateCurrentFunction]                ;; 02:7cd2 $fa $53 $d8
    and  A, $80                                        ;; 02:7cd5 $e6 $80
    ret  NZ                                            ;; 02:7cd7 $c0

titleScreenIntroScrollEnd:
    xor  A, A                                          ;; 02:7cd8 $af
    ld   [wTitleScreenState], A                        ;; 02:7cd9 $ea $86 $d8
    ld   A, [wVideoWYBackup]                           ;; 02:7cdc $fa $84 $d8
    ld   [wVideoWY], A                                 ;; 02:7cdf $ea $a9 $c0
    ld   A, [wWindowMainGameStateBackup]               ;; 02:7ce2 $fa $62 $d8
    ld   [wMainGameState], A                           ;; 02:7ce5 $ea $a0 $c0
    call setDefaultLCDEffectAndBGP_trampoline          ;; 02:7ce8 $cd $b6 $0d
    ld   HL, $03                                       ;; 02:7ceb $21 $03 $00
    ld   C, $c9                                        ;; 02:7cee $0e $c9
    ld   A, $08                                        ;; 02:7cf0 $3e $08
    call runScriptByIndex                              ;; 02:7cf2 $cd $ad $31
    ret                                                ;; 02:7cf5 $c9

;@ffa_text size=5 amount=3
startMenuOptions:
    TXT  "ITEM<00>"                                    ;; 02:7cf6 .....
    TXT  "MAGIC"                                       ;; 02:7cfb .....
    TXT  "EQUIP"                                       ;; 02:7d00 .....
;@ffa_text
    TXT  "ASK<00>"                                     ;; 02:7d05 ....

;@ffa_text size=15
selectMenuOptions:
    TXT  "Save\nMap\nStatus"                           ;; 02:7d09 ...............

;@ffa_text amount=6
levelUpStatOptions:
    TXT  "Warrior"
    TXT  "Wizard<00>"
    TXT  "Monk<00>Sage<00><00>"

yesNoOptions:
    TXT  "Yes<00>"                                     ;; 02:7d31 ....
    TXT  "No<00>"                                      ;; 02:7d35 ...

levelUpText1:
    TXT  "   Level up!\nHP/MP recovered!<00>"          ;; 02:7d38 ..............................

;@ffa_text size=7
vendorBoughtText:
    TXT  "Bought "                                     ;; 02:7d56 .......

;@ffa_text amount=2
venderGreetingText:
    TXT  "Hello!<00>"                                  ;; 02:7d5d .......
    TXT  "May I help you?<00>"                         ;; 02:7d64 ................
    db   $00, $00                                      ;; 02:7d74 ..

;@ffa_text amount=2
venderNotEnoughMoneyText:
    TXT  "Not enough lucre!"                           ;; 02:7d76 ?????????????????

;@ffa_text
venderConfirmSell:
    TXT  "SellNo<00>"                                  ;; 02:7d87 .......

;@ffa_text size=4 amount=3
vendorOptions:
    TXT  "Buy<00>"                                     ;; 02:7d8e ....
    TXT  "Sell"                                        ;; 02:7d92 ....
    TXT  "Exit"                                        ;; 02:7d96 ....

;@ffa_text size=2
statusScreenGoldLabel:
    TXT  " <LUCRE>"                                    ;; 02:7d9a ..

;@ffa_text amount=4
statusScreenStatLabels:
    TXT  "Stamn<00>"                                   ;; 02:7d9c ......
    TXT  "Power<00>"                                   ;; 02:7da2 ......
    TXT  "Wisdm<00>"                                   ;; 02:7da8 ......
    TXT  "Will<00>"                                    ;; 02:7dae .....

;@ffa_text size=9
statusScreenHPLabel:
    TXT  "HP   /   "                                   ;; 02:7db3 .........

;@ffa_text size=6
statusScreenMPLabel:
    TXT  "MP   /"                                      ;; 02:7dbc ......

;@ffa_text
levelUpText2:
    TXT  " Level up! Selectyour job type.<00><00><00><00>"

; Expanded from four letters to six.
;@ffa_text size=6 amount=5
statusEffectLabels:
    TXT  "Poison"
    TXT  "Blind<00>"
    TXT  "Stone<00>"
    TXT  "Moogle"
    TXT  " Good<00>"

;@ffa_text size=4 amount=1
nameLabel:
    TXT  "Name:"                                        ;; 02:7df9 ....

;@ffa_text size=9 amount=9
nameEntryInputOptions:
    TXT  "ABCDEFGHI"                                   ;; 02:7e01 .........
    TXT  "JKLMNOPQR"                                   ;; 02:7e0a .........
    TXT  "STUVWXYZ "                                   ;; 02:7e13 .........
    TXT  "abcdefghi"                                   ;; 02:7e1c .........
    TXT  "jklmnopqr"                                   ;; 02:7e25 .........
    TXT  "stuvwxyz "                                   ;; 02:7e2e .........
    TXT  "',._-!?:/"                                   ;; 02:7e37 .........
    TXT  "01234    "                                   ;; 02:7e40 .........
    TXT  "56789   <SPEL>"                              ;; 02:7e49 .........

;@ffa_text size=8 amount=2
titleScreenOptions:
    TXT  "New Game"                                    ;; 02:7e52 ........
    TXT  "Continue"                                    ;; 02:7e5a ........

;@ffa_text size=20 amount=2
titleScreenLicenseText:
    TXT STRFMT("hack date %u-%02u-%02u", __UTC_YEAR__, __UTC_MONTH__, __UTC_DAY__)
    TXT  "<00><COPYRIGHT> 1991 SQUARE SOFT\n"                 ;; 02:7e76 ....................

intoScrollText:
    TXT " At a shrine atop<00>"
    TXT "Mt. Illusia, above<00>"
    TXT "the clouds, stands<00>"
    TXT "  the Mana Tree.<00>"
    TXT "<00>"
    TXT "Nurtured by energy<00>"
    TXT "from everything in<00>"
    TXT "    the cosmos.<00>"
    TXT "<00>"
    TXT "Legend tells that<00>"
    TXT "touching it grants<00>"
    TXT "  eternal power_<00>"
    TXT "<00>"
    TXT "Shadow Knight, the<00>"
    TXT "ruler of Granz, is<00>"
    TXT "planning a bloody<00>"
    TXT "world conquest and<00>"
    TXT "seeks that power.<00>"
    TXT "<00>"
    TXT "<00>"
    TXT "<00>"
    TXT "<00>"
    TXT "<00>"
    TXT "<00>"
    TXT "<00>"
    TXT "<00>"
    TXT "<00>"
    TXT "<00>"
    TXT "<00>"
    TXT "<00>"
    TXT "<00>"
    TXT "<01>"

; Free space
ds 72
