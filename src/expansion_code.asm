;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"

SECTION "bank11", ROMX[$4000], BANK[$11]

;@call_to_bank_jumptable
entryPointTableBankExpansion:
    call_to_bank_target expansion_test

expansion_test:
    ret
