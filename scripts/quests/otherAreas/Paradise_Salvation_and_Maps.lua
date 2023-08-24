-----------------------------------
-- Paradise, Salvation, and Maps
-----------------------------------
-- Log ID: 4, Quest ID: 68
-- Nivorajean   : !pos 15.890 -22 13.322
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/treasure')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local tavnaziaID = require('scripts/zones/Tavnazian_Safehold/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.PARADISE_SALVATION_AND_MAPS)

quest.reward =
{
    gil = 2000,
    xp  = 2000,
    ki  = xi.ki.MAP_OF_THE_SACRARIUM,
}

quest.sections =
{
    -- START: Talk to Nivorajean
    -- QUEST AVAILABLE
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SAVAGE)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Nivorajean'] = quest:progressEvent(223),

            onEventFinish =
            {
                [223] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- QUEST ACCEPTED
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Nivorajean'] =
            {
                onTrigger = function(player, npc)
                    local selection = quest:getVar(player, "Selection") or 0
                    local gameDay = quest:getVar(player, "GameDay") or 0
                    local chest = quest:getVar(player, "Chest") or 0

                    if
                        player:hasKeyItem(xi.ki.PIECE_OF_RIPPED_FLOORPLANS)
                    then
                        -- Turning in the Key Item
                        if chest == 0 then
                            player:PrintToPlayer("WARNING: Your variables for this quest are broken. Please contact a GM.")
                        else
                            return quest:progressEvent(225, { [0] = chest - 1 })
                        end
                    elseif
                        VanadielUniqueDay() == gameDay
                    then
                        -- Still same gameday as when it was turned in
                        return quest:event(226)
                    elseif
                        selection == 2 and
                        gameDay > 0 and
                        VanadielUniqueDay() ~= gameDay
                    then
                        -- Game day has passed, but it was the wrong map location suggested
                        return quest:progressEvent(227)
                    elseif
                        selection == 1 and
                        gameDay > 0 and
                        VanadielUniqueDay() ~= gameDay
                    then
                        -- Success! Selected the correct location for the map
                        return quest:progressEvent(228)
                    elseif
                        selection == 0 and
                        gameDay == 0 and
                        chest == 0
                    then
                        -- "Repeating" quest after failing the previous attempt
                        return quest:event(227)
                    end
                end,
            },

            onEventFinish =
            {
                [225] = function(player, csid, option, npc)
                    -- Turned in KI of floor plans, made selection of which ID
                    player:delKeyItem(xi.ki.PIECE_OF_RIPPED_FLOORPLANS)
                    quest:messageSpecial(player, tavnaziaID.text.KEYITEM_OBTAINED + 1, xi.ki.PIECE_OF_RIPPED_FLOORPLANS)
                    quest:setVar(player, "Selection", option + 1)
                    quest:setVar(player, "GameDay", VanadielUniqueDay())
                end,

                [227] = function(player, csid, option, npc)
                    -- Clear all vars after being informed their selection was incorrect.  Need to get KI again.
                    quest:setVar(player, "Selection", 0)
                    quest:setVar(player, "GameDay", 0)
                    quest:setVar(player, "Chest", 0)
                end,

                [228] = function(player, csid, option, npc)
                    -- Quest was successful - mark complete
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
