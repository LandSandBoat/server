# Interaction Framework Migration & Verification Guide

## 1. Overview
The project is migrating from "Old-Style" NPC scripts (hardcoded logic in `onTrigger`) to the **Interaction Framework (IF)**. This centralizes quest/mission logic, improves readability, and reduces NPC scripts to minimal stubs.

## 2. Information Discovery

## Retail Captures
Retail packet captures are essential for accurate migrations. They provide the exact sequence of events, NPC positions, and parameters needed for the Interaction Framework. (See the [Retail Packet Captures Format Guide](retail-packet-captures.md) for detailed folder structures).
- **`caplog` (Chat Logs):** Start here to understand the quest flow. The capturer's notes and NPC dialogue will help you identify which events correspond to which quest steps.
- **`eventview/simple` (Simplified Events):** Use these logs to map raw packets directly to Interaction Framework calls:
  - **`CEventPacket` (`0x032`/`0x034`):** The `EventPara` value is the Event ID. This directly maps to your IF `quest:progressEvent(id)` or `quest:event(id)` calls.
  - **`CMessageSpecialPacket` (`0x02A`):** The `MessageNumber` value is the Text ID. This directly maps to your IF `quest:messageSpecial(id)` calls (often used for non-standard dialogues or system messages like checking doors/sarcophagi).
  - **`CMessageNamePacket` (`0x027`):** The `MesNum` value (sometimes requiring a bitwise `& 0xFFFF` depending on the logger output) is the standard chat dialogue ID. This maps to IF `quest:messageName(id)` or standard text lookups.
- **`npclogger/database` (NPC Data):** Use the `.lua` files here to populate or verify NPC coordinates and properties in `sql/npc_list.sql` or to format your NPC script headers correctly.
- **`packetviewer` (Raw Packets):** For complex interactions that `eventview` doesn't fully capture, you can dive into the raw packets here to understand what the client is sending and receiving.

### Database (SQL)
- **NPC IDs & Positions:** Check `sql/npc_list.sql`. Use this to find the 8-digit NPC ID and their `!pos` coordinates.
- **Item IDs:** Check `sql/item_basic.sql`. If an item constant is missing from Lua, find the ID here and use it directly or add it to the enum.

### Global Registries (Lua Enums)
- **Quest IDs:** `scripts/globals/quests.lua`.
- **Mission IDs:** `scripts/globals/missions.lua`.
- **Item Constants:** `scripts/enum/item.lua`.
- **Key Item Constants:** `scripts/enum/key_item.lua`.
- **Zone Constants:** `scripts/enum/zone.lua`.

### Retail Event Dumps
The `sruon/FFXI-EventsDump` repository is the source of truth for retail event IDs and dialogue.
- **Nearby Repo:** If the repo is cloned next to this one, access it via `../FFXI-EventsDump/dumps/<Zone_Name>`.
- **Remote Access:** Use `web_fetch` or `google_web_search` to find raw markdown files on GitHub if the local path is unavailable.
- **Strings:** Each zone folder has a `strings.txt` file. Map the decimal/hex IDs in the `.md` files to these strings to verify dialogue.

## 3. The Migration Workflow

### Step 1: Research (The "Wiki Triangulation")
1.  Check **BOTH** [BG-Wiki](https://www.bg-wiki.com) and [FFXI Wikia](https://ffxiclopedia.fandom.com).
2.  Compare steps, item requirements, and NPC dialogue descriptions.
3.  Note any "Wait until Japanese Midnight" or "Zone out/in" requirements.

### Step 2: Implementation (The IF File)
Create the appropriate file in `scripts/quests/`, `scripts/missions/`, or `scripts/quests/hiddenQuests/`.

- **Choosing the Container Class:**
    - **Quests:** `local quest = Quest:new(xi.questLog.LOG_NAME, xi.quest.id.area.QUEST_NAME)`
    - **Missions:** `local mission = Mission:new(xi.mission.log_id.LOG_NAME, xi.mission.id.area.MISSION_NAME)`
    - **Hidden Quests:** `local quest = HiddenQuest:new('UniqueStringName')` (Used for non-logged content like Trust acquisitions or Mog House expansions).

- **Why they are different:**
    - **Variable Scoping:** Each class automatically prefixes variables (e.g., `Quest[1][2]Prog`, `Mission[4][10]Prog`, or `UniqueStringNameProg`). This prevents collisions across different types of content.
    - **Check Arguments:** `Quest` and `Mission` objects automatically check their respective logs/statuses when determining if a section's `check` function should run. `HiddenQuest` relies entirely on custom variables.

- **Basic Structure:**
```lua
local quest = Quest:new(xi.questLog.LOG_NAME, xi.quest.id.area.QUEST_NAME)
quest.reward = { fame = 30, gil = 1000 }
quest.sections = {
    {
        check = function(player, status, vars) return status == xi.questStatus.QUEST_AVAILABLE end,
        [xi.zone.ZONE_ID] = {
            ['NPC_Name'] = quest:progressEvent(100),
        },
    },
}
```
- **Trading:** Use `onTrade` within the NPC block. Always use `npcUtil.tradeHasExactly` or `npcUtil.tradeHas`.
- **Zoning:** Use `quest:setMustZone(player)` and `quest:getMustZone(player)`.
- **Trigger Areas:** Handle approach-based cutscenes via `onTriggerAreaEnter`.

### Step 3: NPC Script Cleanup
1.  **Header:** Ensure the header includes the `!pos` from `npc_list.sql`.
2.  **Logic Removal:** Strip all `if/else` quest blocks.
3.  **Minimal Stub:** If no non-quest logic remains, convert to:
```lua
---@type TNpcEntity
local entity = {}
entity.onTrigger = function(player, npc) end
entity.onTrade = function(player, npc, trade) end
return entity
```
4.  **Preservation:** Keep patrol logic (`onSpawn`), Trust logic, or complex non-migrated quests in the script.

### Step 4: Default Actions
If an NPC has a single default interaction (e.g., `player:startEvent(200)`), move it to `scripts/zones/<Zone>/DefaultActions.lua`:
```lua
['NPC_Name'] = { event = 200 },
```

### Step 5: Global Marking
Mark the quest in `scripts/globals/quests.lua` with the specific partial conversion tag:
```lua
QUEST_NAME = 123, -- + Partial conversion. TODO: This needs completing with retail caps
```

## 4. Advanced Interaction Techniques
- **Container Action Helpers (`event` vs `progressEvent`):** Under the hood (`scripts/globals/interaction/container.lua`), actions like `quest:progressEvent(id)` are simply syntactic sugar for creating a base Event and applying a priority modifier (e.g. `Event:new(id):progress()`). The same applies to `quest:cutscene(id)` or `quest:replaceEvent(id)`. Use `progressEvent` for critical quest progression to ensure it overrides default NPC behaviors.
- **Event Updates:** Handle multi-choice menus via `onEventUpdate`.
- **Bitmasks:** Use `quest:setVarBit(player, 'Prog', bit)` and `quest:isVarBitsSet(player, 'Prog', bit)`.
- **Variables:** Prefer `quest:getVar` over `player:getCharVar` for framework-managed persistence.
- **Timers:** Use `quest:setTimedVar(player, 'Timer', JstMidnight())` for daily repeats.

## 5. Verification Golden Rule
**Never assume existing logic is correct.** Existing scripts often skip "Reminder" dialogue or "Post-Quest" flavor text. Always cross-reference the `sruon/FFXI-EventsDump` for every NPC involved in the quest to ensure 100% dialogue coverage.
