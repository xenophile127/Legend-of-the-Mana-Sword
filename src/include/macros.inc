MACRO BOSS_HEADER

    db \1, \2, \3, \4, \5, \6
    SCRIPT_IDX \7
ENDM
MACRO BOSS_HEADER_GFX

    db \1, \2
    dw (\3 & $3FFF) | ((BANK(\3) - $08) << 14), \4, \5
ENDM
MACRO FLAG_CONDITION_TO_IDX

assert STRSUB("\1", STRLEN("\1") - 1, 1) == "."
IF STRCMP(STRSUB("\1", 1, 1), "!") == 0
DEF LBL equs STRSUB("\1", 2, STRLEN("\1") - 3)
DEF IDX = STRSUB("\1", STRLEN("\1")) - "0"
  db (LBL - wScriptFlags) * 8 + (IDX) | $80
PURGE LBL
ELSE
DEF LBL equs STRSUB("\1", 1, STRLEN("\1") - 2)
DEF IDX = STRSUB("\1", STRLEN("\1")) - "0"
  db (LBL - wScriptFlags) * 8 + (IDX)
PURGE LBL
ENDC
ENDM
MACRO FLAG_TO_IDX

assert STRSUB("\1", STRLEN("\1") - 1, 1) == "."
DEF LBL equs STRSUB("\1", 1, STRLEN("\1") - 2)
DEF IDX = STRSUB("\1", STRLEN("\1")) - "0"
  db (LBL - wScriptFlags) * 8 + (IDX)
PURGE LBL
ENDM
MACRO ITEM_DATA

        db \1
        TXT \2
        db \3, \4, \5, \6, \7, \8, \9
ENDM
MACRO MAP_HEADER

assert BANK(\1) == $1B || BANK(\1) == $1C
dw (\1) - ($4000 * (BANK(\1) - $1B))
db \2
assert BANK(\3) == BANK(metatiles)
dw \3
db \4
db BANK(\5)
dw \5
db \6
db \7
ENDM
MACRO NPC_DATA

    db \1, \2, \3, \4
    dw (\5 & $3FFF) | ((BANK(\5) - $08) << 14), \6, \7
    db \8, \9
    SHIFT 9
    db \1, \2, \3, \4, \5, \6, \7, \8
    SCRIPT_IDX \9
    SHIFT 9
    IF ISCONST(\1)
      dw \1
    ELSE
      SCRIPT_IDX \1
    ENDC
ENDM
MACRO RLE
; Maps are compressed in ten byte chunks of metatile ids.
; One or more bytes of literal metatile ids may be followed by a repeat value.
; Repeat values must either be followed by a literal or end at a ten byte boundary.
; Repeat values are any byte following a literal which is greater than $f7.
; They repeat the previous literal two to nine times (creating a run from three to ten bytes total).
; The value $f8 repeats the previously output literal two times (for a run of three bytes total).
; The value $ff repeats the previously output literal nine times (for a run of ten bytes total).
  REDEF N = -1
  REPT _NARG
    IF _NARG > 0
      IF (N == \1) && (_NARG > 1)
        IF (\1 != \2)
          REDEF N = \1
          SHIFT 1
          db N
        ELSE
        ; The run length is at least three.
          REDEF RUN_LENGTH = -2
          REDEF RLE_CONTINUE = 1
          REPT _NARG
            IF (RLE_CONTINUE == 1) && (N == \1)
              SHIFT 1
              REDEF RUN_LENGTH = RUN_LENGTH + 1
            ELSE
              REDEF RLE_CONTINUE = 0
            ENDC
          ENDR
          db $f8 + RUN_LENGTH
        ENDC
      ELSE
        REDEF N = \1
        SHIFT 1
        db N
      ENDC
    ENDC
  ENDR
ENDM
MACRO SCRIPT_AT_POS

            db ((\1) << 4) | (\2)
            SCRIPT_IDX \3
ENDM
MACRO SCRIPT_IDX
dw (__script_pointer_\1 - scriptPointersTable) / 2
ENDM
MACRO SCRIPT_POINTER
__script_pointer_\1::
  dw ((\1 - $4000) + ((BANK(\1) - BANK(script_0000)) * $4000))
ENDM
MACRO TXT
SETCHARMAP BASIC
db \#
ENDM
MACRO call_to_bank_target
_call_to_bank_target_\1::
dw \1
ENDM
MACRO data_bbbbbbbbpppp
db \1
shift
db \1
shift
db \1
shift
db \1
shift
db \1
shift
db \1
shift
db \1
shift
db \1
shift
dw \1
shift
dw \1
shift
dw \1
shift
dw \1
shift
ENDM
MACRO data_pbbp
dw \1
shift
db \1
shift
db \1
shift
dw \1
shift
ENDM
MACRO data_ppbbbb
dw \1
shift
dw \1
shift
db \1
shift
db \1
shift
db \1
shift
db \1
shift
ENDM
MACRO data_wbbbbbbbbbbbbbb
dw \1
shift
db \1
shift
db \1
shift
db \1
shift
db \1
shift
db \1
shift
db \1
shift
db \1
shift
db \1
shift
db \1
shift
db \1
shift
db \1
shift
db \1
shift
db \1
shift
db \1
shift
ENDM
MACRO jp_to_bank

            push af
            ld   a, (_call_to_bank_target_\2 - $4000) / 2
            jp callFunctionInBank\1
