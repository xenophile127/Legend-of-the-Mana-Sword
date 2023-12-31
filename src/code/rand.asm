; Random number generator for Gameboy gbz80 architecture
;
; Written by Dagmor for xenophile's Legend of the Mana Sword,
; a hack of Final Fantasy Adventure a.k.a. Seiken Densetsu
; 
; This is public domain. Do with this what you will. Have fun.
;
; Linear Congruential Generator (LCG) with m=2^24 a=65797 (0x010105) and c=1
;
; The multiplier 'a' is partly based upon CC65's use of a=0x01010101 for
; compute efficiency but altered such that (a-1)/4 is integer and
; (a-1)/8 is not integer for improved statistical performance.
; Reference: https://en.wikipedia.org/wiki/Linear_congruential_generator
;
; Register Output:
; A returns the uniform random byte, also stored in wRndState+2
; BC,DE unchanged
; HL points to wRndState+2
; Flags are set as follows: 
;   Z set when A is zero
;   N unset
;   H set 50% of the time, strongly correlated with A and is non-stationary
;   C set 50% of the time, strongly correlated with A and is non-stationary
;
; Comments after each instruction give CPU cycles / ROM size in bytes
; 55 total cycles (220 dots)
; 34 total bytes
getRandomByte:
    ; The choice to only use BC registers was intentional.
    ; I do not believe using DE saves enough cycles to warrant
    ; the extra push/pop to keep the register state.
    ; If you don't care about DE for your application,
    ; then by all means this could be optimized further.
    push bc ;4/1

    ; Load the current random state 'y' from the 3-byte (24-bit)
    ; working RAM variable wRndState stored in little endian.
    ; Compute x[i + 1] = x[i] * 0x010105 + 0x000001
    ; via x[i + 1] = (0x010101 * x[i]) + ((x[i] << 2) + 1)
    ; Computations for the 0x010101 multiply occur during the load
    ld hl,wRndState ;3/3
    ld a,[hl+] ;2/1
    ld c,[hl] ;2/1
    add c ;1/1
    ld [hl+],a ;2/1
    ld b,[hl] ;2/1
    adc b ;1/1
    ld [hl-],a ;2/1
    dec hl ;2/1
    ld a,[hl] ;2/1

    ; Registers 'BCA' hold the original wRndState value
    ; wRndState now contains its original value multiplied by 0x010101
    ; Next, multiply 'BCA' by 4 via bit shifting
    add a ;1/1
    rl c ;2/2
    rl b ;2/2
    add a ;1/1
    rl c ;2/2
    rl b ;2/2

    ; Add 1 (the LCG's constant 'c') to 'BCA'
    ; Since A is even from the last step, the add will never carry
    inc a ;1/1

    ; Add 'BCA' to the previously multiplied value in wRndState
    add [hl] ;2/1
    ld [hl+],a ;2/1
    ld a,[hl] ;2/1
    adc c ;1/1
    ld [hl+],a ;2/1
    ld a,[hl] ;2/1
    adc b ;1/1
    ld [hl],a ;2/1
    
    ; Clean up and exit
    pop bc ;3/1
    ret ;4/1
