#Weaponskill Parameter Tables
----------------------------

`ftpMod` : Table of 3 floating point elements to represent points on the piecemeal function for damage adjustment vs TP.  For weaponskills that do not vary, this will have the same value at all 3 points.

Example: `ftpMod = { 1.0, 2.0, 5.0 }`

NOTE: The below modifiers should _ONLY_ be set if applicable to the WS.

`critVaries` : Table of 3 floating point elements to represent points on the piecemeal function for modifiers (points at 1000, 2000, and 3000 TP).

Example: `critVaries = { 0.15, 0.2, 0.25 }`
