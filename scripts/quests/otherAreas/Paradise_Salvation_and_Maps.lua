-----------------------------------
-- Paradise Salvation and Maps
-----------------------------------
-- Log ID: 4, Quest ID: 68
-- Nivorajean : !pos 16.712 -22.000 12.552
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.PARADISE_SALVATION_AND_MAPS)

quest.reward =
{
    exp     = 2000,
    gil     = 2000,
    keyItem = xi.ki.MAP_OF_THE_SACRARIUM,
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

        [xi.zone.SACRARIUM] =
        {
            ['Treasure_Chest' ] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Option') == 0 and
                        not player:hasKeyItem(xi.keyItem.PIECE_OF_RIPPED_FLOORPLANS)
                    then
                        xi.treasure.onTrade(player, npc, trade, 2, xi.keyItem.PIECE_OF_RIPPED_FLOORPLANS)

                        local chestTable =
                        {
                            [1] = {  31.021, -2.000,   99.013 }, -- (F-5)
                            [2] = {  89.034, -2.000,   99.248 }, -- (H-5)
                            [3] = {  88.223, -2.000,  -36.017 }, -- (H-9)
                            [4] = { 177.600,  8.310,  100.000 }, -- (J-6)
                            [5] = { 179.709, -7.693,  -97.007 }, -- (J-10)
                            [6] = { 260.391,  0.000,   21.487 }, -- (L-8)
                            [7] = { 111.451, -2.000, -100.159 }, -- (H-11)
                            [8] = {   8.974, -2.179, -133.075 }, -- (F-11)
                        }

                        for i = 1, #chestTable do
                            if player:checkDistance(chestTable[i][1], chestTable[i][2], chestTable[i][3]) < 2 then
                                quest:setVar(player, 'Option', i)
                                break
                            end
                        end

                        return quest:noAction()
                    end
                end,
            },
        },

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Nivorajean'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')
                    local wait     = quest:getVar(player, 'Wait')

                    if player:hasKeyItem(xi.keyItem.PIECE_OF_RIPPED_FLOORPLANS) then
                        return quest:progressEvent(225, quest:getVar(player, 'Option') - 1)
                    elseif
                        wait ~= VanadielUniqueDay() and
                        progress > 0
                    then
                        if progress == 2 then
                            return quest:progressEvent(228) -- Correct Coordinates Selected
                        else
                            return quest:progressEvent(227) -- Wrong Corrdinates Selected
                        end
                    elseif wait == VanadielUniqueDay() then
                        return quest:event(226) -- Wait Longer
                    else
                        return quest:event(224) -- Reminder
                    end
                end,
            },

            onEventFinish =
            {
                [225] = function(player, csid, option, npc)
                    quest:setVar(player, 'Wait', VanadielUniqueDay())
                    player:delKeyItem(xi.keyItem.PIECE_OF_RIPPED_FLOORPLANS)
                    quest:setVar(player, 'Option', 0)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 2) -- Correct Coordinates Selected
                    else
                        quest:setVar(player, 'Prog', 1) -- Wrong Coordinates Selected
                    end
                end,

                [227] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 0)
                    quest:setVar(player, 'Wait', 0)
                end,

                [228] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Nivorajean'] = quest:event(382), -- Cycles with whatever his current default action is
        },
    },
}

return quest