ENDM
MACRO ld_long_load
db $FA
dw \2
ENDM
MACRO ld_long_store
db $EA
dw \1
ENDM
MACRO mA_0
db $09
ENDM
MACRO mA_1
db $19
ENDM
MACRO mA_10
db $a9
ENDM
MACRO mA_11
db $b9
ENDM
MACRO mA_12
db $c9
ENDM
MACRO mA_2
db $29
ENDM
MACRO mA_3
db $39
ENDM
MACRO mA_4
db $49
ENDM
MACRO mA_5
db $59
ENDM
MACRO mA_6
db $69
ENDM
MACRO mA_7
db $79
ENDM
MACRO mA_8
db $89
ENDM
MACRO mA_9
db $99
ENDM
MACRO mAis_0
db $0a
ENDM
MACRO mAis_1
db $1a
ENDM
MACRO mAis_10
db $aa
ENDM
MACRO mAis_11
db $ba
ENDM
MACRO mAis_12
db $ca
ENDM
MACRO mAis_2
db $2a
ENDM
MACRO mAis_3
db $3a
ENDM
MACRO mAis_4
db $4a
ENDM
MACRO mAis_5
db $5a
ENDM
MACRO mAis_6
db $6a
ENDM
MACRO mAis_7
db $7a
ENDM
MACRO mAis_8
db $8a
ENDM
MACRO mAis_9
db $9a
ENDM
MACRO mB_0
db $0b
ENDM
MACRO mB_1
db $1b
ENDM
MACRO mB_10
db $ab
ENDM
MACRO mB_11
db $bb
ENDM
MACRO mB_12
db $cb
ENDM
MACRO mB_2
db $2b
ENDM
MACRO mB_3
db $3b
ENDM
MACRO mB_4
db $4b
ENDM
MACRO mB_5
db $5b
ENDM
MACRO mB_6
db $6b
ENDM
MACRO mB_7
db $7b
ENDM
MACRO mB_8
db $8b
ENDM
MACRO mB_9
db $9b
ENDM
MACRO mCOUNTER
db $e3
db \1
ENDM
MACRO mCOUNTER_2
db $ea
db \1
ENDM
MACRO mCPlus_0
db $0c
ENDM
MACRO mCPlus_1
db $1c
ENDM
MACRO mCPlus_10
db $ac
ENDM
MACRO mCPlus_11
db $bc
ENDM
MACRO mCPlus_12
db $cc
ENDM
MACRO mCPlus_2
db $2c
ENDM
MACRO mCPlus_3
db $3c
ENDM
MACRO mCPlus_4
db $4c
ENDM
MACRO mCPlus_5
db $5c
ENDM
MACRO mCPlus_6
db $6c
ENDM
MACRO mCPlus_7
db $7c
ENDM
MACRO mCPlus_8
db $8c
ENDM
MACRO mCPlus_9
db $9c
ENDM
MACRO mC_0
db $00
ENDM
MACRO mC_1
db $10
ENDM
MACRO mC_10
db $a0
ENDM
MACRO mC_11
db $b0
ENDM
MACRO mC_12
db $c0
ENDM
MACRO mC_2
db $20
ENDM
MACRO mC_3
db $30
ENDM
MACRO mC_4
db $40
ENDM
MACRO mC_5
db $50
ENDM
MACRO mC_6
db $60
ENDM
MACRO mC_7
db $70
ENDM
MACRO mC_8
db $80
ENDM
MACRO mC_9
db $90
ENDM
MACRO mCisPlus_0
db $0d
ENDM
MACRO mCisPlus_1
db $1d
ENDM
MACRO mCisPlus_10
db $ad
ENDM
MACRO mCisPlus_11
db $bd
ENDM
MACRO mCisPlus_12
db $cd
ENDM
MACRO mCisPlus_2
db $2d
ENDM
MACRO mCisPlus_3
db $3d
ENDM
MACRO mCisPlus_4
db $4d
ENDM
MACRO mCisPlus_5
db $5d
ENDM
MACRO mCisPlus_6
db $6d
ENDM
MACRO mCisPlus_7
db $7d
ENDM
MACRO mCisPlus_8
db $8d
ENDM
MACRO mCisPlus_9
db $9d
ENDM
MACRO mCis_0
db $01
ENDM
MACRO mCis_1
db $11
ENDM
MACRO mCis_10
db $a1
ENDM
MACRO mCis_11
db $b1
ENDM
MACRO mCis_12
db $c1
ENDM
MACRO mCis_2
db $21
ENDM
MACRO mCis_3
db $31
ENDM
MACRO mCis_4
db $41
ENDM
MACRO mCis_5
db $51
ENDM
MACRO mCis_6
db $61
ENDM
MACRO mCis_7
db $71
ENDM
MACRO mCis_8
db $81
ENDM
MACRO mCis_9
db $91
ENDM
MACRO mDUTYCYCLE
db $e5
db \1
ENDM
MACRO mD_0
db $02
ENDM
MACRO mD_1
db $12
ENDM
MACRO mD_10
db $a2
ENDM
MACRO mD_11
db $b2
ENDM
MACRO mD_12
db $c2
ENDM
MACRO mD_2
db $22
ENDM
MACRO mD_3
db $32
ENDM
MACRO mD_4
db $42
ENDM
MACRO mD_5
db $52
ENDM
MACRO mD_6
db $62
ENDM
MACRO mD_7
db $72
ENDM
MACRO mD_8
db $82
ENDM
MACRO mD_9
db $92
ENDM
MACRO mDis_0
db $03
ENDM
MACRO mDis_1
db $13
ENDM
MACRO mDis_10
db $a3
ENDM
MACRO mDis_11
db $b3
ENDM
MACRO mDis_12
db $c3
ENDM
MACRO mDis_2
db $23
ENDM
MACRO mDis_3
db $33
ENDM
MACRO mDis_4
db $43
ENDM
MACRO mDis_5
db $53
ENDM
MACRO mDis_6
db $63
ENDM
MACRO mDis_7
db $73
ENDM
MACRO mDis_8
db $83
ENDM
MACRO mDis_9
db $93
ENDM
MACRO mEND
db $ff
ENDM
MACRO mE_0
db $04
ENDM
MACRO mE_1
db $14
ENDM
MACRO mE_10
db $a4
ENDM
MACRO mE_11
db $b4
ENDM
MACRO mE_12
db $c4
ENDM
MACRO mE_2
db $24
ENDM
MACRO mE_3
db $34
ENDM
MACRO mE_4
db $44
ENDM
MACRO mE_5
db $54
ENDM
MACRO mE_6
db $64
ENDM
MACRO mE_7
db $74
ENDM
MACRO mE_8
db $84
ENDM
MACRO mE_9
db $94
ENDM
MACRO mF_0
db $05
ENDM
MACRO mF_1
db $15
ENDM
MACRO mF_10
db $a5
ENDM
MACRO mF_11
db $b5
ENDM
MACRO mF_12
db $c5
ENDM
MACRO mF_2
db $25
ENDM
MACRO mF_3
db $35
ENDM
MACRO mF_4
db $45
ENDM
MACRO mF_5
db $55
ENDM
MACRO mF_6
db $65
ENDM
MACRO mF_7
db $75
ENDM
MACRO mF_8
db $85
ENDM
MACRO mF_9
db $95
ENDM
MACRO mFis_0
db $06
ENDM
MACRO mFis_1
db $16
ENDM
MACRO mFis_10
db $a6
ENDM
MACRO mFis_11
db $b6
ENDM
MACRO mFis_12
db $c6
ENDM
MACRO mFis_2
db $26
ENDM
MACRO mFis_3
db $36
ENDM
MACRO mFis_4
db $46
ENDM
MACRO mFis_5
db $56
ENDM
MACRO mFis_6
db $66
ENDM
MACRO mFis_7
db $76
ENDM
MACRO mFis_8
db $86
ENDM
MACRO mFis_9
db $96
ENDM
MACRO mG_0
db $07
ENDM
MACRO mG_1
db $17
ENDM
MACRO mG_10
db $a7
ENDM
MACRO mG_11
db $b7
ENDM
MACRO mG_12
db $c7
ENDM
MACRO mG_2
db $27
ENDM
MACRO mG_3
db $37
ENDM
MACRO mG_4
db $47
ENDM
MACRO mG_5
db $57
ENDM
MACRO mG_6
db $67
ENDM
MACRO mG_7
db $77
ENDM
MACRO mG_8
db $87
ENDM
MACRO mG_9
db $97
ENDM
MACRO mGis_0
db $08
ENDM
MACRO mGis_1
db $18
ENDM
MACRO mGis_10
db $a8
ENDM
MACRO mGis_11
db $b8
ENDM
MACRO mGis_12
db $c8
ENDM
MACRO mGis_2
db $28
ENDM
MACRO mGis_3
db $38
ENDM
MACRO mGis_4
db $48
ENDM
MACRO mGis_5
db $58
ENDM
MACRO mGis_6
db $68
ENDM
MACRO mGis_7
db $78
ENDM
MACRO mGis_8
db $88
ENDM
MACRO mGis_9
db $98
ENDM
MACRO mJUMP
db $e1
dw \1
ENDM
MACRO mJUMPIF
db $eb
db \1
dw \2
ENDM
MACRO mOCTAVE_0
db $d0
ENDM
MACRO mOCTAVE_1
db $d1
ENDM
MACRO mOCTAVE_2
db $d2
ENDM
MACRO mOCTAVE_3
db $d3
ENDM
MACRO mOCTAVE_4
db $d4
ENDM
MACRO mOCTAVE_5
db $d5
ENDM
MACRO mOCTAVE_6
db $d6
ENDM
MACRO mOCTAVE_7
db $d7
ENDM
MACRO mOCTAVE_MINUS_1
db $dc
ENDM
MACRO mOCTAVE_MINUS_2
db $dd
ENDM
MACRO mOCTAVE_MINUS_3
db $de
ENDM
MACRO mOCTAVE_MINUS_4
db $df
ENDM
MACRO mOCTAVE_PLUS_1
db $d8
ENDM
MACRO mOCTAVE_PLUS_2
db $d9
ENDM
MACRO mOCTAVE_PLUS_3
db $da
ENDM
MACRO mOCTAVE_PLUS_4
db $db
ENDM
MACRO mREPEAT
db $e2
dw \1
ENDM
MACRO mREPEAT_2
db $e9
dw \1
ENDM
MACRO mRest_0
db $0f
ENDM
MACRO mRest_1
db $1f
ENDM
MACRO mRest_10
db $af
ENDM
MACRO mRest_11
db $bf
ENDM
MACRO mRest_12
db $cf
ENDM
MACRO mRest_2
db $2f
ENDM
MACRO mRest_3
db $3f
ENDM
MACRO mRest_4
db $4f
ENDM
MACRO mRest_5
db $5f
ENDM
MACRO mRest_6
db $6f
ENDM
MACRO mRest_7
db $7f
ENDM
MACRO mRest_8
db $8f
ENDM
MACRO mRest_9
db $9f
ENDM
MACRO mSTEREOPAN
db $e6
db \1
ENDM
MACRO mTEMPO
db $e7
db \1
ENDM
MACRO mUNK_ED
db $ed
db \1
ENDM
MACRO mVIBRATO
db $e4
dw \1
ENDM
MACRO mVOLUME
db $e0
db \1
ENDM
MACRO mVOLUME_ENVELOPE
db $e0
dw \1
ENDM
MACRO mWAVETABLE
db $e8
dw \1
ENDM
MACRO mWait_0
db $0e
ENDM
MACRO mWait_1
db $1e
ENDM
MACRO mWait_10
db $ae
ENDM
MACRO mWait_11
db $be
ENDM
MACRO mWait_12
db $ce
ENDM
MACRO mWait_2
db $2e
ENDM
MACRO mWait_3
db $3e
ENDM
MACRO mWait_4
db $4e
ENDM
MACRO mWait_5
db $5e
ENDM
MACRO mWait_6
db $6e
ENDM
MACRO mWait_7
db $7e
ENDM
MACRO mWait_8
db $8e
ENDM
MACRO mWait_9
db $9e
ENDM
MACRO sCALL
db $02
db ((BANK(\1) - BANK(script_0000)) << 6) | (HIGH(\1) & $3F), LOW(\1)
ENDM
MACRO sCHANGE_INTO_EMPTY_CHEST
db $af
ENDM
MACRO sCHECK_ALLOWED_TO_OPEN_MAP
db $a9
ENDM
MACRO sCLEAR_PLAYER_ATTACK
db $aa
ENDM
MACRO sCLEAR_FAST_MOVEMENT
db $89
ENDM
MACRO sCLEAR_FLAG
db $db
 FLAG_TO_IDX \1
