;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"

SCRIPT_BANK_1 EQU $12

; Start of the first script bank.
SECTION "script bank 1", ROMX[$4000], BANK[SCRIPT_BANK_1]

script_0000:
    sEND                                               ;; 0d:4000 $00

script_0001:
    sIF_FLAG wScriptFlags.1                            ;; 0d:4001 $08 $01 $00 $05
      sSFX 16                                          ;; 0d:4005 $f9 $10
      sOPEN_EAST_DOOR                                  ;; 0d:4007 $e4
    sELSE                                              ;; 0d:4008 $01 $19
      sIF_FLAG wScriptFlags.2                          ;; 0d:400a $08 $02 $00 $05
        sSFX 16                                        ;; 0d:400e $f9 $10
        sOPEN_WEST_DOOR                                ;; 0d:4010 $e6
      sELSE                                            ;; 0d:4011 $01 $10
        sIF_FLAG wScriptFlags.3                        ;; 0d:4013 $08 $03 $00 $05
          sSFX 16                                      ;; 0d:4017 $f9 $10
          sOPEN_NORTH_DOOR                             ;; 0d:4019 $e0
        sELSE                                          ;; 0d:401a $01 $07
          sIF_FLAG wScriptFlags.4                      ;; 0d:401c $08 $04 $00 $03
            sSFX 16                                    ;; 0d:4020 $f9 $10
            sOPEN_SOUTH_DOOR                           ;; 0d:4022 $e2
          sENDIF                                       ;; 0d:4023
        sENDIF                                         ;; 0d:4023
      sENDIF                                           ;; 0d:4023
    sENDIF                                             ;; 0d:4023
    sEND                                               ;; 0d:4023 $00

script_0002:
    sEND                                               ;; 0d:4024 $00

; New Game script
script_0003:
; All references to the player's gender are controlled by these flags.
IF DEF(PLAYER_GENDER_FEMALE)
    sSET_FLAG wScriptFlags01.7
    sCLEAR_FLAG wScriptFlags06.3
ELIF DEF(PLAYER_GENDER_MALE)
    sSET_FLAG wScriptFlags06.3
    sCLEAR_FLAG wScriptFlags01.7
ELIF DEF(PLAYER_GENDER_NEUTRAL)
    sCLEAR_FLAG wScriptFlags06.3
    sCLEAR_FLAG wScriptFlags01.7
ENDC

; All script references to your gladiator friend are controlled by this flag.
IF DEF(GLADIATOR_DUKE)
    sCLEAR_FLAG wScriptFlags0A.0
ELIF DEF(GLADIATOR_AMANDA)
    sSET_FLAG wScriptFlags0A.0
ENDC

    sPLAYER_CURE_STATUS 16          ; For the color target this initializes the player's palette.
    sSET_NPC_TYPES $2a
    sSET_PLAYER_POSITION 16, 01     ; Draw the player on the naming screen.
    sENTER_PLAYER_AND_GIRL_NAME
    sSET_PLAYER_POSITION 00, 18     ; Hide the player offscreen.
    sSPAWN_NPC 0                    ; Show Fuji instead
    sSET_NPC_1_POSITION 16, 01
    sENTER_PLAYER_AND_GIRL_NAME     ; This second call will prompt to name Fuji.
    sSET_NPC_1_POSITION 00, 18      ; Hide Fuji offscreen.
    sSET_PLAYER_POSITION 20, 01
    sLOAD_ROOM 1, $47, 19, 10
    sCALL script_00e6
    sEND

script_0004:
    sIF_FLAG !wScriptFlags0E.4                         ;; 0d:4031 $08 $f4 $00 $5a
      sIF_FLAG !wScriptFlags0E.5, !wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:4035 $08 $f5 $f6 $f7 $00 $05
        sLOAD_ROOM 14, $10, 12, 9                      ;; 0d:403b $f4 $0e $10 $0c $09
      sENDIF                                           ;; 0d:4040
      sIF_FLAG !wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:4040 $08 $f5 $f6 $77 $00 $05
        sLOAD_ROOM 14, $06, 14, 8                      ;; 0d:4046 $f4 $0e $06 $0e $08
      sENDIF                                           ;; 0d:404b
      sIF_FLAG !wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:404b $08 $f5 $76 $f7 $00 $05
        sLOAD_ROOM 0, $5b, 8, 4                        ;; 0d:4051 $f4 $00 $5b $08 $04
      sENDIF                                           ;; 0d:4056
      sIF_FLAG !wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:4056 $08 $f5 $76 $77 $00 $05
        sLOAD_ROOM 14, $53, 6, 6                       ;; 0d:405c $f4 $0e $53 $06 $06
      sENDIF                                           ;; 0d:4061
      sIF_FLAG wScriptFlags0E.5, !wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:4061 $08 $75 $f6 $f7 $00 $05
        sLOAD_ROOM 14, $14, 2, 12                      ;; 0d:4067 $f4 $0e $14 $02 $0c
      sENDIF                                           ;; 0d:406c
      sIF_FLAG wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:406c $08 $75 $f6 $77 $00 $05
        sLOAD_ROOM 0, $33, 12, 5                       ;; 0d:4072 $f4 $00 $33 $0c $05
      sENDIF                                           ;; 0d:4077
      sIF_FLAG wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:4077 $08 $75 $76 $f7 $00 $05
        sLOAD_ROOM 15, $46, 10, 6                      ;; 0d:407d $f4 $0f $46 $0a $06
      sENDIF                                           ;; 0d:4082
      sIF_FLAG wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:4082 $08 $75 $76 $77 $00 $05
        sLOAD_ROOM 0, $d1, 4, 6                        ;; 0d:4088 $f4 $00 $d1 $04 $06
      sENDIF                                           ;; 0d:408d
    sELSE                                              ;; 0d:408d $01 $7f
      sIF_FLAG !wScriptFlags0E.5, !wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:408f $08 $f5 $f6 $f7 $00 $05
        sLOAD_ROOM 0, $df, 10, 4                       ;; 0d:4095 $f4 $00 $df $0a $04
      sENDIF                                           ;; 0d:409a
      sIF_FLAG !wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:409a $08 $f5 $f6 $77 $00 $0f
        sLOAD_ROOM 14, $14, 10, 6                      ;; 0d:40a0 $f4 $0e $14 $0a $06
        sIF_FLAG !wScriptFlags05.0                     ;; 0d:40a5 $08 $a8 $00 $04
          sSET_MUSIC 0                                 ;; 0d:40a9 $f8 $00
        sELSE                                          ;; 0d:40ab $01 $02
          sSET_MUSIC 13                                ;; 0d:40ad $f8 $0d
        sENDIF                                         ;; 0d:40af
      sENDIF                                           ;; 0d:40af
      sIF_FLAG !wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:40af $08 $f5 $76 $f7 $00 $07
        sLOAD_ROOM 0, $4d, 10, 4                       ;; 0d:40b5 $f4 $00 $4d $0a $04
        sSET_MUSIC 20                                  ;; 0d:40ba $f8 $14
      sENDIF                                           ;; 0d:40bc
      sIF_FLAG !wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:40bc $08 $f5 $76 $77 $00 $0f
        sLOAD_ROOM 15, $36, 2, 11                      ;; 0d:40c2 $f4 $0f $36 $02 $0b
        sIF_FLAG !wScriptFlags04.1                     ;; 0d:40c7 $08 $a1 $00 $04
          sSET_MUSIC 27                                ;; 0d:40cb $f8 $1b
        sELSE                                          ;; 0d:40cd $01 $02
          sSET_MUSIC 4                                 ;; 0d:40cf $f8 $04
        sENDIF                                         ;; 0d:40d1
      sENDIF                                           ;; 0d:40d1
      sIF_FLAG wScriptFlags0E.5, !wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:40d1 $08 $75 $f6 $f7 $00 $07
        sLOAD_ROOM 14, $01, 14, 5                      ;; 0d:40d7 $f4 $0e $01 $0e $05
        sSET_MUSIC 4                                   ;; 0d:40dc $f8 $04
      sENDIF                                           ;; 0d:40de
      sIF_FLAG wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:40de $08 $75 $f6 $77 $00 $10
        sLOAD_ROOM 14, $17, 16, 8                      ;; 0d:40e4 $f4 $0e $17 $10 $08
        sIF_FLAG wScriptFlags02.0, !wScriptFlags02.1   ;; 0d:40e9 $08 $10 $91 $00 $04
          sSET_MUSIC 9                                 ;; 0d:40ee $f8 $09
        sELSE                                          ;; 0d:40f0 $01 $02
          sSET_MUSIC 11                                ;; 0d:40f2 $f8 $0b
        sENDIF                                         ;; 0d:40f4
      sENDIF                                           ;; 0d:40f4
      sIF_FLAG wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:40f4 $08 $75 $76 $f7 $00 $07
        sLOAD_ROOM 0, $aa, 14, 8                       ;; 0d:40fa $f4 $00 $aa $0e $08
        sSET_MUSIC 20                                  ;; 0d:40ff $f8 $14
      sENDIF                                           ;; 0d:4101
      sIF_FLAG wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:4101 $08 $75 $76 $77 $00 $07
        sLOAD_ROOM 0, $7c, 8, 4                        ;; 0d:4107 $f4 $00 $7c $08 $04
        sSET_MUSIC 20                                  ;; 0d:410c $f8 $14
      sENDIF                                           ;; 0d:410e
    sENDIF                                             ;; 0d:410e
    sCLEAR_ROOM_HISTORY                                ;; 0d:410e $ab
    sRUN_ROOM_SCRIPT                                   ;; 0d:410f $ec
    sEND                                               ;; 0d:4110 $00

script_0005:
    sIF_EQUIPED INV_ITEM_KEY                           ;; 0d:4111 $09 $1f $00 $25
      sIF_FLAG wScriptFlags.1                          ;; 0d:4115 $08 $01 $00 $05
        sSFX 16                                        ;; 0d:4119 $f9 $10
        sOPEN_EAST_DOOR                                ;; 0d:411b $e4
      sELSE                                            ;; 0d:411c $01 $19
        sIF_FLAG wScriptFlags.2                        ;; 0d:411e $08 $02 $00 $05
          sSFX 16                                      ;; 0d:4122 $f9 $10
          sOPEN_WEST_DOOR                              ;; 0d:4124 $e6
        sELSE                                          ;; 0d:4125 $01 $10
          sIF_FLAG wScriptFlags.3                      ;; 0d:4127 $08 $03 $00 $05
            sSFX 16                                    ;; 0d:412b $f9 $10
            sOPEN_NORTH_DOOR                           ;; 0d:412d $e0
          sELSE                                        ;; 0d:412e $01 $07
            sIF_FLAG wScriptFlags.4                    ;; 0d:4130 $08 $04 $00 $03
              sSFX 16                                  ;; 0d:4134 $f9 $10
              sOPEN_SOUTH_DOOR                         ;; 0d:4136 $e2
            sENDIF                                     ;; 0d:4137
          sENDIF                                       ;; 0d:4137
        sENDIF                                         ;; 0d:4137
      sENDIF                                           ;; 0d:4137
      sTAKE_EQUIPED_ITEM                               ;; 0d:4137 $de
    sELSE                                              ;; 0d:4138 $01 $0b
      sMSG                                             ;; 0d:413a $04
        db "<10> Locked.<12>"
        db "<11>", $00   ;; 0d:413b
    sENDIF                                             ;; 0d:4145
    sEND                                               ;; 0d:4145 $00

script_0006:
    sEND                                               ;; 0d:4146 $00

script_0007:
    sSET_MUSIC 0                                       ;; 0d:4147 $f8 $00
    sLOOP 4, 13                                        ;; 0d:4149 $03 $04 $0d
      sSET_PLAYER_DIRECTION_RIGHT                      ;; 0d:414c $86
      sDELAY 5                                         ;; 0d:414d $f0 $05
      sSET_PLAYER_DIRECTION_DOWN                       ;; 0d:414f $85
      sDELAY 5                                         ;; 0d:4150 $f0 $05
      sSET_PLAYER_DIRECTION_LEFT                       ;; 0d:4152 $87
      sDELAY 5                                         ;; 0d:4153 $f0 $05
      sSET_PLAYER_DIRECTION_UP                         ;; 0d:4155 $84
      sDELAY 5                                         ;; 0d:4156 $f0 $05
    sEND                                               ;; 0d:4158 $00
    sSET_PLAYER_LAYDOWN_SPRITE                         ;; 0d:4159 $a6
    sSET_PLAYER_DIRECTION_LEFT
    sDELAY 44                                          ;; 0d:415b $f0 $2c
    sSET_MUSIC 23                                      ;; 0d:415d $f8 $17
    sMSG                                               ;; 0d:415f $04
      db "<10>\n    <BOY> fell_<12>"
      db "<11>", $00 ;; 0d:4160
    sFADE_TO_WHITE
    sRESET_GAME                                        ;; 0d:416c $c8
    sEND                                               ;; 0d:416d $00

script_0008:
    sIF_FLAG !wScriptFlags0E.4                         ;; 0d:416e $08 $f4 $00 $5a
      sIF_FLAG !wScriptFlags0E.5, !wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:4172 $08 $f5 $f6 $f7 $00 $05
        sLOAD_ROOM 14, $10, 6, 7                       ;; 0d:4178 $f4 $0e $10 $06 $07
      sENDIF                                           ;; 0d:417d
      sIF_FLAG !wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:417d $08 $f5 $f6 $77 $00 $05
        sLOAD_ROOM 0, $c7, 8, 7                        ;; 0d:4183 $f4 $00 $c7 $08 $07
      sENDIF                                           ;; 0d:4188
      sIF_FLAG !wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:4188 $08 $f5 $76 $f7 $00 $05
        sLOAD_ROOM 14, $07, 12, 4                      ;; 0d:418e $f4 $0e $07 $0c $04
      sENDIF                                           ;; 0d:4193
      sIF_FLAG !wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:4193 $08 $f5 $76 $77 $00 $05
        sLOAD_ROOM 0, $af, 4, 4                        ;; 0d:4199 $f4 $00 $af $04 $04
      sENDIF                                           ;; 0d:419e
      sIF_FLAG wScriptFlags0E.5, !wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:419e $08 $75 $f6 $f7 $00 $05
        sLOAD_ROOM 14, $63, 14, 10                     ;; 0d:41a4 $f4 $0e $63 $0e $0a
      sENDIF                                           ;; 0d:41a9
      sIF_FLAG wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:41a9 $08 $75 $f6 $77 $00 $05
        sLOAD_ROOM 14, $24, 10, 4                      ;; 0d:41af $f4 $0e $24 $0a $04
      sENDIF                                           ;; 0d:41b4
      sIF_FLAG wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:41b4 $08 $75 $76 $f7 $00 $05
        sLOAD_ROOM 0, $23, 10, 6                       ;; 0d:41ba $f4 $00 $23 $0a $06
      sENDIF                                           ;; 0d:41bf
      sIF_FLAG wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:41bf $08 $75 $76 $77 $00 $05
        sLOAD_ROOM 0, $90, 12, 6                       ;; 0d:41c5 $f4 $00 $90 $0c $06
      sENDIF                                           ;; 0d:41ca
    sELSE                                              ;; 0d:41ca $01 $58
      sIF_FLAG !wScriptFlags0E.5, !wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:41cc $08 $f5 $f6 $f7 $00 $05
        sLOAD_ROOM 0, $db, 8, 4                        ;; 0d:41d2 $f4 $00 $db $08 $04
      sENDIF                                           ;; 0d:41d7
      sIF_FLAG !wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:41d7 $08 $f5 $f6 $77 $00 $05
        sLOAD_ROOM 15, $26, 4, 12                      ;; 0d:41dd $f4 $0f $26 $04 $0c
      sENDIF                                           ;; 0d:41e2
      sIF_FLAG !wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:41e2 $08 $f5 $76 $f7 $00 $05
        sLOAD_ROOM 14, $00, 4, 8                       ;; 0d:41e8 $f4 $0e $00 $04 $08
      sENDIF                                           ;; 0d:41ed
      sIF_FLAG !wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:41ed $08 $f5 $76 $77 $00 $05
        sLOAD_ROOM 14, $06, 6, 8                       ;; 0d:41f3 $f4 $0e $06 $06 $08
      sENDIF                                           ;; 0d:41f8
      sIF_FLAG wScriptFlags0E.5, !wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:41f8 $08 $75 $f6 $f7 $00 $05
        sLOAD_ROOM 14, $13, 16, 8                      ;; 0d:41fe $f4 $0e $13 $10 $08
      sENDIF                                           ;; 0d:4203
      sIF_FLAG wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:4203 $08 $75 $f6 $77 $00 $05
        sLOAD_ROOM 14, $63, 10, 4                      ;; 0d:4209 $f4 $0e $63 $0a $04
      sENDIF                                           ;; 0d:420e
      sIF_FLAG wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:420e $08 $75 $76 $f7 $00 $05
        sLOAD_ROOM 15, $46, 4, 10                      ;; 0d:4214 $f4 $0f $46 $04 $0a
      sENDIF                                           ;; 0d:4219
      sIF_FLAG wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:4219 $08 $75 $76 $77 $00 $05
        sLOAD_ROOM 15, $46, 14, 6                      ;; 0d:421f $f4 $0f $46 $0e $06
      sENDIF                                           ;; 0d:4224
    sENDIF                                             ;; 0d:4224
    sCLEAR_ROOM_HISTORY                                ;; 0d:4224 $ab
    sRUN_ROOM_SCRIPT                                   ;; 0d:4225 $ec
    sEND                                               ;; 0d:4226 $00

script_0009:
    sMSG                                               ;; 0d:4227 $04
      db "<10> Doesn't open.<12>"
      db "<11>", $00 ;; 0d:4228
    sEND                                               ;; 0d:4237 $00

script_000a:
    sEND                                               ;; 0d:4238 $00

script_000b:
    sEND                                               ;; 0d:4239 $00

script_000c:
    sIF_FLAG !wScriptFlags0E.4, !wScriptFlags0E.5, !wScriptFlags0E.6 ;; 0d:423a $08 $f4 $f5 $f6 $00 $6c
      sIF_FLAG !wScriptFlags0E.7                       ;; 0d:4240 $08 $f7 $00 $14
        sIF_FLAG wScriptFlags08.0, !wScriptFlags04.5   ;; 0d:4244 $08 $40 $a5 $00 $02
        sELSE                                          ;; 0d:4249 $01 $0b
          sLOAD_ROOM 0, $a9, 10, 5                     ;; 0d:424b $f4 $00 $a9 $0a $05
          sSET_MUSIC 20                                ;; 0d:4250 $f8 $14
          sCALL script_0488                            ;; 0d:4252 $02 $5b $55
          sCLEAR_ROOM_HISTORY                          ;; 0d:4255 $ab
        sENDIF                                         ;; 0d:4256
      sELSE                                            ;; 0d:4256 $01 $52
        sMSG                                           ;; 0d:4258 $04
          db "<10>", $00                               ;; 0d:4259
        sIF_FLAG !wScriptFlags06.1                     ;; 0d:425b $08 $b1 $00 $2f
          sMSG                                         ;; 0d:425f $04
            db " I'LL STAY HERE\n AND RESEARCH.<12>"
            db "<11>", $00 ;; 0d:4260
          sFOLLOWER_DELETE                             ;; 0d:427e $98
          sCLEAR_FLAG wScriptFlags0A.7                 ;; 0d:427f $db $57
          sLOAD_ROOM 0, $73, 10, 6                     ;; 0d:4281 $f4 $00 $73 $0a $06
          sSET_MUSIC 25                                ;; 0d:4286 $f8 $14
          sCALL script_03e8                            ;; 0d:4288 $02 $4f $ae
          sCLEAR_ROOM_HISTORY                          ;; 0d:428b $ab
        sELSE                                          ;; 0d:428c $01 $1c
          sMSG                                         ;; 0d:428e $04
            db "Tower is sinking.\nUnable to get out!<12>"
            db "<11>", $00 ;; 0d:428f
        sENDIF                                         ;; 0d:42aa
      sENDIF                                           ;; 0d:42aa
    sELSE                                              ;; 0d:42aa $01 $d7
      sIF_FLAG !wScriptFlags0E.4                       ;; 0d:42ac $08 $f4 $00 $84
        sIF_FLAG !wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:42b0 $08 $f5 $76 $f7 $00 $07
          sLOAD_ROOM 0, $64, 14, 7                     ;; 0d:42b6 $f4 $00 $64 $0e $07
          sSET_MUSIC 20                                ;; 0d:42bb $f8 $14
        sENDIF                                         ;; 0d:42bd
        sIF_FLAG !wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:42bd $08 $f5 $76 $77 $00 $41
          sIF_FLAG wScriptFlags0A.6, !wScriptFlags05.0 ;; 0d:42c3 $08 $56 $a8 $00 $2b
            sMSG                                       ;; 0d:42c8 $04
              db "<10>Lester:Won't you\n ", $00
            sIF_FLAG wScriptFlags0A.0
              sMSG
                db "avenge my sister", $00
            sELSE
              sMSG
                db "help avenge him", $00
            sENDIF
            sMSG
              db "?\n Well, I'm going!<12>"
              db "<11>", $00 ;; 0d:42c9
            sFOLLOWER_DELETE                           ;; 0d:42f0 $98
            sCLEAR_FLAG wScriptFlags0A.6               ;; 0d:42f1 $db $56
          sENDIF                                       ;; 0d:42f3
          sIF_FLAG wScriptFlags05.0                    ;; 0d:42f3 $08 $28 $00 $02
            sSET_MUSIC 13                              ;; 0d:42f7 $f8 $0d
          sENDIF                                       ;; 0d:42f9
          sIF_FLAG !wScriptFlags05.0                   ;; 0d:42f9 $08 $a8 $00 $02
            sSET_MUSIC 0                               ;; 0d:42fd $f8 $00
          sENDIF                                       ;; 0d:42ff
          sLOAD_ROOM 14, $03, 12, 8                    ;; 0d:42ff $f4 $0e $03 $0c $08
        sENDIF                                         ;; 0d:4304
        sIF_FLAG wScriptFlags0E.5, !wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:4304 $08 $75 $f6 $f7 $00 $07
          sLOAD_ROOM 0, $c5, 9, 8                      ;; 0d:430a $f4 $00 $c5 $09 $08
          sSET_MUSIC 25                                ;; 0d:430f $f8 $19
        sENDIF                                         ;; 0d:4311
        sIF_FLAG wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:4311 $08 $75 $f6 $77 $00 $05
          sLOAD_ROOM 1, $15, 9, 4                      ;; 0d:4317 $f4 $01 $15 $09 $04
        sENDIF                                         ;; 0d:431c
        sIF_FLAG wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:431c $08 $75 $76 $f7 $00 $05
          sLOAD_ROOM 15, $22, 2, 11                    ;; 0d:4322 $f4 $0f $22 $02 $0b
        sENDIF                                         ;; 0d:4327
        sIF_FLAG wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:4327 $08 $75 $76 $77 $00 $05
          sLOAD_ROOM 14, $53, 14, 8                    ;; 0d:432d $f4 $0e $53 $0e $08
        sENDIF                                         ;; 0d:4332
      sELSE                                            ;; 0d:4332 $01 $4d
        sIF_FLAG !wScriptFlags0E.5, !wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:4334 $08 $f5 $f6 $f7 $00 $05
          sLOAD_ROOM 0, $0a, 14, 4                     ;; 0d:433a $f4 $00 $0a $0e $04
        sENDIF                                         ;; 0d:433f
        sIF_FLAG !wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:433f $08 $f5 $f6 $77 $00 $05
          sLOAD_ROOM 0, $55, 8, 4                      ;; 0d:4345 $f4 $00 $55 $08 $04
        sENDIF                                         ;; 0d:434a
        sIF_FLAG !wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:434a $08 $f5 $76 $f7 $00 $05
          sLOAD_ROOM 0, $62, 12, 6                     ;; 0d:4350 $f4 $00 $62 $0c $06
        sENDIF                                         ;; 0d:4355
        sIF_FLAG !wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:4355 $08 $f5 $76 $77 $00 $05
          sLOAD_ROOM 0, $00, 6, 6                      ;; 0d:435b $f4 $00 $00 $06 $06
        sENDIF                                         ;; 0d:4360
        sIF_FLAG wScriptFlags0E.5, !wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:4360 $08 $75 $f6 $f7 $00 $05
          sLOAD_ROOM 14, $01, 6, 9                     ;; 0d:4366 $f4 $0e $01 $06 $09
        sENDIF                                         ;; 0d:436b
        sIF_FLAG wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:436b $08 $75 $f6 $77 $00 $05
          sLOAD_ROOM 14, $26, 8, 8                     ;; 0d:4371 $f4 $0e $26 $08 $08
        sENDIF                                         ;; 0d:4376
        sIF_FLAG wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:4376 $08 $75 $76 $f7 $00 $05
          sLOAD_ROOM 14, $15, 12, 10                   ;; 0d:437c $f4 $0e $15 $0c $0a
        sENDIF                                         ;; 0d:4381
      sENDIF                                           ;; 0d:4381
      sCLEAR_ROOM_HISTORY                              ;; 0d:4381 $ab
      sRUN_ROOM_SCRIPT                                 ;; 0d:4382 $ec
    sENDIF                                             ;; 0d:4383
    sEND                                               ;; 0d:4383 $00

script_000d:
    sIF_FLAG wScriptFlags05.5, wScriptFlags.3          ;; 0d:4384 $08 $2d $03 $00 $05
      sSFX 16                                          ;; 0d:4389 $f9 $10
      sOPEN_NORTH_DOOR                                 ;; 0d:438b $e0
    sELSE                                              ;; 0d:438c $01 $1c
      sMSG                                             ;; 0d:438e $04
        db "<10>_ _", $00                              ;; 0d:438f
      sDELAY 30                                        ;; 0d:4394 $f0 $1e
      sMSG                                             ;; 0d:4396 $04
        db "_", $00                                    ;; 0d:4397
      sDELAY 20                                        ;; 0d:4399 $f0 $14
      sMSG                                             ;; 0d:439b $04
        db "__\n_ It's frozen.<12>"
        db "<11>", $00 ;; 0d:439c
    sENDIF                                             ;; 0d:43aa
    sEND                                               ;; 0d:43aa $00

script_000e:
    sEND                                               ;; 0d:43ab $00

script_000f:
    sEND                                               ;; 0d:43ac $00

script_0010:
    sEND                                               ;; 0d:43ad $00

script_0011:
    sEND                                               ;; 0d:43ae $00

script_0012:
    sEND                                               ;; 0d:43af $00

script_0013:
    sEND                                               ;; 0d:43b0 $00

script_0014:
    sEND                                               ;; 0d:43b1 $00

script_0015:
    sEND                                               ;; 0d:43b2 $00

script_0016:
    sEND                                               ;; 0d:43b3 $00

script_0017:
    sEND                                               ;; 0d:43b4 $00

script_0018:
    sEND                                               ;; 0d:43b5 $00

script_0019:
    sEND                                               ;; 0d:43b6 $00

script_001a:
    sEND                                               ;; 0d:43b7 $00

script_001b:
    sEND                                               ;; 0d:43b8 $00

script_001c:
    sEND                                               ;; 0d:43b9 $00

script_001d:
    sEND                                               ;; 0d:43ba $00

script_001e:
    sEND                                               ;; 0d:43bb $00

script_001f:
    sCHECK_ALLOWED_TO_OPEN_MAP                         ;; 0d:43bc $a9
    sIF_FLAG wScriptFlags0F.7                          ;; 0d:43bd $08 $7f $00 $03
      sOPEN_MAP                                        ;; 0d:43c1 $ac
      sWAIT_MAP_CLOSE                                  ;; 0d:43c2 $ad
      sCLOSE_MAP                                       ;; 0d:43c3 $ae
    sENDIF                                             ;; 0d:43c4
    sEND                                               ;; 0d:43c4 $00

script_0020:
    sEND                                               ;; 0d:43c5 $00

script_0021:
    sEND                                               ;; 0d:43c6 $00

script_0022:
    sEND                                               ;; 0d:43c7 $00

script_0023:
    sEND                                               ;; 0d:43c8 $00

script_0024:
    sEND                                               ;; 0d:43c9 $00

script_0025:
    sEND                                               ;; 0d:43ca $00

script_0026:
    sEND                                               ;; 0d:43cb $00

script_0027:
    sEND                                               ;; 0d:43cc $00

script_0028:
    sEND                                               ;; 0d:43cd $00

script_0029:
    sEND                                               ;; 0d:43ce $00

script_002a:
    sEND                                               ;; 0d:43cf $00

script_002b:
    sEND                                               ;; 0d:43d0 $00

script_002c:
    sEND                                               ;; 0d:43d1 $00

script_002d:
    sEND                                               ;; 0d:43d2 $00

script_002e:
    sEND                                               ;; 0d:43d3 $00

script_002f:
    sEND                                               ;; 0d:43d4 $00

script_0030:
    sSET_NPC_TYPES 0                                   ;; 0d:43d5 $fc $00
    sSPAWN_NPC 0                                       ;; 0d:43d7 $fd $00
    sSPAWN_NPC 1                                       ;; 0d:43d9 $fd $01
    sEND                                               ;; 0d:43db $00

script_003d:
    sEND                                               ;; 0d:43dc $00

script_003e:
    sEND                                               ;; 0d:43dd $00

script_003f:
    sEND                                               ;; 0d:43de $00

script_0040:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:43df $08 $87 $00 $06
      sSET_NPC_TYPES 0                                 ;; 0d:43e3 $fc $00
      sSPAWN_NPC 0                                     ;; 0d:43e5 $fd $00
      sSPAWN_NPC 1                                     ;; 0d:43e7 $fd $01
    sENDIF                                             ;; 0d:43e9
    sEND                                               ;; 0d:43e9 $00

script_0041:
    sEND                                               ;; 0d:43ea $00

script_0042:
    sEND                                               ;; 0d:43eb $00

script_0043:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:43ec $08 $87 $00 $06
      sSET_NPC_TYPES 1                                 ;; 0d:43f0 $fc $01
      sSPAWN_NPC 0                                     ;; 0d:43f2 $fd $00
      sSPAWN_NPC 1                                     ;; 0d:43f4 $fd $01
    sENDIF                                             ;; 0d:43f6
    sEND                                               ;; 0d:43f6 $00

script_0044:
    sEND                                               ;; 0d:43f7 $00

script_0045:
    sEND                                               ;; 0d:43f8 $00

script_0046:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:43f9 $08 $87 $00 $04
      sSET_NPC_TYPES 0                                 ;; 0d:43fd $fc $00
      sSPAWN_NPC 2                                     ;; 0d:43ff $fd $02
    sENDIF                                             ;; 0d:4401
    sEND                                               ;; 0d:4401 $00

script_0047:
    sEND                                               ;; 0d:4402 $00

script_0048:
    sEND                                               ;; 0d:4403 $00

script_0049:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4404 $08 $87 $00 $06
      sSET_NPC_TYPES 2                                 ;; 0d:4408 $fc $02
      sSPAWN_NPC 1                                     ;; 0d:440a $fd $01
      sSPAWN_NPC 0                                     ;; 0d:440c $fd $00
    sENDIF                                             ;; 0d:440e
    sEND                                               ;; 0d:440e $00

script_004a:
    sEND                                               ;; 0d:440f $00

script_004b:
    sEND                                               ;; 0d:4410 $00

script_004c:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4411 $08 $87 $00 $06
      sSET_NPC_TYPES 3                                 ;; 0d:4415 $fc $03
      sSPAWN_NPC 0                                     ;; 0d:4417 $fd $00
      sSPAWN_NPC 1                                     ;; 0d:4419 $fd $01
    sENDIF                                             ;; 0d:441b
    sEND                                               ;; 0d:441b $00

script_004d:
    sEND                                               ;; 0d:441c $00

script_004e:
    sEND                                               ;; 0d:441d $00

script_004f:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:441e $08 $87 $00 $04
      sSET_NPC_TYPES 8                                 ;; 0d:4422 $fc $08
      sSPAWN_NPC 0                                     ;; 0d:4424 $fd $00
    sENDIF                                             ;; 0d:4426
    sEND                                               ;; 0d:4426 $00

script_0050:
    sEND                                               ;; 0d:4427 $00

script_0051:
    sEND                                               ;; 0d:4428 $00

script_0052:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4429 $08 $87 $00 $04
      sSET_NPC_TYPES 9                                 ;; 0d:442d $fc $09
      sSPAWN_NPC 0                                     ;; 0d:442f $fd $00
    sENDIF                                             ;; 0d:4431
    sEND                                               ;; 0d:4431 $00

script_0053:
    sEND                                               ;; 0d:4432 $00

script_0054:
    sEND                                               ;; 0d:4433 $00

script_0055:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4434 $08 $87 $00 $04
      sSET_NPC_TYPES 9                                 ;; 0d:4438 $fc $09
      sSPAWN_NPC 1                                     ;; 0d:443a $fd $01
    sENDIF                                             ;; 0d:443c
    sEND                                               ;; 0d:443c $00

script_0056:
    sEND                                               ;; 0d:443d $00

script_0057:
    sEND                                               ;; 0d:443e $00

script_0058:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:443f $08 $87 $00 $06
      sSET_NPC_TYPES 11                                ;; 0d:4443 $fc $0b
      sSPAWN_NPC 1                                     ;; 0d:4445 $fd $01
      sSPAWN_NPC 2                                     ;; 0d:4447 $fd $02
    sENDIF                                             ;; 0d:4449
    sEND                                               ;; 0d:4449 $00

script_0059:
    sEND                                               ;; 0d:444a $00

script_005a:
    sEND                                               ;; 0d:444b $00

script_005b:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:444c $08 $87 $00 $06
      sSET_NPC_TYPES 13                                ;; 0d:4450 $fc $0d
      sSPAWN_NPC 0                                     ;; 0d:4452 $fd $00
      sSPAWN_NPC 1                                     ;; 0d:4454 $fd $01
    sENDIF                                             ;; 0d:4456
    sEND                                               ;; 0d:4456 $00

script_005c:
    sEND                                               ;; 0d:4457 $00

script_005d:
    sEND                                               ;; 0d:4458 $00

script_005e:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4459 $08 $87 $00 $04
      sCLEAR_FLAG wScriptFlags.5
      sSET_NPC_TYPES 13                                ;; 0d:445d $fc $0d
      sSPAWN_NPC 2                                     ;; 0d:445f $fd $02
    sENDIF                                             ;; 0d:4461
    sEND                                               ;; 0d:4461 $00

script_005f:
    sEND                                               ;; 0d:4462 $00

script_0060:
    sEND                                               ;; 0d:4463 $00

script_0061:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4464 $08 $87 $00 $06
      sSET_NPC_TYPES 18                                ;; 0d:4468 $fc $12
      sSPAWN_NPC 0                                     ;; 0d:446a $fd $00
      sSPAWN_NPC 1                                     ;; 0d:446c $fd $01
    sENDIF                                             ;; 0d:446e
    sEND                                               ;; 0d:446e $00

script_0062:
    sEND                                               ;; 0d:446f $00

script_0063:
    sEND                                               ;; 0d:4470 $00

script_0064:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4471 $08 $87 $00 $06
      sSET_NPC_TYPES 19                                ;; 0d:4475 $fc $13
      sSPAWN_NPC 0                                     ;; 0d:4477 $fd $00
      sSPAWN_NPC 1                                     ;; 0d:4479 $fd $01
    sENDIF                                             ;; 0d:447b
    sCLEAR_FLAG wScriptFlags0F.0                       ;; 0d:447b $db $78
    sCLEAR_FLAG wScriptFlags0F.1                       ;; 0d:447d $db $79
    sEND                                               ;; 0d:447f $00

script_0065:
    sEND                                               ;; 0d:4480 $00

script_0066:
    sEND                                               ;; 0d:4481 $00

script_0067:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4482 $08 $87 $00 $06
      sSET_NPC_TYPES 18                                ;; 0d:4486 $fc $12
      sSPAWN_NPC 1                                     ;; 0d:4488 $fd $01
      sSPAWN_NPC 2                                     ;; 0d:448a $fd $02
    sENDIF                                             ;; 0d:448c
    sEND                                               ;; 0d:448c $00

script_0068:
    sEND                                               ;; 0d:448d $00

script_0069:
    sEND                                               ;; 0d:448e $00

script_006a:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:448f $08 $87 $00 $06
      sSET_NPC_TYPES 24                                ;; 0d:4493 $fc $18
      sSPAWN_NPC 0                                     ;; 0d:4495 $fd $00
      sSPAWN_NPC 1                                     ;; 0d:4497 $fd $01
    sENDIF                                             ;; 0d:4499
    sEND                                               ;; 0d:4499 $00

script_006b:
    sEND                                               ;; 0d:449a $00

script_006c:
    sEND                                               ;; 0d:449b $00

script_006d:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:449c $08 $87 $00 $04
      sSET_NPC_TYPES 24                                ;; 0d:44a0 $fc $18
      sSPAWN_NPC 2                                     ;; 0d:44a2 $fd $02
    sENDIF                                             ;; 0d:44a4
    sEND                                               ;; 0d:44a4 $00

script_006e:
    sEND                                               ;; 0d:44a5 $00

script_006f:
    sEND                                               ;; 0d:44a6 $00

script_0070:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:44a7 $08 $87 $00 $04
      sSET_NPC_TYPES 25                                ;; 0d:44ab $fc $19
      sSPAWN_NPC 0                                     ;; 0d:44ad $fd $00
    sENDIF                                             ;; 0d:44af
    sEND                                               ;; 0d:44af $00

script_0071:
    sEND                                               ;; 0d:44b0 $00

script_0072:
    sEND                                               ;; 0d:44b1 $00

script_0073:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:44b2 $08 $87 $00 $06
      sSET_NPC_TYPES 25                                ;; 0d:44b6 $fc $19
      sSPAWN_NPC 1                                     ;; 0d:44b8 $fd $01
      sSPAWN_NPC 2                                     ;; 0d:44ba $fd $02
    sENDIF                                             ;; 0d:44bc
    sEND                                               ;; 0d:44bc $00

script_0074:
    sEND                                               ;; 0d:44bd $00

script_0075:
    sEND                                               ;; 0d:44be $00

script_0076:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:44bf $08 $87 $00 $06
      sSET_NPC_TYPES 28                                ;; 0d:44c3 $fc $1c
      sSPAWN_NPC 0                                     ;; 0d:44c5 $fd $00
      sSPAWN_NPC 1                                     ;; 0d:44c7 $fd $01
    sENDIF                                             ;; 0d:44c9
    sEND                                               ;; 0d:44c9 $00

script_0077:
    sEND                                               ;; 0d:44ca $00

script_0078:
    sEND                                               ;; 0d:44cb $00

script_0079:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:44cc $08 $87 $00 $04
      sSET_NPC_TYPES 29                                ;; 0d:44d0 $fc $1d
      sSPAWN_NPC 0                                     ;; 0d:44d2 $fd $00
    sENDIF                                             ;; 0d:44d4
    sEND                                               ;; 0d:44d4 $00

script_007a:
    sEND                                               ;; 0d:44d5 $00

script_007b:
    sEND                                               ;; 0d:44d6 $00

script_007c:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:44d7 $08 $87 $00 $04
      sSET_NPC_TYPES 28                                ;; 0d:44db $fc $1c
      sSPAWN_NPC 2                                     ;; 0d:44dd $fd $02
    sENDIF                                             ;; 0d:44df
    sEND                                               ;; 0d:44df $00

script_007d:
    sEND                                               ;; 0d:44e0 $00

script_007e:
    sEND                                               ;; 0d:44e1 $00

script_007f:
    sSET_NPC_TYPES 4                                   ;; 0d:44e2 $fc $04
    sSPAWN_NPC 0                                       ;; 0d:44e4 $fd $00
    sSPAWN_NPC 1                                       ;; 0d:44e6 $fd $01
    sCLEAR_FLAG wScriptFlags0F.0                       ;; 0d:44e8 $db $78
    sCLEAR_FLAG wScriptFlags0F.1                       ;; 0d:44ea $db $79
    sEND                                               ;; 0d:44ec $00

script_0080:
    sEND                                               ;; 0d:44ed $00

script_0081:
    sEND                                               ;; 0d:44ee $00

script_0082:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:44ef $08 $87 $00 $06
      sSET_NPC_TYPES 5                                 ;; 0d:44f3 $fc $05
      sSPAWN_NPC 0                                     ;; 0d:44f5 $fd $00
      sSPAWN_NPC 1                                     ;; 0d:44f7 $fd $01
    sENDIF                                             ;; 0d:44f9
    sEND                                               ;; 0d:44f9 $00

script_0083:
    sEND                                               ;; 0d:44fa $00

script_0084:
    sEND                                               ;; 0d:44fb $00

script_0085:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:44fc $08 $87 $00 $06
      sSET_NPC_TYPES 6                                 ;; 0d:4500 $fc $06
      sSPAWN_NPC 0                                     ;; 0d:4502 $fd $00
      sSPAWN_NPC 1                                     ;; 0d:4504 $fd $01
    sENDIF                                             ;; 0d:4506
    sEND                                               ;; 0d:4506 $00

script_0086:
    sEND                                               ;; 0d:4507 $00

script_0087:
    sEND                                               ;; 0d:4508 $00

script_0088:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4509 $08 $87 $00 $06
      sSET_NPC_TYPES 7                                 ;; 0d:450d $fc $07
      sSPAWN_NPC 0                                     ;; 0d:450f $fd $00
      sSPAWN_NPC 1                                     ;; 0d:4511 $fd $01
    sENDIF                                             ;; 0d:4513
    sEND                                               ;; 0d:4513 $00

script_0089:
    sEND                                               ;; 0d:4514 $00

script_008a:
    sEND                                               ;; 0d:4515 $00

script_008b:
    ; For the first ice puzzle load the snowman even it was previously destroyed.
    sSET_NPC_TYPES 10
    sSPAWN_NPC 0
    sEND                                               ;; 0d:451e $00

script_008c:
    sEND                                               ;; 0d:451f $00

script_008d:
    sEND                                               ;; 0d:4520 $00

script_008e:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4521 $08 $87 $00 $06
      sSET_NPC_TYPES 10                                ;; 0d:4525 $fc $0a
      sSPAWN_NPC 1                                     ;; 0d:4527 $fd $01
      sSPAWN_NPC 2                                     ;; 0d:4529 $fd $02
    sENDIF                                             ;; 0d:452b
    sCLEAR_FLAG wScriptFlags0F.0                       ;; 0d:452b $db $78
    sEND                                               ;; 0d:452d $00

script_008f:
    sEND                                               ;; 0d:452e $00

script_0090:
    sEND                                               ;; 0d:452f $00

script_0091:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4530 $08 $87 $00 $04
      sSET_NPC_TYPES 12                                ;; 0d:4534 $fc $0c
      sSPAWN_NPC 0                                     ;; 0d:4536 $fd $00
    sENDIF                                             ;; 0d:4538
    sEND                                               ;; 0d:4538 $00

script_0092:
    sEND                                               ;; 0d:4539 $00

script_0093:
    sEND                                               ;; 0d:453a $00

script_0094:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:453b $08 $87 $00 $04
      sSET_NPC_TYPES 12                                ;; 0d:453f $fc $0c
      sSPAWN_NPC 2                                     ;; 0d:4541 $fd $02
    sENDIF                                             ;; 0d:4543
    sEND                                               ;; 0d:4543 $00

script_0095:
    sEND                                               ;; 0d:4544 $00

script_0096:
    sEND                                               ;; 0d:4545 $00

script_0097:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4546 $08 $87 $00 $06
      sSET_NPC_TYPES 14                                ;; 0d:454a $fc $0e
      sSPAWN_NPC 1                                     ;; 0d:454c $fd $01
      sSPAWN_NPC 2                                     ;; 0d:454e $fd $02
    sENDIF                                             ;; 0d:4550
    sCLEAR_FLAG wScriptFlags0F.0                       ;; 0d:4550 $db $78
    sCLEAR_FLAG wScriptFlags0F.1                       ;; 0d:4552 $db $79
    sEND                                               ;; 0d:4554 $00

script_0098:
    sEND                                               ;; 0d:4555 $00

script_0099:
    sEND                                               ;; 0d:4556 $00

script_009a:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4557 $08 $87 $00 $06
      sSET_NPC_TYPES 15                                ;; 0d:455b $fc $0f
      sSPAWN_NPC 1                                     ;; 0d:455d $fd $01
      sSPAWN_NPC 2                                     ;; 0d:455f $fd $02
    sENDIF                                             ;; 0d:4561
    sEND                                               ;; 0d:4561 $00

script_009b:
    sEND                                               ;; 0d:4562 $00

script_009c:
    sEND                                               ;; 0d:4563 $00

script_009d:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4564 $08 $87 $00 $06
      sSET_NPC_TYPES 16                                ;; 0d:4568 $fc $10
      sSPAWN_NPC 1                                     ;; 0d:456a $fd $01
      sSPAWN_NPC 2                                     ;; 0d:456c $fd $02
    sENDIF                                             ;; 0d:456e
    sCLEAR_FLAG wScriptFlags0F.0                       ;; 0d:456e $db $78
    sCLEAR_FLAG wScriptFlags0F.1                       ;; 0d:4570 $db $79
    sCLEAR_FLAG wScriptFlags0F.2                       ;; 0d:4572 $db $7a
    sCLEAR_FLAG wScriptFlags0F.3                       ;; 0d:4574 $db $7b
    sEND                                               ;; 0d:4576 $00

script_009e:
    sEND                                               ;; 0d:4577 $00

script_009f:
    sEND                                               ;; 0d:4578 $00

script_00a0:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4579 $08 $87 $00 $04
      sSET_NPC_TYPES 17                                ;; 0d:457d $fc $11
      sSPAWN_NPC 2                                     ;; 0d:457f $fd $02
    sENDIF                                             ;; 0d:4581
    sEND                                               ;; 0d:4581 $00

script_00a1:
    sEND                                               ;; 0d:4582 $00

script_00a2:
    sEND                                               ;; 0d:4583 $00

script_00a3:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4584 $08 $87 $00 $06
      sSET_NPC_TYPES 20                                ;; 0d:4588 $fc $14
      sSPAWN_NPC 0                                     ;; 0d:458a $fd $00
      sSPAWN_NPC 1                                     ;; 0d:458c $fd $01
    sENDIF                                             ;; 0d:458e
    sEND                                               ;; 0d:458e $00

script_00a4:
    sEND                                               ;; 0d:458f $00

script_00a5:
    sEND                                               ;; 0d:4590 $00

script_00a6:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4591 $08 $87 $00 $04
      sSET_NPC_TYPES 8                                 ;; 0d:4595 $fc $08
      sSPAWN_NPC 1                                     ;; 0d:4597 $fd $01
    sENDIF                                             ;; 0d:4599
    sEND                                               ;; 0d:4599 $00

script_00a7:
    sEND                                               ;; 0d:459a $00

script_00a8:
    sEND                                               ;; 0d:459b $00

script_00a9:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:459c $08 $87 $00 $06
      sSET_NPC_TYPES 22                                ;; 0d:45a0 $fc $16
      sSPAWN_NPC 1                                     ;; 0d:45a2 $fd $01
      sSPAWN_NPC 2                                     ;; 0d:45a4 $fd $02
    sENDIF                                             ;; 0d:45a6
    sCLEAR_FLAG wScriptFlags0F.0                       ;; 0d:45a6 $db $78
    sCLEAR_FLAG wScriptFlags0F.1                       ;; 0d:45a8 $db $79
    sEND                                               ;; 0d:45aa $00

script_00aa:
    sEND                                               ;; 0d:45ab $00

script_00ab:
    sEND                                               ;; 0d:45ac $00

script_00ac:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:45ad $08 $87 $00 $04
      sSET_NPC_TYPES 23                                ;; 0d:45b1 $fc $17
      sSPAWN_NPC 0                                     ;; 0d:45b3 $fd $00
    sENDIF                                             ;; 0d:45b5
    sEND                                               ;; 0d:45b5 $00

script_00ad:
    sEND                                               ;; 0d:45b6 $00

script_00ae:
    sEND                                               ;; 0d:45b7 $00

script_00af:
    sCLOSE_WEST_DOOR                                   ;; 0d:45b8 $e7
    sSET_NPC_TYPES 5                                   ;; 0d:45b9 $fc $05
    sSPAWN_NPC 0                                       ;; 0d:45bb $fd $00
    sSPAWN_NPC 0                                       ;; 0d:45bd $fd $00
    sSPAWN_NPC 0                                       ;; 0d:45bf $fd $00
    sEND                                               ;; 0d:45c1 $00

script_00b0:
    sEND                                               ;; 0d:45c2 $00

script_00b1:
    sIF_FLAG !wScriptFlags09.7                         ;; 0d:45c3 $08 $cf $00 $07
      sSET_NPC_TYPES 89                                ;; 0d:45c7 $fc $59
      sSPAWN_NPC 2                                     ;; 0d:45c9 $fd $02
      sSET_CHEST_OPEN_SCRIPT2 script_045e              ;; 0d:45cb $ca $04 $5e
    sENDIF                                             ;; 0d:45ce
    sOPEN_WEST_DOOR                                    ;; 0d:45ce $e6
    sEND                                               ;; 0d:45cf $00

script_00b2:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:45d0 $08 $87 $00 $04
      sSET_NPC_TYPES 26                                ;; 0d:45d4 $fc $1a
      sSPAWN_NPC 1                                     ;; 0d:45d6 $fd $01
    sENDIF                                             ;; 0d:45d8
    sEND                                               ;; 0d:45d8 $00

script_00b3:
    sEND                                               ;; 0d:45d9 $00

script_00b4:
    sEND                                               ;; 0d:45da $00

script_00b5:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:45db $08 $87 $00 $06
      sSET_NPC_TYPES 27                                ;; 0d:45df $fc $1b
      sSPAWN_NPC 0                                     ;; 0d:45e1 $fd $00
      sSPAWN_NPC 1                                     ;; 0d:45e3 $fd $01
    sENDIF                                             ;; 0d:45e5
    sEND                                               ;; 0d:45e5 $00

script_00b6:
    sEND                                               ;; 0d:45e6 $00

script_00b7:
    sEND                                               ;; 0d:45e7 $00

script_00b8:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:45e8 $08 $87 $00 $06
      sSET_NPC_TYPES 30                                ;; 0d:45ec $fc $1e
      sSPAWN_NPC 0                                     ;; 0d:45ee $fd $00
      sSPAWN_NPC 1                                     ;; 0d:45f0 $fd $01
    sENDIF                                             ;; 0d:45f2
    sEND                                               ;; 0d:45f2 $00

script_00b9:
    sEND                                               ;; 0d:45f3 $00

script_00ba:
    sEND                                               ;; 0d:45f4 $00

script_00bb:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:45f5 $08 $87 $00 $04
      sSET_NPC_TYPES 26                                ;; 0d:45f9 $fc $1a
      sSPAWN_NPC 0                                     ;; 0d:45fb $fd $00
    sENDIF                                             ;; 0d:45fd
    sEND                                               ;; 0d:45fd $00

script_00bc:
    sEND                                               ;; 0d:45fe $00

script_00bd:
    sEND                                               ;; 0d:45ff $00

script_00be:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4600 $08 $87 $00 $06
      sSET_NPC_TYPES 31                                ;; 0d:4604 $fc $1f
      sSPAWN_NPC 0                                     ;; 0d:4606 $fd $00
      sSPAWN_NPC 1                                     ;; 0d:4608 $fd $01
    sENDIF                                             ;; 0d:460a
    sEND                                               ;; 0d:460a $00

script_00bf:
    sEND                                               ;; 0d:460b $00

script_00c0:
    sEND                                               ;; 0d:460c $00

script_00c1:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:460d $08 $87 $00 $04
      sSET_NPC_TYPES 31                                ;; 0d:4611 $fc $1f
      sSPAWN_NPC 2                                     ;; 0d:4613 $fd $02
    sENDIF                                             ;; 0d:4615
    sEND                                               ;; 0d:4615 $00

script_00c2:
    sEND                                               ;; 0d:4616 $00

script_00c3:
    sEND                                               ;; 0d:4617 $00

script_00c4:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4618 $08 $87 $00 $06
      sSET_NPC_TYPES 32                                ;; 0d:461c $fc $20
      sSPAWN_NPC 1                                     ;; 0d:461e $fd $01
      sSPAWN_NPC 2                                     ;; 0d:4620 $fd $02
    sENDIF                                             ;; 0d:4622
    sCLEAR_FLAG wScriptFlags0F.0                       ;; 0d:4622 $db $78
    sCLEAR_FLAG wScriptFlags0F.1                       ;; 0d:4624 $db $79
    sCLEAR_FLAG wScriptFlags0F.2                       ;; 0d:4626 $db $7a
    sCLEAR_FLAG wScriptFlags0F.3                       ;; 0d:4628 $db $7b
    sEND                                               ;; 0d:462a $00

script_00c5:
    sEND                                               ;; 0d:462b $00

script_00c6:
    sEND                                               ;; 0d:462c $00

script_00c7:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:462d $08 $87 $00 $06
      sSET_NPC_TYPES 33                                ;; 0d:4631 $fc $21
      sSPAWN_NPC 0                                     ;; 0d:4633 $fd $00
      sSPAWN_NPC 1                                     ;; 0d:4635 $fd $01
    sENDIF                                             ;; 0d:4637
    sEND                                               ;; 0d:4637 $00

script_00c8:
    sEND                                               ;; 0d:4638 $00

script_00c9:
    sEND                                               ;; 0d:4639 $00

script_00ca:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:463a $08 $87 $00 $04
      sCLEAR_FLAG wScriptFlags.5
      sSET_NPC_TYPES 34                                ;; 0d:463e $fc $22
      sSPAWN_NPC 0                                     ;; 0d:4640 $fd $00
    sENDIF                                             ;; 0d:4642
    sEND                                               ;; 0d:4642 $00

script_00cb:
    sEND                                               ;; 0d:4643 $00

script_00cc:
    sEND                                               ;; 0d:4644 $00

script_00cd:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4645 $08 $87 $00 $04
      sCLEAR_FLAG wScriptFlags.5
      sSET_NPC_TYPES 34                                ;; 0d:4649 $fc $22
      sSPAWN_NPC 1                                     ;; 0d:464b $fd $01
    sENDIF                                             ;; 0d:464d
    sEND                                               ;; 0d:464d $00

script_00ce:
    sEND                                               ;; 0d:464e $00

script_00cf:
    sEND                                               ;; 0d:464f $00

script_00d0:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4650 $08 $87 $00 $04
      sCLEAR_FLAG wScriptFlags.5
      sSET_NPC_TYPES 35                                ;; 0d:4654 $fc $23
      sSPAWN_NPC 1                                     ;; 0d:4656 $fd $01
    sENDIF                                             ;; 0d:4658
    sEND                                               ;; 0d:4658 $00

script_00d1:
    sEND                                               ;; 0d:4659 $00

script_00d2:
    sEND                                               ;; 0d:465a $00

script_00d3:
    sIF_FLAG !wScriptFlags.7                           ;; 0d:465b $08 $87 $00 $04
      sSET_NPC_TYPES 35                                ;; 0d:465f $fc $23
      sSPAWN_NPC 2                                     ;; 0d:4661 $fd $02
    sENDIF                                             ;; 0d:4663
    sEND                                               ;; 0d:4663 $00

script_00d4:
    sEND                                               ;; 0d:4664 $00

script_00d5:
    sEND                                               ;; 0d:4665 $00

script_00d6:
    sCLEAR_FLAG wScriptFlags0F.0                       ;; 0d:4666 $db $78
    sIF_FLAG !wScriptFlags.7                           ;; 0d:4668 $08 $87 $00 $10
      sSET_NPC_TYPES 3                                 ;; 0d:466c $fc $03
      sIF_FLAG !wScriptFlags01.5                       ;; 0d:466e $08 $8d $00 $06
        sSPAWN_NPC 0                                   ;; 0d:4672 $fd $00
        sSPAWN_NPC 1                                   ;; 0d:4674 $fd $01
      sELSE                                            ;; 0d:4676 $01 $04
        sSPAWN_NPC 2                                   ;; 0d:4678 $fd $02
        sSPAWN_NPC 2                                   ;; 0d:467a $fd $02
      sENDIF                                           ;; 0d:467c
    sENDIF                                             ;; 0d:467c
    sEND                                               ;; 0d:467c $00

script_00d7:
    sEND                                               ;; 0d:467d $00

script_00d8:
    sIF_FLAG wScriptFlags01.5, !wScriptFlags09.0, !wScriptFlags04.3
      sIF_INVENTORY INV_ITEM_BRONZE_KEY
        sSET_FLAG wScriptFlags0F.0
      sENDIF
      sIF_FLAG !wScriptFlags0F.0                       ;; 0d:4682 $08 $f8 $00 $07
        sSET_NPC_TYPES 89                              ;; 0d:4686 $fc $59
        sSPAWN_NPC 0                                   ;; 0d:4688 $fd $00
        sSET_CHEST_OPEN_SCRIPT1 script_0441            ;; 0d:468a $c9 $04 $41
      sENDIF                                           ;; 0d:468d
    sENDIF                                             ;; 0d:468d
    sSET_FLAG wScriptFlags0F.0                         ;; 0d:468d $da $78
    sEND                                               ;; 0d:468f $00

script_00d9:
    sCLOSE_NORTH_DOOR                                  ;; 0d:4690 $e1
    sSET_NPC_TYPES 14                                  ;; 0d:4691 $fc $0e
    sSPAWN_NPC 2                                       ;; 0d:4693 $fd $02
    sSPAWN_NPC 2                                       ;; 0d:4695 $fd $02
    sEND                                               ;; 0d:4697 $00

script_00da:
    sEND                                               ;; 0d:4698 $00

script_00db:
    sIF_FLAG !wScriptFlags07.1                         ;; 0d:4699 $08 $b9 $00 $07
      sSET_NPC_TYPES 89                                ;; 0d:469d $fc $59
      sSPAWN_NPC 0                                     ;; 0d:469f $fd $00
      sSET_CHEST_OPEN_SCRIPT1 script_045f              ;; 0d:46a1 $c9 $04 $5f
    sENDIF                                             ;; 0d:46a4
    sOPEN_NORTH_DOOR                                   ;; 0d:46a4 $e0
    sEND                                               ;; 0d:46a5 $00

script_00dc:
    sCLOSE_WEST_DOOR                                   ;; 0d:46a6 $e7
    sSET_NPC_TYPES 10                                  ;; 0d:46a7 $fc $0a
    sSPAWN_NPC 1                                       ;; 0d:46a9 $fd $01
    sSPAWN_NPC 1                                       ;; 0d:46ab $fd $01
    sEND                                               ;; 0d:46ad $00

script_00dd:
    sEND                                               ;; 0d:46ae $00

script_00de:
    sIF_FLAG !wScriptFlags07.7                         ;; 0d:46af $08 $bf $00 $07
      sSET_NPC_TYPES 89                                ;; 0d:46b3 $fc $59
      sSPAWN_NPC 0                                     ;; 0d:46b5 $fd $00
      sSET_CHEST_OPEN_SCRIPT1 script_0460              ;; 0d:46b7 $c9 $04 $60
    sENDIF                                             ;; 0d:46ba
    sOPEN_WEST_DOOR                                    ;; 0d:46ba $e6
    sEND                                               ;; 0d:46bb $00

script_00e0:
    sSET_NPC_TYPES 36                                  ;; 0d:46bc $fc $24
    sSPAWN_NPC 2                                       ;; 0d:46be $fd $02
    sEND                                               ;; 0d:46c0 $00

script_00e1:
    sEND                                               ;; 0d:46c1 $00

script_00e2:
    sEND                                               ;; 0d:46c2 $00

script_00e3:
    sSET_NPC_TYPES 37                                  ;; 0d:46c3 $fc $25
    sSPAWN_NPC 0                                       ;; 0d:46c5 $fd $00
    sSPAWN_NPC 2                                       ;; 0d:46c7 $fd $02
    sEND                                               ;; 0d:46c9 $00

script_00e4:
    sEND                                               ;; 0d:46ca $00

script_00e5:
    sEND                                               ;; 0d:46cb $00

script_00e6:
    sSET_MUSIC 0                                       ;; 0d:46cc $f8 $00
    sSET_PLAYER_POSITION 19, 10                        ;; 0d:46ce $8a $13 $0a
    sSET_PLAYER_DIRECTION_LEFT                         ;; 0d:46d1 $87
    sLOOP 10, 2                                        ;; 0d:46d2 $03 $0a $02
      sPLAYER_STEP_FORWARD                             ;; 0d:46d5 $80
    sEND                                               ;; 0d:46d6 $00
    sSFX 16                                            ;; 0d:46d7 $f9 $10
    sSET_ROOM_TILE $6c, 9, 5                           ;; 0d:46d9 $b0 $6c $09 $05
    sDELAY 30                                          ;; 0d:46dd $f0 $1e
    sSET_PLAYER_DIRECTION_UP                           ;; 0d:46df $84
    sDELAY 20                                          ;; 0d:46e0 $f0 $14
    sIF_FLAG !wScriptFlags01.0
      sMSG
        db "<10>Now, fight for\nShadow Knight's\nentertainment!<12><11><00>"
    sELSE
      sMSG
        db "<10>Now fight!\nGive Shadow Knight\na good show!<12><11><00>"
    sENDIF
    sSET_MUSIC 26                                      ;; 0d:46f0 $f8 $1a
    sDELAY 60                                          ;; 0d:46f2 $f0 $3c
    sSET_ROOM_TILE $6a, 4, 1                           ;; 0d:46f4 $b0 $6a $04 $01
    sSET_ROOM_TILE $6a, 5, 1                           ;; 0d:46f8 $b0 $6a $05 $01
    sSET_ROOM_TILE $6a, 4, 0                           ;; 0d:46fc $b0 $6a $04 $00
    sSET_ROOM_TILE $6a, 5, 0                           ;; 0d:4700 $b0 $6a $05 $00
    sSFX 16                                            ;; 0d:4704 $f9 $10
    sSPAWN_BOSS 16                                     ;; 0d:4706 $fe $10
    sDELAY 60                                          ;; 0d:4708 $f0 $3c
    sSET_ROOM_TILE $0f, 4, 0                           ;; 0d:470a $b0 $0f $04 $00
    sSET_ROOM_TILE $0f, 5, 0                           ;; 0d:470e $b0 $0f $05 $00
    sSET_ROOM_TILE $1f, 4, 1                           ;; 0d:4712 $b0 $1f $04 $01
    sSET_ROOM_TILE $1f, 5, 1                           ;; 0d:4716 $b0 $1f $05 $01
    sSFX 16                                            ;; 0d:471a $f9 $10
    sEND                                               ;; 0d:471c $00

script_00e7:
    sEND                                               ;; 0d:471d $00

script_00e8:
    sIF_FLAG wScriptFlags01.0                          ;; 0d:471e $08 $08 $00 $16
      sSFX 16                                          ;; 0d:4722 $f9 $10
      sSET_ROOM_TILE $1f, 4, 0                         ;; 0d:4724 $b0 $1f $04 $00
      sSET_ROOM_TILE $1f, 5, 0                         ;; 0d:4728 $b0 $1f $05 $00
      sSET_ROOM_TILE $6a, 4, 1                         ;; 0d:472c $b0 $6a $04 $01
      sSET_ROOM_TILE $6a, 5, 1                         ;; 0d:4730 $b0 $6a $05 $01
      sSET_MUSIC 14                                    ;; 0d:4734 $f8 $0e
    sELSE                                              ;; 0d:4736 $01 $05

      ; Ensure Hero is visible after Jackal defeat.
      sCLEAR_PLAYER_ATTACK
      sIF_FLAG wScriptFlags.1
        sSET_PLAYER_DIRECTION_RIGHT
      sELSE
        sIF_FLAG wScriptFlags.2
          sSET_PLAYER_DIRECTION_LEFT
        sELSE
          sIF_FLAG wScriptFlags.3
            sSET_PLAYER_DIRECTION_UP
          sELSE
            sSET_PLAYER_DIRECTION_DOWN
          sENDIF
        sENDIF
      sENDIF

      sDELAY 60                                        ;; 0d:4738 $f0 $3c
      sCALL script_0531                                ;; 0d:473a $02 $61 $29
    sENDIF                                             ;; 0d:473d
    sEND                                               ;; 0d:473d $00

script_00e9:
    sIF_FLAG wScriptFlags05.0                          ;; 0d:473e $08 $28 $00 $08
      sSET_NPC_TYPES 62                                ;; 0d:4742 $fc $3e
      sSPAWN_NPC 1                                     ;; 0d:4744 $fd $01
      sSPAWN_NPC 2                                     ;; 0d:4746 $fd $02
    sELSE                                              ;; 0d:4748 $01 $04
      sSET_NPC_TYPES 59                                ;; 0d:474a $fc $3b
      sSPAWN_NPC 1                                     ;; 0d:474c $fd $01
    sENDIF                                             ;; 0d:474e
    sEND                                               ;; 0d:474e $00

script_00ea:
    sEND                                               ;; 0d:474f $00

script_00eb:
    sEND                                               ;; 0d:4750 $00

script_00ec:
    sSET_NPC_TYPES 60                                  ;; 0d:4751 $fc $3c
    sSPAWN_NPC 1                                       ;; 0d:4753 $fd $01
    sEND                                               ;; 0d:4755 $00

script_00ed:
    sEND                                               ;; 0d:4756 $00

script_00ee:
    sEND                                               ;; 0d:4757 $00

script_00ef:
    sIF_FLAG wScriptFlags05.5                          ;; 0d:4758 $08 $2d $00 $06
      sCALL script_0543                                ;; 0d:475c $02 $77 $4e
      sCALL script_0542                                ;; 0d:475f $02 $77 $14
    sENDIF                                             ;; 0d:4762
    sIF_FLAG wScriptFlags05.4, !wScriptFlags03.7       ;; 0d:4762 $08 $2c $9f $00 $09
      sCALL script_0537                                ;; 0d:4767 $02 $64 $da
      sCALL script_0538                                ;; 0d:476a $02 $66 $80
      sCALL script_0539                                ;; 0d:476d $02 $67 $54
    sENDIF                                             ;; 0d:4770
    sIF_FLAG !wScriptFlags01.1                         ;; 0d:4770 $08 $89 $00 $09
      sCALL script_0534                                ;; 0d:4774 $02 $62 $b2
      sCALL script_0535                                ;; 0d:4777 $02 $63 $de
      sCALL script_0536                                ;; 0d:477a $02 $64 $3a
    sENDIF                                             ;; 0d:477d
    sEND                                               ;; 0d:477d $00

script_00f0:
    sEND                                               ;; 0d:477e $00

script_00f1:
    sEND                                               ;; 0d:477f $00

script_00f2:
    sCLOSE_WEST_DOOR                                   ;; 0d:4780 $e7
    sSET_NPC_TYPES 22                                  ;; 0d:4781 $fc $16
    sSPAWN_NPC 2                                       ;; 0d:4783 $fd $02
    sSPAWN_NPC 2                                       ;; 0d:4785 $fd $02
    sEND                                               ;; 0d:4787 $00

script_00f3:
    sEND                                               ;; 0d:4788 $00

script_00f4:
    sIF_FLAG !wScriptFlags07.4                         ;; 0d:4789 $08 $bc $00 $07
      sSET_NPC_TYPES 89                                ;; 0d:478d $fc $59
      sSPAWN_NPC 0                                     ;; 0d:478f $fd $00
      sSET_CHEST_OPEN_SCRIPT1 script_0463              ;; 0d:4791 $c9 $04 $63
    sENDIF                                             ;; 0d:4794
    sOPEN_WEST_DOOR                                    ;; 0d:4794 $e6
    sEND                                               ;; 0d:4795 $00

script_00f5:
    sIF_FLAG !wScriptFlags01.3                         ;; 0d:4796 $08 $8b $00 $06
      sSET_NPC_TYPES 42                                ;; 0d:479a $fc $2a
      sSPAWN_NPC 0                                     ;; 0d:479c $fd $00
      sSPAWN_NPC 2                                     ;; 0d:479e $fd $02
    sENDIF                                             ;; 0d:47a0
    sIF_FLAG !wScriptFlags01.2                         ;; 0d:47a0 $08 $8a $00 $19
      sSET_MUSIC 0                                     ;; 0d:47a4 $f8 $00
      sSPAWN_NPC 1                                     ;; 0d:47a6 $fd $01
      sSPAWN_NPC 1
      sMSG                                             ;; 0d:47a8 $04
        db "<10> HELP!\n H E L P!!<12>"
        db "<11>", $00 ;; 0d:47a9
      sSET_MUSIC 26                                    ;; 0d:47bb $f8 $1a
    sENDIF                                             ;; 0d:47bd
    sIF_FLAG wScriptFlags01.3                          ;; 0d:47bd $08 $0b $00 $03
      sCALL script_0043                                ;; 0d:47c1 $02 $03 $ec
    sENDIF                                             ;; 0d:47c4
    sEND                                               ;; 0d:47c4 $00

script_00f6:
    sIF_FLAG !wScriptFlags01.3                         ;; 0d:47c5 $08 $8b $00 $02
      sSET_MUSIC 20                                    ;; 0d:47c9 $f8 $14
    sENDIF                                             ;; 0d:47cb
    sEND                                               ;; 0d:47cb $00

script_00f7:
    sIF_FLAG !wScriptFlags01.2                         ;; 0d:47cc $08 $8a $00 $04
      sSET_MUSIC 0                                     ;; 0d:47d0 $f8 $00
      sSET_FLAG wScriptFlags01.2                       ;; 0d:47d2 $da $0a
    sENDIF                                             ;; 0d:47d4
    sEND                                               ;; 0d:47d4 $00

script_00f8:
    sSET_NPC_TYPES 43                                  ;; 0d:47d5 $fc $2b
    sSPAWN_NPC 0                                       ;; 0d:47d7 $fd $00
    sEND                                               ;; 0d:47d9 $00

script_00f9:
    sEND                                               ;; 0d:47da $00

script_00fa:
    sEND                                               ;; 0d:47db $00

script_00fb:
    sSET_NPC_TYPES 43                                  ;; 0d:47dc $fc $2b
    sSPAWN_NPC 1                                       ;; 0d:47de $fd $01
    sEND                                               ;; 0d:47e0 $00

script_00fc:
    sEND                                               ;; 0d:47e1 $00

script_00fd:
    sEND                                               ;; 0d:47e2 $00

script_00fe:
    sSET_NPC_TYPES 49                                  ;; 0d:47e3 $fc $31
    sSPAWN_NPC 1                                       ;; 0d:47e5 $fd $01
    sSPAWN_NPC 2                                       ;; 0d:47e7 $fd $02
    sEND                                               ;; 0d:47e9 $00

script_00ff:
    sEND                                               ;; 0d:47ea $00

script_0100:
    sEND                                               ;; 0d:47eb $00

script_0101:
    sSET_NPC_TYPES 26                                  ;; 0d:47ec $fc $1a
    sSPAWN_NPC 0                                       ;; 0d:47ee $fd $00
    sSPAWN_NPC 0                                       ;; 0d:47f0 $fd $00
    sEND                                               ;; 0d:47f2 $00

script_0102:
    sEND                                               ;; 0d:47f3 $00

script_0103:
    sIF_FLAG !wScriptFlags07.6                         ;; 0d:47f4 $08 $be $00 $07
      sSET_NPC_TYPES 89                                ;; 0d:47f8 $fc $59
      sSPAWN_NPC 0                                     ;; 0d:47fa $fd $00
      sSET_CHEST_OPEN_SCRIPT1 script_0461              ;; 0d:47fc $c9 $04 $61
    sENDIF                                             ;; 0d:47ff
    sEND                                               ;; 0d:47ff $00

script_0104:
    sEND                                               ;; 0d:4800 $00

script_0105:
    sEND                                               ;; 0d:4801 $00

script_0106:
    sIF_FLAG !wScriptFlags02.0                         ;; 0d:4802 $08 $90 $00 $06
      sSET_NPC_TYPES 51                                ;; 0d:4806 $fc $33
      sSPAWN_NPC 0                                     ;; 0d:4808 $fd $00
      sSPAWN_NPC 1                                     ;; 0d:480a $fd $01
    sENDIF                                             ;; 0d:480c
    sIF_FLAG wScriptFlags02.0, !wScriptFlags02.1       ;; 0d:480c $08 $10 $91 $00 $0a
      sSET_NPC_TYPES 0                                 ;; 0d:4811 $fc $00
      sSPAWN_NPC 0                                     ;; 0d:4813 $fd $00
      sSPAWN_NPC 1                                     ;; 0d:4815 $fd $01
      sFLASH_SCREEN                                    ;; 0d:4817 $bf
      sSFX 20                                          ;; 0d:4818 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:481a $bf
    sENDIF                                             ;; 0d:481b
    sIF_FLAG wScriptFlags02.1                          ;; 0d:481b $08 $11 $00 $06
      sSET_NPC_TYPES 51                                ;; 0d:481f $fc $33
      sSPAWN_NPC 0                                     ;; 0d:4821 $fd $00
      sSPAWN_NPC 1                                     ;; 0d:4823 $fd $01
    sENDIF                                             ;; 0d:4825
    sEND                                               ;; 0d:4825 $00

script_0107:
    sEND                                               ;; 0d:4826 $00

script_0108:
    sEND                                               ;; 0d:4827 $00

script_0109:
    sIF_FLAG !wScriptFlags02.0                         ;; 0d:4828 $08 $90 $00 $04
      sSET_NPC_TYPES 52                                ;; 0d:482c $fc $34
      sSPAWN_NPC 0                                     ;; 0d:482e $fd $00
    sENDIF                                             ;; 0d:4830
    sIF_FLAG wScriptFlags02.0, !wScriptFlags02.1       ;; 0d:4830 $08 $10 $91 $00 $0a
      sSET_NPC_TYPES 0                                 ;; 0d:4835 $fc $00
      sSPAWN_NPC 0                                     ;; 0d:4837 $fd $00
      sSPAWN_NPC 1                                     ;; 0d:4839 $fd $01
      sSFX 20                                          ;; 0d:483b $f9 $14
      sFLASH_SCREEN                                    ;; 0d:483d $bf
      sFLASH_SCREEN                                    ;; 0d:483e $bf
    sENDIF                                             ;; 0d:483f
    sIF_FLAG wScriptFlags02.1                          ;; 0d:483f $08 $11 $00 $04
      sSET_NPC_TYPES 52                                ;; 0d:4843 $fc $34
      sSPAWN_NPC 0                                     ;; 0d:4845 $fd $00
    sENDIF                                             ;; 0d:4847
    sEND                                               ;; 0d:4847 $00

script_010a:
    sEND                                               ;; 0d:4848 $00

script_010b:
    sEND                                               ;; 0d:4849 $00

script_010c:
    sIF_FLAG wScriptFlags02.0, !wScriptFlags02.1       ;; 0d:484a $08 $10 $91 $00 $04
      sSET_NPC_TYPES 36                                ;; 0d:484f $fc $24
      sSPAWN_NPC 2                                     ;; 0d:4851 $fd $02
    sENDIF                                             ;; 0d:4853
    sEND                                               ;; 0d:4853 $00

script_010d:
    sEND                                               ;; 0d:4854 $00

script_010e:
    sEND                                               ;; 0d:4855 $00

script_010f:
    sSET_NPC_TYPES 55                                  ;; 0d:4856 $fc $37
    sIF_FLAG wScriptFlags02.0, !wScriptFlags03.7       ;; 0d:4858 $08 $10 $9f $00 $02
      sSPAWN_NPC 2                                     ;; 0d:485d $fd $02
    sENDIF                                             ;; 0d:485f
    sIF_FLAG !wScriptFlags02.0                         ;; 0d:485f $08 $90 $00 $be
      sFOLLOWER_DIRECTION_UP                           ;; 0d:4863 $94
      sFOLLOWER_SET_POSITION 9, 14                     ;; 0d:4864 $99 $09 $0e
      sSPAWN_NPC 2                                     ;; 0d:4867 $fd $02
      sSET_PLAYER_DIRECTION_UP                         ;; 0d:4869 $84
      sSET_PLAYER_POSITION 9, 14                       ;; 0d:486a $8a $09 $0e
      sPLAYER_STEP_FORWARD                             ;; 0d:486d $80
      sPLAYER_STEP_FORWARD                             ;; 0d:486e $80
      sSET_PLAYER_DIRECTION_LEFT                       ;; 0d:486f $87
      sLOOP 3, 2                                       ;; 0d:4870 $03 $03 $02
        sPLAYER_STEP_FORWARD                           ;; 0d:4873 $80
      sEND                                             ;; 0d:4874 $00
      sSET_PLAYER_DIRECTION_RIGHT                      ;; 0d:4875 $86
      sSET_NPC_1_DIRECTION_LEFT                        ;; 0d:4876 $17
      sNPC_1_STEP_FORWARD                              ;; 0d:4877 $10
      sSET_NPC_1_DIRECTION_DOWN                        ;; 0d:4878 $15
      sLOOP 6, 2                                       ;; 0d:4879 $03 $06 $02
        sNPC_1_STEP_FORWARD                            ;; 0d:487c $10
      sEND                                             ;; 0d:487d $00
      sMSG                                             ;; 0d:487e $04
        db "<10>Cibba:I am Cibba,\n a Gemma Knight.\n Bogard sent word.<12>"
        db "<1b> _ Oh yes, that is\n the Mana Symbol\n on your Pendant.<12>"
        db "<1b> Step forward.\n It will show you\n your quest.<12>"
        db "<11>", $00 ;; 0d:487f
      sSET_NPC_1_DIRECTION_LEFT                        ;; 0d:48e1 $17
      sLOOP 3, 2                                       ;; 0d:48e2 $03 $03 $02
        sNPC_1_STEP_BACKWARDS                          ;; 0d:48e5 $11
      sEND                                             ;; 0d:48e6 $00
      sLOOP 4, 2                                       ;; 0d:48e7 $03 $04 $02
        sFOLLOWER_STEP_FORWARD                         ;; 0d:48ea $90
      sEND                                             ;; 0d:48eb $00
      sDELAY 20                                        ;; 0d:48ec $f0 $14
      sFOLLOWER_STEP_FORWARD                           ;; 0d:48ee $90
      sDELAY 10                                        ;; 0d:48ef $f0 $0a
      sFOLLOWER_STEP_FORWARD                           ;; 0d:48f1 $90
      sDELAY 10                                        ;; 0d:48f2 $f0 $0a
      sFOLLOWER_STEP_FORWARD                           ;; 0d:48f4 $90
      sSET_PLAYER_DIRECTION_LEFT                       ;; 0d:48f5 $87
      sSET_NPC_1_DIRECTION_RIGHT                       ;; 0d:48f6 $16
      sPLAYER_STEP_FORWARD                             ;; 0d:48f7 $80
      sNPC_1_STEP_FORWARD                              ;; 0d:48f8 $10
      sPLAYER_STEP_FORWARD                             ;; 0d:48f9 $80
      sNPC_1_STEP_FORWARD                              ;; 0d:48fa $10
      sSET_PLAYER_DIRECTION_UP                         ;; 0d:48fb $84
      sSET_NPC_1_DIRECTION_UP                          ;; 0d:48fc $14
      sLOOP 6, 3                                       ;; 0d:48fd $03 $06 $03
        sPLAYER_STEP_FORWARD                           ;; 0d:4900 $80
        sNPC_1_STEP_FORWARD                            ;; 0d:4901 $10
      sEND                                             ;; 0d:4902 $00
      sSET_MUSIC 0                                     ;; 0d:4903 $f8 $00
      sDELAY 60                                        ;; 0d:4905 $f0 $3c
      sFLASH_SCREEN                                    ;; 0d:4907 $bf
      sSFX 20                                          ;; 0d:4908 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:490a $bf
      sDELAY 20                                        ;; 0d:490b $f0 $14
      sSFX 37                                          ;; 0d:490d $f9 $25
      sLOOP 5, 2                                       ;; 0d:490f $03 $05 $02
        sFLASH_SCREEN                                  ;; 0d:4912 $bf
      sEND                                             ;; 0d:4913 $00
      sFADE_TO_BLACK                                   ;; 0d:4914 $bd
      sDELAY 40                                        ;; 0d:4915 $f0 $28
      sSET_MUSIC 3                                     ;; 0d:4917 $f8 $03
      sDELAY 200                                       ;; 0d:4919 $f0 $c8
      sSPAWN_NPC 1                                     ;; 0d:491b $fd $01
      sFADE_TO_NORMAL                                  ;; 0d:491d $bc
      sCALL script_053a                                ;; 0d:491e $02 $68 $e9
    sENDIF                                             ;; 0d:4921
    sEND                                               ;; 0d:4921 $00

script_0110:
    sEND                                               ;; 0d:4922 $00

script_0111:
    sEND                                               ;; 0d:4923 $00

script_0112:
    sSET_NPC_TYPES 45                                  ;; 0d:4924 $fc $2d
    sSPAWN_NPC 0                                       ;; 0d:4926 $fd $00
    sSPAWN_NPC 1                                       ;; 0d:4928 $fd $01
    sEND                                               ;; 0d:492a $00

script_0113:
    sEND                                               ;; 0d:492b $00

script_0114:
    sEND                                               ;; 0d:492c $00

script_0115:
    sSET_NPC_TYPES 46                                  ;; 0d:492d $fc $2e
    sSPAWN_NPC 0                                       ;; 0d:492f $fd $00
    sEND                                               ;; 0d:4931 $00

script_0116:
    sEND                                               ;; 0d:4932 $00

script_0117:
    sEND                                               ;; 0d:4933 $00

script_0118:
    sSET_NPC_TYPES 47                                  ;; 0d:4934 $fc $2f
    sSPAWN_NPC 0                                       ;; 0d:4936 $fd $00
    sSPAWN_NPC 1                                       ;; 0d:4938 $fd $01
    sEND                                               ;; 0d:493a $00

script_0119:
    sEND                                               ;; 0d:493b $00

script_011a:
    sEND                                               ;; 0d:493c $00

script_011b:
    sIF_FLAG wScriptFlags04.6                          ;; 0d:493d $08 $26 $00 $04
      sSET_NPC_TYPES 48                                ;; 0d:4941 $fc $30
      sSPAWN_NPC 0                                     ;; 0d:4943 $fd $00
    sENDIF                                             ;; 0d:4945
    sEND                                               ;; 0d:4945 $00

script_011c:
    sEND                                               ;; 0d:4946 $00

script_011d:
    sEND                                               ;; 0d:4947 $00

script_011e:
    sIF_FLAG !wScriptFlags03.0                         ;; 0d:4948 $08 $98 $00 $0f
      sSET_MUSIC 15                                    ;; 0d:494c $f8 $0f
      sSET_NPC_TYPES 108                               ;; 0d:494e $fc $6c
      sLOOP 5, 4                                       ;; 0d:4950 $03 $05 $04
        sSFX 20                                        ;; 0d:4953 $f9 $14
        sFLASH_SCREEN                                  ;; 0d:4955 $bf
      sEND                                             ;; 0d:4956 $00
      sSPAWN_NPC 0                                     ;; 0d:4957 $fd $00
    sELSE                                              ;; 0d:4959 $01 $32
      sLOOP 3, 4                                       ;; 0d:495b $03 $03 $04
        sSFX 20                                        ;; 0d:495e $f9 $14
        sFLASH_SCREEN                                  ;; 0d:4960 $bf
      sEND                                             ;; 0d:4961 $00
      sMSG                                             ;; 0d:4962 $04
        db "<10>Julius:Now see\n the true power\n of Mana!<12>"
        db "<11>", $00 ;; 0d:4963
      sSPAWN_BOSS 14
      sLOOP 5, 4                                       ;; 0d:4982 $03 $05 $04
        sSFX 20                                        ;; 0d:4985 $f9 $14
        sFLASH_SCREEN                                  ;; 0d:4987 $bf
      sEND                                             ;; 0d:4988 $00
      sSET_MUSIC 19                                    ;; 0d:498b $f8 $13
    sENDIF                                             ;; 0d:498d
    sEND                                               ;; 0d:498d $00

script_011f:
    sEND                                               ;; 0d:498e $00

script_0120:
    sIF_FLAG !wScriptFlags03.0                         ;; 0d:498f $08 $98 $00 $20
      sSET_MUSIC 0                                     ;; 0d:4993 $f8 $00
      sSFX 34                                          ;; 0d:4995 $f9 $22
      sSET_FLAG wScriptFlags03.0                       ;; 0d:4997 $da $18
      sDELAY 60                                        ;; 0d:4999 $f0 $3c
      sMSG                                             ;; 0d:499b $04
        db "<10> Defeated Julius.<12>"
        db "<11>", $00 ;; 0d:499c
      sDELAY 30                                        ;; 0d:49ac $f0 $1e
      sCALL script_011e                                ;; 0d:49ae $02 $09 $48
    sELSE                                              ;; 0d:49b1 $01 $b2
      sSET_MUSIC 0                                     ;; 0d:49b3 $f8 $00
      sSFX 34                                          ;; 0d:49b5 $f9 $22
      sDELAY 20                                        ;; 0d:49b7 $f0 $14
      sMSG                                             ;; 0d:49b9 $04
        db "<10>Julius:GRRRR", $00                     ;; 0d:49ba
      sDELAY 30                                        ;; 0d:49c6 $f0 $1e
      sMSG                                             ;; 0d:49c8 $04
        db " __<12>"
        db "<11>", $00            ;; 0d:49c9
      sDELAY 60                                        ;; 0d:49ce $f0 $3c
      sFADE_TO_BLACK                                   ;; 0d:49d0 $bd
      sLOAD_ROOM_INSTANT 15, $50, 8, 10                ;; 0d:49d1 $f3 $0f $50 $08 $0a
      sSET_NPC_TYPES 50                                ;; 0d:49d6 $fc $32
      sSPAWN_NPC 1                                     ;; 0d:49d8 $fd $01
      sSET_PLAYER_POSITION 8, 10                       ;; 0d:49da $8a $08 $0a
      sSET_PLAYER_DIRECTION_RIGHT                      ;; 0d:49dd $86
      sFADE_TO_NORMAL                                  ;; 0d:49de $bc
      sDELAY 100                                       ;; 0d:49df $f0 $64
      sMSG                                             ;; 0d:49e1 $04
        db "<10><GIRL>:__ <BOY>.\n<BOY>:Are you\n okay, <GIRL>?<12>"
        db "<1b><BOY>:I defeated\n Julius.\n It's all over.<12>"
        db "<11>", $00 ;; 0d:49e2
      sDELAY 60                                        ;; 0d:4a17 $f0 $3c
      sMSG                                             ;; 0d:4a19 $04
        db "<10>Julius:__ No!!\n __ It is not!<12>"
        db "<11>", $00 ;; 0d:4a1a
      sSET_PLAYER_DIRECTION_UP                         ;; 0d:4a33 $84
      sSET_NPC_1_DIRECTION_UP                          ;; 0d:4a34 $14
      sLOOP 5, 4                                       ;; 0d:4a35 $03 $05 $04
        sSFX 20                                        ;; 0d:4a38 $f9 $14
        sFLASH_SCREEN                                  ;; 0d:4a3a $bf
      sEND                                             ;; 0d:4a3b $00
      sDELAY 40                                        ;; 0d:4a3c $f0 $28
      sMSG                                             ;; 0d:4a3e $04
        db "<10>Julius:<BOY>!\n You will never\n leave here alive!<12>"
        db "<11>", $00 ;; 0d:4a3f
      sGIVE_FOLLOWER 1                                 ;; 0d:4a60 $9c $01
      sSET_FLAG wScriptFlags0A.1                       ;; 0d:4a62 $da $51
      sRUN_ROOM_SCRIPT                                 ;; 0d:4a64 $ec
    sENDIF                                             ;; 0d:4a65
    sEND                                               ;; 0d:4a65 $00

script_0121:
    sIF_FLAG !wScriptFlags02.0                         ;; 0d:4a66 $08 $90 $00 $04
      sSET_NPC_TYPES 55                                ;; 0d:4a6a $fc $37
      sSPAWN_NPC 0                                     ;; 0d:4a6c $fd $00
    sENDIF                                             ;; 0d:4a6e
    sIF_FLAG wScriptFlags02.0, !wScriptFlags02.1       ;; 0d:4a6e $08 $10 $91 $00 $0a
      sSET_NPC_TYPES 0                                 ;; 0d:4a73 $fc $00
      sSPAWN_NPC 0                                     ;; 0d:4a75 $fd $00
      sSPAWN_NPC 1                                     ;; 0d:4a77 $fd $01
      sSFX 20                                          ;; 0d:4a79 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:4a7b $bf
      sFLASH_SCREEN                                    ;; 0d:4a7c $bf
    sENDIF                                             ;; 0d:4a7d
    sIF_FLAG wScriptFlags05.7                          ;; 0d:4a7d $08 $2f $00 $04
      sSET_NPC_TYPES 52                                ;; 0d:4a81 $fc $34
      sSPAWN_NPC 1                                     ;; 0d:4a83 $fd $01
    sENDIF                                             ;; 0d:4a85
    sEND                                               ;; 0d:4a85 $00

script_0122:
    sEND                                               ;; 0d:4a86 $00

script_0123:
    sEND                                               ;; 0d:4a87 $00

script_0124:
    sIF_FLAG !wScriptFlags04.6                         ;; 0d:4a88 $08 $a6 $00 $04
      sSET_NPC_TYPES 44                                ;; 0d:4a8c $fc $2c
      sSPAWN_NPC 2                                     ;; 0d:4a8e $fd $02
    sENDIF                                             ;; 0d:4a90
    sEND                                               ;; 0d:4a90 $00

script_0125:
    sEND                                               ;; 0d:4a91 $00

script_0126:
    sEND                                               ;; 0d:4a92 $00

script_0127:
    sSET_NPC_TYPES 89                                  ;; 0d:4a93 $fc $59
    sIF_FLAG !wScriptFlags09.5                         ;; 0d:4a95 $08 $cd $00 $05
      sSPAWN_NPC 1                                     ;; 0d:4a99 $fd $01
      sSET_CHEST_OPEN_SCRIPT1 script_0443              ;; 0d:4a9b $c9 $04 $43
    sENDIF                                             ;; 0d:4a9e
    sEND                                               ;; 0d:4a9e $00

script_0128:
    sEND                                               ;; 0d:4a9f $00

script_0129:
    sEND                                               ;; 0d:4aa0 $00

script_012a:
    sSET_NPC_TYPES 4                                   ;; 0d:4aa1 $fc $04
    sIF_FLAG !wScriptFlags.1
      sSPAWN_NPC 2
    sENDIF
    sSPAWN_NPC 0                                       ;; 0d:4aa5 $fd $00
    sEND                                               ;; 0d:4aa7 $00

script_012b:
    sEND                                               ;; 0d:4aa8 $00

script_012c:
    sEND                                               ;; 0d:4aa9 $00

script_012d:
    sSET_NPC_TYPES 63                                  ;; 0d:4aaa $fc $3f
    sSPAWN_NPC 1                                       ;; 0d:4aac $fd $01
    sEND                                               ;; 0d:4aae $00

script_012e:
    sEND                                               ;; 0d:4aaf $00

script_012f:
    sEND                                               ;; 0d:4ab0 $00

script_0130:
    sIF_FLAG wScriptFlags02.6                          ;; 0d:4ab1 $08 $16 $00 $04
      sSET_NPC_TYPES 96                                ;; 0d:4ab5 $fc $60
      sSPAWN_NPC 0                                     ;; 0d:4ab7 $fd $00
    sENDIF                                             ;; 0d:4ab9
    sEND                                               ;; 0d:4ab9 $00

script_0131:
    sEND                                               ;; 0d:4aba $00

script_0132:
    sEND                                               ;; 0d:4abb $00

script_0133:
    sSET_NPC_TYPES 64                                  ;; 0d:4abc $fc $40
    sSPAWN_NPC 0                                       ;; 0d:4abe $fd $00
    sEND                                               ;; 0d:4ac0 $00

script_0134:
    sEND                                               ;; 0d:4ac1 $00

script_0135:
    sEND                                               ;; 0d:4ac2 $00

script_0136:
    sSET_NPC_TYPES 64                                  ;; 0d:4ac3 $fc $40
    sSPAWN_NPC 1                                       ;; 0d:4ac5 $fd $01
    sEND                                               ;; 0d:4ac7 $00

script_0137:
    sEND                                               ;; 0d:4ac8 $00

script_0138:
    sEND                                               ;; 0d:4ac9 $00

script_0139:
    sSET_NPC_TYPES 5                                   ;; 0d:4aca $fc $05
    sIF_FLAG !wScriptFlags.3
      sSPAWN_NPC 2
    sENDIF
    sSPAWN_NPC 0                                       ;; 0d:4ace $fd $00
    sEND                                               ;; 0d:4ad0 $00

script_013a:
    sEND                                               ;; 0d:4ad1 $00

script_013b:
    sEND                                               ;; 0d:4ad2 $00

script_013c:
    sSET_NPC_TYPES 64                                  ;; 0d:4ad3 $fc $40
    sSPAWN_NPC 2                                       ;; 0d:4ad5 $fd $02
    sEND                                               ;; 0d:4ad7 $00

script_013d:
    sEND                                               ;; 0d:4ad8 $00

script_013e:
    sEND                                               ;; 0d:4ad9 $00

script_013f:
    sSET_NPC_TYPES 88                                  ;; 0d:4ada $fc $58
    sSPAWN_NPC 0                                       ;; 0d:4adc $fd $00
    sSPAWN_NPC 1                                       ;; 0d:4ade $fd $01
    sIF_FLAG wScriptFlags02.6, !wScriptFlags0A.4       ;; 0d:4ae0 $08 $16 $d4 $00 $02
      sSPAWN_NPC 2                                     ;; 0d:4ae5 $fd $02
    sENDIF                                             ;; 0d:4ae7
    sEND                                               ;; 0d:4ae7 $00

script_0140:
    sIF_FLAG wScriptFlags02.6, wScriptFlags0A.4        ;; 0d:4ae8 $08 $16 $54 $00 $27
      sMSG                                             ;; 0d:4aed $04
        db "<10>Bogard:I'll stay\n and guard <GIRL>.\n<BOY>:__ Okay.<12>"
        db "<11>", $00 ;; 0d:4aee
      sFOLLOWER_DELETE                                 ;; 0d:4b11 $98
      sCLEAR_FLAG wScriptFlags0A.4                     ;; 0d:4b12 $db $54
    sENDIF                                             ;; 0d:4b14
    sEND                                               ;; 0d:4b14 $00

script_0141:
    sEND                                               ;; 0d:4b15 $00

script_0142:
    sSET_NPC_TYPES 56                                  ;; 0d:4b16 $fc $38
    sSPAWN_NPC 0                                       ;; 0d:4b18 $fd $00
    sSPAWN_NPC 1                                       ;; 0d:4b1a $fd $01
    sEND                                               ;; 0d:4b1c $00

script_0143:
    sEND                                               ;; 0d:4b1d $00

script_0144:
    sEND                                               ;; 0d:4b1e $00

script_0145:
    sSET_NPC_TYPES 57                                  ;; 0d:4b1f $fc $39
    sSPAWN_NPC 0                                       ;; 0d:4b21 $fd $00
    sSPAWN_NPC 1                                       ;; 0d:4b23 $fd $01
    sEND                                               ;; 0d:4b25 $00

script_0146:
    sEND                                               ;; 0d:4b26 $00

script_0147:
    sEND                                               ;; 0d:4b27 $00

script_0148:
    sSET_NPC_TYPES 59                                  ;; 0d:4b28 $fc $3b
    sSPAWN_NPC 0                                       ;; 0d:4b2a $fd $00
    sEND                                               ;; 0d:4b2c $00

script_0149:
    sEND                                               ;; 0d:4b2d $00

script_014a:
    sEND                                               ;; 0d:4b2e $00

script_014b:
    sSET_NPC_TYPES 60                                  ;; 0d:4b2f $fc $3c
    sSPAWN_NPC 0                                       ;; 0d:4b31 $fd $00
    sEND                                               ;; 0d:4b33 $00

script_014c:
    sEND                                               ;; 0d:4b34 $00

script_014d:
    sEND                                               ;; 0d:4b35 $00

script_014e:
    sSET_NPC_TYPES 59                                  ;; 0d:4b36 $fc $3b
    sSPAWN_NPC 2                                       ;; 0d:4b38 $fd $02
    sEND                                               ;; 0d:4b3a $00

script_014f:
    sEND                                               ;; 0d:4b3b $00

script_0150:
    sEND                                               ;; 0d:4b3c $00

script_0151:
    sSET_NPC_TYPES 48                                  ;; 0d:4b3d $fc $30
    sSPAWN_NPC 1                                       ;; 0d:4b3f $fd $01
    sEND                                               ;; 0d:4b41 $00

script_0152:
    sEND                                               ;; 0d:4b42 $00

script_0153:
    sEND                                               ;; 0d:4b43 $00

script_0154:
    sSET_NPC_TYPES 65                                  ;; 0d:4b44 $fc $41
    sIF_FLAG !wScriptFlags04.7                         ;; 0d:4b46 $08 $a7 $00 $04
      sSPAWN_NPC 0                                     ;; 0d:4b4a $fd $00
      sSPAWN_NPC 1                                     ;; 0d:4b4c $fd $01
    sENDIF                                             ;; 0d:4b4e
    sIF_FLAG wScriptFlags04.7, !wScriptFlags03.5       ;; 0d:4b4e $08 $27 $9d $00 $02
      sSPAWN_NPC 1                                     ;; 0d:4b53 $fd $01
    sENDIF                                             ;; 0d:4b55
    sIF_FLAG wScriptFlags03.5                          ;; 0d:4b55 $08 $1d $00 $04
      sSET_ROOM_TILE $02, 8, 6                         ;; 0d:4b59 $b0 $02 $08 $06
    sENDIF                                             ;; 0d:4b5d
    sIF_FLAG wScriptFlags03.5, !wScriptFlags0A.6, !wScriptFlags05.0 ;; 0d:4b5d $08 $1d $d6 $a8 $00 $2c
      sSPAWN_NPC 2                                     ;; 0d:4b63 $fd $02
      sGIVE_FOLLOWER 6                                 ;; 0d:4b65 $9c $06
      sPLAYER_STEP_FORWARD                             ;; 0d:4b67 $80
      sPLAYER_STEP_FORWARD                             ;; 0d:4b68 $80
      sPLAYER_STEP_FORWARD                             ;; 0d:4b69 $80
      sSET_NPC_1_DIRECTION_LEFT                        ;; 0d:4b6a $17
      sMSG                                             ;; 0d:4b6b $04
        db "<10>Lester:Phew__\n I was helpless\n all by myself.<12>"
        db "<11>", $00 ;; 0d:4b6c
      sSET_FLAG wScriptFlags0A.6                       ;; 0d:4b8d $da $56
    sENDIF                                             ;; 0d:4b8f
    sEND                                               ;; 0d:4b8f $00

script_0155:
    sEND                                               ;; 0d:4b90 $00

script_0156:
    sEND                                               ;; 0d:4b91 $00

script_0157:
    sIF_FLAG !wScriptFlags03.7
      sSET_NPC_TYPES 76                                ;; 0d:4b97 $fc $4c
      sSPAWN_NPC 1                                     ;; 0d:4b99 $fd $01
      sIF_FLAG wScriptFlags04.0
        sSET_NPC_1_DIRECTION_RIGHT
        sNPC_1_STEP_BACKWARDS
        sNPC_1_STEP_BACKWARDS
        sSET_NPC_1_DIRECTION_DOWN
        sNPC_1_STEP_BACKWARDS
        sNPC_1_STEP_BACKWARDS
      sENDIF
    sENDIF                                             ;; 0d:4b9b
    sEND                                               ;; 0d:4b9b $00

script_0158:
    sEND                                               ;; 0d:4b9c $00

script_0159:
    sEND                                               ;; 0d:4b9d $00

script_015a:
    sSET_NPC_TYPES 72                                  ;; 0d:4b9e $fc $48
    sSPAWN_NPC 0                                       ;; 0d:4ba0 $fd $00
    sSPAWN_NPC 1                                       ;; 0d:4ba2 $fd $01
    sSET_FLAG wScriptFlags03.7
    sEND                                               ;; 0d:4ba4 $00

script_015b:
    sEND                                               ;; 0d:4ba5 $00

script_015c:
    sEND                                               ;; 0d:4ba6 $00

script_015d:
    sSET_NPC_TYPES 73                                  ;; 0d:4ba7 $fc $49
    sSPAWN_NPC 0                                       ;; 0d:4ba9 $fd $00
    sSPAWN_NPC 1                                       ;; 0d:4bab $fd $01
    sEND                                               ;; 0d:4bad $00

script_015e:
    sEND                                               ;; 0d:4bae $00

script_015f:
    sEND                                               ;; 0d:4baf $00

script_0160:
    sSET_NPC_TYPES 67                                  ;; 0d:4bb0 $fc $43
    sSPAWN_NPC 0                                       ;; 0d:4bb2 $fd $00
    sEND                                               ;; 0d:4bb4 $00

script_0161:
    sEND                                               ;; 0d:4bb5 $00

script_0162:
    sEND                                               ;; 0d:4bb6 $00

script_0163:
    sSET_NPC_TYPES 67                                  ;; 0d:4bb7 $fc $43
    sSPAWN_NPC 1                                       ;; 0d:4bb9 $fd $01
    sEND                                               ;; 0d:4bbb $00

script_0164:
    sEND                                               ;; 0d:4bbc $00

script_0165:
    sEND                                               ;; 0d:4bbd $00

script_0166:
    sSET_NPC_TYPES 67                                  ;; 0d:4bbe $fc $43
    sSPAWN_NPC 2                                       ;; 0d:4bc0 $fd $02
    sEND                                               ;; 0d:4bc2 $00

script_0167:
    sEND                                               ;; 0d:4bc3 $00

script_0168:
    sEND                                               ;; 0d:4bc4 $00

script_0169:
    sSET_NPC_TYPES 68                                  ;; 0d:4bc5 $fc $44
    sSPAWN_NPC 0                                       ;; 0d:4bc7 $fd $00
    sEND                                               ;; 0d:4bc9 $00

script_016a:
    sEND                                               ;; 0d:4bca $00

script_016b:
    sEND                                               ;; 0d:4bcb $00

script_016c:
    sSET_NPC_TYPES 68                                  ;; 0d:4bcc $fc $44
    sSPAWN_NPC 2                                       ;; 0d:4bce $fd $02
    sEND                                               ;; 0d:4bd0 $00

script_016d:
    sEND                                               ;; 0d:4bd1 $00

script_016e:
    sEND                                               ;; 0d:4bd2 $00

script_016f:
    sSET_NPC_TYPES 68                                  ;; 0d:4bd3 $fc $44
    sSPAWN_NPC 1                                       ;; 0d:4bd5 $fd $01
    sEND                                               ;; 0d:4bd7 $00

script_0170:
    sEND                                               ;; 0d:4bd8 $00

script_0171:
    sEND                                               ;; 0d:4bd9 $00

script_0172:
    sSET_NPC_TYPES 69                                  ;; 0d:4bda $fc $45
    sSPAWN_NPC 0                                       ;; 0d:4bdc $fd $00
    sEND                                               ;; 0d:4bde $00

script_0173:
    sEND                                               ;; 0d:4bdf $00

script_0174:
    sEND                                               ;; 0d:4be0 $00

script_0175:
    sSET_NPC_TYPES 69                                  ;; 0d:4be1 $fc $45
    sSPAWN_NPC 1                                       ;; 0d:4be3 $fd $01
    sEND                                               ;; 0d:4be5 $00

script_0176:
    sEND                                               ;; 0d:4be6 $00

script_0177:
    sEND                                               ;; 0d:4be7 $00

script_0178:
    sIF_FLAG !wScriptFlags03.6                         ;; 0d:4be8 $08 $9e $00 $04
      sSET_NPC_TYPES 40                                ;; 0d:4bec $fc $28
      sSPAWN_NPC 2                                     ;; 0d:4bee $fd $02
    sENDIF                                             ;; 0d:4bf0
    sEND                                               ;; 0d:4bf0 $00

script_0179:
    sEND                                               ;; 0d:4bf1 $00

script_017a:
    sEND                                               ;; 0d:4bf2 $00

script_017b:
    sSET_NPC_TYPES 70                                  ;; 0d:4bf3 $fc $46
    sIF_FLAG !wScriptFlags05.5                         ;; 0d:4bf5 $08 $ad $00 $04
      sSPAWN_NPC 1                                     ;; 0d:4bf9 $fd $01
    sELSE                                              ;; 0d:4bfb $01 $02
      sSPAWN_NPC 0                                     ;; 0d:4bfd $fd $00
    sENDIF                                             ;; 0d:4bff
    sEND                                               ;; 0d:4bff $00

script_017c:
    sEND                                               ;; 0d:4c00 $00

script_017d:
    sEND                                               ;; 0d:4c01 $00

script_017e:
    sSET_NPC_TYPES 70                                  ;; 0d:4c02 $fc $46
    sSPAWN_NPC 2                                       ;; 0d:4c04 $fd $02
    sEND                                               ;; 0d:4c06 $00

script_017f:
    sEND                                               ;; 0d:4c07 $00

script_0180:
    sEND                                               ;; 0d:4c08 $00

script_0181:
    sSET_NPC_TYPES 71                                  ;; 0d:4c09 $fc $47
    sIF_FLAG !wScriptFlags05.5                         ;; 0d:4c0b $08 $ad $00 $04
      sSPAWN_NPC 1                                     ;; 0d:4c0f $fd $01
    sELSE                                              ;; 0d:4c11 $01 $02
      sSPAWN_NPC 0                                     ;; 0d:4c13 $fd $00
    sENDIF                                             ;; 0d:4c15
    sEND                                               ;; 0d:4c15 $00

script_0182:
    sEND                                               ;; 0d:4c16 $00

script_0183:
    sEND                                               ;; 0d:4c17 $00

script_0184:
    sSET_NPC_TYPES 55                                  ;; 0d:4c18 $fc $37
    sSPAWN_NPC 2                                       ;; 0d:4c1a $fd $02
    sEND                                               ;; 0d:4c1c $00

script_0185:
    sEND                                               ;; 0d:4c1d $00

script_0186:
    sEND                                               ;; 0d:4c1e $00

script_0187:
    sSET_NPC_TYPES 6                                   ;; 0d:4c1f $fc $06
    sIF_FLAG !wScriptFlags.2
      sSPAWN_NPC 2
    sENDIF
    sSPAWN_NPC 1                                       ;; 0d:4c23 $fd $01
    sEND                                               ;; 0d:4c25 $00

script_0188:
    sEND                                               ;; 0d:4c26 $00

script_0189:
    sEND                                               ;; 0d:4c27 $00

script_018a:
    sIF_FLAG !wScriptFlags02.0                         ;; 0d:4c28 $08 $90 $00 $04
      sSET_NPC_TYPES 53                                ;; 0d:4c2c $fc $35
      sSPAWN_NPC 0                                     ;; 0d:4c2e $fd $00
    sENDIF                                             ;; 0d:4c30
    sEND                                               ;; 0d:4c30 $00

script_018b:
    sEND                                               ;; 0d:4c31 $00

script_018c:
    sEND                                               ;; 0d:4c32 $00

; Casket room entry script
script_018d:
    sIF_FLAG !wScriptFlags01.6                         ;; 0d:4c33 $08 $8e $00 $04
      sSET_NPC_TYPES 50                                ;; 0d:4c37 $fc $32
      sSPAWN_NPC 0                                     ;; 0d:4c39 $fd $00
    sELSE
      sSET_ROOM_TILE $44, 5, 5
    sENDIF                                             ;; 0d:4c3b
    sEND                                               ;; 0d:4c3b $00

script_018e:
    sEND                                               ;; 0d:4c3c $00

script_018f:
    sEND                                               ;; 0d:4c3d $00

script_0190:
    sIF_FLAG !wScriptFlags0A.2
      sIF_FLAG wScriptFlags09.0, wScriptFlags09.1
      sELSE
        sSET_NPC_TYPES 77
        sSPAWN_NPC 0
      sENDIF
    sENDIF                                             ;; 0d:4c47
    sEND                                               ;; 0d:4c47 $00

script_0191:
    sEND                                               ;; 0d:4c48 $00

script_0192:
    sEND                                               ;; 0d:4c49 $00

script_0193:
    sIF_FLAG wScriptFlags03.7                          ;; 0d:4c4a $08 $1f $00 $02
    sELSE                                              ;; 0d:4c4e $01 $08
      sIF_FLAG !wScriptFlags03.1                       ;; 0d:4c50 $08 $99 $00 $04
        sSET_NPC_TYPES 80                              ;; 0d:4c54 $fc $50
        sSPAWN_NPC 0                                   ;; 0d:4c56 $fd $00
      sENDIF                                           ;; 0d:4c58
    sENDIF                                             ;; 0d:4c58
    sEND                                               ;; 0d:4c58 $00

script_0194:
    sIF_FLAG !wScriptFlags0B.0                         ;; 0d:4c59 $08 $d8 $00 $02
      sSET_MUSIC 20                                    ;; 0d:4c5d $f8 $14
    sENDIF                                             ;; 0d:4c5f
    sEND                                               ;; 0d:4c5f $00

script_0195:
    sEND                                               ;; 0d:4c60 $00

script_0196:
    sIF_FLAG wScriptFlags02.4, !wScriptFlags04.6       ;; 0d:4c61 $08 $14 $a6 $00 $04
      sSET_NPC_TYPES 48                                ;; 0d:4c66 $fc $30
      sSPAWN_NPC 0                                     ;; 0d:4c68 $fd $00
    sENDIF                                             ;; 0d:4c6a
    sEND                                               ;; 0d:4c6a $00

script_0197:
    sEND                                               ;; 0d:4c6b $00

script_0198:
    sEND                                               ;; 0d:4c6c $00

script_0199:
    sSET_NPC_TYPES 7                                   ;; 0d:4c6d $fc $07
    sIF_FLAG !wScriptFlags.4
      sSPAWN_NPC 2
    sENDIF
    sSPAWN_NPC 0                                       ;; 0d:4c71 $fd $00
    sEND                                               ;; 0d:4c73 $00

script_019a:
    sEND                                               ;; 0d:4c74 $00

script_019b:
    sEND                                               ;; 0d:4c75 $00

script_019c:
    sEND                                               ;; 0d:4c76 $00

script_019d:
    sIF_FLAG !wScriptFlags03.0                         ;; 0d:4c77 $08 $98 $00 $ae
      sSET_MUSIC 0                                     ;; 0d:4c7b $f8 $00
      sSET_NPC_TYPES 38                                ;; 0d:4c7d $fc $26
      sSPAWN_NPC 0                                     ;; 0d:4c7f $fd $00
      sSPAWN_NPC 1                                     ;; 0d:4c81 $fd $01
      sDELAY 60                                        ;; 0d:4c83 $f0 $3c
      sSET_MUSIC 10                                    ;; 0d:4c85 $f8 $0a
      sMSG                                             ;; 0d:4c87 $04
        db "<10><BOY>:<GIRL>!\n<GIRL>:__", $00         ;; 0d:4c88
      sDELAY 30                                        ;; 0d:4c92 $f0 $1e
      sMSG                                             ;; 0d:4c94 $04
        db "___<12>"
        db "<1b>Julius:You're\n too late, <BOY>_<12>"
        db "<1b> I've already\n obtained the\n power of Mana!<12>"
        db "<1b> All will bow to\n me and my new\n Vandole Empire!<12>"
        db "<1b> Now that I have\n the power of\n Mana_<12>"
        db "<1b> I do not need you\n anymore, <BOY>!<12>"
        db "<11>", $00 ;; 0d:4c9b
      sLOAD_ROOM 1, $67, 9, 10                         ;; 0d:4d1f $f4 $01 $67 $09 $0a
      sCALL script_011e                                ;; 0d:4d24 $02 $09 $48
    sELSE                                              ;; 0d:4d27 $01 $13
; Teleport to the starting position to avoid saving under Julius' initial ambush.
      sSET_PLAYER_POSITION 8, 10
      sSET_ROOM_TILE $11, 4, 7                         ;; 0d:4d29 $b0 $11 $04 $07
      sSFX 16                                          ;; 0d:4d2d $f9 $10
      sDELAY 10                                        ;; 0d:4d2f $f0 $0a
      sSPAWN_BOSS 17
      sLOOP 10, 4                                      ;; 0d:4d31 $03 $0a $04
        sSFX 20                                        ;; 0d:4d34 $f9 $14
        sFLASH_SCREEN                                  ;; 0d:4d36 $bf
      sEND                                             ;; 0d:4d37 $00
      sSET_MUSIC 16                                    ;; 0d:4d3a $f8 $10
    sENDIF                                             ;; 0d:4d3c
    sEND                                               ;; 0d:4d3c $00

script_019e:
    sEND                                               ;; 0d:4d3d $00

script_019f:
    sCALL script_053f                                  ;; 0d:4d3e $02 $6f $ba
    sCALL script_0540                                  ;; 0d:4d41 $02 $71 $ec
    sCALL script_0541                                  ;; 0d:4d44 $02 $74 $0c
    sHALT_GAME                                         ;; 0d:4d47 $cc
    sEND                                               ;; 0d:4d48 $00

script_01a0:
    sIF_FLAG !wScriptFlags04.3                         ;; 0d:4d49 $08 $a3 $00 $08
      sSPAWN_BOSS 1
      sDELAY 10
      sSFX 20                                          ;; 0d:4d4d $f9 $14
      sSET_MUSIC 15                                    ;; 0d:4d4f $f8 $0f
    sELSE                                              ;; 0d:4d53 $01 $01
      sRUN_ROOM_ALL_KILLED_SCRIPT                      ;; 0d:4d55 $ee
    sENDIF                                             ;; 0d:4d56
    sEND                                               ;; 0d:4d56 $00

script_01a1:
    sSET_MUSIC 7                                       ;; 0d:4d57 $f8 $07
    sEND                                               ;; 0d:4d59 $00

script_01a2:
    sSET_MUSIC 0                                       ;; 0d:4d5a $f8 $00
    sIF_FLAG !wScriptFlags04.3                         ;; 0d:4d49 $08 $a3 $00 $08
      sMSG
        db "<10>Defeated Hydra!<12><11>", $00
    sENDIF
    ; Reuse the Jackal flag to track whether you had the Mysterous Man with you.
    sIF_FLAG wScriptFlags0A.2
      sCLEAR_FLAG wScriptFlags01.0
    sENDIF
    sSET_NPC_TYPES 89                                  ;; 0d:4d5c $fc $59
    sSET_ROOM_TILE $25, 3, 4                           ;; 0d:4d5e $b0 $25 $03 $04
    sSET_ROOM_TILE $25, 4, 4                           ;; 0d:4d62 $b0 $25 $04 $04
    sSET_ROOM_TILE $25, 5, 4                           ;; 0d:4d66 $b0 $25 $05 $04
    sSET_ROOM_TILE $25, 6, 4                           ;; 0d:4d6a $b0 $25 $06 $04
    sSET_FLAG wScriptFlags04.3                         ;; 0d:4d6e $da $23
    sIF_FLAG !wScriptFlags09.1                         ;; 0d:4d70 $08 $c9 $00 $05
      sSPAWN_NPC 1                                     ;; 0d:4d74 $fd $01
      sSET_CHEST_OPEN_SCRIPT1 script_0450              ;; 0d:4d76 $c9 $04 $50
      sCLEAR_FLAG wScriptFlags09.0
    sENDIF                                             ;; 0d:4d79
    sIF_FLAG !wScriptFlags09.0                         ;; 0d:4d79 $08 $c8 $00 $05
      sSPAWN_NPC 2                                     ;; 0d:4d7d $fd $02
      sSET_CHEST_OPEN_SCRIPT2 script_0451              ;; 0d:4d7f $ca $04 $51
    sENDIF                                             ;; 0d:4d82
    sEND                                               ;; 0d:4d82 $00

script_01a3:
    sIF_FLAG wScriptFlags0E.2, wScriptFlags0E.3, !wScriptFlags0E.4, wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:4d83 $08 $72 $73 $f4 $75 $f6 $77 $00 $13
      sIF_FLAG !wScriptFlags06.4                       ;; 0d:4d8c $08 $b4 $00 $0b
        sSFX 20                                        ;; 0d:4d90 $f9 $14
        sFLASH_SCREEN                                  ;; 0d:4d92 $bf
        sSPAWN_BOSS 15
        sDELAY 30                                      ;; 0d:4d93 $f0 $1e
        sSET_MUSIC 15                                  ;; 0d:4d97 $f8 $0f
      sELSE                                            ;; 0d:4d99 $01 $04
        sSET_ROOM_TILE $59, 8, 1                       ;; 0d:4d9b $b0 $59 $08 $01
      sENDIF                                           ;; 0d:4d9f
    sENDIF                                             ;; 0d:4d9f
    sIF_FLAG wScriptFlags0E.2, wScriptFlags0E.3, !wScriptFlags0E.4, wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:4d9f $08 $72 $73 $f4 $75 $76 $f7 $00 $13
      sIF_FLAG !wScriptFlags02.7                       ;; 0d:4da8 $08 $97 $00 $0b
      sLOAD_PALETTE 1
        sSFX 20                                        ;; 0d:4dac $f9 $14
        sFLASH_SCREEN                                  ;; 0d:4dae $bf
        sSPAWN_BOSS 20
        sDELAY 30                                      ;; 0d:4daf $f0 $1e
        sSET_MUSIC 15                                  ;; 0d:4db3 $f8 $0f
      sELSE                                            ;; 0d:4db5 $01 $04
        sSET_ROOM_TILE $59, 8, 1                       ;; 0d:4db7 $b0 $59 $08 $01
      sENDIF                                           ;; 0d:4dbb
    sENDIF                                             ;; 0d:4dbb
    sIF_FLAG wScriptFlags0E.2, wScriptFlags0E.3, !wScriptFlags0E.4, wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:4dbb $08 $72 $73 $f4 $75 $76 $77 $00 $13
      sIF_FLAG !wScriptFlags06.2                       ;; 0d:4dc4 $08 $b2 $00 $0b
        sSFX 20                                        ;; 0d:4dc8 $f9 $14
        sFLASH_SCREEN                                  ;; 0d:4dca $bf
        sSPAWN_BOSS 13
        sDELAY 30                                      ;; 0d:4dcb $f0 $1e
        sSET_MUSIC 15                                  ;; 0d:4dcf $f8 $0f
      sELSE                                            ;; 0d:4dd1 $01 $04
        sSET_ROOM_TILE $59, 8, 1                       ;; 0d:4dd3 $b0 $59 $08 $01
      sENDIF                                           ;; 0d:4dd7
    sENDIF                                             ;; 0d:4dd7
    sEND                                               ;; 0d:4dd7 $00

script_01a4:
    sLOAD_PALETTE 0
    sSET_MUSIC 22                                      ;; 0d:4dd8 $f8 $16
    sEND                                               ;; 0d:4dda $00

script_01a5:
    sIF_FLAG wScriptFlags0E.2, wScriptFlags0E.3, !wScriptFlags0E.4, wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7, !wScriptFlags06.4
      sSET_MUSIC 0                                     ;; 0d:4de4 $f8 $00
      sSFX 34                                          ;; 0d:4de6 $f9 $22
      sMSG                                             ;; 0d:4de8 $04
        db "<10>Defeated\n   Dragon Zombie!<12>"
        db "<11>", $00 ;; 0d:4de9
      sSET_FLAG wScriptFlags06.4                       ;; 0d:4e01 $da $34
      sSET_ROOM_TILE $59, 8, 1                         ;; 0d:4e03 $b0 $59 $08 $01
    sENDIF                                             ;; 0d:4e07
    sIF_FLAG wScriptFlags0E.2, wScriptFlags0E.3, !wScriptFlags0E.4, wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7, !wScriptFlags02.7
      sSET_MUSIC 0                                     ;; 0d:4e10 $f8 $00
      sSFX 34                                          ;; 0d:4e12 $f9 $22
      sMSG                                             ;; 0d:4e14 $04
        db "<10>Defeated\n    Red Dragon!<12>"
        db "<11>", $00 ;; 0d:4e15
      sSET_FLAG wScriptFlags02.7                       ;; 0d:4e2b $da $17
      sLOAD_PALETTE 0
      sSET_ROOM_TILE $59, 8, 1                         ;; 0d:4e2d $b0 $59 $08 $01
    sENDIF                                             ;; 0d:4e31
    sIF_FLAG wScriptFlags0E.2, wScriptFlags0E.3, !wScriptFlags0E.4, wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7, !wScriptFlags06.2
      sSET_MUSIC 0                                     ;; 0d:4e3a $f8 $00
      sSFX 34                                          ;; 0d:4e3c $f9 $22
      sMSG                                             ;; 0d:4e3e $04
        db "<10>Defeated Dragon!<12>"
        db "<11>", $00 ;; 0d:4e3f
      sSET_FLAG wScriptFlags06.2                       ;; 0d:4e4f $da $32
      sSET_ROOM_TILE $59, 8, 1                         ;; 0d:4e51 $b0 $59 $08 $01
    sENDIF                                             ;; 0d:4e55
    sDELAY 30                                          ;; 0d:4e55 $f0 $1e
    sSET_MUSIC 22                                      ;; 0d:4e57 $f8 $16
    sEND                                               ;; 0d:4e59 $00

script_01a6:
    sIF_FLAG !wScriptFlags04.4                         ;; 0d:4e5a $08 $a4 $00 $04
      sSET_NPC_TYPES 90                                ;; 0d:4e5e $fc $5a
      sSPAWN_NPC 1                                     ;; 0d:4e60 $fd $01
    sENDIF                                             ;; 0d:4e62
    sIF_FLAG wScriptFlags04.4                          ;; 0d:4e62 $08 $24 $00 $01
      sOPEN_EAST_DOOR                                  ;; 0d:4e66 $e4
    sENDIF                                             ;; 0d:4e67
    sIF_FLAG wScriptFlags08.0, !wScriptFlags04.5       ;; 0d:4e67 $08 $40 $a5 $00 $31
      sSET_ROOM_TILE $42, 4, 7                         ;; 0d:4e6c $b0 $42 $04 $07
      sSET_ROOM_TILE $43, 5, 7                         ;; 0d:4e70 $b0 $43 $05 $07
      sIF_FLAG wScriptFlags01.6                        ;; 0d:4e74 $08 $0e $00 $25
        sSET_MUSIC 0                                   ;; 0d:4e78 $f8 $00
        sDELAY 50                                      ;; 0d:4e7a $f0 $32
        sMSG                                           ;; 0d:4e7c $04
          db "<10>Lee:That's my\n victim!<12>"
          db "<11>", $00 ;; 0d:4e7d
        sSFX 20                                        ;; 0d:4e92 $f9 $14
        sFLASH_SCREEN                                  ;; 0d:4e94 $bf
        sFLASH_SCREEN                                  ;; 0d:4e95 $bf
        sFLASH_SCREEN                                  ;; 0d:4e96 $bf
        sSPAWN_BOSS 0
        sDELAY 10                                      ;; 0d:4e97 $f0 $0a
        sSET_MUSIC 15                                  ;; 0d:4e99 $f8 $0f
      sENDIF                                           ;; 0d:4e9d
    sENDIF                                             ;; 0d:4e9d
    sEND                                               ;; 0d:4e9d $00

script_01a7:
    sSET_MUSIC 7                                       ;; 0d:4e9e $f8 $07
    sEND                                               ;; 0d:4ea0 $00

script_01a8:
    sIF_FLAG !wScriptFlags01.6                         ;; 0d:4ea1 $08 $8e $00 $12
      sTAKE_ITEM INV_ITEM_MIRROR                       ;; 0d:4ea5 $d5 $1e
      sIF_EQUIPED INV_ITEM_MIRROR                      ;; 0d:4ea7 $09 $27 $00 $01
        sTAKE_EQUIPED_ITEM                             ;; 0d:4eab $de
      sENDIF                                           ;; 0d:4eac
      sSFX 16                                          ;; 0d:4eac $f9 $10
      sOPEN_EAST_DOOR                                  ;; 0d:4eae $e4
      sSET_FLAG wScriptFlags04.4                       ;; 0d:4eaf $da $24
      sDELAY 60                                        ;; 0d:4eb1 $f0 $3c
      sSET_MUSIC 7                                     ;; 0d:4eb3 $f8 $07
    sELSE                                              ;; 0d:4eb5 $01 $89
      sDELAY 30                                        ;; 0d:4eb7 $f0 $1e
      sSET_MUSIC 0                                     ;; 0d:4eb9 $f8 $00
      sMSG                                             ;; 0d:4ebb $04
        db "<10>Defeated Vampire!<12>"
        db "<1b>", $00 ;; 0d:4ebc
      sSFX 15                                          ;; 0d:4ecc $f9 $0f
      sMSG                                             ;; 0d:4ece $04
        db "<1b>Received the Book\nof Dryad!\nLearned Sleep.", $00
      sGIVE_MAGIC INV_MAGIC_SLEP                       ;; 0d:4ef2 $d6 $03
      sMSG                                             ;; 0d:4ef4 $04
        db "<12>"
        db "<1b><BOY>:Are you\n alright, <GIRL>?\n<GIRL>:_ Yeah.<12>"
        db "<11>", $00 ;; 0d:4ef5
      sDELAY 20                                        ;; 0d:4f12 $f0 $14
      sLOAD_ROOM 0, $a9, 10, 6                         ;; 0d:4f14 $f4 $00 $a9 $0a $06
      sDELAY 60                                        ;; 0d:4f19 $f0 $3c
      sMSG                                             ;; 0d:4f1b $04
        db "<10><GIRL>:Wendel is\n to the south.\n Let's hurry!<12>"
        db "<11>", $00 ;; 0d:4f1c
      sSET_MUSIC 20                                    ;; 0d:4f3b $f8 $14
      sSET_FLAG wScriptFlags04.5                       ;; 0d:4f3d $da $25
      sCLEAR_ROOM_HISTORY                              ;; 0d:4f3f $ab
    sENDIF                                             ;; 0d:4f40
    sEND                                               ;; 0d:4f40 $00

script_01a9:
    sSET_MUSIC 0                                       ;; 0d:4f41 $f8 $00
    sIF_FLAG !wScriptFlags04.6                         ;; 0d:4f43 $08 $a6 $00 $0b
      sSFX 20                                          ;; 0d:4f47 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:4f49 $bf
      sSPAWN_BOSS 3
      sDELAY 30                                        ;; 0d:4f4a $f0 $1e
      sSET_MUSIC 15                                    ;; 0d:4f4c $f8 $0f
    sELSE                                              ;; 0d:4f50 $01 $11
      sIF_FLAG !wScriptFlags02.4                       ;; 0d:4f52 $08 $94 $00 $09
        sCALL script_0435
      sELSE                                            ;; 0d:4f5d $01 $04
        sSET_ROOM_TILE $59, 2, 1                       ;; 0d:4f5f $b0 $59 $02 $01
      sENDIF                                           ;; 0d:4f63
    sENDIF                                             ;; 0d:4f63
    sEND                                               ;; 0d:4f63 $00

script_01aa:
    sSET_MUSIC 7                                       ;; 0d:4f64 $f8 $07
    sEND                                               ;; 0d:4f66 $00

script_01ab:
    sSET_MUSIC 0
    sDELAY 20                                          ;; 0d:4f67 $f0 $14
    sMSG                                               ;; 0d:4f69 $04
      db "<10>Defeated Megapede!<12>"
      db "<11>", $00 ;; 0d:4f6a
    sSET_FLAG wScriptFlags04.6                         ;; 0d:4f7b $da $26
    sRUN_ROOM_SCRIPT                                   ;; 0d:4f7d $ec
    sEND                                               ;; 0d:4f7e $00

script_01ac:
    sIF_FLAG !wScriptFlags04.7                         ;; 0d:4f7f $08 $a7 $00 $33
      sDELAY 60                                        ;; 0d:4f83 $f0 $3c
      sMSG                                             ;; 0d:4f85 $04
        db "<10>Medusa:This will\n be your final\n resting place!<12>"
        db "<11>", $00 ;; 0d:4f86
      sDELAY 30                                        ;; 0d:4faa $f0 $1e
      sSFX 20                                          ;; 0d:4fac $f9 $14
      sFLASH_SCREEN                                    ;; 0d:4fae $bf
      sFLASH_SCREEN                                    ;; 0d:4faf $bf
      sSPAWN_BOSS 2
      sDELAY 30                                        ;; 0d:4fb0 $f0 $1e
      sSET_MUSIC 15                                    ;; 0d:4fb2 $f8 $0f
    sENDIF                                             ;; 0d:4fb6
    sIF_FLAG wScriptFlags04.7                          ;; 0d:4fb6 $08 $27 $00 $12
      sSET_NPC_TYPES 66                                ;; 0d:4fba $fc $42
      sSET_MUSIC 2                                     ;; 0d:4fbc $f8 $02
      sIF_FLAG !wScriptFlags0A.5, !wScriptFlags03.4    ;; 0d:4fbe $08 $d5 $9c $00 $02
        sSPAWN_NPC 0                                   ;; 0d:4fc3 $fd $00
      sENDIF                                           ;; 0d:4fc5
      sIF_FLAG wScriptFlags03.4, !wScriptFlags06.5     ;; 0d:4fc5 $08 $1c $b5 $00 $02
        sSPAWN_NPC 1                                   ;; 0d:4fca $fd $01
      sENDIF                                           ;; 0d:4fcc
    sENDIF                                             ;; 0d:4fcc
    sEND                                               ;; 0d:4fcc $00

script_01ad:
    sSET_MUSIC 8                                       ;; 0d:4fcd $f8 $08
    sEND                                               ;; 0d:4fcf $00

script_01ae:
    sIF_FLAG !wScriptFlags04.7                         ;; 0d:4fd0 $08 $a7 $00 $8e
      sSET_MUSIC 0                                     ;; 0d:4fd4 $f8 $00
      sSFX 34                                          ;; 0d:4fd6 $f9 $22
      sDELAY 180                                       ;; 0d:4fd8 $f0 $b4
      sFADE_TO_BLACK                                   ;; 0d:4fda $bd
      sLOAD_ROOM_INSTANT 15, $55, 20, 0                ;; 0d:4fdb $f3 $0f $55 $14 $00
      sSET_MUSIC 10                                    ;; 0d:4fe0 $f8 $0a
      sFADE_TO_NORMAL                                  ;; 0d:4fe2 $bc
      sMSG                                             ;; 0d:4fe3 $04
        db "<10>Medusa:Came here\n to get my tears?\n Huh! What a joke!<12>"
        db "<11>", $00 ;; 0d:4fe4
      sFADE_TO_BLACK                                   ;; 0d:500b $bd
      sDELAY 30                                        ;; 0d:500c $f0 $1e
      sLOAD_ROOM_INSTANT 1, $30, 12, 8                 ;; 0d:500e $f3 $01 $30 $0c $08
      sSET_PLAYER_DIRECTION_UP                         ;; 0d:5013 $84
      sFOLLOWER_SET_POSITION 10, 8                     ;; 0d:5014 $99 $0a $08
      sFADE_TO_NORMAL                                  ;; 0d:5017 $bc
      sDELAY 60                                        ;; 0d:5018 $f0 $3c
      sFOLLOWER_DIRECTION_LEFT                         ;; 0d:501a $97
      sDELAY 60                                        ;; 0d:501b $f0 $3c
      sFOLLOWER_DIRECTION_RIGHT                        ;; 0d:501d $96
      sDELAY 60                                        ;; 0d:501e $f0 $3c
      sSET_PLAYER_DIRECTION_LEFT                       ;; 0d:5020 $87
      sFOLLOWER_SET_POSITION 10, 8                     ;; 0d:5021 $99 $0a $08
      sDELAY 60                                        ;; 0d:5024 $f0 $3c
      sMSG                                             ;; 0d:5026 $04
        db "<10>", $00
      sCALL script_0433
      sMSG
        db ":Can't find\n a drop of tear__<12>"
        db "<1b><BOY>:Let's go back\n to Jadd first.<12>"
        db "<11>", $00 ;; 0d:5027
      sSET_PLAYER_DIRECTION_RIGHT                      ;; 0d:5058 $86
      sPLAYER_STEP_FORWARD                             ;; 0d:5059 $80
      sPLAYER_STEP_FORWARD                             ;; 0d:505a $80
      sCALL script_0227                                ;; 0d:505b $02 $28 $9c
      sCLEAR_FLAG wScriptFlags0A.5                     ;; 0d:505e $db $55
      sSET_FLAG wScriptFlags04.7                       ;; 0d:5060 $da $27
      ; The Jackal bit is reused to influence Fang drops until Medusa is dead.
      sSET_FLAG wScriptFlags01.0
    sENDIF                                             ;; 0d:5062
    sEND                                               ;; 0d:5062 $00

script_01af:
    sIF_FLAG wScriptFlags03.5, !wScriptFlags05.0       ;; 0d:5063 $08 $1d $a8 $00 $3a
      sSET_NPC_TYPES 65                                ;; 0d:5068 $fc $41
      sSPAWN_NPC 0                                     ;; 0d:506a $fd $00
      sDELAY 20                                        ;; 0d:506c $f0 $14
      sMSG                                             ;; 0d:506e $04
        db "<10>Davias:HA!\n You can never\n defeat me!<12>"
        db "<11>", $00 ;; 0d:506f
      sFLASH_SCREEN                                    ;; 0d:508f $bf
      sSFX 20                                          ;; 0d:5090 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:5092 $bf
      sSFX 20                                          ;; 0d:5093 $f9 $14
      sDEL_NPC_1                                       ;; 0d:5095 $18
      sSFX 20                                          ;; 0d:5096 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:5098 $bf
      sSFX 20                                          ;; 0d:5099 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:509b $bf
      sSPAWN_BOSS 4
      sDELAY 30                                        ;; 0d:509c $f0 $1e
      sSET_MUSIC 19                                    ;; 0d:50a0 $f8 $13
    sENDIF                                             ;; 0d:50a2
    sSET_FLAG wScriptFlags0F.1                         ;; 0d:50a2 $da $79
    sEND                                               ;; 0d:50a4 $00

script_01b0:
    sCLEAR_FLAG wScriptFlags0F.1                       ;; 0d:50a5 $db $79
    sSET_MUSIC 7                                       ;; 0d:50a7 $f8 $07
    sEND                                               ;; 0d:50a9 $00

script_01b1:
    sSET_MUSIC 0                                       ;; 0d:50aa $f8 $00
    sDELAY 80                                          ;; 0d:50ac $f0 $50
    sMSG                                               ;; 0d:50ae $04
      db "<10>Lester:We did it!<12>"
      db "<1b>Davias:The Pendant\n is no longer\n here, my dear__!", $00 ;; 0d:50af
    sSET_MUSIC 10                                      ;; 0d:50dd $f8 $0a
    sMSG                                               ;; 0d:50df $04
      db "<12>"
      db "<1b> My servant Garuda\n is flying over\n Mt. Rocks to give<12>"
      db "<1b> the Pendant to\n Shadow Knight_<12>"
      db "<1b>\n  Davias falls__<12>"
      db "<11>", $00 ;; 0d:50e0
    sSET_MUSIC 0                                       ;; 0d:5110 $f8 $00
    sFADE_TO_BLACK
    sFOLLOWER_DELETE                                   ;; 0d:5114 $98
    sSET_PLAYER_DIRECTION_UP                           ;; 0d:5117 $84
    sLOAD_ROOM_INSTANT 14, $04, 12, 10
    sDELAY 30                                          ;; 0d:511d $f0 $1e
    sSET_NPC_TYPES 62                                  ;; 0d:511f $fc $3e
    sSPAWN_NPC 1                                       ;; 0d:5121 $fd $01
    sFADE_TO_NORMAL
    sMSG                                               ;; 0d:5123 $04
      db "<10>Lester:__Going?\n<BOY>:Yeah, but Mt.\n Rocks is blocked_<12>"
      db "<1b>Lester:My harp\n tunes will clear\n the gas.<12>"
      db "<11>", $00 ;; 0d:5124
    sSPAWN_NPC 2                                       ;; 0d:5164 $fd $02
    sSET_MUSIC 13                                      ;; 0d:5166 $f8 $0d
    sDELAY 180                                         ;; 0d:5168 $f0 $b4
    sMSG                                               ;; 0d:516a $04
      db "<10> __ I'll stay here\n and play requiem\n for my ", $00
    sIF_FLAG wScriptFlags0A.0
      sMSG
        db "sist", $00
    sELSE
      sMSG
        db "broth", $00
    sENDIF
    sMSG
      db "er.<12>"
      db "<1b><BOY>:Okay, Lester.\n I'm going.\n __ Take care.<12>"
      db "<1b>Lester:Take this\n book with you.\n It might help.<12>"
      db "<1b>", $00 ;; 0d:516b
    sSFX 15                                            ;; 0d:51d1 $f9 $0f
    sMSG                                               ;; 0d:51d3 $04
      db "Received the Book\nof Gnome!\nLearned Mute.<12>"
      db "<11>", $00 ;; 0d:51d4
    sGIVE_MAGIC INV_MAGIC_MUTE                         ;; 0d:51f5 $d6 $02
    sDELAY 60                                          ;; 0d:51f7 $f0 $3c
    sCLEAR_FLAG wScriptFlags0A.6                       ;; 0d:51f9 $db $56
    sSET_FLAG wScriptFlags05.0                         ;; 0d:51fb $da $28
    sCLEAR_ROOM_HISTORY                                ;; 0d:51fd $ab
    sEND                                               ;; 0d:51fe $00

script_01b2:
    sIF_FLAG !wScriptFlags05.1                         ;; 0d:51ff $08 $a9 $00 $0e
      sSPAWN_BOSS 6
      sDELAY 30                                        ;; 0d:5203 $f0 $1e
      sSFX 20                                          ;; 0d:5205 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:5207 $bf
      sSFX 20                                          ;; 0d:5208 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:520a $bf
      sSET_MUSIC 15                                    ;; 0d:520b $f8 $0f
    sELSE                                              ;; 0d:520f $01 $0b
      sIF_FLAG !wScriptFlags09.6                       ;; 0d:5211 $08 $ce $00 $07
        sSET_NPC_TYPES 89                              ;; 0d:5215 $fc $59
        sSPAWN_NPC 1                                   ;; 0d:5217 $fd $01
        sSET_CHEST_OPEN_SCRIPT1 script_045d            ;; 0d:5219 $c9 $04 $5d
      sENDIF                                           ;; 0d:521c
    sENDIF                                             ;; 0d:521c
    sEND                                               ;; 0d:521c $00

script_01b3:
    sSET_MUSIC 7                                       ;; 0d:521d $f8 $07
    sEND                                               ;; 0d:521f $00

script_01b4:
    sSET_MUSIC 0                                       ;; 0d:5220 $f8 $00
    sDELAY 20                                          ;; 0d:5222 $f0 $14
    sMSG                                               ;; 0d:5224 $04
      db "<10>Defeated Cyclops!<12>"
      db "<11>", $00 ;; 0d:5225
    sSET_FLAG wScriptFlags05.1                         ;; 0d:5237 $da $29
    sRUN_ROOM_SCRIPT                                   ;; 0d:5239 $ec
    sEND                                               ;; 0d:523a $00

script_01b5:
    sIF_FLAG !wScriptFlags06.1                         ;; 0d:523b $08 $b1 $00 $0e
      sSPAWN_BOSS 12
      sDELAY 30                                        ;; 0d:523f $f0 $1e
      sSFX 20                                          ;; 0d:5241 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:5243 $bf
      sSFX 20                                          ;; 0d:5244 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:5246 $bf
      sSET_MUSIC 15                                    ;; 0d:5249 $f8 $0f
    sELSE                                              ;; 0d:524b $01 $03
      sCALL script_0248                                ;; 0d:524d $02 $33 $e7
    sENDIF                                             ;; 0d:5250
    sEND                                               ;; 0d:5250 $00

script_01b6:
    sIF_FLAG !wScriptFlags06.1                         ;; 0d:5251 $08 $b1 $00 $02
      sSET_MUSIC 12                                    ;; 0d:5255 $f8 $0c
    sENDIF                                             ;; 0d:5257
    sEND                                               ;; 0d:5257 $00

script_01b7:
    sSET_MUSIC 9                                       ;; 0d:5258 $f8 $09
; Fill tiles just outside the screen before the shake effect.
    sSET_ROOM_TILE $64, 10, 0
    sSET_ROOM_TILE $64, 10, 1
    sSET_ROOM_TILE $64, 10, 2
    sSET_ROOM_TILE $53, 10, 3
    sSET_ROOM_TILE $64, 10, 4
    sSET_ROOM_TILE $64, 10, 5
    sSET_ROOM_TILE $64, 10, 6
    sSET_ROOM_TILE $64, 10, 7
    sSET_ROOM_TILE $64, 15, 0
    sSET_ROOM_TILE $54, 15, 1
    sSET_ROOM_TILE $32, 15, 2
    sSET_ROOM_TILE $51, 15, 3
    sSET_ROOM_TILE $43, 15, 4
    sSET_ROOM_TILE $30, 15, 5
    sSET_ROOM_TILE $51, 15, 6
    sSET_ROOM_TILE $54, 15, 7
    sSFX 37                                            ;; 0d:525a $f9 $25
    sSHAKE_SCREEN                                      ;; 0d:525c $fb
    sCALL script_0248                                  ;; 0d:525d $02 $33 $e7
    sMSG                                               ;; 0d:5260 $04
      db "<10>Defeated Garuda!<12>"
      db "<11>", $00 ;; 0d:5261
    sDELAY 60                                          ;; 0d:5270 $f0 $3c
    sMSG                                               ;; 0d:5272 $04
      db "<10>Marcie:TOWER LOST\n ITS BALANCE.\n MUST HURRY OUT.<12>"
      db "<11>", $00 ;; 0d:5273
    sSET_FLAG wScriptFlags06.1                         ;; 0d:52a3 $da $31
    sEND                                               ;; 0d:52a5 $00

script_01b8:
    sIF_FLAG !wScriptFlags05.3                         ;; 0d:52a6 $08 $ab $00 $0e
      sSPAWN_BOSS 5
      sDELAY 30                                        ;; 0d:52aa $f0 $1e
      sSFX 20                                          ;; 0d:52ac $f9 $14
      sFLASH_SCREEN                                    ;; 0d:52ae $bf
      sSFX 20                                          ;; 0d:52af $f9 $14
      sFLASH_SCREEN                                    ;; 0d:52b1 $bf
      sSET_MUSIC 15                                    ;; 0d:52b4 $f8 $0f
    sELSE                                              ;; 0d:52b6 $01 $01
      sOPEN_NORTH_DOOR                                 ;; 0d:52b8 $e0
    sENDIF                                             ;; 0d:52b9
    sEND                                               ;; 0d:52b9 $00

script_01b9:
    sSET_MUSIC 7                                       ;; 0d:52ba $f8 $07
    sEND                                               ;; 0d:52bc $00

script_01ba:
    sSET_MUSIC 0                                       ;; 0d:52bd $f8 $00
    sSFX 34                                            ;; 0d:52bf $f9 $22
    sMSG                                               ;; 0d:52c1 $04
      db "<10>Defeated Golem!<12>"
      db "", $00    ;; 0d:52c2
    sGIVE_MAGIC INV_MAGIC_LIT                          ;; 0d:52d0 $d6 $06
    sSFX 15                                            ;; 0d:52d2 $f9 $0f
    sMSG                                               ;; 0d:52d4 $04
      db "<1b>Received the Book\nof Jinn!\nLearned Lit.<12>"
      db "<11>", $00 ;; 0d:52d5
    sSET_FLAG wScriptFlags05.3                         ;; 0d:52fc $da $2b
    sOPEN_NORTH_DOOR                                   ;; 0d:52fe $e0
    sDELAY 30                                          ;; 0d:52ff $f0 $1e
    sSET_MUSIC 7                                       ;; 0d:5301 $f8 $07
    sEND                                               ;; 0d:5303 $00

script_01bb:
    sIF_FLAG !wScriptFlags05.4                         ;; 0d:5304 $08 $ac $00 $bb
      sSET_NPC_TYPES 23                                ;; 0d:5308 $fc $17
      sSPAWN_NPC 0                                     ;; 0d:530a $fd $00
      sSET_PLAYER_DIRECTION_LEFT                       ;; 0d:530c $87
      sFOLLOWER_DIRECTION_UP                           ;; 0d:530d $94
      sSET_PLAYER_POSITION 16, 12                      ;; 0d:530e $8a $10 $0c
      sFOLLOWER_SET_POSITION 16, 12                    ;; 0d:5311 $99 $10 $0c
      sLOOP 7, 2
        sPLAYER_STEP_FORWARD                           ;; 0d:5317 $80
      sEND                                             ;; 0d:5318 $00
      sSET_PLAYER_DIRECTION_UP                         ;; 0d:5319 $84
      sMSG                                             ;; 0d:531a $04
        db "<10>Shadow Knight:It\n has been a while,\n <BOY>.<12>"
        db "<1b> Your skills have\n improved, but are\n you strong enough<12>"
        db "<1b> to beat me", $00
      sIF_FLAG wScriptFlags01.7
        sMSG
          db ", girl", $00
      sENDIF
      sIF_FLAG wScriptFlags06.3
        sMSG
          db ", boy", $00
      sENDIF
      sMSG
        db "?\n<BOY>:Shut up! I'll\n avenge Willy!<12><1b>", $00
      sSET_PLAYER_DIRECTION_RIGHT                      ;; 0d:5359 $86
      sFOLLOWER_DIRECTION_LEFT                         ;; 0d:535a $97
      sMSG                                             ;; 0d:535b $04
        db "<BOY>:Stay outside.\n This fight will\n be too dangerous.<12>"
        db "<1b><GIRL>:Okay__<12>"
        db "<11>", $00 ;; 0d:535c
      sFOLLOWER_DIRECTION_DOWN                         ;; 0d:5391 $95
      sFOLLOWER_STEP_FORWARD                           ;; 0d:5392 $90
      sFOLLOWER_STEP_FORWARD                           ;; 0d:5393 $90
      sFOLLOWER_DELETE                                 ;; 0d:5394 $98
      sSFX 16                                          ;; 0d:5395 $f9 $10
      sSET_ROOM_TILE $2f, 8, 7                         ;; 0d:5397 $b0 $2f $08 $07
      sSET_MUSIC 0                                     ;; 0d:539b $f8 $00
      sDELAY 20                                        ;; 0d:539d $f0 $14
      sSET_PLAYER_DIRECTION_UP                         ;; 0d:539f $84
      sMSG                                             ;; 0d:53a0 $04
        db "<10>Shadow Knight:How\n noble of you.\n Now, fight me!<12><11>", $00
      sSET_MUSIC 19                                    ;; 0d:53c1 $f8 $13
    sENDIF                                             ;; 0d:53c3
    sEND                                               ;; 0d:53c3 $00

script_01bc:
    sEND                                               ;; 0d:53c4 $00

script_01bd:
    sSET_MUSIC 0                                       ;; 0d:53c5 $f8 $00
    sSFX 16                                            ;; 0d:53c7 $f9 $10
    sSET_ROOM_TILE $6b, 8, 7                           ;; 0d:53c9 $b0 $6b $08 $07
    sMSG                                               ;; 0d:53cd $04
      db "<10>Defeated\n   Shadow Knight!<12>"
      db "<1b>Received <7b>Pendant_", $00
    sDELAY 100                                         ;; 0d:53eb $f0 $64
    sMSG                                               ;; 0d:53ed $04
      db "<1b><BOY>:_", $00                            ;; 0d:53ee
    sDELAY 100                                         ;; 0d:53f3 $f0 $64
    sMSG                                               ;; 0d:53f5 $04
      db "_", $00                                      ;; 0d:53f6
    sDELAY 60                                          ;; 0d:53f8 $f0 $3c
    sMSG                                               ;; 0d:53fa $04
      db " It's fake!\n _ Then, where is\n the real Pendant?", $00 ;; 0d:53fb
    sDELAY 80                                          ;; 0d:541b $f0 $50
    sMSG                                               ;; 0d:541d $04
      db "<11>", $00                                   ;; 0d:541e
    sCLEAR_FLAG wScriptFlags0A.1                       ;; 0d:5420 $db $51
    sSET_FLAG wScriptFlags05.4                         ;; 0d:5422 $da $2c
    sSET_MUSIC 14                                      ;; 0d:5424 $f8 $0e
    sEND                                               ;; 0d:5426 $00

script_01be:
    sIF_FLAG !wScriptFlags05.5                         ;; 0d:5427 $08 $ad $00 $0e
      sSPAWN_BOSS 8
      sDELAY 20                                        ;; 0d:542b $f0 $14
      sSFX 20                                          ;; 0d:542d $f9 $14
      sFLASH_SCREEN                                    ;; 0d:542f $bf
      sSFX 20                                          ;; 0d:5430 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:5432 $bf
      sSET_MUSIC 15                                    ;; 0d:5435 $f8 $0f
    sELSE                                              ;; 0d:5437 $01 $0b
      sIF_FLAG !wScriptFlags07.2                       ;; 0d:5439 $08 $ba $00 $07
        sSET_NPC_TYPES 89                              ;; 0d:543d $fc $59
        sSPAWN_NPC 0                                   ;; 0d:543f $fd $00
        sSET_CHEST_OPEN_SCRIPT1 script_0464            ;; 0d:5441 $c9 $04 $64
      sENDIF                                           ;; 0d:5444
    sENDIF                                             ;; 0d:5444
    sEND                                               ;; 0d:5444 $00

script_01bf:
    sSET_MUSIC 12                                      ;; 0d:5445 $f8 $0c
    sEND                                               ;; 0d:5447 $00

script_01c0:
    sSET_MUSIC 0                                       ;; 0d:5448 $f8 $00
    sMSG                                               ;; 0d:544a $04
      db "<10>Defeated Kary!<12>"
      db "<11>", $00 ;; 0d:544b
    sSET_FLAG wScriptFlags05.5                         ;; 0d:5459 $da $2d
    sRUN_ROOM_SCRIPT                                   ;; 0d:545b $ec
    sEND                                               ;; 0d:545c $00

script_01c1:
    sIF_FLAG !wScriptFlags05.7                         ;; 0d:545d $08 $af $00 $0e
      sSPAWN_BOSS 10
      sDELAY 20                                        ;; 0d:5461 $f0 $14
      sSFX 20                                          ;; 0d:5463 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:5465 $bf
      sSFX 20                                          ;; 0d:5466 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:5468 $bf
      sSET_MUSIC 15                                    ;; 0d:546b $f8 $0f
    sELSE                                              ;; 0d:546d $01 $0b
      sIF_FLAG !wScriptFlags07.3                       ;; 0d:546f $08 $bb $00 $07
        sSET_NPC_TYPES 89                              ;; 0d:5473 $fc $59
        sSPAWN_NPC 0                                   ;; 0d:5475 $fd $00
        sSET_CHEST_OPEN_SCRIPT1 script_0437            ;; 0d:5477 $c9 $04 $37
      sENDIF                                           ;; 0d:547a
    sENDIF                                             ;; 0d:547a
    sEND                                               ;; 0d:547a $00

script_01c2:
    sSET_MUSIC 7                                       ;; 0d:547b $f8 $07
    sEND                                               ;; 0d:547d $00

script_01c3:
    sSET_MUSIC 0                                       ;; 0d:547e $f8 $00
    sMSG                                               ;; 0d:5480 $04
      db "<10>Defeated Ifrit!<12>"
      db "<11>", $00 ;; 0d:5481
    sSET_FLAG wScriptFlags05.7                         ;; 0d:5491 $da $2f
    sRUN_ROOM_SCRIPT                                   ;; 0d:5493 $ec
    sEND                                               ;; 0d:5494 $00

script_01c4:
    sIF_FLAG !wScriptFlags05.2                         ;; 0d:5495 $08 $aa $00 $12
      sSFX 16                                          ;; 0d:5499 $f9 $10
      sSET_ROOM_TILE $30, 1, 6                         ;; 0d:549b $b0 $30 $01 $06
      sSPAWN_BOSS 7
      sDELAY 20                                        ;; 0d:549f $f0 $14
      sSFX 20                                          ;; 0d:54a1 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:54a3 $bf
      sSFX 20                                          ;; 0d:54a4 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:54a6 $bf
      sSET_MUSIC 15                                    ;; 0d:54a9 $f8 $0f
    sENDIF                                             ;; 0d:54ab
    sEND                                               ;; 0d:54ab $00

script_01c5:
    sSET_MUSIC 14                                      ;; 0d:54ac $f8 $0e
    sEND                                               ;; 0d:54ae $00

script_01c6:
    sSET_MUSIC 0                                       ;; 0d:54af $f8 $00
    sSFX 16                                            ;; 0d:54b1 $f9 $10
    sSET_ROOM_TILE $13, 1, 6                           ;; 0d:54b3 $b0 $13 $01 $06
    sMSG                                               ;; 0d:54b7 $04
      db "<10>Defeated Chimera!<12>"
      db "<11>", $00 ;; 0d:54b8
    sSET_FLAG wScriptFlags05.2                         ;; 0d:54c8 $da $2a
    sDELAY 30                                          ;; 0d:54ca $f0 $1e
    sSET_MUSIC 14                                      ;; 0d:54cc $f8 $0e
    sEND                                               ;; 0d:54ce $00

script_01c7:
    sIF_FLAG !wScriptFlags05.6                         ;; 0d:54cf $08 $ae $00 $0e
      sSPAWN_BOSS 9
      sDELAY 20                                        ;; 0d:54d3 $f0 $14
      sSFX 20                                          ;; 0d:54d5 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:54d7 $bf
      sSFX 20                                          ;; 0d:54d8 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:54da $bf
      sSET_MUSIC 15                                    ;; 0d:54dd $f8 $0f
    sELSE                                              ;; 0d:54df $01 $04
      sSET_ROOM_TILE $4c, 8, 2                         ;; 0d:54e1 $b0 $4c $08 $02
    sENDIF                                             ;; 0d:54e5
    sEND                                               ;; 0d:54e5 $00

script_01c8:
    sSET_MUSIC 7                                       ;; 0d:54e6 $f8 $07
    sEND                                               ;; 0d:54e8 $00

script_01c9:
    sSET_MUSIC 0                                       ;; 0d:54e9 $f8 $00
    sMSG                                               ;; 0d:54eb $04
      db "<10>Defeated Kraken!<12>"
      db "<11>", $00 ;; 0d:54ec
    sSET_FLAG wScriptFlags05.6                         ;; 0d:54fc $da $2e
    sCREATE_EFFECT $10, $10, $04                       ;; 0d:54fe $ba $10 $10 $04
    sSET_ROOM_TILE $4c, 8, 2                           ;; 0d:5502 $b0 $4c $08 $02
    sDELAY 30                                          ;; 0d:5506 $f0 $1e
    sSET_MUSIC 7                                       ;; 0d:5508 $f8 $07
    sEND                                               ;; 0d:550a $00

script_01ca:
    sIF_FLAG !wScriptFlags06.0                         ;; 0d:550b $08 $b0 $00 $0c
      sSPAWN_BOSS 11
      sDELAY 20                                        ;; 0d:550f $f0 $14
      sSFX 20                                          ;; 0d:5511 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:5513 $bf
      sSFX 20                                          ;; 0d:5514 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:5516 $bf
      sSET_MUSIC 15                                    ;; 0d:5519 $f8 $0f
    sENDIF                                             ;; 0d:551b
    sEND                                               ;; 0d:551b $00

script_01cb:
    sSET_MUSIC 7                                       ;; 0d:551c $f8 $07
    sEND                                               ;; 0d:551e $00

script_01cc:
    sSET_MUSIC 0                                       ;; 0d:551f $f8 $00
    sMSG                                               ;; 0d:5521 $04
      db "<10>Defeated Lich!<12>"
      db "<1b>", $00 ;; 0d:5522
    sSFX 15                                            ;; 0d:5531 $f9 $0f
    sGIVE_MAGIC INV_MAGIC_NUKE                         ;; 0d:5533 $d6 $07
    sMSG                                               ;; 0d:5535 $04
IF DEF(MANA)
      db "Received the Book\nof Shade!\nLearned Nuke!<12>"
ELIF DEF(FINAL_FANTASY)
      db "Received the Book\nof Shade!\nLearned Flare!<12>"
ENDC
      db "<11>", $00 ;; 0d:5536
    sSET_FLAG wScriptFlags06.0                         ;; 0d:555a $da $30
    sDELAY 30                                          ;; 0d:555c $f0 $1e
    sLOAD_ROOM 0, $3e, 12, 7                           ;; 0d:555e $f4 $00 $3e $0c $07
    sSET_MUSIC 25                                      ;; 0d:5563 $f8 $19
    sCLEAR_ROOM_HISTORY                                ;; 0d:5565 $ab
    sRUN_ROOM_SCRIPT                                   ;; 0d:5566 $ec
    sEND                                               ;; 0d:5567 $00

script_01cd:
    sSET_NPC_TYPES 61                                  ;; 0d:5568 $fc $3d
    sSPAWN_NPC 1                                       ;; 0d:556a $fd $01
    sEND                                               ;; 0d:556c $00

script_01ce:
    sEND                                               ;; 0d:556d $00

script_01cf:
    sEND                                               ;; 0d:556e $00

script_01e0:
    sMSG                                               ;; 0d:556f $04
      db "<10>", $00
    sIF_EQUIPED INV_ITEM_MIRROR
      sSET_MUSIC 0
      sMSG
        db "T_that Mirror_!", $00
      sDELAY 30
      sMSG
        db "\nUGGG_ GRRH_", $00
      sDELAY 30
      sMSG
        db "\nUG_ Hg_ GRRR_ _<12>"
        db "<11>", $00
      sSFX 20
      sFLASH_SCREEN
      sFLASH_SCREEN
      sDEL_NPC_1
      sSPAWN_NPC 2
      sSET_MUSIC 26
    sELSE
      sMSG
        db "Welcome to Kett's.\nRooms ahead are\noccupied.<12>"
        db "<1b>Please feel free\nto use the\nwestern room.<12>"
        db "<1b>You can't get past\nthis door.\nIt's for Mr. Lee.", $00
      sIF_FLAG wScriptFlags01.5
        sMSG
          db "<12><1b>Your friend?\nNo__\nI do not know her.<12>"
          db "<11>", $00
      sELSE
        sMSG
          db "<12>"
          db "<11>", $00
      sENDIF
    sENDIF                                             ;; 0d:5639
    sEND                                               ;; 0d:5639 $00

script_01e1:
    sMSG                                               ;; 0d:563a $04
      db "<10>I'm searching for\nthe Moon Mirror.<12>"
      db "<1b>They say it shows\nthe true nature\nof evil things.<12>"
      db "<1b>The owner of this\nhouse hid it in a\ncave. Why do that?<12>"
      db "<11>", $00 ;; 0d:563b
    sEND                                               ;; 0d:567e $00

script_01e2:
    sMSG                                               ;; 0d:567f $04
      db "<10>The Lizardmen's\nnest is to the\nsouth.<12>"
      db "<1b>They have the key\nto open the Marsh\nCave.<12>"
      db "<11>", $00 ;; 0d:5680
    sEND                                               ;; 0d:56bb $00

script_01e3:
    sDEL_NPC_1                                         ;; 0d:56bc $18
    sSPAWN_NPC 1                                       ;; 0d:56bd $fd $01
    sIF_FLAG wScriptFlags.4
      sSET_NPC_1_DIRECTION_UP
    sENDIF
    sNPC_1_STEP_FORWARD
    sNPC_1_STEP_FORWARD
    sSET_NPC_1_DIRECTION_DOWN
    sGIVE_FOLLOWER 1
    sSET_FLAG wScriptFlags0A.1
    sSET_FLAG wScriptFlags01.6
    sMSG
      db "<10><BOY>:<GIRL>!\n<GIRL>:Oh, <BOY>!\n I was so scared_<12>"
      db "<1b><BOY>:Let's get\n out of here!<12>"
      db "<11>", $00
    sRUN_ROOM_SCRIPT
    sEND                                               ;; 0d:56e7 $00

script_01e4:
    sMSG                                               ;; 0d:56e8 $04
      db "<10>Traveler:A woman\n is missing?\n I heard that<12>"
      db "<1b> young women often\n disappear at\n Kett's Mansion.<12>"
      db "<1b> They say there\n are coffins in\n the basement.<12>"
      db "<1b> Looking for the \n Mirror? Perhaps\n I can help?<12>"
      db "<13><11>", $00 ;; 0d:56e9
    sIF_FLAG !wScriptFlags0F.7                         ;; 0d:5767 $08 $ff $00 $04
      sGIVE_FOLLOWER 2                                 ;; 0d:576b $9c $02
      sSET_FLAG wScriptFlags0A.2                       ;; 0d:576d $da $52
    sENDIF                                             ;; 0d:576f
    sEND                                               ;; 0d:576f $00

script_01e5:
    sCREATE_EFFECT $10, $0e, $0a                       ;; 0d:5770 $ba $10 $0e $0a
    sSET_ROOM_TILE $4b, 7, 5                           ;; 0d:5774 $b0 $4b $07 $05
    sSET_FLAG wScriptFlags06.6                         ;; 0d:5778 $da $36
    sEND                                               ;; 0d:577a $00

script_01e6:
    sMSG                                               ;; 0d:577b $04
      db "<10>Welcome to Wendel,\nthe sacred town.<12>"
      db "<11>", $00 ;; 0d:577c
    sEND                                               ;; 0d:5797 $00

script_01e7:
    sIF_FLAG wScriptFlags02.0, !wScriptFlags02.1       ;; 0d:5798 $08 $10 $91 $00 $19
      sMSG                                             ;; 0d:579d $04
        db "<10>Ouch_! He attacked\nme from behind!\nThat man is_<12>"
        db "<11>", $00 ;; 0d:579e
    sENDIF                                             ;; 0d:57b6
    sEND                                               ;; 0d:57b6 $00

script_01e8:
    sMSG                                               ;; 0d:57b7 $04
; For the English script this was reduced down to "Hello again! How've you been?"
; This form is still simplified down, with an "embaressed laugh" cut from Hero's line,
; and originally Hero gets in the last word (or last embarresed mumbling).
      db "<10>Traveler:We meet\n again. Take care\n of your girl.<12>"
      db "<1b><BOY>:My girl_\nTraveler:Why are\n you blushing?<12>"
      db "<11>", $00 ;; 0d:57b8
    sEND                                               ;; 0d:57d3 $00

script_01e9:
    sMSG                                               ;; 0d:57d4 $04
      db "<10>The Waterfalls\nmake all of the\nrivers flow.<12>"
      db "<1b>The water springs\nfrom the root of\nthe Mana Tree.<12>"
      db "<1b>Mana is supporting\nnature.<12>"
      db "<11>", $00 ;; 0d:57d5
    sEND                                               ;; 0d:582c $00

script_01ea:
    sMSG                                               ;; 0d:582d $04
      db "<10>The Dwarf Cave is\nto the west!<12>"
      db "<11>", $00 ;; 0d:582e
    sEND                                               ;; 0d:5842 $00

script_01eb:
    sMSG                                               ;; 0d:5843 $04
      db "<10>Cibba is a sage.\nHe used to be a\ngreat warrior.<12>"
      db "<11>", $00 ;; 0d:5844
    sEND                                               ;; 0d:5867 $00

script_01ec:
    sMSG                                               ;; 0d:5868 $04
      db "<10>", $00                                   ;; 0d:5869
    sIF_FLAG !wScriptFlags03.7                         ;; 0d:586b $08 $9f $00 $0e
      sMSG                                             ;; 0d:586f $04
        db "Cibba's in the\nshrine up ahead.", $00
    sELSE                                              ;; 0d:587b $01 $47
      sMSG                                             ;; 0d:587d $04
        db "Lorimar was\nattacked by many\nmonsters.<12>"
        db "<1b>Cibba went there.\nLorimar is south\nof the Snowfields <12>"
        db "<1b>over the southern\nsea.", $00
    sENDIF                                             ;; 0d:58c4
    sMSG                                               ;; 0d:58c4 $04
      db "<12>"
      db "<11>", $00                   ;; 0d:58c5
    sEND                                               ;; 0d:58c8 $00

script_01ed:
    sMSG                                               ;; 0d:58c9 $04
      db "<10>I hear that the\nMana Tree is very\nbeautiful__<12>"
      db "<11>", $00 ;; 0d:58ca
    sEND                                               ;; 0d:58ea $00

script_01ee:
    sMSG                                               ;; 0d:58eb $04
      db "<10>", $00                                   ;; 0d:58ec
    sIF_FLAG wScriptFlags02.1                          ;; 0d:58ee $08 $11 $00 $21
      sMSG                                             ;; 0d:58f2 $04
        db "Cibba:Julius went\n westward in his\n airship.", $00 ;; 0d:58f3
    sELSE                                              ;; 0d:5911 $01 $12
      sMSG                                             ;; 0d:5913 $04
        db "Cibba:Who is\n that man?", $00             ;; 0d:5914
    sENDIF                                             ;; 0d:5925
    sMSG                                               ;; 0d:5925 $04
      db "<12>"
      db "<11>", $00                   ;; 0d:5926
    sEND                                               ;; 0d:5929 $00

script_01ef:
    sIF_INVENTORY INV_SWORD_RUSTY                      ;; 0d:592a $0a $4f $00 $05
      sCALL script_01f0                                ;; 0d:592e $02 $19 $f5
    sELSE                                              ;; 0d:5931 $01 $c1
      sIF_INVENTORY INV_ITEM_BONE_KEY
        sMSG
          db "<10>", $00
      sELSE
        sGIVE_ITEM INV_ITEM_BONE_KEY
        sIF_FLAG !wScriptFlags.5
          sMSG
            db "<10>", $00
          sSFX 15
          sMSG
            db "Received <KEY>Bone.<12><1b>", $00
        sENDIF
      sENDIF
      sIF_INVENTORY INV_ITEM_BONE_KEY
        sMSG
          db "Cibba:Go up the\n wide river by the\n Ammonite Coast.<12>"
          db "<1b> Go beyond the\n Ammonite Coast\n to Floatrocks.<12>"
          db "<1b> Use the key at\n the cave in the\n Floatrocks!<12>"
          db "<1b> The legendary\n sword is guarded\n by Ifrit.<12>"
          db "<1b> I'll tell you the\n rest when you\n return with it!<12>"
          db "<11>", $00 ;; 0d:593f
      sENDIF                                           ;; 0d:59f4
    sENDIF                                             ;; 0d:59f4
    sEND                                               ;; 0d:59f4 $00

script_01f0:
    sMSG                                               ;; 0d:59f5 $04
      db "<10>Cibba:The only way\n left is to reveal\n the Dime Tower.<12>"
      db "<1b><BOY>:Dime Tower?\n In the Crystal\n Desert?  _ How?<12>"
      db "<1b>Cibba:That sword\n will help you.<12>"
      db "<1b> Use it in the\n Cave of Ruins.\n You'll see it.<12>"
      db "<1b><BOY>:This rusty\n sword has such\n a great power_?<12>"
      db "<1b>Cibba:That sword\n will show its\n real power only<12>"
      db "<1b> when it approves\n of your using it.<12>"
      db "<1b> If you're a real\n Gemma Knight,\n it will help you.<12>"
      db "<1b><BOY>:But_ I don't\n know if it _ _<12>"
      db "<1b>Cibba:Don't worry.\n __", $00 ;; 0d:59f6
    sDELAY 40                                          ;; 0d:5b25 $f0 $28
    sMSG                                               ;; 0d:5b27 $04
      db "Now, go!<12>"
      db "<1b> The Cave of Ruins\n is in the desert\n near Ish.<12>"
      db "<1b> Ask Dr. Bon\n Voyage. He knows\n it well.<12>"
      db "<11>", $00 ;; 0d:5b28
    sEND                                               ;; 0d:5b6d $00

script_01f1:
    sCREATE_EFFECT $08, $09, $0b                       ;; 0d:5b6e $ba $08 $09 $0b
    sFULL_HP                                           ;; 0d:5b72 $c0
    sFULL_MANA                                         ;; 0d:5b73 $c1
    sEND                                               ;; 0d:5b74 $00

script_01f2:
    sMSG                                               ;; 0d:5b75 $04
      db "<10>Hello!\nWelcome to the\nDwarf Cave!<12>"
      db "<11>", $00 ;; 0d:5b76
    sEND                                               ;; 0d:5b90 $00

script_01f3:
    sMSG                                               ;; 0d:5b91 $04
      db "<10>", $00                                   ;; 0d:5b92
    sIF_FLAG wScriptFlags02.1, !wScriptFlags02.6       ;; 0d:5b94 $08 $11 $96 $00 $16
      sMSG                                             ;; 0d:5b99 $04
        db "An airship went\nto the west!<12>"
        db "<1b>", $00 ;; 0d:5b9a
    sENDIF                                             ;; 0d:5baf
    sMSG                                               ;; 0d:5baf $04
      db "The only way west\nis to pass through\nGaia.<12>"
      db "<11>", $00 ;; 0d:5bb0
    sEND                                               ;; 0d:5bcc $00

script_01f4:
    sMSG                                               ;; 0d:5bcd $04
      db "<10>", $00                                   ;; 0d:5bce
    sIF_FLAG !wScriptFlags04.6                         ;; 0d:5bd0 $08 $a6 $00 $5d
      sMSG                                             ;; 0d:5bd4 $04
        db "I used to play\nat the old mine\nwith Watts!", $00
      sIF_FLAG wScriptFlags02.1                        ;; 0d:5bf2 $08 $11 $00 $39
        sMSG                                           ;; 0d:5bf6 $04
          db "<12>"
          db "<1b>Wanna use the\nmine cart? You'll\nneed to oil it.<12>"
          db "<1b>You can buy Oil\nat the store to\nthe south.", $00 ;; 0d:5bf7
      sENDIF                                           ;; 0d:5c2f
    sELSE                                              ;; 0d:5c2f $01 $15
      sMSG                                             ;; 0d:5c31 $04
        db "Watts is selling\nweapons and armor\nmade from mithril!", $00
    sENDIF                                             ;; 0d:5c46
    sMSG                                               ;; 0d:5c46 $04
      db "<12>"
      db "<11>", $00                   ;; 0d:5c47
    sEND                                               ;; 0d:5c4a $00

script_01f5:
    sMSG                                               ;; 0d:5c4b $04
      db "<10>Gaia has its own\nwill and feelings.<12>"
      db "<1b>They say it likes\nthe flavor of\nmithril.<12>"
      db "<11>", $00 ;; 0d:5c4c
    sEND                                               ;; 0d:5c7f $00

script_01f6:
    sMSG                                               ;; 0d:5c80 $04
      db "<10>", $00                                   ;; 0d:5c81
    sIF_FLAG !wScriptFlags04.6                         ;; 0d:5c83 $08 $a6 $00 $37
      sMSG                                             ;; 0d:5c87 $04
        db "Watts likes to\nexplore! He went\nto the mine today.<12>"
        db "<1b>He's searching for\nsome mithril.", $00
    sELSE                                              ;; 0d:5cbc $01 $19
      sMSG                                             ;; 0d:5cbe $04
        db "Watts made stuff\nfrom some mithril\nhe found!", $00
    sENDIF                                             ;; 0d:5cd7
    sMSG                                               ;; 0d:5cd7 $04
      db "<12>"
      db "<11>", $00                   ;; 0d:5cd8
    sEND                                               ;; 0d:5cdb $00

script_01f7:
    sEND                                               ;; 0d:5cdc $00

script_01f8:
    sMSG                                               ;; 0d:5cdd $04
      db "<10>Watts:I made these\n weapons and armor\n with the mithril!<12>"
      db "<1b> Buy these and\n you can pass\n through Gaia!<12>"
      db "<11>", $00 ;; 0d:5cde
    sOPEN_SHOP 6                                       ;; 0d:5d1d $f6 $06
    sEND                                               ;; 0d:5d1f $00

script_01f9:
    sIF_EQUIPED INV_ITEM_POTION_OIL                    ;; 0d:5d20 $09 $2d $00 $07
      sPLAYER_STEP_FORWARD                             ;; 0d:5d24 $80
      sPLAYER_STEP_FORWARD                             ;; 0d:5d25 $80
      sDEL_NPC_1                                       ;; 0d:5d26 $18
      sTAKE_EQUIPED_ITEM                               ;; 0d:5d27 $de
      sPLAYER_IN_MINECART                              ;; 0d:5d28 $a3
    sELSE                                              ;; 0d:5d29 $01 $11
      sMSG                                             ;; 0d:5d2b $04
        db "<10>\nNeeds to be oiled.<12>"
        db "<11>", $00 ;; 0d:5d2c
    sENDIF                                             ;; 0d:5d3c
    sEND                                               ;; 0d:5d3c $00

script_01fa:
    sIF_TRIGGERED_ON_BY $81                            ;; 0d:5d3d $0b $81 $00 $03
      sDEL_NPC_1                                       ;; 0d:5d41 $18
    sELSE                                              ;; 0d:5d42 $01 $05
      sCREATE_EFFECT $10, $09, $01                     ;; 0d:5d44 $ba $10 $09 $01
      sOPEN_NORTH_DOOR                                 ;; 0d:5d48 $e0
    sENDIF                                             ;; 0d:5d49
    sEND                                               ;; 0d:5d49 $00

script_01fb:
    sIF_TRIGGERED_ON_BY $81                            ;; 0d:5d4a $0b $81 $00 $03
      sDEL_NPC_1                                       ;; 0d:5d4e $18
    sELSE                                              ;; 0d:5d4f $01 $05
      sCREATE_EFFECT $10, $09, $0d                     ;; 0d:5d51 $ba $10 $09 $0d
      sOPEN_SOUTH_DOOR                                 ;; 0d:5d55 $e2
    sENDIF                                             ;; 0d:5d56
    sEND                                               ;; 0d:5d56 $00

script_01fc:
    sIF_TRIGGERED_ON_BY $81                            ;; 0d:5d57 $0b $81 $00 $03
      sDEL_NPC_1                                       ;; 0d:5d5b $18
    sELSE                                              ;; 0d:5d5c $01 $05
      sCREATE_EFFECT $10, $11, $07                     ;; 0d:5d5e $ba $10 $11 $07
      sOPEN_EAST_DOOR                                  ;; 0d:5d62 $e4
    sENDIF                                             ;; 0d:5d63
    sEND                                               ;; 0d:5d63 $00

script_01fd:
    sIF_TRIGGERED_ON_BY $81                            ;; 0d:5d64 $0b $81 $00 $03
      sDEL_NPC_1                                       ;; 0d:5d68 $18
    sELSE                                              ;; 0d:5d69 $01 $05
      sCREATE_EFFECT $10, $01, $07                     ;; 0d:5d6b $ba $10 $01 $07
      sOPEN_WEST_DOOR                                  ;; 0d:5d6f $e6
    sENDIF                                             ;; 0d:5d70
    sEND                                               ;; 0d:5d70 $00

script_01fe:
    sMSG                                               ;; 0d:5d71 $04
      db "<10>", $00                                   ;; 0d:5d72
    sIF_EQUIPED INV_SWORD_RUSTY                        ;; 0d:5d74 $09 $4f $00 $21
      sMSG                                             ;; 0d:5d78 $04
        db "Sheath that\nsword, <BOY>.", $00
    sELSE                                              ;; 0d:5d97 $01 $67
      sMSG                                             ;; 0d:5d99 $04
        db "You have proven\nyourself a true\nGemma Knight.<12>"
        db "<1b>I shall give you\nthe Mana Sword.\nNow defeat Julius!<12>"
        db "<11>", $00 ;; 0d:5d9a
      sLOOP 8, 4                                       ;; 0d:5ddd $03 $08 $04
        sFLASH_SCREEN                                  ;; 0d:5de0 $bf
        sSFX 20                                        ;; 0d:5de1 $f9 $14
      sEND                                             ;; 0d:5de3 $00
      sDEL_NPC_1                                       ;; 0d:5de4 $18
      sTAKE_EQUIPMENT INV_SWORD_RUSTY                  ;; 0d:5de5 $d9 $0d
      sGIVE_EQUIPMENT INV_SWORD_XCALIBR                ;; 0d:5de7 $d8 $0f
      sMSG                                             ;; 0d:5de9 $04
        db "<10>Received <SWORD>Mana!!!", $00
      sSET_FLAG wScriptFlags07.0                       ;; 0d:5dfe $da $38
    sENDIF                                             ;; 0d:5e00
    sMSG                                               ;; 0d:5e00 $04
      db "<12>"
      db "<11>", $00                   ;; 0d:5e01
    sEND                                               ;; 0d:5e04 $00

script_01ff:
    sIF_FLAG !wScriptFlags0F.1                         ;; 0d:5e05 $08 $f9 $00 $2c
      sMSG                                             ;; 0d:5e09 $04
        db "<10> Change music?<12>"
        db "<11>", $00 ;; 0d:5e0a
      sRNG                                             ;; 0d:5e18 $c7
      sIF_FLAG wScriptFlags0F.7, !wScriptFlags0F.6     ;; 0d:5e19 $08 $7f $fe $00 $02
        sSET_MUSIC 20                                  ;; 0d:5e1e $f8 $14
      sENDIF                                           ;; 0d:5e20
      sIF_FLAG wScriptFlags0F.7, wScriptFlags0F.6      ;; 0d:5e20 $08 $7f $7e $00 $02
        sSET_MUSIC 9                                   ;; 0d:5e25 $f8 $09
      sENDIF                                           ;; 0d:5e27
      sIF_FLAG !wScriptFlags0F.7, wScriptFlags0F.6     ;; 0d:5e27 $08 $ff $7e $00 $02
        sSET_MUSIC 7                                   ;; 0d:5e2c $f8 $07
      sENDIF                                           ;; 0d:5e2e
      sIF_FLAG !wScriptFlags0F.7, !wScriptFlags0F.6    ;; 0d:5e2e $08 $ff $fe $00 $02
        sSET_MUSIC 14                                  ;; 0d:5e33 $f8 $0e
      sENDIF                                           ;; 0d:5e35
    sENDIF                                             ;; 0d:5e35
    sEND                                               ;; 0d:5e35 $00

script_0200:
    sMSG                                               ;; 0d:5e36 $04
      db "<10>I RECOVER YOUR MP.<12>"
      db "<11>", $00 ;; 0d:5e37
    sSFX 5                                             ;; 0d:5e4b $f9 $05
    sFULL_MANA                                         ;; 0d:5e4d $c1
    sEND                                               ;; 0d:5e4e $00

script_0201:
    sEND                                               ;; 0d:5e4f $00

script_0202:
    sMSG                                               ;; 0d:5e50 $04
      db "<10> I'll treat your\n wounds.<12>"
      db "<11>", $00 ;; 0d:5e51
    sSFX 5                                             ;; 0d:5e67 $f9 $05
    sPLAYER_GIVE_STATUS 16                             ;; 0d:5e69 $c4 $10
    sEND                                               ;; 0d:5e6b $00

script_0203:
    sMSG                                               ;; 0d:5e6c $04
      db "<10>Some walls may be\nbroken with <MSTAR>Star\nor <MATT>Mattock.<12>"
      db "<1b>Those walls sound\ndifferent when you\nhit them.<12>"
      db "<11>", $00 ;; 0d:5e6d
    sEND                                               ;; 0d:5eb1 $00

script_0204:
    sMSG                                               ;; 0d:5eb2 $04
      db "<10> I have very\n useful things!<12>"
      db "<11>", $00 ;; 0d:5eb3
    sOPEN_SHOP 3                                       ;; 0d:5ec9 $f6 $03
    sEND                                               ;; 0d:5ecb $00

script_0205:
    sMSG                                               ;; 0d:5ecc $04
      db "<10>Gemma Knights can\nuse the special\npowers of weapons.<12>"
      db "<1b>Try and see it\nwhen your Will\nPower is full.<12>"
      db "<11>", $00 ;; 0d:5ecd
    sEND                                               ;; 0d:5f11 $00

script_0206:
    sMSG                                               ;; 0d:5f12 $04
      db "<10> I'll heal you\n from Stone.<12>"
      db "<11>", $00 ;; 0d:5f13
    sSFX 5                                             ;; 0d:5f27 $f9 $05
    sPLAYER_CURE_STATUS 4                              ;; 0d:5f29 $c2 $04
    sEND                                               ;; 0d:5f2b $00

script_0207:
    sMSG                                               ;; 0d:5f2c $04
      db "<10><BOY>:Let's go!\n<GIRL>:Take the\n Pendant, <BOY>!<12><1b>", $00
    sSFX 15
    sMSG
      db "Received <7b>Pendant!<12>"
      db "<1b>Julius:Give me\n that Pendant!<12>"
      db "<11>", $00 ;; 0d:5f2d
    sSET_MUSIC 9                                       ;; 0d:5f61 $f8 $09
    sSPAWN_NPC 2                                       ;; 0d:5f63 $fd $02
    sSET_NPC_2_DIRECTION_RIGHT                         ;; 0d:5f65 $26
    sDELAY 20                                          ;; 0d:5f66 $f0 $14
    sSET_PLAYER_DIRECTION_LEFT                         ;; 0d:5f68 $87
    sDELAY 60                                          ;; 0d:5f69 $f0 $3c
    sSFX 20                                            ;; 0d:5f6b $f9 $14
    sFLASH_SCREEN                                      ;; 0d:5f6d $bf
    sFLASH_SCREEN                                      ;; 0d:5f6e $bf
    sCREATE_EFFECT $2c, $02, $08                       ;; 0d:5f6f $ba $2c $02 $08
    sCREATE_EFFECT $2c, $04, $08                       ;; 0d:5f73 $ba $2c $04 $08
    sCREATE_EFFECT $2c, $06, $08                       ;; 0d:5f77 $ba $2c $06 $08
    sCREATE_EFFECT $2c, $08, $08                       ;; 0d:5f7b $ba $2c $08 $08
    sCREATE_EFFECT $10, $0a, $08                       ;; 0d:5f7f $ba $10 $0a $08
    sFLASH_SCREEN                                      ;; 0d:5f83 $bf
    sSET_PLAYER_POSITION 10, 9                         ;; 0d:5f84 $8a $0a $09
    sSET_PLAYER_DIRECTION_UP                           ;; 0d:5f87 $84
    sMSG                                               ;; 0d:5f88 $04
      db "<10><GIRL>:Hold on!\n<BOY>:I_ can't_<12>"
      db "<11>", $00 ;; 0d:5f89
    sDELAY 40                                          ;; 0d:5f9f $f0 $28
    sSET_MUSIC 0                                       ;; 0d:5fa1 $f8 $00
    sSET_PLAYER_DIRECTION_DOWN                         ;; 0d:5fa3 $85
    sSET_PLAYER_HURT_SPRITE                            ;; 0d:5fa4 $a5
    sSET_FAST_MOVEMENT                                 ;; 0d:5fa5 $88
    sSFX 12                                            ;; 0d:5fa6 $f9 $0c
    sLOOP 6, 2                                         ;; 0d:5fa8 $03 $06 $02
      sPLAYER_STEP_FORWARD                             ;; 0d:5fab $80
    sEND                                               ;; 0d:5fac $00
    sSCROLL_ROOM_DOWN                                  ;; 0d:5fad $e8
    sSET_PLAYER_POSITION 10, 0                         ;; 0d:5fae $8a $0a $00
    sSFX 12                                            ;; 0d:5fb1 $f9 $0c
    sLOOP 14, 2                                        ;; 0d:5fb3 $03 $0e $02
      sPLAYER_STEP_FORWARD                             ;; 0d:5fb6 $80
    sEND                                               ;; 0d:5fb7 $00
    sLOAD_ROOM 14, $53, 20, 0                          ;; 0d:5fb8 $f4 $0e $53 $14 $00
    sDELAY 60                                          ;; 0d:5fbd $f0 $3c
    sSET_PLAYER_POSITION 14, 0                         ;; 0d:5fbf $8a $0e $00
    sSET_PLAYER_DIRECTION_DOWN                         ;; 0d:5fc2 $85
    sSFX 12                                            ;; 0d:5fc3 $f9 $0c
    sLOOP 5, 2                                         ;; 0d:5fc5 $03 $05 $02
      sPLAYER_STEP_FORWARD                             ;; 0d:5fc8 $80
    sEND                                               ;; 0d:5fc9 $00
    sSET_PLAYER_POSITION 20, 0                         ;; 0d:5fca $8a $14 $00
    sCREATE_EFFECT $10, $0e, $05                       ;; 0d:5fcd $ba $10 $0e $05
; Fill tiles just outside the screen before the shake effect.
    sSET_ROOM_TILE $21, 10, 0
    sSET_ROOM_TILE $73, 10, 1
    sSET_ROOM_TILE $74, 10, 2
    sSET_ROOM_TILE $52, 10, 3
    sSET_ROOM_TILE $1e, 10, 4
    sSET_ROOM_TILE $00, 10, 5
    sSET_ROOM_TILE $00, 10, 6
    sSET_ROOM_TILE $1c, 10, 7
    sSET_ROOM_TILE $0b, 15, 0
    sSET_ROOM_TILE $0b, 15, 1
    sSET_ROOM_TILE $0b, 15, 2
    sSET_ROOM_TILE $0b, 15, 3
    sSET_ROOM_TILE $0b, 15, 4
    sSET_ROOM_TILE $2d, 15, 5
    sSET_ROOM_TILE $2d, 15, 6
    sSET_ROOM_TILE $07, 15, 7
    sSFX 25                                            ;; 0d:5fd1 $f9 $19
    sFLASH_SCREEN                                      ;; 0d:5fd3 $bf
    sSHAKE_SCREEN                                      ;; 0d:5fd4 $fb
    sDELAY 60                                          ;; 0d:5fd5 $f0 $3c
    sCLEAR_FAST_MOVEMENT                               ;; 0d:5fd7 $89
    sSET_PLAYER_NORMAL_SPRITE                          ;; 0d:5fd8 $a4
    sSET_PLAYER_DIRECTION_RIGHT                        ;; 0d:5fd9 $86
    sCALL script_0208                                  ;; 0d:5fda $02 $1f $df
    sCLEAR_ROOM_HISTORY                                ;; 0d:5fdd $ab
    sEND                                               ;; 0d:5fde $00

script_0208:
    sMSG                                               ;; 0d:5fdf $04
      db "<10>_ Wow!  Somebody\n_ came down from\n_ the sky!<12>"
      db "<1b>_ __ <BOY>?!\n_ ", $00
    sIF_FLAG wScriptFlags01.7
      sMSG
      db "Do you know her", $00
    sENDIF
    sIF_FLAG wScriptFlags06.3
      sMSG
      db "Do you know him", $00
    sENDIF
    sIF_FLAG !wScriptFlags01.7, !wScriptFlags06.3
      sMSG
      db "Friend of yours", $00
    sENDIF
    sMSG
      db "?\n___ _ <BOY>__!<12><11>", $00
    sFADE_TO_BLACK                                     ;; 0d:6024 $bd
    sUNK_C5 7                                          ;; 0d:6025 $c5 $07
; Replace the player with an NPC that looks the same without the shield
    sLOAD_ROOM_INSTANT 4, $00, 20, 3
    sSET_NPC_TYPES 37                                  ;; 0d:602c $fc $25
    sSPAWN_NPC 2                                       ;; 0d:602e $fd $02
    sSPAWN_NPC 1
    sSET_NPC_2_POSITION 14, 3
    sSET_NPC_2_DIRECTION_RIGHT
    sSET_NPC_1_POSITION 10, 4                          ;; 0d:6030 $19 $0a $04
    sSET_NPC_1_DIRECTION_RIGHT                         ;; 0d:6033 $16
    sDELAY 90                                          ;; 0d:6034 $f0 $5a
    sFADE_TO_NORMAL                                    ;; 0d:6036 $bc
    sSET_MUSIC 10                                      ;; 0d:6037 $f8 $0a
    sDELAY 70                                          ;; 0d:6039 $f0 $46
    sNPC_1_STEP_FORWARD                                ;; 0d:603b $10
    sNPC_1_STEP_FORWARD                                ;; 0d:603c $10
    sMSG                                               ;; 0d:603d $04
      db "<10>", $00
    sCALL script_0433
    sMSG
      db ":I'm glad\n to see you again,\n my friend__<12>"
      db "<1b> I escaped from\n Granz after you\n left__<12>"
      db "<1b> Oh, <BOY>__\n", $00 ;; 0d:603e
    sDELAY 50                                          ;; 0d:608a $f0 $32
    sMSG                                               ;; 0d:608c $04
      db " I'm sorry__", $00                           ;; 0d:608d
    sDELAY 40                                          ;; 0d:6096 $f0 $28
    sMSG                                               ;; 0d:6098 $04
      db "\n But I have to__<12>"
      db "<11>", $00 ;; 0d:6099
    sFADE_TO_BLACK                                     ;; 0d:60a6 $bd
    sDELAY 60                                          ;; 0d:60a7 $f0 $3c
    sDEL_NPC_1                                         ;; 0d:60a9 $18
    sSET_MUSIC 0                                       ;; 0d:60aa $f8 $00
    sFULL_HP
    sFULL_MANA
    sDELAY 60                                          ;; 0d:60ac $f0 $3c
    sFADE_TO_NORMAL                                    ;; 0d:60ae $bc
    sSET_PLAYER_DIRECTION_DOWN                         ;; 0d:60af $85
    sSET_NPC_2_DIRECTION_DOWN
    sNPC_2_STEP_FORWARD
    sNPC_2_STEP_FORWARD
    sDELAY 16
    sSET_PLAYER_POSITION 14, 5
    sDEL_NPC_2
    sDELAY 34
    sMSG                                               ;; 0d:60b4 $04
      db "<10><BOY>:_Where am I?\n", $00               ;; 0d:60b5
    sDELAY 30                                          ;; 0d:60c2 $f0 $1e
    sMSG                                               ;; 0d:60c4 $04
      db " __ The Pendant!\n __ It's gone?!<12>"
      db "<1b> __ I think that I\n remember ", $00
    sCALL script_0433
    sMSG
      db "\n talking to me?<12>"
      db "<11>", $00 ;; 0d:60c5
    sSET_MUSIC 4                                       ;; 0d:60fc $f8 $04
    sEND                                               ;; 0d:60fe $00

script_0209:
    sMSG                                               ;; 0d:60ff $04
      db "<10>Someone is being\nheld in a cell\non this airship!<12>"
      db "<11>", $00 ;; 0d:6100
    sEND                                               ;; 0d:6121 $00

script_020a:
    sEND                                               ;; 0d:6122 $00

script_020b:
    sMSG                                               ;; 0d:6123 $04
      db "<10>Repairs are almost\ndone. You'd better\nget back to work!<12>"
      db "<11>", $00 ;; 0d:6124
    sEND                                               ;; 0d:6133 $00

script_020c:
    sEND                                               ;; 0d:6134 $00

script_020d:
    sMSG                                               ;; 0d:6135 $04
      db "<10>Years ago, Shadow\nKnight found an\nabandoned baby in<12>"
      db "<1b>a cave behind the\nWaterfalls near\nCastle Granz.<12>"
      db "<1b>__ That's Julius.<12>"
      db "<11>", $00 ;; 0d:6136
    sEND                                               ;; 0d:617b $00

script_020e:
    sMSG                                               ;; 0d:617c $04
      db "<10>Sorcerer Julius is\nin command of this\nairship.<12>"
      db "<11>", $00 ;; 0d:617d
    sEND                                               ;; 0d:619e $00

script_020f:
    sSET_NPC_1_DIRECTION_UP                            ;; 0d:619f $14
    sUNK_1A                                            ;; 0d:61a0 $1a
    sLOOP 4, 2                                         ;; 0d:61a1 $03 $04 $02
      sNPC_1_STEP_FORWARD                              ;; 0d:61a4 $10
    sEND                                               ;; 0d:61a5 $00
    sMSG                                               ;; 0d:61a6 $04
      db "<10>", $00                                   ;; 0d:61a7
    sIF_FLAG !wScriptFlags02.6                         ;; 0d:61a9 $08 $96 $00 $7d
      sMSG                                             ;; 0d:61ad $04
        db "<BOY>:<GIRL>!\n", $00                      ;; 0d:61ae
      sSFX 23                                          ;; 0d:61b4 $f9 $17
      sMSG                                             ;; 0d:61b6 $04
        db "Bogard:Hurry!\n It's moving!<12>"
        db "<1b><GIRL>:This door\n is locked!<12>"
        db "<1b>Bogard:How about\n the window?<12>"
        db "<11>", $00 ;; 0d:61b7
      sSET_NPC_1_DIRECTION_DOWN                        ;; 0d:61f8 $15
      sLOOP 4, 2                                       ;; 0d:61f9 $03 $04 $02
        sNPC_1_STEP_FORWARD                            ;; 0d:61fc $10
      sEND                                             ;; 0d:61fd $00
      sDELAY 20                                        ;; 0d:61fe $f0 $14
      sSET_NPC_1_DIRECTION_UP                          ;; 0d:6200 $14
      sLOOP 4, 2                                       ;; 0d:6201 $03 $04 $02
        sNPC_1_STEP_FORWARD                            ;; 0d:6204 $10
      sEND                                             ;; 0d:6205 $00
      sMSG                                             ;; 0d:6206 $04
        db "<10><GIRL>:It may open.\n<BOY>:I'll get you\n from outside!<12><1b>", $00 ;; 0d:6207
      sSET_FLAG wScriptFlags02.6                       ;; 0d:6228 $da $16
    sENDIF                                             ;; 0d:622a
    sMSG                                               ;; 0d:622a $04
      db "<GIRL>:Be careful!<12>"
      db "<11>", $00 ;; 0d:622b
    sLOOP 4, 2                                         ;; 0d:6237 $03 $04 $02
      sNPC_1_STEP_BACKWARDS                            ;; 0d:623a $11
    sEND                                               ;; 0d:623b $00
    sUNK_1B                                            ;; 0d:623c $1b
    sEND                                               ;; 0d:623d $00

script_0210:
    sMSG                                               ;; 0d:623e $04
      db "Bogard:I knew you\n would do it.<12>"
      db "<1b> Now, listen.\n It'll be perilous\n from now on.<12>"
      db "<1b> Julius has got\n the power of Mana\n already.<12>"
      db "<1b> Our only hope is\n a Knight with the\n legendary sword.<12>"
      db "<1b><BOY>:Legend_ __!!\n The Mana Sword?!\nBogard:Yes.<12>"
      db "<1b> And it is how we\n defeated the evil\n power of Vandole.<12>"
      db "<1b><BOY>:_ You_ _\n_ Where is that\n sword now?<12>"
      db "<1b>Bogard:Somewhere\n in this world__<12>"
      db "<1b> Go to Wendel and\n ask Cibba.\n He knows better.<12>"
      db "<1b> Ask Dr. Bon\n Voyage how to\n get there.", $00
    sEND                                               ;; 0d:637d $00

script_0211:
    sMSG                                               ;; 0d:637e $04
      db "<10>Are you okay?\n_You are in Menos.<12>"
      db "<1b>", $00
    sCALL script_0433
    sMSG
      db " left the\nvillage early\nthis morning.<12>"
      db "<11>", $00 ;; 0d:637f
    sEND                                               ;; 0d:63bc $00

script_0212:
    sMSG                                               ;; 0d:63bd $04
      db "<10>We used to see\nmany Chocobos\naround here.<12>"
      db "<1b>I saw an egg in a\nforest up north!<12>"
      db "<11>", $00 ;; 0d:63be
    sEND                                               ;; 0d:63f7 $00

script_0213:
    sMSG                                               ;; 0d:63f8 $04
      db "<10>", $00
    sCALL script_0433
    sMSG
      db "'s little\nbrother, Lester,\nis a musician.<12>"
      db "<1b>He's playing harp\nin a town called\nJadd.<12>"
      db "<11>", $00 ;; 0d:63f9
    sEND                                               ;; 0d:6438 $00

script_0214:
    sMSG                                               ;; 0d:6439 $04
      db "<10>I used to hear a\nbeautiful sound of\nharp over in Jadd.<12>"
      db "<1b>Jadd is at the\nnorth end of\nthe desert.<12>"
      db "<11>", $00 ;; 0d:643a
    sEND                                               ;; 0d:647b $00

script_0215:
    sMSG                                               ;; 0d:647c $04
      db "<10>Undine's Book is\nhidden somewhere\nin the desert!<12>"
      db "<11>", $00 ;; 0d:647d
    sEND                                               ;; 0d:64a1 $00

script_0216:
    sMSG                                               ;; 0d:64a2 $04
      db "<10>What's wrong with\n", $00
    sCALL script_0433
    sMSG
      db " lately?\n", $00
    sIF_FLAG wScriptFlags0A.0
      sMSG
        db "Sh", $00
    sELSE
      sMSG
        db "H", $00
    sENDIF
    sMSG
      db "e's depressed.<12>"
      db "<11>", $00 ;; 0d:64a3
    sEND                                               ;; 0d:64c8 $00

script_0217:
    sMSG                                               ;; 0d:64c9 $04
      db "<10> __??", $00                              ;; 0d:64ca
; Add some movement to the egg by flipping its direction.
    sDELAY 10
    sSET_NPC_1_DIRECTION_RIGHT
    sDELAY 10
    sSET_NPC_1_DIRECTION_LEFT
    sDELAY 10
    sSET_NPC_1_DIRECTION_RIGHT
    sDELAY 10
    sSET_NPC_1_DIRECTION_LEFT
    sDELAY 20
    sMSG                                               ;; 0d:64d2 $04
      db "  Wow!\n It's moving!<12>"
      db "<11>", $00 ;; 0d:64d3
    sDELAY 10
    sSET_NPC_1_DIRECTION_RIGHT
    sDELAY 10
    sSET_NPC_1_DIRECTION_LEFT
    sDELAY 40
    sDEL_NPC_1                                         ;; 0d:64e6 $18
    sSFX 15                                            ;; 0d:64e7 $f9 $0f
    sSPAWN_NPC 1                                       ;; 0d:64e9 $fd $01
    sSET_NPC_1_DIRECTION_LEFT                          ;; 0d:64eb $17
    sSET_MUSIC 5                                       ;; 0d:64ec $f8 $05
    sDELAY 120                                         ;; 0d:64ee $f0 $78
    sMSG                                               ;; 0d:64f0 $04
      db "<10>__ What are you??<12>"
      db "<11>", $00 ;; 0d:64f1
    sSET_PLAYER_DIRECTION_LEFT                         ;; 0d:64ff $87
    sPLAYER_STEP_FORWARD                               ;; 0d:6500 $80
    sPLAYER_STEP_FORWARD                               ;; 0d:6501 $80
    sNPC_1_STEP_FORWARD                                ;; 0d:6502 $10
    sSFX 7                                             ;; 0d:6503 $f9 $07
    sDELAY 15                                          ;; 0d:6505 $f0 $0f
    sSFX 7                                             ;; 0d:6507 $f9 $07
    sNPC_1_STEP_FORWARD                                ;; 0d:6509 $10
    sDELAY 60                                          ;; 0d:650a $f0 $3c
    sSET_PLAYER_DIRECTION_RIGHT                        ;; 0d:650c $86
    sDELAY 40                                          ;; 0d:650d $f0 $28
    sMSG                                               ;; 0d:650f $04
      db "<10>__ Hey!\nDon't follow me!<12>"
      db "<11>", $00 ;; 0d:6510
    sSET_PLAYER_DIRECTION_LEFT                         ;; 0d:6524 $87
    sPLAYER_STEP_FORWARD                               ;; 0d:6525 $80
    sPLAYER_STEP_FORWARD                               ;; 0d:6526 $80
    sNPC_1_STEP_FORWARD                                ;; 0d:6527 $10
    sSFX 7                                             ;; 0d:6528 $f9 $07
    sDELAY 15                                          ;; 0d:652a $f0 $0f
    sSFX 7                                             ;; 0d:652c $f9 $07
    sNPC_1_STEP_FORWARD                                ;; 0d:652e $10
    sDELAY 60                                          ;; 0d:652f $f0 $3c
    sSET_PLAYER_DIRECTION_RIGHT                        ;; 0d:6531 $86
    sMSG                                               ;; 0d:6532 $04
      db "<10>You think I'm\nyour mother?<12>"
      db "<1b>__ ", $00 ;; 0d:6533
    sDELAY 80                                          ;; 0d:654a $f0 $50
    sMSG                                               ;; 0d:654c $04
      db " Okay.\n__ Come with me!<12>"
      db "<11>", $00 ;; 0d:654d
    sGIVE_FOLLOWER 9                                   ;; 0d:6560 $9c $09
    sSET_FLAG wScriptFlags03.1                         ;; 0d:6562 $da $19
    sSET_FLAG wScriptFlags0B.0                         ;; 0d:6564 $da $58
    sSFX 7                                             ;; 0d:6566 $f9 $07
    sDELAY 10                                          ;; 0d:6568 $f0 $0a
    sSFX 7                                             ;; 0d:656a $f9 $07
    sDELAY 10                                          ;; 0d:656c $f0 $0a
    sSFX 7                                             ;; 0d:656e $f9 $07
    sSET_MUSIC 20                                      ;; 0d:6570 $f8 $14
    sEND                                               ;; 0d:6572 $00

script_0218:
    sMSG                                               ;; 0d:6573 $04
      db "<10>Davias:Better\n behave yourself\n in this town.<12>"
      db "<1b> __ ", $00
    sCALL script_0433
    sMSG
      db "__?\n Oh, yes!\n That ", $00
    sIF_FLAG wScriptFlags0A.0
      sMSG
        db "girl__<12><1b> Sh", $00
    sELSE
      sMSG
        db "boy__<12><1b> H", $00
    sENDIF
    sMSG
      db "e went to\n Medusa's Cave.\n<12>"
      db "<1b> Nobody has ever\n come back from\n there alive.<12>"
      db "", $00 ;; 0d:6574
    sSET_FLAG wScriptFlags03.2                         ;; 0d:65e7 $da $1a
    sMSG                                               ;; 0d:65e9 $04
      db "<11>", $00                                   ;; 0d:65ea
    sEND                                               ;; 0d:65ec $00

script_0219:
    sIF_EQUIPED INV_ITEM_POTION_AMANDA                 ;; 0d:65ed $09 $2a $00 $53
      sSET_MUSIC 0                                     ;; 0d:65f1 $f8 $00
      sMSG                                             ;; 0d:65f3 $04
        db "<10><BOY> used <POT>Tears,\nthe tears of\n", $00
      sCALL script_0433
      sMSG
        db "__", $00
      sDELAY 120                                       ;; 0d:660e $f0 $78
      sTAKE_EQUIPED_ITEM                               ;; 0d:6610 $de
      sMSG                                             ;; 0d:6611 $04
        db "<11>", $00                                 ;; 0d:6612
      sDEL_NPC_1                                       ;; 0d:6614 $18
      sSFX 6                                           ;; 0d:6615 $f9 $06
      sSPAWN_NPC 2                                     ;; 0d:6617 $fd $02
      sGIVE_FOLLOWER 6                                 ;; 0d:6619 $9c $06
      sMSG                                             ;; 0d:661b $04
        db "<10>    Lester was\n  released from\n Davias's curse__<12>"
        db "<1b>", $00 ;; 0d:661c
      sCALL script_053c                                ;; 0d:663b $02 $6d $32
      sSET_FLAG wScriptFlags0A.6                       ;; 0d:663e $da $56
      sSET_FLAG wScriptFlags03.5                       ;; 0d:6640 $da $1d
      sSET_MUSIC 14                                    ;; 0d:6642 $f8 $0e
    sENDIF                                             ;; 0d:6644
    sEND                                               ;; 0d:6644 $00

script_021a:
    sMSG                                               ;; 0d:6645 $04
      db "<10>Welcome to Jadd.", $00                   ;; 0d:6646
    sIF_FLAG !wScriptFlags05.0                         ;; 0d:6654 $08 $a8 $00 $19
      sMSG                                             ;; 0d:6658 $04
        db "\nDavias rules this\ntown. I hate it.", $00 ;; 0d:6659
    sENDIF                                             ;; 0d:6671
    sMSG                                               ;; 0d:6671 $04
      db "<12>"
      db "<11>", $00                   ;; 0d:6672
    sEND                                               ;; 0d:6675 $00

script_021b:
    sMSG                                               ;; 0d:6676 $04
      db "<10>", $00                                   ;; 0d:6677
    sIF_FLAG !wScriptFlags05.0                         ;; 0d:6679 $08 $a8 $00 $20
      sMSG                                             ;; 0d:667d $04
        db "Northern valley is\nfilled with fatal\npoison gas.", $00 ;; 0d:667e
    sELSE                                              ;; 0d:669b $01 $30
      sMSG                                             ;; 0d:669d $04
        db "The poison gas\nhas cleared!<12>"
        db "<1b>North through\nthe valley is\nMt. Rocks.", $00
    sENDIF                                             ;; 0d:66cd
    sMSG                                               ;; 0d:66cd $04
      db "<12>"
      db "<11>", $00                   ;; 0d:66ce
    sEND                                               ;; 0d:66d1 $00

script_021c:
    sMSG                                               ;; 0d:66d2 $04
      db "<10>The poison gas\nappeared when\nthe harp stopped.<12>"
      db "<11>", $00 ;; 0d:66d3
    sEND                                               ;; 0d:66f5 $00

script_021d:
    sMSG                                               ;; 0d:66f6 $04
      db "<10>See that huge\nmansion? That's\nDavias's house!<12>"
      db "<11>", $00 ;; 0d:66f7
    sEND                                               ;; 0d:6719 $00

script_021e:
    sMSG                                               ;; 0d:671a $04
      db "<10>Davias can cast a\nspell to change\npeople to animals.<12>"
      db "<1b>Many people went\nto his place and\nnever came back!<12>"
      db "<11>", $00 ;; 0d:671b
    sEND                                               ;; 0d:6765 $00

script_021f:
    sMSG                                               ;; 0d:6766 $04
      db "<10>To uncurse, you\nneed a teardrop\nof Medusa.<12>"
      db "<11>", $00 ;; 0d:6767
    sEND                                               ;; 0d:6785 $00

script_0220:
    sMSG                                               ;; 0d:6786 $04
      db "<10>Davias's mother\nis a Medusa.<12>"
      db "<1b>He locked her in\na cave because\nshe is so ugly.<12>"
      db "<11>", $00 ;; 0d:6787
    sEND                                               ;; 0d:67eb $00

script_0221:
    sMSG                                               ;; 0d:67ec $04
      db "<10>Medusa's Cave?", $00
      sDELAY 30
    sMSG
      db "\nI've been there.<12>"
      db "<1b>I'll tell you how\nto find it for a\nSaurus <FANG>Fang!<12>"
      db "<13><1b>", $00 ;; 0d:67ed
    sIF_FLAG !wScriptFlags0F.7                         ;; 0d:6810 $08 $ff $00 $28
      sIF_EQUIPED INV_ITEM_BAG_FANG                    ;; 0d:6814 $09 $3b $00 $06
        sTAKE_EQUIPED_ITEM                             ;; 0d:6818 $de
        sCALL script_022e                              ;; 0d:6819 $02 $2d $01
      sELSE                                            ;; 0d:681c $01 $1c
        sIF_INVENTORY INV_ITEM_BAG_FANG                ;; 0d:681e $0a $3b $00 $07
          sTAKE_ITEM INV_ITEM_BAG_FANG                 ;; 0d:6822 $d5 $32
          sCALL script_022e                            ;; 0d:6824 $02 $2d $01
        sELSE                                          ;; 0d:6827 $01 $11
          sMSG                                         ;; 0d:6829 $04
            db "But, you don't\nhave it!", $00         ;; 0d:682a
        sENDIF                                         ;; 0d:683a
      sENDIF                                           ;; 0d:683a
    sELSE                                              ;; 0d:683a $01 $1c
      sMSG                                             ;; 0d:683c $04
        db "Don't you know?\nIt's very\nvaluable!", $00 ;; 0d:683d
    sENDIF                                             ;; 0d:6858
    sMSG                                               ;; 0d:6858 $04
      db "<12>"
      db "<11>", $00                   ;; 0d:6859
    sEND                                               ;; 0d:685c $00

script_0222:
    sMSG                                               ;; 0d:685d $04
      db "<10>Lester:Good luck!<12>"
      db "<11>", $00 ;; 0d:685e
    sEND                                               ;; 0d:686d $00

script_0223:
    sSET_NPC_TYPES 94                                  ;; 0d:686e $fc $5e
    sSPAWN_NPC 0                                       ;; 0d:6870 $fd $00
    sEND                                               ;; 0d:6872 $00

script_0224:
    sEND                                               ;; 0d:6873 $00

script_0225:
    sEND                                               ;; 0d:6874 $00

script_0226:
    sSPAWN_NPC 1                                       ;; 0d:6875 $fd $01
    sMSG                                               ;; 0d:6877 $04
      db "<10><BOY>:__I'm sorry,\n ", $00
    sCALL script_0433
    sMSG
      db " __\n But I had to __<12>"
      db "<11>", $00 ;; 0d:6878
    sSET_FLAG wScriptFlags03.4                         ;; 0d:6899 $da $1c
    sEND                                               ;; 0d:689b $00

script_0227:
    sFOLLOWER_DIRECTION_DOWN                           ;; 0d:689c $95
    sMSG                                               ;; 0d:689d $04
      db "<10>", $00                                   ;; 0d:689e
    sSET_MUSIC 0                                       ;; 0d:68a0 $f8 $00
    sCALL script_0433
    sMSG                                               ;; 0d:68a2 $04
      db ":__Ouch!", $00                         ;; 0d:68a3
    sSET_PLAYER_DIRECTION_LEFT                         ;; 0d:68af $87
    sPLAYER_STEP_FORWARD                               ;; 0d:68b0 $80
    sMSG                                               ;; 0d:68b1 $04
      db "\n<BOY>:Are you okay?<12>"
      db "<1b>", $00
    sCALL script_0433
    sMSG
      db ":I guess\n Medusa bit me\n while fighting__<12>"
      db "", $00 ;; 0d:68b2
    sSET_MUSIC 2                                       ;; 0d:68df $f8 $02
    sMSG                                               ;; 0d:68e1 $04
      db "<1b> __ One who was\n bitten by Medusa\n turns to Medusa.<12>"
      db "<1b> I'm gonna turn\n into a Medusa in\n a short while__<12>"
      db "<1b> Please do away\n with me and take\n my tears, <BOY>.<12>"
      db "<1b><BOY>:No, I can't!\n", $00
    sCALL script_0433
    sMSG
      db ":I'm gonna\n be a monster__<12>"
      db "<1b> I might lose my\n mind and hurt\n people__<12>"
      db "<1b>", $00 ;; 0d:68e2
    sFOLLOWER_DELETE                                   ;; 0d:6986 $98
    sSET_NPC_TYPES 66                                  ;; 0d:6987 $fc $42
    sSPAWN_NPC 0                                       ;; 0d:6989 $fd $00
    sDELAY 30                                          ;; 0d:698b $f0 $1e
    sMSG                                               ;; 0d:698d $04
      db " Please__ <BOY>__\n Before I lose\n my feelings__<12>"
      db "<1b> Please take my\n tears to Lester.<12>"
      db "<1b> Tell him that\n I loved him__\n", $00 ;; 0d:698e
    sDELAY 40                                          ;; 0d:69d7 $f0 $28
    sMSG                                               ;; 0d:69d9 $04
      db " _ Please __<12>"
      db "<1b> <BOY> __\n", $00 ;; 0d:69da
    sDELAY 30                                          ;; 0d:69ea $f0 $1e
    sMSG                                               ;; 0d:69ec $04
      db " Pl_ please_ _ _<12>"
      db "<11>", $00   ;; 0d:69ed
    sEND                                               ;; 0d:69fe $00

script_0228:
    sGIVE_ITEM INV_ITEM_POTION_AMANDA                  ;; 0d:69ff $d4 $21
    sIF_FLAG !wScriptFlags.5                           ;; 0d:6a01 $08 $85 $00 $42
      sFADE_TO_BLACK                                   ;; 0d:6a05 $bd
      sLOAD_ROOM_INSTANT 15, $55, 20, 0                ;; 0d:6a06 $f3 $0f $55 $14 $00
      sFADE_TO_NORMAL                                  ;; 0d:6a0b $bc
      sMSG                                             ;; 0d:6a0c $04
        db "<10> <BOY> took a drop\n   of tear from\n  ", $00
      sIF_FLAG wScriptFlags0A.0
        sMSG
          db "Amanda", $00
      sELSE
        sMSG
          db " Duke", $00
      sENDIF
      sMSG
        db "'s face.<12>"
        db "<1b>", $00 ;; 0d:6a0d
      sDELAY 30                                        ;; 0d:6a2f $f0 $1e
      sMSG                                             ;; 0d:6a31 $04
        db "<11>", $00                                 ;; 0d:6a32
      sDELAY 60                                        ;; 0d:6a34 $f0 $3c
      sSET_MUSIC 0                                     ;; 0d:6a36 $f8 $00
      sDELAY 60                                        ;; 0d:6a38 $f0 $3c
      sLOAD_ROOM 0, $2c, 14, 4                         ;; 0d:6a3a $f4 $00 $2c $0e $04
      sSET_FLAG wScriptFlags06.5                       ;; 0d:6a3f $da $35
      sDELAY 10                                        ;; 0d:6a41 $f0 $0a
      sSET_MUSIC 20                                    ;; 0d:6a43 $f8 $14
      sCLEAR_ROOM_HISTORY                              ;; 0d:6a45 $ab
      sRUN_ROOM_SCRIPT                                 ;; 0d:6a46 $ec
    sENDIF                                             ;; 0d:6a47
    sEND                                               ;; 0d:6a47 $00

script_0229:
    sMSG                                               ;; 0d:6a48 $04
      db "<10>", $00                                   ;; 0d:6a49
    sIF_FLAG wScriptFlags0F.1                          ;; 0d:6a4b $08 $79 $00 $18
      sMSG                                             ;; 0d:6a4f $04
        db "Old man:Go away!", $00                     ;; 0d:6a50
      sIF_FLAG wScriptFlags01.3, wScriptFlags0A.1      ;; 0d:6a5d $08 $0b $51 $00 $05
        sCALL script_022a                              ;; 0d:6a62 $02 $2a $bb
        sSET_FLAG wScriptFlags01.4                     ;; 0d:6a65 $da $0c
      sENDIF                                           ;; 0d:6a67
    sENDIF                                             ;; 0d:6a67
    sIF_FLAG !wScriptFlags01.4                         ;; 0d:6a67 $08 $8c $00 $4f
      sIF_FLAG wScriptFlags0F.0, !wScriptFlags0F.1     ;; 0d:6a6b $08 $78 $f9 $00 $1b
        sMSG                                           ;; 0d:6a70 $04
          db "Old man:I don't\n know anything!", $00   ;; 0d:6a71
        sSET_FLAG wScriptFlags0F.1                     ;; 0d:6a89 $da $79
      sENDIF                                           ;; 0d:6a8b
      sIF_FLAG !wScriptFlags0F.0                       ;; 0d:6a8b $08 $f8 $00 $27
        sMSG                                           ;; 0d:6a8f $04
          db "<BOY>:Excuse me.\n I'm looking for a\n man named Bogard.", $00 ;; 0d:6a90
        sSET_FLAG wScriptFlags0F.0                     ;; 0d:6ab4 $da $78
      sENDIF                                           ;; 0d:6ab6
      sMSG                                             ;; 0d:6ab6 $04
        db "<12>"
        db "<11>", $00               ;; 0d:6ab7
    sENDIF                                             ;; 0d:6aba
    sEND                                               ;; 0d:6aba $00

script_022a:
    sMSG                                               ;; 0d:6abb $04
      db "\n", $00                                     ;; 0d:6abc
    sDELAY 40                                          ;; 0d:6abe $f0 $28
    sMSG                                               ;; 0d:6ac0 $04
      db " _", $00                                     ;; 0d:6ac1
    sDELAY 50                                          ;; 0d:6ac4 $f0 $32
    sMSG                                               ;; 0d:6ac6 $04
      db " _", $00                                     ;; 0d:6ac7
    sDELAY 30                                          ;; 0d:6aca $f0 $1e
    sMSG                                               ;; 0d:6acc $04
      db " That is_ the_\n Pendant of Mana.<12>"
      db "<1b><GIRL>:_ My mother\n gave me this.<12>"
      db "<1b><GIRL>:Are you the\n Gemma Knight?<12>"
      db "<1b>Bogard:_ Yes.\n Back when Vandole\n was trying to<12>"
      db "<1b> conquer the world\n with the power\n of Mana.<12>"
      db "<1b> We fought against\n them to restore\n peace. But_<12>"
      db "<1b> We were losing_\n The power of Mana\n was too strong.<12>"
      db "<1b> But there was a\n lady who assured\n our victory.<12>"
      db "<1b> That lady had\n that Pendant on\n her chest.<12>"
      db "<1b> It seems like you\n may be the key\n this time, <GIRL>.<12>"
      db "<1b> Take the Mattock\n in the next room!<12>", $00
    sCALL script_022b                                  ;; 0d:6c0d $02 $2c $14
    sSFX 16                                            ;; 0d:6c10 $f9 $10
    sOPEN_NORTH_DOOR                                   ;; 0d:6c12 $e0
    sEND                                               ;; 0d:6c13 $00

script_022b:
    sIF_FLAG wScriptFlags01.4                          ;; 0d:6c17 $08 $0c $00 $24
      sMSG                                             ;; 0d:6c1b $04
        db "<10>Bogard:You can\n also buy mattocks\n at Item Shops.<12>", $00
    sENDIF                                             ;; 0d:6c3f
    sMSG                                               ;; 0d:6c3f $04
      db "<1b> Go to the cave on\n the east side of\n the mountains.<12>"
      db "<1b> Use a Mattock\n to clear rocks\n in the cave. See<12>"
      db "<1b> Cibba in the town\n called Wendel.\n He knows more.<12>"
      db "<11>", $00 ;; 0d:6c40
    sEND                                               ;; 0d:6ca4 $00

script_022c:
    sMSG                                               ;; 0d:6ca5 $04
      db "<10>", $00                                   ;; 0d:6ca6
    sIF_FLAG !wScriptFlags04.1                         ;; 0d:6ca8 $08 $a1 $00 $0b
      sMSG                                             ;; 0d:6cac $04
        db "Bogard:_____", $00                         ;; 0d:6cad
    sENDIF                                             ;; 0d:6cb7
    sIF_FLAG wScriptFlags04.1, !wScriptFlags04.2       ;; 0d:6cb7 $08 $21 $a2 $00 $03
      sCALL script_0210                                ;; 0d:6cbc $02 $22 $3e
    sENDIF                                             ;; 0d:6cbf
    sIF_FLAG wScriptFlags04.2                          ;; 0d:6cbf $08 $22 $00 $1e
      sMSG                                             ;; 0d:6cc3 $04
        db "Bogard:The final\n showdown! Come\n back alive, <BOY>.", $00
    sENDIF                                             ;; 0d:6ce1
    sMSG                                               ;; 0d:6ce1 $04
      db "<12>"
      db "<11>", $00                   ;; 0d:6ce2
    sEND                                               ;; 0d:6ce5 $00

script_022d:
    sMSG                                               ;; 0d:6ce6 $04
      db "<10>Bogard:I'll take\n care of her.<12>"
      db "<11>", $00 ;; 0d:6ce7
    sEND                                               ;; 0d:6d00 $00

script_022e:
    sMSG                                               ;; 0d:6d01 $04
      db "The entrance to\nMedusa's Cave is\nat the oasis.<12>"
      db "<1b>Trace a figure\neight around the\npalm trees there.", $00
    sEND                                               ;; 0d:6d24 $00

script_022f:
    sMSG                                               ;; 0d:6d25 $04
      db "<10>Bon Voyage:", $00
    sIF_FLAG !wScriptFlags05.7                         ;; 0d:6d2c $08 $af $00 $43
      sMSG                                             ;; 0d:6d30 $04
        db "Go east\n on the sea from\n the north pier.<12>"
        db "<1b> And go north to\n Wendel.__South is\n to the Ammonites.", $00
    sELSE                                              ;; 0d:6d71 $01 $a5
      sMSG                                             ;; 0d:6d73 $04
        db "Done?!\n", $00
      sIF_INVENTORY INV_MAGIC_NUKE                     ;; 0d:6d7c $0a $08 $00 $3c
        sMSG                                           ;; 0d:6d80 $04
IF DEF(MANA)
          db " A crystal in the\n desert can be<12>"
          db "<1b> destroyed with\n Nuke.<12>"
          db "<1b> It rings when\n struck.\n __ Find it!", $00
ELIF DEF(FINAL_FANTASY)
          db " A crystal in the\n desert can be<12>"
          db "<1b> destroyed with\n Flare.<12>"
          db "<1b> It rings when\n struck.\n __ Find it!", $00
ENDC
      sELSE                                            ;; 0d:6dba $01 $5c
        sMSG                                           ;; 0d:6dbc $04
          db " But you need the\n ultimate magic.<12>"
          db "<1b> It is in Shade's\n book, which is\n sealed by Lich.<12>"
          db "<1b> Go north to the\n Palmy Desert and\n defeat Lich!", $00
      sENDIF                                           ;; 0d:6e18
    sENDIF                                             ;; 0d:6e18
    sMSG                                               ;; 0d:6e18 $04
      db "<12>"
      db "<11>", $00                   ;; 0d:6e19
    sEND                                               ;; 0d:6e1c $00

script_0230:
    sMSG                                               ;; 0d:6e1d $04
      db "<10>There is no way\nto cross seas.\nBut, you know_<12>"
      db "<1b>Maybe Dr. Bon\nVoyage can build\nsomething.<12>"
      db "<1b>He lives in a\nhouse over there.<12>"
      db "<11>", $00 ;; 0d:6e1e
    sEND                                               ;; 0d:6e6e $00

script_0231:
    sMSG                                               ;; 0d:6e6f $04
      db "<10>", $00                                   ;; 0d:6e70
    sIF_FLAG wScriptFlags04.0                          ;; 0d:6e72 $08 $20 $00 $19
      sMSG                                             ;; 0d:6e76 $04
        db "Sarah:Please__\n Save us all_!<12>"
        db "<11>", $00 ;; 0d:6e77
    sELSE                                              ;; 0d:6e8d $01 $0a
      sCALL script_0232                                ;; 0d:6e8f $02 $2e $9a
      sNPC_1_STEP_BACKWARDS                            ;; 0d:6e92 $11
      sNPC_1_STEP_BACKWARDS                            ;; 0d:6e93 $11
      sSET_NPC_1_DIRECTION_DOWN                        ;; 0d:6e94 $15
      sNPC_1_STEP_BACKWARDS                            ;; 0d:6e95 $11
      sNPC_1_STEP_BACKWARDS                            ;; 0d:6e96 $11
      sSET_FLAG wScriptFlags04.0                       ;; 0d:6e97 $da $20
    sENDIF                                             ;; 0d:6e99
    sEND                                               ;; 0d:6e99 $00

script_0232:
    sMSG                                               ;; 0d:6e9a $04
      db "Sarah:He didn't\n wanna let you\n know, but_<12>"
      db "<1b> He has a broken\n back and cannot\n move for a while.<12>"
      db "<1b> He was distressed\n to hear of places\n being attacked.<12>"
      db "<1b> But he kept\n saying there is\n a ", $00
    sIF_FLAG wScriptFlags01.7
      sMSG
      db "woman_<12>"
      db "<1b> A woman", $00
    sENDIF
    sIF_FLAG wScriptFlags06.3
      sMSG
      db "boy_<12>"
      db "<1b> A boy", $00
    sENDIF
    sIF_FLAG !wScriptFlags01.7, !wScriptFlags06.3
      sMSG
      db "hero_<12>"
      db "<1b> A hero", $00
    sENDIF
    sMSG
      db " named\n <BOY> will come to\n save us all_<12>"
      db "<1b> I didn't really\n believe him, but\n when I saw you_<12>"
      db "<1b> _ Even a Chocobo\n knew you're the\n last hope_<12>"
      db "<1b> Bogard and the\n bird made me\n believe in you_<12>"
      db "<1b> We all believe\n that you'll save\n our world now.<12>"
      db "<1b> Chocobo is being\n treated at Doctor\n Bon Voyage's.<12>"
      db "<11>", $00 ;; 0d:6e9b
    sEND                                               ;; 0d:6feb $00

script_0233:
    sMSG                                               ;; 0d:6fec $04
      db "<10>This is Ish.<12>"
      db "<1b>The evil Vandole\nEmpire used to\nprosper here.<12>"
      db "<1b>But a Gemma Knight\ndefeated Vandole\nwith a sword.<12>"
      db "<1b>The ruins of\nVandole lie under\nthe desert sands.<12>"
      db "<11>", $00 ;; 0d:6fed
    sEND                                               ;; 0d:705c $00

script_0234:
    sMSG                                               ;; 0d:705d $04
      db "<10>Julius summoned\nevil monsters_", $00    ;; 0d:705e
    sDELAY 40                                          ;; 0d:7074 $f0 $28
    sMSG                                               ;; 0d:7076 $04
      db "\nIs it safe here?<12>"
      db "<11>", $00 ;; 0d:7077
    sEND                                               ;; 0d:7085 $00

script_0235:
    sMSG                                               ;; 0d:7086 $04
      db "<10>Vandole could\nbuild things on\ndesert sand.<12>"
      db "<1b>But their great\nDime Tower sank\nwhen Vandole fell_<12>"
      db "<11>", $00 ;; 0d:7087
    sEND                                               ;; 0d:70cf $00

script_0236:
    sMSG                                               ;; 0d:70d0 $04
      db "<10>Julius is the new\nKing of Granz.\nBut Julius is<12>"
      db "<1b>even crueler than\nShadow Knight was!\n_ What'll we do?<12>"
      db "<11>", $00 ;; 0d:70d1
    sEND                                               ;; 0d:711b $00

script_0237:
    sMSG                                               ;; 0d:711c $04
      db "<10>It's hard to walk\naround in Crystal\nDesert.<12>"
      db "<1b>Even for Chocobos!<12>"
      db "<11>", $00 ;; 0d:711d
    sEND                                               ;; 0d:714d $00

script_0238:
    sEND                                               ;; 0d:714e $00

script_0239:
    sEND                                               ;; 0d:714f $00

script_023a:
    sEND                                               ;; 0d:7150 $00

script_023b:
    sEND                                               ;; 0d:7151 $00

script_023c:
    sEND                                               ;; 0d:7152 $00

script_023d:
    sEND                                               ;; 0d:7153 $00

script_023e:
    sMSG                                               ;; 0d:7154 $04
      db "<10>THE TREE OF MANA\nGROWS WITH THE\nENERGY OF NATURE.<12>"
      db "<11>", $00 ;; 0d:7155
    sEND                                               ;; 0d:7183 $00

script_023f:
    sMSG                                               ;; 0d:7184 $04
      db "<10>THE EVIL FORCE\nOF PEOPLE MAKES\nTHE TREE EVIL.<12>"
      db "<11>", $00 ;; 0d:7185
    sEND                                               ;; 0d:71b1 $00

script_0240:
    sMSG                                               ;; 0d:71b2 $04
      db "<10>WATER FROM THE\nEVIL MANA TREE\nTURNS PEOPLE EVIL.<12>"
      db "<1b>IT IS A VICIOUS\nCIRCLE BETWEEN\nENERGY AND MANA.<12>"
      db "<11>", $00 ;; 0d:71b3
    sEND                                               ;; 0d:7210 $00

script_0241:
    sMSG                                               ;; 0d:7211 $04
      db "<10>ONE WHO TOUCHES\nTHE MANA TREE GETS\nTHE MIGHTY POWER.<12>"
      db "<11>", $00 ;; 0d:7212
    sEND                                               ;; 0d:7241 $00

script_0242:
    sMSG                                               ;; 0d:7242 $04
      db "<10>VANDOLE'S EMPEROR\nGOT THE MIGHTY\nPOWER OF MANA.<12>"
      db "<1b>THE ONLY ONE WHO\nCAN STAND AGAINST\nIS THE __<12>"
      db "<1b>GEMMA KNIGHT__\nWITH THE__\nMANA SWORD__<12>"
      db "<11>", $00 ;; 0d:7243
    sEND                                               ;; 0d:72ba $00

script_0243:
    sMSG                                               ;; 0d:72bb $04
      db "<10>GEMMA KNIGHT WITH\nTHE RUSTY SWORD\nWILL BE TESTED.<12>"
      db "<1b>THE TRUE GEMMA\nKNIGHT WILL\nBE GIVEN THE<12>"
      db "<1b>LEGENDARY MANA\nSWORD__!<12>"
      db "<11>", $00 ;; 0d:72bc
    sEND                                               ;; 0d:732e $00

script_0244:
    sMSG                                               ;; 0d:732f $04
      db "<10>FIGHT WITH THE 3\nDRAGONS IN THE\nSHRINE OF MANA.<12>"
      db "<11>", $00 ;; 0d:7330
    sEND                                               ;; 0d:735b $00

script_0245:
    sMSG                                               ;; 0d:735c $04
      db "<10>THE VANDOLE EMPIRE\nSOON MAY FALL.\n<12>"
      db "<1b>WE LEAVE OUR LAST\nHOPE IN THE CAVE\nAT THE WATERFALLS.<12>"
      db "<1b>GLORY TO VANDOLE\nAND TO OUR CHILD\nOF HOPE__!<12>"
      db "<11>", $00 ;; 0d:735d
    sEND                                               ;; 0d:73d6 $00

script_0246:
    sSFX 20                                            ;; 0d:73d7 $f9 $14
    sFLASH_SCREEN                                      ;; 0d:73d9 $bf
    sFLASH_SCREEN                                      ;; 0d:73da $bf
    sSFX 17                                            ;; 0d:73db $f9 $11
    sEND                                               ;; 0d:73dd $00

script_0247:
    sSFX 20                                            ;; 0d:73de $f9 $14
    sFLASH_SCREEN                                      ;; 0d:73e0 $bf
    sFLASH_SCREEN                                      ;; 0d:73e1 $bf
    sSFX 17                                            ;; 0d:73e2 $f9 $11
    sFLASH_SCREEN                                      ;; 0d:73e4 $bf
    sFLASH_SCREEN                                      ;; 0d:73e5 $bf
    sEND                                               ;; 0d:73e6 $00

script_0248:
    sSET_ROOM_TILE $51, 1, 3                           ;; 0d:73e7 $b0 $51 $01 $03
    sSET_ROOM_TILE $43, 1, 4                           ;; 0d:73eb $b0 $43 $01 $04
    sSET_ROOM_TILE $31, 1, 5                           ;; 0d:73ef $b0 $31 $01 $05
    sEND                                               ;; 0d:73f3 $00

script_0249:
; Fill tiles just outside the screen before the shake effect.
; Because you must scroll in only one side needs to be done.
    sSET_ROOM_TILE $50, 15, 0
    sSET_ROOM_TILE $50, 15, 1
    sSET_ROOM_TILE $50, 15, 2
    sSET_ROOM_TILE $51, 15, 3
    sSET_ROOM_TILE $00, 15, 4
    sSET_ROOM_TILE $00, 15, 5
    sSET_ROOM_TILE $00, 15, 6
    sSET_ROOM_TILE $11, 15, 7
    sFLASH_SCREEN                                      ;; 0d:73f4 $bf
    sSFX 37                                            ;; 0d:73f5 $f9 $25
    sFLASH_SCREEN                                      ;; 0d:73f7 $bf
    sSHAKE_SCREEN                                      ;; 0d:73f8 $fb
    sSET_PLAYER_POSITION 18, 8                         ;; 0d:73f9 $8a $12 $08
    sFOLLOWER_DIRECTION_LEFT                           ;; 0d:73fc $97
    sFOLLOWER_SET_POSITION 18, 8                       ;; 0d:73fd $99 $12 $08
    sSET_PLAYER_DIRECTION_LEFT                         ;; 0d:7400 $87
    sFLASH_SCREEN                                      ;; 0d:7401 $bf
    sSFX 20                                            ;; 0d:7402 $f9 $14
    sSET_ROOM_TILE $64, 7, 2                           ;; 0d:7404 $b0 $64 $07 $02
    sSET_ROOM_TILE $64, 7, 3                           ;; 0d:7408 $b0 $64 $07 $03
    sSET_ROOM_TILE $64, 7, 4                           ;; 0d:740c $b0 $64 $07 $04
    sSET_ROOM_TILE $32, 7, 5                           ;; 0d:7410 $b0 $32 $07 $05
    sSET_ROOM_TILE $51, 7, 6                           ;; 0d:7414 $b0 $51 $07 $06
    sSET_ROOM_TILE $43, 7, 7                           ;; 0d:7418 $b0 $43 $07 $07
; These parapet pieces are no longer shaded.
    sSET_ROOM_TILE $84, 8, 3
    sSET_ROOM_TILE $86, 8, 5
    sDELAY 5                                           ;; 0d:741c $f0 $05
    sFLASH_SCREEN                                      ;; 0d:741e $bf
    sSFX 20                                            ;; 0d:741f $f9 $14
    sSET_ROOM_TILE $64, 7, 5                           ;; 0d:7421 $b0 $64 $07 $05
    sSET_ROOM_TILE $64, 7, 6                           ;; 0d:7425 $b0 $64 $07 $06
    sSET_ROOM_TILE $64, 7, 7                           ;; 0d:7429 $b0 $64 $07 $07
    sPLAYER_STEP_FORWARD                               ;; 0d:742d $80
    sPLAYER_STEP_FORWARD                               ;; 0d:742e $80
    sDELAY 80                                          ;; 0d:742f $f0 $50
    sSET_PLAYER_DIRECTION_RIGHT                        ;; 0d:7431 $86
    sMSG                                               ;; 0d:7432 $04
      db "<10><BOY>:Oh__ No__\nMarcie:I THROW YOU\n __ AND I JUMP.<12>", $00
    sDELAY 50                                          ;; 0d:745d $f0 $32
    sMSG                                               ;; 0d:745f $04
      db "<1b><BOY>:Can you?\n Let's do that!<12>"
      db "<11>", $00 ;; 0d:7460
    sDELAY 60                                          ;; 0d:7476 $f0 $3c
    sSET_PLAYER_DIRECTION_LEFT                         ;; 0d:7478 $87
    sDELAY 50                                          ;; 0d:7479 $f0 $32
    sFOLLOWER_STEP_FORWARD                             ;; 0d:747b $90
    sDELAY 40                                          ;; 0d:747c $f0 $28
    sSFX 12                                            ;; 0d:747e $f9 $0c
    sPLAYER_JUMP 104                                   ;; 0d:7480 $8b $68
    sDELAY 40                                          ;; 0d:7482 $f0 $28
    sSET_PLAYER_DIRECTION_RIGHT                        ;; 0d:7484 $86
    sSFX 37                                            ;; 0d:7485 $f9 $25
    sSHAKE_SCREEN                                      ;; 0d:7487 $fb
    sMSG                                               ;; 0d:7488 $04
      db "<10><BOY>:Now!\n Come on, Marcie!", $00      ;; 0d:7489
    sSET_MUSIC 0                                       ;; 0d:749c $f8 $00
    sDELAY 80                                          ;; 0d:749e $f0 $50
    sMSG                                               ;; 0d:74a0 $04
      db "\nMarcie:__ __<12>"
      db "<1b>YOU HAVE TO SAVE\nTHE WORLD. YOU\nARE THE ONLY HOPE.", $00 ;; 0d:74a1
    sSET_MUSIC 2                                       ;; 0d:74d7 $f8 $02
    sMSG                                               ;; 0d:74d9 $04
      db "<12>"
      db "<1b><BOY>:What are you\n talking about?\n __ Come on!<12>"
      db "<1b>Marcie:_ I AM\n UNABLE TO JUMP__\n<BOY>:_ What_?!<12>"
      db "<1b>Marcie:I WAS MADE\n TO WORK IN HERE.\n AND I SLEEP HERE_<12>"
      db "<11>", $00 ;; 0d:74da
    sDELAY 40                                          ;; 0d:7551 $f0 $28
    sFLASH_SCREEN                                      ;; 0d:7553 $bf
    sSFX 37                                            ;; 0d:7554 $f9 $25
    sFLASH_SCREEN                                      ;; 0d:7556 $bf
    sSET_ROOM_TILE $64, 8, 3                           ;; 0d:7557 $b0 $64 $08 $03
    sSET_ROOM_TILE $64, 8, 4                           ;; 0d:755b $b0 $64 $08 $04
    sSET_ROOM_TILE $84, 8, 5
    sSET_ROOM_TILE $43, 8, 6                           ;; 0d:7563 $b0 $43 $08 $06
    sSET_ROOM_TILE $86, 8, 7
    sFOLLOWER_SET_POSITION 17, 12                      ;; 0d:756b $99 $11 $0c
    sSET_ROOM_TILE $64, 9, 2                           ;; 0d:756e $b0 $64 $09 $02
    sSET_ROOM_TILE $64, 9, 3                           ;; 0d:7572 $b0 $64 $09 $03
    sSET_ROOM_TILE $32, 9, 4                           ;; 0d:7576 $b0 $32 $09 $04
    sSET_ROOM_TILE $51, 9, 5                           ;; 0d:757a $b0 $51 $09 $05
    sSET_ROOM_TILE $43, 9, 6                           ;; 0d:757e $b0 $43 $09 $06
    sSET_ROOM_TILE $30, 9, 7                           ;; 0d:7582 $b0 $30 $09 $07
    sDELAY 5                                           ;; 0d:7586 $f0 $05
    sFLASH_SCREEN                                      ;; 0d:7588 $bf
    sSFX 37                                            ;; 0d:7589 $f9 $25
    sFLASH_SCREEN                                      ;; 0d:758b $bf
    sSET_ROOM_TILE $64, 8, 5                           ;; 0d:758c $b0 $64 $08 $05
    sSET_ROOM_TILE $64, 8, 6                           ;; 0d:7590 $b0 $64 $08 $06
    sSET_ROOM_TILE $84, 8, 7
    sFOLLOWER_DELETE                                   ;; 0d:7598 $98
    sSET_ROOM_TILE $64, 9, 4                           ;; 0d:7599 $b0 $64 $09 $04
    sSET_ROOM_TILE $64, 9, 5                           ;; 0d:759d $b0 $64 $09 $05
    sSET_ROOM_TILE $32, 9, 6                           ;; 0d:75a1 $b0 $32 $09 $06
    sSET_ROOM_TILE $51, 9, 7                           ;; 0d:75a5 $b0 $51 $09 $07
    sDELAY 5                                           ;; 0d:75a9 $f0 $05
    sFLASH_SCREEN                                      ;; 0d:75ab $bf
    sSFX 37                                            ;; 0d:75ac $f9 $25
    sFLASH_SCREEN                                      ;; 0d:75ae $bf
    sSET_ROOM_TILE $64, 8, 7                           ;; 0d:75af $b0 $64 $08 $07
    sSET_ROOM_TILE $64, 9, 6                           ;; 0d:75b3 $b0 $64 $09 $06
    sSET_ROOM_TILE $64, 9, 7                           ;; 0d:75b7 $b0 $64 $09 $07
; Fill tiles just outside the screen before the shake effect.
; Only the area where the bridge was needs to be changed.
    sSET_ROOM_TILE $64, 10, 3
    sSET_ROOM_TILE $64, 10, 4
    sSET_ROOM_TILE $64, 10, 5
    sSET_ROOM_TILE $64, 10, 6
    sSFX 37                                            ;; 0d:75bb $f9 $25
    sSHAKE_SCREEN                                      ;; 0d:75bd $fb
    sFLASH_SCREEN                                      ;; 0d:75be $bf
    sFLASH_SCREEN                                      ;; 0d:75bf $bf
    sSFX 17                                            ;; 0d:75c0 $f9 $11
    sDELAY 140                                         ;; 0d:75c2 $f0 $8c
    sMSG                                               ;; 0d:75c4 $04
      db "<10><BOY>:__ Marcie!<12>"
      db "<11>", $00 ;; 0d:75c5
    sFADE_TO_BLACK                                     ;; 0d:75d1 $bd
    sLOAD_ROOM_INSTANT 15, $55, 20, 0                  ;; 0d:75d2 $f3 $0f $55 $14 $00
    sFADE_TO_NORMAL                                    ;; 0d:75d7 $bc
    sDELAY 20                                          ;; 0d:75d8 $f0 $14
    sMSG                                               ;; 0d:75da $04
      db "<10>Marcie:SEE YOU\n SOMETIME,", $00         ;; 0d:75db
    sDELAY 40                                          ;; 0d:75f3 $f0 $28
    sMSG                                               ;; 0d:75f5 $04
      db " KID__<12>"
      db "<11>", $00             ;; 0d:75f6
    sFADE_TO_BLACK                                     ;; 0d:75fe $bd
    sLOAD_ROOM_INSTANT 1, $56, 12, 8                   ;; 0d:75ff $f3 $01 $56 $0e $06
    sCLEAR_ROOM_HISTORY                                ;; 0d:7604 $ab
    sDELAY 60                                          ;; 0d:7605 $f0 $3c
    sFADE_TO_NORMAL                                    ;; 0d:7607 $bc
    sDELAY 60                                          ;; 0d:7608 $f0 $3c
    sCLEAR_FLAG wScriptFlags0A.7                       ;; 0d:760a $db $57
    sEND                                               ;; 0d:760c $00

script_024a:
    sEND                                               ;; 0d:760d $00

script_024b:
    sEND                                               ;; 0d:760e $00

script_024c:
    sEND                                               ;; 0d:760f $00

script_024d:
    sEND                                               ;; 0d:7610 $00

script_024e:
    sEND                                               ;; 0d:7611 $00

script_024f:
    sLOOP 8, 4                                         ;; 0d:7612 $03 $08 $04
      sSFX 20                                          ;; 0d:7615 $f9 $14
      sFLASH_SCREEN                                    ;; 0d:7617 $bf
    sEND                                               ;; 0d:7618 $00
    sEND                                               ;; 0d:7619 $00

script_0250:
    sMSG                                               ;; 0d:761a $04
      db "<10>", $00                                   ;; 0d:761b
    sIF_FLAG !wScriptFlags05.5                         ;; 0d:761d $08 $ad $00 $8b
      sMSG                                             ;; 0d:7621 $04
        db "King of Lorimar:\n Julius summoned \n monsters. One of<12>"
        db "<1b> them called Kary\n now dwells in\n the Snowfields_<12>"
        db "<1b> Kary has sent icy\n mountain winds to\n freeze us all.<12>"
        db "<1b> Cibba came to\n help us, but he's\n trapped by ice.<12>"
        db "<1b> If you don't stop\n Kary soon I fear\n the worst_", $00

    sELSE                                              ;; 0d:76aa $01 $24
      sMSG                                             ;; 0d:76ac $04
        db "Thank you so much.\nCibba is waiting\nin the other room.", $00 ;; 0d:76ad
    sENDIF                                             ;; 0d:76d0
    sMSG                                               ;; 0d:76d0 $04
      db "<12>"
      db "<11>", $00                   ;; 0d:76d1
    sEND                                               ;; 0d:76d4 $00

script_0251:
    sMSG                                               ;; 0d:76d5 $04
      db "<10>__ Frozen.<12>"
      db "<11>", $00     ;; 0d:76d6
    sEND                                               ;; 0d:76e1 $00

script_0252:
    sMSG                                               ;; 0d:76e2 $04
      db "<10>Wow!\nGood morning!<12>"
      db "<11>", $00 ;; 0d:76e3
    sEND                                               ;; 0d:76f4 $00

script_0253:
    sMSG                                               ;; 0d:76f5 $04
      db "<10>Welcome to\nLorimar!<12>"
      db "<11>", $00 ;; 0d:76f6
    sEND                                               ;; 0d:7706 $00

script_0254:
    sEND                                               ;; 0d:7707 $00

script_0255:
    sEND                                               ;; 0d:7708 $00

script_0256:
    sIF_FLAG wScriptFlags01.3, !wScriptFlags02.1       ;; 0d:7709 $08 $0b $91 $00 $03
      sCALL script_01e7                                ;; 0d:770e $02 $17 $98
    sENDIF                                             ;; 0d:7711
    sIF_FLAG wScriptFlags01.1, !wScriptFlags01.3       ;; 0d:7711 $08 $09 $8b $00 $03
      sCALL script_026c                                ;; 0d:7716 $02 $3a $70
    sENDIF                                             ;; 0d:7719
    sIF_FLAG !wScriptFlags01.1                         ;; 0d:7719 $08 $89 $00 $03
      sCALL script_0264                                ;; 0d:771d $02 $38 $f9
    sENDIF                                             ;; 0d:7720
    sEND                                               ;; 0d:7720 $00

script_0257:
    sIF_FLAG wScriptFlags03.6
      sCALL script_022c                                ;; 0d:7725 $02 $2c $a5
    sENDIF                                             ;; 0d:7728
    sIF_FLAG wScriptFlags04.6, !wScriptFlags03.6
      sCALL script_022d                                ;; 0d:772d $02 $2c $e6
    sENDIF                                             ;; 0d:7730
    sIF_FLAG wScriptFlags01.4, !wScriptFlags04.6       ;; 0d:7730 $08 $0c $a6 $00 $03
      sCALL script_022b                                ;; 0d:7735 $02 $2c $14
    sENDIF                                             ;; 0d:7738
    sIF_FLAG !wScriptFlags01.4                         ;; 0d:7738 $08 $8c $00 $03
      sCALL script_0229                                ;; 0d:773c $02 $2a $48
    sENDIF                                             ;; 0d:773f
    sEND                                               ;; 0d:773f $00

script_0258:
    sIF_FLAG wScriptFlags04.6                          ;; 0d:7740 $08 $26 $00 $03
      sCALL script_020f                                ;; 0d:7744 $02 $21 $9f
    sENDIF                                             ;; 0d:7747
    sIF_FLAG !wScriptFlags01.3                         ;; 0d:7747 $08 $8b $00 $03
      sCALL script_026b                                ;; 0d:774b $02 $3a $53
    sENDIF                                             ;; 0d:774e
    sEND                                               ;; 0d:774e $00

script_0259:
    sIF_FLAG wScriptFlags04.5, !wScriptFlags02.0       ;; 0d:774f $08 $25 $90 $00 $03
      sCALL script_01e8                                ;; 0d:7754 $02 $17 $b7
    sENDIF                                             ;; 0d:7757
    sIF_FLAG !wScriptFlags04.3                         ;; 0d:7757 $08 $a3 $00 $03
      sCALL script_01e4                                ;; 0d:775b $02 $16 $e8
    sENDIF                                             ;; 0d:775e
    sEND                                               ;; 0d:775e $00

script_025a:
    sIF_FLAG wScriptFlags03.7                          ;; 0d:775f $08 $1f $00 $03
      sCALL script_01ef                                ;; 0d:7763 $02 $19 $2a
    sENDIF                                             ;; 0d:7766
    sIF_FLAG !wScriptFlags03.7                         ;; 0d:7766 $08 $9f $00 $03
      sCALL script_01ee                                ;; 0d:776a $02 $18 $eb
    sENDIF                                             ;; 0d:776d
    sEND                                               ;; 0d:776d $00

script_025b:
    sEND                                               ;; 0d:776e $00

script_025c:
    sEND                                               ;; 0d:776f $00

script_025d:
    sIF_FLAG !wScriptFlags0E.4                         ;; 0d:7770 $08 $f4 $00 $04
      sOPEN_SHOP 3                                     ;; 0d:7774 $f6 $03
    sELSE                                              ;; 0d:7776 $01 $14
      sIF_FLAG !wScriptFlags0E.6, !wScriptFlags0E.7    ;; 0d:7778 $08 $f6 $f7 $00 $02
        sOPEN_SHOP 14                                  ;; 0d:777d $f6 $0e
      sENDIF                                           ;; 0d:777f
      sIF_FLAG !wScriptFlags0E.6, wScriptFlags0E.7     ;; 0d:777f $08 $f6 $77 $00 $02
        sOPEN_SHOP 15                                  ;; 0d:7784 $f6 $0f
      sENDIF                                           ;; 0d:7786
      sIF_FLAG wScriptFlags0E.6                        ;; 0d:7786 $08 $76 $00 $02
        sOPEN_SHOP 16                                  ;; 0d:778a $f6 $10
      sENDIF                                           ;; 0d:778c
    sENDIF                                             ;; 0d:778c
    sEND                                               ;; 0d:778c $00

script_025e:
    sSET_NPC_1_DIRECTION_DOWN                          ;; 0d:778d $15
    sIF_FLAG !wScriptFlags0E.4                         ;; 0d:778e $08 $f4 $00 $42
      sIF_FLAG !wScriptFlags0E.5, !wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:7792 $08 $f5 $f6 $f7 $00 $02
        sOPEN_SHOP 4                                   ;; 0d:7798 $f6 $04
      sENDIF                                           ;; 0d:779a
      sIF_FLAG !wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:779a $08 $f5 $f6 $77 $00 $02
        sOPEN_SHOP 5                                   ;; 0d:77a0 $f6 $05
      sENDIF                                           ;; 0d:77a2
      sIF_FLAG !wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:77a2 $08 $f5 $76 $f7 $00 $02
        sOPEN_SHOP 7                                   ;; 0d:77a8 $f6 $07
      sENDIF                                           ;; 0d:77aa
      sIF_FLAG !wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:77aa $08 $f5 $76 $77 $00 $02
        sOPEN_SHOP 8                                   ;; 0d:77b0 $f6 $08
      sENDIF                                           ;; 0d:77b2
      sIF_FLAG wScriptFlags0E.5, !wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:77b2 $08 $75 $f6 $f7 $00 $02
        sOPEN_SHOP 9                                   ;; 0d:77b8 $f6 $09
      sENDIF                                           ;; 0d:77ba
      sIF_FLAG wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:77ba $08 $75 $f6 $77 $00 $02
        sOPEN_SHOP 10                                  ;; 0d:77c0 $f6 $0a
      sENDIF                                           ;; 0d:77c2
      sIF_FLAG wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:77c2 $08 $75 $76 $f7 $00 $02
        sOPEN_SHOP 11                                  ;; 0d:77c8 $f6 $0b
      sENDIF                                           ;; 0d:77ca
      sIF_FLAG wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7 ;; 0d:77ca $08 $75 $76 $77 $00 $02
        sOPEN_SHOP 12                                  ;; 0d:77d0 $f6 $0c
      sENDIF                                           ;; 0d:77d2
    sELSE                                              ;; 0d:77d2 $01 $08
      sIF_FLAG !wScriptFlags0E.5, !wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0d:77d4 $08 $f5 $f6 $f7 $00 $02
        sOPEN_SHOP 13                                  ;; 0d:77da $f6 $0d
      sENDIF                                           ;; 0d:77dc
    sENDIF                                             ;; 0d:77dc
    sEND                                               ;; 0d:77dc $00

script_025f:
    sSET_NPC_1_DIRECTION_DOWN                          ;; 0d:77dd $15
    sMSG                                               ;; 0d:77de $04
      db "<10> Howdy!\n 10 lucre a night!\n Wanna stay?<12>"
      db "<13>", $00 ;; 0d:77df
    sIF_FLAG !wScriptFlags0F.7                         ;; 0d:77fc $08 $ff $00 $21
      sTAKE_MONEY 10                                   ;; 0d:7800 $d1 $0a $00
      sIF_FLAG wScriptFlags.6                          ;; 0d:7803 $08 $06 $00 $17
        sMSG                                           ;; 0d:7807 $04
          db "<1b> Sorry.\n Not enough lucre!<12>"
          db "<11>", $00 ;; 0d:7808
      sELSE                                            ;; 0d:781c $01 $03
        sSET_MUSIC 0
        sMSG
          db "<1b> Good night!<12>"
          db "<11><00>"
        sFADE_TO_BLACK
        sDELAY 10
        sSET_MUSIC 17
        sFULL_HP
        sFULL_MANA
        sSET_PLAYER_DIRECTION_DOWN
        sDELAY 110
        sCALL script_0405
        sFADE_TO_NORMAL
        sCLEAR_ROOM_HISTORY
        sRUN_ROOM_SCRIPT
      sENDIF                                           ;; 0d:7821
    sELSE
      sMSG
        db "<11><00>"
    sENDIF                                             ;; 0d:7821
    sEND                                               ;; 0d:7824 $00

script_0260:
    sSET_NPC_1_DIRECTION_DOWN                          ;; 0d:7825 $15
    sIF_FLAG wScriptFlags0E.4                          ;; 0d:7826 $08 $74 $00 $04
      sOPEN_SHOP 3                                     ;; 0d:782a $f6 $03
    sELSE                                              ;; 0d:782c $01 $7b
      sIF_FLAG wScriptFlags0E.5                        ;; 0d:782e $08 $75 $00 $04
        sOPEN_SHOP 3                                   ;; 0d:7832 $f6 $03
      sELSE                                            ;; 0d:7834 $01 $73
        sIF_FLAG !wScriptFlags0E.6, !wScriptFlags0E.7  ;; 0d:7836 $08 $f6 $f7 $00 $0a
          sIF_FLAG !wScriptFlags01.4                   ;; 0d:783b $08 $8c $00 $04
            sOPEN_SHOP 0                               ;; 0d:783f $f6 $00
          sELSE                                        ;; 0d:7841 $01 $02
            sOPEN_SHOP 1                               ;; 0d:7843 $f6 $01
          sENDIF                                       ;; 0d:7845
        sENDIF                                         ;; 0d:7845
        sIF_FLAG !wScriptFlags0E.6, wScriptFlags0E.7   ;; 0d:7845 $08 $f6 $77 $00 $25
          sIF_INVENTORY INV_AXE_BATTLE                 ;; 0d:784a $0a $43 $00 $02
          sELSE                                        ;; 0d:784e $01 $03
            sCALL script_0549                          ;; 0d:7850 $02 $7a $c2
          sENDIF                                       ;; 0d:7853
          sOPEN_SHOP 1                                 ;; 0d:7853 $f6 $01
          sMSG                                         ;; 0d:7855 $04
            db "<10>It's swampy ahead.\nBe careful!<12>"
            db "<11>", $00 ;; 0d:7856
        sENDIF                                         ;; 0d:786f
        sIF_FLAG wScriptFlags0E.6, !wScriptFlags0E.7   ;; 0d:786f $08 $76 $f7 $00 $02
          sOPEN_SHOP 1                                 ;; 0d:7874 $f6 $01
        sENDIF                                         ;; 0d:7876
        sIF_FLAG wScriptFlags0E.6, wScriptFlags0E.7    ;; 0d:7876 $08 $76 $77 $00 $2e
          sIF_FLAG wScriptFlags02.1                    ;; 0d:787b $08 $11 $00 $04
            sOPEN_SHOP 2                               ;; 0d:787f $f6 $02
          sELSE                                        ;; 0d:7881 $01 $26
            sMSG                                       ;; 0d:7883 $04
              db "<10>Excuse me_", $00                 ;; 0d:7884
            sDELAY 30                                  ;; 0d:788e $f0 $1e
            sMSG                                       ;; 0d:7890 $04
              db "\n_ Hello_", $00                     ;; 0d:7891
            sDELAY 50                                  ;; 0d:7899 $f0 $32
            sMSG                                       ;; 0d:789b $04
              db "\n_ No answer.<12>"
              db "<11>", $00 ;; 0d:789c
          sENDIF                                       ;; 0d:78a9
        sENDIF                                         ;; 0d:78a9
      sENDIF                                           ;; 0d:78a9
    sENDIF                                             ;; 0d:78a9
    sEND                                               ;; 0d:78a9 $00

script_0261:
    sMSG                                               ;; 0d:78aa $04
      db "<10>", $00
    sCALL script_0433
    sMSG
      db ":I'm sorry\n about Willy, but\n if we don't get<12>"
      db "<1b> out of here soon\n then we'll all\n be joining him.<12>"
      db "<1b> I left my brother\n all alone. I want\n to see him again.<12>"
      db "<11>", $00 ;; 0d:78ab
    sEND                                               ;; 0d:78f6 $00

script_0262:
    sEND                                               ;; 0d:78f7 $00

script_0263:
    sEND                                               ;; 0d:78f8 $00

script_0264:
    sMSG                                               ;; 0d:78f9 $04
      db "<10><BOY>:Willy__\n I'll avenge you!<12>"
      db "<11>", $00 ;; 0d:78fa
    sEND                                               ;; 0d:7910 $00

script_0265:
    sMSG                                               ;; 0d:7911 $04
      db "<10>The entrance the\nmonsters use leads\noutside.<12>"
      db "<1b>Take your chance!<12>"
      db "<11>", $00 ;; 0d:7912
    sEND                                               ;; 0d:7941 $00

script_0266:
    sMSG                                               ;; 0d:7942 $04
      db "<10>Welcome to Topple!<12>"
      db "<11>", $00 ;; 0d:7943
    sEND                                               ;; 0d:795f $00

script_0267:
    sMSG                                               ;; 0d:7960 $04
      db "<10>Shadow Knight is \nso cruel! I can't\nstand it anymore!<12>"
      db "<11>", $00 ;; 0d:7961
    sEND                                               ;; 0d:7987 $00

script_0268:
    sMSG                                               ;; 0d:7988 $04
      db "<10>Shadow Knight\nis searching for\nsomeone_<12>"
      db "<1b>Someone who knows\nthe secret of the\nMana Tree.<12>"
      db "<11>", $00 ;; 0d:7989
    sEND                                               ;; 0d:79cb $00

script_0269:
    sMSG                                               ;; 0d:79cc $04
      db "<10>The old man by\nthe Waterfalls is\nsuch a weirdo!<12>"
      db "<1b>He used to be a\ngallant knight,\nbut not anymore!<12>"
      db "<11>", $00 ;; 0d:79cd
    sEND                                               ;; 0d:7a11 $00

script_026a:
    sMSG                                               ;; 0d:7a12 $04
      db "<10>The Mana Tree is\nwatching us from\nabove the clouds.<12>"
      db "<1b>It's protecting us\nfrom evil things.<12>"
      db "<11>", $00 ;; 0d:7a13
    sEND                                               ;; 0d:7a52 $00

script_026b:
    sMSG                                               ;; 0d:7a53 $04
      db "<10> Hasim's got a\n serious wound!<12>"
      db "<11>", $00 ;; 0d:7a54
    sEND                                               ;; 0d:7a6f $00

script_026c:
    sIF_FLAG wScriptFlags01.2                          ;; 0d:7a70 $08 $0a $00 $a2
      sMSG                                             ;; 0d:7a74 $04
        db "<10>", $00                                 ;; 0d:7a75
      sDELAY 10                                        ;; 0d:7a77 $f0 $0a
      sSET_MUSIC 23                                    ;; 0d:7a79 $f8 $17
      sCALL script_026d                                ;; 0d:7a7b $02 $3b $17
      sMSG                                             ;; 0d:7a7e $04
        db "<GIRL>:Oh_ No_\n Don't leave me\n alone, Hasim!<12>"
        db "<1b><BOY>:I'm looking\n for that Bogard,\n too.<12>"
        db "<1b> Why don't you\n come with me?\n<GIRL>:Oh _ Can I?<12>"
        db "<1b><BOY>:I can't leave\n you here alone.\n _ I am <BOY>.<12>"
        db "<1b><GIRL>:Call me <GIRL>.<12>"
        db "<1b>", $00 ;; 0d:7a7f
      sSET_MUSIC 0                                     ;; 0d:7b09 $f8 $00
      sGIVE_FOLLOWER 1                                 ;; 0d:7b0b $9c $01
      sMSG                                             ;; 0d:7b0d $04
        db "<11>", $00                                 ;; 0d:7b0e
      sSET_FLAG wScriptFlags01.3                       ;; 0d:7b10 $da $0b
      sSET_FLAG wScriptFlags0A.1                       ;; 0d:7b12 $da $51
      sSET_MUSIC 20                                    ;; 0d:7b14 $f8 $14
    sENDIF                                             ;; 0d:7b16
    sEND                                               ;; 0d:7b16 $00

script_026d:
    sMSG                                               ;; 0d:7b17 $04
      db "Hasim:Oh_ please_\n take <GIRL> to_\n Wendel_ and if_<12>"
      db "<1b>", $00 ;; 0d:7b18
    sSET_NPC_1_DIRECTION_LEFT                          ;; 0d:7b3f $17
    sMSG                                               ;; 0d:7b40 $04
      db " you find Bogard__\n I'm sure he\n will help you_ _<12>"
      db "<1b><GIRL>:_ _ Hasim!?\n _ _ H A S I M!!<12>"
      db "<1b>", $00 ;; 0d:7b41
    sDELAY 30                                          ;; 0d:7b7f $f0 $1e
    sMSG                                               ;; 0d:7b81 $04
      db "\nHasim passed away.<12>"
      db "<1b>", $00 ;; 0d:7b82
    sEND                                               ;; 0d:7b92 $00

script_0270:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0d:7b93 $0b $c9 $00 $21
      sIF_EQUIPED INV_ITEM_BONE_KEY                    ;; 0d:7b97 $09 $20 $00 $12
        sIF_FLAG wScriptFlags0B.0                      ;; 0d:7b9b $08 $58 $00 $05
          sCALL script_0473                            ;; 0d:7b9f $02 $5a $e2
          sSET_FLAG wScriptFlags0D.2                   ;; 0d:7ba2 $da $6a
        sENDIF                                         ;; 0d:7ba4
        sLOAD_ROOM 11, $07, 16, 12                     ;; 0d:7ba4 $f4 $0b $07 $10 $0c
        sSET_MUSIC 7                                   ;; 0d:7ba9 $f8 $07
      sELSE                                            ;; 0d:7bab $01 $0b
        sMSG                                           ;; 0d:7bad $04
          db "<10> Locked.<12>"
          db "<11>", $00 ;; 0d:7bae
      sENDIF                                           ;; 0d:7bb8
    sENDIF                                             ;; 0d:7bb8
    sEND                                               ;; 0d:7bb8 $00

script_0271:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0d:7bb9 $0b $c9 $00 $13
      sIF_FLAG wScriptFlags0B.0                        ;; 0d:7bbd $08 $58 $00 $05
        sCALL script_0473                              ;; 0d:7bc1 $02 $5a $e2
        sSET_FLAG wScriptFlags0C.0                     ;; 0d:7bc4 $da $60
      sENDIF                                           ;; 0d:7bc6
      sLOAD_ROOM 14, $01, 14, 12                       ;; 0d:7bc6 $f4 $0e $01 $0e $0c
      sDELAY 20                                        ;; 0d:7bcb $f0 $14
      sSET_MUSIC 4                                     ;; 0d:7bcd $f8 $04
      sRUN_ROOM_SCRIPT                                 ;; 0d:7bcf $ec
    sENDIF                                             ;; 0d:7bd0
    sEND                                               ;; 0d:7bd0 $00

script_0272:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0d:7bd1 $0b $c9 $00 $1b
      sLOAD_ROOM 6, $32, 9, 12                         ;; 0d:7bd5 $f4 $06 $32 $09 $0c
      sSET_MUSIC 4                                     ;; 0d:7bda $f8 $04
      sUNK_C5 2                                        ;; 0d:7bdc $c5 $02
      sIF_FLAG !wScriptFlags04.6                       ;; 0d:7bde $08 $a6 $00 $06
        sCLEAR_FLAG wScriptFlags0F.0                   ;; 0d:7be2 $db $78
        sCLEAR_FLAG wScriptFlags0F.1                   ;; 0d:7be4 $db $79
        sCLEAR_FLAG wScriptFlags0F.2                   ;; 0d:7be6 $db $7a
      sENDIF                                           ;; 0d:7be8
      sIF_FLAG wScriptFlags01.4                        ;; 0d:7be8 $08 $0c $00 $03
        sSFX 16                                        ;; 0d:7bec $f9 $10
        sOPEN_NORTH_DOOR                               ;; 0d:7bee $e0
      sENDIF                                           ;; 0d:7bef
      sRUN_ROOM_SCRIPT                                 ;; 0d:7bef $ec
    sENDIF                                             ;; 0d:7bf0
    sEND                                               ;; 0d:7bf0 $00

script_0273:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0d:7bf1 $0b $c9 $c1 $00 $0d
      sSFX 12                                          ;; 0d:7bf6 $f9 $0c
      sSET_PLAYER_POSITION 20, 0                       ;; 0d:7bf8 $8a $14 $00
      sDELAY 60                                        ;; 0d:7bfb $f0 $3c
      sLOAD_ROOM 3, $11, 9, 7                          ;; 0d:7bfd $f4 $03 $11 $09 $07
      sRUN_ROOM_SCRIPT                                 ;; 0d:7c02 $ec
    sENDIF                                             ;; 0d:7c03
    sEND                                               ;; 0d:7c03 $00

script_0274:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0d:7c04 $0b $c9 $c1 $00 $0d
      sSFX 12                                          ;; 0d:7c09 $f9 $0c
      sSET_PLAYER_POSITION 20, 0                       ;; 0d:7c0b $8a $14 $00
      sDELAY 60                                        ;; 0d:7c0e $f0 $3c
      sLOAD_ROOM 6, $07, 9, 7                          ;; 0d:7c10 $f4 $06 $07 $09 $07
      sRUN_ROOM_SCRIPT                                 ;; 0d:7c15 $ec
    sENDIF                                             ;; 0d:7c16
    sEND                                               ;; 0d:7c16 $00

; Start of the second script bank.
SECTION "script bank 2", ROMX[$4000], BANK[SCRIPT_BANK_1 + 1]

script_0275:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0d:7c17 $0b $c9 $00 $29
      sIF_EQUIPED INV_ITEM_BRONZE_KEY                  ;; 0d:7c1b $09 $21 $00 $1a
        sTAKE_EQUIPED_ITEM
        sSET_FLAG wScriptFlags09.0
      sENDIF
      sIF_FLAG !wScriptFlags09.0, !wScriptFlags04.3
        sMSG
          db "<10> Locked.<12>"
          db "<11>", $00
      sELSE
        sIF_FLAG wScriptFlags0B.0                      ;; 0d:7c1f $08 $58 $00 $05
          sCALL script_0473                            ;; 0d:7c23 $02 $5a $e2
          sSET_FLAG wScriptFlags0C.2                   ;; 0d:7c26 $da $62
        sENDIF                                         ;; 0d:7c28
        sLOAD_ROOM 9, $31, 16, 2                       ;; 0d:7c28 $f4 $09 $31 $10 $02
        sCALL script_0190
        sSET_MUSIC 7                                   ;; 0d:7c35 $f8 $07
      sENDIF                                           ;; 0d:7c44
    sENDIF                                             ;; 0d:7c44
    sEND                                               ;; 0d:7c44 $00

script_0276:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0d:7c45 $0b $c9 $00 $13
      sIF_FLAG wScriptFlags0B.0                        ;; 0d:7c49 $08 $58 $00 $05
        sCALL script_0473                              ;; 0d:7c4d $02 $5a $e2
        sSET_FLAG wScriptFlags0C.1                     ;; 0d:7c50 $da $61
      sENDIF                                           ;; 0d:7c52
      sUNK_C5 0                                        ;; 0d:7c52 $c5 $00
      sLOAD_ROOM 3, $41, 9, 12                         ;; 0d:7c54 $f4 $03 $41 $09 $0c
      sSET_MUSIC 7                                     ;; 0d:7c59 $f8 $07
      sRUN_ROOM_SCRIPT                                 ;; 0d:7c5b $ec
    sENDIF                                             ;; 0d:7c5c
    sEND                                               ;; 0d:7c5c $00

script_0277:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0d:7c5d $0b $c9 $00 $11
      sIF_FLAG wScriptFlags0B.0                        ;; 0d:7c61 $08 $58 $00 $05
        sCALL script_0473                              ;; 0d:7c65 $02 $5a $e2
        sSET_FLAG wScriptFlags0C.3                     ;; 0d:7c68 $da $63
      sENDIF                                           ;; 0d:7c6a
      sLOAD_ROOM 14, $17, 11, 12                       ;; 0d:7c6a $f4 $0e $17 $0b $0c
      sSET_MUSIC 11                                    ;; 0d:7c6f $f8 $0b
      sRUN_ROOM_SCRIPT                                 ;; 0d:7c71 $ec
    sENDIF                                             ;; 0d:7c72
    sEND                                               ;; 0d:7c72 $00

script_0278:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0d:7c73 $0b $c9 $00 $11
      sIF_FLAG wScriptFlags0B.0                        ;; 0d:7c77 $08 $58 $00 $05
        sCALL script_0473                              ;; 0d:7c7b $02 $5a $e2
        sSET_FLAG wScriptFlags0C.5                     ;; 0d:7c7e $da $65
      sENDIF                                           ;; 0d:7c80
      sLOAD_ROOM 10, $66, 16, 2                        ;; 0d:7c80 $f4 $0a $66 $10 $02
      sSET_MUSIC 24                                    ;; 0d:7c85 $f8 $18
      sRUN_ROOM_SCRIPT                                 ;; 0d:7c87 $ec
    sENDIF                                             ;; 0d:7c88
    sEND                                               ;; 0d:7c88 $00

script_0279:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0d:7c89 $0b $c9 $00 $39
      sIF_FLAG wScriptFlags0B.0                        ;; 0d:7c8d $08 $58 $00 $05
        sCALL script_0473                              ;; 0d:7c91 $02 $5a $e2
        sSET_FLAG wScriptFlags0C.4                     ;; 0d:7c94 $da $64
      sENDIF                                           ;; 0d:7c96
      sIF_FLAG wScriptFlags0A.4                        ;; 0d:7c96 $08 $54 $00 $24
        sMSG                                           ;; 0d:7c9a $04
          db "<10>Bogard:Hey! Where\n do you think you\n are going??<12>"
          db "<11>", $00 ;; 0d:7c9b
      sELSE                                            ;; 0d:7cbc $01 $08
        sLOAD_ROOM 10, $55, 16, 2                      ;; 0d:7cbe $f4 $0a $55 $10 $02
        sSET_MUSIC 7                                   ;; 0d:7cc3 $f8 $07
        sRUN_ROOM_SCRIPT                               ;; 0d:7cc5 $ec
      sENDIF                                           ;; 0d:7cc6
    sENDIF                                             ;; 0d:7cc6
    sEND                                               ;; 0d:7cc6 $00

script_027a:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0d:7cc7 $0b $c9 $00 $7c
      sIF_EQUIPED INV_SWORD_SILVER                     ;; 0d:7ccb $09 $46 $00 $09
        sLOAD_ROOM 10, $13, 16, 12                     ;; 0d:7ccf $f4 $0a $13 $10 $0c
        sSET_MUSIC 7                                   ;; 0d:7cd4 $f8 $07
      sELSE                                            ;; 0d:7cd6 $01 $6f
        sIF_EQUIPED INV_ARMOR_SILVER                   ;; 0d:7cd8 $09 $54 $00 $09
          sLOAD_ROOM 10, $13, 16, 12                   ;; 0d:7cdc $f4 $0a $13 $10 $0c
          sSET_MUSIC 7                                 ;; 0d:7ce1 $f8 $07
        sELSE                                          ;; 0d:7ce3 $01 $62
          sIF_EQUIPED INV_SHIELD_SILVER                ;; 0d:7ce5 $09 $5f $00 $09
            sLOAD_ROOM 10, $13, 16, 12                 ;; 0d:7ce9 $f4 $0a $13 $10 $0c
            sSET_MUSIC 7                               ;; 0d:7cee $f8 $07
          sELSE                                        ;; 0d:7cf0 $01 $55
            sIF_EQUIPED INV_HELM_SILVER                ;; 0d:7cf2 $09 $6a $00 $09
              sLOAD_ROOM 10, $13, 16, 12               ;; 0d:7cf6 $f4 $0a $13 $10 $0c
              sSET_MUSIC 7                             ;; 0d:7cfb $f8 $07
            sELSE                                      ;; 0d:7cfd $01 $48
              sMSG                                     ;; 0d:7cff $04
                db "<10>Gaia:Whaaaa_", $00             ;; 0d:7d00
              sDELAY 40                                ;; 0d:7d0c $f0 $28
              sMSG                                     ;; 0d:7d0e $04
                db "\n Doooon't walk in\n my moooouth_<12>"
                db "<1b>\n Ooooo ", $00 ;; 0d:7d0f
              sDELAY 40                                ;; 0d:7d2e $f0 $28
              sMSG                                     ;; 0d:7d30 $04
                db "  Yuck!!", $00                     ;; 0d:7d31
              sDELAY 60                                ;; 0d:7d38 $f0 $3c
              sMSG                                     ;; 0d:7d3a $04
                db "<11>", $00                         ;; 0d:7d3b
              sSFX 12                                  ;; 0d:7d3d $f9 $0c
              sSET_PLAYER_POSITION 12, 3               ;; 0d:7d3f $8a $0c $03
              sLOOP 2, 2                               ;; 0d:7d42 $03 $02 $02
                sPLAYER_STEP_BACKWARD                  ;; 0d:7d45 $81
              sEND                                     ;; 0d:7d46 $00
            sENDIF                                     ;; 0d:7d47
          sENDIF                                       ;; 0d:7d47
        sENDIF                                         ;; 0d:7d47
      sENDIF                                           ;; 0d:7d47
    sENDIF                                             ;; 0d:7d47
    sEND                                               ;; 0d:7d47 $00

script_027b:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0d:7d48 $0b $c9 $00 $08
      sLOAD_ROOM 10, $05, 16, 12                       ;; 0d:7d4c $f4 $0a $05 $10 $0c
      sSET_MUSIC 7                                     ;; 0d:7d51 $f8 $07
      sRUN_ROOM_SCRIPT                                 ;; 0d:7d53 $ec
    sENDIF                                             ;; 0d:7d54
    sEND                                               ;; 0d:7d54 $00

script_027c:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0d:7d55 $0b $c9 $00 $0c
      sIF_FLAG !wScriptFlags02.6                       ;; 0d:7d59 $08 $96 $00 $08
        sLOAD_ROOM 14, $62, 12, 12                     ;; 0d:7d5d $f4 $0e $62 $0c $0c
        sSET_MUSIC 14                                  ;; 0d:7d62 $f8 $0e
        sRUN_ROOM_SCRIPT                               ;; 0d:7d64 $ec
      sENDIF                                           ;; 0d:7d65
    sENDIF                                             ;; 0d:7d65
    sEND                                               ;; 0d:7d65 $00

script_027d:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0d:7d66 $0b $c9 $00 $06
      sSFX 24                                          ;; 0d:7d6a $f9 $18
      sSET_ROOM_TILE $02, 1, 1                         ;; 0d:7d6c $b0 $02 $01 $01
    sENDIF                                             ;; 0d:7d70
    sEND                                               ;; 0d:7d70 $00

script_027e:
    sIF_TRIGGERED_ON_BY $c9, $a9
      sSFX 24
      sSET_ROOM_TILE $02, 8, 1
    sENDIF
    sIF_TRIGGERED_OFF_BY $c9
      sSFX 24
      sSET_ROOM_TILE $00, 8, 1
    sENDIF
    sEND

script_027f:
    sIF_TRIGGERED_ON_BY $c9
      sIF_FLAG wScriptFlags0B.0
        sCALL script_0473
        sSET_FLAG wScriptFlags0B.7
      sENDIF
      sLOAD_ROOM 14, $53, 13, 12
      sSET_MUSIC 4
      sRUN_ROOM_SCRIPT
    sENDIF
    sEND

script_0280:
    sIF_TRIGGERED_ON_BY $c9
      sIF_FLAG wScriptFlags0B.0
        sCALL script_0473
        sSET_FLAG wScriptFlags0B.3
      sENDIF
      sLOAD_ROOM 14, $15, 7, 12
      sIF_FLAG !wScriptFlags05.0
        sSET_MUSIC 0
      sENDIF
      sIF_FLAG wScriptFlags05.0
        sSET_MUSIC 13
      sENDIF
      sRUN_ROOM_SCRIPT
    sENDIF
    sEND

script_0281:
    sIF_TRIGGERED_ON_BY $c9
      sIF_FLAG wScriptFlags0B.0
        sCALL script_0473
        sSET_FLAG wScriptFlags0B.4
      sENDIF
      sLOAD_ROOM 8, $54, 16, 2
      sSET_MUSIC 8
      sIF_FLAG !wScriptFlags04.7
        sSET_NPC_TYPES 81
        sSPAWN_NPC 0
        sSET_NPC_1_DIRECTION_RIGHT
        sSET_PLAYER_DIRECTION_DOWN
        sSET_PLAYER_POSITION 16, 3
        sLOOP 4, 2
          sPLAYER_STEP_FORWARD
        sEND
        sSET_PLAYER_DIRECTION_LEFT
        sLOOP 5, 2
          sPLAYER_STEP_FORWARD
        sEND
        sMSG
          db "<10>", $00
        sIF_FLAG wScriptFlags03.3
          sCALL script_0433
          sMSG
            db ":I'm glad\n you're back!", $00
        sELSE
          sCALL script_053d
        sENDIF
        sMSG
          db "<12>"
          db "<11>", $00
        sGIVE_FOLLOWER 5
        sSET_FLAG wScriptFlags0A.5
      sENDIF
    sENDIF
    sEND

script_0282:
    sIF_TRIGGERED_ON_BY $c9
      sIF_FLAG wScriptFlags0B.0
        sCALL script_0473
        sSET_FLAG wScriptFlags0B.5
      sENDIF
      sUNK_C5 1
      sLOAD_ROOM 6, $17, 9, 12
      sSET_MUSIC 12
      sSET_NPC_TYPES 82
      sSET_PLAYER_DIRECTION_UP
      sSPAWN_NPC 2
      sNPC_1_STEP_FORWARD
      sNPC_1_STEP_FORWARD
      sNPC_1_STEP_FORWARD
      sMSG
        db "<10>I AM MARCIE.\nI SEARCH RELICS.\nDOCTOR BON VOYAGE<12>"
        db "<1b>MADE ME.\nHE LEFT ME HERE.\nI WAITED 50 YEARS.<12>"
        db "<1b>HE FORGOT ME.\nI CAN HELP YOU.\nTAKE ME WITH YOU.<12>"
        db "<11>", $00
      sGIVE_FOLLOWER 7
      sSET_FLAG wScriptFlags0A.7
    sENDIF
    sEND

script_0283:
    sEND

script_0284:
    sIF_TRIGGERED_ON_BY $c9
      sIF_FLAG wScriptFlags0B.0
        sCALL script_0473
        sSET_FLAG wScriptFlags0D.4
      sENDIF
      sLOAD_ROOM 9, $03, 2, 12
      sSET_MUSIC 8
      sRUN_ROOM_SCRIPT
    sENDIF
    sEND

script_0285:
    sIF_TRIGGERED_ON_BY $c9
      sIF_FLAG wScriptFlags0B.0
        sCALL script_0473
        sSET_FLAG wScriptFlags0D.3
      sENDIF
      sLOAD_ROOM 13, $77, 16, 12
      sSET_MUSIC 8
      sRUN_ROOM_SCRIPT
    sENDIF
    sEND

script_0286:
    sIF_TRIGGERED_ON_BY $c9
      sIF_FLAG wScriptFlags0B.0
        sCALL script_0473
        sSET_FLAG wScriptFlags0D.5
      sENDIF
      sLOAD_ROOM 8, $03, 8, 8
      sSET_MUSIC 7
    sENDIF
    sEND

script_0287:
    sIF_TRIGGERED_ON_BY $c9
      sLOAD_ROOM 15, $10, 16, 2
      sSET_MUSIC 7
    sENDIF
    sEND

script_0288:
    sIF_TRIGGERED_ON_BY $c9
      sIF_FLAG wScriptFlags0B.0
        sCALL script_0473
        sSET_FLAG wScriptFlags0C.6
      sENDIF
      sLOAD_ROOM 15, $37, 9, 12
      sIF_FLAG wScriptFlags04.1
        sSET_MUSIC 4
      sELSE
        sSET_MUSIC 27
      sENDIF
      sRUN_ROOM_SCRIPT
    sENDIF
    sEND

script_0289:
    sIF_TRIGGERED_ON_BY $c9
      sLOAD_ROOM 13, $17, 16, 12
      sSET_MUSIC 12
      sRUN_ROOM_SCRIPT
    sENDIF
    sEND

script_028a:
    sIF_TRIGGERED_ON_BY $c9
      sIF_FLAG wScriptFlags0B.0
        sCALL script_0473
        sSET_FLAG wScriptFlags0D.0
      sENDIF
      sUNK_C5 4
      sLOAD_ROOM 3, $47, 9, 12
      sIF_FLAG wScriptFlags05.5
        sSET_MUSIC 11
      sELSE
        sSET_MUSIC 10
      sENDIF
      sRUN_ROOM_SCRIPT
    sENDIF
    sEND

script_028b:
    sIF_TRIGGERED_ON_BY $c9
      sIF_FLAG wScriptFlags0B.0
        sCALL script_0473
        sSET_FLAG wScriptFlags0C.7
      sENDIF
      sLOAD_ROOM 14, $77, 14, 2
      sSET_MUSIC 8
      sSET_FLAG wScriptFlags08.7
      sRUN_ROOM_SCRIPT
    sENDIF
    sEND

script_028c:
    sIF_TRIGGERED_ON_BY $c9
      sLOAD_ROOM 1, $17, 16, 5
      sSET_MUSIC 7
      sCALL script_01c7
    sENDIF
    sEND

script_028d:
    sIF_TRIGGERED_ON_BY $c9
      sLOAD_ROOM 11, $76, 16, 2
      sSET_MUSIC 7
      sRUN_ROOM_SCRIPT
    sENDIF
    sEND

script_028e:
    sEND

script_028f:
    sEND

script_0290:
    sIF_TRIGGERED_ON_BY $c9
      sLOAD_ROOM 0, $f0, 8, 8
      sSET_MUSIC 25
      sCLEAR_ROOM_HISTORY
; Because Chocobo can spawn in an inaccessible location when you leave the cave, move it to you.
      sIF_FLAG wScriptFlags0D.2
        sCALL script_0475
        sSET_NPC_1_POSITION 8, 10
      sENDIF
    sENDIF
    sEND

script_0291:
    sIF_TRIGGERED_ON_BY $c9, $c1
      sLOAD_ROOM 0, $87, 8, 3
      sDELAY 20
      sSET_MUSIC 20
      sRUN_ROOM_SCRIPT
    sENDIF
    sEND

script_0292:
    sIF_TRIGGERED_ON_BY $c9, $c1
      sSFX 12
      sSET_PLAYER_POSITION 20, 0
      sDELAY 60
      sLOAD_ROOM 6, $26, 9, 7
      sRUN_ROOM_SCRIPT
    sENDIF
    sEND

script_0293:
    sEND

script_0294:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4000 $0b $c9 $00 $33
      sIF_FLAG wScriptFlags0A.2
        sMSG                                           ;; 0e:4009 $04
          db "<10>Man:Didn't you\n come here to find\n the Mirror?<12>"
          db "<11>", $00 ;; 0e:400a
        sFOLLOWER_DELETE                               ;; 0e:402b $98
        sCLEAR_FLAG wScriptFlags0A.2                   ;; 0e:402c $db $52
      sENDIF                                           ;; 0e:402e
      sLOAD_ROOM 0, $e8, 10, 3                         ;; 0e:402e $f4 $00 $e8 $0a $03
      sSET_MUSIC 20                                    ;; 0e:4033 $f8 $14
      sCLEAR_ROOM_HISTORY                              ;; 0e:4035 $ab
      sRUN_ROOM_SCRIPT                                 ;; 0e:4036 $ec
    sENDIF                                             ;; 0e:4037
    sEND                                               ;; 0e:4037 $00

script_0295:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:4038 $0b $c9 $c1 $00 $12
      sLOAD_ROOM 0, $dc, 9, 8                          ;; 0e:403d $f4 $00 $dc $09 $08
      sIF_FLAG wScriptFlags02.0, !wScriptFlags02.1     ;; 0e:4042 $08 $10 $91 $00 $05
        sCALL script_053b                              ;; 0e:4047 $02 $6b $04
      sELSE                                            ;; 0e:404a $01 $03
        sSET_MUSIC 20                                  ;; 0e:404c $f8 $14
        sRUN_ROOM_SCRIPT                               ;; 0e:404e $ec
      sENDIF                                           ;; 0e:404f
    sENDIF                                             ;; 0e:404f
    sEND                                               ;; 0e:404f $00

script_0296:
    sEND                                               ;; 0e:4050 $00

script_0297:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4051 $0b $c9 $00 $09
      sLOAD_ROOM 0, $9e, 16, 4                         ;; 0e:4055 $f4 $00 $9e $10 $04
      sSET_MUSIC 20                                    ;; 0e:405a $f8 $14
      sCLEAR_ROOM_HISTORY                              ;; 0e:405c $ab
; Because Chocobo can spawn in an inaccessible location when you leave the cave, move it to you.
      sIF_FLAG wScriptFlags0C.5
        sCALL script_0475
        sSET_NPC_1_POSITION 16, 6
      sENDIF
    sENDIF                                             ;; 0e:405e
    sEND                                               ;; 0e:405e $00

script_0298:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:405f $0b $c9 $00 $09
      sLOAD_ROOM 0, $9b, 4, 6                          ;; 0e:4063 $f4 $00 $9b $04 $06
      sSET_MUSIC 20                                    ;; 0e:4068 $f8 $14
      sCLEAR_ROOM_HISTORY                              ;; 0e:406a $ab
      sRUN_ROOM_SCRIPT                                 ;; 0e:406b $ec
    sENDIF                                             ;; 0e:406c
    sEND                                               ;; 0e:406c $00

script_0299:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:406d $0b $c9 $00 $09
      sLOAD_ROOM 0, $8b, 12, 4                         ;; 0e:4071 $f4 $00 $8b $0c $04
      sSET_MUSIC 20                                    ;; 0e:4076 $f8 $14
      sCLEAR_ROOM_HISTORY                              ;; 0e:4078 $ab
      sRUN_ROOM_SCRIPT                                 ;; 0e:4079 $ec
    sENDIF                                             ;; 0e:407a
    sEND                                               ;; 0e:407a $00

script_029a:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:407b $0b $c9 $00 $37
      sLOAD_ROOM 0, $8d, 6, 8                          ;; 0e:407f $f4 $00 $8d $06 $08
      sSET_MUSIC 20                                    ;; 0e:4084 $f8 $14
      sIF_FLAG !wScriptFlags0A.4, !wScriptFlags02.6    ;; 0e:4086 $08 $d4 $96 $00 $2a
        sSET_NPC_TYPES 79                              ;; 0e:408b $fc $4f
        sSET_PLAYER_DIRECTION_DOWN                     ;; 0e:408d $85
        sLOOP 4, 2                                     ;; 0e:408e $03 $04 $02
          sPLAYER_STEP_FORWARD                         ;; 0e:4091 $80
        sEND                                           ;; 0e:4092 $00
        sMSG                                           ;; 0e:4093 $04
          db "<10> Wait, <BOY>!<12>"
          db "<11>", $00 ;; 0e:4094
        sDELAY 30                                      ;; 0e:409e $f0 $1e
        sSET_PLAYER_DIRECTION_UP                       ;; 0e:40a0 $84
        sDELAY 30                                      ;; 0e:40a1 $f0 $1e
        sSPAWN_NPC 2                                   ;; 0e:40a3 $fd $02
        sGIVE_FOLLOWER 4                               ;; 0e:40a5 $9c $04
        sFOLLOWER_STEP_FORWARD                         ;; 0e:40a7 $90
        sFOLLOWER_STEP_FORWARD                         ;; 0e:40a8 $90
        sMSG                                           ;; 0e:40a9 $04
          db "<10>", $00                               ;; 0e:40aa
        sCALL script_029b                              ;; 0e:40ac $02 $40 $b7
        sMSG                                           ;; 0e:40af $04
          db "<12>"
          db "<11>", $00           ;; 0e:40b0
        sSET_FLAG wScriptFlags0A.4                     ;; 0e:40b3 $da $54
      sENDIF                                           ;; 0e:40b5
      sCLEAR_ROOM_HISTORY                              ;; 0e:40b5 $ab
    sENDIF                                             ;; 0e:40b6
    sEND                                               ;; 0e:40b6 $00

script_029b:
    sMSG                                               ;; 0e:40b7 $04
      db "<BOY>:Bogard!\n <GIRL> was taken\n by Granz_<12>"
      db "<1b>Bogard:Cibba told\n me about that.\n Julius is skilled<12>"
      db "<1b> with disguises.\n But, don't worry.\n We can save <GIRL>.<12>"
      db "<1b> Granz's airship\n is refueling at\n a lake up north.<12>"
      db "<1b> I'll come with\n you and help!\n Let's go!", $00 ;; 0e:40b8
    sEND                                               ;; 0e:415b $00

script_029c:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:415c $0b $c9 $00 $06
      sSET_ROOM_TILE $02, 8, 6                         ;; 0e:4160 $b0 $02 $08 $06
      sSFX 24                                          ;; 0e:4164 $f9 $18
    sENDIF                                             ;; 0e:4166
    sEND                                               ;; 0e:4166 $00

script_029d:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:4167 $0b $c9 $c1 $00 $08
      sLOAD_ROOM 0, $49, 8, 3
      sSET_MUSIC 20                                    ;; 0e:4171 $f8 $14
      sRUN_ROOM_SCRIPT                                 ;; 0e:4173 $ec
    sENDIF                                             ;; 0e:4174
    sEND                                               ;; 0e:4174 $00

script_029e:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:4175 $0b $c9 $c1 $00 $08
      sLOAD_ROOM 0, $18, 9, 8                          ;; 0e:417a $f4 $00 $18 $09 $08
      sSET_MUSIC 20                                    ;; 0e:417f $f8 $14
      sRUN_ROOM_SCRIPT                                 ;; 0e:4181 $ec
    sENDIF                                             ;; 0e:4182
    sEND                                               ;; 0e:4182 $00

script_029f:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4183 $0b $c9 $00 $33
      sIF_FLAG wScriptFlags0A.5, !wScriptFlags04.7     ;; 0e:4187 $08 $55 $a7 $00 $25
        sMSG                                           ;; 0e:418c $04
          db "<10>", $00
        sCALL script_0433
        sMSG
          db ":Won't you\n come along with\n me, <BOY>?<12>"
          db "<11>", $00 ;; 0e:418d
        sFOLLOWER_DELETE                               ;; 0e:41ac $98
        sDELAY 30                                      ;; 0e:41ad $f0 $1e
        sCLEAR_FLAG wScriptFlags0A.5                   ;; 0e:41af $db $55
      sENDIF                                           ;; 0e:41b1
      sLOAD_ROOM 0, $2c, 14, 4                         ;; 0e:41b1 $f4 $00 $2c $0e $04
      sSET_MUSIC 20                                    ;; 0e:41b6 $f8 $14
      sCLEAR_ROOM_HISTORY                              ;; 0e:41b8 $ab
      sRUN_ROOM_SCRIPT                                 ;; 0e:41b9 $ec
    sENDIF                                             ;; 0e:41ba
    sEND                                               ;; 0e:41ba $00

script_02a0:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:41bb $0b $c9 $00 $10
      sIF_FLAG !wScriptFlags03.7                       ;; 0e:41bf $08 $9f $00 $07
        sLOAD_ROOM 15, $65, 4, 12                      ;; 0e:41c3 $f4 $0f $65 $04 $0c
      sELSE                                            ;; 0e:41c8 $01 $05
        sLOAD_ROOM 15, $00, 4, 12                      ;; 0e:41ca $f4 $0f $00 $04 $0c
      sENDIF                                           ;; 0e:41cf
    sENDIF                                             ;; 0e:41cf
    sEND                                               ;; 0e:41cf $00

script_02a1:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:41d0 $0b $c9 $c1 $00 $08
      sLOAD_ROOM 0, $92, 10, 6                         ;; 0e:41d5 $f4 $00 $92 $0a $06
      sSET_MUSIC 25                                    ;; 0e:41da $f8 $19
      sRUN_ROOM_SCRIPT                                 ;; 0e:41dc $ec
    sENDIF                                             ;; 0e:41dd
    sEND                                               ;; 0e:41dd $00

script_02a2:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:41de $0b $c9 $00 $05
      sLOAD_ROOM 14, $57, 2, 12                        ;; 0e:41e2 $f4 $0e $57 $02 $0c
    sENDIF                                             ;; 0e:41e7
    sEND                                               ;; 0e:41e7 $00

script_02a3:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:41e8 $0b $c9 $00 $05
      sLOAD_ROOM 1, $07, 2, 2                          ;; 0e:41ec $f4 $01 $07 $02 $02
    sENDIF                                             ;; 0e:41f1
    sEND                                               ;; 0e:41f1 $00

script_02a4:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:41f2 $0b $c9 $00 $09
      sLOAD_ROOM 0, $0e, 12, 12                        ;; 0e:41f6 $f4 $00 $0e $0c $0c
      sSET_MUSIC 25                                    ;; 0e:41fb $f8 $19
      sCLEAR_ROOM_HISTORY                              ;; 0e:41fd $ab
      sRUN_ROOM_SCRIPT                                 ;; 0e:41fe $ec
    sENDIF                                             ;; 0e:41ff
    sEND                                               ;; 0e:41ff $00

script_02a5:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4200 $0b $c9 $00 $07
      sLOAD_ROOM 1, $52, 9, 4                          ;; 0e:4204 $f4 $01 $52 $09 $04
      sCLEAR_ROOM_HISTORY                              ;; 0e:4209 $ab
      sRUN_ROOM_SCRIPT                                 ;; 0e:420a $ec
    sENDIF                                             ;; 0e:420b
    sEND                                               ;; 0e:420b $00

script_02a6:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:420c $0b $c9 $00 $08
      sUNK_C5 0                                        ;; 0e:4210 $c5 $00
      sLOAD_ROOM 2, $00, 9, 12                         ;; 0e:4212 $f4 $02 $00 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4217 $ec
    sENDIF                                             ;; 0e:4218
    sEND                                               ;; 0e:4218 $00

script_02a7:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4219 $0b $c9 $00 $08
      sUNK_C5 0                                        ;; 0e:421d $c5 $00
      sLOAD_ROOM 2, $01, 9, 12                         ;; 0e:421f $f4 $02 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4224 $ec
    sENDIF                                             ;; 0e:4225
    sEND                                               ;; 0e:4225 $00

script_02a8:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4226 $0b $c9 $00 $08
      sUNK_C5 12                                       ;; 0e:422a $c5 $0c
      sLOAD_ROOM 4, $01, 9, 12                         ;; 0e:422c $f4 $04 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4231 $ec
    sENDIF                                             ;; 0e:4232
    sEND                                               ;; 0e:4232 $00

script_02a9:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4233 $0b $c9 $00 $08
      sUNK_C5 12                                       ;; 0e:4237 $c5 $0c
      sLOAD_ROOM 3, $00, 9, 12                         ;; 0e:4239 $f4 $03 $00 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:423e $ec
    sENDIF                                             ;; 0e:423f
    sEND                                               ;; 0e:423f $00

script_02aa:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4240 $0b $c9 $00 $08
      sUNK_C5 10                                       ;; 0e:4244 $c5 $0a
      sLOAD_ROOM 3, $01, 9, 12                         ;; 0e:4246 $f4 $03 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:424b $ec
    sENDIF                                             ;; 0e:424c
    sEND                                               ;; 0e:424c $00

script_02ab:
    sEND                                               ;; 0e:424d $00

script_02ac:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:424e $0b $c9 $00 $08
      sUNK_C5 2                                        ;; 0e:4252 $c5 $02
      sLOAD_ROOM 2, $00, 9, 12                         ;; 0e:4254 $f4 $02 $00 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4259 $ec
    sENDIF                                             ;; 0e:425a
    sEND                                               ;; 0e:425a $00

script_02ad:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:425b $0b $c9 $00 $08
      sUNK_C5 1                                        ;; 0e:425f $c5 $01
      sLOAD_ROOM 2, $01, 9, 12                         ;; 0e:4261 $f4 $02 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4266 $ec
    sENDIF                                             ;; 0e:4267
    sEND                                               ;; 0e:4267 $00

script_02ae:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4268 $0b $c9 $00 $08
      sUNK_C5 13                                       ;; 0e:426c $c5 $0d
      sLOAD_ROOM 4, $01, 9, 12                         ;; 0e:426e $f4 $04 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4273 $ec
    sENDIF                                             ;; 0e:4274
    sEND                                               ;; 0e:4274 $00

script_02af:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4275 $0b $c9 $00 $08
      sUNK_C5 13                                       ;; 0e:4279 $c5 $0d
      sLOAD_ROOM 3, $00, 9, 12                         ;; 0e:427b $f4 $03 $00 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4280 $ec
    sENDIF                                             ;; 0e:4281
    sEND                                               ;; 0e:4281 $00

script_02b0:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4282 $0b $c9 $00 $08
      sUNK_C5 11                                       ;; 0e:4286 $c5 $0b
      sLOAD_ROOM 3, $01, 9, 12                         ;; 0e:4288 $f4 $03 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:428d $ec
    sENDIF                                             ;; 0e:428e
    sEND                                               ;; 0e:428e $00

script_02b1:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:428f $0b $c9 $00 $08
      sUNK_C5 4                                        ;; 0e:4293 $c5 $04
      sLOAD_ROOM 2, $00, 9, 12                         ;; 0e:4295 $f4 $02 $00 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:429a $ec
    sENDIF                                             ;; 0e:429b
    sEND                                               ;; 0e:429b $00

script_02b2:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:429c $0b $c9 $00 $08
      sUNK_C5 3                                        ;; 0e:42a0 $c5 $03
      sLOAD_ROOM 2, $01, 9, 12                         ;; 0e:42a2 $f4 $02 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:42a7 $ec
    sENDIF                                             ;; 0e:42a8
    sEND                                               ;; 0e:42a8 $00

script_02b3:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:42a9 $0b $c9 $00 $07
      sUNK_C5 7                                        ;; 0e:42ad $c5 $07
      sLOAD_ROOM 4, $00, 9, 12                         ;; 0e:42af $f4 $04 $00 $09 $0c
    sENDIF                                             ;; 0e:42b4
    sEND                                               ;; 0e:42b4 $00

script_02b4:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:42b5 $0b $c9 $00 $08
      sUNK_C5 13                                       ;; 0e:42b9 $c5 $0d
      sLOAD_ROOM 3, $01, 9, 12                         ;; 0e:42bb $f4 $03 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:42c0 $ec
    sENDIF                                             ;; 0e:42c1
    sEND                                               ;; 0e:42c1 $00

script_02b5:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:42c2 $0b $c9 $00 $08
      sUNK_C5 5                                        ;; 0e:42c6 $c5 $05
      sLOAD_ROOM 2, $00, 9, 12                         ;; 0e:42c8 $f4 $02 $00 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:42cd $ec
    sENDIF                                             ;; 0e:42ce
    sEND                                               ;; 0e:42ce $00

script_02b6:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:42cf $0b $c9 $00 $08
      sUNK_C5 4                                        ;; 0e:42d3 $c5 $04
      sLOAD_ROOM 2, $01, 9, 12                         ;; 0e:42d5 $f4 $02 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:42da $ec
    sENDIF                                             ;; 0e:42db
    sEND                                               ;; 0e:42db $00

script_02b7:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:42dc $0b $c9 $00 $08
      sUNK_C5 9                                        ;; 0e:42e0 $c5 $09
      sLOAD_ROOM 4, $01, 9, 12                         ;; 0e:42e2 $f4 $04 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:42e7 $ec
    sENDIF                                             ;; 0e:42e8
    sEND                                               ;; 0e:42e8 $00

script_02b8:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:42e9 $0b $c9 $00 $08
      sUNK_C5 14                                       ;; 0e:42ed $c5 $0e
      sLOAD_ROOM 3, $00, 9, 12                         ;; 0e:42ef $f4 $03 $00 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:42f4 $ec
    sENDIF                                             ;; 0e:42f5
    sEND                                               ;; 0e:42f5 $00

script_02b9:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:42f6 $0b $c9 $00 $08
      sUNK_C5 12                                       ;; 0e:42fa $c5 $0c
      sLOAD_ROOM 3, $01, 9, 12                         ;; 0e:42fc $f4 $03 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4301 $ec
    sENDIF                                             ;; 0e:4302
    sEND                                               ;; 0e:4302 $00

script_02ba:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4303 $0b $c9 $00 $08
      sIF_FLAG wScriptFlags04.0
        sSET_FLAG wScriptFlags03.7
      sENDIF
      sUNK_C5 15                                       ;; 0e:4307 $c5 $0f
      sLOAD_ROOM 2, $00, 9, 12                         ;; 0e:4309 $f4 $02 $00 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:430e $ec
    sENDIF                                             ;; 0e:430f
    sEND                                               ;; 0e:430f $00

script_02bb:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4310 $0b $c9 $00 $08
      sIF_FLAG wScriptFlags04.0
        sSET_FLAG wScriptFlags03.7
      sENDIF
      sUNK_C5 6                                        ;; 0e:4314 $c5 $06
      sLOAD_ROOM 2, $01, 9, 12                         ;; 0e:4316 $f4 $02 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:431b $ec
    sENDIF                                             ;; 0e:431c
    sEND                                               ;; 0e:431c $00

script_02bc:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:431d $0b $c9 $00 $08
      sUNK_C5 11                                       ;; 0e:4321 $c5 $0b
      sLOAD_ROOM 4, $01, 9, 12                         ;; 0e:4323 $f4 $04 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4328 $ec
    sENDIF                                             ;; 0e:4329
    sEND                                               ;; 0e:4329 $00

script_02bd:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:432a $0b $c9 $00 $08
      sUNK_C5 14                                       ;; 0e:432e $c5 $0e
      sLOAD_ROOM 3, $01, 9, 12                         ;; 0e:4330 $f4 $03 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4335 $ec
    sENDIF                                             ;; 0e:4336
    sEND                                               ;; 0e:4336 $00

script_02be:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4337 $0b $c9 $00 $22
      sUNK_C5 9                                        ;; 0e:433b $c5 $09
      sIF_FLAG wScriptFlags03.7, !wScriptFlags04.1     ;; 0e:433d $08 $1f $a1 $00 $15
        sSET_MUSIC 0                                   ;; 0e:4342 $f8 $00
        sSFX 22                                        ;; 0e:4344 $f9 $16
        sDELAY 70                                      ;; 0e:4346 $f0 $46
        sSFX 22                                        ;; 0e:4348 $f9 $16
        sDELAY 70                                      ;; 0e:434a $f0 $46
; Fill tiles just outside the screen before the shake effect.
        sSET_ROOM_TILE $61, 10, 0
        sSET_ROOM_TILE $62, 10, 1
        sSET_ROOM_TILE $60, 10, 2
        sSET_ROOM_TILE $70, 10, 3
        sSET_ROOM_TILE $70, 10, 4
        sSET_ROOM_TILE $70, 10, 5
        sSET_ROOM_TILE $00, 10, 6
        sSET_ROOM_TILE $30, 10, 7
        sSET_ROOM_TILE $11, 15, 0
        sSET_ROOM_TILE $21, 15, 1
        sSET_ROOM_TILE $08, 15, 2
        sSET_ROOM_TILE $08, 15, 3
        sSET_ROOM_TILE $08, 15, 4
        sSET_ROOM_TILE $08, 15, 5
        sSET_ROOM_TILE $08, 15, 6
        sSET_ROOM_TILE $08, 15, 7
        sSFX 37                                        ;; 0e:434c $f9 $25
        sSHAKE_SCREEN                                  ;; 0e:434e $fb
        sMSG                                           ;; 0e:434f $04
          db "<10>  __?<12>"
          db "<11>", $00  ;; 0e:4350
      sENDIF                                           ;; 0e:4357
      sLOAD_ROOM 3, $01, 9, 12                         ;; 0e:4357 $f4 $03 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:435c $ec
    sENDIF                                             ;; 0e:435d
    sEND                                               ;; 0e:435d $00

script_02bf:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:435e $0b $c9 $00 $07
      sLOAD_ROOM 0, $9b, 4, 5                          ;; 0e:4362 $f4 $00 $9b $04 $05
      sSET_MUSIC 20                                    ;; 0e:4367 $f8 $14
    sENDIF                                             ;; 0e:4369
    sEND                                               ;; 0e:4369 $00

script_02c0:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:436a $0b $c9 $00 $05
      sLOAD_ROOM 1, $57, 14, 12                        ;; 0e:436e $f4 $01 $57 $0e $0c
    sENDIF                                             ;; 0e:4373
    sEND                                               ;; 0e:4373 $00

script_02c1:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4374 $0b $c9 $00 $05
      sLOAD_ROOM 1, $71, 2, 6                          ;; 0e:4378 $f4 $01 $71 $02 $06
    sENDIF                                             ;; 0e:437d
    sEND                                               ;; 0e:437d $00

script_02c2:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:437e $0b $c9 $00 $05
      sLOAD_ROOM 1, $71, 8, 4                          ;; 0e:4382 $f4 $01 $71 $08 $04
    sENDIF                                             ;; 0e:4387
    sEND                                               ;; 0e:4387 $00

script_02c3:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4388 $0b $c9 $00 $05
      sLOAD_ROOM 1, $71, 16, 6                         ;; 0e:438c $f4 $01 $71 $10 $06
    sENDIF                                             ;; 0e:4391
    sEND                                               ;; 0e:4391 $00

script_02c4:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4392 $0b $c9 $00 $20
      sLOAD_ROOM 1, $36, 14, 254                       ;; 0e:4396 $f4 $01 $36 $0e $fe
      sSET_PLAYER_DIRECTION_UP                         ;; 0e:439b $84
      sDELAY 30                                        ;; 0e:439c $f0 $1e
      sPLAYER_STEP_BACKWARD                            ;; 0e:439e $81
      sDELAY 60                                        ;; 0e:439f $f0 $3c
      sPLAYER_STEP_BACKWARD                            ;; 0e:43a1 $81
      sPLAYER_STEP_BACKWARD                            ;; 0e:43a2 $81
      sDELAY 10                                        ;; 0e:43a3 $f0 $0a
      sPLAYER_STEP_BACKWARD                            ;; 0e:43a5 $81
      sDELAY 70                                        ;; 0e:43a6 $f0 $46
      sSET_PLAYER_DIRECTION_DOWN                       ;; 0e:43a8 $85
      sSET_PLAYER_HURT_SPRITE                          ;; 0e:43a9 $a5
      sSET_FAST_MOVEMENT                               ;; 0e:43aa $88
      sSFX 12                                          ;; 0e:43ab $f9 $0c
      sLOOP 6, 2                                       ;; 0e:43ad $03 $06 $02
        sPLAYER_STEP_FORWARD                           ;; 0e:43b0 $80
      sEND                                             ;; 0e:43b1 $00
      sSET_PLAYER_NORMAL_SPRITE                        ;; 0e:43b2 $a4
      sCLEAR_FAST_MOVEMENT                             ;; 0e:43b3 $89
      sDELAY 20                                        ;; 0e:43b4 $f0 $14
    sENDIF                                             ;; 0e:43b6
    sEND                                               ;; 0e:43b6 $00

script_02c5:
    sEND                                               ;; 0e:43b7 $00

script_02c6:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:43b8 $0b $c9 $c1 $00 $05
      sLOAD_ROOM 1, $46, 7, 8                          ;; 0e:43bd $f4 $01 $46 $07 $08
    sENDIF                                             ;; 0e:43c2
    sEND                                               ;; 0e:43c2 $00

script_02c7:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:43c3 $0b $c9 $00 $05
      sLOAD_ROOM 1, $45, 7, 12                         ;; 0e:43c7 $f4 $01 $45 $07 $0c
    sENDIF                                             ;; 0e:43cc
    sEND                                               ;; 0e:43cc $00

script_02c8:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:43cd $0b $c9 $00 $05
      sLOAD_ROOM 15, $04, 14, 12                       ;; 0e:43d1 $f4 $0f $04 $0e $0c
    sENDIF                                             ;; 0e:43d6
    sEND                                               ;; 0e:43d6 $00

script_02c9:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:43d7 $0b $c9 $00 $05
      sLOAD_ROOM 1, $24, 6, 2                          ;; 0e:43db $f4 $01 $24 $06 $02
    sENDIF                                             ;; 0e:43e0
    sEND                                               ;; 0e:43e0 $00

script_02ca:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:43e1 $0b $c9 $00 $05
      sLOAD_ROOM 15, $32, 16, 10                       ;; 0e:43e5 $f4 $0f $32 $10 $0a
    sENDIF                                             ;; 0e:43ea
    sEND                                               ;; 0e:43ea $00

script_02cb:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:43eb $0b $c9 $00 $05
      sLOAD_ROOM 15, $33, 14, 12                       ;; 0e:43ef $f4 $0f $33 $0e $0c
    sENDIF                                             ;; 0e:43f4
    sEND                                               ;; 0e:43f4 $00

script_02cc:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:43f5 $0b $c9 $00 $05
      sLOAD_ROOM 5, $02, 16, 12                        ;; 0e:43f9 $f4 $05 $02 $10 $0c
    sENDIF                                             ;; 0e:43fe
    sEND                                               ;; 0e:43fe $00

script_02cd:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:43ff $0b $c9 $00 $05
      sLOAD_ROOM 4, $02, 16, 12                        ;; 0e:4403 $f4 $04 $02 $10 $0c
    sENDIF                                             ;; 0e:4408
    sEND                                               ;; 0e:4408 $00

script_02ce:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4409 $0b $c9 $00 $05
      sLOAD_ROOM 6, $03, 16, 2                         ;; 0e:440d $f4 $06 $03 $10 $02
    sENDIF                                             ;; 0e:4412
    sEND                                               ;; 0e:4412 $00

script_02cf:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4413 $0b $c9 $00 $05
      sLOAD_ROOM 5, $03, 16, 2                         ;; 0e:4417 $f4 $05 $03 $10 $02
    sENDIF                                             ;; 0e:441c
    sEND                                               ;; 0e:441c $00

script_02d0:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:441d $0b $c9 $00 $05
      sLOAD_ROOM 6, $42, 16, 2                         ;; 0e:4421 $f4 $06 $42 $10 $02
    sENDIF                                             ;; 0e:4426
    sEND                                               ;; 0e:4426 $00

script_02d1:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4427 $0b $c9 $00 $06
      sLOAD_ROOM 5, $42, 16, 2                         ;; 0e:442b $f4 $05 $42 $10 $02
; Inlined from 03df to remove wall enemy conditional.
      sSET_NPC_TYPES 7
      sSPAWN_NPC 2
      sSPAWN_NPC 0
    sENDIF                                             ;; 0e:4431
    sEND                                               ;; 0e:4431 $00

script_02d2:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4432 $0b $c9 $00 $05
      sLOAD_ROOM 5, $51, 16, 2                         ;; 0e:4436 $f4 $05 $51 $10 $02
    sENDIF                                             ;; 0e:443b
    sEND                                               ;; 0e:443b $00

script_02d3:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:443c $0b $c9 $00 $05
      sLOAD_ROOM 4, $51, 16, 2                         ;; 0e:4440 $f4 $04 $51 $10 $02
    sENDIF                                             ;; 0e:4445
    sEND                                               ;; 0e:4445 $00

script_02d4:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4446 $0b $c9 $00 $05
      sLOAD_ROOM 5, $32, 16, 12                        ;; 0e:444a $f4 $05 $32 $10 $0c
    sENDIF                                             ;; 0e:444f
    sEND                                               ;; 0e:444f $00

script_02d5:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4450 $0b $c9 $00 $05
      sLOAD_ROOM 4, $32, 16, 12                        ;; 0e:4454 $f4 $04 $32 $10 $0c
    sENDIF                                             ;; 0e:4459
    sEND                                               ;; 0e:4459 $00

script_02d6:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:445a $0b $c9 $00 $05
      sLOAD_ROOM 4, $21, 10, 8                         ;; 0e:445e $f4 $04 $21 $0a $08
    sENDIF                                             ;; 0e:4463
    sEND                                               ;; 0e:4463 $00

script_02d7:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4464 $0b $c9 $00 $05
      sLOAD_ROOM 5, $21, 10, 6                         ;; 0e:4468 $f4 $05 $21 $0a $06
    sENDIF                                             ;; 0e:446d
    sEND                                               ;; 0e:446d $00

script_02d8:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:446e $0b $c9 $00 $05
      sLOAD_ROOM 6, $71, 2, 2                          ;; 0e:4472 $f4 $06 $71 $02 $02
    sENDIF                                             ;; 0e:4477
    sEND                                               ;; 0e:4477 $00

script_02d9:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4478 $0b $c9 $00 $05
      sLOAD_ROOM 15, $30, 14, 6                        ;; 0e:447c $f4 $0f $30 $0e $06
    sENDIF                                             ;; 0e:4481
    sEND                                               ;; 0e:4481 $00

script_02da:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4482 $0b $c9 $00 $05
      sLOAD_ROOM 15, $54, 2, 12                        ;; 0e:4486 $f4 $0f $54 $02 $0c
    sENDIF                                             ;; 0e:448b
    sEND                                               ;; 0e:448b $00

script_02db:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:448c $0b $c9 $00 $05
      sLOAD_ROOM 15, $64, 14, 2                        ;; 0e:4490 $f4 $0f $64 $0e $02
    sENDIF                                             ;; 0e:4495
    sEND                                               ;; 0e:4495 $00

script_02dc:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4496 $0b $c9 $00 $05
      sLOAD_ROOM 5, $72, 16, 12                        ;; 0e:449a $f4 $05 $72 $10 $0c
    sENDIF                                             ;; 0e:449f
    sEND                                               ;; 0e:449f $00

script_02dd:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:44a0 $0b $c9 $00 $05
      sLOAD_ROOM 5, $70, 16, 12                        ;; 0e:44a4 $f4 $05 $70 $10 $0c
    sENDIF                                             ;; 0e:44a9
    sEND                                               ;; 0e:44a9 $00

script_02de:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:44aa $0b $c9 $00 $05
      sLOAD_ROOM 5, $70, 16, 2                         ;; 0e:44ae $f4 $05 $70 $10 $02
    sENDIF                                             ;; 0e:44b3
    sEND                                               ;; 0e:44b3 $00

script_02df:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:44b4 $0b $c9 $00 $05
      sLOAD_ROOM 15, $31, 10, 4                        ;; 0e:44b8 $f4 $0f $31 $0a $04
    sENDIF                                             ;; 0e:44bd
    sEND                                               ;; 0e:44bd $00

script_02e0:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:44be $0b $c9 $00 $05
      sLOAD_ROOM 1, $03, 9, 4                          ;; 0e:44c2 $f4 $01 $03 $09 $04
    sENDIF                                             ;; 0e:44c7
    sEND                                               ;; 0e:44c7 $00

script_02e1:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:44c8 $0b $c9 $00 $08
      sUNK_C5 6                                        ;; 0e:44cc $c5 $06
      sLOAD_ROOM 5, $00, 9, 12                         ;; 0e:44ce $f4 $05 $00 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:44d3 $ec
    sENDIF                                             ;; 0e:44d4
    sEND                                               ;; 0e:44d4 $00

script_02e2:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:44d5 $0b $c9 $00 $05
      sLOAD_ROOM 15, $02, 16, 8                        ;; 0e:44d9 $f4 $0f $02 $10 $08
    sENDIF                                             ;; 0e:44de
    sEND                                               ;; 0e:44de $00

script_02e3:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:44df $0b $c9 $00 $05
      sLOAD_ROOM 4, $04, 16, 12                        ;; 0e:44e3 $f4 $04 $04 $10 $0c
    sENDIF                                             ;; 0e:44e8
    sEND                                               ;; 0e:44e8 $00

script_02e4:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:44e9 $0b $c9 $00 $05
      sLOAD_ROOM 1, $03, 9, 4                          ;; 0e:44ed $f4 $01 $03 $09 $04
    sENDIF                                             ;; 0e:44f2
    sEND                                               ;; 0e:44f2 $00

script_02e5:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:44f3 $0b $c9 $00 $05
      sLOAD_ROOM 1, $33, 11, 4                         ;; 0e:44f7 $f4 $01 $33 $0b $04
    sENDIF                                             ;; 0e:44fc
    sEND                                               ;; 0e:44fc $00

script_02e6:
    sEND                                               ;; 0e:44fd $00

script_02e7:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:44fe $0b $c9 $00 $05
      sLOAD_ROOM 15, $62, 2, 4                         ;; 0e:4502 $f4 $0f $62 $02 $04
    sENDIF                                             ;; 0e:4507
    sEND                                               ;; 0e:4507 $00

script_02e8:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4508 $0b $c9 $00 $05
      sLOAD_ROOM 15, $63, 2, 6                         ;; 0e:450c $f4 $0f $63 $02 $06
    sENDIF                                             ;; 0e:4511
    sEND                                               ;; 0e:4511 $00

script_02e9:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4512 $0b $c9 $00 $05
      sLOAD_ROOM 5, $14, 2, 2                          ;; 0e:4516 $f4 $05 $14 $02 $02
    sENDIF                                             ;; 0e:451b
    sEND                                               ;; 0e:451b $00

script_02ea:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:451c $0b $c9 $00 $05
      sLOAD_ROOM 6, $14, 16, 2                         ;; 0e:4520 $f4 $06 $14 $10 $02
    sENDIF                                             ;; 0e:4525
    sEND                                               ;; 0e:4525 $00

script_02eb:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4526 $0b $c9 $00 $05
      sLOAD_ROOM 15, $53, 16, 6                        ;; 0e:452a $f4 $0f $53 $10 $06
    sENDIF                                             ;; 0e:452f
    sEND                                               ;; 0e:452f $00

script_02ec:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4530 $0b $c9 $00 $05
      sLOAD_ROOM 15, $52, 16, 4                        ;; 0e:4534 $f4 $0f $52 $10 $04
    sENDIF                                             ;; 0e:4539
    sEND                                               ;; 0e:4539 $00

script_02ed:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:453a $0b $c9 $00 $09
      sLOAD_ROOM 3, $06, 16, 12                        ;; 0e:453e $f4 $03 $06 $10 $0c
      sSET_ROOM_TILE $02, 8, 6                         ;; 0e:4543 $b0 $02 $08 $06
    sENDIF                                             ;; 0e:4547
    sEND                                               ;; 0e:4547 $00

script_02ee:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4548 $0b $c9 $00 $05
      sLOAD_ROOM 4, $06, 16, 12                        ;; 0e:454c $f4 $04 $06 $10 $0c
    sENDIF                                             ;; 0e:4551
    sEND                                               ;; 0e:4551 $00

script_02ef:
    sEND                                               ;; 0e:4552 $00

script_02f0:
    sEND                                               ;; 0e:4553 $00

script_02f1:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4554 $0b $c9 $00 $06
      sLOAD_ROOM 2, $06, 16, 2                         ;; 0e:4558 $f4 $02 $06 $10 $02
      sRUN_ROOM_SCRIPT                                 ;; 0e:455d $ec
    sENDIF                                             ;; 0e:455e
    sEND                                               ;; 0e:455e $00

script_02f2:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:455f $0b $c9 $00 $05
      sLOAD_ROOM 3, $06, 16, 2                         ;; 0e:4563 $f4 $03 $06 $10 $02
    sENDIF                                             ;; 0e:4568
    sEND                                               ;; 0e:4568 $00

script_02f3:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4569 $0b $c9 $00 $05
      sLOAD_ROOM 2, $05, 16, 2                         ;; 0e:456d $f4 $02 $05 $10 $02
    sENDIF                                             ;; 0e:4572
    sEND                                               ;; 0e:4572 $00

script_02f4:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4573 $0b $c9 $00 $05
      sLOAD_ROOM 1, $40, 14, 1                         ;; 0e:4577 $f4 $01 $40 $0e $01
    sENDIF                                             ;; 0e:457c
    sEND                                               ;; 0e:457c $00

script_02f5:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:457d $0b $c9 $c1 $00 $2a
      sIF_FLAG wScriptFlags0E.2, wScriptFlags0E.3, !wScriptFlags0E.4, wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7 ;; 0e:4582 $08 $72 $73 $f4 $75 $f6 $77 $00 $05
        sLOAD_ROOM 2, $74, 14, 4                       ;; 0e:458b $f4 $02 $74 $0e $04
      sENDIF                                           ;; 0e:4590
      sIF_FLAG wScriptFlags0E.2, wScriptFlags0E.3, !wScriptFlags0E.4, wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0e:4590 $08 $72 $73 $f4 $75 $76 $f7 $00 $05
        sLOAD_ROOM 4, $47, 16, 12                      ;; 0e:4599 $f4 $04 $47 $10 $0c
      sENDIF                                           ;; 0e:459e
      sIF_FLAG wScriptFlags0E.2, wScriptFlags0E.3, !wScriptFlags0E.4, wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7 ;; 0e:459e $08 $72 $73 $f4 $75 $76 $77 $00 $05
        sLOAD_ROOM 6, $64, 16, 12                      ;; 0e:45a7 $f4 $06 $64 $10 $0c
      sENDIF                                           ;; 0e:45ac
    sENDIF                                             ;; 0e:45ac
    sEND                                               ;; 0e:45ac $00

script_02f6:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:45ad $0b $c9 $00 $06
      sSET_ROOM_TILE $02, 8, 6                         ;; 0e:45b1 $b0 $02 $08 $06
      sSFX 24                                          ;; 0e:45b5 $f9 $18
    sENDIF                                             ;; 0e:45b7
    sEND                                               ;; 0e:45b7 $00

script_02f7:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:45b8 $0b $c9 $00 $05
      sLOAD_ROOM 2, $52, 16, 2                         ;; 0e:45bc $f4 $02 $52 $10 $02
    sENDIF                                             ;; 0e:45c1
    sEND                                               ;; 0e:45c1 $00

script_02f8:
    sEND                                               ;; 0e:45c2 $00

script_02f9:
    sEND                                               ;; 0e:45c3 $00

script_02fa:
    sEND                                               ;; 0e:45c4 $00

script_02fb:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:45c5 $0b $c9 $00 $05
      sLOAD_ROOM 15, $35, 14, 6                        ;; 0e:45c9 $f4 $0f $35 $0e $06
    sENDIF                                             ;; 0e:45ce
    sEND                                               ;; 0e:45ce $00

script_02fc:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:45cf $0b $c9 $00 $05
      sLOAD_ROOM 2, $16, 16, 12                        ;; 0e:45d3 $f4 $02 $16 $10 $0c
    sENDIF                                             ;; 0e:45d8
    sEND                                               ;; 0e:45d8 $00

script_02fd:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:45d9 $0b $c9 $00 $05
      sLOAD_ROOM 8, $62, 16, 2                         ;; 0e:45dd $f4 $08 $62 $10 $02
    sENDIF                                             ;; 0e:45e2
    sEND                                               ;; 0e:45e2 $00

script_02fe:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:45e3 $0b $c9 $00 $05
      sLOAD_ROOM 14, $36, 8, 5                         ;; 0e:45e7 $f4 $0e $36 $08 $05
    sENDIF                                             ;; 0e:45ec
    sEND                                               ;; 0e:45ec $00

script_02ff:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:45ed $0b $c9 $00 $05
      sLOAD_ROOM 2, $50, 16, 2                         ;; 0e:45f1 $f4 $02 $50 $10 $02
    sENDIF                                             ;; 0e:45f6
    sEND                                               ;; 0e:45f6 $00

script_0300:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:45f7 $0b $c9 $00 $05
      sLOAD_ROOM 3, $50, 16, 2                         ;; 0e:45fb $f4 $03 $50 $10 $02
    sENDIF                                             ;; 0e:4600
    sEND                                               ;; 0e:4600 $00

script_0301:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4601 $0b $c9 $00 $05
      sLOAD_ROOM 2, $62, 16, 12                        ;; 0e:4605 $f4 $02 $62 $10 $0c
    sENDIF                                             ;; 0e:460a
    sEND                                               ;; 0e:460a $00

script_0302:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:460b $0b $c9 $00 $05
      sLOAD_ROOM 3, $62, 16, 12                        ;; 0e:460f $f4 $03 $62 $10 $0c
    sENDIF                                             ;; 0e:4614
    sEND                                               ;; 0e:4614 $00

script_0303:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4615 $0b $c9 $00 $05
      sLOAD_ROOM 2, $10, 16, 2                         ;; 0e:4619 $f4 $02 $10 $10 $02
    sENDIF                                             ;; 0e:461e
    sEND                                               ;; 0e:461e $00

script_0304:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:461f $0b $c9 $00 $05
      sLOAD_ROOM 3, $10, 16, 2                         ;; 0e:4623 $f4 $03 $10 $10 $02
    sENDIF                                             ;; 0e:4628
    sEND                                               ;; 0e:4628 $00

script_0305:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4629 $0b $c9 $00 $05
      sLOAD_ROOM 2, $20, 16, 2                         ;; 0e:462d $f4 $02 $20 $10 $02
    sENDIF                                             ;; 0e:4632
    sEND                                               ;; 0e:4632 $00

script_0306:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4633 $0b $c9 $00 $06
      sLOAD_ROOM 3, $20, 16, 2                         ;; 0e:4637 $f4 $03 $20 $10 $02
      sRUN_ROOM_SCRIPT                                 ;; 0e:463c $ec
    sENDIF                                             ;; 0e:463d
    sEND                                               ;; 0e:463d $00

script_0307:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:463e $0b $c9 $00 $05
      sLOAD_ROOM 5, $20, 16, 12                        ;; 0e:4642 $f4 $05 $20 $10 $0c
    sENDIF                                             ;; 0e:4647
    sEND                                               ;; 0e:4647 $00

script_0308:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4648 $0b $c9 $00 $09
      sLOAD_ROOM 3, $20, 16, 12                        ;; 0e:464c $f4 $03 $20 $10 $0c
      sSET_ROOM_TILE $02, 8, 6                         ;; 0e:4651 $b0 $02 $08 $06
    sENDIF                                             ;; 0e:4655
    sEND                                               ;; 0e:4655 $00

script_0309:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4656 $0b $c9 $00 $05
      sLOAD_ROOM 14, $51, 8, 6                         ;; 0e:465a $f4 $0e $51 $08 $06
    sENDIF                                             ;; 0e:465f
    sEND                                               ;; 0e:465f $00

script_030a:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4660 $0b $c9 $00 $05
      sLOAD_ROOM 2, $73, 16, 2                         ;; 0e:4664 $f4 $02 $73 $10 $02
    sENDIF                                             ;; 0e:4669
    sEND                                               ;; 0e:4669 $00

script_030b:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:466a $0b $c9 $00 $05
      sLOAD_ROOM 3, $04, 16, 12                        ;; 0e:466e $f4 $03 $04 $10 $0c
    sENDIF                                             ;; 0e:4673
    sEND                                               ;; 0e:4673 $00

script_030c:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4674 $0b $c9 $00 $05
      sLOAD_ROOM 2, $04, 16, 12                        ;; 0e:4678 $f4 $02 $04 $10 $0c
    sENDIF                                             ;; 0e:467d
    sEND                                               ;; 0e:467d $00

script_030d:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:467e $0b $c9 $00 $05
      sLOAD_ROOM 3, $32, 16, 2                         ;; 0e:4682 $f4 $03 $32 $10 $02
    sENDIF                                             ;; 0e:4687
    sEND                                               ;; 0e:4687 $00

script_030e:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4688 $0b $c9 $00 $05
      sLOAD_ROOM 2, $32, 16, 2                         ;; 0e:468c $f4 $02 $32 $10 $02
    sENDIF                                             ;; 0e:4691
    sEND                                               ;; 0e:4691 $00

script_030f:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4692 $0b $c9 $00 $05
      sLOAD_ROOM 4, $43, 16, 12                        ;; 0e:4696 $f4 $04 $43 $10 $0c
    sENDIF                                             ;; 0e:469b
    sEND                                               ;; 0e:469b $00

script_0310:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:469c $0b $c9 $00 $05
      sLOAD_ROOM 3, $52, 16, 2                         ;; 0e:46a0 $f4 $03 $52 $10 $02
    sENDIF                                             ;; 0e:46a5
    sEND                                               ;; 0e:46a5 $00

script_0311:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:46a6 $0b $c9 $00 $0d
      sUNK_C5 3                                        ;; 0e:46aa $c5 $03
      sCLEAR_FLAG wScriptFlags0F.0                     ;; 0e:46ac $db $78
      sCLEAR_FLAG wScriptFlags0F.1                     ;; 0e:46ae $db $79
      sLOAD_ROOM 3, $35, 9, 12                         ;; 0e:46b0 $f4 $03 $35 $09 $0c
      sSET_MUSIC 14                                    ;; 0e:46b5 $f8 $0e
    sENDIF                                             ;; 0e:46b7
    sEND                                               ;; 0e:46b7 $00

script_0312:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:46b8 $0b $c9 $00 $05
      sLOAD_ROOM 2, $35, 16, 2                         ;; 0e:46bc $f4 $02 $35 $10 $02
    sENDIF                                             ;; 0e:46c1
    sEND                                               ;; 0e:46c1 $00

script_0313:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:46c2 $0b $c9 $00 $05
      sLOAD_ROOM 3, $35, 16, 2                         ;; 0e:46c6 $f4 $03 $35 $10 $02
    sENDIF                                             ;; 0e:46cb
    sEND                                               ;; 0e:46cb $00

script_0314:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:46cc $0b $c9 $00 $06
      sLOAD_ROOM 2, $55, 16, 12                        ;; 0e:46d0 $f4 $02 $55 $10 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:46d5 $ec
    sENDIF                                             ;; 0e:46d6
    sEND                                               ;; 0e:46d6 $00

script_0315:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:46d7 $0b $c9 $00 $07
      sLOAD_ROOM 3, $55, 16, 12                        ;; 0e:46db $f4 $03 $55 $10 $0c
      sCLEAR_FLAG wScriptFlags0F.0                     ;; 0e:46e0 $db $78
    sENDIF                                             ;; 0e:46e2
    sEND                                               ;; 0e:46e2 $00

script_0316:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:46e3 $0b $c9 $00 $06
      sLOAD_ROOM 2, $66, 16, 12                        ;; 0e:46e7 $f4 $02 $66 $10 $0c
; Inlined from 012a to remove wall enemy conditional.
      sSET_NPC_TYPES 4                                   ;; 0d:4aa1 $fc $04
      sSPAWN_NPC 2
      sSPAWN_NPC 0
      sRUN_ROOM_SCRIPT                                 ;; 0e:46ec $ec
    sENDIF                                             ;; 0e:46ed
    sEND                                               ;; 0e:46ed $00

script_0317:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:46ee $0b $c9 $00 $05
      sLOAD_ROOM 3, $66, 16, 12                        ;; 0e:46f2 $f4 $03 $66 $10 $0c
    sENDIF                                             ;; 0e:46f7
    sEND                                               ;; 0e:46f7 $00

script_0318:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:46f8 $0b $c9 $00 $05
      sLOAD_ROOM 2, $64, 16, 2                         ;; 0e:46fc $f4 $02 $64 $10 $02
    sENDIF                                             ;; 0e:4701
    sEND                                               ;; 0e:4701 $00

script_0319:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4702 $0b $c9 $00 $05
      sLOAD_ROOM 3, $64, 16, 2                         ;; 0e:4706 $f4 $03 $64 $10 $02
    sENDIF                                             ;; 0e:470b
    sEND                                               ;; 0e:470b $00

script_031a:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:470c $0b $c9 $00 $05
      sLOAD_ROOM 2, $24, 16, 12                        ;; 0e:4710 $f4 $02 $24 $10 $0c
    sENDIF                                             ;; 0e:4715
    sEND                                               ;; 0e:4715 $00

script_031b:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4716 $0b $c9 $00 $05
      sLOAD_ROOM 3, $24, 16, 12                        ;; 0e:471a $f4 $03 $24 $10 $0c
    sENDIF                                             ;; 0e:471f
    sEND                                               ;; 0e:471f $00

script_031c:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4720 $0b $c9 $00 $05
      sLOAD_ROOM 2, $26, 16, 12                        ;; 0e:4724 $f4 $02 $26 $10 $0c
    sENDIF                                             ;; 0e:4729
    sEND                                               ;; 0e:4729 $00

script_031d:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:472a $0b $c9 $00 $05
      sLOAD_ROOM 3, $26, 16, 12                        ;; 0e:472e $f4 $03 $26 $10 $0c
    sENDIF                                             ;; 0e:4733
    sEND                                               ;; 0e:4733 $00

script_031e:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4734 $0b $c9 $00 $05
      sLOAD_ROOM 2, $25, 16, 2                         ;; 0e:4738 $f4 $02 $25 $10 $02
    sENDIF                                             ;; 0e:473d
    sEND                                               ;; 0e:473d $00

script_031f:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:473e $0b $c9 $00 $2a
      sIF_FLAG wScriptFlags0E.2, wScriptFlags0E.3, !wScriptFlags0E.4, wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7 ;; 0e:4742 $08 $72 $73 $f4 $75 $76 $77 $00 $05
        sLOAD_ROOM 1, $10, 6, 8                        ;; 0e:474b $f4 $01 $10 $06 $08
      sENDIF                                           ;; 0e:4750
      sIF_FLAG wScriptFlags0E.2, wScriptFlags0E.3, !wScriptFlags0E.4, wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0e:4750 $08 $72 $73 $f4 $75 $76 $f7 $00 $05
        sLOAD_ROOM 1, $61, 12, 8                       ;; 0e:4759 $f4 $01 $61 $0c $08
      sENDIF                                           ;; 0e:475e
      sIF_FLAG wScriptFlags0E.2, wScriptFlags0E.3, !wScriptFlags0E.4, wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7 ;; 0e:475e $08 $72 $73 $f4 $75 $f6 $77 $00 $05
        sLOAD_ROOM 1, $75, 12, 12                      ;; 0e:4767 $f4 $01 $75 $0c $0c
      sENDIF                                           ;; 0e:476c
    sENDIF                                             ;; 0e:476c
    sEND                                               ;; 0e:476c $00

script_0320:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:476d $0b $c9 $00 $05
      sLOAD_ROOM 1, $20, 12, 8                         ;; 0e:4771 $f4 $01 $20 $0c $08
    sENDIF                                             ;; 0e:4776
    sEND                                               ;; 0e:4776 $00

script_0321:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4777 $0b $c9 $00 $05
      sLOAD_ROOM 6, $75, 9, 7                          ;; 0e:477b $f4 $06 $75 $09 $07
    sENDIF                                             ;; 0e:4780
    sEND                                               ;; 0e:4780 $00

script_0322:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4781 $0b $c9 $00 $05
      sLOAD_ROOM 6, $44, 9, 7                          ;; 0e:4785 $f4 $06 $44 $09 $07
    sENDIF                                             ;; 0e:478a
    sEND                                               ;; 0e:478a $00

script_0323:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:478b $0b $c9 $00 $05
      sLOAD_ROOM 1, $21, 12, 8                         ;; 0e:478f $f4 $01 $21 $0c $08
    sENDIF                                             ;; 0e:4794
    sEND                                               ;; 0e:4794 $00

script_0324:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4795 $0b $c9 $00 $05
      sLOAD_ROOM 1, $11, 6, 8                          ;; 0e:4799 $f4 $01 $11 $06 $08
    sENDIF                                             ;; 0e:479e
    sEND                                               ;; 0e:479e $00

script_0325:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:479f $0b $c9 $00 $05
      sLOAD_ROOM 1, $50, 6, 8                          ;; 0e:47a3 $f4 $01 $50 $06 $08
    sENDIF                                             ;; 0e:47a8
    sEND                                               ;; 0e:47a8 $00

script_0326:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:47a9 $0b $c9 $00 $05
      sLOAD_ROOM 1, $60, 12, 8                         ;; 0e:47ad $f4 $01 $60 $0c $08
    sENDIF                                             ;; 0e:47b2
    sEND                                               ;; 0e:47b2 $00

script_0327:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:47b3 $0b $c9 $00 $05
      sLOAD_ROOM 4, $67, 9, 7                          ;; 0e:47b7 $f4 $04 $67 $09 $07
    sENDIF                                             ;; 0e:47bc
    sEND                                               ;; 0e:47bc $00

script_0328:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:47bd $0b $c9 $00 $05
      sLOAD_ROOM 6, $53, 9, 7                          ;; 0e:47c1 $f4 $06 $53 $09 $07
    sENDIF                                             ;; 0e:47c6
    sEND                                               ;; 0e:47c6 $00

script_0329:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:47c7 $0b $c9 $00 $05
      sLOAD_ROOM 4, $45, 9, 7                          ;; 0e:47cb $f4 $04 $45 $09 $07
    sENDIF                                             ;; 0e:47d0
    sEND                                               ;; 0e:47d0 $00

script_032a:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:47d1 $0b $c9 $00 $05
      sLOAD_ROOM 5, $46, 9, 7                          ;; 0e:47d5 $f4 $05 $46 $09 $07
    sENDIF                                             ;; 0e:47da
    sEND                                               ;; 0e:47da $00

script_032b:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:47db $0b $c9 $00 $05
      sLOAD_ROOM 4, $65, 9, 7                          ;; 0e:47df $f4 $04 $65 $09 $07
    sENDIF                                             ;; 0e:47e4
    sEND                                               ;; 0e:47e4 $00

script_032c:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:47e5 $0b $c9 $00 $05
      sLOAD_ROOM 5, $63, 9, 7                          ;; 0e:47e9 $f4 $05 $63 $09 $07
    sENDIF                                             ;; 0e:47ee
    sEND                                               ;; 0e:47ee $00

script_032d:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:47ef $0b $c9 $00 $05
      sLOAD_ROOM 5, $40, 9, 7                          ;; 0e:47f3 $f4 $05 $40 $09 $07
    sENDIF                                             ;; 0e:47f8
    sEND                                               ;; 0e:47f8 $00

script_032e:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:47f9 $0b $c9 $00 $05
      sLOAD_ROOM 5, $52, 9, 7                          ;; 0e:47fd $f4 $05 $52 $09 $07
    sENDIF                                             ;; 0e:4802
    sEND                                               ;; 0e:4802 $00

script_032f:
    sEND                                               ;; 0e:4803 $00

script_0330:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4804 $0b $c9 $00 $05
      sLOAD_ROOM 1, $51, 6, 8                          ;; 0e:4808 $f4 $01 $51 $06 $08
    sENDIF                                             ;; 0e:480d
    sEND                                               ;; 0e:480d $00

script_0331:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:480e $0b $c9 $00 $05
      sLOAD_ROOM 2, $46, 9, 7                          ;; 0e:4812 $f4 $02 $46 $09 $07
    sENDIF                                             ;; 0e:4817
    sEND                                               ;; 0e:4817 $00

script_0332:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4818 $0b $c9 $00 $05
      sLOAD_ROOM 3, $33, 9, 7                          ;; 0e:481c $f4 $03 $33 $09 $07
    sENDIF                                             ;; 0e:4821
    sEND                                               ;; 0e:4821 $00

script_0333:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4822 $0b $c9 $00 $05
      sLOAD_ROOM 1, $02, 6, 8                          ;; 0e:4826 $f4 $01 $02 $06 $08
    sENDIF                                             ;; 0e:482b
    sEND                                               ;; 0e:482b $00

script_0334:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:482c $0b $c9 $00 $05
      sLOAD_ROOM 1, $12, 12, 8                         ;; 0e:4830 $f4 $01 $12 $0c $08
    sENDIF                                             ;; 0e:4835
    sEND                                               ;; 0e:4835 $00

script_0335:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4836 $0b $c9 $00 $05
      sLOAD_ROOM 1, $16, 12, 8                         ;; 0e:483a $f4 $01 $16 $0c $08
    sENDIF                                             ;; 0e:483f
    sEND                                               ;; 0e:483f $00

script_0336:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4840 $0b $c9 $00 $05
      sLOAD_ROOM 1, $06, 6, 8                          ;; 0e:4844 $f4 $01 $06 $06 $08
    sENDIF                                             ;; 0e:4849
    sEND                                               ;; 0e:4849 $00

script_0337:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:484a $0b $c9 $00 $05
      sLOAD_ROOM 2, $17, 9, 7                          ;; 0e:484e $f4 $02 $17 $09 $07
    sENDIF                                             ;; 0e:4853
    sEND                                               ;; 0e:4853 $00

script_0338:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4854 $0b $c9 $00 $05
      sLOAD_ROOM 6, $21, 9, 7                          ;; 0e:4858 $f4 $06 $21 $09 $07
    sENDIF                                             ;; 0e:485d
    sEND                                               ;; 0e:485d $00

script_0339:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:485e $0b $c9 $00 $05
      sLOAD_ROOM 15, $56, 14, 4                        ;; 0e:4862 $f4 $0f $56 $0e $04
    sENDIF                                             ;; 0e:4867
    sEND                                               ;; 0e:4867 $00

script_033a:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4868 $0b $c9 $00 $05
      sLOAD_ROOM 3, $56, 16, 2                         ;; 0e:486c $f4 $03 $56 $10 $02
    sENDIF                                             ;; 0e:4871
    sEND                                               ;; 0e:4871 $00

script_033b:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:4872 $0b $c9 $c1 $00 $06
      sLOAD_ROOM 1, $15, 9, 12                         ;; 0e:4877 $f4 $01 $15 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:487c $ec
    sENDIF                                             ;; 0e:487d
    sEND                                               ;; 0e:487d $00

script_033c:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:487e $0b $c9 $c1 $00 $06
      sLOAD_ROOM 14, $16, 9, 2                         ;; 0e:4883 $f4 $0e $16 $09 $02
      sRUN_ROOM_SCRIPT                                 ;; 0e:4888 $ec
    sENDIF                                             ;; 0e:4889
    sEND                                               ;; 0e:4889 $00

script_033d:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:488a $0b $c9 $00 $07
      sUNK_C5 5                                        ;; 0e:488e $c5 $05
      sLOAD_ROOM 4, $63, 9, 12                         ;; 0e:4890 $f4 $04 $63 $09 $0c
    sENDIF                                             ;; 0e:4895
    sEND                                               ;; 0e:4895 $00

script_033e:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4896 $0b $c9 $00 $07
      sUNK_C5 35                                       ;; 0e:489a $c5 $23
      sLOAD_ROOM 6, $46, 16, 2                         ;; 0e:489c $f4 $06 $46 $10 $02
    sENDIF                                             ;; 0e:48a1
    sEND                                               ;; 0e:48a1 $00

script_033f:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:48a2 $0b $c9 $00 $05
      sLOAD_ROOM 2, $46, 16, 2                         ;; 0e:48a6 $f4 $02 $46 $10 $02
    sENDIF                                             ;; 0e:48ab
    sEND                                               ;; 0e:48ab $00

script_0340:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:48ac $0b $c9 $00 $05
      sLOAD_ROOM 4, $67, 16, 2                         ;; 0e:48b0 $f4 $04 $67 $10 $02
    sENDIF                                             ;; 0e:48b5
    sEND                                               ;; 0e:48b5 $00

script_0341:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:48b6 $0b $c9 $00 $05
      sLOAD_ROOM 4, $65, 16, 2                         ;; 0e:48ba $f4 $04 $65 $10 $02
    sENDIF                                             ;; 0e:48bf
    sEND                                               ;; 0e:48bf $00

script_0342:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:48c0 $0b $c9 $00 $05
      sLOAD_ROOM 6, $75, 16, 2                         ;; 0e:48c4 $f4 $06 $75 $10 $02
    sENDIF                                             ;; 0e:48c9
    sEND                                               ;; 0e:48c9 $00

script_0343:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:48ca $0b $c9 $00 $05
      sLOAD_ROOM 15, $66, 8, 8                         ;; 0e:48ce $f4 $0f $66 $08 $08
    sENDIF                                             ;; 0e:48d3
    sEND                                               ;; 0e:48d3 $00

script_0344:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:48d4 $0b $c9 $c1 $00 $05
      sLOAD_ROOM 1, $72, 10, 2                         ;; 0e:48d9 $f4 $01 $72 $0a $02
    sENDIF                                             ;; 0e:48de
    sEND                                               ;; 0e:48de $00

script_0345:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:48df $0b $c9 $00 $05
      sLOAD_ROOM 1, $74, 16, 12                        ;; 0e:48e3 $f4 $01 $74 $10 $0c
    sENDIF                                             ;; 0e:48e8
    sEND                                               ;; 0e:48e8 $00

script_0346:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:48e9 $0b $c9 $00 $05
      sLOAD_ROOM 6, $57, 16, 2                         ;; 0e:48ed $f4 $06 $57 $10 $02
    sENDIF                                             ;; 0e:48f2
    sEND                                               ;; 0e:48f2 $00

script_0347:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:48f3 $0b $c9 $00 $06
      sLOAD_ROOM 1, $14, 16, 12                        ;; 0e:48f7 $f4 $01 $14 $10 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:48fc $ec
    sENDIF                                             ;; 0e:48fd
    sEND                                               ;; 0e:48fd $00

script_0348:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:48fe $0b $c9 $00 $05
      sLOAD_ROOM 1, $03, 2, 12                         ;; 0e:4902 $f4 $01 $03 $02 $0c
    sENDIF                                             ;; 0e:4907
    sEND                                               ;; 0e:4907 $00

script_0349:
    sEND                                               ;; 0e:4908 $00

script_034a:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4909 $0b $c9 $00 $05
      sLOAD_ROOM 1, $04, 6, 4                          ;; 0e:490d $f4 $01 $04 $06 $04
    sENDIF                                             ;; 0e:4912
    sEND                                               ;; 0e:4912 $00

script_034b:
    sEND                                               ;; 0e:4913 $00

script_034c:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4914 $0b $c9 $00 $07
      sUNK_C5 53                                       ;; 0e:4918 $c5 $35
      sLOAD_ROOM 1, $01, 16, 12                        ;; 0e:491a $f4 $01 $01 $10 $0c
    sENDIF                                             ;; 0e:491f
    sEND                                               ;; 0e:491f $00

script_034d:
    sEND                                               ;; 0e:4920 $00

script_034e:
    sEND                                               ;; 0e:4921 $00

script_034f:
    sEND                                               ;; 0e:4922 $00

script_0350:
    sEND                                               ;; 0e:4923 $00

script_0351:
    sEND                                               ;; 0e:4924 $00

script_0352:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4925 $0b $c9 $00 $60
      sIF_FLAG !wScriptFlags06.7                       ;; 0e:4929 $08 $b7 $00 $55
; Fill tiles just outside the screen before the shake effect.
        sSET_ROOM_TILE $12, 10, 0
        sSET_ROOM_TILE $12, 10, 1
        sSET_ROOM_TILE $12, 10, 2
        sSET_ROOM_TILE $12, 10, 3
        sSET_ROOM_TILE $12, 10, 4
        sSET_ROOM_TILE $12, 10, 5
        sSET_ROOM_TILE $12, 10, 6
        sSET_ROOM_TILE $12, 10, 7
        sSET_ROOM_TILE $64, 15, 0
        sSET_ROOM_TILE $64, 15, 1
        sSET_ROOM_TILE $25, 15, 2
        sSET_ROOM_TILE $64, 15, 3
        sSET_ROOM_TILE $53, 15, 4
        sSET_ROOM_TILE $64, 15, 5
        sSET_ROOM_TILE $64, 15, 6
        sSET_ROOM_TILE $79, 15, 7
        sSFX 37                                        ;; 0e:492d $f9 $25
        sSHAKE_SCREEN                                  ;; 0e:492f $fb
        sMSG                                           ;; 0e:4930 $04
          db "<10>__?<12>"
          db "<11>", $00    ;; 0e:4931
        sPLAYER_STEP_BACKWARD                          ;; 0e:4937 $81
        sPLAYER_STEP_BACKWARD                          ;; 0e:4938 $81
        sSET_PLAYER_DIRECTION_LEFT                     ;; 0e:4939 $87
        sSFX 20                                        ;; 0e:493a $f9 $14
        sSET_ROOM_TILE $64, 0, 2                       ;; 0e:493c $b0 $64 $00 $02
        sDELAY 15                                      ;; 0e:4940 $f0 $0f
        sSFX 20                                        ;; 0e:4942 $f9 $14
        sSET_ROOM_TILE $64, 1, 2                       ;; 0e:4944 $b0 $64 $01 $02
        sDELAY 15                                      ;; 0e:4948 $f0 $0f
        sSFX 20                                        ;; 0e:494a $f9 $14
        sSET_ROOM_TILE $64, 2, 2                       ;; 0e:494c $b0 $64 $02 $02
        sDELAY 15                                      ;; 0e:4950 $f0 $0f
        sSFX 20                                        ;; 0e:4952 $f9 $14
        sSET_ROOM_TILE $64, 3, 2                       ;; 0e:4954 $b0 $64 $03 $02
        sDELAY 15                                      ;; 0e:4958 $f0 $0f
        sSFX 20                                        ;; 0e:495a $f9 $14
        sSET_ROOM_TILE $64, 4, 2                       ;; 0e:495c $b0 $64 $04 $02
        sDELAY 15                                      ;; 0e:4960 $f0 $0f
        sSFX 20                                        ;; 0e:4962 $f9 $14
        sSET_ROOM_TILE $64, 5, 2                       ;; 0e:4964 $b0 $64 $05 $02
        sDELAY 60                                      ;; 0e:4968 $f0 $3c
        sMSG                                           ;; 0e:496a $04
          db "<10> I can't go back\n anymore __<12>"
          db "<11>", $00 ;; 0e:496b
        sSET_FLAG wScriptFlags06.7                     ;; 0e:4980 $da $37
      sENDIF                                           ;; 0e:4982
      sLOAD_ROOM 1, $26, 12, 4                         ;; 0e:4982 $f4 $01 $26 $0c $04
      sSET_MUSIC 14                                    ;; 0e:4987 $f8 $0e
    sENDIF                                             ;; 0e:4989
    sEND                                               ;; 0e:4989 $00

script_0353:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:498a $0b $c9 $00 $05
      sLOAD_ROOM 9, $40, 16, 2                         ;; 0e:498e $f4 $09 $40 $10 $02
    sENDIF                                             ;; 0e:4993
    sEND                                               ;; 0e:4993 $00

script_0354:
    sEND                                               ;; 0e:4994 $00

script_0355:
    sEND                                               ;; 0e:4995 $00

script_0356:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4996 $0b $c9 $00 $09
      sLOAD_ROOM 0, $51, 14, 8                         ;; 0e:499a $f4 $00 $51 $0e $08
      sSET_MUSIC 20                                    ;; 0e:499f $f8 $14
      sCLEAR_ROOM_HISTORY                              ;; 0e:49a1 $ab
      sRUN_ROOM_SCRIPT                                 ;; 0e:49a2 $ec
    sENDIF                                             ;; 0e:49a3
    sEND                                               ;; 0e:49a3 $00

script_0357:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:49a4 $0b $c9 $00 $05
      sLOAD_ROOM 1, $34, 2, 12                         ;; 0e:49a8 $f4 $01 $34 $02 $0c
    sENDIF                                             ;; 0e:49ad
    sEND                                               ;; 0e:49ad $00

script_0358:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:49ae $0b $c9 $00 $05
      sLOAD_ROOM 14, $55, 16, 4                        ;; 0e:49b2 $f4 $0e $55 $10 $04
    sENDIF                                             ;; 0e:49b7
    sEND                                               ;; 0e:49b7 $00

script_0359:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:49b8 $0b $c9 $00 $06
      sLOAD_ROOM 9, $41, 16, 2                         ;; 0e:49bc $f4 $09 $41 $10 $02
      sRUN_ROOM_SCRIPT                                 ;; 0e:49c1 $ec
    sENDIF                                             ;; 0e:49c2
    sEND                                               ;; 0e:49c2 $00

script_035a:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:49c3 $0b $c9 $00 $05
      sLOAD_ROOM 8, $24, 16, 2                         ;; 0e:49c7 $f4 $08 $24 $10 $02
    sENDIF                                             ;; 0e:49cc
    sEND                                               ;; 0e:49cc $00

script_035b:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:49cd $0b $c9 $c1 $00 $05
      sLOAD_ROOM 11, $36, 16, 12                       ;; 0e:49d2 $f4 $0b $36 $10 $0c
    sENDIF                                             ;; 0e:49d7
    sEND                                               ;; 0e:49d7 $00

script_035c:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:49d8 $0b $c9 $00 $05
      sLOAD_ROOM 14, $56, 10, 2                        ;; 0e:49dc $f4 $0e $56 $0a $02
    sENDIF                                             ;; 0e:49e1
    sEND                                               ;; 0e:49e1 $00

script_035d:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:49e2 $0b $c9 $00 $05
      sLOAD_ROOM 8, $51, 16, 2                         ;; 0e:49e6 $f4 $08 $51 $10 $02
    sENDIF                                             ;; 0e:49eb
    sEND                                               ;; 0e:49eb $00

script_035e:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:49ec $0b $c9 $00 $05
      sLOAD_ROOM 8, $57, 16, 2                         ;; 0e:49f0 $f4 $08 $57 $10 $02
    sENDIF                                             ;; 0e:49f5
    sEND                                               ;; 0e:49f5 $00

script_035f:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:49f6 $0b $c9 $00 $05
      sLOAD_ROOM 3, $43, 16, 12                        ;; 0e:49fa $f4 $03 $43 $10 $0c
    sENDIF                                             ;; 0e:49ff
    sEND                                               ;; 0e:49ff $00

script_0360:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4a00 $0b $c9 $00 $05
      sLOAD_ROOM 11, $17, 9, 7                         ;; 0e:4a04 $f4 $0b $17 $09 $07
    sENDIF                                             ;; 0e:4a09
    sEND                                               ;; 0e:4a09 $00

script_0361:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4a0a $0b $c9 $00 $05
      sLOAD_ROOM 15, $56, 16, 2                        ;; 0e:4a0e $f4 $0f $56 $10 $02
    sENDIF                                             ;; 0e:4a13
    sEND                                               ;; 0e:4a13 $00

script_0362:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4a14 $0b $c9 $00 $05
      sLOAD_ROOM 15, $47, 4, 6                         ;; 0e:4a18 $f4 $0f $47 $04 $06
    sENDIF                                             ;; 0e:4a1d
    sEND                                               ;; 0e:4a1d $00

script_0363:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4a1e $0b $c9 $00 $05
      sLOAD_ROOM 15, $66, 4, 2                         ;; 0e:4a22 $f4 $0f $66 $04 $02
    sENDIF                                             ;; 0e:4a27
    sEND                                               ;; 0e:4a27 $00

script_0364:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4a28 $0b $c9 $00 $05
      sLOAD_ROOM 15, $66, 14, 10                       ;; 0e:4a2c $f4 $0f $66 $0e $0a
    sENDIF                                             ;; 0e:4a31
    sEND                                               ;; 0e:4a31 $00

script_0365:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4a32 $0b $c9 $00 $06
      sLOAD_ROOM 10, $51, 16, 2                        ;; 0e:4a36 $f4 $0a $51 $10 $02
      sRUN_ROOM_SCRIPT                                 ;; 0e:4a3b $ec
    sENDIF                                             ;; 0e:4a3c
    sEND                                               ;; 0e:4a3c $00

script_0366:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4a3d $0b $c9 $00 $05
      sLOAD_ROOM 9, $21, 16, 2                         ;; 0e:4a41 $f4 $09 $21 $10 $02
    sENDIF                                             ;; 0e:4a46
    sEND                                               ;; 0e:4a46 $00

script_0367:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4a47 $0b $c9 $00 $05
      sLOAD_ROOM 15, $67, 4, 2                         ;; 0e:4a4b $f4 $0f $67 $04 $02
    sENDIF                                             ;; 0e:4a50
    sEND                                               ;; 0e:4a50 $00

script_0368:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:4a51 $0b $c9 $c1 $00 $06
      sLOAD_ROOM 10, $41, 16, 12                       ;; 0e:4a56 $f4 $0a $41 $10 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4a5b $ec
    sENDIF                                             ;; 0e:4a5c
    sEND                                               ;; 0e:4a5c $00

script_0369:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4a5d $0b $c9 $00 $09
      sLOAD_ROOM 0, $12, 12, 6                         ;; 0e:4a61 $f4 $00 $12 $0c $06
      sCLEAR_ROOM_HISTORY                              ;; 0e:4a66 $ab
      sSET_MUSIC 20                                    ;; 0e:4a67 $f8 $14
      sRUN_ROOM_SCRIPT                                 ;; 0e:4a69 $ec
    sENDIF                                             ;; 0e:4a6a
    sEND                                               ;; 0e:4a6a $00

script_036a:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4a6b $0b $c9 $00 $05
      sLOAD_ROOM 9, $33, 16, 2                         ;; 0e:4a6f $f4 $09 $33 $10 $02
    sENDIF                                             ;; 0e:4a74
    sEND                                               ;; 0e:4a74 $00

script_036b:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4a75 $0b $c9 $00 $05
      sLOAD_ROOM 12, $00, 16, 2                        ;; 0e:4a79 $f4 $0c $00 $10 $02
    sENDIF                                             ;; 0e:4a7e
    sEND                                               ;; 0e:4a7e $00

script_036c:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4a7f $0b $c9 $00 $05
      sLOAD_ROOM 13, $00, 16, 2                        ;; 0e:4a83 $f4 $0d $00 $10 $02
    sENDIF                                             ;; 0e:4a88
    sEND                                               ;; 0e:4a88 $00

script_036d:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4a89 $0b $c9 $00 $09
      sLOAD_ROOM 12, $32, 16, 12                       ;; 0e:4a8d $f4 $0c $32 $10 $0c
      sSET_ROOM_TILE $02, 8, 6                         ;; 0e:4a92 $b0 $02 $08 $06
    sENDIF                                             ;; 0e:4a96
    sEND                                               ;; 0e:4a96 $00

script_036e:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4a97 $0b $c9 $00 $05
      sLOAD_ROOM 13, $32, 16, 12                       ;; 0e:4a9b $f4 $0d $32 $10 $0c
    sENDIF                                             ;; 0e:4aa0
    sEND                                               ;; 0e:4aa0 $00

script_036f:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4aa1 $0b $c9 $00 $06
      sLOAD_ROOM 11, $11, 16, 2                        ;; 0e:4aa5 $f4 $0b $11 $10 $02
; Inlined from 03df to remove wall enemy conditional.
      sSET_NPC_TYPES 7
      sSPAWN_NPC 2
      sSPAWN_NPC 0
    sENDIF                                             ;; 0e:4aab
    sEND                                               ;; 0e:4aab $00

script_0370:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4aac $0b $c9 $00 $05
      sLOAD_ROOM 12, $11, 16, 2                        ;; 0e:4ab0 $f4 $0c $11 $10 $02
    sENDIF                                             ;; 0e:4ab5
    sEND                                               ;; 0e:4ab5 $00

script_0371:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4ab6 $0b $c9 $00 $05
      sLOAD_ROOM 14, $44, 4, 4                         ;; 0e:4aba $f4 $0e $44 $04 $04
    sENDIF                                             ;; 0e:4abf
    sEND                                               ;; 0e:4abf $00

script_0372:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4ac0 $0b $c9 $00 $05
      sLOAD_ROOM 14, $54, 14, 2                        ;; 0e:4ac4 $f4 $0e $54 $0e $02
    sENDIF                                             ;; 0e:4ac9
    sEND                                               ;; 0e:4ac9 $00

script_0373:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4aca $0b $c9 $00 $05
      sLOAD_ROOM 1, $33, 8, 2                          ;; 0e:4ace $f4 $01 $33 $08 $02
    sENDIF                                             ;; 0e:4ad3
    sEND                                               ;; 0e:4ad3 $00

script_0374:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4ad4 $0b $c9 $00 $05
      sLOAD_ROOM 1, $23, 16, 12                        ;; 0e:4ad8 $f4 $01 $23 $10 $0c
    sENDIF                                             ;; 0e:4add
    sEND                                               ;; 0e:4add $00

script_0375:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4ade $0b $c9 $00 $05
      sLOAD_ROOM 1, $41, 14, 8                         ;; 0e:4ae2 $f4 $01 $41 $0e $08
    sENDIF                                             ;; 0e:4ae7
    sEND                                               ;; 0e:4ae7 $00

script_0376:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4ae8 $0b $c9 $00 $05
      sLOAD_ROOM 1, $31, 6, 2                          ;; 0e:4aec $f4 $01 $31 $06 $02
    sENDIF                                             ;; 0e:4af1
    sEND                                               ;; 0e:4af1 $00

script_0377:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4af2 $0b $c9 $00 $05
      sLOAD_ROOM 1, $70, 6, 6                          ;; 0e:4af6 $f4 $01 $70 $06 $06
    sENDIF                                             ;; 0e:4afb
    sEND                                               ;; 0e:4afb $00

script_0378:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4afc $0b $c9 $00 $05
      sLOAD_ROOM 1, $70, 12, 2                         ;; 0e:4b00 $f4 $01 $70 $0c $02
    sENDIF                                             ;; 0e:4b05
    sEND                                               ;; 0e:4b05 $00

script_0379:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4b06 $0b $c9 $00 $05
      sLOAD_ROOM 1, $71, 8, 12                         ;; 0e:4b0a $f4 $01 $71 $08 $0c
    sENDIF                                             ;; 0e:4b0f
    sEND                                               ;; 0e:4b0f $00

script_037a:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4b10 $0b $c9 $00 $09
      sLOAD_ROOM 13, $73, 16, 12                       ;; 0e:4b14 $f4 $0d $73 $10 $0c
      sSET_ROOM_TILE $02, 8, 6                         ;; 0e:4b19 $b0 $02 $08 $06
    sENDIF                                             ;; 0e:4b1d
    sEND                                               ;; 0e:4b1d $00

script_037b:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4b1e $0b $c9 $00 $05
      sLOAD_ROOM 14, $12, 10, 2                        ;; 0e:4b22 $f4 $0e $12 $0a $02
    sENDIF                                             ;; 0e:4b27
    sEND                                               ;; 0e:4b27 $00

script_037c:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4b28 $0b $c9 $00 $05
      sLOAD_ROOM 14, $45, 2, 8                         ;; 0e:4b2c $f4 $0e $45 $02 $08
    sENDIF                                             ;; 0e:4b31
    sEND                                               ;; 0e:4b31 $00

script_037d:
    sEND                                               ;; 0e:4b32 $00

script_037e:
    sEND                                               ;; 0e:4b33 $00

script_037f:
    sEND                                               ;; 0e:4b34 $00

script_0380:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4b35 $0b $c9 $00 $08
      sUNK_C5 11                                       ;; 0e:4b39 $c5 $0b
      sLOAD_ROOM 3, $00, 9, 12                         ;; 0e:4b3b $f4 $03 $00 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4b40 $ec
    sENDIF                                             ;; 0e:4b41
    sEND                                               ;; 0e:4b41 $00

script_0381:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4b42 $0b $c9 $00 $08
      sUNK_C5 7                                        ;; 0e:4b46 $c5 $07
      sLOAD_ROOM 2, $00, 9, 12                         ;; 0e:4b48 $f4 $02 $00 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4b4d $ec
    sENDIF                                             ;; 0e:4b4e
    sEND                                               ;; 0e:4b4e $00

script_0382:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4b4f $0b $c9 $00 $08
      sUNK_C5 6                                        ;; 0e:4b53 $c5 $06
      sLOAD_ROOM 2, $00, 9, 12                         ;; 0e:4b55 $f4 $02 $00 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4b5a $ec
    sENDIF                                             ;; 0e:4b5b
    sEND                                               ;; 0e:4b5b $00

script_0383:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4b5c $0b $c9 $00 $08
      sUNK_C5 7                                        ;; 0e:4b60 $c5 $07
      sLOAD_ROOM 2, $01, 9, 12                         ;; 0e:4b62 $f4 $02 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4b67 $ec
    sENDIF                                             ;; 0e:4b68
    sEND                                               ;; 0e:4b68 $00

script_0384:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4b69 $0b $c9 $00 $08
      sUNK_C5 10                                       ;; 0e:4b6d $c5 $0a
      sLOAD_ROOM 3, $00, 9, 12                         ;; 0e:4b6f $f4 $03 $00 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4b74 $ec
    sENDIF                                             ;; 0e:4b75
    sEND                                               ;; 0e:4b75 $00

script_0385:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4b76 $0b $c9 $00 $08
      sUNK_C5 9                                        ;; 0e:4b7a $c5 $09
      sLOAD_ROOM 3, $00, 9, 12                         ;; 0e:4b7c $f4 $03 $00 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4b81 $ec
    sENDIF                                             ;; 0e:4b82
    sEND                                               ;; 0e:4b82 $00

script_0386:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4b83 $0b $c9 $00 $08
      sUNK_C5 8                                        ;; 0e:4b87 $c5 $08
      sLOAD_ROOM 3, $00, 9, 12                         ;; 0e:4b89 $f4 $03 $00 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4b8e $ec
    sENDIF                                             ;; 0e:4b8f
    sEND                                               ;; 0e:4b8f $00

script_0387:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4b90 $0b $c9 $00 $08
      sUNK_C5 14                                       ;; 0e:4b94 $c5 $0e
      sLOAD_ROOM 4, $01, 9, 12                         ;; 0e:4b96 $f4 $04 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4b9b $ec
    sENDIF                                             ;; 0e:4b9c
    sEND                                               ;; 0e:4b9c $00

script_0388:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4b9d $0b $c9 $00 $08
      sUNK_C5 2                                        ;; 0e:4ba1 $c5 $02
      sLOAD_ROOM 2, $01, 9, 12                         ;; 0e:4ba3 $f4 $02 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4ba8 $ec
    sENDIF                                             ;; 0e:4ba9
    sEND                                               ;; 0e:4ba9 $00

script_0389:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4baa $0b $c9 $00 $08
      sUNK_C5 8                                        ;; 0e:4bae $c5 $08
      sLOAD_ROOM 2, $00, 9, 12                         ;; 0e:4bb0 $f4 $02 $00 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4bb5 $ec
    sENDIF                                             ;; 0e:4bb6
    sEND                                               ;; 0e:4bb6 $00

script_038a:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4bb7 $0b $c9 $00 $08
      sUNK_C5 15                                       ;; 0e:4bbb $c5 $0f
      sLOAD_ROOM 4, $01, 9, 12                         ;; 0e:4bbd $f4 $04 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4bc2 $ec
    sENDIF                                             ;; 0e:4bc3
    sEND                                               ;; 0e:4bc3 $00

script_038b:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4bc4 $0b $c9 $00 $08
      sUNK_C5 10                                       ;; 0e:4bc8 $c5 $0a
      sLOAD_ROOM 4, $01, 9, 12                         ;; 0e:4bca $f4 $04 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4bcf $ec
    sENDIF                                             ;; 0e:4bd0
    sEND                                               ;; 0e:4bd0 $00

script_038c:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4bd1 $0b $c9 $00 $08
      sUNK_C5 8                                        ;; 0e:4bd5 $c5 $08
      sLOAD_ROOM 2, $01, 9, 12                         ;; 0e:4bd7 $f4 $02 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4bdc $ec
    sENDIF                                             ;; 0e:4bdd
    sEND                                               ;; 0e:4bdd $00

script_038d:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4bde $0b $c9 $00 $08
      sUNK_C5 3                                        ;; 0e:4be2 $c5 $03
      sLOAD_ROOM 2, $00, 9, 12                         ;; 0e:4be4 $f4 $02 $00 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4be9 $ec
    sENDIF                                             ;; 0e:4bea
    sEND                                               ;; 0e:4bea $00

script_038e:
    sEND                                               ;; 0e:4beb $00

script_038f:
    sEND                                               ;; 0e:4bec $00

script_0390:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4bed $0b $c9 $00 $05
      sLOAD_ROOM 3, $02, 16, 12                        ;; 0e:4bf1 $f4 $03 $02 $10 $0c
    sENDIF                                             ;; 0e:4bf6
    sEND                                               ;; 0e:4bf6 $00

script_0391:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4bf7 $0b $c9 $00 $05
      sLOAD_ROOM 14, $31, 4, 2                         ;; 0e:4bfb $f4 $0e $31 $04 $02
    sENDIF                                             ;; 0e:4c00
    sEND                                               ;; 0e:4c00 $00

script_0392:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4c01 $0b $c9 $00 $05
      sLOAD_ROOM 2, $02, 16, 12                        ;; 0e:4c05 $f4 $02 $02 $10 $0c
    sENDIF                                             ;; 0e:4c0a
    sEND                                               ;; 0e:4c0a $00

script_0393:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4c0b $0b $c9 $00 $05
      sLOAD_ROOM 2, $02, 16, 2                         ;; 0e:4c0f $f4 $02 $02 $10 $02
    sENDIF                                             ;; 0e:4c14
    sEND                                               ;; 0e:4c14 $00

script_0394:
    sEND                                               ;; 0e:4c15 $00

script_0395:
    sEND                                               ;; 0e:4c16 $00

script_0396:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4c17 $0b $c9 $00 $07
      sUNK_C5 54                                       ;; 0e:4c1b $c5 $36
      sLOAD_ROOM 1, $01, 16, 12                        ;; 0e:4c1d $f4 $01 $01 $10 $0c
    sENDIF                                             ;; 0e:4c22
    sEND                                               ;; 0e:4c22 $00

script_0397:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4c23 $0b $c9 $00 $07
      sUNK_C5 55                                       ;; 0e:4c27 $c5 $37
      sLOAD_ROOM 1, $01, 16, 12                        ;; 0e:4c29 $f4 $01 $01 $10 $0c
    sENDIF                                             ;; 0e:4c2e
    sEND                                               ;; 0e:4c2e $00

script_0398:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4c2f $0b $c9 $00 $09
      sLOAD_ROOM 0, $43, 16, 8                         ;; 0e:4c33 $f4 $00 $43 $10 $08
      sCLEAR_ROOM_HISTORY                              ;; 0e:4c38 $ab
      sSET_MUSIC 20                                    ;; 0e:4c39 $f8 $14
      sRUN_ROOM_SCRIPT                                 ;; 0e:4c3b $ec
    sENDIF                                             ;; 0e:4c3c
    sEND                                               ;; 0e:4c3c $00

script_0399:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4c3d $0b $c9 $00 $06
      sLOAD_ROOM 13, $37, 2, 12                        ;; 0e:4c41 $f4 $0d $37 $02 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:4c46 $ec
    sENDIF                                             ;; 0e:4c47
    sEND                                               ;; 0e:4c47 $00

script_039a:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4c48 $0b $c9 $00 $05
      sLOAD_ROOM 15, $25, 12, 6                        ;; 0e:4c4c $f4 $0f $25 $0c $06
    sENDIF                                             ;; 0e:4c51
    sEND                                               ;; 0e:4c51 $00

script_039b:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4c52 $0b $c9 $00 $05
      sLOAD_ROOM 13, $05, 16, 2                        ;; 0e:4c56 $f4 $0d $05 $10 $02
    sENDIF                                             ;; 0e:4c5b
    sEND                                               ;; 0e:4c5b $00

script_039c:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4c5c $0b $c9 $00 $05
      sLOAD_ROOM 13, $07, 16, 12                       ;; 0e:4c60 $f4 $0d $07 $10 $0c
    sENDIF                                             ;; 0e:4c65
    sEND                                               ;; 0e:4c65 $00

script_039d:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4c66 $0b $c9 $00 $06
      sLOAD_ROOM 0, $95, 12, 8                         ;; 0e:4c6a $f4 $00 $95 $0c $08
      sCLEAR_ROOM_HISTORY                              ;; 0e:4c6f $ab
    sENDIF                                             ;; 0e:4c70
    sEND                                               ;; 0e:4c70 $00

script_039e:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4c71 $0b $c9 $00 $06
      sLOAD_ROOM 0, $96, 12, 2                         ;; 0e:4c75 $f4 $00 $96 $0c $02
      sCLEAR_ROOM_HISTORY                              ;; 0e:4c7a $ab
    sENDIF                                             ;; 0e:4c7b
    sEND                                               ;; 0e:4c7b $00

script_039f:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4c7c $0b $c9 $00 $11
      sIF_FLAG wScriptFlags0B.0                        ;; 0e:4c80 $08 $58 $00 $05
        sCALL script_0473                              ;; 0e:4c84 $02 $5a $e2
        sSET_FLAG wScriptFlags0D.1                     ;; 0e:4c87 $da $69
      sENDIF                                           ;; 0e:4c89
      sLOAD_ROOM 12, $06, 16, 2                        ;; 0e:4c89 $f4 $0c $06 $10 $02
      sSET_MUSIC 7                                     ;; 0e:4c8e $f8 $07
      sRUN_ROOM_SCRIPT                                 ;; 0e:4c90 $ec
    sENDIF                                             ;; 0e:4c91
    sEND                                               ;; 0e:4c91 $00

script_03a0:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4c92 $0b $c9 $00 $09
      sLOAD_ROOM 0, $3e, 12, 6                         ;; 0e:4c96 $f4 $00 $3e $0c $06
      sSET_MUSIC 25                                    ;; 0e:4c9b $f8 $19
      sCLEAR_ROOM_HISTORY                              ;; 0e:4c9d $ab
      sRUN_ROOM_SCRIPT                                 ;; 0e:4c9e $ec
    sENDIF                                             ;; 0e:4c9f
    sEND                                               ;; 0e:4c9f $00

script_03a1:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4ca0 $0b $c9 $00 $08
      sLOAD_ROOM 2, $00, 9, 12                         ;; 0e:4ca4 $f4 $02 $00 $09 $0c
      sUNK_C5 1                                        ;; 0e:4ca9 $c5 $01
      sRUN_ROOM_SCRIPT                                 ;; 0e:4cab $ec
    sENDIF                                             ;; 0e:4cac
    sEND                                               ;; 0e:4cac $00

script_03a2:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4cad $0b $c9 $00 $06
      sLOAD_ROOM 12, $07, 16, 2                        ;; 0e:4cb1 $f4 $0c $07 $10 $02
      sRUN_ROOM_SCRIPT                                 ;; 0e:4cb6 $ec
    sENDIF                                             ;; 0e:4cb7
    sEND                                               ;; 0e:4cb7 $00

script_03a3:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4cb8 $0b $c9 $00 $05
      sLOAD_ROOM 12, $06, 16, 12                       ;; 0e:4cbc $f4 $0c $06 $10 $0c
    sENDIF                                             ;; 0e:4cc1
    sEND                                               ;; 0e:4cc1 $00

script_03a4:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4cc2 $0b $c9 $00 $06
      sLOAD_ROOM 14, $35, 16, 1                        ;; 0e:4cc6 $f4 $0e $35 $10 $01
      sRUN_ROOM_SCRIPT                                 ;; 0e:4ccb $ec
    sENDIF                                             ;; 0e:4ccc
    sEND                                               ;; 0e:4ccc $00

script_03a5:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:4ccd $0b $c9 $c1 $00 $05
      sLOAD_ROOM 12, $07, 16, 12                       ;; 0e:4cd2 $f4 $0c $07 $10 $0c
    sENDIF                                             ;; 0e:4cd7
    sEND                                               ;; 0e:4cd7 $00

script_03a6:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4cd8 $0b $c9 $00 $07
      sLOAD_ROOM 0, $69, 14, 2                         ;; 0e:4cdc $f4 $00 $69 $0e $02
      sSET_MUSIC 20                                    ;; 0e:4ce1 $f8 $14
    sENDIF                                             ;; 0e:4ce3
    sEND                                               ;; 0e:4ce3 $00

script_03a7:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4ce4 $0b $c9 $00 $09
      sLOAD_ROOM 0, $d3, 12, 5                         ;; 0e:4ce8 $f4 $00 $d3 $0c $05
      sSET_MUSIC 25                                    ;; 0e:4ced $f8 $19
      sCLEAR_ROOM_HISTORY                              ;; 0e:4cef $ab
      sRUN_ROOM_SCRIPT                                 ;; 0e:4cf0 $ec
    sENDIF                                             ;; 0e:4cf1
    sEND                                               ;; 0e:4cf1 $00

script_03a8:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:4cf2 $0b $c9 $c1 $00 $05
      sLOAD_ROOM 4, $50, 16, 2                         ;; 0e:4cf7 $f4 $04 $50 $10 $02
    sENDIF                                             ;; 0e:4cfc
    sEND                                               ;; 0e:4cfc $00

script_03a9:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4cfd $0b $c9 $00 $05
      sLOAD_ROOM 6, $46, 16, 2                         ;; 0e:4d01 $f4 $06 $46 $10 $02
    sENDIF                                             ;; 0e:4d06
    sEND                                               ;; 0e:4d06 $00

script_03aa:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4d07 $0b $c9 $00 $08
      sUNK_C5 55                                       ;; 0e:4d0b $c5 $37
      sLOAD_ROOM 1, $00, 16, 2                         ;; 0e:4d0d $f4 $01 $00 $10 $02
      sRUN_ROOM_SCRIPT                                 ;; 0e:4d12 $ec
    sENDIF                                             ;; 0e:4d13
    sEND                                               ;; 0e:4d13 $00

script_03ab:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4d14 $0b $c9 $00 $05
      sLOAD_ROOM 6, $72, 9, 7                          ;; 0e:4d18 $f4 $06 $72 $09 $07
    sENDIF                                             ;; 0e:4d1d
    sEND                                               ;; 0e:4d1d $00

script_03ac:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4d1e $0b $c9 $00 $05
      sLOAD_ROOM 6, $60, 9, 7                          ;; 0e:4d22 $f4 $06 $60 $09 $07
    sENDIF                                             ;; 0e:4d27
    sEND                                               ;; 0e:4d27 $00

script_03ad:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4d28 $0b $c9 $00 $05
      sLOAD_ROOM 5, $71, 9, 7                          ;; 0e:4d2c $f4 $05 $71 $09 $07
    sENDIF                                             ;; 0e:4d31
    sEND                                               ;; 0e:4d31 $00

script_03ae:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4d32 $0b $c9 $00 $05
      sLOAD_ROOM 6, $41, 9, 7                          ;; 0e:4d36 $f4 $06 $41 $09 $07
    sENDIF                                             ;; 0e:4d3b
    sEND                                               ;; 0e:4d3b $00

script_03af:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4d3c $0b $c9 $00 $05
      sLOAD_ROOM 5, $74, 9, 7                          ;; 0e:4d40 $f4 $05 $74 $09 $07
    sENDIF                                             ;; 0e:4d45
    sEND                                               ;; 0e:4d45 $00

script_03b0:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4d46 $0b $c9 $00 $08
      sUNK_C5 54                                       ;; 0e:4d4a $c5 $36
      sLOAD_ROOM 1, $00, 16, 2                         ;; 0e:4d4c $f4 $01 $00 $10 $02
      sRUN_ROOM_SCRIPT                                 ;; 0e:4d51 $ec
    sENDIF                                             ;; 0e:4d52
    sEND                                               ;; 0e:4d52 $00

script_03b1:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4d53 $0b $c9 $00 $05
      sLOAD_ROOM 3, $45, 9, 7                          ;; 0e:4d57 $f4 $03 $45 $09 $07
    sENDIF                                             ;; 0e:4d5c
    sEND                                               ;; 0e:4d5c $00

script_03b2:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4d5d $0b $c9 $00 $05
      sLOAD_ROOM 3, $53, 9, 7                          ;; 0e:4d61 $f4 $03 $53 $09 $07
    sENDIF                                             ;; 0e:4d66
    sEND                                               ;; 0e:4d66 $00

script_03b3:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4d67 $0b $c9 $00 $05
      sLOAD_ROOM 6, $00, 9, 7                          ;; 0e:4d6b $f4 $06 $00 $09 $07
    sENDIF                                             ;; 0e:4d70
    sEND                                               ;; 0e:4d70 $00

script_03b4:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4d71 $0b $c9 $00 $05
      sLOAD_ROOM 6, $12, 9, 7                          ;; 0e:4d75 $f4 $06 $12 $09 $07
    sENDIF                                             ;; 0e:4d7a
    sEND                                               ;; 0e:4d7a $00

script_03b5:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4d7b $0b $c9 $00 $05
      sLOAD_ROOM 2, $27, 9, 7                          ;; 0e:4d7f $f4 $02 $27 $09 $07
    sENDIF                                             ;; 0e:4d84
    sEND                                               ;; 0e:4d84 $00

script_03b6:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4d85 $0b $c9 $00 $05
      sLOAD_ROOM 13, $43, 16, 2                        ;; 0e:4d89 $f4 $0d $43 $10 $02
    sENDIF                                             ;; 0e:4d8e
    sEND                                               ;; 0e:4d8e $00

script_03b7:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4d8f $0b $c9 $00 $05
      sLOAD_ROOM 12, $43, 16, 2                        ;; 0e:4d93 $f4 $0c $43 $10 $02
    sENDIF                                             ;; 0e:4d98
    sEND                                               ;; 0e:4d98 $00

script_03b8:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:4d99 $0b $c9 $c1 $00 $09
      sLOAD_ROOM 13, $73, 16, 12                       ;; 0e:4d9e $f4 $0d $73 $10 $0c
      sSET_ROOM_TILE $02, 8, 6                         ;; 0e:4da3 $b0 $02 $08 $06
    sENDIF                                             ;; 0e:4da7
    sEND                                               ;; 0e:4da7 $00

script_03b9:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4da8 $0b $c9 $00 $05
      sLOAD_ROOM 13, $54, 16, 2                        ;; 0e:4dac $f4 $0d $54 $10 $02
    sENDIF                                             ;; 0e:4db1
    sEND                                               ;; 0e:4db1 $00

script_03ba:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4db2 $0b $c9 $00 $05
      sLOAD_ROOM 13, $74, 16, 2                        ;; 0e:4db6 $f4 $0d $74 $10 $02
    sENDIF                                             ;; 0e:4dbb
    sEND                                               ;; 0e:4dbb $00

script_03bb:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4dbc $0b $c9 $00 $05
      sLOAD_ROOM 13, $50, 16, 2                        ;; 0e:4dc0 $f4 $0d $50 $10 $02
    sENDIF                                             ;; 0e:4dc5
    sEND                                               ;; 0e:4dc5 $00

script_03bc:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:4dc6 $0b $c9 $c1 $00 $08
      sUNK_C5 53                                       ;; 0e:4dcb $c5 $35
      sLOAD_ROOM 1, $00, 16, 2                         ;; 0e:4dcd $f4 $01 $00 $10 $02
      sRUN_ROOM_SCRIPT                                 ;; 0e:4dd2 $ec
    sENDIF                                             ;; 0e:4dd3
    sEND                                               ;; 0e:4dd3 $00

script_03bd:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:4dd4 $0b $c9 $c1 $00 $05
      sLOAD_ROOM 15, $73, 8, 8                         ;; 0e:4dd9 $f4 $0f $73 $08 $08
    sENDIF                                             ;; 0e:4dde
    sEND                                               ;; 0e:4dde $00

script_03be:
    sEND                                               ;; 0e:4ddf $00

script_03bf:
    sEND                                               ;; 0e:4de0 $00

script_03c0:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4de1 $0b $c9 $00 $05
      sLOAD_ROOM 9, $40, 16, 2                         ;; 0e:4de5 $f4 $09 $40 $10 $02
    sENDIF                                             ;; 0e:4dea
    sEND                                               ;; 0e:4dea $00

script_03c1:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4deb $0b $c9 $00 $05
      sLOAD_ROOM 12, $46, 16, 12                       ;; 0e:4def $f4 $0c $46 $10 $0c
    sENDIF                                             ;; 0e:4df4
    sEND                                               ;; 0e:4df4 $00

script_03c2:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4df5 $0b $c9 $00 $05
      sLOAD_ROOM 11, $46, 16, 12                       ;; 0e:4df9 $f4 $0b $46 $10 $0c
    sENDIF                                             ;; 0e:4dfe
    sEND                                               ;; 0e:4dfe $00

script_03c3:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:4dff $0b $c9 $c1 $00 $05
      sLOAD_ROOM 11, $32, 16, 2                        ;; 0e:4e04 $f4 $0b $32 $10 $02
    sENDIF                                             ;; 0e:4e09
    sEND                                               ;; 0e:4e09 $00

script_03c4:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4e0a $0b $c9 $00 $09
      sLOAD_ROOM 0, $0e, 14, 4                         ;; 0e:4e0e $f4 $00 $0e $0e $04
      sCLEAR_ROOM_HISTORY                              ;; 0e:4e13 $ab
      sSET_MUSIC 25                                    ;; 0e:4e14 $f8 $19
      sRUN_ROOM_SCRIPT                                 ;; 0e:4e16 $ec
    sENDIF                                             ;; 0e:4e17
    sEND                                               ;; 0e:4e17 $00

script_03c5:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4e18 $0b $c9 $00 $05
      sLOAD_ROOM 8, $47, 16, 2                         ;; 0e:4e1c $f4 $08 $47 $10 $02
    sENDIF                                             ;; 0e:4e21
    sEND                                               ;; 0e:4e21 $00

script_03c6:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:4e22 $0b $c9 $c1 $00 $95
      sLOAD_ROOM 4, $10, 16, 2                         ;; 0e:4e27 $f4 $04 $10 $10 $02
      sIF_FLAG wScriptFlags05.4, !wScriptFlags03.7     ;; 0e:4e2c $08 $2c $9f $00 $8b
        sSET_PLAYER_DIRECTION_DOWN                     ;; 0e:4e31 $85
        sLOOP 4, 2                                     ;; 0e:4e32 $03 $04 $02
          sPLAYER_STEP_FORWARD                         ;; 0e:4e35 $80
        sEND                                           ;; 0e:4e36 $00
        sDELAY 60                                      ;; 0e:4e37 $f0 $3c
        sSET_PLAYER_DIRECTION_RIGHT                    ;; 0e:4e39 $86
        sDELAY 60                                      ;; 0e:4e3a $f0 $3c
        sSET_PLAYER_DIRECTION_LEFT                     ;; 0e:4e3c $87
        sDELAY 60                                      ;; 0e:4e3d $f0 $3c
        sSET_PLAYER_DIRECTION_DOWN                     ;; 0e:4e3f $85
        sMSG                                           ;; 0e:4e40 $04
          db "<10><GIRL>? __ <GIRL>?!\nWhere could she\nbe_? _", $00 ;; 0e:4e41
        sDELAY 60                                      ;; 0e:4e5c $f0 $3c
        sMSG                                           ;; 0e:4e5e $04
          db " Julius_ ?!<12>"
          db "<1b>Where is he___?\n  !!  Must be at\nthe Waterfalls!!<12>"
          db "<11>", $00 ;; 0e:4e5f
        sLOAD_ROOM 1, $46, 7, 9                        ;; 0e:4e8d $f4 $01 $46 $07 $09
        sCLEAR_ROOM_HISTORY                            ;; 0e:4e92 $ab
        sSET_NPC_TYPES 40                              ;; 0e:4e93 $fc $28
        sSPAWN_NPC 0                                   ;; 0e:4e95 $fd $00
        sSET_NPC_1_DIRECTION_LEFT                      ;; 0e:4e97 $17
        sLOOP 4, 2                                     ;; 0e:4e98 $03 $04 $02
          sNPC_1_STEP_FORWARD                          ;; 0e:4e9b $10
        sEND                                           ;; 0e:4e9c $00
        sMSG                                           ;; 0e:4e9d $04
          db "<10><BOY>:<GIRL>!!<12>"
          db "<11>", $00 ;; 0e:4e9e
        sSET_NPC_1_DIRECTION_UP                        ;; 0e:4ea7 $14
        sDELAY 60                                      ;; 0e:4ea8 $f0 $3c
        sSET_NPC_1_DIRECTION_LEFT                      ;; 0e:4eaa $17
        sLOOP 6, 2                                     ;; 0e:4eab $03 $06 $02
          sNPC_1_STEP_FORWARD                          ;; 0e:4eae $10
        sEND                                           ;; 0e:4eaf $00
        sDEL_NPC_1                                     ;; 0e:4eb0 $18
        sMSG                                           ;; 0e:4eb1 $04
          db "<10><BOY>:__ <GIRL>?<12>"
          db "<11>", $00 ;; 0e:4eb2
      sENDIF                                           ;; 0e:4ebc
    sENDIF                                             ;; 0e:4ebc
    sEND                                               ;; 0e:4ebc $00

script_03c7:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4ebd $0b $c9 $00 $05
      sLOAD_ROOM 10, $62, 16, 2                        ;; 0e:4ec1 $f4 $0a $62 $10 $02
    sENDIF                                             ;; 0e:4ec6
    sEND                                               ;; 0e:4ec6 $00

script_03c8:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:4ec7 $0b $c9 $c1 $00 $05
      sLOAD_ROOM 8, $63, 10, 6                         ;; 0e:4ecc $f4 $08 $63 $0a $06
    sENDIF                                             ;; 0e:4ed1
    sEND                                               ;; 0e:4ed1 $00

script_03c9:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:4ed2 $0b $c9 $c1 $00 $0b
      sLOAD_ROOM 2, $22, 16, 2                         ;; 0e:4ed7 $f4 $02 $22 $10 $02
      sSET_NPC_TYPES 7                                 ;; 0e:4edc $fc $07
      sSPAWN_NPC 0                                     ;; 0e:4ede $fd $00
      sSPAWN_NPC 2                                     ;; 0e:4ee0 $fd $02
    sENDIF                                             ;; 0e:4ee2
    sEND                                               ;; 0e:4ee2 $00

script_03ca:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:4ee3 $0b $c9 $c1 $00 $05
      sLOAD_ROOM 2, $62, 16, 2                         ;; 0e:4ee8 $f4 $02 $62 $10 $02
    sENDIF                                             ;; 0e:4eed
    sEND                                               ;; 0e:4eed $00

script_03cb:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4eee $0b $c9 $00 $05
      sLOAD_ROOM 13, $40, 16, 2                        ;; 0e:4ef2 $f4 $0d $40 $10 $02
    sENDIF                                             ;; 0e:4ef7
    sEND                                               ;; 0e:4ef7 $00

script_03cc:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4ef8 $0b $c9 $00 $05
      sLOAD_ROOM 11, $20, 16, 2                        ;; 0e:4efc $f4 $0b $20 $10 $02
    sENDIF                                             ;; 0e:4f01
    sEND                                               ;; 0e:4f01 $00

script_03cd:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4f02 $0b $c9 $00 $05
      sLOAD_ROOM 10, $20, 16, 2                        ;; 0e:4f06 $f4 $0a $20 $10 $02
    sENDIF                                             ;; 0e:4f0b
    sEND                                               ;; 0e:4f0b $00

script_03ce:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4f0c $0b $c9 $00 $05
      sLOAD_ROOM 10, $14, 16, 2                        ;; 0e:4f10 $f4 $0a $14 $10 $02
    sENDIF                                             ;; 0e:4f15
    sEND                                               ;; 0e:4f15 $00

script_03cf:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:4f16 $0b $c9 $00 $05
      sLOAD_ROOM 10, $53, 16, 2                        ;; 0e:4f1a $f4 $0a $53 $10 $02
    sENDIF                                             ;; 0e:4f1f
    sEND                                               ;; 0e:4f1f $00

script_03d0:
    sSET_NPC_TYPES 21                                  ;; 0e:4f20 $fc $15
    sSPAWN_NPC 1                                       ;; 0e:4f22 $fd $01
    sEND                                               ;; 0e:4f24 $00

script_03d1:
    sIF_FLAG wScriptFlags.2                            ;; 0e:4f25 $08 $02 $00 $03
      ; Add a sound if the player is looped back to the starting room in the Mt. Rocks cave.
      sSFX 3
      sSET_NEXT_ROOM $00, $03                          ;; 0e:4f29 $ef $00 $03
    sENDIF                                             ;; 0e:4f2c
    sEND                                               ;; 0e:4f2c $00

script_03d2:
    sEND                                               ;; 0e:4f2d $00

script_03d3:
    sCLEAR_FLAG wScriptFlags0F.0                       ;; 0e:4f2e $db $78
    sCLEAR_FLAG wScriptFlags0F.1                       ;; 0e:4f30 $db $79
    sCLEAR_FLAG wScriptFlags0F.2                       ;; 0e:4f32 $db $7a
    sCLEAR_FLAG wScriptFlags0F.3                       ;; 0e:4f34 $db $7b
    sEND                                               ;; 0e:4f36 $00

script_03d4:
    sEND                                               ;; 0e:4f37 $00

script_03d5:
    sEND                                               ;; 0e:4f38 $00

script_03d6:
    sIF_FLAG !wScriptFlags05.0                         ;; 0e:4f39 $08 $a8 $00 $31
      sPLAYER_STEP_FORWARD                             ;; 0e:4f3d $80
      sPLAYER_STEP_FORWARD                             ;; 0e:4f3e $80
      sFADE_TO_BLACK                                   ;; 0e:4f3f $bd
      sIF_FLAG wScriptFlags0D.7                        ;; 0e:4f40 $08 $6f $00 $03
        sCALL script_0470                              ;; 0e:4f44 $02 $5a $3f
      sENDIF                                           ;; 0e:4f47
      sLOAD_ROOM_INSTANT 15, $55, 20, 0                ;; 0e:4f47 $f3 $0f $55 $14 $00
      sFADE_TO_NORMAL                                  ;; 0e:4f4c $bc
      sMSG                                             ;; 0e:4f4d $04
        db "<10> AAARGH!!\n Poison gas!!<12>"
        db "<11>", $00 ;; 0e:4f4e
      sFADE_TO_BLACK                                   ;; 0e:4f65 $bd
      sLOAD_ROOM_INSTANT 0, $28, 11, 6                 ;; 0e:4f66 $f3 $00 $28 $0b $06
      sFADE_TO_NORMAL                                  ;; 0e:4f6b $bc
      sPLAYER_GIVE_STATUS 1                            ;; 0e:4f6c $c4 $01
    sENDIF                                             ;; 0e:4f6e
    sEND                                               ;; 0e:4f6e $00

script_03d7:
    sEND                                               ;; 0e:4f6f $00

script_03d8:
    sEND                                               ;; 0e:4f70 $00

script_03d9:
    sIF_FLAG !wScriptFlags01.3                         ;; 0e:4f71 $08 $8b $00 $14
      sSET_ROOM_TILE $0f, 3, 2                         ;; 0e:4f75 $b0 $0f $03 $02
      sSET_ROOM_TILE $0f, 4, 2                         ;; 0e:4f79 $b0 $0f $04 $02
      sSET_ROOM_TILE $1f, 3, 3                         ;; 0e:4f7d $b0 $1f $03 $03
      sSET_ROOM_TILE $1f, 4, 3                         ;; 0e:4f81 $b0 $1f $04 $03
      sDELAY 5                                         ;; 0e:4f85 $f0 $05
      sSFX 16                                          ;; 0e:4f87 $f9 $10
    sENDIF                                             ;; 0e:4f89
    sEND                                               ;; 0e:4f89 $00

script_03da:
    sEND                                               ;; 0e:4f8a $00

script_03db:
    sEND                                               ;; 0e:4f8b $00

script_03dc:
    sSET_NPC_TYPES 21                                  ;; 0e:4f8c $fc $15
    sIF_FLAG !wScriptFlags.1
      sSPAWN_NPC 2
    sENDIF
    sSPAWN_NPC 0                                       ;; 0e:4f90 $fd $00
    sEND                                               ;; 0e:4f92 $00

script_03dd:
    sEND                                               ;; 0e:4f93 $00

script_03de:
    sEND                                               ;; 0e:4f94 $00

script_03df:
    sSET_NPC_TYPES 7                                   ;; 0e:4f95 $fc $07
    sIF_FLAG !wScriptFlags.4
      sSPAWN_NPC 2
    sENDIF
    sSPAWN_NPC 0                                       ;; 0e:4f99 $fd $00
    sEND                                               ;; 0e:4f9b $00

script_03e0:
    sEND                                               ;; 0e:4f9c $00

script_03e1:
    sEND                                               ;; 0e:4f9d $00

script_03e2:
    sSET_NPC_TYPES 32                                  ;; 0e:4f9e $fc $20
    sIF_FLAG !wScriptFlags.2
      sSPAWN_NPC 0
    sENDIF
    sSPAWN_NPC 2                                       ;; 0e:4fa2 $fd $02
    sEND                                               ;; 0e:4fa4 $00

script_03e3:
    sEND                                               ;; 0e:4fa5 $00

script_03e4:
    sEND                                               ;; 0e:4fa6 $00

script_03e5:
    sSET_NPC_TYPES 99                                  ;; 0e:4fa7 $fc $63
    sSPAWN_NPC 0                                       ;; 0e:4fa9 $fd $00
    sIF_FLAG wScriptFlags0D.7
      sCALL script_0470
    sENDIF
    sEND                                               ;; 0e:4fab $00

script_03e6:
    sEND                                               ;; 0e:4fac $00

script_03e7:
    sEND                                               ;; 0e:4fad $00

script_03e8:
    sIF_FLAG wScriptFlags04.2                          ;; 0e:4fae $08 $22 $00 $fb
      sIF_FLAG !wScriptFlags02.2                       ;; 0e:4fb2 $08 $92 $00 $f4
        sSET_MUSIC 0                                   ;; 0e:4fb6 $f8 $00
        sIF_FLAG wScriptFlags0D.7                      ;; 0e:4fb8 $08 $6f $00 $03
          sSET_PLAYER_NORMAL_SPRITE
          sSFX 7
          sDELAY 7
          sSFX 7
          sCLEAR_FLAG wScriptFlags0D.7
        sENDIF                                         ;; 0e:4fbf
        sPLAYER_STEP_FORWARD                           ;; 0e:4fbf $80
        sPLAYER_STEP_FORWARD                           ;; 0e:4fc0 $80
        sDELAY 40                                      ;; 0e:4fc1 $f0 $28
; Fill tiles just outside the screen before the shake effect.
; Because you must scroll in from a similar screen only part of one side needs to be done.
        sSET_ROOM_TILE $41, 15, 0
        sSET_ROOM_TILE $51, 15, 1
        sSET_ROOM_TILE $39, 15, 6
        sSET_ROOM_TILE $41, 15, 7
        sSHAKE_SCREEN                                  ;; 0e:4fc3 $fb
        sFLASH_SCREEN                                  ;; 0e:4fc4 $bf
        sSFX 37                                        ;; 0e:4fc5 $f9 $25
        sFLASH_SCREEN                                  ;; 0e:4fc7 $bf
        sFLASH_SCREEN                                  ;; 0e:4fc8 $bf
        sCREATE_EFFECT $10, $06, $04                   ;; 0e:4fc9 $ba $10 $06 $04
        sCREATE_EFFECT $10, $0a, $03                   ;; 0e:4fcd $ba $10 $0a $03
        sCREATE_EFFECT $10, $08, $05                   ;; 0e:4fd1 $ba $10 $08 $05
        sCREATE_EFFECT $10, $0c, $04                   ;; 0e:4fd5 $ba $10 $0c $04
        sSFX 37                                        ;; 0e:4fd9 $f9 $25
        sSET_ROOM_TILE $6c, 3, 2                       ;; 0e:4fdb $b0 $6c $03 $02
        sSET_ROOM_TILE $66, 4, 2                       ;; 0e:4fdf $b0 $66 $04 $02
        sSET_ROOM_TILE $6c, 5, 2                       ;; 0e:4fe3 $b0 $6c $05 $02
        sSET_ROOM_TILE $66, 6, 2                       ;; 0e:4fe7 $b0 $66 $06 $02
        sSET_ROOM_TILE $6c, 7, 2                       ;; 0e:4feb $b0 $6c $07 $02
        sDELAY 5                                       ;; 0e:4fef $f0 $05
        sFLASH_SCREEN                                  ;; 0e:4ff1 $bf
        sSFX 37                                        ;; 0e:4ff2 $f9 $25
        sSET_ROOM_TILE $6c, 3, 1                       ;; 0e:4ff4 $b0 $6c $03 $01
        sSET_ROOM_TILE $66, 4, 1                       ;; 0e:4ff8 $b0 $66 $04 $01
        sSET_ROOM_TILE $6c, 5, 1                       ;; 0e:4ffc $b0 $6c $05 $01
        sSET_ROOM_TILE $66, 6, 1                       ;; 0e:5000 $b0 $66 $06 $01
        sSET_ROOM_TILE $6c, 7, 1                       ;; 0e:5004 $b0 $6c $07 $01
;        sSET_ROOM_TILE $6c, 3, 2                       ;; 0e:5008 $b0 $6c $03 $02
        sSET_ROOM_TILE $65, 4, 2                       ;; 0e:500c $b0 $65 $04 $02
        sSET_ROOM_TILE $65, 5, 2                       ;; 0e:5010 $b0 $65 $05 $02
        sSET_ROOM_TILE $65, 6, 2                       ;; 0e:5014 $b0 $65 $06 $02
        sSET_ROOM_TILE $6c, 7, 2                       ;; 0e:5018 $b0 $6c $07 $02
        sDELAY 5                                       ;; 0e:501c $f0 $05
        sFLASH_SCREEN                                  ;; 0e:501e $bf
        sSFX 37                                        ;; 0e:501f $f9 $25
        sSET_ROOM_TILE $6c, 3, 0                       ;; 0e:5021 $b0 $6c $03 $00
        sSET_ROOM_TILE $80, 4, 0                       ;; 0e:5025 $b0 $66 $04 $00
        sSET_ROOM_TILE $6c, 5, 0                       ;; 0e:5029 $b0 $6c $05 $00
        sSET_ROOM_TILE $80, 6, 0                       ;; 0e:502d $b0 $66 $06 $00
        sSET_ROOM_TILE $6c, 7, 0                       ;; 0e:5031 $b0 $6c $07 $00
;        sSET_ROOM_TILE $6c, 3, 1                       ;; 0e:5035 $b0 $6c $03 $01
        sSET_ROOM_TILE $65, 4, 1                       ;; 0e:5039 $b0 $65 $04 $01
        sSET_ROOM_TILE $65, 5, 1                       ;; 0e:503d $b0 $65 $05 $01
        sSET_ROOM_TILE $65, 6, 1                       ;; 0e:5041 $b0 $65 $06 $01
;        sSET_ROOM_TILE $6c, 7, 1                       ;; 0e:5045 $b0 $6c $07 $01
;        sSET_ROOM_TILE $6c, 3, 2                       ;; 0e:5049 $b0 $6c $03 $02
        sSET_ROOM_TILE $72, 4, 2                       ;; 0e:504d $b0 $72 $04 $02
        sSET_ROOM_TILE $6c, 5, 2                       ;; 0e:5051 $b0 $6c $05 $02
        sSET_ROOM_TILE $72, 6, 2                       ;; 0e:5055 $b0 $72 $06 $02
        sSET_ROOM_TILE $6c, 7, 2                       ;; 0e:5059 $b0 $6c $07 $02
        sDELAY 5                                       ;; 0e:505d $f0 $05
        sFLASH_SCREEN                                  ;; 0e:505f $bf
        sSFX 37                                        ;; 0e:5060 $f9 $25
        sSET_ROOM_TILE $6c, 3, 0                       ;; 0e:5062 $b0 $6c $03 $00
        sSET_ROOM_TILE $65, 4, 0                       ;; 0e:5066 $b0 $65 $04 $00
        sSET_ROOM_TILE $65, 5, 0                       ;; 0e:506a $b0 $65 $05 $00
        sSET_ROOM_TILE $65, 6, 0                       ;; 0e:506e $b0 $65 $06 $00
        sSET_ROOM_TILE $6c, 7, 0                       ;; 0e:5072 $b0 $6c $07 $00
;        sSET_ROOM_TILE $6c, 3, 1                       ;; 0e:5076 $b0 $6c $03 $01
        sSET_ROOM_TILE $72, 4, 1                       ;; 0e:507a $b0 $72 $04 $01
        sSET_ROOM_TILE $6c, 5, 1                       ;; 0e:507e $b0 $6c $05 $01
        sSET_ROOM_TILE $72, 6, 1                       ;; 0e:5082 $b0 $72 $06 $01
;        sSET_ROOM_TILE $6c, 7, 1                       ;; 0e:5086 $b0 $6c $07 $01
        sSET_ROOM_TILE $09, 3, 2                       ;; 0e:508a $b0 $09 $03 $02
        sSET_ROOM_TILE $55, 4, 2                       ;; 0e:508e $b0 $55 $04 $02
        sSET_ROOM_TILE $55, 5, 2                       ;; 0e:5092 $b0 $55 $05 $02
        sSET_ROOM_TILE $55, 6, 2                       ;; 0e:5096 $b0 $55 $06 $02
        sSET_ROOM_TILE $0a, 7, 2                       ;; 0e:509a $b0 $0a $07 $02
        sDELAY 5                                       ;; 0e:509e $f0 $05
        sFLASH_SCREEN                                  ;; 0e:50a0 $bf
        sSFX 37                                        ;; 0e:50a1 $f9 $25
        sCALL script_0544                              ;; 0e:50a3 $02 $77 $b1
        sSET_FLAG wScriptFlags02.2                     ;; 0e:50a6 $da $12
      sELSE                                            ;; 0e:50a8 $01 $03
        sCALL script_0547                              ;; 0e:50aa $02 $79 $86
      sENDIF                                           ;; 0e:50ad
    sENDIF                                             ;; 0e:50ad
    sIF_FLAG wScriptFlags0B.5                          ;; 0e:50ad $08 $5d $00 $03
      sCALL script_0475                                ;; 0e:50b1 $02 $5b $01
    sENDIF                                             ;; 0e:50b4
    sEND                                               ;; 0e:50b4 $00

script_03e9:
    sIF_FLAG !wScriptFlags0D.7                         ;; 0e:50b5 $08 $ef $00 $02
      sSET_MUSIC 25                                    ;; 0e:50b9 $f8 $19
    sENDIF                                             ;; 0e:50bb
    sEND                                               ;; 0e:50bb $00

script_03ea:
    sEND                                               ;; 0e:50bc $00

script_03eb:
    sSET_NPC_TYPES 95                                  ;; 0e:50bd $fc $5f
    sSPAWN_NPC 0                                       ;; 0e:50bf $fd $00
    sCLEAR_FLAG wScriptFlags0F.0
    sCLEAR_FLAG wScriptFlags0F.1
    sEND                                               ;; 0e:50c1 $00

script_03ec:
    sEND                                               ;; 0e:50c2 $00

script_03ed:
    sEND                                               ;; 0e:50c3 $00

script_03ee:
    sEND                                               ;; 0e:50c4 $00

script_03ef:
    sIF_FLAG wScriptFlags.1                            ;; 0e:50c5 $08 $01 $00 $03
      ; Add a sound if the player is looped back to the starting room in the Mt. Rocks cave.
      sSFX 3
      sSET_NEXT_ROOM $00, $03                          ;; 0e:50c9 $ef $00 $03
    sENDIF                                             ;; 0e:50cc
    sIF_FLAG wScriptFlags.2                            ;; 0e:50cc $08 $02 $00 $03
      ; Add a sound if the player is looped back to the starting room in the Mt. Rocks cave.
      sSFX 3
      sSET_NEXT_ROOM $00, $03                          ;; 0e:50d0 $ef $00 $03
    sENDIF                                             ;; 0e:50d3
    sEND                                               ;; 0e:50d3 $00

script_03f0:
    sEND                                               ;; 0e:50d4 $00

script_03f1:
    sSET_CHEST_OPEN_SCRIPT1 script_03f3                ;; 0e:50d5 $c9 $03 $f3
    sEND                                               ;; 0e:50d8 $00

script_03f2:
    sEND                                               ;; 0e:50d9 $00

script_03f3:
    sSET_ROOM_TILE $65, 5, 3                           ;; 0e:50da $b0 $65 $05 $03
    sSET_ROOM_TILE $73, 7, 4                           ;; 0e:50de $b0 $73 $07 $04
    sEND                                               ;; 0e:50e2 $00

script_03f4:
    sSET_CHEST_OPEN_SCRIPT1 script_03f6                ;; 0e:50e3 $c9 $03 $f6
    sEND                                               ;; 0e:50e6 $00

script_03f5:
    sEND                                               ;; 0e:50e7 $00

script_03f6:
    sSET_ROOM_TILE $70, 6, 3                           ;; 0e:50e8 $b0 $70 $06 $03
    sSET_ROOM_TILE $73, 3, 2                           ;; 0e:50ec $b0 $73 $03 $02
    sEND                                               ;; 0e:50f0 $00

script_03f7:
    sSET_CHEST_OPEN_SCRIPT1 script_03f9                ;; 0e:50f1 $c9 $03 $f9
    sEND                                               ;; 0e:50f4 $00

script_03f8:
    sEND                                               ;; 0e:50f5 $00

script_03f9:
    sSET_ROOM_TILE $4b, 6, 5                           ;; 0e:50f6 $b0 $4b $06 $05
    sSET_ROOM_TILE $73, 7, 2                           ;; 0e:50fa $b0 $73 $07 $02
    sEND                                               ;; 0e:50fe $00

script_03fa:
    sIF_FLAG wScriptFlags02.6                          ;; 0e:50ff $08 $16 $00 $0c
      sSET_ROOM_TILE $5c, 6, 7                         ;; 0e:5103 $b0 $5c $06 $07
      sSET_ROOM_TILE $5c, 6, 6                         ;; 0e:5107 $b0 $5c $06 $06
      sSET_ROOM_TILE $5c, 6, 5                         ;; 0e:510b $b0 $5c $06 $05
    sENDIF                                             ;; 0e:510f
    sEND                                               ;; 0e:510f $00

script_03fb:
    sEND                                               ;; 0e:5110 $00

script_03fc:
    sEND                                               ;; 0e:5111 $00

script_03fd:
    sSET_NPC_TYPES 95                                  ;; 0e:5112 $fc $5f
    sSPAWN_NPC 2                                       ;; 0e:5114 $fd $02
    sEND                                               ;; 0e:5116 $00

script_03fe:
    sEND                                               ;; 0e:5117 $00

script_03ff:
    sEND                                               ;; 0e:5118 $00

script_0400:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5119 $0b $c9 $00 $15
      sSET_PLAYER_POSITION 8, 3                        ;; 0e:511d $8a $08 $03
      sSET_PLAYER_DIRECTION_RIGHT                      ;; 0e:5120 $86
      sDELAY 10                                        ;; 0e:5121 $f0 $0a
      sFADE_TO_BLACK                                   ;; 0e:5123 $bd
      sDELAY 40                                        ;; 0e:5124 $f0 $28
      sIF_FLAG !wScriptFlags01.5                       ;; 0e:5126 $08 $8d $00 $05
        sCALL script_0548                              ;; 0e:512a $02 $79 $c3
      sELSE                                            ;; 0e:512d $01 $01
        sFADE_TO_NORMAL                                ;; 0e:512f $bc
      sENDIF                                           ;; 0e:5130
      sFULL_HP                                         ;; 0e:5130 $c0
      sFULL_MANA                                       ;; 0e:5131 $c1
    sENDIF                                             ;; 0e:5132
    sEND                                               ;; 0e:5132 $00

script_0401:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5133 $0b $c9 $00 $b6
      sSFX 12                                          ;; 0e:5137 $f9 $0c
      sSET_PLAYER_DIRECTION_LEFT                       ;; 0e:5139 $87
      sSET_FAST_MOVEMENT                               ;; 0e:513a $88
      sPLAYER_JUMP 112                                 ;; 0e:513b $8b $70
      sCLEAR_FAST_MOVEMENT                             ;; 0e:513d $89
      sSFX 9                                           ;; 0e:513e $f9 $09
      sLOOP 6, 5                                       ;; 0e:5140 $03 $06 $05
        sSET_PLAYER_DIRECTION_UP                       ;; 0e:5143 $84
        sSET_PLAYER_DIRECTION_RIGHT                    ;; 0e:5144 $86
        sSET_PLAYER_DIRECTION_DOWN                     ;; 0e:5145 $85
        sSET_PLAYER_DIRECTION_LEFT                     ;; 0e:5146 $87
      sEND                                             ;; 0e:5147 $00
      sSET_PLAYER_POSITION 20, 0                       ;; 0e:5148 $8a $14 $00
      sDELAY 60                                        ;; 0e:514b $f0 $3c
      sFADE_TO_BLACK                                   ;; 0e:514d $bd
      sSET_PLAYER_LAYDOWN_SPRITE                       ;; 0e:514e $a6
      sLOAD_ROOM_INSTANT 11, $17, 8, 10                ;; 0e:514f $f3 $0b $17 $08 $0a
      sIF_FLAG !wScriptFlags04.6                       ;; 0e:5154 $08 $a6 $00 $8e
        sSET_NPC_TYPES 48                              ;; 0e:5158 $fc $30
        sSPAWN_NPC 0                                   ;; 0e:515a $fd $00
        sDELAY 60                                      ;; 0e:515c $f0 $3c
        sFADE_TO_NORMAL                                ;; 0e:515e $bc
        sDELAY 60                                      ;; 0e:515f $f0 $3c
        sMSG                                           ;; 0e:5161 $04
          db "<10>Watts:Wow!?\n Are you okay?\n<BOY>:_ Ouch!_<12>"
          db "<11>", $00 ;; 0e:5162
        sNPC_1_STEP_FORWARD                            ;; 0e:5189 $10
        sNPC_1_STEP_FORWARD                            ;; 0e:518a $10
        sSET_NPC_1_DIRECTION_LEFT                      ;; 0e:518b $17
        sLOOP 4, 2                                     ;; 0e:518c $03 $04 $02
          sNPC_1_STEP_FORWARD                          ;; 0e:518f $10
        sEND                                           ;; 0e:5190 $00
        sDELAY 30                                      ;; 0e:5191 $f0 $1e
        sSET_PLAYER_NORMAL_SPRITE                      ;; 0e:5193 $a4
        sSET_PLAYER_DIRECTION_RIGHT                    ;; 0e:5194 $86
        sDELAY 60                                      ;; 0e:5195 $f0 $3c
        sMSG                                           ;; 0e:5197 $04
          db "<10><BOY>:Thanks.\n Do you know this\n mine well?<12>"
          db "<1b>Watts:Looking for\n mithril? Come\n with me, then!<12>"
          db "<11>", $00 ;; 0e:5198
        sSET_NPC_TYPES 78                              ;; 0e:51db $fc $4e
        sDEL_NPC_1                                     ;; 0e:51dd $18
        sSPAWN_NPC 2                                   ;; 0e:51de $fd $02
        sGIVE_FOLLOWER 3                               ;; 0e:51e0 $9c $03
        sSET_FLAG wScriptFlags0A.3                     ;; 0e:51e2 $da $53
      sELSE                                            ;; 0e:51e4 $01 $07
        sFADE_TO_NORMAL                                ;; 0e:51e6 $bc
        sDELAY 30                                      ;; 0e:51e7 $f0 $1e
        sSET_PLAYER_NORMAL_SPRITE                      ;; 0e:51e9 $a4
        sSET_PLAYER_DIRECTION_RIGHT                    ;; 0e:51ea $86
        sDELAY 60                                      ;; 0e:51eb $f0 $3c
      sENDIF                                           ;; 0e:51ed
    sENDIF                                             ;; 0e:51ed
    sEND                                               ;; 0e:51ed $00

script_0402:
    sEND                                               ;; 0e:51ee $00

script_0403:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:51ef $0b $c9 $00 $06
      sFADE_TO_BLACK                                   ;; 0e:51f3 $bd
      sFULL_HP                                         ;; 0e:51f4 $c0
      sFULL_MANA                                       ;; 0e:51f5 $c1
      sDELAY 60                                        ;; 0e:51f6 $f0 $3c
      sFADE_TO_NORMAL                                  ;; 0e:51f8 $bc
    sENDIF                                             ;; 0e:51f9
    sEND                                               ;; 0e:51f9 $00

script_0404:
    sEND                                               ;; 0e:51fa $00

script_0405:
; Used by the inn script.
    sIF_FLAG !wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7
      ; Welcome to Jadd.
      sLOAD_ROOM_INSTANT 14, $14, 10, 6
      sIF_FLAG !wScriptFlags05.0
        sSET_MUSIC 0
      sELSE
        sSET_MUSIC 13
      sENDIF
    sENDIF
    sIF_FLAG !wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7
      sLOAD_ROOM_INSTANT 0, $4d, 10, 4
      sSET_MUSIC 20
    sENDIF
    sIF_FLAG !wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7
      ; Welcome to Ish.
      sLOAD_ROOM_INSTANT 15, $36, 2, 11
      sIF_FLAG !wScriptFlags04.1
        sSET_MUSIC 27
      sELSE
        sSET_MUSIC 4
      sENDIF
    sENDIF
    sIF_FLAG wScriptFlags0E.5, !wScriptFlags0E.6, !wScriptFlags0E.7
      ; Welcome to Topple.
      sLOAD_ROOM_INSTANT 14, $01, 14, 5
      sSET_MUSIC 4
    sENDIF
    sIF_FLAG wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7
      ; Welcome to Wendel.
      sLOAD_ROOM_INSTANT 14, $17, 16, 8
      sIF_FLAG wScriptFlags02.0, !wScriptFlags02.1
        sSET_MUSIC 9
      sELSE
        sSET_MUSIC 11
      sENDIF
    sENDIF
    sIF_FLAG wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7
      sLOAD_ROOM_INSTANT 0, $aa, 14, 8
      sSET_MUSIC 20
    sENDIF
    sIF_FLAG wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7
      sLOAD_ROOM_INSTANT 0, $7c, 8, 4
      sSET_MUSIC 20
    sENDIF
    sEND

script_0406:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5212 $0b $c9 $00 $0a
      sSFX 24                                          ;; 0e:5216 $f9 $18
      sSET_ROOM_TILE $46, 4, 6                         ;; 0e:5218 $b0 $46 $04 $06
      sSET_ROOM_TILE $46, 5, 6                         ;; 0e:521c $b0 $46 $05 $06
    sENDIF                                             ;; 0e:5220
    sEND                                               ;; 0e:5220 $00

script_0407:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5221 $0b $c9 $00 $0a
      sSFX 24                                          ;; 0e:5225 $f9 $18
      sSET_ROOM_TILE $00, 4, 6                         ;; 0e:5227 $b0 $00 $04 $06
      sSET_ROOM_TILE $00, 5, 6                         ;; 0e:522b $b0 $00 $05 $06
    sENDIF                                             ;; 0e:522f
    sEND                                               ;; 0e:522f $00

script_0408:
    sEND                                               ;; 0e:5230 $00

script_0409:
    sEND                                               ;; 0e:5231 $00

script_040a:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5232 $0b $c9 $00 $68
      sIF_INVENTORY INV_SWORD_RUSTY
        sSET_MUSIC 0                                   ;; 0e:523a $f8 $00
        sMSG                                           ;; 0e:523c $04
          db "<10>   Rusty sword\n  released its\n  mystic power__<12>"
          db "<11>", $00 ;; 0e:523d
        sDELAY 120                                     ;; 0e:5260 $f0 $78
; Fill tiles just outside the screen before the shake effect.
        sSET_ROOM_TILE $06, 10, 0
        sSET_ROOM_TILE $10, 10, 1
        sSET_ROOM_TILE $10, 10, 2
        sSET_ROOM_TILE $10, 10, 3
        sSET_ROOM_TILE $40, 10, 4
        sSET_ROOM_TILE $40, 10, 5
        sSET_ROOM_TILE $40, 10, 6
        sSET_ROOM_TILE $50, 10, 7
        sSET_ROOM_TILE $05, 15, 0
        sSET_ROOM_TILE $15, 15, 1
        sSET_ROOM_TILE $15, 15, 2
        sSET_ROOM_TILE $25, 15, 3
        sSET_ROOM_TILE $35, 15, 4
        sSET_ROOM_TILE $45, 15, 5
        sSET_ROOM_TILE $45, 15, 6
        sSET_ROOM_TILE $55, 15, 7
        sSFX 37                                        ;; 0e:5262 $f9 $25
        sSHAKE_SCREEN                                  ;; 0e:5264 $fb
        sSFX 37                                        ;; 0e:5265 $f9 $25
        sSHAKE_SCREEN                                  ;; 0e:5267 $fb
        sSET_FLAG wScriptFlags04.2                     ;; 0e:5268 $da $22
        sLOAD_ROOM 0, $70, 14, 11                      ;; 0e:526a $f4 $00 $70 $0e $0b
; Turn the crystal into a hole ASAP.
        sSET_ROOM_TILE $4b, 7, 5
        sCALL script_049a
; Fill tiles just outside the screen before the shake effect.
        sSET_ROOM_TILE $11, 10, 0
        sSET_ROOM_TILE $21, 10, 1
        sSET_ROOM_TILE $05, 10, 2
        sSET_ROOM_TILE $05, 10, 3
        sSET_ROOM_TILE $05, 10, 4
        sSET_ROOM_TILE $05, 10, 5
        sSET_ROOM_TILE $05, 10, 6
        sSET_ROOM_TILE $46, 10, 7
        sSET_ROOM_TILE $11, 15, 0
        sSET_ROOM_TILE $11, 15, 1
        sSET_ROOM_TILE $11, 15, 2
        sSET_ROOM_TILE $21, 15, 3
        sSET_ROOM_TILE $05, 15, 4
        sSET_ROOM_TILE $05, 15, 5
        sSET_ROOM_TILE $05, 15, 6
        sSET_ROOM_TILE $46, 15, 7
        sSFX 37                                        ;; 0e:526f $f9 $25
        sSHAKE_SCREEN                                  ;; 0e:5271 $fb
        sMSG                                           ;; 0e:5272 $04
          db "<10>Dime Tower will\n appear somewhere\n in this desert!!<12>"
          db "<11>", $00 ;; 0e:5273
        sSET_MUSIC 25                                  ;; 0e:529a $f8 $19
        sCLEAR_ROOM_HISTORY                            ;; 0e:529c $ab
      sENDIF                                           ;; 0e:529e
    sENDIF                                             ;; 0e:529e
    sEND                                               ;; 0e:529e $00

script_040b:
    sEND                                               ;; 0e:529f $00

script_040c:
    sIF_TRIGGERED_ON_BY $c9, $c1, $e1, $f1
      sIF_FLAG wScriptFlags0F.0, wScriptFlags0F.1, wScriptFlags0F.2, !wScriptFlags0F.3 ;; 0e:52a4 $08 $78 $79 $7a $fb $00 $0a
        sCREATE_EFFECT $10, $0e, $02                   ;; 0e:52ab $ba $10 $0e $02
        sSET_ROOM_TILE $4c, 7, 1                       ;; 0e:52af $b0 $4c $07 $01
      sELSE                                            ;; 0e:52b3 $01 $08
        sCLEAR_FLAG wScriptFlags0F.0                   ;; 0e:52b5 $db $78
        sCLEAR_FLAG wScriptFlags0F.1                   ;; 0e:52b7 $db $79
        sCLEAR_FLAG wScriptFlags0F.2                   ;; 0e:52b9 $db $7a
        sCLEAR_FLAG wScriptFlags0F.3                   ;; 0e:52bb $db $7b
      sENDIF                                           ;; 0e:52bd
    sENDIF                                             ;; 0e:52bd
    sEND                                               ;; 0e:52bd $00

script_040d:
    sIF_TRIGGERED_ON_BY $c9, $c1, $e1, $f1
      sIF_FLAG !wScriptFlags0F.0, !wScriptFlags0F.1, !wScriptFlags0F.2, !wScriptFlags0F.3 ;; 0e:52c2 $08 $f8 $f9 $fa $fb $00 $04
        sSET_FLAG wScriptFlags0F.0                     ;; 0e:52c9 $da $78
      sELSE                                            ;; 0e:52cb $01 $13
        sIF_FLAG wScriptFlags0F.0, wScriptFlags0F.1, !wScriptFlags0F.2, !wScriptFlags0F.3 ;; 0e:52cd $08 $78 $79 $fa $fb $00 $04
          sSET_FLAG wScriptFlags0F.2                   ;; 0e:52d4 $da $7a
        sELSE                                          ;; 0e:52d6 $01 $08
          sCLEAR_FLAG wScriptFlags0F.0                 ;; 0e:52d8 $db $78
          sCLEAR_FLAG wScriptFlags0F.1                 ;; 0e:52da $db $79
          sCLEAR_FLAG wScriptFlags0F.2                 ;; 0e:52dc $db $7a
          sCLEAR_FLAG wScriptFlags0F.3                 ;; 0e:52de $db $7b
        sENDIF                                         ;; 0e:52e0
      sENDIF                                           ;; 0e:52e0
    sENDIF                                             ;; 0e:52e0
    sEND                                               ;; 0e:52e0 $00

script_040e:
    sIF_TRIGGERED_ON_BY $c9, $c1, $e1, $f1
      sIF_FLAG wScriptFlags0F.0, !wScriptFlags0F.1, !wScriptFlags0F.2, !wScriptFlags0F.3 ;; 0e:52e5 $08 $78 $f9 $fa $fb $00 $04
        sSET_FLAG wScriptFlags0F.1                     ;; 0e:52ec $da $79
      sELSE                                            ;; 0e:52ee $01 $08
        sCLEAR_FLAG wScriptFlags0F.0                   ;; 0e:52f0 $db $78
        sCLEAR_FLAG wScriptFlags0F.1                   ;; 0e:52f2 $db $79
        sCLEAR_FLAG wScriptFlags0F.2                   ;; 0e:52f4 $db $7a
        sCLEAR_FLAG wScriptFlags0F.3                   ;; 0e:52f6 $db $7b
      sENDIF                                           ;; 0e:52f8
    sENDIF                                             ;; 0e:52f8
    sEND                                               ;; 0e:52f8 $00

script_0410:
    sIF_FLAG !wScriptFlags08.1                         ;; 0e:52f9 $08 $c1 $00 $07
      sSET_NPC_TYPES 89                                ;; 0e:52fd $fc $59
      sSPAWN_NPC 0                                     ;; 0e:52ff $fd $00
      sSET_CHEST_OPEN_SCRIPT1 script_042e              ;; 0e:5301 $c9 $04 $2e
    sENDIF                                             ;; 0e:5304
    sEND                                               ;; 0e:5304 $00

script_0411:
    sEND                                               ;; 0e:5305 $00

script_0412:
    sEND                                               ;; 0e:5306 $00

script_0413:
    sIF_FLAG !wScriptFlags08.0                         ;; 0e:5307 $08 $c0 $00 $07
      sSET_NPC_TYPES 89                                ;; 0e:530b $fc $59
      sSPAWN_NPC 0                                     ;; 0e:530d $fd $00
      sSET_CHEST_OPEN_SCRIPT1 script_042f              ;; 0e:530f $c9 $04 $2f
    sENDIF                                             ;; 0e:5312
    sEND                                               ;; 0e:5312 $00

script_0414:
    sEND                                               ;; 0e:5313 $00

script_0415:
    sEND                                               ;; 0e:5314 $00

script_0416:
    sIF_FLAG !wScriptFlags09.4                         ;; 0e:5315 $08 $cc $00 $07
      sSET_NPC_TYPES 89                                ;; 0e:5319 $fc $59
      sSPAWN_NPC 0                                     ;; 0e:531b $fd $00
      sSET_CHEST_OPEN_SCRIPT1 script_0430              ;; 0e:531d $c9 $04 $30
    sENDIF                                             ;; 0e:5320
    sEND                                               ;; 0e:5320 $00

script_0417:
    sEND                                               ;; 0e:5321 $00

script_0418:
    sEND                                               ;; 0e:5322 $00

script_0419:
    sIF_FLAG !wScriptFlags08.3                         ;; 0e:5323 $08 $c3 $00 $07
      sSET_NPC_TYPES 89                                ;; 0e:5327 $fc $59
      sSPAWN_NPC 0                                     ;; 0e:5329 $fd $00
      sSET_CHEST_OPEN_SCRIPT1 script_0431              ;; 0e:532b $c9 $04 $31
    sENDIF                                             ;; 0e:532e
    sEND                                               ;; 0e:532e $00

script_041a:
    sEND                                               ;; 0e:532f $00

script_041b:
    sEND                                               ;; 0e:5330 $00

script_041c:
    sIF_FLAG !wScriptFlags08.4                         ;; 0e:5331 $08 $c4 $00 $07
      sSET_NPC_TYPES 89                                ;; 0e:5335 $fc $59
      sSPAWN_NPC 0                                     ;; 0e:5337 $fd $00
      sSET_CHEST_OPEN_SCRIPT1 script_0432              ;; 0e:5339 $c9 $04 $32
    sENDIF                                             ;; 0e:533c
    sEND                                               ;; 0e:533c $00

script_041d:
    sEND                                               ;; 0e:533d $00

script_041e:
    sEND                                               ;; 0e:533e $00

script_041f:
    sIF_FLAG !wScriptFlags.7                           ;; 0e:533f $08 $87 $00 $04
      sSET_NPC_TYPES 26                                ;; 0e:5343 $fc $1a
      sSPAWN_NPC 1                                     ;; 0e:5345 $fd $01
    sENDIF                                             ;; 0e:5347
    sEND                                               ;; 0e:5347 $00

script_0420:
    sEND                                               ;; 0e:5348 $00

script_0421:
    sSET_NPC_TYPES 89                                  ;; 0e:5349 $fc $59
    sSPAWN_NPC 0                                       ;; 0e:534b $fd $00
    sSET_CHEST_OPEN_SCRIPT1 script_0446                ;; 0e:534d $c9 $04 $46
    sEND                                               ;; 0e:5350 $00

script_0422:
    sIF_FLAG !wScriptFlags08.6                         ;; 0e:5351 $08 $c6 $00 $07
      sSET_NPC_TYPES 89                                ;; 0e:5355 $fc $59
      sSPAWN_NPC 0                                     ;; 0e:5357 $fd $00
      sSET_CHEST_OPEN_SCRIPT1 script_0434              ;; 0e:5359 $c9 $04 $34
    sENDIF                                             ;; 0e:535c
    sEND                                               ;; 0e:535c $00

script_0423:
    sEND                                               ;; 0e:535d $00

script_0424:
    sEND                                               ;; 0e:535e $00

script_0425:
    sIF_FLAG !wScriptFlags09.2                         ;; 0e:535f $08 $ca $00 $07
      sSET_NPC_TYPES 89                                ;; 0e:5363 $fc $59
      sSPAWN_NPC 0                                     ;; 0e:5365 $fd $00
      sSET_CHEST_OPEN_SCRIPT1 script_0466              ;; 0e:5367 $c9 $04 $66
    sENDIF                                             ;; 0e:536a
    sEND                                               ;; 0e:536a $00

script_0426:
    sEND                                               ;; 0e:536b $00

script_0427:
    sEND                                               ;; 0e:536c $00

script_0428:
    sIF_FLAG !wScriptFlags.7                           ;; 0e:536d $08 $87 $00 $04
      sSET_NPC_TYPES 28                                ;; 0e:5371 $fc $1c
      sSPAWN_NPC 2                                     ;; 0e:5373 $fd $02
    sENDIF                                             ;; 0e:5375
    sEND                                               ;; 0e:5375 $00

script_0429:
    sEND                                               ;; 0e:5376 $00

script_042a:
    sSET_NPC_TYPES 89                                  ;; 0e:5377 $fc $59
    sSPAWN_NPC 0                                       ;; 0e:5379 $fd $00
    sSET_CHEST_OPEN_SCRIPT1 script_0446                ;; 0e:537b $c9 $04 $46
    sEND                                               ;; 0e:537e $00

script_042b:
    sSET_NPC_TYPES 89                                  ;; 0e:537f $fc $59
    sSPAWN_NPC 0                                       ;; 0e:5381 $fd $00
    sSET_CHEST_OPEN_SCRIPT1 script_0437                ;; 0e:5383 $c9 $04 $37
    sEND                                               ;; 0e:5386 $00

script_042c:
    sEND                                               ;; 0e:5387 $00

script_042d:
    sEND                                               ;; 0e:5388 $00

script_042e:
    sGIVE_EQUIPMENT INV_SICKLE_SICKLE                  ;; 0e:5389 $d8 $02
    sIF_FLAG !wScriptFlags.5                           ;; 0e:538b $08 $85 $00 $13
      sSFX 15                                          ;; 0e:538f $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:5391 $af
      sMSG                                             ;; 0e:5392 $04
        db "<10>Found <SICKLE>Sickle!<12>"
        db "<11>", $00 ;; 0e:5393
      sSET_FLAG wScriptFlags08.1                       ;; 0e:53a0 $da $41
    sENDIF                                             ;; 0e:53a2
    sEND                                               ;; 0e:53a2 $00

script_042f:
    sGIVE_EQUIPMENT INV_WHIP_CHAIN                     ;; 0e:53a3 $d8 $03
    sIF_FLAG !wScriptFlags.5                           ;; 0e:53a5 $08 $85 $00 $12
      sSFX 15                                          ;; 0e:53a9 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:53ab $af
      sMSG                                             ;; 0e:53ac $04
        db "<10>Found <WHIP>Chain!<12>"
        db "<11>", $00 ;; 0e:53ad
      sSET_FLAG wScriptFlags08.0                       ;; 0e:53b9 $da $40
    sENDIF                                             ;; 0e:53bb
    sEND                                               ;; 0e:53bb $00

script_0430:
    sGIVE_EQUIPMENT INV_SWORD_DRAGON                   ;; 0e:53bc $d8 $09
    sIF_FLAG !wScriptFlags.5                           ;; 0e:53be $08 $85 $00 $14
      sSFX 15                                          ;; 0e:53c2 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:53c4 $af
      sMSG                                             ;; 0e:53c5 $04
        db "<10>Found <SWORD>Dragon!<12>"
        db "<11>", $00 ;; 0e:53c6
      sSET_FLAG wScriptFlags09.4                       ;; 0e:53d4 $da $4c
    sENDIF                                             ;; 0e:53d6
    sEND                                               ;; 0e:53d6 $00

script_0431:
    sGIVE_EQUIPMENT INV_SHIELD_DRAGON                  ;; 0e:53d7 $d8 $20
    sIF_FLAG !wScriptFlags.5                           ;; 0e:53d9 $08 $85 $00 $14
      sSFX 15                                          ;; 0e:53dd $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:53df $af
      sMSG                                             ;; 0e:53e0 $04
        db "<10>Found <SHIELD>Dragon!<12>"
        db "<11>", $00 ;; 0e:53e1
      sSET_FLAG wScriptFlags08.3                       ;; 0e:53ef $da $43
    sENDIF                                             ;; 0e:53f1
    sEND                                               ;; 0e:53f1 $00

script_0432:
    sGIVE_EQUIPMENT INV_ARMOR_DRAGON                   ;; 0e:53f2 $d8 $16
    sIF_FLAG !wScriptFlags.5                           ;; 0e:53f4 $08 $85 $00 $14
      sSFX 15                                          ;; 0e:53f8 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:53fa $af
      sMSG                                             ;; 0e:53fb $04
        db "<10>Found <ARMOR>Dragon!<12>"
        db "<11>", $00 ;; 0e:53fc
      sSET_FLAG wScriptFlags08.4                       ;; 0e:540a $da $44
    sENDIF                                             ;; 0e:540c
    sEND                                               ;; 0e:540c $00

; Utility script used to print your fellow  gladiator's name
script_0433:
    sIF_FLAG wScriptFlags0A.0
      sMSG
        db "Amanda", $00
    sELSE
      sMSG
        db "Duke", $00
    sENDIF
    sEND                                               ;; 0e:540d $00

script_0434:
    sGIVE_EQUIPMENT INV_SWORD_XCALIBR                  ;; 0e:540e $d8 $0f
    sIF_FLAG !wScriptFlags.5                           ;; 0e:5410 $08 $85 $00 $13
      sSFX 15                                          ;; 0e:5414 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:5416 $af
      sMSG                                             ;; 0e:5417 $04
        db "<10>Found <SWORD>????!<12>"
        db "<11>", $00 ;; 0e:5418
      sSET_FLAG wScriptFlags08.6                       ;; 0e:5425 $da $46
    sENDIF                                             ;; 0e:5427
    sEND                                               ;; 0e:5427 $00

script_0435:
    sDELAY 60
    sMSG                                               ;; 0e:542b $04
      db "<10>Watts:There's\n plenty of mithril\n down here!<12>"
      db "<11>", $00  ;; 0e:542c
    sSET_FLAG wScriptFlags02.4                         ;; 0e:5438 $da $14
    sDELAY 60                                          ;; 0e:543a $f0 $3c
    sLOAD_ROOM 0, $9b, 4, 5                            ;; 0e:543c $f4 $00 $9b $04 $05
    sSET_PLAYER_DIRECTION_RIGHT                        ;; 0e:5441 $86
    sFOLLOWER_DIRECTION_LEFT                           ;; 0e:5442 $97
    sFOLLOWER_SET_POSITION 7, 5                        ;; 0e:5443 $99 $07 $05
    sDELAY 80                                          ;; 0e:5446 $f0 $50
    sMSG                                               ;; 0e:5448 $04
      db "<10>Watts:I'll take it\n back and forge\n swords and armor!<12>"
      db "<1b> Gaia will let you\n in if you wear\n mithril stuff!<12>"
      db "<1b> Come see me at\n the Dwarf Cave!<12>"
      db "<11>", $00 ;; 0e:5449
    sFOLLOWER_DIRECTION_RIGHT                          ;; 0e:54a5 $96
    sUNK_9A                                            ;; 0e:54a6 $9a
    sLOOP 9, 2                                         ;; 0e:54a7 $03 $09 $02
      sFOLLOWER_STEP_FORWARD                           ;; 0e:54aa $90
    sEND                                               ;; 0e:54ab $00
    sFOLLOWER_DIRECTION_UP                             ;; 0e:54ac $94
    sFOLLOWER_STEP_FORWARD                             ;; 0e:54ad $90
    sFOLLOWER_DIRECTION_RIGHT                          ;; 0e:54ae $96
    sFOLLOWER_STEP_FORWARD                             ;; 0e:54af $90
    sFOLLOWER_STEP_FORWARD                             ;; 0e:54b0 $90
    sUNK_9B                                            ;; 0e:54b1 $9b
    sFOLLOWER_DELETE                                   ;; 0e:54b2 $98
    sCLEAR_FLAG wScriptFlags0A.3                       ;; 0e:54b3 $db $53
    sSET_MUSIC 20                                      ;; 0e:54b5 $f8 $14
    sCLEAR_ROOM_HISTORY                                ;; 0e:54b7 $ab
    sEND                                               ;; 0e:54b8 $00

script_0436:
    sSFX 15
    sCHANGE_INTO_EMPTY_CHEST
    sMSG
      db "<10>Found <FANG>Fang_\n<00>"
    sDELAY 30
    sMSG
      db "_ But it's broken.<12><11><00>"
    sEND

script_0437:
    sGIVE_EQUIPMENT INV_SWORD_RUSTY                    ;; 0e:54ba $d8 $0d
    sIF_FLAG !wScriptFlags.5                           ;; 0e:54bc $08 $85 $00 $3e
      sSFX 15                                          ;; 0e:54c0 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:54c2 $af
      sMSG                                             ;; 0e:54c3 $04
        db "<10>Received <SWORD>Rusty!<12>"
        db "<1b><BOY>:Rusty sword?\n Is this the Mana\n Sword_?<12>"
        db "<11>", $00 ;; 0e:54c4
      sSET_FLAG wScriptFlags07.3                       ;; 0e:54f3 $da $3b
      sLOAD_ROOM 0, $f0, 8, 9                          ;; 0e:54f5 $f4 $00 $f0 $08 $09
      sSET_MUSIC 25                                    ;; 0e:54fa $f8 $19
      sCLEAR_ROOM_HISTORY                              ;; 0e:54fc $ab
; Because Chocobo can spawn in an inaccessible location when you leave the cave, move it to you.
      sIF_FLAG wScriptFlags0D.2
        sCALL script_0475
        sSET_NPC_1_POSITION 8, 10
      sENDIF
    sENDIF                                             ;; 0e:54fe
    sEND                                               ;; 0e:54fe $00

script_0438:
    sGIVE_ITEM INV_ITEM_CANDY                          ;; 0e:54ff $d4 $14
    sIF_FLAG !wScriptFlags.5                           ;; 0e:5501 $08 $85 $00 $11
      sSFX 15                                          ;; 0e:5505 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:5507 $af
      sMSG                                             ;; 0e:5508 $04
        db "<10>Found <CANDY>Candy.<12>"
        db "<11>", $00 ;; 0e:5509
    sENDIF                                             ;; 0e:5516
    sEND                                               ;; 0e:5516 $00

script_0439:
    sRNG                                               ;; 0e:5517 $c7
    sIF_FLAG !wScriptFlags0F.6, !wScriptFlags0F.7      ;; 0e:5518 $08 $fe $ff $00 $19
      sGIVE_ITEM INV_ITEM_GEM_WISDOM                   ;; 0e:551d $d4 $2d
      sIF_FLAG !wScriptFlags.5                         ;; 0e:551f $08 $85 $00 $11
        sSFX 15                                        ;; 0e:5523 $f9 $0f
        sCHANGE_INTO_EMPTY_CHEST                       ;; 0e:5525 $af
        sMSG                                           ;; 0e:5526 $04
          db "<10>Found <GEM>Wisdom.<12>"
          db "<11>", $00 ;; 0e:5527
      sENDIF                                           ;; 0e:5534
    sELSE                                              ;; 0e:5534 $01 $03
      sCALL script_0440                                ;; 0e:5536 $02 $55 $af
    sENDIF                                             ;; 0e:5539
    sEND                                               ;; 0e:5539 $00

script_043a:
    sGIVE_ITEM INV_ITEM_POTION_CURE                    ;; 0e:553a $d4 $00
    sIF_FLAG !wScriptFlags.5                           ;; 0e:553c $08 $85 $00 $0f
      sSFX 15                                          ;; 0e:5540 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:5542 $af
      sMSG                                             ;; 0e:5543 $04
        db "<10>Found <POT>Cure.<12>"
        db "<11>", $00 ;; 0e:5544
    sENDIF                                             ;; 0e:554f
    sEND                                               ;; 0e:554f $00

script_043b:
    sGIVE_ITEM INV_ITEM_POTION_EYEDRP                  ;; 0e:5550 $d4 $06
    sIF_FLAG !wScriptFlags.5                           ;; 0e:5552 $08 $85 $00 $12
      sSFX 15                                          ;; 0e:5556 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:5558 $af
      sMSG                                             ;; 0e:5559 $04
        db "<10>Found <POT>Eyedrop.<12>"
        db "<11>", $00 ;; 0e:555a
    sENDIF                                             ;; 0e:5568
    sEND                                               ;; 0e:5568 $00

script_043c:
    sGIVE_ITEM INV_ITEM_POTION_PURE                    ;; 0e:5569 $d4 $05
    sIF_FLAG !wScriptFlags.5                           ;; 0e:556b $08 $85 $00 $0f
      sSFX 15                                          ;; 0e:556f $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:5571 $af
      sMSG                                             ;; 0e:5572 $04
        db "<10>Found <POT>Pure.<12>"
        db "<11>", $00 ;; 0e:5573
    sENDIF                                             ;; 0e:557e
    sEND                                               ;; 0e:557e $00

script_043d:
    sGIVE_ITEM INV_ITEM_POTION_SOFT                    ;; 0e:557f $d4 $07
    sIF_FLAG !wScriptFlags.5                           ;; 0e:5581 $08 $85 $00 $10
      sSFX 15                                          ;; 0e:5585 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:5587 $af
      sMSG                                             ;; 0e:5588 $04
        db "<10>Found <POT>Soft.<12>"
        db "<11>", $00 ;; 0e:5589
    sENDIF                                             ;; 0e:5595
    sEND                                               ;; 0e:5595 $00

script_043e:
    sGIVE_ITEM INV_ITEM_POTION_XCURE                   ;; 0e:5596 $d4 $01
    sIF_FLAG !wScriptFlags.5                           ;; 0e:5598 $08 $85 $00 $11
      sSFX 15                                          ;; 0e:559c $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:559e $af
      sMSG                                             ;; 0e:559f $04
        db "<10>Found <POT>X-Cure.<12>"
        db "<11>", $00 ;; 0e:55a0
    sENDIF                                             ;; 0e:55ad
    sEND                                               ;; 0e:55ad $00

script_043f:
    sGIVE_ITEM INV_ITEM_BAG_FANG
    sIF_FLAG !wScriptFlags.5
      sSFX 15
      sCHANGE_INTO_EMPTY_CHEST
      sMSG
        db "<10>Found <FANG>Fang!<12><11><00>"
    sENDIF
    sEND

script_0440:
    sGIVE_ITEM INV_ITEM_POTION_ETHER                   ;; 0e:55af $d4 $02
    sIF_FLAG !wScriptFlags.5                           ;; 0e:55b1 $08 $85 $00 $10
      sSFX 15                                          ;; 0e:55b5 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:55b7 $af
      sMSG                                             ;; 0e:55b8 $04
        db "<10>Found <POT>Ether.<12>"
        db "<11>", $00 ;; 0e:55b9
    sENDIF                                             ;; 0e:55c5
    sEND                                               ;; 0e:55c5 $00

script_0441:
    sGIVE_ITEM INV_ITEM_BRONZE_KEY                     ;; 0e:55c6 $d4 $18
    sIF_FLAG !wScriptFlags.5                           ;; 0e:55c8 $08 $85 $00 $11
      sSFX 15                                          ;; 0e:55cc $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:55ce $af
      sMSG                                             ;; 0e:55cf $04
        db "<10>Found <KEY>Silver!<12>"
        db "<11>", $00 ;; 0e:55d0
    sENDIF                                             ;; 0e:55dd
    sEND                                               ;; 0e:55dd $00

script_0442:
    sGIVE_ITEM INV_ITEM_KEY                            ;; 0e:55de $d4 $16
    sIF_FLAG !wScriptFlags.5                           ;; 0e:55e0 $08 $85 $00 $10
      sSFX 15                                          ;; 0e:55e4 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:55e6 $af
      sMSG                                             ;; 0e:55e7 $04
        db "<10>Found <KEY>Key.<12>"
        db "<11>", $00 ;; 0e:55e8
    sENDIF                                             ;; 0e:55f4
    sEND                                               ;; 0e:55f4 $00

script_0443:
    sGIVE_ITEM INV_ITEM_MATTOK                         ;; 0e:55f5 $d4 $35
    sIF_FLAG !wScriptFlags.5                           ;; 0e:55f7 $08 $85 $00 $13
      sSFX 15                                          ;; 0e:55fb $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:55fd $af
      sMSG                                             ;; 0e:55fe $04
        db "<10>Found <MATT>Mattock.<12>"
        db "<11>", $00 ;; 0e:55ff
      sSET_FLAG wScriptFlags09.5                       ;; 0e:560c $da $4d
    sENDIF                                             ;; 0e:560e
    sEND                                               ;; 0e:560e $00

script_0444:
    ; Stop re-roll on bag full by using the bag-full bit to control the roll.
    sIF_FLAG !wScriptFlags.5
      sRNG
    sENDIF
    ; Logic has been modified after the first broken Fang to increase the drop rate to 75%,
    ; unless you have one in your inventory or have already killed Medusa.
    ; If the first random check passes then give the Fang.
    sIF_FLAG !wScriptFlags0F.6
      sCALL script_043f
    sELSE
      ; Else if Medusa isn't dead, the second random bit passes,
      ; and a reused bit from Jackal isn't set, then give the Fang.
      sIF_FLAG !wScriptFlags04.7, wScriptFlags0F.7, !wScriptFlags01.0
        sIF_INVENTORY INV_ITEM_BAG_FANG
          ; If you are already carrying a Fang then the chest is a broken Fang.
          sCALL script_0436
        sELSE
          ; Else, give the Fang.
          sCALL script_043f
        sENDIF
      sELSE
        ; Else it's the broken Fang.
        sCALL script_0436
        ; And if it is the broken fang and Medusa isn't dead yet, change the Jackal bit to influence future odds.
        sIF_FLAG !wScriptFlags04.7
          sCLEAR_FLAG wScriptFlags01.0
        sENDIF
      sENDIF
    sENDIF
    sEND

script_0445:
    sRNG                                               ;; 0e:563b $c7
    sIF_FLAG !wScriptFlags0F.6                         ;; 0e:563c $08 $fe $00 $19
      sGIVE_ITEM INV_ITEM_BAG_GOLD                     ;; 0e:5640 $d4 $31
      sIF_FLAG !wScriptFlags.5                         ;; 0e:5642 $08 $85 $00 $11
        sSFX 15                                        ;; 0e:5646 $f9 $0f
        sCHANGE_INTO_EMPTY_CHEST                       ;; 0e:5648 $af
        sMSG                                           ;; 0e:5649 $04
          db "<10>Found <BAG>Gold.<12>"
          db "<11>", $00 ;; 0e:564a
      sENDIF                                           ;; 0e:5657
    sELSE                                              ;; 0e:5657 $01 $03
      sCALL script_0438                                ;; 0e:5659 $02 $54 $ff
    sENDIF                                             ;; 0e:565c
    sEND                                               ;; 0e:565c $00

script_0446:
    sGIVE_ITEM INV_ITEM_POTION_ELIXIR                  ;; 0e:565d $d4 $04
    sIF_FLAG !wScriptFlags.5                           ;; 0e:565f $08 $85 $00 $11
      sSFX 15                                          ;; 0e:5663 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:5665 $af
      sMSG                                             ;; 0e:5666 $04
        db "<10>Found <POT>Elixir.<12>"
        db "<11>", $00 ;; 0e:5667
    sENDIF                                             ;; 0e:5674
    sEND                                               ;; 0e:5674 $00

script_0447:
    sGIVE_ITEM INV_ITEM_GEM_CRYSTAL                    ;; 0e:5675 $d4 $29
    sIF_FLAG !wScriptFlags.5                           ;; 0e:5677 $08 $85 $00 $12
      sSFX 15                                          ;; 0e:567b $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:567d $af
      sMSG                                             ;; 0e:567e $04
        db "<10>Found <GEM>Crystal.<12>"
        db "<11>", $00 ;; 0e:567f
    sENDIF                                             ;; 0e:568d
    sEND                                               ;; 0e:568d $00

script_0448:
    sGIVE_ITEM INV_ITEM_POTION_MOOGLE                  ;; 0e:568e $d4 $08
    sIF_FLAG !wScriptFlags.5                           ;; 0e:5690 $08 $85 $00 $11
      sSFX 15                                          ;; 0e:5694 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:5696 $af
      sMSG                                             ;; 0e:5697 $04
        db "<10>Found <POT>Moogle.<12>"
        db "<11>", $00 ;; 0e:5698
    sENDIF                                             ;; 0e:56a5
    sEND                                               ;; 0e:56a5 $00

script_0449:
    sGIVE_ITEM INV_ITEM_POTION_XETHER                  ;; 0e:56a6 $d4 $03
    sIF_FLAG !wScriptFlags.5                           ;; 0e:56a8 $08 $85 $00 $12
      sSFX 15                                          ;; 0e:56ac $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:56ae $af
      sMSG                                             ;; 0e:56af $04
        db "<10>Found <POT>X-Ether.<12>"
        db "<11>", $00 ;; 0e:56b0
    sENDIF                                             ;; 0e:56be
    sEND                                               ;; 0e:56be $00

script_044a:
    sGIVE_ITEM INV_ITEM_POTION_UNICORN                 ;; 0e:56bf $d4 $09
    sIF_FLAG !wScriptFlags.5                           ;; 0e:56c1 $08 $85 $00 $13
      sSFX 15                                          ;; 0e:56c5 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:56c7 $af
      sMSG                                             ;; 0e:56c8 $04
        db "<10>Found <POT>Unicorn.<12>"
        db "<11>", $00 ;; 0e:56c9
    sENDIF                                             ;; 0e:56d8
    sEND                                               ;; 0e:56d8 $00

script_044b:
    sRNG                                               ;; 0e:56d9 $c7
    sIF_FLAG !wScriptFlags0F.6, !wScriptFlags0F.7      ;; 0e:56da $08 $fe $ff $00 $18
      sGIVE_ITEM INV_ITEM_GEM_WILL                     ;; 0e:56df $d4 $2e
      sIF_FLAG !wScriptFlags.5                         ;; 0e:56e1 $08 $85 $00 $10
        sSFX 15                                        ;; 0e:56e5 $f9 $0f
        sCHANGE_INTO_EMPTY_CHEST                       ;; 0e:56e7 $af
        sMSG                                           ;; 0e:56e8 $04
          db "<10>Found <GEM>Will.<12>"
          db "<11>", $00 ;; 0e:56e9
      sENDIF                                           ;; 0e:56f5
    sELSE                                              ;; 0e:56f5 $01 $03
      sCALL script_0440                                ;; 0e:56f7 $02 $55 $af
    sENDIF                                             ;; 0e:56fa
    sEND                                               ;; 0e:56fa $00

script_044c:
    sCALL script_0438                                  ;; 0e:56fb $02 $54 $ff
    sEND                                               ;; 0e:56fe $00

script_044d:
    sIF_FLAG !wScriptFlags.5
      sRNG
    sENDIF
    sIF_FLAG !wScriptFlags0F.6, wScriptFlags0F.7       ;; 0e:5700 $08 $fe $7f $00 $19
      sGIVE_EQUIPMENT INV_SHIELD_AEGIS                 ;; 0e:5705 $d8 $21
      sIF_FLAG !wScriptFlags.5                         ;; 0e:5707 $08 $85 $00 $11
        sSFX 15                                        ;; 0e:570b $f9 $0f
        sCHANGE_INTO_EMPTY_CHEST                       ;; 0e:570d $af
        sMSG                                           ;; 0e:570e $04
          db "<10>Found <SHIELD>Aegis!<12>"
          db "<11>", $00 ;; 0e:570f
      sENDIF                                           ;; 0e:571c
    sELSE                                              ;; 0e:571c $01 $19
      sGIVE_ITEM INV_ITEM_POTION_UNICORN               ;; 0e:571e $d4 $09
      sIF_FLAG !wScriptFlags.5                         ;; 0e:5720 $08 $85 $00 $13
        sSFX 15                                        ;; 0e:5724 $f9 $0f
        sCHANGE_INTO_EMPTY_CHEST                       ;; 0e:5726 $af
        sMSG                                           ;; 0e:5727 $04
          db "<10>Found <POT>Unicorn.<12>"
          db "<11>", $00 ;; 0e:5728
      sENDIF                                           ;; 0e:5737
    sENDIF                                             ;; 0e:5737
    sEND                                               ;; 0e:5737 $00

script_044e:
    sIF_FLAG !wScriptFlags.5
      sRNG
    sENDIF
    sIF_FLAG !wScriptFlags0F.6, wScriptFlags0F.7       ;; 0e:5739 $08 $fe $7f $00 $1a
      sGIVE_EQUIPMENT INV_ARMOR_SAMURAI                ;; 0e:573e $d8 $17
      sIF_FLAG !wScriptFlags.5                         ;; 0e:5740 $08 $85 $00 $12
        sSFX 15                                        ;; 0e:5744 $f9 $0f
        sCHANGE_INTO_EMPTY_CHEST                       ;; 0e:5746 $af
        sMSG                                           ;; 0e:5747 $04
          db "<10>Found <ARMOR>Genji!<12>"
          db "<11>", $00 ;; 0e:5748
      sENDIF                                           ;; 0e:5756
    sELSE                                              ;; 0e:5756 $01 $17
      sGIVE_ITEM INV_ITEM_POTION_ELIXIR                ;; 0e:5758 $d4 $04
      sIF_FLAG !wScriptFlags.5                         ;; 0e:575a $08 $85 $00 $11
        sSFX 15                                        ;; 0e:575e $f9 $0f
        sCHANGE_INTO_EMPTY_CHEST                       ;; 0e:5760 $af
        sMSG                                           ;; 0e:5761 $04
          db "<10>Found <POT>Elixir.<12>"
          db "<11>", $00 ;; 0e:5762
      sENDIF                                           ;; 0e:576f
    sENDIF                                             ;; 0e:576f
    sEND                                               ;; 0e:576f $00

script_044f:
    sIF_FLAG !wScriptFlags.5
      sRNG
    sENDIF
    sIF_FLAG !wScriptFlags0F.6, wScriptFlags0F.7       ;; 0e:5771 $08 $fe $7f $00 $1a
      sGIVE_EQUIPMENT INV_HELM_SAMURAI                 ;; 0e:5776 $d8 $2b
      sIF_FLAG !wScriptFlags.5                         ;; 0e:5778 $08 $85 $00 $12
        sSFX 15                                        ;; 0e:577c $f9 $0f
        sCHANGE_INTO_EMPTY_CHEST                       ;; 0e:577e $af
        sMSG                                           ;; 0e:577f $04
          db "<10>Found <HELM>Genji!<12>"
          db "<11>", $00 ;; 0e:5780
      sENDIF                                           ;; 0e:578e
    sELSE                                              ;; 0e:578e $01 $18
      sGIVE_ITEM INV_ITEM_POTION_XETHER                ;; 0e:5790 $d4 $03
      sIF_FLAG !wScriptFlags.5                         ;; 0e:5792 $08 $85 $00 $12
        sSFX 15                                        ;; 0e:5796 $f9 $0f
        sCHANGE_INTO_EMPTY_CHEST                       ;; 0e:5798 $af
        sMSG                                           ;; 0e:5799 $04
          db "<10>Found <POT>X-Ether.<12>"
          db "<11>", $00 ;; 0e:579a
      sENDIF                                           ;; 0e:57a8
    sENDIF                                             ;; 0e:57a8
    sEND                                               ;; 0e:57a8 $00

script_0450:
    sGIVE_MAGIC INV_MAGIC_FIRE                         ;; 0e:57a9 $d6 $04
    sCHANGE_INTO_EMPTY_CHEST                           ;; 0e:57ab $af
    sMSG                                               ;; 0e:57ac $04
      db "<10>Found the Book\nof Salamander!\nLearned Fire.<12>"
      db "<11>", $00 ;; 0e:57ad
    sSET_FLAG wScriptFlags09.1                         ;; 0e:57cc $da $49
    sEND                                               ;; 0e:57ce $00

script_0451:
    sGIVE_ITEM INV_ITEM_MIRROR                         ;; 0e:57cf $d4 $1e
    sIF_FLAG !wScriptFlags.5                           ;; 0e:57d1 $08 $85 $00 $62
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:57d5 $af
      sMSG                                             ;; 0e:57d6 $04
        db "<10>Found <7c>Mirror!<12>"
        db "<11>", $00 ;; 0e:57d7
      sSET_FLAG wScriptFlags09.0                       ;; 0e:57e5 $da $48
      sIF_FLAG wScriptFlags0A.2                        ;; 0e:57e7 $08 $52 $00 $42
        sDELAY 10
        sMSG                                           ;; 0e:57eb $04
          db "<10>Traveler:Try it\n on that jerk at\n Kett's Mansion.<12>"
          db "<1b> It'll show if he\n has something to\n hide.<12>"
          db "<1b> I wish you luck,\n but I must leave.\n Bye!<12>"
          db "<11>", $00 ;; 0e:57ec
        sFOLLOWER_DELETE                               ;; 0e:582a $98
        sCLEAR_FLAG wScriptFlags0A.2                   ;; 0e:582b $db $52
      sENDIF                                           ;; 0e:582d
      sDELAY 60                                        ;; 0e:582d $f0 $3c
      sLOAD_ROOM 0, $e8, 10, 2                         ;; 0e:582f $f4 $00 $e8 $0a $02
      sCLEAR_ROOM_HISTORY                              ;; 0e:5834 $ab
      sSET_MUSIC 20                                    ;; 0e:5835 $f8 $14
    sENDIF                                             ;; 0e:5837
    sEND                                               ;; 0e:5837 $00

script_0452:
    sGIVE_ITEM INV_ITEM_SPELL_THUNDR                   ;; 0e:5838 $d4 $13
    sIF_FLAG !wScriptFlags.5                           ;; 0e:583a $08 $85 $00 $11
      sSFX 15                                          ;; 0e:583e $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:5840 $af
      sMSG                                             ;; 0e:5841 $04
        db "<10>Found <SPEL>Thunder.<12>"
        db "<11>", $00 ;; 0e:5842
    sENDIF                                             ;; 0e:584f
    sEND                                               ;; 0e:584f $00

script_0453:
    sGIVE_ITEM INV_ITEM_SPELL_PILLOW                   ;; 0e:5850 $d4 $0b
    sIF_FLAG !wScriptFlags.5                           ;; 0e:5852 $08 $85 $00 $11
      sSFX 15                                          ;; 0e:5856 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:5858 $af
      sMSG                                             ;; 0e:5859 $04
        db "<10>Found <SPEL>Pillow.<12>"
        db "<11>", $00 ;; 0e:585a
    sENDIF                                             ;; 0e:5867
    sEND                                               ;; 0e:5867 $00

script_0454:
    sEND                                               ;; 0e:5868 $00

script_0455:
    sGIVE_ITEM INV_ITEM_RUBY                           ;; 0e:5869 $d4 $36
    sIF_FLAG !wScriptFlags.5                           ;; 0e:586b $08 $85 $00 $11
      sSFX 15                                          ;; 0e:586f $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:5871 $af
      sMSG                                             ;; 0e:5872 $04
        db "<10>Found <BAG>Ruby.<12>"
        db "<11>", $00 ;; 0e:5873
    sENDIF                                             ;; 0e:5880
    sEND                                               ;; 0e:5880 $00

script_0456:
    sGIVE_ITEM INV_ITEM_OPAL                           ;; 0e:5881 $d4 $37
    sIF_FLAG !wScriptFlags.5                           ;; 0e:5883 $08 $85 $00 $10
      sSFX 15                                          ;; 0e:5887 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:5889 $af
      sMSG                                             ;; 0e:588a $04
        db "<10>Found <BAG>Opal.<12>"
        db "<11>", $00 ;; 0e:588b
    sENDIF                                             ;; 0e:5897
    sEND                                               ;; 0e:5897 $00

script_0457:
    sGIVE_ITEM INV_ITEM_SPELL_FLAME                    ;; 0e:5898 $d4 $0e
    sIF_FLAG !wScriptFlags.5                           ;; 0e:589a $08 $85 $00 $11
      sSFX 15                                          ;; 0e:589e $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:58a0 $af
      sMSG                                             ;; 0e:58a1 $04
        db "<10>Found <SPEL>Flame.<12>"
        db "<11>", $00 ;; 0e:58a2
    sENDIF                                             ;; 0e:58af
    sEND                                               ;; 0e:58af $00

script_0458:
    sGIVE_ITEM INV_ITEM_SPELL_BLIZRD                   ;; 0e:58b0 $d4 $10
    sIF_FLAG !wScriptFlags.5                           ;; 0e:58b2 $08 $85 $00 $13
      sSFX 15                                          ;; 0e:58b6 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:58b8 $af
      sMSG                                             ;; 0e:58b9 $04
        db "<10>Found <SPEL>Blizzard.<12>"
        db "<11>", $00 ;; 0e:58ba
    sENDIF                                             ;; 0e:58c9
    sEND                                               ;; 0e:58c9 $00

script_0459:
    sGIVE_ITEM INV_ITEM_GEM_NECTAR                     ;; 0e:58ca $d4 $2b
    sIF_FLAG !wScriptFlags.5                           ;; 0e:58cc $08 $85 $00 $12
      sSFX 15                                          ;; 0e:58d0 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:58d2 $af
      sMSG                                             ;; 0e:58d3 $04
        db "<10>Found <GEM>Nectar.<12>"
        db "<11>", $00 ;; 0e:58d4
    sENDIF                                             ;; 0e:58e2
    sEND                                               ;; 0e:58e2 $00

script_045a:
    sGIVE_ITEM INV_ITEM_GEM_STAMINA                    ;; 0e:58e3 $d4 $2c
    sIF_FLAG !wScriptFlags.5                           ;; 0e:58e5 $08 $85 $00 $12
      sSFX 15                                          ;; 0e:58e9 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:58eb $af
      sMSG                                             ;; 0e:58ec $04
        db "<10>Found <GEM>Stamina.<12>"
        db "<11>", $00 ;; 0e:58ed
    sENDIF                                             ;; 0e:58fb
    sEND                                               ;; 0e:58fb $00

script_045b:
    sGIVE_ITEM INV_ITEM_GEM_WISDOM                     ;; 0e:58fc $d4 $2d
    sIF_FLAG !wScriptFlags.5                           ;; 0e:58fe $08 $85 $00 $11
      sSFX 15                                          ;; 0e:5902 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:5904 $af
      sMSG                                             ;; 0e:5905 $04
        db "<10>Found <GEM>Wisdom.<12>"
        db "<11>", $00 ;; 0e:5906
    sENDIF                                             ;; 0e:5913
    sEND                                               ;; 0e:5913 $00

script_045c:
    sGIVE_ITEM INV_ITEM_GEM_WILL                       ;; 0e:5914 $d4 $2e
    sIF_FLAG !wScriptFlags.5                           ;; 0e:5916 $08 $85 $00 $10
      sSFX 15                                          ;; 0e:591a $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:591c $af
      sMSG                                             ;; 0e:591d $04
        db "<10>Found <GEM>Will.<12>"
        db "<11>", $00 ;; 0e:591e
    sENDIF                                             ;; 0e:592a
    sEND                                               ;; 0e:592a $00

script_045d:
    sGIVE_EQUIPMENT INV_MORNING_STAR                   ;; 0e:592b $d8 $07
    sIF_FLAG !wScriptFlags.5                           ;; 0e:592d $08 $85 $00 $12
      sSFX 15                                          ;; 0e:5931 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:5933 $af
      sMSG                                             ;; 0e:5934 $04
        db "<10>Found <MSTAR>Star!<12>"
        db "<11>", $00 ;; 0e:5935
      sSET_FLAG wScriptFlags09.6                       ;; 0e:5941 $da $4e
    sENDIF                                             ;; 0e:5943
    sEND                                               ;; 0e:5943 $00

script_045e:
    sGIVE_EQUIPMENT INV_SHIELD_IRON                    ;; 0e:5944 $d8 $1c
    sIF_FLAG !wScriptFlags.5                           ;; 0e:5946 $08 $85 $00 $12
      sSFX 15                                          ;; 0e:594a $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:594c $af
      sMSG                                             ;; 0e:594d $04
        db "<10>Found <SHIELD>Iron.<12>"
        db "<11>", $00 ;; 0e:594e
      sSET_FLAG wScriptFlags09.7                       ;; 0e:595a $da $4f
    sENDIF                                             ;; 0e:595c
    sEND                                               ;; 0e:595c $00

script_045f:
    sGIVE_EQUIPMENT INV_ARMOR_GOLD                     ;; 0e:595d $d8 $13
    sIF_FLAG !wScriptFlags.5                           ;; 0e:595f $08 $85 $00 $13
      sSFX 15                                          ;; 0e:5963 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:5965 $af
      sMSG                                             ;; 0e:5966 $04
        db "<10>Found <ARMOR>Gold.<12>"
        db "<11>", $00 ;; 0e:5967
      sSET_FLAG wScriptFlags07.1                       ;; 0e:5974 $da $39
    sENDIF                                             ;; 0e:5976
    sEND                                               ;; 0e:5976 $00

script_0460:
    sGIVE_EQUIPMENT INV_AXE_WERE                       ;; 0e:5977 $d8 $06
    sIF_FLAG !wScriptFlags.5                           ;; 0e:5979 $08 $85 $00 $11
      sSFX 15                                          ;; 0e:597d $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:597f $af
      sMSG                                             ;; 0e:5980 $04
        db "<10>Found <AXE>Were.<12>"
        db "<11>", $00 ;; 0e:5981
      sSET_FLAG wScriptFlags07.7                       ;; 0e:598c $da $3f
    sENDIF                                             ;; 0e:598e
    sEND                                               ;; 0e:598e $00

script_0461:
    sGIVE_EQUIPMENT INV_AXE_ZEUS                       ;; 0e:598f $d8 $0c
    sIF_FLAG !wScriptFlags.5                           ;; 0e:5991 $08 $85 $00 $12
      sSFX 15                                          ;; 0e:5995 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:5997 $af
      sMSG                                             ;; 0e:5998 $04
        db "<10>Found <AXE>Zeus.<12>"
        db "<11>", $00 ;; 0e:5999
      sSET_FLAG wScriptFlags07.6                       ;; 0e:59a5 $da $3e
    sENDIF                                             ;; 0e:59a7
    sEND                                               ;; 0e:59a7 $00

script_0462:
    sGIVE_EQUIPMENT INV_SHIELD_AEGIS                   ;; 0e:59a8 $d8 $21
    sIF_FLAG !wScriptFlags.5                           ;; 0e:59aa $08 $85 $00 $13
      sSFX 15                                          ;; 0e:59ae $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:59b0 $af
      sMSG                                             ;; 0e:59b1 $04
        db "<10>Found <SHIELD>Aegis!<12>"
        db "<11>", $00 ;; 0e:59b2
      sSET_FLAG wScriptFlags07.5                       ;; 0e:59bf $da $3d
    sENDIF                                             ;; 0e:59c1
    sEND                                               ;; 0e:59c1 $00

script_0463:
    sGIVE_EQUIPMENT INV_SWORD_BLOOD                    ;; 0e:59c2 $d8 $08
    sIF_FLAG !wScriptFlags.5                           ;; 0e:59c4 $08 $85 $00 $13
      sSFX 15                                          ;; 0e:59c8 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:59ca $af
      sMSG                                             ;; 0e:59cb $04
        db "<10>Found <SWORD>Blood.<12>"
        db "<11>", $00 ;; 0e:59cc
      sSET_FLAG wScriptFlags07.4                       ;; 0e:59d9 $da $3c
    sENDIF                                             ;; 0e:59db
    sEND                                               ;; 0e:59db $00

script_0464:
    sGIVE_EQUIPMENT INV_SWORD_ICE                      ;; 0e:59dc $d8 $0b
    sIF_FLAG !wScriptFlags.5                           ;; 0e:59de $08 $85 $00 $1c
      sSFX 15                                          ;; 0e:59e2 $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:59e4 $af
      sMSG                                             ;; 0e:59e5 $04
        db "<10>Found <SWORD>Ice.<12>"
        db "<11>", $00 ;; 0e:59e6
      sSET_FLAG wScriptFlags07.2                       ;; 0e:59f1 $da $3a
      sDELAY 40                                        ;; 0e:59f3 $f0 $28
      sLOAD_ROOM 0, $d3, 12, 6                         ;; 0e:59f5 $f4 $00 $d3 $0c $06
      sSET_MUSIC 25                                    ;; 0e:59fa $f8 $19
      sCLEAR_ROOM_HISTORY                              ;; 0e:59fc $ab
      sRUN_ROOM_SCRIPT                                 ;; 0e:59fd $ec
    sENDIF                                             ;; 0e:59fe
    sEND                                               ;; 0e:59fe $00

script_0465:
    sEND                                               ;; 0e:59ff $00

script_0466:
    sGIVE_MAGIC INV_MAGIC_ICE                          ;; 0e:5a00 $d6 $05
    sSFX 15                                            ;; 0e:5a02 $f9 $0f
    sCHANGE_INTO_EMPTY_CHEST                           ;; 0e:5a04 $af
    sMSG                                               ;; 0e:5a05 $04
      db "<10>Found the Book\nof Undine!\nLearned Ice.<12>"
      db "<11>", $00 ;; 0e:5a06
    sSET_FLAG wScriptFlags09.2                         ;; 0e:5a24 $da $4a
    sEND                                               ;; 0e:5a26 $00

script_0467:
    sGIVE_ITEM INV_ITEM_SPELL_SILENCE                  ;; 0e:5a27 $d4 $0a
    sIF_FLAG !wScriptFlags.5                           ;; 0e:5a29 $08 $85 $00 $11
      sSFX 15                                          ;; 0e:5a2d $f9 $0f
      sCHANGE_INTO_EMPTY_CHEST                         ;; 0e:5a2f $af
      sMSG                                             ;; 0e:5a30 $04
        db "<10>Found <SPEL>Silence.<12>"
        db "<11>", $00 ;; 0e:5a31
    sENDIF                                             ;; 0e:5a3e
    sEND                                               ;; 0e:5a3e $00

script_0470:
    sIF_FLAG wScriptFlags0D.7                          ;; 0e:5a3f $08 $6f $00 $22
      sIF_FLAG !wScriptFlags0E.0                       ;; 0e:5a43 $08 $f0 $00 $05
        sCALL script_0471                              ;; 0e:5a47 $02 $5a $7c
      sELSE                                            ;; 0e:5a4a $01 $17
        sMSG                                           ;; 0e:5a4c $04
          db "<10>  Cannot land on\n    the water.<12>"
          db "<11>", $00 ;; 0e:5a4d
      sENDIF                                           ;; 0e:5a63
    sELSE                                              ;; 0e:5a63 $01 $16
      ; Remove Poison, Stone, and Moogle.
      ; Originally only Moogle was removed.
      ; If you had Poison and you immediately hopped off again Poison would be running with normal music.
      ; If you had Stone you would be stuck until you hopped off again.
      sPLAYER_CURE_STATUS 13
      sSFX 7                                           ;; 0e:5a67 $f9 $07
      sDELAY 7                                         ;; 0e:5a69 $f0 $07
      sSFX 7                                           ;; 0e:5a6b $f9 $07
      sIF_FLAG !wScriptFlags04.1                       ;; 0e:5a6d $08 $a1 $00 $01
        sPLAYER_ON_CHOCOBO                             ;; 0e:5a71 $a0
      sENDIF                                           ;; 0e:5a72
      sIF_FLAG wScriptFlags04.1                        ;; 0e:5a72 $08 $21 $00 $01
        sPLAYER_ON_CHOCOBOT                            ;; 0e:5a76 $a1
      sENDIF                                           ;; 0e:5a77
      sSET_MUSIC 6                                     ;; 0e:5a77 $f8 $06
      sSET_FLAG wScriptFlags0D.7                       ;; 0e:5a79 $da $6f
    sENDIF                                             ;; 0e:5a7b
    sEND                                               ;; 0e:5a7b $00

script_0471:
    sSET_PLAYER_NORMAL_SPRITE                          ;; 0e:5a7c $a4
    sIF_FLAG !wScriptFlags03.7                         ;; 0e:5a7d $08 $9f $00 $04
      sSET_MUSIC 20                                    ;; 0e:5a81 $f8 $14
    sELSE                                              ;; 0e:5a83 $01 $02
      sSET_MUSIC 25                                    ;; 0e:5a85 $f8 $19
    sENDIF                                             ;; 0e:5a87
    sSFX 7                                             ;; 0e:5a87 $f9 $07
    sDELAY 7                                           ;; 0e:5a89 $f0 $07
    sSFX 7                                             ;; 0e:5a8b $f9 $07
    sCLEAR_FLAG wScriptFlags0D.7                       ;; 0e:5a8d $db $6f
    sEND                                               ;; 0e:5a8f $00

script_0472:
    sIF_FLAG wScriptFlags04.1
      sMSG
        db "<10>Take Chocobot\nwith you?<12><13><00>"
    sELSE
      sMSG
        db "<10>Take your\nChocobo with you?<12><13><00>"
    sENDIF
    sIF_FLAG !wScriptFlags0F.7                         ;; 0e:5aa8 $08 $ff $00 $2c
; Originally Chocobo was unconditionally loaded, but the correct graphics were loaded by the group.
; The color code runs when an NPC is spawned, so if Chocobot had different colors
; it still would use Chocobo's.
      sIF_FLAG wScriptFlags04.1
        sGIVE_FOLLOWER 8
      sELSE
        sGIVE_FOLLOWER 9
      sENDIF
      sSET_FLAG wScriptFlags0B.0                       ;; 0e:5aae $da $58
      sCLEAR_FLAG wScriptFlags0B.3                     ;; 0e:5ab0 $db $5b
      sCLEAR_FLAG wScriptFlags0B.4                     ;; 0e:5ab2 $db $5c
      sCLEAR_FLAG wScriptFlags0B.5                     ;; 0e:5ab4 $db $5d
      sCLEAR_FLAG wScriptFlags0B.6                     ;; 0e:5ab6 $db $5e
      sCLEAR_FLAG wScriptFlags0B.7                     ;; 0e:5ab8 $db $5f
      sCLEAR_FLAG wScriptFlags0C.0                     ;; 0e:5aba $db $60
      sCLEAR_FLAG wScriptFlags0C.1                     ;; 0e:5abc $db $61
      sCLEAR_FLAG wScriptFlags0C.2                     ;; 0e:5abe $db $62
      sCLEAR_FLAG wScriptFlags0C.3                     ;; 0e:5ac0 $db $63
      sCLEAR_FLAG wScriptFlags0C.4                     ;; 0e:5ac2 $db $64
      sCLEAR_FLAG wScriptFlags0C.5                     ;; 0e:5ac4 $db $65
      sCLEAR_FLAG wScriptFlags0C.6                     ;; 0e:5ac6 $db $66
      sCLEAR_FLAG wScriptFlags0C.7                     ;; 0e:5ac8 $db $67
      sCLEAR_FLAG wScriptFlags0D.0                     ;; 0e:5aca $db $68
      sCLEAR_FLAG wScriptFlags0D.1                     ;; 0e:5acc $db $69
      sCLEAR_FLAG wScriptFlags0D.2                     ;; 0e:5ace $db $6a
      sCLEAR_FLAG wScriptFlags0D.3                     ;; 0e:5ad0 $db $6b
      sCLEAR_FLAG wScriptFlags0D.4                     ;; 0e:5ad2 $db $6c
      sCLEAR_FLAG wScriptFlags0D.5                     ;; 0e:5ad4 $db $6d
      sCLEAR_FLAG wScriptFlags0D.6                     ;; 0e:5ad6 $db $6e
    sENDIF                                             ;; 0e:5ad8
    sMSG                                               ;; 0e:5ad8 $04
      db "<11>", $00                                   ;; 0e:5ad9
    sSFX 7                                             ;; 0e:5adb $f9 $07
    sDELAY 7                                           ;; 0e:5add $f0 $07
    sSFX 7                                             ;; 0e:5adf $f9 $07
    sEND                                               ;; 0e:5ae1 $00

script_0473:
    sMSG                                               ;; 0e:5ae2 $04
      db "<10> Wait for me!<12>"
      db "<11>", $00  ;; 0e:5ae3
    sFOLLOWER_DELETE                                   ;; 0e:5aee $98
    sCLEAR_FLAG wScriptFlags0B.0                       ;; 0e:5aef $db $58
    sEND                                               ;; 0e:5af1 $00

script_0474:
    sIF_TRIGGERED_ON_BY $f1                            ;; 0e:5af2 $0b $f1 $00 $03
      sPLAYER_ON_CHOCOBOT_WATER                        ;; 0e:5af6 $a2
      sSET_FLAG wScriptFlags0E.0                       ;; 0e:5af7 $da $70
    sENDIF                                             ;; 0e:5af9
    sIF_TRIGGERED_ON_BY $f5                            ;; 0e:5af9 $0b $f5 $00 $03
      sPLAYER_ON_CHOCOBOT                              ;; 0e:5afd $a1
      sCLEAR_FLAG wScriptFlags0E.0                     ;; 0e:5afe $db $70
    sENDIF                                             ;; 0e:5b00
    sEND                                               ;; 0e:5b00 $00

script_0475:
    sIF_FLAG !wScriptFlags0B.0                         ;; 0e:5b01 $08 $d8 $00 $12
      sIF_FLAG !wScriptFlags04.1                       ;; 0e:5b05 $08 $a1 $00 $08
        sSET_NPC_TYPES 80                              ;; 0e:5b09 $fc $50
        sDELAY 6                                       ;; 0e:5b0b $f0 $06
        sSPAWN_NPC 2                                   ;; 0e:5b0d $fd $02
      sELSE                                            ;; 0e:5b0f $01 $06
        sSET_NPC_TYPES 101                             ;; 0e:5b11 $fc $65
        sDELAY 6                                       ;; 0e:5b13 $f0 $06
        sSPAWN_NPC 0                                   ;; 0e:5b15 $fd $00
      sENDIF                                           ;; 0e:5b17
    sENDIF                                             ;; 0e:5b17
    sEND                                               ;; 0e:5b17 $00

script_0476:
    sIF_FLAG wScriptFlags0B.7                          ;; 0e:5b18 $08 $5f $00 $03
      sCALL script_0475                                ;; 0e:5b1c $02 $5b $01
    sENDIF                                             ;; 0e:5b1f
    sEND                                               ;; 0e:5b1f $00

script_0477:
    sEND                                               ;; 0e:5b20 $00

script_0478:
    sEND                                               ;; 0e:5b21 $00

script_0479:
    sIF_FLAG wScriptFlags0B.3                          ;; 0e:5b22 $08 $5b $00 $03
      sCALL script_0475                                ;; 0e:5b26 $02 $5b $01
    sENDIF                                             ;; 0e:5b29
    sEND                                               ;; 0e:5b29 $00

script_047a:
    sEND                                               ;; 0e:5b2a $00

script_047b:
    sEND                                               ;; 0e:5b2b $00

script_047c:
    sIF_FLAG wScriptFlags0B.4                          ;; 0e:5b2c $08 $5c $00 $03
      sCALL script_0475                                ;; 0e:5b30 $02 $5b $01
    sENDIF                                             ;; 0e:5b33
    sCLEAR_FLAG wScriptFlags0F.0                       ;; 0e:5b33 $db $78
    sCLEAR_FLAG wScriptFlags0F.1                       ;; 0e:5b35 $db $79
    sCLEAR_FLAG wScriptFlags0F.2                       ;; 0e:5b37 $db $7a
    sCLEAR_FLAG wScriptFlags0F.3                       ;; 0e:5b39 $db $7b
    sEND                                               ;; 0e:5b3b $00

script_047d:
    sEND                                               ;; 0e:5b3c $00

script_047e:
    sEND                                               ;; 0e:5b3d $00

script_047f:
    sEND                                               ;; 0e:5b3e $00

script_0480:
    sEND                                               ;; 0e:5b3f $00

script_0481:
    sEND                                               ;; 0e:5b40 $00

script_0482:
    sIF_FLAG wScriptFlags0B.6                          ;; 0e:5b41 $08 $5e $00 $03
      sCALL script_0475                                ;; 0e:5b45 $02 $5b $01
    sENDIF                                             ;; 0e:5b48
    sEND                                               ;; 0e:5b48 $00

script_0483:
    sEND                                               ;; 0e:5b49 $00

script_0484:
    sEND                                               ;; 0e:5b4a $00

script_0485:
    sIF_FLAG wScriptFlags0C.0                          ;; 0e:5b4b $08 $60 $00 $03
      sCALL script_0475                                ;; 0e:5b4f $02 $5b $01
    sENDIF                                             ;; 0e:5b52
    sEND                                               ;; 0e:5b52 $00

script_0486:
    sEND                                               ;; 0e:5b53 $00

script_0487:
    sEND                                               ;; 0e:5b54 $00

script_0488:
    sIF_FLAG wScriptFlags0C.1                          ;; 0e:5b55 $08 $61 $00 $03
      sCALL script_0475                                ;; 0e:5b59 $02 $5b $01
    sENDIF                                             ;; 0e:5b5c
    sEND                                               ;; 0e:5b5c $00

script_0489:
    sEND                                               ;; 0e:5b5d $00

script_048a:
    sEND                                               ;; 0e:5b5e $00

script_048b:
    sIF_FLAG wScriptFlags0C.2                          ;; 0e:5b5f $08 $62 $00 $03
      sCALL script_0475                                ;; 0e:5b63 $02 $5b $01
    sENDIF                                             ;; 0e:5b66
    sEND                                               ;; 0e:5b66 $00

script_048c:
    sEND                                               ;; 0e:5b67 $00

script_048d:
    sEND                                               ;; 0e:5b68 $00

script_048e:
    sIF_FLAG wScriptFlags0C.3                          ;; 0e:5b69 $08 $63 $00 $03
      sCALL script_0475                                ;; 0e:5b6d $02 $5b $01
    sENDIF                                             ;; 0e:5b70
    sEND                                               ;; 0e:5b70 $00

script_048f:
    sEND                                               ;; 0e:5b71 $00

script_0490:
    sEND                                               ;; 0e:5b72 $00

script_0491:
    sIF_FLAG wScriptFlags0C.4                          ;; 0e:5b73 $08 $64 $00 $03
      sCALL script_0475                                ;; 0e:5b77 $02 $5b $01
    sENDIF                                             ;; 0e:5b7a
    sEND                                               ;; 0e:5b7a $00

script_0492:
    sEND                                               ;; 0e:5b7b $00

script_0493:
    sEND                                               ;; 0e:5b7c $00

script_0494:
    sIF_FLAG wScriptFlags0C.5                          ;; 0e:5b7d $08 $65 $00 $03
      sCALL script_0475                                ;; 0e:5b81 $02 $5b $01
    sENDIF                                             ;; 0e:5b84
    sEND                                               ;; 0e:5b84 $00

script_0495:
    sEND                                               ;; 0e:5b85 $00

script_0496:
    sEND                                               ;; 0e:5b86 $00

script_0497:
    sIF_FLAG wScriptFlags0C.6                          ;; 0e:5b87 $08 $66 $00 $03
      sCALL script_0475                                ;; 0e:5b8b $02 $5b $01
    sENDIF                                             ;; 0e:5b8e
    sEND                                               ;; 0e:5b8e $00

script_0498:
    sEND                                               ;; 0e:5b8f $00

script_0499:
    sEND                                               ;; 0e:5b90 $00

script_049a:
    sIF_FLAG wScriptFlags0C.7                          ;; 0e:5b91 $08 $67 $00 $03
      sCALL script_0475                                ;; 0e:5b95 $02 $5b $01
    sENDIF                                             ;; 0e:5b98
    sIF_FLAG !wScriptFlags06.6                         ;; 0e:5b98 $08 $b6 $00 $08
      sSET_NPC_TYPES 52                                ;; 0e:5b9c $fc $34
      sDELAY 10                                        ;; 0e:5b9e $f0 $0a
      sSPAWN_NPC 2                                     ;; 0e:5ba0 $fd $02
    sELSE                                              ;; 0e:5ba2 $01 $04
      sSET_ROOM_TILE $4b, 7, 5                         ;; 0e:5ba4 $b0 $4b $07 $05
    sENDIF                                             ;; 0e:5ba8
    sEND                                               ;; 0e:5ba8 $00

script_049b:
    sEND                                               ;; 0e:5ba9 $00

script_049c:
    sEND                                               ;; 0e:5baa $00

script_049d:
    sIF_FLAG wScriptFlags0D.0                          ;; 0e:5bab $08 $68 $00 $03
      sCALL script_0475                                ;; 0e:5baf $02 $5b $01
    sENDIF                                             ;; 0e:5bb2
    sEND                                               ;; 0e:5bb2 $00

script_049e:
    sEND                                               ;; 0e:5bb3 $00

script_049f:
    sEND                                               ;; 0e:5bb4 $00

script_04a0:
    sIF_FLAG wScriptFlags0D.1                          ;; 0e:5bb5 $08 $69 $00 $03
      sCALL script_0475                                ;; 0e:5bb9 $02 $5b $01
    sENDIF                                             ;; 0e:5bbc
    sEND                                               ;; 0e:5bbc $00

script_04a1:
    sEND                                               ;; 0e:5bbd $00

script_04a2:
    sEND                                               ;; 0e:5bbe $00

script_04a3:
    sIF_FLAG wScriptFlags0D.2                          ;; 0e:5bbf $08 $6a $00 $03
      sCALL script_0475                                ;; 0e:5bc3 $02 $5b $01
    sENDIF                                             ;; 0e:5bc6
    sEND                                               ;; 0e:5bc6 $00

script_04a4:
    sEND                                               ;; 0e:5bc7 $00

script_04a5:
    sEND                                               ;; 0e:5bc8 $00

script_04a6:
    sIF_FLAG wScriptFlags0D.3                          ;; 0e:5bc9 $08 $6b $00 $03
      sCALL script_04af                                ;; 0e:5bcd $02 $5b $e7
    sENDIF                                             ;; 0e:5bd0
    sEND                                               ;; 0e:5bd0 $00

script_04a7:
    sEND                                               ;; 0e:5bd1 $00

script_04a8:
    sEND                                               ;; 0e:5bd2 $00

script_04a9:
    sIF_FLAG wScriptFlags0D.4                          ;; 0e:5bd3 $08 $6c $00 $03
      sCALL script_0475                                ;; 0e:5bd7 $02 $5b $01
    sENDIF                                             ;; 0e:5bda
    sEND                                               ;; 0e:5bda $00

script_04aa:
    sEND                                               ;; 0e:5bdb $00

script_04ab:
    sEND                                               ;; 0e:5bdc $00

script_04ac:
    sIF_FLAG wScriptFlags0D.5                          ;; 0e:5bdd $08 $6d $00 $03
      sCALL script_0475                                ;; 0e:5be1 $02 $5b $01
    sENDIF                                             ;; 0e:5be4
    sEND                                               ;; 0e:5be4 $00

script_04ad:
    sEND                                               ;; 0e:5be5 $00

script_04ae:
    sEND                                               ;; 0e:5be6 $00

script_04af:
    sIF_FLAG !wScriptFlags0B.0                         ;; 0e:5be7 $08 $d8 $00 $12
      sIF_FLAG !wScriptFlags04.1                       ;; 0e:5beb $08 $a1 $00 $08
        sSET_NPC_TYPES 83                              ;; 0e:5bef $fc $53
        sDELAY 6                                       ;; 0e:5bf1 $f0 $06
        sSPAWN_NPC 0                                   ;; 0e:5bf3 $fd $00
      sELSE                                            ;; 0e:5bf5 $01 $06
        sSET_NPC_TYPES 101                             ;; 0e:5bf7 $fc $65
        sDELAY 6                                       ;; 0e:5bf9 $f0 $06
        sSPAWN_NPC 2                                   ;; 0e:5bfb $fd $02
      sENDIF                                           ;; 0e:5bfd
    sENDIF                                             ;; 0e:5bfd
    sEND                                               ;; 0e:5bfd $00

script_04b0:
    sIF_TRIGGERED_ON_BY $f1                            ;; 0e:5bfe $0b $f1 $00 $03
      sCALL script_0470                                ;; 0e:5c02 $02 $5a $3f
    sENDIF                                             ;; 0e:5c05
    sIF_TRIGGERED_ON_BY $c9, $c1, $f1                  ;; 0e:5c05 $0b $c9 $c1 $f1 $00 $32
      sIF_FLAG wScriptFlags0B.0                        ;; 0e:5c0b $08 $58 $00 $2e
        sMSG                                           ;; 0e:5c0f $04
          db "<10>It's too cold for\nyou ahead.\nWait for me here.<12>"
          db "<11>", $00 ;; 0e:5c10
        sFOLLOWER_DIRECTION_DOWN                       ;; 0e:5c32 $95
        sLOOP 4, 2                                     ;; 0e:5c33 $03 $04 $02
          sFOLLOWER_STEP_FORWARD                       ;; 0e:5c36 $90
        sEND                                           ;; 0e:5c37 $00
        sFOLLOWER_DELETE                               ;; 0e:5c38 $98
        sCLEAR_FLAG wScriptFlags0B.0                   ;; 0e:5c39 $db $58
        sSET_FLAG wScriptFlags0B.6                     ;; 0e:5c3b $da $5e
      sENDIF                                           ;; 0e:5c3d
    sENDIF                                             ;; 0e:5c3d
    sEND                                               ;; 0e:5c3d $00

script_04d0:
    sIF_TRIGGERED_ON_BY $a9                            ;; 0e:5c3e $0b $a9 $00 $03
      sSFX 16                                          ;; 0e:5c42 $f9 $10
      sOPEN_EAST_DOOR                                  ;; 0e:5c44 $e4
    sENDIF                                             ;; 0e:5c45
    sEND                                               ;; 0e:5c45 $00

script_04d1:
    sEND                                               ;; 0e:5c46 $00

script_04d2:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:5c47 $0b $c9 $c1 $00 $05
      sLOAD_ROOM 4, $57, 16, 12                        ;; 0e:5c4c $f4 $04 $57 $10 $0c
    sENDIF                                             ;; 0e:5c51
    sEND                                               ;; 0e:5c51 $00

script_04d3:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:5c52 $0b $c9 $c1 $00 $0c
      sLOAD_ROOM 0, $70, 14, 10                        ;; 0e:5c57 $f4 $00 $70 $0e $0a
      sSET_MUSIC 25                                    ;; 0e:5c5c $f8 $19
      sSET_ROOM_TILE $4b, 7, 5                         ;; 0e:5c5e $b0 $4b $07 $05
      sRUN_ROOM_SCRIPT                                 ;; 0e:5c62 $ec
    sENDIF                                             ;; 0e:5c63
    sEND                                               ;; 0e:5c63 $00

script_04d4:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5c64 $0b $c9 $00 $05
      sLOAD_ROOM 5, $27, 8, 6                          ;; 0e:5c68 $f4 $05 $27 $08 $06
    sENDIF                                             ;; 0e:5c6d
    sEND                                               ;; 0e:5c6d $00

script_04d5:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5c6e $0b $c9 $00 $05
      sLOAD_ROOM 4, $27, 8, 8                          ;; 0e:5c72 $f4 $04 $27 $08 $08
    sENDIF                                             ;; 0e:5c77
    sEND                                               ;; 0e:5c77 $00

script_04d6:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5c78 $0b $c9 $00 $05
      sLOAD_ROOM 6, $34, 16, 2                         ;; 0e:5c7c $f4 $06 $34 $10 $02
    sENDIF                                             ;; 0e:5c81
    sEND                                               ;; 0e:5c81 $00

script_04d7:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5c82 $0b $c9 $00 $05
      sLOAD_ROOM 5, $34, 16, 2                         ;; 0e:5c86 $f4 $05 $34 $10 $02
    sENDIF                                             ;; 0e:5c8b
    sEND                                               ;; 0e:5c8b $00

script_04d8:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:5c8c $0b $c9 $c1 $00 $05
      sLOAD_ROOM 8, $00, 2, 2                          ;; 0e:5c91 $f4 $08 $00 $02 $02
    sENDIF                                             ;; 0e:5c96
    sEND                                               ;; 0e:5c96 $00

script_04d9:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:5c97 $0b $c9 $c1 $00 $74
      sLOAD_ROOM 5, $72, 16, 2                         ;; 0e:5c9c $f4 $05 $72 $10 $02
      sIF_FLAG !wScriptFlags03.6                       ;; 0e:5ca1 $08 $9e $00 $6b
        sSET_NPC_TYPES 50                              ;; 0e:5ca5 $fc $32
        sSPAWN_NPC 1                                   ;; 0e:5ca7 $fd $01
        sSET_PLAYER_DIRECTION_DOWN                     ;; 0e:5ca9 $85
        sSET_NPC_1_DIRECTION_UP                        ;; 0e:5caa $14
        sLOOP 4, 3                                     ;; 0e:5cab $03 $04 $03
          sPLAYER_STEP_FORWARD                         ;; 0e:5cae $80
          sNPC_1_STEP_FORWARD                          ;; 0e:5caf $10
        sEND                                           ;; 0e:5cb0 $00
        sSET_PLAYER_DIRECTION_LEFT                     ;; 0e:5cb1 $87
        sSET_NPC_1_DIRECTION_RIGHT                     ;; 0e:5cb2 $16
        sPLAYER_STEP_FORWARD                           ;; 0e:5cb3 $80
        sNPC_1_STEP_FORWARD                            ;; 0e:5cb4 $10
        sPLAYER_STEP_FORWARD                           ;; 0e:5cb5 $80
        sNPC_1_STEP_FORWARD                            ;; 0e:5cb6 $10
        sMSG                                           ;; 0e:5cb7 $04
          db "<10><BOY>:<GIRL>!\n They took the\n Pendant!<12>"
          db "<1b><GIRL>:We have to\n get it back!\n __ Let's go!<12>"
          db "<1b> Shadow Knight's\n room is on the\n top floor!<12>"
          db "<11>", $00 ;; 0e:5cb8
        sGIVE_FOLLOWER 1                               ;; 0e:5d0a $9c $01
        sSET_FLAG wScriptFlags03.6                     ;; 0e:5d0c $da $1e
        sSET_FLAG wScriptFlags0A.1                     ;; 0e:5d0e $da $51
      sENDIF                                           ;; 0e:5d10
    sENDIF                                             ;; 0e:5d10
    sEND                                               ;; 0e:5d10 $00

script_04da:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:5d11 $0b $c9 $c1 $00 $05
      sLOAD_ROOM 6, $71, 16, 2                         ;; 0e:5d16 $f4 $06 $71 $10 $02
    sENDIF                                             ;; 0e:5d1b
    sEND                                               ;; 0e:5d1b $00

script_04db:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5d1c $0b $c9 $00 $05
      sLOAD_ROOM 10, $40, 16, 2                        ;; 0e:5d20 $f4 $0a $40 $10 $02
    sENDIF                                             ;; 0e:5d25
    sEND                                               ;; 0e:5d25 $00

script_04dc:
    sIF_TRIGGERED_ON_BY $c9, $c1                       ;; 0e:5d26 $0b $c9 $c1 $00 $09
      sLOAD_ROOM 9, $10, 16, 2                         ;; 0e:5d2b $f4 $09 $10 $10 $02
      sSET_ROOM_TILE $02, 8, 1                         ;; 0e:5d30 $b0 $02 $08 $01
    sENDIF                                             ;; 0e:5d34
    sEND                                               ;; 0e:5d34 $00

script_04dd:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5d35 $0b $c9 $00 $05
      sLOAD_ROOM 9, $20, 2, 2                          ;; 0e:5d39 $f4 $09 $20 $02 $02
    sENDIF                                             ;; 0e:5d3e
    sEND                                               ;; 0e:5d3e $00

script_04de:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5d3f $0b $c9 $00 $05
      sLOAD_ROOM 10, $50, 2, 2                         ;; 0e:5d43 $f4 $0a $50 $02 $02
    sENDIF                                             ;; 0e:5d48
    sEND                                               ;; 0e:5d48 $00

script_04df:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5d49 $0b $c9 $00 $08
      sUNK_C5 5                                        ;; 0e:5d4d $c5 $05
      sLOAD_ROOM 2, $01, 9, 12                         ;; 0e:5d4f $f4 $02 $01 $09 $0c
      sRUN_ROOM_SCRIPT                                 ;; 0e:5d54 $ec
    sENDIF                                             ;; 0e:5d55
    sEND                                               ;; 0e:5d55 $00

; This is the first chest switch puzzle encountered.
; Unlike the others this also triggers on the player as a teaching aid.
; This chang establishes a counter for the number of things currently on the switch. 
script_04e0:
    sIF_TRIGGERED_ON_BY $c9, $91, $a9                  ;; 0e:5d56 $0b $c9 $91 $a9 $00 $06
      sIF_FLAG wScriptFlags0F.0
        sSET_FLAG wScriptFlags0F.1
      sELSE
        sSFX 24
        sSET_ROOM_TILE $02, 8, 1
        sSET_FLAG wScriptFlags0F.0
      sENDIF
    sENDIF
    sIF_TRIGGERED_OFF_BY $c9, $91, $a9                 ;; 0e:5d62 $0c $c9 $91 $a9 $00 $06
      sIF_FLAG wScriptFlags0F.0
        sIF_FLAG wScriptFlags0F.1
          sCLEAR_FLAG wScriptFlags0F.1
        sELSE
          sSFX 24
          sSET_ROOM_TILE $00, 8, 1
          sCLEAR_FLAG wScriptFlags0F.0
        sENDIF
      sENDIF
    sENDIF
    sEND                                               ;; 0e:5d6e $00

script_04e1:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5d6f $0b $c9 $00 $02
      sSET_FLAG wScriptFlags0F.0                       ;; 0e:5d73 $da $78
    sENDIF                                             ;; 0e:5d75
    sEND                                               ;; 0e:5d75 $00

script_04e2:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5d76 $0b $c9 $00 $0a
      sSET_FLAG wScriptFlags0F.1                       ;; 0e:5d7a $da $79
      sIF_FLAG !wScriptFlags0F.0                       ;; 0e:5d7c $08 $f8 $00 $04
        sCLEAR_FLAG wScriptFlags0F.1                   ;; 0e:5d80 $db $79
        sCLEAR_FLAG wScriptFlags0F.2                   ;; 0e:5d82 $db $7a
      sENDIF                                           ;; 0e:5d84
    sENDIF                                             ;; 0e:5d84
    sEND                                               ;; 0e:5d84 $00

script_04e3:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5d85 $0b $c9 $00 $12
      sSET_FLAG wScriptFlags0F.2                       ;; 0e:5d89 $da $7a
      sIF_FLAG !wScriptFlags0F.0                       ;; 0e:5d8b $08 $f8 $00 $04
        sCLEAR_FLAG wScriptFlags0F.1                   ;; 0e:5d8f $db $79
        sCLEAR_FLAG wScriptFlags0F.2                   ;; 0e:5d91 $db $7a
      sENDIF                                           ;; 0e:5d93
      sIF_FLAG !wScriptFlags0F.1                       ;; 0e:5d93 $08 $f9 $00 $04
        sCLEAR_FLAG wScriptFlags0F.0                   ;; 0e:5d97 $db $78
        sCLEAR_FLAG wScriptFlags0F.2                   ;; 0e:5d99 $db $7a
      sENDIF                                           ;; 0e:5d9b
    sENDIF                                             ;; 0e:5d9b
    sEND                                               ;; 0e:5d9b $00

script_04e4:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5d9c $0b $c9 $00 $14
      sIF_FLAG wScriptFlags0F.0, wScriptFlags0F.1, wScriptFlags0F.2 ;; 0e:5da0 $08 $78 $79 $7a $00 $08
        sSFX 24                                        ;; 0e:5da6 $f9 $18
        sSET_ROOM_TILE $02, 8, 6                       ;; 0e:5da8 $b0 $02 $08 $06
      sELSE                                            ;; 0e:5dac $01 $06
        sCLEAR_FLAG wScriptFlags0F.0                   ;; 0e:5dae $db $78
        sCLEAR_FLAG wScriptFlags0F.1                   ;; 0e:5db0 $db $79
        sCLEAR_FLAG wScriptFlags0F.2                   ;; 0e:5db2 $db $7a
      sENDIF                                           ;; 0e:5db4
    sENDIF                                             ;; 0e:5db4
    sEND                                               ;; 0e:5db4 $00

script_04e5:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5db5 $0b $c9 $00 $06
      sSFX 24                                          ;; 0e:5db9 $f9 $18
      sSET_ROOM_TILE $00, 8, 1                         ;; 0e:5dbb $b0 $00 $08 $01
    sENDIF                                             ;; 0e:5dbf
    sEND                                               ;; 0e:5dbf $00

script_04e6:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5dc0 $0b $c9 $00 $06
      sSFX 24                                          ;; 0e:5dc4 $f9 $18
      sSET_ROOM_TILE $02, 8, 1                         ;; 0e:5dc6 $b0 $02 $08 $01
    sENDIF                                             ;; 0e:5dca
    sEND                                               ;; 0e:5dca $00

script_04e7:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5dcb $0b $c9 $00 $1a
      sSFX 16                                          ;; 0e:5dcf $f9 $10
      sSET_ROOM_TILE $00, 2, 1                         ;; 0e:5dd1 $b0 $00 $02 $01
      sSET_ROOM_TILE $00, 2, 2                         ;; 0e:5dd5 $b0 $00 $02 $02
      sSET_ROOM_TILE $00, 2, 3                         ;; 0e:5dd9 $b0 $00 $02 $03
      sSET_ROOM_TILE $00, 2, 4                         ;; 0e:5ddd $b0 $00 $02 $04
      sSET_ROOM_TILE $00, 2, 5                         ;; 0e:5de1 $b0 $00 $02 $05
      sSET_ROOM_TILE $00, 2, 6                         ;; 0e:5de5 $b0 $00 $02 $06
    sENDIF                                             ;; 0e:5de9
    sEND                                               ;; 0e:5de9 $00

script_04e8:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5dea $0b $c9 $00 $06
      sSFX 24                                          ;; 0e:5dee $f9 $18
      sSET_ROOM_TILE $02, 8, 6                         ;; 0e:5df0 $b0 $02 $08 $06
    sENDIF                                             ;; 0e:5df4
    sEND                                               ;; 0e:5df4 $00

script_04e9:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5df5 $0b $c9 $00 $04
      sSET_ROOM_TILE $02, 8, 6                         ;; 0e:5df9 $b0 $02 $08 $06
    sENDIF                                             ;; 0e:5dfd
    sEND                                               ;; 0e:5dfd $00

script_04ea:
    sIF_TRIGGERED_ON_BY $a9, $a9                       ;; 0e:5dfe $0b $a9 $a9 $00 $0c
      sSET_FLAG wScriptFlags0F.0                       ;; 0e:5e03 $da $78
      sIF_FLAG wScriptFlags0F.1                        ;; 0e:5e05 $08 $79 $00 $06
        sSFX 24                                        ;; 0e:5e09 $f9 $18
        sSET_ROOM_TILE $02, 8, 6                       ;; 0e:5e0b $b0 $02 $08 $06
      sENDIF                                           ;; 0e:5e0f
    sENDIF                                             ;; 0e:5e0f
    sIF_TRIGGERED_OFF_BY $a9, $a9                      ;; 0e:5e0f $0c $a9 $a9 $00 $02
      sCLEAR_FLAG wScriptFlags0F.0                     ;; 0e:5e14 $db $78
    sENDIF                                             ;; 0e:5e16
    sEND                                               ;; 0e:5e16 $00

script_04eb:
    sIF_TRIGGERED_ON_BY $a9, $a9                       ;; 0e:5e17 $0b $a9 $a9 $00 $0c
      sSET_FLAG wScriptFlags0F.1                       ;; 0e:5e1c $da $79
      sIF_FLAG wScriptFlags0F.0                        ;; 0e:5e1e $08 $78 $00 $06
        sSFX 24                                        ;; 0e:5e22 $f9 $18
        sSET_ROOM_TILE $02, 8, 6                       ;; 0e:5e24 $b0 $02 $08 $06
      sENDIF                                           ;; 0e:5e28
    sENDIF                                             ;; 0e:5e28
    sIF_TRIGGERED_OFF_BY $a9, $a9                      ;; 0e:5e28 $0c $a9 $a9 $00 $02
      sCLEAR_FLAG wScriptFlags0F.1                     ;; 0e:5e2d $db $79
    sENDIF                                             ;; 0e:5e2f
    sEND                                               ;; 0e:5e2f $00

script_04ec:
    sIF_TRIGGERED_OFF_BY $a9                           ;; 0e:5e30 $0c $a9 $00 $04
      sSET_ROOM_TILE $00, 8, 1                         ;; 0e:5e34 $b0 $00 $08 $01
    sENDIF                                             ;; 0e:5e38
    sEND                                               ;; 0e:5e38 $00

script_04ed:
    sSET_NPC_TYPES 94                                  ;; 0e:5e39 $fc $5e
    sSPAWN_NPC 0                                       ;; 0e:5e3b $fd $00
    sSPAWN_NPC 1                                       ;; 0e:5e3d $fd $01
    sEND                                               ;; 0e:5e3f $00

script_04ee:
    sEND                                               ;; 0e:5e40 $00

script_04ef:
    sEND                                               ;; 0e:5e41 $00

script_04f0:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5e42 $0b $c9 $00 $02
      sSET_FLAG wScriptFlags0F.0                       ;; 0e:5e46 $da $78
    sENDIF                                             ;; 0e:5e48
    sEND                                               ;; 0e:5e48 $00

script_04f1:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5e49 $0b $c9 $00 $0a
      sIF_FLAG wScriptFlags0F.0                        ;; 0e:5e4d $08 $78 $00 $06
        sSFX 24                                        ;; 0e:5e51 $f9 $18
        sSET_ROOM_TILE $02, 8, 6                       ;; 0e:5e53 $b0 $02 $08 $06
      sENDIF                                           ;; 0e:5e57
    sENDIF                                             ;; 0e:5e57
    sEND                                               ;; 0e:5e57 $00

script_04f2:
    sSET_NPC_TYPES 105                                 ;; 0e:5e58 $fc $69
    sSPAWN_NPC 0                                       ;; 0e:5e5a $fd $00
    sCLEAR_FLAG wScriptFlags0F.0                       ;; 0e:5e5c $db $78
    sCLEAR_FLAG wScriptFlags0F.1                       ;; 0e:5e5e $db $79
    sEND                                               ;; 0e:5e60 $00

script_04f3:
    sEND                                               ;; 0e:5e61 $00

script_04f4:
    sEND                                               ;; 0e:5e62 $00

script_04f5:
    sIF_TRIGGERED_ON_BY $87, $a9                       ;; 0e:5e63 $0b $87 $a9 $00 $0c
      sSET_FLAG wScriptFlags0F.0                       ;; 0e:5e68 $da $78
      sIF_FLAG wScriptFlags0F.1                        ;; 0e:5e6a $08 $79 $00 $06
        sSFX 24                                        ;; 0e:5e6e $f9 $18
        sSET_ROOM_TILE $02, 8, 1                       ;; 0e:5e70 $b0 $02 $08 $01
      sENDIF                                           ;; 0e:5e74
    sENDIF                                             ;; 0e:5e74
    sEND                                               ;; 0e:5e74 $00

script_04f6:
    sIF_TRIGGERED_ON_BY $87, $a9                       ;; 0e:5e75 $0b $87 $a9 $00 $0c
      sSET_FLAG wScriptFlags0F.1                       ;; 0e:5e7a $da $79
      sIF_FLAG wScriptFlags0F.0                        ;; 0e:5e7c $08 $78 $00 $06
        sSFX 24                                        ;; 0e:5e80 $f9 $18
        sSET_ROOM_TILE $02, 8, 1                       ;; 0e:5e82 $b0 $02 $08 $01
      sENDIF                                           ;; 0e:5e86
    sENDIF                                             ;; 0e:5e86
    sEND                                               ;; 0e:5e86 $00

script_04f7:
    sIF_TRIGGERED_ON_BY $a9                            ;; 0e:5e87 $0b $a9 $00 $09
      sSET_FLAG wScriptFlags0F.0                       ;; 0e:5e8b $da $78
      sIF_FLAG wScriptFlags0F.1                        ;; 0e:5e8d $08 $79 $00 $03
        sSFX 16                                        ;; 0e:5e91 $f9 $10
        sOPEN_NORTH_DOOR                               ;; 0e:5e93 $e0
      sENDIF                                           ;; 0e:5e94
    sENDIF                                             ;; 0e:5e94
    sIF_TRIGGERED_OFF_BY $a9                           ;; 0e:5e94 $0c $a9 $00 $02
      sCLEAR_FLAG wScriptFlags0F.0                     ;; 0e:5e98 $db $78
    sENDIF                                             ;; 0e:5e9a
    sEND                                               ;; 0e:5e9a $00

script_04f8:
    sIF_TRIGGERED_ON_BY $a9                            ;; 0e:5e9b $0b $a9 $00 $09
      sSET_FLAG wScriptFlags0F.1                       ;; 0e:5e9f $da $79
      sIF_FLAG wScriptFlags0F.0                        ;; 0e:5ea1 $08 $78 $00 $03
        sSFX 16                                        ;; 0e:5ea5 $f9 $10
        sOPEN_NORTH_DOOR                               ;; 0e:5ea7 $e0
      sENDIF                                           ;; 0e:5ea8
    sENDIF                                             ;; 0e:5ea8
    sIF_TRIGGERED_OFF_BY $a9                           ;; 0e:5ea8 $0c $a9 $00 $02
      sCLEAR_FLAG wScriptFlags0F.1                     ;; 0e:5eac $db $79
    sENDIF                                             ;; 0e:5eae
    sEND                                               ;; 0e:5eae $00

script_04f9:
    sIF_TRIGGERED_ON_BY $a9, $87                       ;; 0e:5eaf $0b $a9 $87 $00 $03
      sSFX 16                                          ;; 0e:5eb4 $f9 $10
      sOPEN_NORTH_DOOR                                 ;; 0e:5eb6 $e0
    sENDIF                                             ;; 0e:5eb7
    sIF_TRIGGERED_OFF_BY $a9, $87                      ;; 0e:5eb7 $0c $a9 $87 $00 $03
      sSFX 16                                          ;; 0e:5ebc $f9 $10
      sCLOSE_NORTH_DOOR                                ;; 0e:5ebe $e1
    sENDIF                                             ;; 0e:5ebf
; This puzzle originally had a "hint" in that the active switch caused a slight delay when stepped on.
; Since the script speed optimization removes that delay, add it in manually.
    sDELAY 3
    sEND                                               ;; 0e:5ebf $00

script_04fa:
    sIF_TRIGGERED_ON_BY $a9, $87                       ;; 0e:5ec0 $0b $a9 $87 $00 $03
      sSFX 16                                          ;; 0e:5ec5 $f9 $10
      sOPEN_EAST_DOOR                                  ;; 0e:5ec7 $e4
    sENDIF                                             ;; 0e:5ec8
    sIF_TRIGGERED_OFF_BY $a9, $87                      ;; 0e:5ec8 $0c $a9 $87 $00 $03
      sSFX 16                                          ;; 0e:5ecd $f9 $10
      sCLOSE_EAST_DOOR                                 ;; 0e:5ecf $e5
    sENDIF                                             ;; 0e:5ed0
    sEND                                               ;; 0e:5ed0 $00

script_04fb:
    sIF_TRIGGERED_OFF_BY $91                           ;; 0e:5ed1 $0c $91 $00 $0b
      sSET_FLAG wScriptFlags0F.0                       ;; 0e:5ed5 $da $78
      sIF_FLAG wScriptFlags0F.1                        ;; 0e:5ed7 $08 $79 $00 $03
        sSFX 16                                        ;; 0e:5edb $f9 $10
        sOPEN_EAST_DOOR                                ;; 0e:5edd $e4
      sENDIF                                           ;; 0e:5ede
    sELSE                                              ;; 0e:5ede $01 $02
      sCLEAR_FLAG wScriptFlags0F.0                     ;; 0e:5ee0 $db $78
    sENDIF                                             ;; 0e:5ee2
    sEND                                               ;; 0e:5ee2 $00

script_04fc:
    sIF_TRIGGERED_OFF_BY $91                           ;; 0e:5ee3 $0c $91 $00 $0b
      sSET_FLAG wScriptFlags0F.1                       ;; 0e:5ee7 $da $79
      sIF_FLAG wScriptFlags0F.0                        ;; 0e:5ee9 $08 $78 $00 $03
        sSFX 16                                        ;; 0e:5eed $f9 $10
        sOPEN_EAST_DOOR                                ;; 0e:5eef $e4
      sENDIF                                           ;; 0e:5ef0
    sELSE                                              ;; 0e:5ef0 $01 $02
      sCLEAR_FLAG wScriptFlags0F.1                     ;; 0e:5ef2 $db $79
    sENDIF                                             ;; 0e:5ef4
    sEND                                               ;; 0e:5ef4 $00

script_04fd:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5ef5 $0b $c9 $00 $02
      sSET_FLAG wScriptFlags0F.0                       ;; 0e:5ef9 $da $78
    sENDIF                                             ;; 0e:5efb
    sIF_FLAG wScriptFlags0F.1, wScriptFlags0F.2, wScriptFlags0F.3 ;; 0e:5efb $08 $79 $7a $7b $00 $03
      sSFX 16                                          ;; 0e:5f01 $f9 $10
      sOPEN_NORTH_DOOR                                 ;; 0e:5f03 $e0
    sENDIF                                             ;; 0e:5f04
    sEND                                               ;; 0e:5f04 $00

script_04fe:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5f05 $0b $c9 $00 $02
      sSET_FLAG wScriptFlags0F.1                       ;; 0e:5f09 $da $79
    sENDIF                                             ;; 0e:5f0b
    sIF_FLAG wScriptFlags0F.0, wScriptFlags0F.2, wScriptFlags0F.3 ;; 0e:5f0b $08 $78 $7a $7b $00 $03
      sSFX 16                                          ;; 0e:5f11 $f9 $10
      sOPEN_NORTH_DOOR                                 ;; 0e:5f13 $e0
    sENDIF                                             ;; 0e:5f14
    sEND                                               ;; 0e:5f14 $00

script_04ff:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5f15 $0b $c9 $00 $02
      sSET_FLAG wScriptFlags0F.2                       ;; 0e:5f19 $da $7a
    sENDIF                                             ;; 0e:5f1b
    sIF_FLAG wScriptFlags0F.0, wScriptFlags0F.1, wScriptFlags0F.3 ;; 0e:5f1b $08 $78 $79 $7b $00 $03
      sSFX 16                                          ;; 0e:5f21 $f9 $10
      sOPEN_NORTH_DOOR                                 ;; 0e:5f23 $e0
    sENDIF                                             ;; 0e:5f24
    sEND                                               ;; 0e:5f24 $00

script_0500:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5f25 $0b $c9 $00 $02
      sSET_FLAG wScriptFlags0F.3                       ;; 0e:5f29 $da $7b
    sENDIF                                             ;; 0e:5f2b
    sIF_FLAG wScriptFlags0F.0, wScriptFlags0F.1, wScriptFlags0F.2 ;; 0e:5f2b $08 $78 $79 $7a $00 $03
      sSFX 16                                          ;; 0e:5f31 $f9 $10
      sOPEN_NORTH_DOOR                                 ;; 0e:5f33 $e0
    sENDIF                                             ;; 0e:5f34
    sEND                                               ;; 0e:5f34 $00

script_0501:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5f35 $0b $c9 $00 $03
      sSFX 16                                          ;; 0e:5f39 $f9 $10
      sOPEN_EAST_DOOR                                  ;; 0e:5f3b $e4
    sENDIF                                             ;; 0e:5f3c
    sEND                                               ;; 0e:5f3c $00

script_0502:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5f3d $0b $c9 $00 $03
      sSFX 16                                          ;; 0e:5f41 $f9 $10
      sCLOSE_EAST_DOOR                                 ;; 0e:5f43 $e5
    sENDIF                                             ;; 0e:5f44
    sEND                                               ;; 0e:5f44 $00

script_0503:
    sIF_TRIGGERED_OFF_BY $a9                           ;; 0e:5f45 $0c $a9 $00 $03
      sSFX 16                                          ;; 0e:5f49 $f9 $10
      sOPEN_NORTH_DOOR                                 ;; 0e:5f4b $e0
    sENDIF                                             ;; 0e:5f4c
    sEND                                               ;; 0e:5f4c $00

script_0504:
    ; Modified to detect c1 (the player during knockback)
    sIF_TRIGGERED_ON_BY $c9, $a9, $c1
      sSFX 16                                          ;; 0e:5f52 $f9 $10
      sOPEN_NORTH_DOOR                                 ;; 0e:5f54 $e0
    sENDIF                                             ;; 0e:5f55
    sIF_TRIGGERED_OFF_BY $c9, $a9, $c1
      sSFX 16                                          ;; 0e:5f5a $f9 $10
      sCLOSE_NORTH_DOOR                                ;; 0e:5f5c $e1
    sENDIF                                             ;; 0e:5f5d
    sEND                                               ;; 0e:5f5d $00

script_0505:
    sEND                                               ;; 0e:5f5e $00

script_0506:
    sEND                                               ;; 0e:5f5f $00

script_0507:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5f60 $0b $c9 $00 $0c
      sSET_ROOM_TILE $00, 1, 5                         ;; 0e:5f64 $b0 $00 $01 $05
      sSET_ROOM_TILE $00, 4, 1                         ;; 0e:5f68 $b0 $00 $04 $01
      sSET_ROOM_TILE $00, 5, 1                         ;; 0e:5f6c $b0 $00 $05 $01
    sENDIF                                             ;; 0e:5f70
    sEND                                               ;; 0e:5f70 $00

script_0508:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5f71 $0b $c9 $00 $03
      sSFX 16                                          ;; 0e:5f75 $f9 $10
      sOPEN_SOUTH_DOOR                                 ;; 0e:5f77 $e2
    sENDIF                                             ;; 0e:5f78
    sEND                                               ;; 0e:5f78 $00

script_0509:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5f79 $0b $c9 $00 $10
      sSET_ROOM_TILE $00, 4, 3                         ;; 0e:5f7d $b0 $00 $04 $03
      sSET_ROOM_TILE $00, 5, 3                         ;; 0e:5f81 $b0 $00 $05 $03
      sSET_ROOM_TILE $00, 4, 4                         ;; 0e:5f85 $b0 $00 $04 $04
      sSET_ROOM_TILE $00, 5, 4                         ;; 0e:5f89 $b0 $00 $05 $04
    sENDIF                                             ;; 0e:5f8d
    sEND                                               ;; 0e:5f8d $00

script_050a:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5f8e $0b $c9 $00 $13
      sSFX 16                                          ;; 0e:5f92 $f9 $10
      sOPEN_EAST_DOOR                                  ;; 0e:5f94 $e4
      sSET_ROOM_TILE $00, 4, 3                         ;; 0e:5f95 $b0 $00 $04 $03
      sSET_ROOM_TILE $00, 5, 3                         ;; 0e:5f99 $b0 $00 $05 $03
      sSET_ROOM_TILE $00, 4, 4                         ;; 0e:5f9d $b0 $00 $04 $04
      sSET_ROOM_TILE $00, 5, 4                         ;; 0e:5fa1 $b0 $00 $05 $04
    sENDIF                                             ;; 0e:5fa5
    sEND                                               ;; 0e:5fa5 $00

script_050b:
    sIF_TRIGGERED_ON_BY $a9                            ;; 0e:5fa6 $0b $a9 $00 $03
      sSFX 16                                          ;; 0e:5faa $f9 $10
      sOPEN_EAST_DOOR                                  ;; 0e:5fac $e4
    sENDIF                                             ;; 0e:5fad
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5fad $0b $c9 $00 $06
      sSFX 24                                          ;; 0e:5fb1 $f9 $18
      sSET_ROOM_TILE $59, 4, 4                         ;; 0e:5fb3 $b0 $59 $04 $04
    sENDIF                                             ;; 0e:5fb7
    sEND                                               ;; 0e:5fb7 $00

script_050c:
    sIF_TRIGGERED_ON_BY $c9                            ;; 0e:5fb8 $0b $c9 $00 $14
      sIF_TRIGGERED_ON_BY $c9                          ;; 0e:5fbc $0b $c9 $00 $10
        sIF_FLAG wScriptFlags0F.0                      ;; 0e:5fc0 $08 $78 $00 $07
          sCLEAR_FLAG wScriptFlags0F.0                 ;; 0e:5fc4 $db $78
          sSFX 16                                      ;; 0e:5fc6 $f9 $10
          sOPEN_SOUTH_DOOR                             ;; 0e:5fc8 $e2
        sELSE                                          ;; 0e:5fc9 $01 $05
          sSET_FLAG wScriptFlags0F.0                   ;; 0e:5fcb $da $78
          sSFX 16                                      ;; 0e:5fcd $f9 $10
          sCLOSE_SOUTH_DOOR                            ;; 0e:5fcf $e3
        sENDIF                                         ;; 0e:5fd0
      sENDIF                                           ;; 0e:5fd0
    sENDIF                                             ;; 0e:5fd0
    sEND                                               ;; 0e:5fd0 $00

script_050d:
    sSET_NPC_TYPES 14                                  ;; 0e:5fd1 $fc $0e
    sLOOP 4, 3                                         ;; 0e:5fd3 $03 $04 $03
      sSPAWN_NPC 2                                     ;; 0e:5fd6 $fd $02
    sEND                                               ;; 0e:5fd8 $00
    sEND                                               ;; 0e:5fd9 $00

script_050e:
    sEND                                               ;; 0e:5fda $00

script_050f:
    sEND                                               ;; 0e:5fdb $00

script_0510:
    sIF_FLAG !wScriptFlags02.3                         ;; 0e:5fdc $08 $93 $00 $0e
      sSPAWN_BOSS 18
      sDELAY 20                                        ;; 0e:5fe0 $f0 $14
      sSFX 20                                          ;; 0e:5fe2 $f9 $14
      sFLASH_SCREEN                                    ;; 0e:5fe4 $bf
      sSFX 20                                          ;; 0e:5fe5 $f9 $14
      sFLASH_SCREEN                                    ;; 0e:5fe7 $bf
      sSET_MUSIC 15                                    ;; 0e:5fea $f8 $0f
    sELSE                                              ;; 0e:5fec $01 $06
      sSFX 24                                          ;; 0e:5fee $f9 $18
      sSET_ROOM_TILE $02, 1, 6                         ;; 0e:5ff0 $b0 $02 $01 $06
    sENDIF                                             ;; 0e:5ff4
    sEND                                               ;; 0e:5ff4 $00

script_0511:
    sSET_MUSIC 8                                       ;; 0e:5ff5 $f8 $08
    sEND                                               ;; 0e:5ff7 $00

script_0512:
    sSET_MUSIC 0                                       ;; 0e:5ff8 $f8 $00
    sMSG                                               ;; 0e:5ffa $04
      db "<10>Defeated\n    Metal Crab!<12>"
      db "<11>", $00 ;; 0e:5ffb
    sSFX 24                                            ;; 0e:6011 $f9 $18
    sSET_ROOM_TILE $02, 1, 6                           ;; 0e:6013 $b0 $02 $01 $06
    sSET_FLAG wScriptFlags02.3                         ;; 0e:6017 $da $13
    sSET_MUSIC 8                                       ;; 0e:6019 $f8 $08
    sEND                                               ;; 0e:601b $00

script_0513:
    sIF_FLAG !wScriptFlags02.5                         ;; 0e:601c $08 $95 $00 $0e
      sSPAWN_BOSS 19
      sDELAY 20                                        ;; 0e:6020 $f0 $14
      sSFX 20                                          ;; 0e:6022 $f9 $14
      sFLASH_SCREEN                                    ;; 0e:6024 $bf
      sSFX 20                                          ;; 0e:6025 $f9 $14
      sFLASH_SCREEN                                    ;; 0e:6027 $bf
      sSET_MUSIC 15                                    ;; 0e:602a $f8 $0f
    sELSE                                              ;; 0e:602c $01 $03
      sSFX 16                                          ;; 0e:602e $f9 $10
      sOPEN_EAST_DOOR                                  ;; 0e:6030 $e4
    sENDIF                                             ;; 0e:6031
    sEND                                               ;; 0e:6031 $00

script_0514:
    sSET_MUSIC 8                                       ;; 0e:6032 $f8 $08
    sEND                                               ;; 0e:6034 $00

script_0515:
    sSET_MUSIC 0                                       ;; 0e:6035 $f8 $00
    sMSG                                               ;; 0e:6037 $04
      db "<10>Defeated\n    Mantis Ant!<12>"
      db "<11>", $00 ;; 0e:6038
    sSFX 16                                            ;; 0e:604c $f9 $10
    sOPEN_EAST_DOOR                                    ;; 0e:604e $e4
    sSET_FLAG wScriptFlags02.5                         ;; 0e:604f $da $15
    sSET_MUSIC 8                                       ;; 0e:6051 $f8 $08
    sEND                                               ;; 0e:6053 $00

script_0516:
    sIF_FLAG !wScriptFlags07.0                         ;; 0e:6054 $08 $b8 $00 $04
      sSET_NPC_TYPES 107                               ;; 0e:6058 $fc $6b
      sSPAWN_NPC 0                                     ;; 0e:605a $fd $00
    sENDIF                                             ;; 0e:605c
    sEND                                               ;; 0e:605c $00

script_0517:
    sEND                                               ;; 0e:605d $00

script_0518:
    sEND                                               ;; 0e:605e $00

script_0519:
    sSET_NPC_TYPES 84                                  ;; 0e:605f $fc $54
    sSPAWN_NPC 1                                       ;; 0e:6061 $fd $01
    sIF_FLAG !wScriptFlags0E.4, !wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7, !wScriptFlags02.1 ;; 0e:6063 $08 $f4 $f5 $76 $77 $91 $00 $02
    sELSE                                              ;; 0e:606b $01 $02
      sSPAWN_NPC 0                                     ;; 0e:606d $fd $00
    sENDIF                                             ;; 0e:606f
    sEND                                               ;; 0e:606f $00

script_051a:
    sEND                                               ;; 0e:6070 $00

script_051b:
    sEND                                               ;; 0e:6071 $00

script_051c:
    sSET_NPC_TYPES 91                                  ;; 0e:6072 $fc $5b
    sSPAWN_NPC 0                                       ;; 0e:6074 $fd $00
    sSPAWN_NPC 1                                       ;; 0e:6076 $fd $01
    sEND                                               ;; 0e:6078 $00

script_051d:
    sEND                                               ;; 0e:6079 $00

script_051e:
    sEND                                               ;; 0e:607a $00

script_051f:
    sSET_NPC_TYPES 85                                  ;; 0e:607b $fc $55
    sSPAWN_NPC 0                                       ;; 0e:607d $fd $00
    sSPAWN_NPC 1                                       ;; 0e:607f $fd $01
    sEND                                               ;; 0e:6081 $00

script_0520:
    sEND                                               ;; 0e:6082 $00

script_0521:
    sEND                                               ;; 0e:6083 $00

script_0522:
    sIF_FLAG !wScriptFlags0E.5                         ;; 0e:6084 $08 $f5 $00 $06
      sSET_NPC_TYPES 106                               ;; 0e:6088 $fc $6a
      sSPAWN_NPC 0                                     ;; 0e:608a $fd $00
    sELSE                                              ;; 0e:608c $01 $1d
      sIF_FLAG !wScriptFlags0E.6, !wScriptFlags0E.7    ;; 0e:608e $08 $f6 $f7 $00 $06
        sSET_NPC_TYPES 44                              ;; 0e:6093 $fc $2c
        sSPAWN_NPC 0                                   ;; 0e:6095 $fd $00
        sSPAWN_NPC 1                                   ;; 0e:6097 $fd $01
      sENDIF                                           ;; 0e:6099
      sIF_FLAG !wScriptFlags0E.6, wScriptFlags0E.7     ;; 0e:6099 $08 $f6 $77 $00 $04
        sSET_NPC_TYPES 51                              ;; 0e:609e $fc $33
        sSPAWN_NPC 2                                   ;; 0e:60a0 $fd $02
      sENDIF                                           ;; 0e:60a2
      sIF_FLAG wScriptFlags0E.6, !wScriptFlags0E.7     ;; 0e:60a2 $08 $76 $f7 $00 $04
        sSET_NPC_TYPES 61                              ;; 0e:60a7 $fc $3d
        sSPAWN_NPC 0                                   ;; 0e:60a9 $fd $00
      sENDIF                                           ;; 0e:60ab
    sENDIF                                             ;; 0e:60ab
    sEND                                               ;; 0e:60ab $00

script_0523:
    sEND                                               ;; 0e:60ac $00

script_0524:
    sEND                                               ;; 0e:60ad $00

script_0525:
    sIF_FLAG !wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7 ;; 0e:60ae $08 $f5 $f6 $77 $00 $12
      sSET_NPC_TYPES 74                                ;; 0e:60b4 $fc $4a
      sIF_FLAG wScriptFlags03.7, !wScriptFlags04.1     ;; 0e:60b6 $08 $1f $a1 $00 $09
        sSPAWN_NPC 1                                   ;; 0e:60bb $fd $01
        sSPAWN_NPC 2                                   ;; 0e:60bd $fd $02
        sCALL script_053e                              ;; 0e:60bf $02 $6e $c6
      sELSE                                            ;; 0e:60c2 $01 $02
        sSPAWN_NPC 2                                   ;; 0e:60c4 $fd $02
      sENDIF                                           ;; 0e:60c6
    sENDIF                                             ;; 0e:60c6
    sIF_FLAG !wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0e:60c6 $08 $f5 $76 $f7 $00 $04
      sSET_NPC_TYPES 43                                ;; 0e:60cc $fc $2b
      sSPAWN_NPC 2                                     ;; 0e:60ce $fd $02
    sENDIF                                             ;; 0e:60d0
    sIF_FLAG !wScriptFlags0E.5, wScriptFlags0E.6, wScriptFlags0E.7 ;; 0e:60d0 $08 $f5 $76 $77 $00 $04
      sSET_NPC_TYPES 52                                ;; 0e:60d6 $fc $34
      sSPAWN_NPC 1                                     ;; 0e:60d8 $fd $01
    sENDIF                                             ;; 0e:60da
    sIF_FLAG wScriptFlags0E.5, !wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0e:60da $08 $75 $f6 $f7 $00 $04
      sSET_NPC_TYPES 60                                ;; 0e:60e0 $fc $3c
      sSPAWN_NPC 2                                     ;; 0e:60e2 $fd $02
    sENDIF                                             ;; 0e:60e4
    sIF_FLAG wScriptFlags0E.5, !wScriptFlags0E.6, wScriptFlags0E.7 ;; 0e:60e4 $08 $75 $f6 $77 $00 $06
      sSET_NPC_TYPES 58                                ;; 0e:60ea $fc $3a
      sSPAWN_NPC 0                                     ;; 0e:60ec $fd $00
      sSPAWN_NPC 1                                     ;; 0e:60ee $fd $01
    sENDIF                                             ;; 0e:60f0
    sIF_FLAG wScriptFlags0E.5, wScriptFlags0E.6, !wScriptFlags0E.7 ;; 0e:60f0 $08 $75 $76 $f7 $00 $17
      sSET_NPC_TYPES 76                                ;; 0e:60f6 $fc $4c
      sSPAWN_NPC 0
      sIF_FLAG wScriptFlags03.7
        sSPAWN_NPC 1                                   ;; 0e:60fc $fd $01
      sENDIF                                           ;; 0e:60fe
    sENDIF                                             ;; 0e:610d
    sEND                                               ;; 0e:610d $00

script_0526:
    sEND                                               ;; 0e:610e $00

script_0527:
    sEND                                               ;; 0e:610f $00

script_0528:
    sSET_NPC_TYPES 106                                 ;; 0e:6110 $fc $6a
    sSPAWN_NPC 0                                       ;; 0e:6112 $fd $00
    sEND                                               ;; 0e:6114 $00

script_0529:
    sEND                                               ;; 0e:6115 $00

script_052a:
    sEND                                               ;; 0e:6116 $00

script_052b:
    sSFX 16                                            ;; 0e:6117 $f9 $10
    sCLOSE_EAST_DOOR                                   ;; 0e:6119 $e5
    sCLOSE_SOUTH_DOOR                                  ;; 0e:611a $e3
    sSET_NPC_TYPES 3                                   ;; 0e:611b $fc $03
    sSPAWN_NPC 2                                       ;; 0e:611d $fd $02
    sEND                                               ;; 0e:611f $00

script_052c:
    sEND                                               ;; 0e:6120 $00

script_052d:
    sSFX 16                                            ;; 0e:6121 $f9 $10
    sOPEN_EAST_DOOR                                    ;; 0e:6123 $e4
    sOPEN_SOUTH_DOOR                                   ;; 0e:6124 $e2
    sEND                                               ;; 0e:6125 $00

script_052e:
    sEND                                               ;; 0e:6126 $00

script_052f:
    sEND                                               ;; 0e:6127 $00

script_0530:
    sEND                                               ;; 0e:6128 $00

script_0531:
    sIF_FLAG !wScriptFlags01.0                         ;; 0e:6129 $08 $88 $00 $71
      sSET_MUSIC 0                                     ;; 0e:612d $f8 $00
; Originally this one message was unaffected by holding a button to speed up text.
; Probably to test the feature, which is turned on during the ending (and then never turned off).
;      sLOCK_TEXT_SPEED
      sDELAY 90                                        ;; 0e:6130 $f0 $5a
      sMSG                                             ;; 0e:6132 $04
        db "<10><BOY> was a captive\nof the cruel\nKingdom of Granz.<12>"
        db "<11>", $00                                 ;; 0e:614d
      sFULL_HP                                         ;; 0e:614f $c0
      sFADE_TO_BLACK                                   ;; 0e:6150 $bd
      sLOAD_ROOM_INSTANT 15, $55, 20, 0                ;; 0e:6151 $f3 $0f $55 $14 $00
      sFADE_TO_NORMAL                                  ;; 0e:6156 $bc
      sDELAY 50                                        ;; 0e:6157 $f0 $32
;      sUNLOCK_TEXT_SPEED
      sMSG                                             ;; 0e:615a $04
        db "<10><BOY> and friends\nwere forced to\nfight every day<12>"
        db "<1b>just for the\namusement of\nShadow Knight.<12>"
        db "<1b>", $00 ;; 0e:615b
      sCALL script_0532                                ;; 0e:6198 $02 $61 $9f
      sCALL script_0533                                ;; 0e:619b $02 $61 $fa
    sENDIF                                             ;; 0e:619e
    sEND                                               ;; 0e:619e $00

script_0532:
    sMSG                                               ;; 0e:619f $04
      db "Many fighters have\nfallen from their\nwounds.<12>"
      db "<11>", $00 ;; 0e:61a0
    sFADE_TO_BLACK                                     ;; 0e:61be $bd
    sLOAD_ROOM_INSTANT 4, $41, 10, 8
    sSET_MUSIC 23                                      ;; 0e:61c4 $f8 $17
    sSET_PLAYER_DIRECTION_LEFT                         ;; 0e:61c6 $87
    sSET_NPC_TYPES 36                                  ;; 0e:61c7 $fc $24
    sSPAWN_NPC 2                                       ;; 0e:61c9 $fd $02
    sDELAY 100                                         ;; 0e:61cb $f0 $64
    sFADE_TO_NORMAL                                    ;; 0e:61cd $bc
    sDELAY 30                                          ;; 0e:61ce $f0 $1e
    sMSG                                               ;; 0e:61d0 $04
      db "<10><BOY>:__ Willy!\nWilly:<BOY>_", $00      ;; 0e:61d1
    sDELAY 50                                          ;; 0e:61e3 $f0 $32
    sMSG                                               ;; 0e:61e5 $04
      db "  Mana\n is in danger_<12>"
      db "<1b>", $00 ;; 0e:61e6
    sEND                                               ;; 0e:61f9 $00

script_0533:
    sMSG                                               ;; 0e:61fa $04
      db " We must let the\n Gemma Knights\n know.<12>"
      db "<1b><BOY>:_ Gemma_?\nWilly:See Bogard\n at the Falls.<12>"
      db "<1b> He is a Gemma\n Knight. He should\n know what to do.<12>"
      db "<1b><BOY>:Gemma?", $00 ;; 0e:61fb
    sDELAY 30                                          ;; 0e:626c $f0 $1e
    sMSG                                               ;; 0e:626e $04
      db " Mana?\n What are they? _", $00              ;; 0e:626f
    sDELAY 30                                          ;; 0e:6280 $f0 $1e
    sMSG                                               ;; 0e:6282 $04
      db "\n _ Willy?", $00                            ;; 0e:6283
    sDELAY 60                                          ;; 0e:628c $f0 $3c
    sMSG                                               ;; 0e:628e $04
      db "_ Willy!!<12>"
      db "<11>", $00          ;; 0e:628f
    sDELAY 60                                          ;; 0e:6299 $f0 $3c
    sMSG                                               ;; 0e:629b $04
      db "<10>\nWilly passed away.<12>"
      db "<11>", $00 ;; 0e:629c
    sDELAY 60                                          ;; 0e:62ad $f0 $3c
    sSET_FLAG wScriptFlags01.0                         ;; 0e:62af $da $08
    sEND                                               ;; 0e:62b1 $00

script_0534:
    sSET_MUSIC 0                                       ;; 0e:62b2 $f8 $00
    sSET_NPC_TYPES 39                                  ;; 0e:62b4 $fc $27
    sSPAWN_NPC 0                                       ;; 0e:62b6 $fd $00
    sSET_NPC_1_DIRECTION_UP                            ;; 0e:62b8 $14
    sSPAWN_NPC 1                                       ;; 0e:62b9 $fd $01
    sSET_NPC_2_DIRECTION_UP                            ;; 0e:62bb $24
    sPLAYER_STEP_FORWARD                               ;; 0e:62bc $80
    sDELAY 30                                          ;; 0e:62bd $f0 $1e
    sMSG                                               ;; 0e:62bf $04
      db "<10><BOY>:Shadow Knight\n _ With Julius_\n _What's going on?<12>"
      db "<11>", $00 ;; 0e:62c0
    sSET_MUSIC 10                                      ;; 0e:62e4 $f8 $0a
    sDELAY 30                                          ;; 0e:62e6 $f0 $1e
    sSET_NPC_1_DIRECTION_RIGHT                         ;; 0e:62e8 $16
    sMSG                                               ;; 0e:62e9 $04
      db "<10>Shadow Knight:The\n Mana Tree is\n above the Falls_?<12>"
      db "<11>", $00 ;; 0e:62ea
    sDELAY 10                                          ;; 0e:6313 $f0 $0a
    sSET_NPC_2_DIRECTION_LEFT                          ;; 0e:6315 $27
    sDELAY 10                                          ;; 0e:6316 $f0 $0a
    sMSG                                               ;; 0e:6318 $04
      db "<10>Julius:Yes, Sir.\n The tree is in a\n shrine up there.<12>"
      db "<1b>", $00 ;; 0e:6319
    sSET_NPC_1_DIRECTION_RIGHT                         ;; 0e:633e $16
    sMSG                                               ;; 0e:633f $04
      db "Shadow Knight:How\n do I get there?", $00
    sDELAY 30                                          ;; 0e:6356 $f0 $1e
    sSET_NPC_1_DIRECTION_UP                            ;; 0e:6358 $14
    sDELAY 20                                          ;; 0e:6359 $f0 $14
    sMSG                                               ;; 0e:635b $04
      db "\n Am I to climb?<12>"
      db "<1b>Julius:A miracle\n should do it.\n", $00
    sSET_NPC_1_DIRECTION_RIGHT                         ;; 0e:638f $16
    sMSG                                               ;; 0e:6390 $04
      db "Shadow Knight:How?<12>"
      db "<1b>Julius:_ ", $00
    sDELAY 10
    sMSG
      db "A girl\n holds the key_\n I have seen it_", $00
    sDELAY 10
    sMSG
      db "_<12><1b>Shadow Knight:Find\n me this key.\nJulius:Yes, Sir!", $00
    sEND                                               ;; 0e:63dd $00

script_0535:
    sMSG                                               ;; 0e:63de $04
      db "<12>"
      db "<11>", $00                   ;; 0e:63df
    sDELAY 60                                          ;; 0e:63e2 $f0 $3c
    sLOOP 8, 5                                         ;; 0e:63e4 $03 $08 $05
      sSET_NPC_2_DIRECTION_RIGHT                       ;; 0e:63e7 $26
      sSET_NPC_2_DIRECTION_DOWN                        ;; 0e:63e8 $25
      sSET_NPC_2_DIRECTION_LEFT                        ;; 0e:63e9 $27
      sSET_NPC_2_DIRECTION_UP                          ;; 0e:63ea $24
    sEND                                               ;; 0e:63eb $00
    sDEL_NPC_2                                         ;; 0e:63ec $28
    sSFX 20                                            ;; 0e:63ed $f9 $14
    sFLASH_SCREEN                                      ;; 0e:63ef $bf
    sSFX 20                                            ;; 0e:63f0 $f9 $14
    sFLASH_SCREEN                                      ;; 0e:63f2 $bf
    sFLASH_SCREEN                                      ;; 0e:63f3 $bf
    sDELAY 60                                          ;; 0e:63f4 $f0 $3c
    sMSG                                               ;; 0e:63f6 $04
      db "<10>Shadow Knight:_\n What? Who is it?\n<BOY>:__ !!<12>"
      db "<11>", $00 ;; 0e:63f7
    sNPC_1_STEP_FORWARD                                ;; 0e:6417 $10
    sNPC_1_STEP_FORWARD                                ;; 0e:6418 $10
    sSET_MUSIC 9                                       ;; 0e:6419 $f8 $09
    sSET_PLAYER_DIRECTION_RIGHT                        ;; 0e:641b $86
    sPLAYER_STEP_FORWARD                               ;; 0e:641c $80
    sPLAYER_STEP_FORWARD                               ;; 0e:641d $80
    sSCROLL_ROOM_RIGHT                                 ;; 0e:641e $eb
    sLOOP 7, 2                                         ;; 0e:641f $03 $07 $02
      sPLAYER_STEP_FORWARD                             ;; 0e:6422 $80
    sEND                                               ;; 0e:6423 $00
    sSET_PLAYER_DIRECTION_DOWN                         ;; 0e:6424 $85
    sLOOP 4, 2                                         ;; 0e:6425 $03 $04 $02
      sPLAYER_STEP_FORWARD                             ;; 0e:6428 $80
    sEND                                               ;; 0e:6429 $00
    sSCROLL_ROOM_DOWN                                  ;; 0e:642a $e8
    sLOOP 7, 2                                         ;; 0e:642b $03 $07 $02
      sPLAYER_STEP_FORWARD                             ;; 0e:642e $80
    sEND                                               ;; 0e:642f $00
    sSET_PLAYER_DIRECTION_LEFT                         ;; 0e:6430 $87
    sLOOP 7, 2                                         ;; 0e:6431 $03 $07 $02
      sPLAYER_STEP_FORWARD                             ;; 0e:6434 $80
    sEND                                               ;; 0e:6435 $00
    sSCROLL_ROOM_LEFT                                  ;; 0e:6436 $ea
    sSET_FLAG wScriptFlags01.1                         ;; 0e:6437 $da $09
    sEND                                               ;; 0e:6439 $00

script_0536:
    sSET_NPC_TYPES 41                                  ;; 0e:643a $fc $29
    sLOOP 7, 2                                         ;; 0e:643c $03 $07 $02
      sPLAYER_STEP_FORWARD                             ;; 0e:643f $80
    sEND                                               ;; 0e:6440 $00
    sDELAY 30                                          ;; 0e:6441 $f0 $1e
    sSPAWN_NPC 1                                       ;; 0e:6443 $fd $01
    sSET_NPC_1_DIRECTION_LEFT                          ;; 0e:6445 $17
; This version of Shadow Knight has been modified to move faster and spawn just offscreen.
; Slow him down for his initial walk onto the screen, then speed him up for the charge.
    sUNK_1A
    sNPC_1_STEP_FORWARD
    sNPC_1_STEP_FORWARD
    sUNK_1B
    sDELAY 30                                          ;; 0e:6446 $f0 $1e
    sSET_PLAYER_DIRECTION_RIGHT                        ;; 0e:6448 $86
    sDELAY 30                                          ;; 0e:6449 $f0 $1e
    sMSG                                               ;; 0e:644b $04
      db "<10>Shadow Knight:I\n won't let you\n leave alive!<12>"
      db "<11>", $00 ;; 0e:644c
    sLOOP 5, 2                                         ;; 0e:646d $03 $05 $02
      sNPC_1_STEP_FORWARD                              ;; 0e:6470 $10
    sEND                                               ;; 0e:6471 $00
    sSFX 20                                            ;; 0e:6472 $f9 $14
    sLOOP 2, 2                                         ;; 0e:6474 $03 $02 $02
      sFLASH_SCREEN                                    ;; 0e:6477 $bf
    sEND                                               ;; 0e:6478 $00
    sPLAYER_STEP_BACKWARD                              ;; 0e:6479 $81
    sPLAYER_STEP_BACKWARD                              ;; 0e:647a $81
    sSET_PLAYER_DIRECTION_DOWN                         ;; 0e:647b $85
    sSET_PLAYER_HURT_SPRITE                            ;; 0e:647c $a5
    sSET_FAST_MOVEMENT                                 ;; 0e:647d $88
    sSFX 12                                            ;; 0e:647e $f9 $0c
    sLOOP 11, 2                                        ;; 0e:6480 $03 $0b $02
      sPLAYER_STEP_FORWARD                             ;; 0e:6483 $80
    sEND                                               ;; 0e:6484 $00
    sLOAD_ROOM 14, $72, 9, 0                           ;; 0e:6485 $f4 $0e $72 $09 $00
    sLOOP 15, 2                                        ;; 0e:648a $03 $0f $02
      sPLAYER_STEP_FORWARD                             ;; 0e:648d $80
    sEND                                               ;; 0e:648e $00
    sLOOP 3, 10                                        ;; 0e:648f $03 $03 $0a
      sSET_NEXT_ROOM $07, $02                          ;; 0e:6492 $ef $07 $02
      sSCROLL_ROOM_DOWN                                ;; 0e:6495 $e8
      sLOOP 16, 2                                      ;; 0e:6496 $03 $10 $02
        sPLAYER_STEP_FORWARD                           ;; 0e:6499 $80
      sEND                                             ;; 0e:649a $00
    sEND                                               ;; 0e:649b $00
    sPLAYER_STEP_FORWARD                               ;; 0e:649c $80
    sPLAYER_STEP_FORWARD                               ;; 0e:649d $80
    sCLEAR_FAST_MOVEMENT                               ;; 0e:649e $89
    sDELAY 20                                          ;; 0e:649f $f0 $14
    sSET_PLAYER_LAYDOWN_SPRITE                         ;; 0e:64a1 $a6
    sFADE_TO_BLACK                                     ;; 0e:64a2 $bd
    sSET_MUSIC 0                                       ;; 0e:64a3 $f8 $00
    sLOAD_ROOM_INSTANT 0, $56, 8, 8                    ;; 0e:64a5 $f3 $00 $56 $08 $08
    sDELAY 144                                         ;; 0e:64aa $f0 $90
    sFADE_TO_NORMAL                                    ;; 0e:64ac $bc
    sDELAY 100                                         ;; 0e:64ad $f0 $64
    sMSG                                               ;; 0e:64af $04
      db "<10><BOY>:_ _ Ouch!\n _ Where am I?\n _ Where is this?<12>"
      db "<11>", $00 ;; 0e:64b0
    sDELAY 80                                          ;; 0e:64d4 $f0 $50
    sSET_PLAYER_NORMAL_SPRITE                          ;; 0e:64d6 $a4
    sSET_MUSIC 20                                      ;; 0e:64d7 $f8 $14
    sEND                                               ;; 0e:64d9 $00

script_0537:
    sSET_NPC_TYPES 40                                  ;; 0e:64da $fc $28
    sPLAYER_STEP_FORWARD                               ;; 0e:64dc $80
    sSPAWN_NPC 0                                       ;; 0e:64dd $fd $00
    sDELAY 60                                          ;; 0e:64df $f0 $3c
    sMSG                                               ;; 0e:64e1 $04
      db "<10><BOY>:<GIRL>!\n _ What's wrong?<12>"
      db "<11>", $00 ;; 0e:64e2
    sSET_MUSIC 0                                       ;; 0e:64f5 $f8 $00
    sDELAY 80                                          ;; 0e:64f7 $f0 $50
    sMSG                                               ;; 0e:64f9 $04
      db "<10>Julius:It's too\n late, <BOY>.\n <GIRL> is mine__", $00
    sSET_MUSIC 10                                      ;; 0e:6515 $f8 $0a
    sMSG                                               ;; 0e:6517 $04
      db "<12>"
      db "<11>", $00                   ;; 0e:6518
    sDELAY 90                                          ;; 0e:651b $f0 $5a
    sSFX 20                                            ;; 0e:651d $f9 $14
    sFLASH_SCREEN                                      ;; 0e:651f $bf
    sSFX 20                                            ;; 0e:6520 $f9 $14
    sFLASH_SCREEN                                      ;; 0e:6522 $bf
    sSPAWN_NPC 1                                       ;; 0e:6523 $fd $01
    sSET_NPC_2_DIRECTION_RIGHT                         ;; 0e:6525 $26
    sFLASH_SCREEN                                      ;; 0e:6526 $bf
    sDELAY 120                                         ;; 0e:6527 $f0 $78
    sMSG                                               ;; 0e:6529 $04
      db "<10><BOY>:What?!<12>"
      db "", $00       ;; 0e:652a
    sSET_NPC_2_DIRECTION_DOWN                          ;; 0e:6534 $25
    sDELAY 30                                          ;; 0e:6535 $f0 $1e
    sSET_NPC_2_DIRECTION_LEFT                          ;; 0e:6537 $27
    sMSG                                               ;; 0e:6538 $04
      db "<1b>Julius:Use this\n Pendant and cast\n the spell, <GIRL>.<12>"
      db "<1b><BOY>:<GIRL>!  Stop!\n Come over here!\n", $00
    sDELAY 30                                          ;; 0e:6572 $f0 $1e
    sMSG                                               ;; 0e:6574 $04
      db "<GIRL>:__", $00                              ;; 0e:6575
    sDELAY 60                                          ;; 0e:6579 $f0 $3c
    sMSG                                               ;; 0e:657b $04
      db "____<12>"
      db "<1b><BOY>:<GIRL>?", $00  ;; 0e:657c
    sDELAY 60                                          ;; 0e:6585 $f0 $3c
    sMSG                                               ;; 0e:6587 $04
      db "\n What did you do\n to her, Julius?", $00   ;; 0e:6588
    sDELAY 40                                          ;; 0e:659f $f0 $28
    sSET_NPC_2_DIRECTION_DOWN                          ;; 0e:65a1 $25
    sDELAY 20                                          ;; 0e:65a2 $f0 $14
    sSET_NPC_2_DIRECTION_RIGHT                         ;; 0e:65a4 $26
    sDELAY 20                                          ;; 0e:65a5 $f0 $14
    sMSG                                               ;; 0e:65a7 $04
      db "<12>"
      db "<1b>Julius:With the\n power of Mana,\n this is easy.<12>"
      db "", $00 ;; 0e:65a8
    sSET_NPC_2_DIRECTION_DOWN                          ;; 0e:65cd $25
    sDELAY 40                                          ;; 0e:65ce $f0 $28
    sMSG                                               ;; 0e:65d0 $04
      db "<1b> Now we celebrate\n the rebirth of\n Vandole!<12>"
      db "<1b> Now, <GIRL>!\n Reverse the\n Waterfalls!<12>"
      db "", $00 ;; 0e:65d1
    sSET_MUSIC 10                                      ;; 0e:660a $f8 $0a
    sSET_NPC_2_DIRECTION_LEFT                          ;; 0e:660c $27
    sMSG                                               ;; 0e:660d $04
      db "<1b><GIRL>:Klnka Imra\n Miryon Tin Qua_ _<12>"
      db "<11>", $00 ;; 0e:660e
    sDELAY 40                                          ;; 0e:662b $f0 $28
; Fill tiles just outside the screen before the shake effect.
; Because you must scroll in only one side needs to be done.
        sSET_ROOM_TILE $41, 15, 0
        sSET_ROOM_TILE $51, 15, 1
        sSET_ROOM_TILE $37, 15, 2
        sSET_ROOM_TILE $07, 15, 3
        sSET_ROOM_TILE $17, 15, 4
        sSET_ROOM_TILE $17, 15, 5
        sSET_ROOM_TILE $27, 15, 6
        sSET_ROOM_TILE $37, 15, 7
    sSFX 37                                            ;; 0e:662d $f9 $25
    sSHAKE_SCREEN                                      ;; 0e:662f $fb
    sSHAKE_SCREEN                                      ;; 0e:6630 $fb
    sLOOP 8, 4                                         ;; 0e:6631 $03 $08 $04
      sFLASH_SCREEN                                    ;; 0e:6634 $bf
      sSFX 20                                          ;; 0e:6635 $f9 $14
    sEND                                               ;; 0e:6637 $00
    sDELAY 20                                          ;; 0e:6638 $f0 $14
    sCALL script_0543                                  ;; 0e:663a $02 $77 $4e
    sDELAY 20                                          ;; 0e:663d $f0 $14
    sSET_NPC_2_DIRECTION_DOWN                          ;; 0e:663f $25
    sLOOP 6, 3                                         ;; 0e:6640 $03 $06 $03
      sNPC_1_STEP_BACKWARDS                            ;; 0e:6643 $11
      sNPC_2_STEP_BACKWARDS                            ;; 0e:6644 $21
    sEND                                               ;; 0e:6645 $00
    sLOOP 6, 2                                         ;; 0e:6646 $03 $06 $02
      sPLAYER_STEP_FORWARD                             ;; 0e:6649 $80
    sEND                                               ;; 0e:664a $00
    sSET_PLAYER_DIRECTION_UP                           ;; 0e:664b $84
    sMSG                                               ;; 0e:664c $04
      db "<10><BOY>:Wait!\nJulius:Fall!<12>"
      db "<11>", $00 ;; 0e:664d
    sDELAY 20                                          ;; 0e:6661 $f0 $14
    sLOOP 3, 4                                         ;; 0e:6663 $03 $03 $04
      sSFX 20                                          ;; 0e:6666 $f9 $14
      sFLASH_SCREEN                                    ;; 0e:6668 $bf
    sEND                                               ;; 0e:6669 $00
    sCREATE_EFFECT $10, $0c, $0c                       ;; 0e:666a $ba $10 $0c $0c
    sSET_PLAYER_HURT_SPRITE                            ;; 0e:666e $a5
    sLOOP 5, 2                                         ;; 0e:666f $03 $05 $02
      sPLAYER_STEP_BACKWARD                            ;; 0e:6672 $81
    sEND                                               ;; 0e:6673 $00
    sDELAY 60                                          ;; 0e:6674 $f0 $3c
    sLOOP 6, 3                                         ;; 0e:6676 $03 $06 $03
      sNPC_1_STEP_BACKWARDS                            ;; 0e:6679 $11
      sNPC_2_STEP_BACKWARDS                            ;; 0e:667a $21
    sEND                                               ;; 0e:667b $00
    sDEL_NPC_1                                         ;; 0e:667c $18
    sDEL_NPC_2                                         ;; 0e:667d $28
    sFADE_TO_WHITE                                     ;; 0e:667e $be
    sEND                                               ;; 0e:667f $00

script_0538:
    sSET_PLAYER_LAYDOWN_SPRITE                         ;; 0e:6680 $a6
    sDELAY 100                                         ;; 0e:6681 $f0 $64
    sSET_MUSIC 0                                       ;; 0e:6683 $f8 $00
    sLOAD_ROOM_INSTANT 0, $82, 9, 7                    ;; 0e:6685 $f3 $00 $82 $09 $07
    sDELAY 200                                         ;; 0e:668a $f0 $c8
    sFADE_TO_NORMAL                                    ;; 0e:668c $bc
    sMSG                                               ;; 0e:668d $04
      db "<10><BOY>:Ou_ _", $00                        ;; 0e:668e
    sDELAY 40                                          ;; 0e:6697 $f0 $28
    sMSG                                               ;; 0e:6699 $04
      db " ouch_\n Can't_ _ move_ _<12>"
      db "<11>", $00 ;; 0e:669a
    sDELAY 40                                          ;; 0e:66b1 $f0 $28
    sSFX 7                                             ;; 0e:66b3 $f9 $07
    sDELAY 10                                          ;; 0e:66b5 $f0 $0a
    sSFX 7                                             ;; 0e:66b7 $f9 $07
    sSET_NPC_TYPES 83                                  ;; 0e:66b9 $fc $53
    sMSG                                               ;; 0e:66bb $04
      db "<10>_", $00                                  ;; 0e:66bc
    sDELAY 40                                          ;; 0e:66bf $f0 $28
    sMSG                                               ;; 0e:66c1 $04
      db "__", $00                                     ;; 0e:66c2
    sDELAY 40                                          ;; 0e:66c4 $f0 $28
    sMSG                                               ;; 0e:66c6 $04
      db "__?<12>"
      db "<11>", $00                ;; 0e:66c7
; This NPC is changed to spawn offscreen so its direction can be set before it is shown.
    sSPAWN_NPC 1
    sSET_NPC_1_DIRECTION_LEFT                          ;; 0e:66ce $17
    sSET_NPC_1_POSITION 18, 7
    sDELAY 30                                          ;; 0e:66cf $f0 $1e
    sUNK_1A                                            ;; 0e:66d1 $1a
    sLOOP 7, 2                                         ;; 0e:66d2 $03 $07 $02
      sNPC_1_STEP_FORWARD                              ;; 0e:66d5 $10
    sEND                                               ;; 0e:66d6 $00
    sDELAY 100                                         ;; 0e:66d7 $f0 $64
    sSFX 7                                             ;; 0e:66d9 $f9 $07
    sDELAY 10                                          ;; 0e:66db $f0 $0a
    sSFX 7                                             ;; 0e:66dd $f9 $07
    sNPC_1_STEP_FORWARD                                ;; 0e:66df $10
    sNPC_1_STEP_FORWARD                                ;; 0e:66e0 $10
    sSET_PLAYER_POSITION 20, 16                        ;; 0e:66e1 $8a $14 $10
    sDELAY 20                                          ;; 0e:66e4 $f0 $14
    sSET_NPC_1_DIRECTION_RIGHT                         ;; 0e:66e6 $16
    sLOOP 11, 2                                        ;; 0e:66e7 $03 $0b $02
      sNPC_1_STEP_FORWARD                              ;; 0e:66ea $10
    sEND                                               ;; 0e:66eb $00
    sSCROLL_ROOM_RIGHT                                 ;; 0e:66ec $eb
    sSET_NPC_TYPES 83                                  ;; 0e:66ed $fc $53
    sSPAWN_NPC 1                                       ;; 0e:66ef $fd $01
    sSET_NPC_1_DIRECTION_RIGHT                         ;; 0e:66f1 $16
; This NPC is changed to spawn offscreen so it can walk in from offscreen.
    sSET_NPC_1_POSITION -2, 7
    sUNK_1A                                            ;; 0e:66f2 $1a
    sLOOP 12, 2                                        ;; 0e:66f3 $03 $0a $02
      sNPC_1_STEP_FORWARD                              ;; 0e:66f6 $10
    sEND                                               ;; 0e:66f7 $00
    sSET_NPC_1_DIRECTION_UP                            ;; 0e:66f8 $14
    sNPC_1_STEP_FORWARD                                ;; 0e:66f9 $10
    sNPC_1_STEP_FORWARD                                ;; 0e:66fa $10
    sNPC_1_STEP_FORWARD                                ;; 0e:66fb $10
    sDEL_NPC_1                                         ;; 0e:66fc $18
    sSET_PLAYER_POSITION 20, 0                         ;; 0e:66fd $8a $14 $00
    sSET_PLAYER_NORMAL_SPRITE                          ;; 0e:6700 $a4
    sDELAY 40                                          ;; 0e:6701 $f0 $28
    sMSG                                               ;; 0e:6703 $04
      db "<10>_See, Auntie?\n Somebody's hurt!\nSarah:Oh, yes.<12>"
      db "<1b>_And a birdie is\n hurt, too!\nSarah:Oh_ dear_ _<12>"
      db "<11>", $00 ;; 0e:6704
    sDELAY 60                                          ;; 0e:6750 $f0 $3c
    sFADE_TO_BLACK                                     ;; 0e:6752 $bd
    sEND                                               ;; 0e:6753 $00

script_0539:
    sLOAD_ROOM_INSTANT 3, $01, 20, 3
    sSET_NPC_TYPES 76                                  ;; 0e:6759 $fc $4c
    sSPAWN_NPC 0                                       ;; 0e:675b $fd $00
; Replace the player with an NPC that looks the same without the shield
    sSPAWN_NPC 2
    sSET_NPC_2_POSITION 16, 3
    sSET_NPC_2_DIRECTION_RIGHT
    sDELAY 20                                          ;; 0e:675d $f0 $14
    sSET_MUSIC 27                                      ;; 0e:675f $f8 $1b
    sFADE_TO_NORMAL                                    ;; 0e:6762 $bc
    sDELAY 180                                         ;; 0e:6763 $f0 $b4
    sSET_NPC_2_DIRECTION_LEFT
    sMSG                                               ;; 0e:6766 $04
      db "<10>Bogard:<BOY>__\n<BOY>:_ Bogard!\n How are you?", $00
    sNPC_2_STEP_FORWARD
    sNPC_2_STEP_FORWARD
    sSET_NPC_2_DIRECTION_LEFT
    sMSG                                               ;; 0e:6789 $04
      db "<12>"
      db "<1b>Bogard:I was\n thrown off the\n airship__<12>"
      db "<1b> But Sarah found\n me and nursed me\n back to health.<12>"
      db "<1b> I'm glad to see\n you again, <BOY>.<12>"
      db "<1b> You're the last\n hope of the\n Gemma Knights.<12>"
      db "<11>", $00 ;; 0e:678a
    sDELAY 40                                          ;; 0e:67da $f0 $28
    sSET_NPC_2_DIRECTION_DOWN
    sNPC_2_STEP_FORWARD
    sNPC_2_STEP_FORWARD
    sNPC_2_STEP_FORWARD
    sSET_NPC_2_DIRECTION_LEFT
    sNPC_2_STEP_FORWARD
    sNPC_2_STEP_FORWARD
    sNPC_2_STEP_FORWARD
    sNPC_2_STEP_FORWARD
    sSET_NPC_2_DIRECTION_DOWN
    sDELAY 20                                          ;; 0e:67e6 $f0 $14
    sMSG                                               ;; 0e:67e8 $04
      db "<10><BOY>:I can't do\n this anymore_\n I can't do it!<12>"
      db "<11>", $00 ;; 0e:67e9
    sDELAY 40                                          ;; 0e:680a $f0 $28
    sSET_NPC_2_DIRECTION_UP
    sSET_PLAYER_DIRECTION_UP                           ;; 0e:680c $84
    sDELAY 10                                          ;; 0e:680d $f0 $0a
    sMSG                                               ;; 0e:680f $04
      db "<10> I couldn't even\n save ", $00
    sCALL script_0433
    sMSG
      db "! I'm\n no Gemma Knight.<12>"
      db "<1b>Bogard:Quit it!\n This is no way\n for a Gemma to-<12>"
      db "<1b><BOY>:Enough! Gemma\n this! Gemma that!\n __ Why me?<12>"
      db "<1b> Why does that\n have to be me?\nBogard:<BOY>, you_<12>"
      db "<1b><BOY>:You do it!\n You're the Gemma\n Knight. It's you!<12>"
      db "<1b>Bogard:_ Shut up!\n _ GET OUT!!_<12>", $00
    sDELAY 20                                          ;; 0e:68c9 $f0 $14
    sSET_PLAYER_POSITION 10, 6
    sDEL_NPC_2
    sMSG                                               ;; 0e:68cb $04
      db "<11>", $00                                   ;; 0e:68cc
    sSET_PLAYER_DIRECTION_LEFT                         ;; 0e:68ce $87
    sPLAYER_STEP_FORWARD                               ;; 0e:68cf $80
    sSET_PLAYER_DIRECTION_DOWN                         ;; 0e:68d0 $85
    sLOOP 6, 2                                         ;; 0e:68d1 $03 $06 $02
      sPLAYER_STEP_FORWARD                             ;; 0e:68d4 $80
    sEND                                               ;; 0e:68d5 $00
    sLOAD_ROOM 15, $46, 4, 10                          ;; 0e:68d6 $f4 $0f $46 $04 $0a
    sCLEAR_FLAG wScriptFlags0B.3                       ;; 0e:68dd $db $5b
    sCLEAR_FLAG wScriptFlags0B.4                       ;; 0e:68df $db $5c
    sCLEAR_FLAG wScriptFlags0B.7                       ;; 0e:68e1 $db $5f
    sCLEAR_FLAG wScriptFlags0D.3                       ;; 0e:68e3 $db $6b
    sCALL script_0157                                  ;; 0e:68e5 $02 $0b $92
    sEND                                               ;; 0e:68e8 $00

script_053a:
    sDELAY 144                                         ;; 0e:68e9 $f0 $90
    sMSG                                               ;; 0e:68eb $04
      db "<10> _ <GIRL>, you've\n grown so tall__\n<GIRL>:Mother!\n<12>"
      db "<1b><BOY>:Mother?!\nCibba:Ah! That's\n the woman who<12>"
      db "<1b> gave us strength\n in our fight\n against Vandole.<12>"
      db "<1b>Mother:Listen to\n me carefully,\n <GIRL>.<12>"
      db "<1b> You and I are\n members of the\n Mana Family.<12>"
      db "<1b><BOY>:The Mana\n Family?<12>"
      db "<1b>Mother:We are Mana\n Seeds born from\n the Mana Tree_ <12>"
      db "<1b> Long ago Vandole\n used the power of\n Mana against us.<12>"
      db "<1b> So I sealed away\n the Mana Tree\n with the Pendant.<12>"
      db "<1b> But now, Granz is\n pursuing the same\n evil purpose.<12>"
      db "<1b> Granz cannot be\n allowed to reach\n the Mana Tree.<12>"
      db "<1b> Guard the Mana\n Tree with the\n Gemma Knights!<12>"
      db "<11>", $00 ;; 0e:68ec
    sDELAY 10                                          ;; 0e:6a2c $f0 $0a
    sFADE_TO_BLACK                                     ;; 0e:6a2e $bd
    sDEL_NPC_2                                         ;; 0e:6a2f $28
    sDELAY 40                                          ;; 0e:6a30 $f0 $28
    sFADE_TO_NORMAL                                    ;; 0e:6a32 $bc
    sMSG                                               ;; 0e:6a33 $04
      db "<10><1f> Her image fades_<12><11><00>"
    sDELAY 60                                          ;; 0e:6a51 $f0 $3c
    sMSG                                               ;; 0e:6a53 $04
      db "<10><GIRL>:Mom_<12>"
      db "<11>", $00    ;; 0e:6a54
    sLOOP 8, 4                                         ;; 0e:6a5d $03 $08 $04
      sSFX 20                                          ;; 0e:6a60 $f9 $14
      sFLASH_SCREEN                                    ;; 0e:6a62 $bf
    sEND                                               ;; 0e:6a63 $00
; Fill tiles just outside the screen before the shake effect.
        sSET_ROOM_TILE $06, 10, 0
        sSET_ROOM_TILE $10, 10, 1
        sSET_ROOM_TILE $10, 10, 2
        sSET_ROOM_TILE $10, 10, 3
        sSET_ROOM_TILE $40, 10, 4
        sSET_ROOM_TILE $40, 10, 5
        sSET_ROOM_TILE $40, 10, 6
        sSET_ROOM_TILE $50, 10, 7
        sSET_ROOM_TILE $05, 15, 0
        sSET_ROOM_TILE $15, 15, 1
        sSET_ROOM_TILE $15, 15, 2
        sSET_ROOM_TILE $15, 15, 3
        sSET_ROOM_TILE $45, 15, 4
        sSET_ROOM_TILE $45, 15, 5
        sSET_ROOM_TILE $45, 15, 6
        sSET_ROOM_TILE $55, 15, 7
    sSFX 37                                            ;; 0e:6a64 $f9 $25
    sSHAKE_SCREEN                                      ;; 0e:6a66 $fb
    sSET_MUSIC 9                                       ;; 0e:6a67 $f8 $09
; Speed up Cibba so he can move out from under the text windo.
    sUNK_1A
    sSET_PLAYER_DIRECTION_DOWN                         ;; 0e:6a69 $85
    sSET_NPC_1_DIRECTION_DOWN
    sFOLLOWER_DIRECTION_DOWN                           ;; 0e:6a6a $95
    sPLAYER_STEP_FORWARD                               ;; 0e:6a6b $80
    sPLAYER_STEP_FORWARD                               ;; 0e:6a6c $80
    sNPC_1_STEP_FORWARD
    sFOLLOWER_STEP_FORWARD                             ;; 0e:6a6e $90
    sNPC_1_STEP_FORWARD
    sPLAYER_STEP_FORWARD                               ;; 0e:6a6f $80
    sSET_PLAYER_DIRECTION_RIGHT
    sFOLLOWER_STEP_FORWARD                             ;; 0e:6a70 $90
    sPLAYER_STEP_FORWARD                               ;; 0e:6a71 $80
    sSPAWN_NPC 0                                       ;; 0e:6a72 $fd $00
    sUNK_2A                                            ;; 0e:6a74 $2a
    sSET_NPC_2_DIRECTION_UP                            ;; 0e:6a75 $24
    sNPC_2_STEP_FORWARD                                ;; 0e:6a76 $20
    sMSG                                               ;; 0e:6a77 $04
      db "<10>Traveler:Granz is\n attacking by air!\nCibba:What?!<12>"
      db "<1b>Traveler:Fuji,\n come with me to\n a safe place!<12>"
      db "<1b><GIRL>:Thank you.<12>"
      db "<11>", $00 ;; 0e:6a78
    sSET_NPC_2_DIRECTION_DOWN                          ;; 0e:6abe $25
    sLOOP 3, 3                                         ;; 0e:6abf $03 $03 $03
      sNPC_2_STEP_FORWARD                              ;; 0e:6ac2 $20
      sFOLLOWER_STEP_FORWARD                           ;; 0e:6ac3 $90
    sEND                                               ;; 0e:6ac4 $00
    sDEL_NPC_2                                         ;; 0e:6ac5 $28
    sLOOP 2, 2                                         ;; 0e:6ac6 $03 $02 $02
      sFOLLOWER_STEP_FORWARD                           ;; 0e:6ac9 $90
    sEND                                               ;; 0e:6aca $00
    sFOLLOWER_DELETE                                   ;; 0e:6acb $98
    sSET_NPC_1_DIRECTION_DOWN                          ;; 0e:6acc $15
    sMSG                                               ;; 0e:6acd $04
      db "<10>Cibba:Where did\n he take her?!\n<BOY>:I'll check.<12>"
      db "<11>", $00 ;; 0e:6ace
    sSET_PLAYER_DIRECTION_DOWN
    sLOAD_ROOM 1, $15, 9, 4
    sSFX 20                                            ;; 0e:6af7 $f9 $14
    sFLASH_SCREEN                                      ;; 0e:6af9 $bf
    sFLASH_SCREEN                                      ;; 0e:6afa $bf
    sSET_NPC_TYPES 36                                  ;; 0e:6afb $fc $24
    sSPAWN_NPC 2                                       ;; 0e:6afd $fd $02
    sCLEAR_FLAG wScriptFlags0A.1                       ;; 0e:6aff $db $51
    sSET_FLAG wScriptFlags02.0                         ;; 0e:6b01 $da $10
    sEND                                               ;; 0e:6b03 $00

script_053b:
    sSET_NPC_TYPES 55                                  ;; 0e:6b04 $fc $37
    sSPAWN_NPC 0                                       ;; 0e:6b06 $fd $00
    sSET_NPC_1_DIRECTION_UP                            ;; 0e:6b08 $14
    sMSG                                               ;; 0e:6b09 $04
      db "<10><BOY>:<GIRL>!", $00                      ;; 0e:6b0a
    sDELAY 20                                          ;; 0e:6b10 $f0 $14
    sMSG                                               ;; 0e:6b12 $04
      db " __?<12>"
      db "<11>", $00               ;; 0e:6b13
    sDELAY 20                                          ;; 0e:6b19 $f0 $14
    sFLASH_SCREEN                                      ;; 0e:6b1b $bf
    sLOOP 3, 13                                        ;; 0e:6b1c $03 $03 $0d
      sSET_NPC_1_DIRECTION_RIGHT                       ;; 0e:6b1f $16
      sDELAY 3                                         ;; 0e:6b20 $f0 $03
      sSET_NPC_1_DIRECTION_DOWN                        ;; 0e:6b22 $15
      sDELAY 3                                         ;; 0e:6b23 $f0 $03
      sSET_NPC_1_DIRECTION_LEFT                        ;; 0e:6b25 $17
      sDELAY 3                                         ;; 0e:6b26 $f0 $03
      sSET_NPC_1_DIRECTION_UP                          ;; 0e:6b28 $14
      sDELAY 3                                         ;; 0e:6b29 $f0 $03
    sEND                                               ;; 0e:6b2b $00
    sDEL_NPC_1                                         ;; 0e:6b2c $18
    sSET_NPC_TYPES 92                                  ;; 0e:6b2d $fc $5c
    sSPAWN_NPC 0                                       ;; 0e:6b2f $fd $00
    sLOOP 3, 13                                        ;; 0e:6b31 $03 $03 $0d
      sSET_NPC_1_DIRECTION_RIGHT                       ;; 0e:6b34 $16
      sDELAY 3                                         ;; 0e:6b35 $f0 $03
      sSET_NPC_1_DIRECTION_DOWN                        ;; 0e:6b37 $15
      sDELAY 3                                         ;; 0e:6b38 $f0 $03
      sSET_NPC_1_DIRECTION_LEFT                        ;; 0e:6b3a $17
      sDELAY 3                                         ;; 0e:6b3b $f0 $03
      sSET_NPC_1_DIRECTION_UP                          ;; 0e:6b3d $14
      sDELAY 3                                         ;; 0e:6b3e $f0 $03
    sEND                                               ;; 0e:6b40 $00
    sDELAY 50                                          ;; 0e:6b41 $f0 $32
    sSPAWN_NPC 1                                       ;; 0e:6b43 $fd $01
    sSET_NPC_2_DIRECTION_UP                            ;; 0e:6b45 $24
    sMSG                                               ;; 0e:6b46 $04
      db "<10><BOY>:Julius! Why?!\n", $00
    sIF_FLAG wScriptFlags01.0
      sMSG
        db " You offered to\n help me before.<12>", $00
    sELSE
      sMSG
        db " You helped me\n once before.<12>", $00
    sENDIF
    sMSG
      db "<1b>Julius:Even my\n powers are not\n perfect.<12>"
      db "<1b> Until I saw the\n ritual I was not\n completely sure<12>"
      db "<1b> whether she was\n a member of the\n Mana Family.<12>"
      db "<1b> That's why I hid\n my identity_ and\n", $00
    sIF_FLAG wScriptFlags01.0
      sMSG
        db " waited.<12>", $00
    sELSE
      sMSG
        db " helped save her.<12>", $00
      sSET_FLAG wScriptFlags01.0
    sENDIF
    sMSG
      db "<1b> But now she will\n serve the Kingdom\n of Granz!<12>"
      db "<11>", $00 ;; 0e:6b47
    sSET_NPC_1_DIRECTION_DOWN                          ;; 0e:6be5 $15
    sNPC_1_STEP_FORWARD                                ;; 0e:6be6 $10
    sNPC_2_STEP_BACKWARDS                              ;; 0e:6be7 $21
    sNPC_1_STEP_FORWARD                                ;; 0e:6be8 $10
    sNPC_2_STEP_BACKWARDS                              ;; 0e:6be9 $21
    sDEL_NPC_2                                         ;; 0e:6bea $28
    sPLAYER_STEP_FORWARD                               ;; 0e:6beb $80
    sPLAYER_STEP_FORWARD                               ;; 0e:6bec $80
    sMSG                                               ;; 0e:6bed $04
      db "<10><BOY>:<GIRL>!!<12>"
      db "<11>", $00 ;; 0e:6bee
    sDELAY 60                                          ;; 0e:6bf7 $f0 $3c
    sSET_NPC_1_DIRECTION_UP                            ;; 0e:6bf9 $14
    sDELAY 80                                          ;; 0e:6bfa $f0 $50
    sSFX 20                                            ;; 0e:6bfc $f9 $14
    sFLASH_SCREEN                                      ;; 0e:6bfe $bf
    sSFX 20                                            ;; 0e:6bff $f9 $14
    sCREATE_EFFECT $10, $08, $0c                       ;; 0e:6c01 $ba $10 $08 $0c
    sCREATE_EFFECT $10, $0a, $0a                       ;; 0e:6c05 $ba $10 $0a $0a
    sSET_FAST_MOVEMENT                                 ;; 0e:6c09 $88
    sSET_PLAYER_HURT_SPRITE                            ;; 0e:6c0a $a5
    sLOOP 7, 2                                         ;; 0e:6c0b $03 $07 $02
      sPLAYER_STEP_BACKWARD                            ;; 0e:6c0e $81
    sEND                                               ;; 0e:6c0f $00
    sCREATE_EFFECT $10, $09, $03                       ;; 0e:6c10 $ba $10 $09 $03
    sSFX 12                                            ;; 0e:6c14 $f9 $0c
    sLOOP 7, 2                                         ;; 0e:6c16 $03 $07 $02
      sPLAYER_STEP_FORWARD                             ;; 0e:6c19 $80
    sEND                                               ;; 0e:6c1a $00
    sCLEAR_FAST_MOVEMENT                               ;; 0e:6c1b $89
    sSET_PLAYER_LAYDOWN_SPRITE                         ;; 0e:6c1c $a6
    sSET_PLAYER_DIRECTION_LEFT
    sSET_MUSIC 0                                       ;; 0e:6c1d $f8 $00
    sSFX 20                                            ;; 0e:6c20 $f9 $14
    sDELAY 60                                          ;; 0e:6c22 $f0 $3c
    sNPC_1_STEP_FORWARD                                ;; 0e:6c24 $10
    sNPC_1_STEP_FORWARD                                ;; 0e:6c25 $10
    sMSG                                               ;; 0e:6c26 $04
      db "<10>Julius:You stand\n no chance against\n my magical power.<12>"
      db "<11>", $00 ;; 0e:6c27
    sSET_NPC_1_DIRECTION_DOWN                          ;; 0e:6c4c $15
    sNPC_1_STEP_FORWARD                                ;; 0e:6c4d $10
    sNPC_1_STEP_FORWARD                                ;; 0e:6c4e $10
    sDEL_NPC_1                                         ;; 0e:6c4f $18
    sDELAY 60                                          ;; 0e:6c50 $f0 $3c
    sMSG                                               ;; 0e:6c52 $04
      db "<10><BOY>:_ _ <GIRL> _<12>"
      db "<11>", $00 ;; 0e:6c53
    sDELAY 60                                          ;; 0e:6c60 $f0 $3c
    sFADE_TO_BLACK                                     ;; 0e:6c62 $bd
    sSET_FLAG wScriptFlags02.1                         ;; 0e:6c63 $da $11
    sLOAD_ROOM_INSTANT 4, $62, 7, 6                    ;; 0e:6c65 $f3 $04 $62 $07 $06
    sUNK_C5 5                                          ;; 0e:6c6a $c5 $05
    sSET_NPC_TYPES 55                                  ;; 0e:6c6c $fc $37
    sSPAWN_NPC 2                                       ;; 0e:6c6e $fd $02
    sSET_NPC_1_DIRECTION_LEFT                          ;; 0e:6c70 $17
    sDELAY 88                                          ;; 0e:6c71 $f0 $58
    sFADE_TO_NORMAL                                    ;; 0e:6c73 $bc
    sDELAY 50                                          ;; 0e:6c74 $f0 $32
    sMSG                                               ;; 0e:6c76 $04
      db "<10>Cibba:Alright?\n", $00                   ;; 0e:6c77
    sSET_PLAYER_NORMAL_SPRITE                          ;; 0e:6c85 $a4
    sSET_PLAYER_DIRECTION_RIGHT                        ;; 0e:6c86 $86
    sMSG                                               ;; 0e:6c87 $04
      db "<BOY>:_ _ <GIRL>!\n Where is <GIRL>?<12>"
      db "<1b>Cibba:Julius took\n <GIRL> to the west\n in an airship!<12>"
      db "<1b>", $00 ;; 0e:6c88
    sSET_MUSIC 11                                      ;; 0e:6cbe $f8 $0b
    sDELAY 30                                          ;; 0e:6cc0 $f0 $1e
    sMSG                                               ;; 0e:6cc2 $04
      db "<BOY>:I'm going_!\nCibba:Then take\n this with you.<12>"
      db "<1b>", $00 ;; 0e:6cc3
    sSFX 15                                            ;; 0e:6ce6 $f9 $0f
    sMSG                                               ;; 0e:6ce8 $04
      db "Received the Book\nof Luna!\nLearned Heal.", $00
    sGIVE_MAGIC INV_MAGIC_HEAL                         ;; 0e:6d0a $d6 $01
    sMSG                                               ;; 0e:6d0c $04
      db "<12>"
      db "<1b> Luna's magic will\n help you recover.\n<BOY>:Thanks.<12>"
      db "<11>", $00 ;; 0e:6d0d
    sEND                                               ;; 0e:6d31 $00

script_053c:
    sMSG                                               ;; 0e:6d32 $04
      db "Lester:Thank you.\n<BOY>:I'm sorry to\n tell you but__<12>"
      db "", $00 ;; 0e:6d33
    sSET_MUSIC 27                                      ;; 0e:6d53 $f8 $1b
    sMSG                                               ;; 0e:6d55 $04
      db "<1b> ", $00
    sCALL script_0433
    sMSG
      db " sacrificed\n ", $00
    sIF_FLAG wScriptFlags0A.0
      sMSG
        db "her", $00
    sELSE
      sMSG
        db "his", $00
    sENDIF
    sMSG
      db " life to save\n you __<12>"
      db "<1b>Lester:To save me?\n __ Oh, ", $00
    sCALL script_0433
    sMSG
      db "__<12>"
      db "<1b> Will you please\n help me avenge\n my ", $00
    sIF_FLAG wScriptFlags0A.0
      sMSG
        db "sist", $00
    sELSE
      sMSG
        db "broth", $00
    sENDIF
    sMSG
      db "er?<12>"
      db "<1b><BOY>:Yes, Lester.\nLester:Thanks.\n Let's go, <BOY>!<12>"
      db "<11>", $00 ;; 0e:6d56
    sSFX 9                                             ;; 0e:6dd2 $f9 $09
    sDELAY 60                                          ;; 0e:6dd4 $f0 $3c
    sSFX 24                                            ;; 0e:6dd6 $f9 $18
    sSET_ROOM_TILE $02, 8, 6                           ;; 0e:6dd8 $b0 $02 $08 $06
    sDELAY 60                                          ;; 0e:6ddc $f0 $3c
    sMSG                                               ;; 0e:6dde $04
      db "<10><BOY>:Mystic tune?!\nLester:Yeah.<12>"
      db "<11>", $00 ;; 0e:6ddf
    sEND                                               ;; 0e:6df8 $00

script_053d:
    sMSG                                               ;; 0e:6df9 $04
      db "<BOY>:", $00
    sCALL script_0433
    sMSG
      db "!\n Did you take the\n Pendant? __ Why?<12>"
      db "<1b>", $00
    sCALL script_0433
    sMSG
      db ":I'm sorry.\n I had to bring\n it to Davias__<12>"
      db "<1b> That Pendant was\n to exchange for\n my brother. But__<12>"
      db "<1b> Davias cursed him\n and turned him\n into a parrot__!<12>"
      db "<1b> I must get the\n tears of Medusa\n to uncurse him!<12>"
      db "<1b><BOY>:_ ", $00
    sCALL script_0433
    sMSG
      db "__\n __ I'll help you.\n", $00
    sCALL script_0433
    sMSG
      db ":Thank you.", $00 ;; 0e:6dfa
    sSET_FLAG wScriptFlags03.3                         ;; 0e:6ec3 $da $1b
    sEND                                               ;; 0e:6ec5 $00

script_053e:
    sSET_NPC_1_DIRECTION_LEFT                          ;; 0e:6ec6 $17
    sSET_MUSIC 0                                       ;; 0e:6ec7 $f8 $00
    sCREATE_EFFECT $10, $03, $02                       ;; 0e:6ec9 $ba $10 $03 $02
    sCREATE_EFFECT $10, $05, $04                       ;; 0e:6ecd $ba $10 $05 $04
    sCREATE_EFFECT $10, $04, $03                       ;; 0e:6ed1 $ba $10 $04 $03
    sDELAY 40                                          ;; 0e:6ed5 $f0 $28
    sLOOP 6, 2                                         ;; 0e:6ed7 $03 $06 $02
      sPLAYER_STEP_FORWARD                             ;; 0e:6eda $80
    sEND                                               ;; 0e:6edb $00
    sSET_PLAYER_DIRECTION_LEFT                         ;; 0e:6edc $87
    sMSG                                               ;; 0e:6edd $04
      db "<10>Bon Voyage:Phew_!\n All done!", $00
    sSET_MUSIC 5                                       ;; 0e:6ef1 $f8 $05
    sMSG                                               ;; 0e:6ef3 $04
      db "<12>"
      db "<1b> I mechanized his\n wounded legs.\n He's fine now!<12>"
      db "<1b> He can even run\n on water!<12>"
      db "<1b> I named him\n Chocobot!!\n How's that?<12>"
      db "<11>", $00 ;; 0e:6ef4
    sSET_NPC_1_DIRECTION_DOWN                          ;; 0e:6f49 $15
    sNPC_1_STEP_FORWARD                                ;; 0e:6f4a $10
    sNPC_1_STEP_FORWARD                                ;; 0e:6f4b $10
    sSET_NPC_1_DIRECTION_RIGHT                         ;; 0e:6f4c $16
    sLOOP 3, 2                                         ;; 0e:6f4d $03 $03 $02
      sNPC_1_STEP_FORWARD                              ;; 0e:6f50 $10
    sEND                                               ;; 0e:6f51 $00
    sSFX 7                                             ;; 0e:6f52 $f9 $07
    sDELAY 10                                          ;; 0e:6f54 $f0 $0a
    sSFX 7                                             ;; 0e:6f56 $f9 $07
    sDELAY 50                                          ;; 0e:6f58 $f0 $32
    sMSG                                               ;; 0e:6f5a $04
      db "<10><BOY>:Oh_ You_\nBon Voyage:We all\n rely on you, kid!<12>"
      db "<11>", $00 ;; 0e:6f5b
    sSET_NPC_2_DIRECTION_RIGHT                         ;; 0e:6f7e $26
    sLOOP 4, 2                                         ;; 0e:6f7f $03 $04 $02
      sNPC_2_STEP_FORWARD                              ;; 0e:6f82 $20
    sEND                                               ;; 0e:6f83 $00
    sSET_NPC_2_DIRECTION_DOWN                          ;; 0e:6f84 $25
    sNPC_2_STEP_FORWARD                                ;; 0e:6f85 $20
    sNPC_2_STEP_FORWARD                                ;; 0e:6f86 $20
    sSET_PLAYER_DIRECTION_UP                           ;; 0e:6f87 $84
    sDELAY 40                                          ;; 0e:6f88 $f0 $28
    sMSG                                               ;; 0e:6f8a $04
      db "<10> Talk to Bogard\n before you leave\n town.<12>"
      db "<11>", $00 ;; 0e:6f8b
    sLOAD_ROOM 15, $26, 4, 12                          ;; 0e:6fae $f4 $0f $26 $04 $0c
    sSET_MUSIC 4                                       ;; 0e:6fb3 $f8 $04
    sSET_FLAG wScriptFlags0C.6                         ;; 0e:6fb5 $da $66
    sSET_FLAG wScriptFlags04.1                         ;; 0e:6fb7 $da $21
    sEND                                               ;; 0e:6fb9 $00

script_053f:
    sSET_MUSIC 0                                       ;; 0e:6fba $f8 $00
    sCREATE_EFFECT $10, $04, $04                       ;; 0e:6fbc $ba $10 $04 $04
    sCREATE_EFFECT $10, $0a, $08                       ;; 0e:6fc0 $ba $10 $0a $08
    sCREATE_EFFECT $10, $07, $03                       ;; 0e:6fc4 $ba $10 $07 $03
    sCREATE_EFFECT $10, $0d, $02                       ;; 0e:6fc8 $ba $10 $0d $02
    sLOOP 10, 4                                        ;; 0e:6fcc $03 $0a $04
      sFLASH_SCREEN                                    ;; 0e:6fcf $bf
      sSFX 20                                          ;; 0e:6fd0 $f9 $14
    sEND                                               ;; 0e:6fd2 $00
    sFADE_TO_BLACK                                     ;; 0e:6fd3 $bd
    sFOLLOWER_DELETE                                   ;; 0e:6fd4 $98
    sLOAD_ROOM_INSTANT 15, $05, 8, 9                   ;; 0e:6fd5 $f3 $0f $05 $08 $09
    sDELAY 255                                         ;; 0e:6fda $f0 $ff
    sLOCK_TEXT_SPEED                                   ;; 0e:6fdc $dc
    sSET_PLAYER_POSITION 8, 9                          ;; 0e:6fdd $8a $08 $09
    sSET_PLAYER_DIRECTION_RIGHT                        ;; 0e:6fe0 $86
    sSET_NPC_TYPES 98                                  ;; 0e:6fe1 $fc $62
    sDELAY 6                                           ;; 0e:6fe3 $f0 $06
    sSPAWN_NPC 0                                       ;; 0e:6fe5 $fd $00
    sSET_NPC_1_DIRECTION_DOWN                          ;; 0e:6fe7 $15
    sFADE_TO_NORMAL                                    ;; 0e:6fe8 $bc
    sDELAY 80                                          ;; 0e:6fe9 $f0 $50
    sMSG                                               ;; 0e:6feb $04
      db "<10><1f>The Tree vanishes_", $00   ;; 0e:6fec
    sDELAY 60                                          ;; 0e:7003 $f0 $3c
    sMSG                                               ;; 0e:7005 $04
      db "<1b><BOY>:Oh__ _\n<GIRL>:_ What am I\n supposed to do_?", $00 ;; 0e:7006
    sDELAY 80                                          ;; 0e:7027 $f0 $50
    sMSG                                               ;; 0e:7029 $04
      db "<11>", $00                                   ;; 0e:702a
    sDELAY 80                                          ;; 0e:702c $f0 $50
    sMSG                                               ;; 0e:702e $04
      db "<10> <GIRL>, my dear__\n", $00               ;; 0e:702f
    sDELAY 120                                         ;; 0e:703b $f0 $78
    sMSG                                               ;; 0e:703d $04
      db "<GIRL>:__", $00                              ;; 0e:703e
    sDELAY 80                                          ;; 0e:7042 $f0 $50
    sMSG                                               ;; 0e:7044 $04
      db " Mom?", $00                                  ;; 0e:7045
    sSET_MUSIC 3                                       ;; 0e:7049 $f8 $03
    sDELAY 80                                          ;; 0e:704b $f0 $50
    sMSG                                               ;; 0e:704d $04
      db "<11>", $00                                   ;; 0e:704e
    sSPAWN_NPC 2                                       ;; 0e:7050 $fd $02
    sDELAY 40                                          ;; 0e:7052 $f0 $28
    sSET_NPC_1_DIRECTION_UP                            ;; 0e:7054 $14
    sSET_PLAYER_DIRECTION_UP                           ;; 0e:7055 $84
    sDELAY 100                                         ;; 0e:7056 $f0 $64
    sNPC_1_STEP_FORWARD                                ;; 0e:7058 $10
    sPLAYER_STEP_FORWARD                               ;; 0e:7059 $80
    sNPC_1_STEP_FORWARD                                ;; 0e:705a $10
    sPLAYER_STEP_FORWARD                               ;; 0e:705b $80
    sDELAY 90                                          ;; 0e:705c $f0 $5a
    sMSG                                               ;; 0e:705e $04
      db "<10>Mother:<GIRL>, the\n Mana Tree is\n gone now, but", $00
    sDELAY 120
    sMSG
      db "<1b> you can become\n a new tree.", $00
    sDELAY 120
    sMSG
      db "<1b><GIRL>:_ New tree?", $00 ;; 0e:705f
    sDELAY 40                                          ;; 0e:70a3 $f0 $28
    sMSG                                               ;; 0e:70a5 $04
      db "\nMother:Remember\n what I told you?", $00
    sDELAY 120
    sMSG
      db "<1b> We are the seeds\n of the Mana Tree.", $00
    sDELAY 120
    sMSG
      db "<1b> You, yourself,\n will become the\n Mana Tree.", $00
    sDELAY 120
    sMSG
      db "<1b> Last time, I was\n unable to protect\n the Mana Tree.", $00
    sDELAY 120
    sMSG
      db "<1b> So I came here\n to become a new\n tree.", $00
    sDELAY 120
    sMSG
      db "<1b><GIRL>:That tree__?\n It was you__?\nMother:_Yes, <GIRL>.", $00
    sDELAY 120
    sMSG
      db "<1b> You can become a\n new Mana Tree and\n restore peace.", $00
    sDELAY 120
    sMSG
      db "<1b> But_ <GIRL>_ It\n is your choice\n to make.", $00
    sDELAY 80                                          ;; 0e:71d9 $f0 $50
    sMSG                                               ;; 0e:71db $04
      db "<11>", $00                                   ;; 0e:71dc
    sSET_MUSIC 0                                       ;; 0e:71de $f8 $00
    sDELAY 80                                          ;; 0e:71e0 $f0 $50
    sSET_NPC_1_DIRECTION_LEFT                          ;; 0e:71e2 $17
    sDELAY 80                                          ;; 0e:71e3 $f0 $50
    sSET_PLAYER_DIRECTION_RIGHT                        ;; 0e:71e5 $86
    sDELAY 200                                         ;; 0e:71e6 $f0 $c8
    sSET_NPC_1_DIRECTION_UP                            ;; 0e:71e8 $14
    sDELAY 100                                         ;; 0e:71e9 $f0 $64
    sEND                                               ;; 0e:71eb $00

script_0540:
    sMSG                                               ;; 0e:71ec $04
      db "<10><GIRL>:", $00                            ;; 0e:71ed
    sSET_MUSIC 1                                       ;; 0e:71f1 $f8 $01
    sMSG                                               ;; 0e:71f3 $04
      db "I will, Mom.", $00                           ;; 0e:71f4
    sSET_PLAYER_DIRECTION_UP                           ;; 0e:71fc $84
    sMSG                                               ;; 0e:71fd $04
      db "\n I will be the new\n Mana Tree.", $00   ;; 0e:71fe
    sDELAY 120                                         ;; 0e:7214 $f0 $78
    sMSG                                               ;; 0e:7216 $04
      db "<1b> But if I am the\n last one left,\n when I fall_", $00 ;; 0e:7217
    sDELAY 100                                         ;; 0e:7236 $f0 $64
    sMSG                                               ;; 0e:7238 $04
      db "<1b>Mother:Yes_\n That will be the\n end of the peace_", $00 ;; 0e:7239
    sDELAY 120                                         ;; 0e:725a $f0 $78
    sSET_NPC_1_DIRECTION_LEFT                          ;; 0e:725c $17
    sMSG                                               ;; 0e:725d $04
      db "<1b><GIRL>:_ Bye_ <BOY>.\n Please go_ _\n I must stay here_", $00 ;; 0e:725e
    sDELAY 120                                         ;; 0e:7281 $f0 $78
    sSET_PLAYER_DIRECTION_RIGHT                        ;; 0e:7283 $86
    sMSG                                               ;; 0e:7284 $04
      db "<1b> __ Don't worry.\n I will be here\n as long as_", $00 ;; 0e:7285
    sDELAY 120                                         ;; 0e:72a5 $f0 $78
    sMSG                                               ;; 0e:72a7 $04
      db "<1b> _ you guard me\n from evil__<00>"
    sDELAY 120                                         ;; 0e:72be $f0 $78
    sMSG                                               ;; 0e:72c0 $04
      db "<1b>", $00                                   ;; 0e:72c1
    sSET_PLAYER_DIRECTION_UP                           ;; 0e:72c3 $84
    sSET_NPC_1_DIRECTION_UP                            ;; 0e:72c4 $14
    sDELAY 40                                          ;; 0e:72c5 $f0 $28
    sMSG                                               ;; 0e:72c7 $04
      db "Mother:<BOY>__\n Please protect\n my daughter.<00>"
    sDELAY 120                                         ;; 0e:72e4 $f0 $78
    sMSG                                               ;; 0e:72e6 $04
      db "<1b> You are the only\n Gemma Knight for\n the Tree now__", $00 ;; 0e:72e7
    sDELAY 120                                         ;; 0e:7309 $f0 $78
    sMSG                                               ;; 0e:730b $04
      db "<1b> I will be\n withering soon_", $00
    sDELAY 120                                         ;; 0e:7323 $f0 $78
    sMSG                                               ;; 0e:7325 $04
      db "<1b> Please tell my\n Gemma Knights\n that I said_", $00 ;; 0e:7326
    sDELAY 120                                         ;; 0e:7345 $f0 $78
    sMSG                                               ;; 0e:7347 $04
      db "<1b> goodbye and\n thank you.<00>"
    sDELAY 120                                         ;; 0e:735e $f0 $78
    sMSG                                               ;; 0e:7360 $04
      db "<11>", $00                                   ;; 0e:7361
    sLOOP 6, 4                                         ;; 0e:7363 $03 $06 $04
      sSFX 20                                          ;; 0e:7366 $f9 $14
      sFLASH_SCREEN                                    ;; 0e:7368 $bf
    sEND                                               ;; 0e:7369 $00
    sMSG                                               ;; 0e:736a $04
      db "<10>Mother:You should\n go now.<00>"
    sDELAY 70                                          ;; 0e:737b $f0 $46
    sMSG                                               ;; 0e:737d $04
      db "<1b>", $00                                   ;; 0e:737e
    sSET_PLAYER_DIRECTION_RIGHT                        ;; 0e:7380 $86
    sSET_NPC_1_DIRECTION_LEFT                          ;; 0e:7381 $17
    sMSG                                               ;; 0e:7382 $04
      db "<BOY>:<GIRL>_<00>"
    sDELAY 80                                          ;; 0e:738a $f0 $50
    sFLASH_SCREEN                                      ;; 0e:738c $bf
    sFLASH_SCREEN                                      ;; 0e:738d $bf
    sMSG                                               ;; 0e:738e $04
      db "\n<GIRL>:<BOY>__", $00                       ;; 0e:738f
    sDELAY 80                                          ;; 0e:7395 $f0 $50
    sFLASH_SCREEN                                      ;; 0e:7397 $bf
    sMSG                                               ;; 0e:7398 $04
      db "<11>", $00                                   ;; 0e:7399
    sDELAY 90                                          ;; 0e:739b $f0 $5a
    sSET_NPC_1_DIRECTION_UP                            ;; 0e:739d $14
    sSET_NPC_2_DIRECTION_LEFT                          ;; 0e:739e $27
    sNPC_2_STEP_FORWARD                                ;; 0e:739f $20
    sLOOP 4, 2                                         ;; 0e:73a0 $03 $04 $02
      sNPC_1_STEP_FORWARD                              ;; 0e:73a3 $10
    sEND                                               ;; 0e:73a4 $00
    sDELAY 50                                          ;; 0e:73a5 $f0 $32
    sSET_NPC_1_DIRECTION_LEFT                          ;; 0e:73a7 $17
    sDELAY 30                                          ;; 0e:73a8 $f0 $1e
    sSET_NPC_1_DIRECTION_DOWN                          ;; 0e:73aa $15
    sSET_PLAYER_DIRECTION_UP                           ;; 0e:73ab $84
    sFLASH_SCREEN                                      ;; 0e:73ac $bf
    sFLASH_SCREEN                                      ;; 0e:73ad $bf
    sMSG                                               ;; 0e:73ae $04
      db "<10><GIRL>:Farewell_\n <BOY>.<00>"
    sDELAY 70                                          ;; 0e:73ba $f0 $46
    sMSG                                               ;; 0e:73bc $04
      db "\n<BOY>:Farewell_<00>"
    sDELAY 120                                         ;; 0e:73ce $f0 $78
    sMSG                                               ;; 0e:73d0 $04
      db "<11>", $00                                   ;; 0e:73d1
    sLOOP 5, 2                                         ;; 0e:73d3 $03 $05 $02
      sFLASH_SCREEN                                    ;; 0e:73d6 $bf
    sEND                                               ;; 0e:73d7 $00
    sFADE_TO_BLACK                                     ;; 0e:73d8 $bd
    sLOAD_ROOM_INSTANT 15, $55, 20, 0                  ;; 0e:73d9 $f3 $0f $55 $14 $00
    sLETTER_BOX_EFFECT                                 ;; 0e:73de $b6
    sFADE_TO_NORMAL                                    ;; 0e:73df $bc
    sDELAY 60                                          ;; 0e:73e0 $f0 $3c
    sSET_MUSIC 0                                       ;; 0e:73e2 $f8 $00
    sMSG                                               ;; 0e:73e4 $04
      db "<10>", $00                                   ;; 0e:73e5
    sDELAY 60                                          ;; 0e:73e7 $f0 $3c
    sMSG                                               ;; 0e:73e9 $04
      db " Goodbye_<00>"
    sDELAY 60                                          ;; 0e:73f5 $f0 $3c
    sMSG                                               ;; 0e:73f7 $04
      db "\n     _", $00                               ;; 0e:73f8
    sDELAY 40                                          ;; 0e:73fe $f0 $28
    sMSG                                               ;; 0e:7400 $04
      db "<GIRL>__", $00                               ;; 0e:7401
    sDELAY 130                                         ;; 0e:7404 $f0 $82
    sMSG                                               ;; 0e:7406 $04
      db "<11>", $00                                   ;; 0e:7407
    sDELAY 100                                         ;; 0e:7409 $f0 $64
    sEND                                               ;; 0e:740b $00

script_0541:
    sDELAY 100                                         ;; 0e:740c $f0 $64
    sSET_MUSIC 21                                      ;; 0e:740e $f8 $15
    sDELAY 120                                         ;; 0e:7410 $f0 $78
    sMSG                                               ;; 0e:7412 $04
      db "<10>A seed_\nbrings peace.\nA new Mana Sprout_<00>"
    sDELAY 200
    sMSG                                               ;; 0e:7434 $04
      db "<1b>If it is tainted,\nthen peace will\nbe lost forever.<00>"
    sDELAY 200
    sMSG                                               ;; 0e:7456 $04
      db "<1b>And so it must be\nguarded with care.<00>"
    sDELAY 200
    sMSG                                               ;; 0e:746f $04
      db "<1b>As the last Gemma\nKnight, that duty\nis given to <BOY>.<00>"
    sDELAY 200
    sMSG                                               ;; 0e:7491 $04
      db "<11>", $00                                   ;; 0e:7492
    sFADE_TO_BLACK                                     ;; 0e:7494 $bd
    sLOAD_ROOM_INSTANT 15, $06, 20, 0                  ;; 0e:7495 $f3 $0f $06 $14 $00
    sSET_NPC_TYPES 100                                 ;; 0e:749a $fc $64
    sSPAWN_NPC 1                                       ;; 0e:749c $fd $01
    sSPAWN_NPC 2                                       ;; 0e:749e $fd $02
    sSET_NPC_1_DIRECTION_LEFT                          ;; 0e:74a0 $17
    sSET_NPC_2_DIRECTION_LEFT                          ;; 0e:74a1 $27
    sDELAY 100                                         ;; 0e:74a2 $f0 $64
    sFADE_TO_NORMAL                                    ;; 0e:74a4 $bc
    sDELAY 100                                         ;; 0e:74a5 $f0 $64
    sSET_PLAYER_DIRECTION_RIGHT                        ;; 0e:74a7 $86
    sSET_PLAYER_POSITION 0, 7                          ;; 0e:74a8 $8a $00 $07
    sLOOP 8, 2                                         ;; 0e:74ab $03 $08 $02
      sPLAYER_STEP_FORWARD                             ;; 0e:74ae $80
    sEND                                               ;; 0e:74af $00
    sDELAY 110                                         ;; 0e:74b0 $f0 $6e
    sMSG                                               ;; 0e:74b2 $04
      db "<10>TRANSLATION\n  KAORU MORIYAMA", $00      ;; 0e:74b3
    sDELAY 255                                         ;; 0e:74cf $f0 $ff
    sDELAY 20                                          ;; 0e:74d1 $f0 $14
    sMSG                                               ;; 0e:74d3 $04
      db "<11>", $00                                   ;; 0e:74d4
    sDELAY 90                                          ;; 0e:74d6 $f0 $5a
    sSPAWN_NPC 0                                       ;; 0e:74d8 $fd $00
    sSET_NPC_3_DIRECTION_RIGHT                         ;; 0e:74da $36
    sLOOP 6, 2                                         ;; 0e:74db $03 $06 $02
      sNPC_3_STEP_FORWARD                              ;; 0e:74de $30
    sEND                                               ;; 0e:74df $00
    sDELAY 60                                          ;; 0e:74e0 $f0 $3c
    sSET_PLAYER_DIRECTION_DOWN                         ;; 0e:74e2 $85
    sDELAY 30                                          ;; 0e:74e3 $f0 $1e
    sSET_PLAYER_DIRECTION_LEFT                         ;; 0e:74e5 $87
    sDELAY 80                                          ;; 0e:74e6 $f0 $50
    sMSG                                               ;; 0e:74e8 $04
      db "<10>MAIN PROGRAM\n SATORU YOSHIEDA", $00     ;; 0e:74e9
    sDELAY 255                                         ;; 0e:7507 $f0 $ff
    sDELAY 20                                          ;; 0e:7509 $f0 $14
    sMSG                                               ;; 0e:750b $04
      db "<11>", $00                                   ;; 0e:750c
    sDELAY 100                                         ;; 0e:750e $f0 $64
    sMSG                                               ;; 0e:7510 $04
      db "<10>PROGRAM\n  MASAAKI SAITOH", $00          ;; 0e:7511
    sDELAY 255                                         ;; 0e:7529 $f0 $ff
    sDELAY 20                                          ;; 0e:752b $f0 $14
    sMSG                                               ;; 0e:752d $04
      db "<11>", $00                                   ;; 0e:752e
    sDELAY 70                                          ;; 0e:7530 $f0 $46
    sFADE_TO_BLACK                                     ;; 0e:7532 $bd
    sLOAD_ROOM_INSTANT 10, $26, 20, 0                  ;; 0e:7533 $f3 $0a $26 $14 $00
; The letterbox effect covers the back wall which makes this room look weird, so load a new one.
    sSET_ROOM_TILE $16, 0, 1
    sSET_ROOM_TILE $04, 1, 1
    sSET_ROOM_TILE $04, 2, 1
    sSET_ROOM_TILE $04, 3, 1
    sSET_ROOM_TILE $04, 4, 1
    sSET_ROOM_TILE $04, 5, 1
    sSET_ROOM_TILE $04, 6, 1
    sSET_ROOM_TILE $04, 7, 1
    sSET_ROOM_TILE $04, 8, 1
    sSET_ROOM_TILE $05, 9, 1
    sPLAYER_IN_MINECART                                ;; 0e:7538 $a3
    sSET_PLAYER_DIRECTION_RIGHT                        ;; 0e:7539 $86
    sSET_NPC_TYPES 102                                 ;; 0e:753a $fc $66
    sSPAWN_NPC 0                                       ;; 0e:753c $fd $00
    sSET_NPC_1_DIRECTION_LEFT                          ;; 0e:753e $17
    sDELAY 100                                         ;; 0e:753f $f0 $64
    sFADE_TO_NORMAL                                    ;; 0e:7541 $bc
    sLOOP 5, 2                                         ;; 0e:7542 $03 $05 $02
      sNPC_1_STEP_FORWARD                              ;; 0e:7545 $10
    sEND                                               ;; 0e:7546 $00
    sDELAY 30                                          ;; 0e:7547 $f0 $1e
    sSET_PLAYER_POSITION 0, 6                          ;; 0e:7549 $8a $00 $06
    sLOOP 8, 2                                         ;; 0e:754c $03 $08 $02
      sPLAYER_STEP_FORWARD                             ;; 0e:754f $80
    sEND                                               ;; 0e:7550 $00
    sNPC_1_STEP_BACKWARDS                              ;; 0e:7551 $11
    sSET_ROOM_TILE $73, 3, 2                           ;; 0e:7552 $b0 $73 $03 $02
    sSET_ROOM_TILE $4d, 6, 3                           ;; 0e:7556 $b0 $4d $06 $03
    sLOOP 4, 2                                         ;; 0e:755a $03 $04 $02
      sPLAYER_STEP_FORWARD                             ;; 0e:755d $80
    sEND                                               ;; 0e:755e $00
    sSET_PLAYER_DIRECTION_DOWN                         ;; 0e:755f $85
    sLOOP 8, 2                                         ;; 0e:7560 $03 $08 $02
      sPLAYER_STEP_FORWARD                             ;; 0e:7563 $80
    sEND                                               ;; 0e:7564 $00
    sSET_PLAYER_POSITION 20, 0                         ;; 0e:7565 $8a $14 $00
    sSET_NPC_1_DIRECTION_DOWN                          ;; 0e:7568 $15
    sDELAY 100                                         ;; 0e:7569 $f0 $64
    sMSG                                               ;; 0e:756b $04
      db "<10>MUSIC COMPOSER\n    KENJI ITO", $00      ;; 0e:756c
    sDELAY 255                                         ;; 0e:7587 $f0 $ff
    sDELAY 20                                          ;; 0e:7589 $f0 $14
    sMSG                                               ;; 0e:758b $04
      db "<11>", $00                                   ;; 0e:758c
    sDELAY 70                                          ;; 0e:758e $f0 $46
    sFADE_TO_BLACK                                     ;; 0e:7590 $bd
    sLOAD_ROOM_INSTANT 14, $16, 9, 12                  ;; 0e:7591 $f3 $0e $16 $09 $0c
    sSET_NPC_TYPES 87                                  ;; 0e:7596 $fc $57
    sSPAWN_NPC 2                                       ;; 0e:7598 $fd $02
    sSET_NPC_1_POSITION 9, 2                           ;; 0e:759a $19 $09 $02
    sSET_PLAYER_NORMAL_SPRITE                          ;; 0e:759d $a4
    sSET_PLAYER_DIRECTION_UP                           ;; 0e:759e $84
    sDELAY 90                                          ;; 0e:759f $f0 $5a
    sFADE_TO_NORMAL                                    ;; 0e:75a1 $bc
    sDELAY 60                                          ;; 0e:75a2 $f0 $3c
    sLOOP 3, 2                                         ;; 0e:75a4 $03 $03 $02
      sNPC_1_STEP_FORWARD                              ;; 0e:75a7 $10
    sEND                                               ;; 0e:75a8 $00
    sLOOP 5, 2                                         ;; 0e:75a9 $03 $05 $02
      sPLAYER_STEP_FORWARD                             ;; 0e:75ac $80
    sEND                                               ;; 0e:75ad $00
    sDELAY 100                                         ;; 0e:75ae $f0 $64
    sMSG                                               ;; 0e:75b0 $04
      db "<10>GRAPHICS\n  KAZUKO SHIBUYA", $00         ;; 0e:75b1
    sDELAY 255                                         ;; 0e:75ca $f0 $ff
    sDELAY 20                                          ;; 0e:75cc $f0 $14
    sMSG                                               ;; 0e:75ce $04
      db "<11>", $00                                   ;; 0e:75cf
    sDELAY 90                                          ;; 0e:75d1 $f0 $5a
    sMSG                                               ;; 0e:75d3 $04
      db "<10>GRAPHIC ASSIST\n    HIROMI ITO", $00     ;; 0e:75d4
    sDELAY 255                                         ;; 0e:75f0 $f0 $ff
    sDELAY 20                                          ;; 0e:75f2 $f0 $14
    sMSG                                               ;; 0e:75f4 $04
      db "<11>", $00                                   ;; 0e:75f5
    sDELAY 70                                          ;; 0e:75f7 $f0 $46
    sFADE_TO_BLACK                                     ;; 0e:75f9 $bd
    sLOAD_ROOM_INSTANT 14, $04, 20, 0                  ;; 0e:75fa $f3 $0e $04 $14 $00
    sSET_NPC_TYPES 103                                 ;; 0e:75ff $fc $67
    sSPAWN_NPC 1                                       ;; 0e:7601 $fd $01
    sSET_NPC_1_POSITION 12, 5                          ;; 0e:7603 $19 $0c $05
    sDELAY 100                                         ;; 0e:7606 $f0 $64
    sFADE_TO_NORMAL                                    ;; 0e:7608 $bc
    sDELAY 60                                          ;; 0e:7609 $f0 $3c
    sSET_PLAYER_DIRECTION_UP                           ;; 0e:760b $84
    sSET_PLAYER_POSITION 12, 14                        ;; 0e:760c $8a $0c $0e
    sLOOP 7, 2                                         ;; 0e:760f $03 $07 $02
      sPLAYER_STEP_FORWARD                             ;; 0e:7612 $80
    sEND                                               ;; 0e:7613 $00
    sDELAY 90                                          ;; 0e:7614 $f0 $5a
    sMSG                                               ;; 0e:7616 $04
      db "<10>SCENARIO\n YOSHINORI KITASE", $00        ;; 0e:7617
    sDELAY 255                                         ;; 0e:7632 $f0 $ff
    sDELAY 20                                          ;; 0e:7634 $f0 $14
    sMSG                                               ;; 0e:7636 $04
      db "<11>", $00                                   ;; 0e:7637
    sDELAY 100                                         ;; 0e:7639 $f0 $64
    sMSG                                               ;; 0e:763b $04
      db "<10>MAP DESIGN\n   GORO OHASHI", $00         ;; 0e:763c
    sDELAY 255                                         ;; 0e:7655 $f0 $ff
    sDELAY 20                                          ;; 0e:7657 $f0 $14
    sMSG                                               ;; 0e:7659 $04
      db "<11>", $00                                   ;; 0e:765a
    sDELAY 90                                          ;; 0e:765c $f0 $5a
    sSPAWN_NPC 0                                       ;; 0e:765e $fd $00
    sSET_NPC_2_DIRECTION_LEFT                          ;; 0e:7660 $27
    sLOOP 4, 2                                         ;; 0e:7661 $03 $04 $02
      sNPC_2_STEP_FORWARD                              ;; 0e:7664 $20
    sEND                                               ;; 0e:7665 $00
    sSET_NPC_2_DIRECTION_DOWN                          ;; 0e:7666 $25
    sNPC_2_STEP_FORWARD                                ;; 0e:7667 $20
    sDELAY 90                                          ;; 0e:7668 $f0 $5a
    sMSG                                               ;; 0e:766a $04
      db "<10>DIRECTOR\n   KOICHI ISHII", $00          ;; 0e:766b
    sDELAY 255                                         ;; 0e:7683 $f0 $ff
    sDELAY 20                                          ;; 0e:7685 $f0 $14
    sMSG                                               ;; 0e:7687 $04
      db "<11>", $00                                   ;; 0e:7688
    sDELAY 70                                          ;; 0e:768a $f0 $46
    sFADE_TO_BLACK                                     ;; 0e:768c $bd
    sLOAD_ROOM_INSTANT 1, $65, 4, 6                    ;; 0e:768d $f3 $01 $65 $04 $06
    sSET_PLAYER_DIRECTION_RIGHT                        ;; 0e:7692 $86
    sSET_NPC_TYPES 104                                 ;; 0e:7693 $fc $68
    sSPAWN_NPC 0                                       ;; 0e:7695 $fd $00
    sSPAWN_NPC 1                                       ;; 0e:7697 $fd $01
    sSET_NPC_1_POSITION 6, 6                           ;; 0e:7699 $19 $06 $06
    sSET_NPC_2_POSITION 16, 6                          ;; 0e:769c $29 $10 $06
    sSET_NPC_1_DIRECTION_RIGHT                         ;; 0e:769f $16
    sSET_NPC_2_DIRECTION_RIGHT                         ;; 0e:76a0 $26
    sDELAY 90                                          ;; 0e:76a1 $f0 $5a
    sFADE_TO_NORMAL                                    ;; 0e:76a3 $bc
    sDELAY 90                                          ;; 0e:76a4 $f0 $5a
    sLOOP 4, 2                                         ;; 0e:76a6 $03 $04 $02
      sNPC_1_STEP_FORWARD                              ;; 0e:76a9 $10
    sEND                                               ;; 0e:76aa $00
    sSET_NPC_2_DIRECTION_LEFT                          ;; 0e:76ab $27
    sDELAY 140                                         ;; 0e:76ac $f0 $8c
    sSET_NPC_1_DIRECTION_LEFT                          ;; 0e:76ae $17
    sDELAY 80                                          ;; 0e:76af $f0 $50
    sLOOP 4, 2                                         ;; 0e:76b1 $03 $04 $02
      sPLAYER_STEP_FORWARD                             ;; 0e:76b4 $80
    sEND                                               ;; 0e:76b5 $00
    sDELAY 90                                          ;; 0e:76b6 $f0 $5a
    sSET_NPC_1_DIRECTION_RIGHT                         ;; 0e:76b8 $16
    sLOOP 4, 2                                         ;; 0e:76b9 $03 $04 $02
      sNPC_1_STEP_FORWARD                              ;; 0e:76bc $10
    sEND                                               ;; 0e:76bd $00
    sDELAY 100                                         ;; 0e:76be $f0 $64
    sSET_NPC_2_DIRECTION_DOWN                          ;; 0e:76c0 $25
    sNPC_2_STEP_FORWARD                                ;; 0e:76c1 $20
    sNPC_2_STEP_FORWARD                                ;; 0e:76c2 $20
    sSET_NPC_1_DIRECTION_DOWN                          ;; 0e:76c3 $15
    sSET_NPC_2_DIRECTION_LEFT                          ;; 0e:76c4 $27
    sNPC_2_STEP_FORWARD                                ;; 0e:76c5 $20
    sNPC_2_STEP_FORWARD                                ;; 0e:76c6 $20
    sSET_NPC_1_DIRECTION_LEFT                          ;; 0e:76c7 $17
    sDELAY 100                                         ;; 0e:76c8 $f0 $64
    sMSG                                               ;; 0e:76ca $04
      db "<10>\n      SQUARE", $00                     ;; 0e:76cb
    sDELAY 30                                          ;; 0e:76d7 $f0 $1e
    sDELAY 255                                         ;; 0e:76d9 $f0 $ff
    sMSG                                               ;; 0e:76db $04
      db "<11>", $00                                   ;; 0e:76dc
    sDELAY 70                                          ;; 0e:76de $f0 $46
    sPLAYER_STEP_BACKWARD                              ;; 0e:76e0 $81
    sPLAYER_STEP_BACKWARD                              ;; 0e:76e1 $81
    sDELAY 90                                          ;; 0e:76e2 $f0 $5a
    sSET_PLAYER_DIRECTION_LEFT                         ;; 0e:76e4 $87
    sDELAY 10                                          ;; 0e:76e5 $f0 $0a
    sLOOP 4, 2                                         ;; 0e:76e7 $03 $04 $02
      sPLAYER_STEP_FORWARD                             ;; 0e:76ea $80
    sEND                                               ;; 0e:76eb $00
    sFADE_TO_BLACK                                     ;; 0e:76ec $bd
    sLOAD_ROOM_INSTANT 7, $01, 20, 0                   ;; 0e:76ed $f3 $07 $01 $14 $00
    sDELAY 130                                         ;; 0e:76f2 $f0 $82
    sFADE_TO_NORMAL                                    ;; 0e:76f4 $bc
    sDELAY 110                                         ;; 0e:76f5 $f0 $6e
    sSET_ROOM_TILE $24, 7, 5                           ;; 0e:76f7 $b0 $24 $07 $05
    sDELAY 6                                           ;; 0e:76fb $f0 $06
    sSET_ROOM_TILE $25, 7, 5                           ;; 0e:76fd $b0 $25 $07 $05
    sDELAY 6                                           ;; 0e:7701 $f0 $06
    sSET_ROOM_TILE $26, 7, 5                           ;; 0e:7703 $b0 $26 $07 $05
    sDELAY 6                                           ;; 0e:7707 $f0 $06
    sSET_ROOM_TILE $27, 7, 5                           ;; 0e:7709 $b0 $27 $07 $05
    sDELAY 6                                           ;; 0e:770d $f0 $06
    sSET_ROOM_TILE $1e, 7, 5                           ;; 0e:770f $b0 $1e $07 $05
    sEND                                               ;; 0e:7713 $00

script_0542:
    sSET_MUSIC 10                                      ;; 0e:7714 $f8 $0a
    sDELAY 60                                          ;; 0e:7716 $f0 $3c
    sPLAYER_STEP_FORWARD                               ;; 0e:7718 $80
    sPLAYER_STEP_FORWARD                               ;; 0e:7719 $80
    sPLAYER_STEP_FORWARD                               ;; 0e:771a $80
    sSET_PLAYER_DIRECTION_UP                           ;; 0e:771b $84
    sLOOP 8, 2                                         ;; 0e:771c $03 $08 $02
      sPLAYER_STEP_FORWARD                             ;; 0e:771f $80
    sEND                                               ;; 0e:7720 $00
    sSET_PLAYER_DIRECTION_LEFT                         ;; 0e:7721 $87
    sPLAYER_STEP_FORWARD                               ;; 0e:7722 $80
    sPLAYER_STEP_FORWARD                               ;; 0e:7723 $80
    sPLAYER_STEP_FORWARD                               ;; 0e:7724 $80
    sSET_PLAYER_POSITION 20, 0                         ;; 0e:7725 $8a $14 $00
    sDELAY 90                                          ;; 0e:7728 $f0 $5a
; Fill tiles just outside the screen before the shake effect.
; Because you must scroll in only one side needs to be done.
        sSET_ROOM_TILE $41, 15, 0
        sSET_ROOM_TILE $51, 15, 1
        sSET_ROOM_TILE $37, 15, 2
        sSET_ROOM_TILE $07, 15, 3
        sSET_ROOM_TILE $17, 15, 4
        sSET_ROOM_TILE $17, 15, 5
        sSET_ROOM_TILE $27, 15, 6
        sSET_ROOM_TILE $37, 15, 7
    sSFX 37                                            ;; 0e:772a $f9 $25
    sSHAKE_SCREEN                                      ;; 0e:772c $fb
    sDELAY 20                                          ;; 0e:772d $f0 $14
    sSFX 9                                             ;; 0e:772f $f9 $09
    sLOOP 10, 8                                        ;; 0e:7731 $03 $0a $08
      sSET_NEXT_ROOM $06, $04                          ;; 0e:7734 $ef $06 $04
      sSCROLL_ROOM_UP                                  ;; 0e:7737 $e9
      sSET_PLAYER_POSITION 20, 0                       ;; 0e:7738 $8a $14 $00
    sEND                                               ;; 0e:773b $00
    sSCROLL_ROOM_UP                                    ;; 0e:773c $e9
    sSET_PLAYER_POSITION 20, 0                         ;; 0e:773d $8a $14 $00
    sSET_PLAYER_DIRECTION_LEFT                         ;; 0e:7740 $87
    sSET_PLAYER_POSITION 6, 8                          ;; 0e:7741 $8a $06 $08
    sSFX 12                                            ;; 0e:7744 $f9 $0c
    sPLAYER_JUMP 104                                   ;; 0e:7746 $8b $68
    sDELAY 60                                          ;; 0e:7748 $f0 $3c
    sSET_MUSIC 22                                      ;; 0e:774a $f8 $16
    sCLEAR_ROOM_HISTORY                                ;; 0e:774c $ab
    sEND                                               ;; 0e:774d $00

script_0543:
    sFLASH_SCREEN                                      ;; 0e:774e $bf
    sSET_ROOM_TILE $5c, 3, 3                           ;; 0e:774f $b0 $5c $03 $03
    sSFX 20                                            ;; 0e:7753 $f9 $14
    sSET_ROOM_TILE $5c, 4, 3                           ;; 0e:7755 $b0 $5c $04 $03
    sSFX 20                                            ;; 0e:7759 $f9 $14
    sSET_ROOM_TILE $5c, 5, 3                           ;; 0e:775b $b0 $5c $05 $03
    sSFX 20                                            ;; 0e:775f $f9 $14
    sSET_ROOM_TILE $5c, 6, 3                           ;; 0e:7761 $b0 $5c $06 $03
    sDELAY 30                                          ;; 0e:7765 $f0 $1e
    sFLASH_SCREEN                                      ;; 0e:7767 $bf
    sSET_ROOM_TILE $5c, 3, 2                           ;; 0e:7768 $b0 $5c $03 $02
    sSFX 20                                            ;; 0e:776c $f9 $14
    sSET_ROOM_TILE $5c, 4, 2                           ;; 0e:776e $b0 $5c $04 $02
    sSFX 20                                            ;; 0e:7772 $f9 $14
    sSET_ROOM_TILE $5c, 5, 2                           ;; 0e:7774 $b0 $5c $05 $02
    sSFX 20                                            ;; 0e:7778 $f9 $14
    sSET_ROOM_TILE $5c, 6, 2                           ;; 0e:777a $b0 $5c $06 $02
    sDELAY 30                                          ;; 0e:777e $f0 $1e
    sFLASH_SCREEN                                      ;; 0e:7780 $bf
    sSET_ROOM_TILE $5c, 3, 1                           ;; 0e:7781 $b0 $5c $03 $01
    sSFX 20                                            ;; 0e:7785 $f9 $14
    sSET_ROOM_TILE $5c, 4, 1                           ;; 0e:7787 $b0 $5c $04 $01
    sSFX 20                                            ;; 0e:778b $f9 $14
    sSET_ROOM_TILE $5c, 5, 1                           ;; 0e:778d $b0 $5c $05 $01
    sSFX 20                                            ;; 0e:7791 $f9 $14
    sSET_ROOM_TILE $5c, 6, 1                           ;; 0e:7793 $b0 $5c $06 $01
    sDELAY 30                                          ;; 0e:7797 $f0 $1e
    sFLASH_SCREEN                                      ;; 0e:7799 $bf
    sSET_ROOM_TILE $5c, 3, 0                           ;; 0e:779a $b0 $5c $03 $00
    sSFX 20                                            ;; 0e:779e $f9 $14
    sSET_ROOM_TILE $5c, 4, 0                           ;; 0e:77a0 $b0 $5c $04 $00
    sSFX 20                                            ;; 0e:77a4 $f9 $14
    sSET_ROOM_TILE $5c, 5, 0                           ;; 0e:77a6 $b0 $5c $05 $00
    sSFX 20                                            ;; 0e:77aa $f9 $14
    sSET_ROOM_TILE $5c, 6, 0                           ;; 0e:77ac $b0 $5c $06 $00
    sEND                                               ;; 0e:77b0 $00

script_0544:
    sSET_ROOM_TILE $6c, 3, 0                           ;; 0e:77b1 $b0 $6c $03 $00
    sSET_ROOM_TILE $72, 4, 0                           ;; 0e:77b5 $b0 $72 $04 $00
    sSET_ROOM_TILE $6c, 5, 0                           ;; 0e:77b9 $b0 $6c $05 $00
    sSET_ROOM_TILE $72, 6, 0                           ;; 0e:77bd $b0 $72 $06 $00
;    sSET_ROOM_TILE $6c, 7, 0                           ;; 0e:77c1 $b0 $6c $07 $00
    sSET_ROOM_TILE $09, 3, 1                           ;; 0e:77c5 $b0 $09 $03 $01
    sSET_ROOM_TILE $55, 4, 1                           ;; 0e:77c9 $b0 $55 $04 $01
    sSET_ROOM_TILE $55, 5, 1                           ;; 0e:77cd $b0 $55 $05 $01
    sSET_ROOM_TILE $55, 6, 1                           ;; 0e:77d1 $b0 $55 $06 $01
    sSET_ROOM_TILE $0a, 7, 1                           ;; 0e:77d5 $b0 $0a $07 $01
    sSET_ROOM_TILE $09, 3, 2                           ;; 0e:77d9 $b0 $09 $03 $02
    sSET_ROOM_TILE $55, 4, 2                           ;; 0e:77dd $b0 $55 $04 $02
    sSET_ROOM_TILE $55, 5, 2                           ;; 0e:77e1 $b0 $55 $05 $02
    sSET_ROOM_TILE $55, 6, 2                           ;; 0e:77e5 $b0 $55 $06 $02
    sSET_ROOM_TILE $0a, 7, 2                           ;; 0e:77e9 $b0 $0a $07 $02
    sDELAY 15                                          ;; 0e:77ed $f0 $0f
    sFLASH_SCREEN                                      ;; 0e:77ef $bf
    sSFX 37                                            ;; 0e:77f0 $f9 $25
    sSET_ROOM_TILE $09, 3, 0                           ;; 0e:77f2 $b0 $09 $03 $00
    sSET_ROOM_TILE $55, 4, 0                           ;; 0e:77f6 $b0 $55 $04 $00
    sSET_ROOM_TILE $55, 5, 0                           ;; 0e:77fa $b0 $55 $05 $00
    sSET_ROOM_TILE $55, 6, 0                           ;; 0e:77fe $b0 $55 $06 $00
    sSET_ROOM_TILE $0a, 7, 0                           ;; 0e:7802 $b0 $0a $07 $00
    sSET_ROOM_TILE $09, 3, 1                           ;; 0e:7806 $b0 $09 $03 $01
    sSET_ROOM_TILE $55, 4, 1                           ;; 0e:780a $b0 $55 $04 $01
    sSET_ROOM_TILE $55, 5, 1                           ;; 0e:780e $b0 $55 $05 $01
    sSET_ROOM_TILE $55, 6, 1                           ;; 0e:7812 $b0 $55 $06 $01
    sSET_ROOM_TILE $0a, 7, 1                           ;; 0e:7816 $b0 $0a $07 $01
    sSET_ROOM_TILE $09, 3, 2                           ;; 0e:781a $b0 $09 $03 $02
    sSET_ROOM_TILE $55, 4, 2                           ;; 0e:781e $b0 $55 $04 $02
    sSET_ROOM_TILE $55, 5, 2                           ;; 0e:7822 $b0 $55 $05 $02
    sSET_ROOM_TILE $55, 6, 2                           ;; 0e:7826 $b0 $55 $06 $02
    sSET_ROOM_TILE $0a, 7, 2                           ;; 0e:782a $b0 $0a $07 $02
    sDELAY 15                                          ;; 0e:782e $f0 $0f
    sFLASH_SCREEN                                      ;; 0e:7830 $bf
    sSFX 37                                            ;; 0e:7831 $f9 $25
    sCALL script_0545                                  ;; 0e:7833 $02 $78 $3f
    sCALL script_0547                                  ;; 0e:7836 $02 $79 $86
    sDELAY 15                                          ;; 0e:7839 $f0 $0f
    sFLASH_SCREEN                                      ;; 0e:783b $bf
    sSFX 37                                            ;; 0e:783c $f9 $25
    sEND                                               ;; 0e:783e $00

; Start of the third script bank.
SECTION "script bank 3", ROMX[$4000], BANK[SCRIPT_BANK_1 + 2]

script_0545:
    sLOOP 4, 189
      sSET_ROOM_TILE $09, 3, 0                         ;; 0e:7842 $b0 $09 $03 $00
      sSET_ROOM_TILE $55, 4, 0                         ;; 0e:7846 $b0 $55 $04 $00
      sSET_ROOM_TILE $55, 5, 0                         ;; 0e:784a $b0 $55 $05 $00
      sSET_ROOM_TILE $55, 6, 0                         ;; 0e:784e $b0 $55 $06 $00
      sSET_ROOM_TILE $0a, 7, 0                         ;; 0e:7852 $b0 $0a $07 $00
      sSET_ROOM_TILE $09, 3, 1                         ;; 0e:7856 $b0 $09 $03 $01
      sSET_ROOM_TILE $55, 4, 1                         ;; 0e:785a $b0 $55 $04 $01
      sSET_ROOM_TILE $55, 5, 1                         ;; 0e:785e $b0 $55 $05 $01
      sSET_ROOM_TILE $55, 6, 1                         ;; 0e:7862 $b0 $55 $06 $01
      sSET_ROOM_TILE $0a, 7, 1                         ;; 0e:7866 $b0 $0a $07 $01
      sSET_ROOM_TILE $09, 3, 2                         ;; 0e:786a $b0 $09 $03 $02
      sSET_ROOM_TILE $55, 4, 2                         ;; 0e:786e $b0 $55 $04 $02
      sSET_ROOM_TILE $55, 5, 2                         ;; 0e:7872 $b0 $55 $05 $02
      sSET_ROOM_TILE $55, 6, 2                         ;; 0e:7876 $b0 $55 $06 $02
      sSET_ROOM_TILE $0a, 7, 2                         ;; 0e:787a $b0 $0a $07 $02
      sDELAY 15                                        ;; 0e:787e $f0 $0f
      sSFX 37                                          ;; 0e:7880 $f9 $25
      sSET_ROOM_TILE $09, 3, 0                         ;; 0e:7882 $b0 $09 $03 $00
      sSET_ROOM_TILE $55, 4, 0                         ;; 0e:7886 $b0 $55 $04 $00
      sSET_ROOM_TILE $55, 5, 0                         ;; 0e:788a $b0 $55 $05 $00
      sSET_ROOM_TILE $55, 6, 0                         ;; 0e:788e $b0 $55 $06 $00
      sSET_ROOM_TILE $0a, 7, 0                         ;; 0e:7892 $b0 $0a $07 $00
      sSET_ROOM_TILE $09, 3, 1                         ;; 0e:7896 $b0 $09 $03 $01
      sSET_ROOM_TILE $55, 4, 1                         ;; 0e:789a $b0 $55 $04 $01
      sSET_ROOM_TILE $55, 5, 1                         ;; 0e:789e $b0 $55 $05 $01
      sSET_ROOM_TILE $55, 6, 1                         ;; 0e:78a2 $b0 $55 $06 $01
      sSET_ROOM_TILE $0a, 7, 1                         ;; 0e:78a6 $b0 $0a $07 $01
      sSET_ROOM_TILE $09, 3, 2                         ;; 0e:78aa $b0 $09 $03 $02
      sSET_ROOM_TILE $79, 4, 2                         ;; 0e:78ae $b0 $79 $04 $02
      sSET_ROOM_TILE $79, 5, 2                         ;; 0e:78b2 $b0 $79 $05 $02
      sSET_ROOM_TILE $79, 6, 2                         ;; 0e:78b6 $b0 $79 $06 $02
      sSET_ROOM_TILE $0a, 7, 2                         ;; 0e:78ba $b0 $0a $07 $02
      sDELAY 15                                        ;; 0e:78be $f0 $0f
      sSFX 37                                          ;; 0e:78c0 $f9 $25
      sSET_ROOM_TILE $09, 3, 0                         ;; 0e:78c2 $b0 $09 $03 $00
      sSET_ROOM_TILE $55, 4, 0                         ;; 0e:78c6 $b0 $55 $04 $00
      sSET_ROOM_TILE $55, 5, 0                         ;; 0e:78ca $b0 $55 $05 $00
      sSET_ROOM_TILE $55, 6, 0                         ;; 0e:78ce $b0 $55 $06 $00
      sSET_ROOM_TILE $0a, 7, 0                         ;; 0e:78d2 $b0 $0a $07 $00
      sSET_ROOM_TILE $09, 3, 1                         ;; 0e:78d6 $b0 $09 $03 $01
      sSET_ROOM_TILE $79, 4, 1                         ;; 0e:78da $b0 $79 $04 $01
      sSET_ROOM_TILE $79, 5, 1                         ;; 0e:78de $b0 $79 $05 $01
      sSET_ROOM_TILE $79, 6, 1                         ;; 0e:78e2 $b0 $79 $06 $01
;      sSET_ROOM_TILE $0a, 7, 1                         ;; 0e:78e6 $b0 $0a $07 $01
;      sSET_ROOM_TILE $09, 3, 2                         ;; 0e:78ea $b0 $09 $03 $02
      sSET_ROOM_TILE $55, 4, 2                         ;; 0e:78ee $b0 $55 $04 $02
      sSET_ROOM_TILE $55, 5, 2                         ;; 0e:78f2 $b0 $55 $05 $02
      sSET_ROOM_TILE $55, 6, 2                         ;; 0e:78f6 $b0 $55 $06 $02
      sSET_ROOM_TILE $0a, 7, 2                         ;; 0e:78fa $b0 $0a $07 $02
      sDELAY 15                                        ;; 0e:78fe $f0 $0f
      sFLASH_SCREEN                                    ;; 0e:7900 $bf
      sSFX 37                                          ;; 0e:7901 $f9 $25
      sCALL script_0546                                ;; 0e:7903 $02 $79 $08
    sEND                                               ;; 0e:7906 $00
    sEND                                               ;; 0e:7907 $00

script_0546:
    sSET_ROOM_TILE $09, 3, 0                           ;; 0e:7908 $b0 $09 $03 $00
    sSET_ROOM_TILE $79, 4, 0                           ;; 0e:790c $b0 $79 $04 $00
    sSET_ROOM_TILE $79, 5, 0                           ;; 0e:7910 $b0 $79 $05 $00
    sSET_ROOM_TILE $79, 6, 0                           ;; 0e:7914 $b0 $79 $06 $00
;    sSET_ROOM_TILE $0a, 7, 0                           ;; 0e:7918 $b0 $0a $07 $00
;    sSET_ROOM_TILE $09, 3, 1                           ;; 0e:791c $b0 $09 $03 $01
    sSET_ROOM_TILE $55, 4, 1                           ;; 0e:7920 $b0 $55 $04 $01
    sSET_ROOM_TILE $55, 5, 1                           ;; 0e:7924 $b0 $55 $05 $01
    sSET_ROOM_TILE $55, 6, 1                           ;; 0e:7928 $b0 $55 $06 $01
    sSET_ROOM_TILE $0a, 7, 1                           ;; 0e:792c $b0 $0a $07 $01
    sSET_ROOM_TILE $09, 3, 2                           ;; 0e:7930 $b0 $09 $03 $02
    sSET_ROOM_TILE $55, 4, 2                           ;; 0e:7934 $b0 $55 $04 $02
    sSET_ROOM_TILE $55, 5, 2                           ;; 0e:7938 $b0 $55 $05 $02
    sSET_ROOM_TILE $55, 6, 2                           ;; 0e:793c $b0 $55 $06 $02
    sSET_ROOM_TILE $0a, 7, 2                           ;; 0e:7940 $b0 $0a $07 $02
    sDELAY 15                                          ;; 0e:7944 $f0 $0f
    sFLASH_SCREEN                                      ;; 0e:7946 $bf
    sSET_ROOM_TILE $09, 3, 0                           ;; 0e:7947 $b0 $09 $03 $00
    sSET_ROOM_TILE $55, 4, 0                           ;; 0e:794b $b0 $55 $04 $00
    sSET_ROOM_TILE $55, 5, 0                           ;; 0e:794f $b0 $55 $05 $00
    sSET_ROOM_TILE $55, 6, 0                           ;; 0e:7953 $b0 $55 $06 $00
    sSET_ROOM_TILE $0a, 7, 0                           ;; 0e:7957 $b0 $0a $07 $00
    sSET_ROOM_TILE $09, 3, 1                           ;; 0e:795b $b0 $09 $03 $01
    sSET_ROOM_TILE $55, 4, 1                           ;; 0e:795f $b0 $55 $04 $01
    sSET_ROOM_TILE $55, 5, 1                           ;; 0e:7963 $b0 $55 $05 $01
    sSET_ROOM_TILE $55, 6, 1                           ;; 0e:7967 $b0 $55 $06 $01
    sSET_ROOM_TILE $0a, 7, 1                           ;; 0e:796b $b0 $0a $07 $01
    sSET_ROOM_TILE $09, 3, 2                           ;; 0e:796f $b0 $09 $03 $02
    sSET_ROOM_TILE $55, 4, 2                           ;; 0e:7973 $b0 $55 $04 $02
    sSET_ROOM_TILE $55, 5, 2                           ;; 0e:7977 $b0 $55 $05 $02
    sSET_ROOM_TILE $55, 6, 2                           ;; 0e:797b $b0 $55 $06 $02
    sSET_ROOM_TILE $0a, 7, 2                           ;; 0e:797f $b0 $0a $07 $02
    sSFX 37                                            ;; 0e:7983 $f9 $25
    sEND                                               ;; 0e:7985 $00

script_0547:
    sSET_ROOM_TILE $09, 3, 0                           ;; 0e:7986 $b0 $09 $03 $00
    sSET_ROOM_TILE $55, 4, 0                           ;; 0e:798a $b0 $55 $04 $00
    sSET_ROOM_TILE $55, 5, 0                           ;; 0e:798e $b0 $55 $05 $00
    sSET_ROOM_TILE $55, 6, 0                           ;; 0e:7992 $b0 $55 $06 $00
    sSET_ROOM_TILE $0a, 7, 0                           ;; 0e:7996 $b0 $0a $07 $00
    sSET_ROOM_TILE $09, 3, 1                           ;; 0e:799a $b0 $09 $03 $01
    sSET_ROOM_TILE $55, 4, 1                           ;; 0e:799e $b0 $55 $04 $01
    sSET_ROOM_TILE $55, 5, 1                           ;; 0e:79a2 $b0 $55 $05 $01
    sSET_ROOM_TILE $55, 6, 1                           ;; 0e:79a6 $b0 $55 $06 $01
    sSET_ROOM_TILE $0a, 7, 1                           ;; 0e:79aa $b0 $0a $07 $01
    sSET_ROOM_TILE $19, 3, 2                           ;; 0e:79ae $b0 $19 $03 $02
    sSET_ROOM_TILE $54, 4, 2                           ;; 0e:79b2 $b0 $54 $04 $02
    sSET_ROOM_TILE $2e, 5, 2                           ;; 0e:79b6 $b0 $2e $05 $02
    sSET_ROOM_TILE $54, 6, 2                           ;; 0e:79ba $b0 $54 $06 $02
    sSET_ROOM_TILE $1a, 7, 2                           ;; 0e:79be $b0 $1a $07 $02
    sEND                                               ;; 0e:79c2 $00

script_0548:
    sFOLLOWER_DIRECTION_LEFT                           ;; 0e:79c3 $97
    sSET_MUSIC 0                                       ;; 0e:79c4 $f8 $00
    sFOLLOWER_SET_POSITION 4, 3                        ;; 0e:79c6 $99 $04 $03

; Replace the player with an NPC that looks the same without the shield
    sSET_NPC_TYPES 37
    sSPAWN_NPC 1
    sSET_NPC_1_DIRECTION_RIGHT
    sSET_NPC_1_POSITION 8, 3
    sSET_PLAYER_POSITION 20, 0

    sFADE_TO_NORMAL                                    ;; 0e:79c9 $bc
    sDELAY 60                                          ;; 0e:79ca $f0 $3c
    sFOLLOWER_DIRECTION_RIGHT                          ;; 0e:79cc $96
    sMSG                                               ;; 0e:79cd $04
      db "<10><GIRL>:Hey_ ", $00
    sDELAY 60                                          ;; 0e:79d4 $f0 $3c
    sMSG                                               ;; 0e:79d6 $04
      db "<BOY>_?\n", $00                              ;; 0e:79d7
    sSET_NPC_1_DIRECTION_LEFT
    sMSG                                               ;; 0e:79dd $04
      db "<BOY>:What?<12>"
      db "<1b><GIRL>:I think you\n will need my\n Cure magic.<12>"
      db "<1b><GIRL>:Want it?\n<BOY>:I do!", $00
    sDELAY 20
    sMSG
      db " _ How?\n<GIRL>:Read this.<12>"
      db "<1b>", $00 ;; 0e:79de
    sGIVE_MAGIC INV_MAGIC_CURE                         ;; 0e:7a29 $d6 $00
    sSFX 15                                            ;; 0e:7a2b $f9 $0f
    sMSG                                               ;; 0e:7a2d $04
      db "Received the Book\nof Wisp!\nLearned Cure.<12>"
      db "<1b><GIRL>:Good night_", $00 ;; 0e:7a2e
    sDELAY 60                                          ;; 0e:7a59 $f0 $3c
    sFOLLOWER_DIRECTION_LEFT                           ;; 0e:7a5b $97
    sMSG                                               ;; 0e:7a5c $04
      db "\n<BOY>:That's all?\n G_ Good night_<12>"
      db "<11>", $00 ;; 0e:7a5d
    sFADE_TO_BLACK                                     ;; 0e:7a6b $bd
    sFOLLOWER_DELETE                                   ;; 0e:7a6c $98
    sLOAD_ROOM_INSTANT 15, $55, 20, 0                  ;; 0e:7a6d $f3 $0f $55 $14 $00
    sFADE_TO_NORMAL                                    ;; 0e:7a72 $bc
    sDELAY 80                                          ;; 0e:7a73 $f0 $50
    sMSG                                               ;; 0e:7a75 $04
      db "<10>\n Ah! Fresh blood!", $00
    sDELAY 90                                          ;; 0e:7a88 $f0 $5a
    sMSG                                               ;; 0e:7a8a $04
      db "<11>", $00                                   ;; 0e:7a8b
    sDELAY 40                                          ;; 0e:7a8d $f0 $28
    sFADE_TO_BLACK                                     ;; 0e:7a8f $bd
    sLOAD_ROOM_INSTANT 3, $30, 20, 0
    sSPAWN_NPC 1
    sSET_NPC_1_DIRECTION_LEFT
    sSET_NPC_1_POSITION 8, 3
    sFADE_TO_NORMAL                                    ;; 0e:7a95 $bc
    sDELAY 20                                          ;; 0e:7a96 $f0 $14
    sSET_PLAYER_DIRECTION_DOWN                         ;; 0e:7a9a $85
    sNPC_1_STEP_FORWARD
    sNPC_1_STEP_FORWARD
    sSET_NPC_1_DIRECTION_DOWN
    sDELAY 20
    sSET_PLAYER_POSITION 6, 3
    sDEL_NPC_1
    sMSG                                               ;; 0e:7a9b $04
      db "<10><BOY>:_ _ Good m_\n       ?!\n<GIRL> is missing!<12>"
      db "<11>", $00 ;; 0e:7a9c
    sCLEAR_FLAG wScriptFlags0A.1                       ;; 0e:7abb $db $51
    sSET_FLAG wScriptFlags01.5                         ;; 0e:7abd $da $0d
    sSET_MUSIC 7                                       ;; 0e:7abf $f8 $07
    sEND                                               ;; 0e:7ac1 $00

script_0549:
    sMSG                                               ;; 0e:7ac2 $04
      db "<10> The one and only\n <AXE>Battle for 150\n lucre! Want it?<12>"
      db "<13>", $00 ;; 0e:7ac3
    sIF_FLAG !wScriptFlags0F.7                         ;; 0e:7aeb $08 $ff $00 $38
      sMSG                                             ;; 0e:7aef $04
        db "<11>", $00                                 ;; 0e:7af0
      sTAKE_MONEY 150                                  ;; 0e:7af2 $d1 $96 $00
      sMSG                                             ;; 0e:7af5 $04
        db "<10>", $00                                 ;; 0e:7af6
      sIF_FLAG wScriptFlags.6                          ;; 0e:7af8 $08 $06 $00 $1e
        sMSG                                           ;; 0e:7afc $04
          db " Sorry!\n You don't have\n enough money!", $00 ;; 0e:7afd
      sELSE                                            ;; 0e:7b18 $01 $0a
        sMSG                                           ;; 0e:7b1a $04
          db " Great!", $00                            ;; 0e:7b1b
        sSFX 15                                        ;; 0e:7b20 $f9 $0f
        sGIVE_EQUIPMENT INV_AXE_BATTLE                 ;; 0e:7b22 $d8 $01
      sENDIF                                           ;; 0e:7b24
      sMSG                                             ;; 0e:7b24 $04
        db "<12>"
        db "", $00                   ;; 0e:7b25
    sENDIF                                             ;; 0e:7b27
    sMSG                                               ;; 0e:7b27 $04
      db "<1b> How about\n some items?<12>"
      db "<11>", $00 ;; 0e:7b28
    sEND                                               ;; 0e:7b3b $00
