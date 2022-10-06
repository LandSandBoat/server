-----------------------------------
-- A Lady's Heart
-----------------------------------
-- Log ID: 1, Quest ID: 50
-- Valah Molkot : !pos 59 8 -221 236
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local portBastokID = require('scripts/zones/Port_Bastok/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_LADYS_HEART)

quest.reward =
{
    fame     = 120,
    fameArea = xi.quest.fame_area.BASTOK,
}

local flowerItems =
{
    xi.items.AMARYLLIS,
    xi.items.ASPHODEL,
    xi.items.CARNATION,
    xi.items.CASABLANCA,
    xi.items.CATTLEYA,
    xi.items.CHAMOMILE,
    xi.items.DAHLIA,
    xi.items.FLAX_FLOWER,
    xi.items.LILAC,
    xi.items.LYCOPODIUM_FLOWER,
    xi.items.MARGUERITE,
    xi.items.OLIVE_FLOWER,
    xi.items.PAPAKA_GRASS,
    xi.items.PHALAENOPSIS,
    xi.items.RAIN_LILY,
    xi.items.RED_ROSE,
    xi.items.SNOW_LILY,
    xi.items.SWEET_WILLIAM,
    xi.items.TAHRONGI_CACTUS,
    xi.items.WATER_LILY,
    xi.items.WIJNRUIT,
}

local function isTradeInTable(trade, itemTable)
    for _, itemId in ipairs(itemTable) do
        if npcUtil.tradeHasExactly(trade, itemId) then
            return true
        end
    end

    return false
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status ~= QUEST_COMPLETED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Valah_Molkot'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.AMARYLLIS) then
                        return quest:progressEvent(160, 0, 236, 2)
                    elseif isTradeInTable(trade, flowerItems) then
                        local acceptedParam = player:getQuestStatus(quest.areaId, quest.questId) == QUEST_ACCEPTED and 3 or 1

                        return quest:progressEvent(160, 0, 236, acceptedParam)
                    else
                        return quest:progressEvent(160, 0, 236, 0)
                    end
                end,

                onTrigger = quest:progressEvent(160, 0, 236, 10),
            },

            onEventFinish =
            {
                [160] = function(player, csid, option, npc)
                    -- Three possible event options are returned from the above triggers:
                    -- 0    : Invalid Item was traded
                    -- 1    : Valid Item was traded
                    -- 2002 : Amaryllis was traded

                    if option > 0 then
                        player:confirmTrade()
                    end

                    if option == 2002 then
                        if quest:complete(player) then
                            player:setMoghouseFlag(2)
                            player:messageSpecial(portBastokID.text.MOGHOUSE_EXIT)
                        end
                    elseif player:getQuestStatus(quest.areaId, quest.questId) == QUEST_AVAILABLE then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Valah_Molkot'] =
            {
                onTrade = function(player, npc, trade)
                    -- NOTE: After completing this quest, trade is not consumed.

                    if npcUtil.tradeHasExactly(trade, xi.items.AMARYLLIS) then
                        return quest:progressEvent(160, 0, 236, 4)
                    elseif isTradeInTable(trade, flowerItems) then
                        return quest:progressEvent(160, 0, 236, 5)
                    else
                        return quest:progressEvent(160, 0, 236, 0)
                    end
                end,

                onTrigger = quest:progressEvent(160, 0, 236, 10),
            },
        },
    },
}

return quest
