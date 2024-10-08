; Each enemy projectile needs an entry in this file.
; Comments are best-effor to describe the projectile and which enemies use it.
; Some enemies load a projectile that they do not use and obvious cases have been filtered out.

; Projectiles higher than this are either for:
; 1. Companions, who use their own palette for their projectiles.
; 2. Bosses, which are not handled here.

    COLOR_PALETTE_PROJECTILE 000              ; Short Sword    $00 NPC_GOBLIN
    COLOR_PALETTE_PROJECTILE red              ; Voice          $01 NPC_CARROT
    COLOR_PALETTE_PROJECTILE red              ; Needle         $02 NPC_PORCUPINE
    COLOR_PALETTE_PROJECTILE red              ; Harpoon        $03 NPC_CHIBIDEVIL, NPC_TORTOISE, NPC_WATER_DEMON
    COLOR_PALETTE_PROJECTILE red              ; Reflection     $04 NPC_DOPPEL_MIRROR
    COLOR_PALETTE_PROJECTILE red              ; Laser          $05 NPC_GUARDIAN
    COLOR_PALETTE_PROJECTILE red              ; Axe            $06 NPC_MINOTAUR
    COLOR_PALETTE_PROJECTILE red              ; Scissors       $07 NPC_CRAB
    COLOR_PALETTE_PROJECTILE red              ; Ring Beam      $08 NPC_EYE_SPY, NPC_FUZZY_WONDER
    COLOR_PALETTE_PROJECTILE red              ; Rock           $09 NPC_OGRE, NPC_EARTH_DIGGER, NPC_ELEPHANT
    COLOR_PALETTE_PROJECTILE red              ; Shuriken       $0a NPC_NINJA
    COLOR_PALETTE_PROJECTILE red              ; Beam           $0b NPC_PHANTASM, NPC_GLAIVE_MAGE

; ; Note: Fire does fire damage, and can be blocked by Ice Shield, or reduced by Flame Armor..
    COLOR_PALETTE_PROJECTILE 012              ; Fire           $0c NPC_DRAGONFLY, NPC_FIRE_MOTH, NPC_SEA_DRAGON

; Note: Ice does ice damage, and can be blocked by Flame Shield, or reduced by Ice Armor.
    COLOR_PALETTE_PROJECTILE 013              ; Ice            $0d NPC_WALRUS

    COLOR_PALETTE_PROJECTILE red              ; Lightning Bolt $0e NPC_CLOUD
    COLOR_PALETTE_PROJECTILE red              ; Poison Thread  $0f NPC_SPIDER, NPC_MEGA_FLYTRAP
    COLOR_PALETTE_PROJECTILE red              ; Spear          $10 NPC_LIZARDMAN
    COLOR_PALETTE_PROJECTILE red              ; Sword          $11 NPC_GLAIVE_KNIGHT, NPC_SHADOWKNIGHT, NPC_DUCK_SOLDIER
    COLOR_PALETTE_PROJECTILE red              ; Rapier         $12 NPC_SKELETON, NPC_GARASHA_DUCK
    COLOR_PALETTE_PROJECTILE red              ; Scorpion Tail  $13 NPC_SCORPION
    COLOR_PALETTE_PROJECTILE red              ; Unused         $14 Only used by bosses. Included as a spacer.
    COLOR_PALETTE_PROJECTILE red              ; Claw           $15 NPC_MOLEBEAR, NPC_KETTS_BUTTLER_WEREWOLF, NPC_WEREWOLF_2
    COLOR_PALETTE_PROJECTILE red              ; Nuke           $16 NPC_JULIUS
    COLOR_PALETTE_PROJECTILE red              ; Mimic Bite     $17 NPC_MIMIC_CHEST
