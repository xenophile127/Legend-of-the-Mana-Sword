; Metasprite tables for NPC projectiles and melee attacks (both companions and enemies).

; These metasprite tables are made up of entries of [attr, tile1, tile2].


metasprites30FourDirections:
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $32, $30
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $34, $36
    db   OAMF_YFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $34, $36

projectileIceMetatileTable:
    db   OAMF_XFLIP  | OAMF_PAL1 | PAL_PROJECTILE, $32, $30
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_PROJECTILE, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL1 | PAL_PROJECTILE, $34, $36
    db   OAMF_YFLIP  | OAMF_PAL1 | PAL_PROJECTILE, $34, $36

; Two graphics are used and flipped so east/west and north/south are mirror images of each other.
metasprites38FourDirections:
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $3a, $38
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e
    db   OAMF_YFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $3a, $38
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e
    db   OAMF_YFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e

; Used by Guardian's lasers.
; This is the only projectile that is loaded outside the normal area.
; Two graphics are used and flipped so east/west and north/south are mirror images of each other.
metasprites68FourDirections:
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $6a, $68
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $68, $6a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $6c, $6e
    db   OAMF_YFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $6c, $6e

; Modified so that the Mega Xorn can use Poison Threads while Dragonfly uses Fire.
metasprites30FourDirections_npc_pal3:
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_NPC3, $32, $30
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC3, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC3, $34, $36
    db   OAMF_YFLIP  | OAMF_PAL0 | PAL_NPC3, $34, $36

; One frame, no flipping.
metasprites30Static:
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32

; Modified so that the Mandrake can use Voice while Porcupine uses Needle.
metasprites30Static_npc_pal2:
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC2, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC2, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC2, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC2, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC2, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC2, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC2, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_NPC2, $30, $32

; Used by Doppel Mirror.
; One frame, no flipping.
metasprites38Static:
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a

; Used by Ogre and Elephant's rocks, and Kraken, Dragon, and Red Dragon's projectiles.
; One graphic drawn with diagonal symetry allows rotation for the four directions.
metasprites30BiasRotate:
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $32, $30
    db   OAMF_YFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32
    db   OAMF_XYFLIP | OAMF_PAL0 | PAL_PROJECTILE, $32, $30
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $32, $30
    db   OAMF_YFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32
    db   OAMF_XYFLIP | OAMF_PAL0 | PAL_PROJECTILE, $32, $30

; Used by Death Crab's scissors and Minotaur's axe
; One graphic drawn with diagonal symetry allows rotation for the four directions.
metasprites38BiasRotate:
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $3a, $38
    db   OAMF_YFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_XYFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3a, $38
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $3a, $38
    db   OAMF_YFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_XYFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3a, $38

; Alternate between two static frames;
metasprites30Pulsing:
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $30, $32
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $34, $36
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $34, $36
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $34, $36
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $34, $36

; Alternate between two static frames;
metasprites38Pulsing:
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $3c, $3e

; Used by Scorpions and Mimic Chests, though chests only attack north.
; One frame, mirrored only east/west.
metasprites38XMirror:
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $3a, $38
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $3a, $38
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a

; Used by the Werewolf and Molebear's melee attack.
; One frame mirrored from east to west, rotated 180 degrees from north to south.
metasprites38FlipRotate:
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $3a, $38
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $3a, $38
    db   OAMF_YFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $3a, $38
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $3a, $38
    db   OAMF_YFLIP  | OAMF_PAL0 | PAL_PROJECTILE, $38, $3a

; Used by all companion attacks except Watts.
; Two graphics are used and flipped so east/west and north/south are mirror images of each other.
metaspritesCompanionFourDirections:
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_FOLLOWER, $1a, $18
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_FOLLOWER, $18, $1a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_FOLLOWER, $1c, $1e
    db   OAMF_YFLIP  | OAMF_PAL0 | PAL_FOLLOWER, $1c, $1e

; Used by Watts' axe attack.
; One graphic drawn with diagonal symetry allows rotation for the four directions.
metaspritesCompanionBiasRotate:
    db   OAMF_XFLIP  | OAMF_PAL0 | PAL_FOLLOWER, $1a, $18
    db   OAMF_YFLIP  | OAMF_PAL0 | PAL_FOLLOWER, $18, $1a
    db   OAMF_NOFLIP | OAMF_PAL0 | PAL_FOLLOWER, $18, $1a
    db   OAMF_XYFLIP | OAMF_PAL0 | PAL_FOLLOWER, $1a, $18