ENDM
MACRO sCLEAR_ROOM_HISTORY
db $ab
ENDM
MACRO sCLOSE_EAST_DOOR
db $e5
ENDM
MACRO sCLOSE_MAP
db $ae
ENDM
MACRO sCLOSE_NORTH_DOOR
db $e1
ENDM
MACRO sCLOSE_SOUTH_DOOR
db $e3
ENDM
MACRO sCLOSE_WEST_DOOR
db $e7
ENDM
MACRO sCREATE_EFFECT
db $ba
db \1, \2, \3
ENDM
MACRO sDELAY
db $f0
db \1
ENDM
MACRO sDEL_NPC_1
db $18
ENDM
MACRO sDEL_NPC_2
db $28
ENDM
MACRO sDEL_NPC_3
db $38
ENDM
MACRO sDEL_NPC_4
db $48
ENDM
MACRO sDEL_NPC_5
db $58
ENDM
MACRO sDEL_NPC_6
db $68
ENDM
MACRO sDEL_NPC_7
db $78
ENDM
MACRO sELSE
db $01

  DEF TMP equs "{IF_LABELS}"
  REDEF IF_LABELS equs STRSUB("{IF_LABELS}", 1, STRRIN("{IF_LABELS}", "X") - 1)
  REDEF IF_LABELS equs STRCAT("{IF_LABELS}", "X", "\@")
  db .{IF_LABELS} - @ - 1
  .{TMP}:
  PURGE TMP
