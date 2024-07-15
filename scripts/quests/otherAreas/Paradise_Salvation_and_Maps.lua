-----------------------------------
-- Paradise, Salvation, and Maps
-----------------------------------
-- Log ID: 4, Quest ID: 68
-- Nivorajean     : !gotoid 16883781
-- Treasure Chest : !gotoid 16892183
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.PARADISE_SALVATION_AND_MAPS)

quest.reward =
{
    gil = 2000,
    xp  = 2000,
    ki  = xi.ki.MAP_OF_THE_SACRARIUM,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
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

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Nivorajean'] =
            {
                onTrigger = function(player, npc)
                    local selection = quest:getVar(player, 'Selection') or 0
                    local gameDay = quest:getVar(player, 'GameDay') or 0
                    local chest = quest:getVar(player, 'Chest') or 0

                    if
                        player:hasKeyItem(xi.ki.PIECE_OF_RIPPED_FLOORPLANS) and
                        gameDay == 0 -- don't allow turn in when we're waiting for results
                    then
                        return quest:progressEvent(225, { [0] = chest - 1 }) -- turn in
                    elseif
                        VanadielUniqueDay() == gameDay
                    then
                        return quest:progressEvent(226) -- player must wait until next game day
                    elseif
                        selection == 2 and
                        gameDay > 0 and
                        VanadielUniqueDay() ~= gameDay
                    then
                        return quest:progressEvent(227) -- player selected the wrong location
                    elseif
                        selection == 1 and
                        gameDay > 0 and
                        VanadielUniqueDay() ~= gameDay
                    then
                        return quest:progressEvent(228) -- Correct answer, complete quest
                    else
                        return quest:progressEvent(224) -- repeat dialog until player has Ripped Floorplans
                    end
                end,
            },

            onEventFinish =
            {
                [225] = function(player, csid, option, npc)
                    -- Turned in floor plans, and record correctness and game day
                    player:delKeyItem(xi.ki.PIECE_OF_RIPPED_FLOORPLANS)
                    quest:setVar(player, 'Selection', option + 1)
                    quest:setVar(player, 'GameDay', VanadielUniqueDay())
                end,

                [227] = function(player, csid, option, npc)
                    -- Clear all vars after being informed their selection was incorrect. Need to get KI again.
                    quest:setVar(player, 'Selection', 0)
                    quest:setVar(player, 'GameDay', 0)
                    quest:setVar(player, 'Chest', 0)
                end,

                [228] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
