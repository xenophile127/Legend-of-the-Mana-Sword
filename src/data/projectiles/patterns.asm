; Patterns for NPC projectiles and melee attacks.

; A simple stab pattern.
; First byte is default direction flags.
; Second and third bytes are default vector.
; Fourth byte is unknown but always 4.
; Null terminated
;@data amount=3 format=bbbb
pattern_melee:
    db   $11, $08, $00, $04                            ;; 09:48a9 ???? $00
    db   $11, $10, $00, $04                            ;; 09:48ad ???? $01
    db   $11, $08, $00, $04                            ;; 09:48b1 ???? $02
    db   $00                                           ;; 09:48b5 ?

; Starts at maximum range and then draws closer.
; First byte is default direction flags.
; Second and third bytes are default vector.
; Fourth byte is unknown but always 4.
; Null terminated
;@data amount=3 format=bbbb
pattern_scorpion_tail:
    db   $11, $16, $00, $04                            ;; 09:48b6 ???? $00
    db   $11, $13, $00, $04                            ;; 09:48ba ???? $01
    db   $11, $10, $00, $04                            ;; 09:48be ???? $02
    db   $00                                           ;; 09:48c2 ?

; First byte is default direction flags.
; Second and third bytes are default vector. (Moves eight pixels each tick.)
; This is used by all npc projectiles and attacks except the melee types.
; Null terminated
;@data amount=1 format=bbb
pattern_simple:
    db   $11, $08, $00                                 ;; 09:48c3 ...
    db   $00                                           ;; 09:48c6 .

; Used by the mimics.
; There's nothing obvious here to make the direction always north, so that is probably in the enemy logic.
; First byte is default direction flags.
; Second and third bytes are default vector.
; Fourth byte is unknown but always 4.
; Null terminated
;@data amount=2 format=bbbb
pattern_chest_bite:
    db   $11, $f0, $00, $04                            ;; 09:48c7 ???? $00
    db   $11, $f0, $00, $04                            ;; 09:48cb ???? $01
    db   $00
