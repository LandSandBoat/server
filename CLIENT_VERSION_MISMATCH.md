# Client Version Mismatch — Caskets & Survival Guides

## Problem
The FFXI game client auto-updated to version `30260203_0` (Feb 3, 2026), but the server
text IDs and CLIENT_VER are still at `30251227_0` (Dec 27, 2025). With `VER_LOCK = 2`
(greater-than-or-equal), the newer client connects fine, but text offsets are misaligned.

## Symptoms

### Treasure Caskets — Wrong hint messages
When examining a locked brown casket to get a hint (e.g., "The second digit is even"),
the player instead sees "Successfully unlocked the box" or other incorrect messages.

**Root cause**: The client's text string tables shifted by +1 in many zones. The server
sends `PLAYER_OBTAINS_TEMP_ITEM + 11` intending the hint message, but the updated client
now maps that ID to a different string (e.g., the "opened lock" message at the old +10 offset).

**Affected zones** (confirmed shifted in upstream): Valkurm Dunes, Gusgen Mines,
Buburimu Peninsula, and likely many more. The upstream commit `9d4674b9a3` lists:
Buburimu Peninsula, Davoi, Misareaux Coast, Castle Oztroja, Gusgen Mines, Valkurm Dunes,
Waughroon Shrine — but there are IDs.lua changes across nearly every zone.

### Survival Guides — Expansion categories in menu
Survival Guides now show "Original / Zilart / Promathia" expansion categories before the
region list, instead of the flat region-based list.

**Root cause**: The updated client's event rendering for event 8500 changed menu layout
behavior. The server parameters haven't changed — the client just interprets them
differently now.

## Fix
Apply the following upstream commits (or merge upstream base):

1. `9d4674b9a3` — [client] Text ID shifts, Version update
   - Updates `CLIENT_VER` from `30251227_0` to `30260203_0`
   - Shifts text IDs in ~100+ zone IDs.lua files to match Feb 2026 client
2. `0656a8cb90` — [client] NPC ID shifts
   - Updates NPC IDs in npc_list.sql (345 line changes)

Both commits are from the LandSandBoat upstream and are already on the
`item_mods_perle_equipment` branch via its upstream merge (`177f8c5c42`).

### Alternative: Roll back the game client
If updating the server is not desired, roll the FFXI client back to the December 2025
version. However, this is not recommended as FFXI auto-updates through PlayOnline.

## Files involved
- `settings/default/login.lua` — CLIENT_VER setting
- `scripts/zones/*/IDs.lua` — Per-zone text ID definitions
- `sql/npc_list.sql` — NPC ID definitions
- `scripts/globals/caskets.lua` — Casket hint system (uses messageOffset relative to PLAYER_OBTAINS_TEMP_ITEM)
- `scripts/globals/teleports/survival_guide.lua` — Survival guide event (8500)

## Server-side code reference
The casket hint system in `scripts/globals/caskets.lua` calculates message IDs as:
```lua
baseMessage = ID.text.PLAYER_OBTAINS_TEMP_ITEM
-- Hint messages are at offsets 6-19 from baseMessage
-- e.g., HUNCH_SECOND_EVEN_ODD = baseMessage + 11
```
When the client text table shifts by +1 but the server IDs don't update, all casket
messages are off by 1, causing wrong messages to display.
