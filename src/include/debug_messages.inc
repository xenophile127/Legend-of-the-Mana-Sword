; Use DBG_STR to define the message. Refer to debug.inc for further instructions.
IF DEF(DEBUG)

introDebugMsg:
    DBG_STR STRFMT("LotMS Build  %u-%02u-%02u", __UTC_YEAR__, __UTC_MONTH__, __UTC_DAY__)

ENDC
