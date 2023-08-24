-----------------------------------
-- All at Sea
-----------------------------------
-- !addquest 2 23
-- Paytah !pos 77 -5 117
-- Baren-Moren !pos -66 -2 -145
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ALL_AT_SEA)

quest.reward =
{
    item = xi.items.LEATHER_RING,
    fame = 30,
    fameArea = xi.quest.fame_area.WINDURST,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getFameLevel(xi.quest.fame_area.WINDURST) >= 3
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Paytah'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(291)
                end,

                onTrade = function(player, npc, trade)
                    if trade:hasItemQty(xi.items.RIPPED_CAP, 1) and trade:getItemCount() == 1 then
                        return quest:progressEvent(292)
                    end
                end,
            },

            onEventFinish =
            {
                [292] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Paytah'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(293)
                end,

                onTrade = function(player, npc, trade)
                    if trade:hasItemQty(xi.items.SAILORS_CAP, 1) and trade:getItemCount() == 1 and quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(295)
                    end
                end,
            },

            onEventFinish =
            {
                [295] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Baren-Moren'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(548, 0, xi.items.DHALMEL_HIDE)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if trade:hasItemQty(xi.items.RIPPED_CAP, 1) and trade:getItemCount() == 1 and quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(547, 0, xi.items.DHALMEL_HIDE)
                    elseif trade:hasItemQty(xi.items.DHALMEL_HIDE, 4) and trade:getItemCount() == 4 and quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(549)
                    end
                end,
            },

            onEventFinish =
            {
                [547] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'Prog', 1)
                end,
                [549] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'Prog', 2)
                    npcUtil.giveItem(player, xi.items.SAILORS_CAP)
                    npcUtil.giveItem(player, xi.items.DHALMEL_MANTLE)
                end,
            },
        },
    },
}

return quest
