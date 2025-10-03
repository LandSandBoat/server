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
