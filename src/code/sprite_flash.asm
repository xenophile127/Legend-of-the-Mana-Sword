; Rewritten sprite flashing routines. These differ from the original in three ways:
; 1. Invisible sprites were treated the same as visible sprites. An example: Using a healing pond there are
;    four invisible sprites considered: two for the pond script trigger, and two used for script effect logic.
;    As a result it was not possible to use the cure ponds without causing sprite flash.
; 2. The original likely had an edge condition where a sprite that was hidden due to its second (or third)
;    part hitting the limit of ten sprites would still be counted against the limit in the first (or second)
;    block of sprites. In practice this is a difficult situation to set up.
; 3. Performance optimization. These two routines get called every frame and each loop through all 40 sprites.
;    Of note, these arrays do not cross 8-bit alignment boundaries so the code now makes heavy use of 8-bit
;    inc/dec (ex: `inc l` instead of `inc hl`).
;    Also, some care has been taken to ensure the most common paths are best optimized.  

; What hasn't changed:
; The overall design is to work in 8ox high stripes, counting how many sprites occupy at least part of each
; stripe. After the hardware limit of 10 sprites is reached further sprites are moved offscreen. Processing
; starts the next time at the first hidden sprite if any (or the first sprite). This keeps sprites (in most
; cases) from disappearing for more than one frame at a time. It does mean that sprites at higher addresses
; are the first to go.
; Sprites are still hidden in pairs, essentially extending the game's "metasprite" abstraction to the sprite
; flashing code. This means an object either appears in a frame or it doesn't--never will the left or right
; half of an object appear on its own. There's a potential optimization for when the player is just entering
; the screen from the east or west of hiding the offscreen sprite, but that would result visually in one or
; more objects flashing only one side.

; Also note, this code is entirely disabled during bosses. The fact that it essentially considers any sprite off-grid
; to be 24px tall means any boss that moves more finely grained than that (likely every boss) will self-interfere
; if only six sprites (48px) wide. This often leads to boss projectiles going invisible.

; Check that alignment assumptions are correct:
assert HIGH(wSpriteShuffleScratch) == HIGH(wSpriteShuffleScratch + SCRN_VY_B)
assert HIGH(wHiddenSpritesYPositions) == HIGH(wHiddenSpritesYPositions + OAM_COUNT)
assert LOW(wOAMBuffer) == $00

; Sprites hidden by the shuffling routine are moved to y=$ce so any sprites with that y value should be restored
; before running most game logic.
; When optimizing this function, keep in mind that the most common case is to loop 40 times making no changes.
spriteShuffleShowHidden:
    ld hl, wHiddenSpritesYPositions + OAM_COUNT - 1
    ld b, OAM_COUNT
    xor a
.loop:
    cp a, [hl]
    jr nz, .show
    dec l
    dec b
    jr nz, .loop
    ret
.show:
; The slow path. This isn't hit at all unless there are sprites flashing.
; Calculate the sprite location based off of its index (wOAMBuffer + (b - 1) * sizeof_OAM_ATTRS).
    ld a, b
    dec a
    add a
    add a
; Use that to get its entry in the array.
    ld d, HIGH(wOAMBuffer)
    ld e, a
; Restore the saved y position.
    ld a, [hl]
    ld [de], a
; Clear the entry.
    xor a
    ld [hl-], a
    dec b
    jr nz, .loop
    ret

; Tests the screen in eight pixel sections for more than ten sprites.
; A sprite that is not aligned to a vertical multiple of eight is treated as if it is 24 pixels tall.
; Testing starts at the first sprite hidden last frame (if any) to give previously hidden sprites priority.
spriteShuffleDoFlash:
; Clear the scratch array.
    ld hl, wSpriteShuffleScratch
    ld b, SCRN_Y_B + $02
    xor a
.loop_scratch:
    ld [hl+], a
    dec b
    jr nz, .loop_scratch
; Begin with the first sprite hidden (if any) last time. This ensures that sprites won't disappear for too long.
    ld hl, wSpriteShuffleHiddenSpriteAddressLow
    ld d, HIGH(wOAMBuffer)
    ld e, [hl]
    ld [hl], $ff
; Because the game's metasprite abstraction is so consistent, all the tests on one sprite of a metasprite pair
; can be applied to the other. That means this loop can run on 20 metasprites instead of 40 sprites.
    ld b, OAM_COUNT / 2
.loop:
; Test if this sprite is already hidden (y position is zero or greater than or equal to 144) and if so skip it.
; Normally the test would be (SCRN_Y + OAM_Y_OFS) for 160, but the status bar covers the last 16 lines.
; Since unused sprites have their y address set to zero that is the most common branch.
    ld a, [de]
    or a
    jr z, .next
    cp SCRN_Y
    jr nc, .next
; The y position of the current sprite is kept around in c.
    ld c, a
; Check the tile number. Tile number $10 is used for invisible sprites which are always moved offscreen.
    inc e
    inc e
    ld a, [de]
    dec e
    dec e
    cp $10
    jr z, .hide
; Since most sprites are aligned to a 8x8 grid location consider hiding in eight scan line chunks.
; Sprites that are on-grid take up two while sprites that are vertically off-grid take up three.
    ld hl, wSpriteShuffleScratch
    ld a, c
; Divide by eight.
    and $f8
    rra
    rra
    rra
    add l
    ld l, a
; Check whether the sprite occupies three sections.
    ld a, $07
    and c
; Maximum of ten sprites per line, so five metasprites.
    ld a, $05 - 1
    jr z, .on_grid_check
    cp [hl]
    jr c, .flash
    inc l
.on_grid_check:
    cp [hl]
    jr c, .flash
    inc l
    cp [hl]
    jr c, .flash
; Under the limit. The sprite will not be hidden. Increment the counts.
; The original had edge cases where one or two counts were incremented for a
; sprite that was ultimately hidden. This code requires it to pass all checks
; before it is counted.
; Check whether the sprite occupies three sections.
    ld a, $07
    and c
    jr z, .on_grid_increment
    inc [hl]
    dec l
.on_grid_increment:
    inc [hl]
    dec l
    inc [hl]
    jr .next
.flash:
; The first sprite hidden is given preferential treatment next time.
    ld hl, wSpriteShuffleHiddenSpriteAddressLow
    ld a, [hl]
    inc a
    jr nz, .hide
    ld [hl], e
.hide:
; c = y postion
; de = OAMBuffer entry y position
; Calculate the sprite number by dividing by four.
    ld a, e
    rrca
    rrca
; Store the original y position for both sprites.
; This is done twice so the restoration routine can be kept simpler.
    ld hl, wHiddenSpritesYPositions
    add l
    ld l, a
    ld [hl], c
    inc l
    ld [hl], c
; Set both sprites' position to the magic number $ce, moving it offscreen and
; indicating it should be restored next frame.
    ld a, $ce
    ld h, d
    ld l, e
    ld [hl+], a
    inc l
    inc l
    inc l
    ld [hl], a
.next:
    dec b
    jr z, .finished
    ld a, sizeof_OAM_ATTRS * 2
    add e
    ld e, a
; Since the loop potentially starts mid way through the list,
; check for the end and reset to the beginning if necessary.
    cp OAM_COUNT * sizeof_OAM_ATTRS
    jr nz, .loop
    ld e, LOW(wOAMBuffer)
    jr .loop
.finished:
; If no sprites were hidden reset the start value to zero.
    ld hl, wSpriteShuffleHiddenSpriteAddressLow
    inc [hl]
    ret z
    dec [hl]
    ret
