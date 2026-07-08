# NPC Script Header Guide

This guide explains how to format the header for NPC script files in LandSandBoat, and how to locate the required information.

## Header Format

Every NPC script should begin with a standardized header. This header provides the zone name, zone ID, NPC name, and the NPC's spawn position (as a `!pos` command).

```lua
-----------------------------------
-- Area: Windurst Walls (239)
--  NPC: Ambrosius
-- !pos 65.175 -2.499 -63.231 239
-----------------------------------
```

### Components

1.  **Area**: The name of the zone followed by its Zone ID in parentheses.
2.  **NPC**: The name of the NPC.
3.  **!pos**: The X, Y, Z coordinates, followed by the Zone ID. This matches the format used by the in-game `!pos` command.

## Finding the Information

### 1. Zone Name and ID

*   **Zone Name**: Usually matches the name of the folder containing the script (e.g., `scripts/zones/Windurst_Walls/`).
*   **Zone ID**: Can be found in `scripts/enum/zone.lua`. Search for the zone's constant name (e.g., `WINDURST_WALLS`) to find its numeric ID.

### 2. NPC Name

*   **NPC Name**: Use the **display name** (the second name) as it appears in the `sql/npc_list.sql` file. This is usually the name players see in-game.

    Example SQL:
    ```sql
    INSERT INTO `npc_list` VALUES (17752605,'AMAN_Liaison','A.M.A.N. Liaison', ...);
    ```
    In this case, you would use `A.M.A.N. Liaison` in the header.

### 3. Finding Position (X, Y, Z) in `sql/npc_list.sql`

If you don't have the coordinates from an in-game capture or a retail dump, you can find them in the database:

1.  Open `sql/npc_list.sql`.
2.  Search for the NPC's name within the section for the specific zone. Note that names in SQL might be in `varbinary` or `char` formats.
3.  The coordinates are stored in the `pos_x`, `pos_y`, and `pos_z` columns.

Example SQL entry:
```sql
INSERT INTO `npc_list` VALUES (16781427,'Ambrosius','Ambrosius',0,65.175,-2.499,-63.231,0,40,40,0,0,0,0,0,'\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',0,NULL,1);
```
In this example:
*   `pos_x` = `65.175`
*   `pos_y` = `-2.499`
*   `pos_z` = `-63.231`
*   Zone ID = `239` (derived from the NPC ID or the zone header in the SQL file).

## Maintaining the Notes Section

If a script requires additional context or documentation, a "Notes" section can be included within the header block.

### Existing Notes
If a script already has a notes section, **do not remove it**. Maintain the notes and update them if your changes alter the NPC's behavior or purpose.

### Formatting Notes
Notes should be placed within the header block, usually before the `!pos` command.

```lua
-----------------------------------
-- Area: Windurst Walls (239)
--  NPC: Ambrosius
-- Notes: This NPC is part of the "Crying Over Onions" quest.
-- !pos 65.175 -2.499 -63.231 239
-----------------------------------
```
