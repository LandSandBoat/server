-----------------------------------
-- A Lady's Heart
-----------------------------------
-- Log ID: 1, Quest ID: 50
-- Valah Molkot : !pos 59 8 -221 236
-----------------------------------
local portBastokID = zones[xi.zone.PORT_BASTOK]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_LADYS_HEART)

quest.reward =
{
    fame     = 120,
    fameArea = xi.quest.fame_area.BASTOK,
}

local flowerItems =
{
    xi.item.AMARYLLIS,
    xi.item.ASPHODEL,
    xi.item.CARNATION,
    xi.item.CASABLANCA,
    xi.item.CATTLEYA,
    xi.item.CHAMOMILE,
    xi.item.DAHLIA,
    xi.item.FLAX_FLOWER,
    xi.item.LILAC,
    xi.item.LYCOPODIUM_FLOWER,
    xi.item.MARGUERITE,
    xi.item.OLIVE_FLOWER,
    xi.item.PAPAKA_GRASS,
    xi.item.PHALAENOPSIS,
    xi.item.RAIN_LILY,
    xi.item.RED_ROSE,
    xi.item.SNOW_LILY,
    xi.item.SWEET_WILLIAM,
    xi.item.TAHRONGI_CACTUS,
    xi.item.WATER_LILY,
    xi.item.WIJNRUIT,
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
                    if npcUtil.tradeHasExactly(trade, xi.item.AMARYLLIS) then
                        return quest:progressEvent(160, 0, 236, 2)
                    elseif isTradeInTable(trade, flowerItems) then
                        return quest:progressEvent(160, 0, 236, 1)
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
                    -- 10   : Cancel/Exit event option.
                    -- 2002 : Amaryllis was traded

                    -- Correct trade option (Amaryllis).
                    if option == 2002 then
                        if quest:complete(player) then
                            player:confirmTrade()
                            local mhflag = player:getMoghouseFlag()
                            player:setMoghouseFlag(mhflag + 0x0002)
                            player:messageSpecial(portBastokID.text.MOGHOUSE_EXIT)
                        end

                    else
                        if option == 1 then
                            player:confirmTrade()
                        end

                        if player:getQuestStatus(quest.areaId, quest.questId) == QUEST_AVAILABLE then
                            quest:begin(player)
                        end
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

                    if npcUtil.tradeHasExactly(trade, xi.item.AMARYLLIS) then
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
