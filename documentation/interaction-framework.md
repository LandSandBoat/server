Interaction Framework
===

The common term used for quests and missions in this document and in the code is "containers", since they contain all the things that go into making a quest/mission/etc work.

<!-- TODO: Fix link to proper file in repository -->
See [Some_Example_Quest.lua](https://github.com/) quest file for a full example of how a quest can be defined.


Sections
---

A container/quest/mission is made up of one or more "sections", which are all of the form:
```lua
{
    -- If this "check" function returns true, then this section will be used to determine which action should be taken
    check = function(player, status, questVars, globalVars)
        return status == QUEST_AVAILABLE
    end,

    -- Each section is split into the different zones that each NPC/trigger is in
    [xi.zone.SOME_AREA] = {
        ['Some_NPC'] = {
            onTrigger = function(player, npc)
                return quest:progressEvent(101) -- Quest should progress when this event finishes
            end,
        },

        onEventFinish = {
            [101] = function(player, csid, option, npc)
                -- do something
            end,
        },
    },

    [xi.zone.SOME_OTHER_AREA] = {
        ['Another_NPC'] = {
            -- interactions
        },
    }
}
```

The `check` function is used to determine if the player is in this section of the quest. All matching sections will be run by the framework in order to determine which action it should take for the NPC.

You can use the `questVars` argument to automatically get quest-related variables. For example to get the `Quest[X][Y]Prog` quest variable, all you have to do is dot into the `questVars` table:

```lua
check = function(player, status, questVars, globalVars)
    return status == QUEST_AVAILABLE and questVars.Prog == 0
end,
```

Similarly, the last argument, `globalVars`, can be used to get variables that aren't necessarily related to the quest.

> Note, that this applies to all variables, no matter what name you give them. The framework will automatically fetch the quest variable with the name supplied. If the variable has spaces or other special characters, you can also use the format `questVars['my var']`, which will result in the same outcome for that variable.




Actions
-----

Each NPC function where something is supposed to happen, like `onTrigger` and `onTrade`, should return a special action object, that is used to determine the priority and type of the action the NPC should take. Here's a small list of example actions that the framework supports that can be performed by NPCs:

```lua
-- Start a regular event, not important to any quest progression
quest:event(csid)

-- Start an important event that will progress a quest and will thus be prioritized higher than other actions
quest:progressEvent(csid)

-- Show a message (not event) from the given NPC
quest:message(messageId)

-- Make the priority high enough to always prefer this action over using old NPC the Lua file trigger
quest:replaceMessage(messageId)

-- Play a sequence of actions:
quest:sequence({ text = 11470, wait = 1000 }, { text = 11471, face = 82, wait = 2000 }, { face = 115 }),
-- The above sequence will perform:
--          message 11470, wait 1 second, message 11471, face direction 82, wait 2 seconds, face direction 115
-- (see video of this NPC in action here: https://youtu.be/vwfoYUN-rs8?t=1421)
```


Within a section, there's multiple ways of accomplishing the same action in order to reduce the amount of code needed in places. The examples in the below code segment will result in the same outcome:
```lua
    -- If an NPC has an onTrigger function that just has one action, you can omit everything except the one action:
    ['Some_NPC'] = quest:event(200),

    -- This action can also be accomplished with the following table shorthand (more on this later):
    ['Some_NPC'] = { event = 123 },

    -- If for example, there's also supposed to be another handler besides onTrigger, you can define it specifically on the function:
    ['Some_NPC'] = {
        onTrigger = quest:event(200),
    },

    -- Or fully define the function and return value, when conditionals are needed:
    ['Some_NPC'] = {
        onTrigger = function(player, npc)
            return quest:event(200)
        end,
    },
```


Action modifiers
------

There are several modifiers you can apply to the various types of actions after creating them. They are applied by just calling a function on them, which will alter them and return the new one.
Example of turning a normal event into a progress event:

```lua
quest:event(XXX):progress()
```

List of current modifiers:

```lua
-- Set the action priority to the highest it can be, which means it will always be prioritized
:progress()

-- Perform action with high priority once, then lower priority the following times the NPC is interacted with
:importantOnce()

-- Perform only once every time the player has zoned in
:oncePerZone()

-- Make the action priority high enough to always prefer this action over anything from the old Lua file trigger
:replaceDefault()

-- Only for events: Turn a normal event into a cutscene
quest:event(XXX):cutscene()

-- Only for messages: Make the NPC face a direction or towards a given entity (like the player)
quest:message(YYY):face(player)
```


Action table shorthand
---

An alternative to creating an action from a container object, like `quest:event(XXX)`, is to define the action by providing a table with specific content. This is needed in certain places where a container object is not available, like with default actions.

Possible action shorthand formats are currently:

```lua
-- Event examples:
    { event = 123 }                             == quest:event(123)
    { event = 123, progress = true }            == quest:progressEvent(123)
    { cutscene = 123 }                          == quest:cutscene(123)
    { event = 123, options = { [2] = 555 } }    == quest:event(123, { [2] = 555 })

-- Message examples:
    { text = 456 }          == quest:message(456)
    { message = 456 }       == quest:message(456)

-- Sequence example:
    { { text = 11470, wait = 1000 }, { text = 11471, face = 82, wait = 2000 }, { face = 115 } }
-- The above sequence will perform:
--          message 11470, wait 1 second, message 11471, face direction 82, wait 2 seconds, face direction 115
-- (see video of this NPC in action here: https://youtu.be/vwfoYUN-rs8?t=1421)
```


Container helpers
---------

The container objects come with several more helper functions that helps generalize and abstract away a lot of repeated code, like variable management:
```lua
quest:getVar(player, 'Prog') -- Returns the value for the quest variable 'Prog' for the  player (stored in char_var `Quest[<area>][<id>]Prog`)
quest:setVar(player, 'Prog', value) -- Sets the Prog quest variable for the player

quest:setVarBit(player, 'Prog', 3) -- Sets bit 3 in the Prog quest variable
quest:unsetVarBit(player, 'Prog', 3) -- Unsets bit 3 in the Prog quest variable
quest:isVarBitsSet(player, 'Prog', 1, 3) -- Returns true if the given bits are set in the Prog quest variable (bit 1 and 3 in this case)
```

There can be other helpers too, like on quests and missions:
```lua
quest:begin(player) -- Starts the quest for the player by adding it to their quest log
quest:complete(player) -- Completes the quest for the player, and returns true if succesful
```




Handlers
---

Below is a more-exhaustive mock example of how a section can be set up, and it tries to show and document the various handlers that can be added in the different places of a section:
```lua
{
    -- If this "check" function returns true, this section will be used to determine which action should be taken
    check = function(player, status, vars)
        return status == QUEST_AVAILABLE and vars.Prog == 0
    end,

    -- Each section is split into the different zones that each NPC/trigger is in
    [xi.zone.SOME_AREA] = {

        -- NPCs are indexed by their handlers like `onTrade`, `onTrigger`, etc
        ['Some_NPC_Name'] = {
            onTrigger = function(player, npc)
                if player:getFreeSlotsCount() > 0 then
                    return quest:progressEvent(101) -- Quest will progress when this event finishes
                else
                    return quest:event(100) -- Quest-related event, like a reminder of something related to the quest
                end
            end,

            onTrade = function(player, npc, trade)
                if npcUtil.tradeHasExactly(trade, xi.items.SOME_ITEM) then
                    return quest:progressEvent(111)
                end
            end,
        },

        -- onEventFinish is indexed by the event/cutscene ID
        onEventFinish = {
            [101] = function(player, csid, option, npc)
                quest:setVar(player, 'Prog', 1)
            end,

            [111] = function(player, csid, option, npc)
                quest:setVar(player, 'Prog', 2)
            end,
        },

        -- onRegionEnter is indexed by the triggering region ID
        onRegionEnter = {
            [2] = function(player, csid, option, npc)
                quest:setVar(player, 'Prog', 3)
            end,
        },
    },

    [xi.zone.SOME_OTHER_AREA] = {

        -- onZoneIn needs to have only one entry that will handle all the different cases,
        -- and should return the event ID to be played if any
        onZoneIn = {
            function(player, prevZone)
                return 543
            end,
        },
    }
}
```



Default actions
----

In order to properly prioritize quest/mission events over default dialogue from NPCs, and to avoid ending up with a lot of NPC lua files that just do one thing, it is possible to define the default action for NPCs in the framework. These will automatically be prioritized lower than normal actions of that type, such that quest/mission dialogue will always take precedence.

These default actions can be defined by creating a `DefaultActions.lua` file in the corresponding zone folder, and adding the actions using the short-hand method for them:

```lua
local ID = require("scripts/zones/Northern_San_dOria/IDs")

return {
    ['Ailbeche'] = { event = 868 },
    ['Maurinne'] = { text = ID.text.MAURINNE_DIALOG },
}
```


Framework internals
----

<!-- TODO: Fix link to proper file in repository -->
Add the container/quest/mission as an entry in [`interaction_containers.lua`](https://github.com/), and the handlers from the quest file will automatically be hooked up to the NPCs and zones.

Since the framework has to be backwards-compatible with existing quest logic in each NPC/zone file, it will prioritize the different events/triggers generally as follows:

1. Start priority events from this interaction framework
2. Switch between regular events from the interaction framework, and running the corresponding function in the NPC/zone lua file.
3. Default actions from the framework, if the NPC/zone lua did not do anything.



Commands
----

Reloads the specified quest. Note that it has to match exactly the name used in `interaction_containers.lua` (it's case sensitive):
```
!reloadquest Three_Men_and_a_Closet
```

Prints the `Prog` quest variable for the given quest:
```
!checkquestvar TOAU THREE_MEN_AND_A_CLOSET Prog
```

Prints the bits set in the `Prog` quest variable for the given quest:
```
!checkquestbits TOAU ARTS_AND_CRAFTS Prog
```
