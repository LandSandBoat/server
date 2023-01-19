-----------------------------------
-- Growing Flowers
-----------------------------------
-- Log ID: 0, Quest ID: 58
-- Kuu Mohzolhi : !pos -123 0 80 231
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local northenSandoriaID = require('scripts/zones/Northern_San_dOria/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GROWING_FLOWERS)

quest.reward =
{
    fame     = 120,
    fameArea = xi.quest.fame_area.SANDORIA,
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

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Kuu_Mohzolhi'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.MARGUERITE) then
                        return quest:progressEvent(605, 0, 231, 2)
                    elseif isTradeInTable(trade, flowerItems) then
                        return quest:progressEvent(605, 0, 231, 1)
                    else
                        return quest:progressEvent(605, 0, 231, 0)
                    end
                end,

                onTrigger = quest:progressEvent(605, 0, 231, 10),
            },

            onEventFinish =
            {
                [605] = function(player, csid, option, npc)
                    -- Three possible event options are returned from the above triggers:
                    -- 0    : Invalid Item was traded
                    -- 1    : Valid Item was traded
                    -- 10   : Cancel/Exit event option.
                    -- 1002 : Marguerite was traded

                    -- Correct trade option (Marguerite).
                    if option == 1002 then
                        if quest:complete(player) then
                            player:confirmTrade()
                            local mhflag = player:getMoghouseFlag()
                            player:setMoghouseFlag(mhflag + 0x0001)
                            player:messageSpecial(northenSandoriaID.text.MOGHOUSE_EXIT)
                        end

                    else
                        -- Confirm trade if there was a trade.
                        if option == 1 then
                            player:confirmTrade()
                        end

                        -- Start quest if it wasn't.
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

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Kuu_Mohzolhi'] =
            {
                onTrade = function(player, npc, trade)
                    -- NOTE: After completing this quest, trade is not consumed.

                    if npcUtil.tradeHasExactly(trade, xi.items.MARGUERITE) then
                        return quest:progressEvent(605, 0, 231, 4)
                    elseif isTradeInTable(trade, flowerItems) then
                        return quest:progressEvent(605, 0, 231, 5)
                    else
                        return quest:progressEvent(605, 0, 231, 0)
                    end
                end,

                onTrigger = quest:progressEvent(605, 0, 231, 10),
            },
        },
    },
}

return quest
