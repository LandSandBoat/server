-----------------------------------
-- Black Market
-----------------------------------
-- Log ID: 5, Quest ID: 130
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.BLACK_MARKET)

quest.reward =
{
    fameArea = xi.quest.fame_area.NORG,
    fame = 50,
    title = xi.title.BLACK_MARKETEER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.NORG] =
        {
            ['Muzaffar'] = quest:progressEvent(15),

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NORG] =
        {
            ['Muzaffar'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:event(16)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.items.NORTHERN_FUR, 4 } }) then
                        return quest:progressEvent(17, 1199, 1199)
                    elseif npcUtil.tradeHasExactly(trade, { { xi.items.PIECES_OF_EASTERN_POTTERY, 4 } }) then
                        return quest:progressEvent(18, 1200, 1200)
                    elseif npcUtil.tradeHasExactly(trade, { { xi.items.SOUTHERN_MUMMY, 4 } }) then
                        return quest:progressEvent(19, 1201, 1201)
                    end
                end,
            },

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        npcUtil.giveCurrency(player, 'gil', 1500)
                        player:needToZone(true)
                    end
                end,

                [18] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        npcUtil.giveCurrency(player, 'gil', 2000)
                        player:needToZone(true)
                    end
                end,

                [19] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        npcUtil.giveCurrency(player, 'gil', 3000)
                        player:needToZone(true)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.NORG] =
        {
            ['Muzaffar'] =
            {
                onTrigger = function(player, npc)
                    if not player:needToZone() then
                        return quest:progressEvent(15)
                    else return quest:event(20)
                    end
                end,
            },

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.BLACK_MARKET)
                        quest:begin(player)
                    end
                end,
            },
        },
    },
}

return quest
