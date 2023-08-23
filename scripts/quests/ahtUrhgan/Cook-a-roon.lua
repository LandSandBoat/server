-----------------------------------
-- Cook-a-roon
-- Ququroon !pos -2.400 -1 66.824 53
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.COOK_A_ROON)

quest.sections =
{
    -- Setion: Quest available
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.NASHMAU] =
        {
            ['Ququroon'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(241)
                end,
            },

            onEventFinish =
            {
                [241] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NASHMAU] =
        {
            ['Ququroon'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(242)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.item.AHTAPOT, xi.item.ISTAKOZ, xi.item.ISTAVRIT, xi.item.ISTIRIDYE, xi.item.MERCANBALIGI }) then
                        quest:setVar(player, 'Prog', math.random(2, 3))
                        return quest:progressEvent(243, { [7] = quest:getVar(player, 'Prog') })
                    end
                end,
            },

            onEventFinish =
            {
                [243] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        npcUtil.giveItem(player, xi.item.BOWL_OF_NASHMAU_STEW)
                    end

                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },

    -- Section: Quest complete
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.NASHMAU] =
        {
            ['Ququroon'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.item.AHTAPOT, xi.item.ISTAKOZ, xi.item.ISTAVRIT, xi.item.ISTIRIDYE, xi.item.MERCANBALIGI }) then
                        quest:setVar(player, 'Prog', math.random(2, 3))
                        return quest:progressEvent(243, { [7] = quest:getVar(player, 'Prog') })
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(244)
                end,
            },

            onEventUpdate =
            {
                [243] = function(player, csid, option, npc)
                    player:confirmTrade()
                    if quest:getVar(player, 'Prog') == 2 then
                        npcUtil.giveItem(player, xi.item.BOWL_OF_NASHMAU_STEW)
                    end

                    quest:setVar(player, 'Prog', 0)
                end,
            },
        },
    },
}

return quest
