-----------------------------------
-- The Rumor
-----------------------------------
-- !addquest 0 61
-- Novalmauge: !gotoid 17461510
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
local ID = require("scripts/zones/Bostaunieux_Oubliette/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_RUMOR)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    item = xi.items.SCROLL_OF_DRAIN,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 3 and
            player:getMainLvl() >= 10
        end,

        [xi.zone.BOSTAUNIEUX_OUBLIETTE] =
        {
            ['Novalmauge'] = quest:progressEvent(13),

            onEventUpdate =
            {
                [13] = function(player, csid, option, npc)
                    if option == 0 then
                        player:updateEvent(13, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [13] = function(player, csid, option, npc)
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

        [xi.zone.BOSTAUNIEUX_OUBLIETTE] =
        {
            ['Novalmauge'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.VIAL_OF_BEASTMAN_BLOOD) then
                        return quest:progressEvent(12)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(11)
                end,
            },

            onEventFinish =
            {
                [12] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.BOSTAUNIEUX_OUBLIETTE] =
        {
            ['Novalmauge'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(14):replaceDefault()
                end,
            },
        },
    },
}

return quest
