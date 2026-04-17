---
allowed-tools: Bash(system_profiler:*)
description: List connected displays and how to capture each
---

!`system_profiler SPDisplaysDataType`

Parse the output above and print a concise table with one row per connected display:

| # | Resolution | Main? | Command |
|---|---|---|---|

Where `#` is the display's position in the output (1-indexed, matching what `screencapture -D` expects), `Main?` is yes/no, and `Command` is `/shotn 1`, `/shotn 2`, etc. Also note `/shotm` for main and `/shota` for all.

Keep it to the table plus one line of guidance. Nothing else.
