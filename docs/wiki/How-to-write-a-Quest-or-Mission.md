The purpose of this guide is to provide a brief overview of the structure used for quests and missions with the addition of the interaction framework.  For a reference of available functions, please see the documentation located in your repository, or at [in the Wiki](Interaction-Framework-Documentation).

## Mission/Quest Header
Quests and Missions can have references to multiple triggers and NPCs across multiple zones.  To allow for easier testing, pos references should be included in the comments (example below):
```
-----------------------------------
-- Kazham's Chieftainess
-- Zilart M3
-----------------------------------
-- !addmission 3 6
-- Gilgamesh        : !pos 122.452 -9.009 -12.052 252
-- Jakoh Wahcondalo : !pos 101 -16 -115 250
-----------------------------------
```

## Mission/Quest Declaration
Each mission or quest script must include an return an object of the `Quest` or `Mission` type.  To do this, first declare the object and call its appropriate constructor.  This will define the object with both the area/log ID, and mission/quest ID.
```
local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.KAZHAMS_CHIEFTAINESS)
```
Note: If a duplicate class is detected by the system, and error message will be displayed on server start or reload.

## Mission/Quest Reward
Rewards in this table are given when the class `complete(player)` function is called.  This is passed into a `npcUtil` function, which will provide messaging to the player, along with rewards.
```
mission.reward =
{
    keyItem     = xi.ki.SACRIFICIAL_CHAMBER_KEY,
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH },
}
```
For a list of acceptable items in this table, refer to `npcUtil.completeQuest()` or `npcUtil.completeMission()`.
Note: `nextMission` is only supported by `npcUtil.completeMission()`

## Section Overview
Sections are where the meat of the mission or quest is defined.  It is a table sections, which then are categorized by zone, and then lastly NPC or other triggers.  A full example will be shown at the end of this document.

At minimum, a section should contain one (1) check, and one (1) zone and trigger.

### Checks
The check function at the beginning of each section determines if that section is relevant to the player, and will only have the potential of activating if that function returns true.
```
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,
```
In the above case, this section will be applicable to the player if the player's current mission is the same as the one defined in the script.  The currentMission and missionStatus parameters are defined in the `mission.lua` or `quest.lua` file, in the `getCheckArgs()` function.

### Zone
After a check is declared, each applicable zone should have its own block defined.  This block includes NPCs and triggers that exist for that check.
```
        [xi.zone.NORG] =
        {
            ['Gilgamesh'] =
            {
                onTrigger = function(player, npc)
                    -- Reminder text
                    return mission:event(7)
                end,
            },
        },
```
In the above case, if the check is applicable to the player, and the player is in Norg and interacts with Gilgamesh, event 7 will be executed.

**IMPORTANT:** `onTrigger` events must be returned for the event to be recognized by the framework.

A zone can contain multiple triggers as well!  For example, if you wish to start an event with onTrigger, and then have an onEventFinish from that, it would look something like below:
```
        [xi.zone.KAZHAM] = {
            ['Jakoh_Wahcondalo'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(114)
                end,
            },

            onEventFinish =
            {
                [114] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
```
In this case, if `onTrigger` is called, it will start event 114.  Once event 114 is completed, then `onEventFinish` will pick up 114's end, and execute the function attached to it.

**IMPORTANT:** onEventFinish is not attached to the NPC's sub-section, but rather a part of the zone.  In some cases (such as picking up a BCNM's event), care must be taken to ensure its the _right_ event being triggered.

## Sections Example: Putting it all together
The below example shows an entire sections declaration for a mission containing a single section.  Additional sections can be defined by adding more section blocks to that definition.
```
mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['Gilgamesh'] =
            {
                onTrigger = function(player, npc)
                    -- Reminder text
                    return mission:event(7)
                end,
            },
        },

        [xi.zone.KAZHAM] = {
            ['Jakoh_Wahcondalo'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(114)
                end,
            },

            onEventFinish =
            {
                [114] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}
```

## Return the mission
Finally, the mission or quest object defined must be returned from the file.
```
return mission
```

There are some shortcuts that can be taken with simple commands, and these can be seen in currently implemented quests, missions, and the included documentation.
