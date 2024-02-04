; Use DBG_STR to define the message. Refer to debug.inc for further instructions.
IF DEF(DEBUG)

introDebugMsg:
    DBG_STR STRCAT("LotMS Build ",__ISO_8601_UTC__)

ENDC
