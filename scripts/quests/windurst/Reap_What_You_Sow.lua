-----------------------------------
-- Reap What You sow
-----------------------------------
-- !addquest 2 29
-- Mashuu-Ajuu 130 -5 167
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require('scripts/zones/Windurst_Waters/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.REAP_WHAT_YOU_SOW)

quest.reward =
{
    gil = 700,
    fame = 75,
    fameArea = xi.quest.fame_area.WINDURST,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Mashuu-Ajuu'] =
            {
                onTrigger = function(player, npc)
                    if player:getFameLevel(xi.quest.fame_area.WINDURST) >= 4 then
                        return quest:progressEvent(483)
                    else
                        return quest:progressEvent(463, 0, 4565, xi.items.BAG_OF_HERB_SEEDS)
                    end
                end,
            },

            onEventFinish =
            {
                [463] = function(player, csid, option, npc)
                    if player:getFreeSlotsCount() == 0 then
                        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.BAG_OF_HERB_SEEDS)
                    else
                        if option == 3 then
                            npcUtil.giveItem(player, xi.items.BAG_OF_HERB_SEEDS)
                            quest:begin(player)
                        end
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Mashuu-Ajuu'] =
            {
                onTrigger = function(player, npc)
                    local rand = math.random()

                    if rand > 0.5 then
                        return quest:progressEvent(464, 0, 4565, xi.items.BAG_OF_HERB_SEEDS)
                    else
                        return quest:progressEvent(476)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if trade:getItemCount() == 1 then
                        if (trade:hasItemQty(4565, 1) == true) then
                            return quest:progressEvent(475, 500, 131) -- Sobbing Fungus
                        elseif (trade:hasItemQty(4566, 1) == true) then
                            return quest:progressEvent(477, 700) -- Deathball
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [475] = function(player, csid, option, npc)
                    player:tradeComplete()

                    if player:getFreeSlotsCount() == 0 then
                        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.STATIONERY_SET)
                    else
                        player:addGil(500)
                        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.main.GIL_RATE * 500)
                        npcUtil.giveItem(player, xi.items.STATIONERY_SET)
                        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.STATIONERY_SET)
                    end
                end,

                [477] = function(player, csid, option, npc)
                    player:tradeComplete()

                    if player:getFreeSlotsCount() == 0 then
                        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.STATIONERY_SET)
                    else
                        npcUtil.giveItem(player, xi.items.STATIONERY_SET)
                        quest:complete(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
            player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.LET_SLEEPING_DOGS_LIE)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Mashuu-Ajuu'] =
            {
                onTrigger = function(player, npc)
                    local rand = math.random()

                    if rand > 0.5 then
                        return quest:progressEvent(464, 0, 4565, xi.items.BAG_OF_HERB_SEEDS)
                    else
                        player:startEvent(476)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if trade:getItemCount() == 1 then
                        if (trade:hasItemQty(4565, 1) == true) then
                            player:startEvent(475, 500, 131) -- Sobbing Fungus
                        elseif (trade:hasItemQty(4566, 1) == true) then
                            player:startEvent(477, 700) -- Deathball
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [475] = function(player, csid, option, npc)
                    player:tradeComplete()

                    if player:getFreeSlotsCount() == 0 then
                        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.STATIONERY_SET)
                    else
                        player:addGil(500)
                        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.main.GIL_RATE * 500)
                        npcUtil.giveItem(player, xi.items.STATIONERY_SET)
                    end
                end,

                [477] = function(player, csid, option, npc)
                    player:tradeComplete()

                    if player:getFreeSlotsCount() == 0 then
                        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.STATIONERY_SET)
                    else
                        player:addGil(500)
                        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.main.GIL_RATE * 500)
                        npcUtil.giveItem(player, xi.items.STATIONERY_SET)
                    end
                end,
            },
        },
    },
}

return quest
