-----------------------------------
-- The Antique Collector
-----------------------------------
-- !addquest 3 25
-- Imasuke : !gotoid 17784840
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/items')
require("scripts/globals/keyitems")
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/status')
require('scripts/globals/titles')
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_ANTIQUE_COLLECTOR)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    keyitem  = xi.ki.MAP_OF_DELKFUTTS_TOWER,
    title    = xi.title.TRADER_OF_ANTIQUITIES,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.JEUNO) >= 3
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Imasuke'] = quest:progressEvent(13),

            onEventFinish =
            {
                [13] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    else
                        quest:setVar(player, 'Option', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Imasuke'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(14)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.KAISER_SWORD) then
                        return quest:progressEvent(15)
                    end
                end,
            },

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MAP_OF_DELKFUTTS_TOWER)
                    end
                end,
            },
        },
    },
}

return quest
