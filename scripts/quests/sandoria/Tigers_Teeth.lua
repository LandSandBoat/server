-----------------------------------
-- Tigers Teeth
-----------------------------------
-- LogID: 0 QuestID: 23
-- Taukila : !pos -140 -6 -8 230
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.TIGERS_TEETH)

quest.reward =
{
    gil   = 2100,
    title = xi.title.FANG_FINDER,
    fame  = 30,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.SANDORIA) >= 3
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Taumila'] = quest:progressEvent(574),

            onEventFinish =
            {
                [574] = function(player, csid, option, npc)
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

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Taumila'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.BLACK_TIGER_FANG, 3 } }) then
                        return quest:progressEvent(572)
                    elseif npcUtil.tradeHas(trade, xi.item.BLACK_TIGER_FANG) then
                        return quest:event(573)
                    end
                end,

                onTrigger = quest:event(575):replaceDefault(),
            },

            onEventFinish =
            {
                [572] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Taumila'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.BLACK_TIGER_FANG, 3 } }) then
                        quest:setLocalVar(player, 'Option', 1)
                        return quest:progressEvent(572)
                    elseif npcUtil.tradeHas(trade, xi.item.BLACK_TIGER_FANG) then
                        return quest:event(573)
                    end
                end,

                onTrigger = quest:event(571):replaceDefault(),
            },

            onEventFinish =
            {
                [572] = function(player, csid, option, npc)
                    if
                        quest:getLocalVar(player, 'Option') == 1 and
                        npcUtil.giveCurrency(player, 'gil', 2100)
                    then
                        quest:setLocalVar(player, 'Option', 0)
                        player:confirmTrade()
                        player:addFame(xi.fameArea.SANDORIA, 5)
                    end
                end,
            },
        },
    },
}

return quest