ENDM
MACRO sEND
db $00
ENDM
MACRO sENDIF

  .{IF_LABELS}:
  REDEF IF_LABELS equs STRSUB("{IF_LABELS}", 1, STRRIN("{IF_LABELS}", "X") - 1)
ENDM
MACRO sENTER_PLAYER_AND_GIRL_NAME
db $c6
ENDM
MACRO sFADE_TO_BLACK
db $bd
ENDM
MACRO sFADE_TO_NORMAL
db $bc
ENDM
MACRO sFADE_TO_WHITE
db $be
ENDM
MACRO sFLASH_SCREEN
db $bf
ENDM
MACRO sFOLLOWER_DELETE
db $98
ENDM
MACRO sFOLLOWER_DIRECTION_DOWN
db $95
ENDM
MACRO sFOLLOWER_DIRECTION_LEFT
db $97
ENDM
MACRO sFOLLOWER_DIRECTION_RIGHT
db $96
ENDM
MACRO sFOLLOWER_DIRECTION_UP
db $94
ENDM
MACRO sFOLLOWER_SET_POSITION
db $99
db \1, \2
ENDM
MACRO sFOLLOWER_STEP_BACKWARD
db $91
ENDM
MACRO sFOLLOWER_STEP_FORWARD
db $90
ENDM
MACRO sFULL_HP
db $c0
ENDM
MACRO sFULL_HP_DUMMY_12
db $12
ENDM
MACRO sFULL_HP_DUMMY_13
db $13
ENDM
MACRO sFULL_HP_DUMMY_22
db $22
ENDM
MACRO sFULL_HP_DUMMY_23
db $23
ENDM
MACRO sFULL_HP_DUMMY_32
db $32
ENDM
MACRO sFULL_HP_DUMMY_33
db $33
ENDM
MACRO sFULL_HP_DUMMY_42
db $42
ENDM
MACRO sFULL_HP_DUMMY_43
db $43
ENDM
MACRO sFULL_HP_DUMMY_52
db $52
ENDM
MACRO sFULL_HP_DUMMY_53
db $53
ENDM
MACRO sFULL_HP_DUMMY_62
db $62
ENDM
MACRO sFULL_HP_DUMMY_63
db $63
ENDM
MACRO sFULL_HP_DUMMY_72
db $72
ENDM
MACRO sFULL_HP_DUMMY_73
db $73
ENDM
MACRO sFULL_HP_DUMMY_82
db $82
ENDM
MACRO sFULL_HP_DUMMY_83
db $83
ENDM
MACRO sFULL_HP_DUMMY_8C
db $8c
ENDM
MACRO sFULL_HP_DUMMY_8D
db $8d
ENDM
MACRO sFULL_HP_DUMMY_8E
db $8e
ENDM
MACRO sFULL_HP_DUMMY_92
db $92
ENDM
MACRO sFULL_HP_DUMMY_93
db $93
ENDM
MACRO sFULL_HP_DUMMY_F1
db $f1
ENDM
MACRO sFULL_HP_DUMMY_F2
db $f2
ENDM
MACRO sFULL_HP_DUMMY_F5
db $f5
ENDM
MACRO sFULL_HP_DUMMY_F7
db $f7
ENDM
MACRO sFULL_HP_DUMMY_FA
db $fa
ENDM
MACRO sFULL_MANA
db $c1
ENDM
MACRO sGIVE_EQUIPMENT
db $d8
db \1 - $42
ENDM
MACRO sGIVE_FOLLOWER
db $9c
db \1
ENDM
MACRO sGIVE_ITEM
db $d4
db \1 - $09
ENDM
MACRO sGIVE_MAGIC
db $d6
db \1 - $01
ENDM
MACRO sGIVE_XP
db $d2
dw \1
ENDM
MACRO sHALT_GAME
db $cc
ENDM
MACRO sIF_EQUIPED
db $09

