-----------------------------------
-- Glyph Hanger
-----------------------------------
-- !addquest 2 30
-- Hariga-Origa : !pos -62 -6 105 238
-- Ipupu        : !pos 251.745 -5.5 35.539 115
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.GLYPH_HANGER)

quest.reward =
{
    item = xi.items.LEATHER_RING,
    fame = 25,
    fameArea = xi.quest.fame_area.WINDURST,
    keyItem = xi.ki.MAP_OF_THE_HORUTOTO_RUINS,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Paytah'] = quest:progressEvent(291),

            onEventFinish =
            {
                [291] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.NOTE_FROM_HARIGA_ORIGA)
                    npcUtil.giveKeyItem(player, xi.ki.NOTE_FROM_IPUPU)
                end,
            },
        }
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Baren-Moren'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'Prog') == 0 then
                        if trade:hasItemQty(xi.items.RIPPED_CAP, 1) and trade:getItemCount() == 1 then
                            return quest:progressEvent(0)
                        end
                    elseif quest:getVar(player, 'Prog') == 1 then
                        if trade:hasItemQty(xi.items.DHALMEL_HIDE, 4) and trade:getItemCount() == 1 then
                            return quest:progressEvent(0)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'Prog', 1)
                end,

                [1] = function(player, csid, option, npc)
                    player:tradeComplete()
                    npcUtil.addItem(player, xi.items.DHALMEL_MANTLE)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Paytah'] =
            {
                onTrade = function(player, npc, trade)
                    if trade:hasItemQty(xi.items.SAILORS_CAP, 1) and trade:getItemCount() == 1 then
                        return quest:progressEvent(0)
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
