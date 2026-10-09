; Metasprites for script-triggered special effects (recovery ponds, fire, and explosions).

; This is an invisible metasprite created at the specified (x, y) locaiton.
; Presumably this is used like a dummy player to center the effect.

; Palettes are loaded for the visible parts of the effect, not for this. It has
; PAL_PLAYER (0) as a placeholder and as a guard--if code ever loaded a palette
; into that slot it would be immediately visible as a color change of the player
; sprites.

specialEffectMetaspriteTable:
    METASPRITE $00, OAMF_NOFLIP, OAMF_PAL0, $10, $10, PAL_PLAYER
    METASPRITE $01, OAMF_NOFLIP, OAMF_PAL0, $10, $10, PAL_PLAYER
    METASPRITE $02, OAMF_NOFLIP, OAMF_PAL0, $10, $10, PAL_PLAYER
    METASPRITE $03, OAMF_NOFLIP, OAMF_PAL0, $10, $10, PAL_PLAYER