REPT _NARG
    db \1
    SHIFT
ENDR
    db $00
    sIF_JMP
ENDM
MACRO sIF_FLAG
db $08
REPT _NARG
 FLAG_CONDITION_TO_IDX \1
 SHIFT
ENDR
 db $00
 sIF_JMP
ENDM
MACRO sIF_INVENTORY
db $0a

REPT _NARG
    db \1
    SHIFT
ENDR
    db $00
    sIF_JMP
ENDM
MACRO sIF_JMP

  IF !DEF(IF_LABELS)
    DEF IF_LABELS equs ""
  ENDC
  REDEF IF_LABELS equs STRCAT("{IF_LABELS}", "X", "\@")
  db .{IF_LABELS} - @ - 1
ENDM
MACRO sIF_TRIGGERED_OFF_BY
db $0c

REPT _NARG
    db \1
    SHIFT
ENDR
    db $00
    sIF_JMP
ENDM
MACRO sIF_TRIGGERED_ON_BY
db $0b

REPT _NARG
    db \1
    SHIFT
ENDR
    db $00
    sIF_JMP
ENDM
MACRO sLETTER_BOX_EFFECT
db $b6
ENDM
MACRO sLOAD_ROOM
db $f4
db \1, \2, \3, \4
ENDM
MACRO sLOAD_ROOM_INSTANT
db $f3
db \1, \2, \3, \4
ENDM
MACRO sLOCK_TEXT_SPEED
db $dc
ENDM
MACRO sLOOP
db $03
db \1, \2
ENDM
MACRO sMSG
db $04
SETCHARMAP SCRIPT
ENDM
MACRO sLOAD_PALETTE ; Added for colorization.
db $05
db \1
ENDM
MACRO sNOP_06
db $06
ENDM
MACRO sNOP_07
db $07
ENDM
MACRO sNOP_0D
db $0d
ENDM
MACRO sNOP_0E
db $0e
ENDM
MACRO sNOP_0F
db $0f
ENDM
MACRO sNOP_1C
db $1c
ENDM
MACRO sNOP_1D
db $1d
ENDM
MACRO sNOP_1E
db $1e
ENDM
MACRO sNOP_1F
db $1f
ENDM
MACRO sNOP_2C
db $2c
ENDM
MACRO sNOP_2D
db $2d
ENDM
MACRO sNOP_2E
db $2e
ENDM
MACRO sNOP_2F
db $2f
ENDM
MACRO sNOP_3C
db $3c
ENDM
MACRO sNOP_3D
db $3d
ENDM
MACRO sNOP_3E
db $3e
ENDM
MACRO sNOP_3F
db $3f
ENDM
MACRO sNOP_4C
db $4c
ENDM
MACRO sNOP_4D
db $4d
ENDM
MACRO sNOP_4E
db $4e
ENDM
MACRO sNOP_4F
db $4f
ENDM
MACRO sNOP_5C
db $5c
ENDM
MACRO sNOP_5D
db $5d
ENDM
MACRO sNOP_5E
db $5e
ENDM
MACRO sNOP_5F
db $5f
ENDM
MACRO sNOP_6C
db $6c
ENDM
MACRO sNOP_6D
db $6d
ENDM
MACRO sNOP_6E
db $6e
ENDM
MACRO sNOP_6F
db $6f
ENDM
MACRO sNOP_7C
db $7c
ENDM
MACRO sNOP_7D
db $7d
ENDM
MACRO sNOP_7E
db $7e
ENDM
MACRO sNOP_7F
db $7f
ENDM
MACRO sNOP_9E
db $9e
ENDM
MACRO sNOP_9F
db $9f
ENDM
MACRO sNOP_A7
db $a7
ENDM
MACRO sNOP_A8
db $a8
ENDM
MACRO sNOP_B1
db $b1
ENDM
MACRO sNOP_B2
db $b2
ENDM
MACRO sNOP_B3
db $b3
ENDM
MACRO sNOP_B4
db $b4
ENDM
MACRO sNOP_B5
db $b5
ENDM
MACRO sNOP_BB
db $bb
ENDM
MACRO sNOP_CD
db $cd
ENDM
MACRO sNOP_CE
db $ce
ENDM
MACRO sNOP_CF
db $cf
ENDM
MACRO sNOP_DF
db $df
ENDM
MACRO sNPC_1_STEP_BACKWARDS
db $11
ENDM
MACRO sNPC_1_STEP_FORWARD
db $10
ENDM
MACRO sNPC_2_STEP_BACKWARDS
db $21
ENDM
MACRO sNPC_2_STEP_FORWARD
db $20
ENDM
MACRO sNPC_3_STEP_BACKWARDS
db $31
ENDM
MACRO sNPC_3_STEP_FORWARD
db $30
ENDM
MACRO sNPC_4_STEP_BACKWARDS
db $41
ENDM
MACRO sNPC_4_STEP_FORWARD
db $40
ENDM
MACRO sNPC_5_STEP_BACKWARDS
db $51
ENDM
MACRO sNPC_5_STEP_FORWARD
db $50
ENDM
MACRO sNPC_6_STEP_BACKWARDS
db $61
ENDM
MACRO sNPC_6_STEP_FORWARD
db $60
ENDM
MACRO sNPC_7_STEP_BACKWARDS
db $71
ENDM
MACRO sNPC_7_STEP_FORWARD
db $70
ENDM
MACRO sOPEN_EAST_DOOR
db $e4
ENDM
MACRO sOPEN_MAP
db $ac
ENDM
MACRO sOPEN_NORTH_DOOR
db $e0
ENDM
MACRO sOPEN_SHOP
db $f6
db \1
ENDM
MACRO sOPEN_SOUTH_DOOR
db $e2
ENDM
MACRO sOPEN_WEST_DOOR
db $e6
ENDM
MACRO sPLAYER_CURE_STATUS
db $c2
db \1
ENDM
MACRO sPLAYER_GIVE_STATUS
db $c4
db \1
ENDM
MACRO sPLAYER_IN_MINECART
db $a3
ENDM
MACRO sPLAYER_JUMP
db $8b
db \1
ENDM
MACRO sPLAYER_ON_CHOCOBO
db $a0
ENDM
MACRO sPLAYER_ON_CHOCOBOT
db $a1
ENDM
MACRO sPLAYER_ON_CHOCOBOT_WATER
db $a2
ENDM
MACRO sPLAYER_STEP_BACKWARD
db $81
ENDM
MACRO sPLAYER_STEP_FORWARD
db $80
ENDM
MACRO sRESET_GAME
db $c8
ENDM
MACRO sRNG
db $c7
ENDM
MACRO sRUN_ROOM_ALL_KILLED_SCRIPT
db $ee
ENDM
MACRO sRUN_ROOM_SCRIPT
db $ec
ENDM
MACRO sSCROLL_ROOM_DOWN
db $e8
ENDM
MACRO sSCROLL_ROOM_LEFT
db $ea
ENDM
MACRO sSCROLL_ROOM_RIGHT
db $eb
ENDM
MACRO sSCROLL_ROOM_UP
db $e9
ENDM
MACRO sSET_CHEST_OPEN_SCRIPT1
db $c9
 db HIGH((__script_pointer_\1 - scriptPointersTable) / 2), LOW((__script_pointer_\1 - scriptPointersTable) / 2)
