#Weaponskill Parameter Tables
----------------------------

`ftpMod` : Table of 3 floating point elements to represent points on the piecemeal function for damage adjustment vs TP.  For weaponskills that do not vary, this will have the same value at all 3 points.

Example: `ftpMod = { 1.0, 2.0, 5.0 }`

NOTE: The below modifiers should _ONLY_ be set if applicable to the WS.
----------------------------
`accVaries`  : Table of 3 integer elements to represent points on the piecemeal function for modifiers (points at 1000, 2000, and 3000 TP). 30 at 2k = +30 acc at exactly 2,000 tp

Example: `accVaries = { 0, 30, 60 }`

`atkVaries`  : Table of 3 floating point elements to represent points on the piecemeal function for modifiers (points at 1000, 2000, and 3000 TP).

NOTE: atkVaries can be used for atk adjustments (See: https://w.atwiki.jp/studiogobli/pages/93.html) or for a function based on TP.  Default is a multiplier of 1.0 if not defined.

`critVaries` : Table of 3 floating point elements to represent points on the piecemeal function for modifiers (points at 1000, 2000, and 3000 TP).

Example: `critVaries = { 0.15, 0.2, 0.25 }`
