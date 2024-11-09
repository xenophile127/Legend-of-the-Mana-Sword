# Logging

Legend of the Mana sword debug messages using the No$GBA/BGB logging system. In BGB these log to the 'debug messages' window which can be accessed from the debugger's 'Windows' menu. See the [BGB manual](https://bgb.bircd.org/manual.html#expressions) for more information on the log format.

Adding messages consists of four steps:
1. Ensure `debug.inc` is included: `INCLUDE "include/debug.inc"`.
2. Add a label and message in `src/include/debug_messages.inc`.
3. Make sure there is at least six bytes of free space where you want to add the log message.
4. Load the label into `bc`, `de`, or `hl` and then call one of `logger.bc`, `logger.de`, or `logger.hl`.

You can also use the macro `DBG_MSG_LABEL` instead of the `logger` functions. This is faster and doesn't require a register, but uses an extra five bytes of space.

There is another macro, `DBG_MSG` which accepts an inline string. It's preferable *not* to use this and instead add all strings into `debug_messages.inc`.

## Examples:

```ld bc, debugMsgBuildDate
call logger.bc```

`DBG_MSG_LABEL debugMsgHelloWorld`