ENDM
MACRO sSET_CHEST_OPEN_SCRIPT2
db $ca
 db HIGH((__script_pointer_\1 - scriptPointersTable) / 2), LOW((__script_pointer_\1 - scriptPointersTable) / 2)
ENDM
MACRO sSET_FAST_MOVEMENT
db $88
ENDM
MACRO sSET_FLAG
db $da
 FLAG_TO_IDX \1
ENDM
MACRO sSET_MUSIC
db $f8
db \1
ENDM
MACRO sSET_NEXT_ROOM
db $ef
db \1, \2
ENDM
MACRO sSET_NPC_1_DIRECTION_DOWN
db $15
ENDM
MACRO sSET_NPC_1_DIRECTION_LEFT
db $17
ENDM
MACRO sSET_NPC_1_DIRECTION_RIGHT
db $16
ENDM
MACRO sSET_NPC_1_DIRECTION_UP
db $14
ENDM
MACRO sSET_NPC_1_POSITION
db $19
db \1, \2
ENDM
MACRO sSET_NPC_2_DIRECTION_DOWN
db $25
ENDM
MACRO sSET_NPC_2_DIRECTION_LEFT
db $27
ENDM
MACRO sSET_NPC_2_DIRECTION_RIGHT
db $26
ENDM
MACRO sSET_NPC_2_DIRECTION_UP
db $24
ENDM
MACRO sSET_NPC_2_POSITION
db $29
db \1, \2
ENDM
MACRO sSET_NPC_3_DIRECTION_DOWN
db $35
ENDM
MACRO sSET_NPC_3_DIRECTION_LEFT
db $37
ENDM
MACRO sSET_NPC_3_DIRECTION_RIGHT
db $36
ENDM
MACRO sSET_NPC_3_DIRECTION_UP
db $34
ENDM
MACRO sSET_NPC_3_POSITION
db $39
db \1, \2
ENDM
MACRO sSET_NPC_4_DIRECTION_DOWN
db $45
ENDM
MACRO sSET_NPC_4_DIRECTION_LEFT
db $47
ENDM
MACRO sSET_NPC_4_DIRECTION_RIGHT
db $46
ENDM
MACRO sSET_NPC_4_DIRECTION_UP
db $44
ENDM
MACRO sSET_NPC_4_POSITION
db $49
db \1, \2
ENDM
MACRO sSET_NPC_5_DIRECTION_DOWN
db $55
ENDM
MACRO sSET_NPC_5_DIRECTION_LEFT
db $57
ENDM
MACRO sSET_NPC_5_DIRECTION_RIGHT
db $56
ENDM
MACRO sSET_NPC_5_DIRECTION_UP
db $54
ENDM
MACRO sSET_NPC_5_POSITION
db $59
db \1, \2
ENDM
MACRO sSET_NPC_6_DIRECTION_DOWN
db $65
ENDM
MACRO sSET_NPC_6_DIRECTION_LEFT
db $67
ENDM
MACRO sSET_NPC_6_DIRECTION_RIGHT
db $66
ENDM
MACRO sSET_NPC_6_DIRECTION_UP
db $64
ENDM
MACRO sSET_NPC_6_POSITION
db $69
db \1, \2
ENDM
MACRO sSET_NPC_7_DIRECTION_DOWN
db $75
ENDM
MACRO sSET_NPC_7_DIRECTION_LEFT
db $77
ENDM
MACRO sSET_NPC_7_DIRECTION_RIGHT
db $76
ENDM
MACRO sSET_NPC_7_DIRECTION_UP
db $74
ENDM
MACRO sSET_NPC_7_POSITION
db $79
db \1, \2
ENDM
MACRO sSET_NPC_TYPES
db $fc
db \1
ENDM
MACRO sSET_PLAYER_DIRECTION_DOWN
db $85
ENDM
MACRO sSET_PLAYER_DIRECTION_LEFT
db $87
ENDM
MACRO sSET_PLAYER_DIRECTION_RIGHT
db $86
ENDM
MACRO sSET_PLAYER_DIRECTION_UP
db $84
ENDM
MACRO sSET_PLAYER_HURT_SPRITE
db $a5
ENDM
MACRO sSET_PLAYER_LAYDOWN_SPRITE
db $a6
ENDM
MACRO sSET_PLAYER_NORMAL_SPRITE
db $a4
ENDM
MACRO sSET_PLAYER_POSITION
db $8a
db \1, \2
ENDM
MACRO sSET_ROOM_TILE
db $b0
db \1, \2, \3
ENDM
MACRO sSFX
db $f9
db \1
ENDM
MACRO sSHAKE_SCREEN
db $fb
ENDM
MACRO sSPAWN_BOSS
db $fe
db \1
ENDM
MACRO sSPAWN_NPC
db $fd
db \1
ENDM
MACRO sTAKE_EQUIPED_ITEM
db $de
ENDM
MACRO sTAKE_EQUIPMENT
db $d9
db \1 - $42
ENDM
MACRO sTAKE_ITEM
db $d5
db \1 - $09
ENDM
MACRO sTAKE_MAGIC
db $d7
db \1 - $01
ENDM
MACRO sTAKE_MONEY
db $d1
dw \1
ENDM
MACRO sTAKE_XP
db $d3
dw \1
ENDM
MACRO sUNK_1A
db $1a
ENDM
MACRO sUNK_1B
db $1b
ENDM
MACRO sUNK_2A
db $2a
ENDM
MACRO sUNK_2B
db $2b
ENDM
MACRO sUNK_3A
db $3a
ENDM
MACRO sUNK_3B
db $3b
ENDM
MACRO sUNK_4A
db $4a
ENDM
MACRO sUNK_4B
db $4b
ENDM
MACRO sUNK_5A
db $5a
ENDM
MACRO sUNK_5B
db $5b
ENDM
MACRO sUNK_6A
db $6a
ENDM
MACRO sUNK_6B
db $6b
ENDM
MACRO sUNK_7A
db $7a
ENDM
MACRO sUNK_7B
db $7b
ENDM
MACRO sUNK_9A
db $9a
ENDM
MACRO sUNK_9B
db $9b
ENDM
MACRO sUNK_C5
db $c5
db \1
ENDM
MACRO sUNLOCK_TEXT_SPEED
db $dd
ENDM
MACRO sWAIT_MAP_CLOSE
db $ad
ENDM
MACRO short_halt
db $76
ENDM
MACRO short_stop
db $10
ENDM

