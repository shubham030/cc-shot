---
allowed-tools: Bash(screencapture:*), Bash(echo:*), Read
description: Screenshot display N — usage /shotn <display-number>
argument-hint: <display-number>
---

!`screencapture -D $ARGUMENTS -x /tmp/cc-shot.png && echo CAPTURED || echo FAILED`

If the output above is "CAPTURED": Read `/tmp/cc-shot.png` and wait for my next instruction.

If the output is "FAILED" or empty: tell me "Display $ARGUMENTS does not exist — run /shots to see available displays." Do not Read the file (it may be stale from a prior capture).
