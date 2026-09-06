-----------------------------------
-- Never to Return
-----------------------------------
-- Log ID: 3, Quest ID: 14
-- Kurou-Morou : !pos -4 -6 -28 245
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.NEVER_TO_RETURN)

quest.reward =
{
    gil  = 1200,
    item = xi.item.GARNET_RING,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.YOUR_CRYSTAL_BALL)
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Kurou-Morou'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') >= 3 and
                        quest:getVar(player, 'Day') ~= VanadielUniqueDay() and
                        player:getFameLevel(xi.fameArea.JEUNO) >= 5
                    then
                        return quest:progressEvent(202) -- Quest offered
                    end

                    return quest:event(204) -- Fortune reading
                end,
            },

            onEventUpdate =
            {
                [204] = function(player, csid, option, npc)
                    player:updateEvent((VanadielUniqueDay() + player:getID()) % 100)
                end,
            },

            onEventFinish =
            {
                [202] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,

                [204] = function(player, csid, option, npc)
                    if
                        option == 0 and
                        quest:getVar(player, 'Day') ~= VanadielUniqueDay()
                    then
                        quest:setVar(player, 'Prog', quest:getVar(player, 'Prog') + 1)
                        quest:setVar(player, 'Day', VanadielUniqueDay())
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Kurou-Morou'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(203) -- Reminder
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeMatches(trade, { { xi.item.HORN_HAIRPIN, 1 } }) then
                        return quest:progressEvent(201) -- Quest complete
                    end
                end,
            },

            onEventFinish =
            {
                [201] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        player:addFame(xi.fameArea.SANDORIA, 17)
                        player:addFame(xi.fameArea.BASTOK, 17)
                        player:addFame(xi.fameArea.WINDURST, 17)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Kurou-Morou'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(204) -- Fortune reading
                end,
            },

            onEventUpdate =
            {
                [204] = function(player, csid, option, npc)
                    player:updateEvent((VanadielUniqueDay() + player:getID()) % 100)
                end,
            },
        },
    },
}

return quest