MACRO COLOR_PALETTE
color_palette_\1:
.bgp:
    DEF n = 0
    REPT 8
        INCBIN "pal/\1/normal/bgp{u:n}.pal",0,8
        DEF n = n + 1
    ENDR
.obj:
    DEF n = 0
    REPT 8
        INCBIN "pal/\1/normal/obj{u:n}.pal",0,8
        DEF n = n + 1
    ENDR
.bgp_blind:
    DEF n = 0
    REPT 8
        INCBIN "pal/\1/blind/bgp{u:n}.pal",0,8
        DEF n = n + 1
    ENDR
.obj_blind:
    DEF n = 0
    REPT 8
        INCBIN "pal/\1/blind/obj{u:n}.pal",0,8
        DEF n = n + 1
    ENDR
.bgp_damage:
    DEF n = 0
    REPT 8
        INCBIN "pal/\1/damage/bgp{u:n}.pal",0,8
        DEF n = n + 1
    ENDR
.obj_damage:
    DEF n = 0
    REPT 8
        INCBIN "pal/\1/damage/obj{u:n}.pal",0,8
        DEF n = n + 1
    ENDR
.bgp_flash:
    DEF n = 0
    REPT 8
        INCBIN "pal/\1/flash/bgp{u:n}.pal",0,8
        DEF n = n + 1
    ENDR
