; Metasprite tables for NPC projectiles and melee attacks (both companions and enemies).

; These metasprite tables are made up of entries of [attr, tile1, tile2].

projectileIceMetatileTable:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_SNOW, $32, $30
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_SNOW, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_SNOW, $34, $36
    db   OAMF_YFLIP  | OAMF_PAL1 | PAL_SNOW, $34, $36

data_09_4789:
    db   OAMF_XFLIP  | OAMF_PAL0, $3a, $38
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $3c, $3e
    db   OAMF_YFLIP  | OAMF_PAL0, $3c, $3e
    db   OAMF_XFLIP  | OAMF_PAL0, $3a, $38
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $3c, $3e
    db   OAMF_YFLIP  | OAMF_PAL0, $3c, $3e

data_09_47a1:
    db   OAMF_XFLIP  | OAMF_PAL0, $6a, $68
    db   OAMF_NOFLIP | OAMF_PAL0, $68, $6a
    db   OAMF_NOFLIP | OAMF_PAL0, $6c, $6e
    db   OAMF_YFLIP  | OAMF_PAL0, $6c, $6e
    db   OAMF_XFLIP  | OAMF_PAL0, $6a, $68
    db   OAMF_NOFLIP | OAMF_PAL0, $68, $6a
    db   OAMF_NOFLIP | OAMF_PAL0, $6c, $6e
    db   OAMF_YFLIP  | OAMF_PAL0, $6c, $6e

data_09_47b9:
    db   OAMF_NOFLIP | OAMF_PAL0, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0, $30, $32

data_09_47d1:
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a

data_09_47e9:
    db   OAMF_XFLIP  | OAMF_PAL0, $32, $30
    db   OAMF_YFLIP  | OAMF_PAL0, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0, $30, $32
    db   OAMF_XYFLIP | OAMF_PAL0, $32, $30
    db   OAMF_XFLIP  | OAMF_PAL0, $32, $30
    db   OAMF_YFLIP  | OAMF_PAL0, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0, $30, $32
    db   OAMF_XYFLIP | OAMF_PAL0, $32, $30

data_09_4801:
    db   OAMF_XFLIP  | OAMF_PAL0, $3a, $38
    db   OAMF_YFLIP  | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_XYFLIP | OAMF_PAL0, $3a, $38
    db   OAMF_XFLIP  | OAMF_PAL0, $3a, $38
    db   OAMF_YFLIP  | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_XYFLIP | OAMF_PAL0, $3a, $38

data_09_4819:
    db   OAMF_NOFLIP | OAMF_PAL0, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0, $34, $36
    db   OAMF_NOFLIP | OAMF_PAL0, $34, $36
    db   OAMF_NOFLIP | OAMF_PAL0, $34, $36
    db   OAMF_NOFLIP | OAMF_PAL0, $34, $36

data_09_4831:
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $3c, $3e
    db   OAMF_NOFLIP | OAMF_PAL0, $3c, $3e
    db   OAMF_NOFLIP | OAMF_PAL0, $3c, $3e
    db   OAMF_NOFLIP | OAMF_PAL0, $3c, $3e

data_09_4849:
    db   OAMF_XFLIP  | OAMF_PAL0, $3a, $38
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_XFLIP  | OAMF_PAL0, $3a, $38
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a

data_09_4861:
    db   OAMF_XFLIP  | OAMF_PAL0, $3a, $38
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_XFLIP  | OAMF_PAL0, $3a, $38
    db   OAMF_YFLIP  | OAMF_PAL0, $38, $3a
    db   OAMF_XFLIP  | OAMF_PAL0, $3a, $38
    db   OAMF_NOFLIP | OAMF_PAL0, $38, $3a
    db   OAMF_XFLIP  | OAMF_PAL0, $3a, $38
    db   OAMF_YFLIP  | OAMF_PAL0, $38, $3a

data_09_4879:
    db   OAMF_XFLIP  | OAMF_PAL0, $1a, $18
    db   OAMF_NOFLIP | OAMF_PAL0, $18, $1a
    db   OAMF_NOFLIP | OAMF_PAL0, $1c, $1e
    db   OAMF_YFLIP  | OAMF_PAL0, $1c, $1e
    db   OAMF_XFLIP  | OAMF_PAL0, $1a, $18
    db   OAMF_NOFLIP | OAMF_PAL0, $18, $1a
    db   OAMF_NOFLIP | OAMF_PAL0, $1c, $1e
    db   OAMF_YFLIP  | OAMF_PAL0, $1c, $1e

data_09_4891:
    db   OAMF_XFLIP  | OAMF_PAL0, $1a, $18
    db   OAMF_YFLIP  | OAMF_PAL0, $18, $1a
    db   OAMF_NOFLIP | OAMF_PAL0, $18, $1a
    db   OAMF_XYFLIP | OAMF_PAL0, $1a, $18
    db   OAMF_XFLIP  | OAMF_PAL0, $1a, $18
    db   OAMF_YFLIP  | OAMF_PAL0, $18, $1a
    db   OAMF_NOFLIP | OAMF_PAL0, $18, $1a
    db   OAMF_XYFLIP | OAMF_PAL0, $1a, $18
