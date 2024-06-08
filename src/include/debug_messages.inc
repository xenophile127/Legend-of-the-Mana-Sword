; Use DBG_STR to define the message. Refer to debug.inc for further instructions.

; Messages SHOULD use one of these log levels:
; TRACE: Temporary messages, not to be checked in.
; DEBUG: Raw data useful for debugging.
; INFO: Standard logging level indicating something happened.
; WARN: Something unexpected happened, but there is no impact on gameplay.
; ERROR: Something happened that may cause unintended behavior noticible to the player.
; FATAL: Detected an invalid state that makes it undesirable to continue execution.
;        FATAL level messages SHOULD be followed with an infinite loop to preserve state.

introDebugMsg:
    DBG_STR STRFMT("[INFO] LotMS Build  %u-%02u-%02u", __UTC_YEAR__, __UTC_MONTH__, __UTC_DAY__)

bootupRegisterStates:
; $fffc == hBootup.a, $fffd == hBootup.b, $fffe == hBootupc
    DBG_STR "[DEBUG] Initial register values: a=%($fffc)% b=%($fffd)% c=%($fffe)%"

nonAlignedTileCopy:
IF DEF(COLOR)
; Tile copies must be aligned to a 16 byte boundary--both source and destination--on GBC for VRAM DMA.
    DBG_STR STRFMT("[ERROR] Non-aligned tile copy.")
ELSE
; On non-color Game Boys there is an optimization that assumes they do not cross a 256 byte boundary.
; If tiles are crossing a 16 byte boundary it's more likely a bug than intentional.
    DBG_STR STRFMT("[WARN] Non-aligned tile copy.")
ENDC

debugMsgColorIncompatible:
    DBG_STR "[FATAL] Requires Game Boy Color or Game Boy Advance."

debugMsgDoubleSpeed:
    DBG_STR "[DEBUG] Performed switch to Double Speed Mode."