.obj_flash:
    DEF n = 0
    REPT 8
        INCBIN "pal/\1/flash/obj{u:n}.pal",0,8
        DEF n = n + 1
    ENDR
ENDM

DEF COLOR_PALETTE_BANK1_NUMBER = $00
MACRO COLOR_PALETTE_NPC
color_palette_npc_{02x:COLOR_PALETTE_BANK1_NUMBER}:
        DEF COLOR_PALETTE_BANK1_NUMBER = COLOR_PALETTE_BANK1_NUMBER + 1
.main:
        INCBIN "pal/npc/\1/main.pal",0,8
.blind:
        INCBIN "pal/npc/\1/blind.pal",0,8
.damage:
        INCBIN "pal/npc/\1/damage.pal",0,8
.flash:
        INCBIN "pal/npc/\1/flash.pal",0,8
ENDM

MACRO COLOR_PALETTE_PROJECTILE
color_palette_projectile_{02x:COLOR_PALETTE_BANK1_NUMBER}:
        DEF COLOR_PALETTE_BANK1_NUMBER = COLOR_PALETTE_BANK1_NUMBER + 1
.main:
        INCBIN "pal/projectile/\1/main.pal",0,8
.blind:
        INCBIN "pal/projectile/\1/blind.pal",0,8
.damage:
        INCBIN "pal/projectile/\1/damage.pal",0,8
.flash:
        INCBIN "pal/projectile/\1/flash.pal",0,8
ENDM

MACRO COLOR_PALETTE_SET_SINGLE
     REDEF LOWER EQUS STRRPL("\1", "/", "_")
     REDEF UPPER EQUS STRUPR("{LOWER}")
color_palette_set_{LOWER}:
     DEF PALETTE_SET_{UPPER} = (color_palette_set_{LOWER} - $4000) / $20
     EXPORT PALETTE_SET_{UPPER}
.main:
        INCBIN "pal/\1/main.pal",0,8
.blind:
        INCBIN "pal/\1/blind.pal",0,8
.damage:
        INCBIN "pal/\1/damage.pal",0,8
.flash:
        INCBIN "pal/\1/flash.pal",0,8
ENDM

DEF COLOR_PALETTE_ATTACK_NUMBER = $00
MACRO COLOR_PALETTE_ATTACK
color_palette_bank_2_{02x:COLOR_PALETTE_ATTACK_NUMBER}:
        DEF COLOR_PALETTE_ATTACK_NUMBER = COLOR_PALETTE_ATTACK_NUMBER + 1
.main:
        INCBIN "pal/attack/\1/main.pal",0,8
.blind:
        INCBIN "pal/attack/\1/blind.pal",0,8
.damage:
        INCBIN "pal/attack/\1/damage.pal",0,8
.flash:
        INCBIN "pal/attack/\1/flash.pal",0,8
ENDM
