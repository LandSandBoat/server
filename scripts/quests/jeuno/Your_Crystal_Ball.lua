-----------------------------------
-- Your Crystal Ball
-----------------------------------
-- Log ID: 3, Quest ID: 9
-- Kurou-Morou : !pos -4 -6 -28 245
-- Rockwell    : !pos -18 -13 181 198
-----------------------------------
local mazeID = zones[xi.zone.MAZE_OF_SHAKHRAMI]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.YOUR_CRYSTAL_BALL)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.JEUNO,
    title    = xi.title.FORTUNE_TELLER_IN_TRAINING,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getFameLevel(xi.fameArea.JEUNO) >= 2
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Kurou-Morou'] = quest:progressEvent(194),

            onEventFinish =
            {
                [194] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
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
                    return quest:event(191) -- Reminder
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        npcUtil.tradeHasExactly(trade, xi.item.DIVINATION_SPHERE)
                    then
                        return quest:progressEvent(196)
                    end
                end,
            },

            onEventFinish =
            {
                [196] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },

        [xi.zone.MAZE_OF_SHAKHRAMI] =
        {
            ['Rockwell'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        if GetSystemTime() >= quest:getVar(player, 'Wait') + 60 then -- 1 minute wait time
                            return quest:progressEvent(52)
                        else
                            return quest:messageSpecial(mazeID.text.WAIT_A_BIT_LONGER, 0, xi.item.DIVINATION_SPHERE)
                        end
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.AHRIMAN_LENS) then
                        local progress = quest:getVar(player, 'Prog')
                        if progress == 0 then
                            player:confirmTrade()
                            quest:setVar(player, 'Prog', 1)
                            quest:setVar(player, 'Wait', GetSystemTime() + 60)
                            return quest:messageSpecial(mazeID.text.SUBMERGED_ITEM, xi.item.AHRIMAN_LENS)
                        elseif progress == 1 then
                            return quest:messageSpecial(mazeID.text.MORE_THAN_ONE, xi.item.AHRIMAN_LENS)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [52] = function(player, csid, option, npc)
                    if player:getFreeSlotsCount() ~= 0 then
                        quest:setVar(player, 'Prog', 2)
                        player:addItem(xi.item.DIVINATION_SPHERE)
                    else
                        player:messageSpecial(mazeID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.DIVINATION_SPHERE)
                    end
                end,
            },
        },
    },
}

return quest
