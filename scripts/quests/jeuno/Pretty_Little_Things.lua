-----------------------------------
-- Pretty Little Things
-----------------------------------
-- Log ID: 3, Quest ID: 43
-- Zona Shodhun : !pos -175 -5 -4 246
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local portJeunoID = require('scripts/zones/Port_Jeuno/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PRETTY_LITTLE_THINGS)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.JEUNO,
}

local invalidRocks =
{
    xi.items.RED_ROCK,
    xi.items.BLUE_ROCK,
    xi.items.GREEN_ROCK,
    xi.items.TRANSLUCENT_ROCK,
    xi.items.PURPLE_ROCK,
    xi.items.BLACK_ROCK,
    xi.items.WHITE_ROCK,
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
}

local function isTradeInTable(trade, itemTable)
    for _, itemID in ipairs(itemTable) do
        if npcUtil.tradeHasExactly(trade, itemID) then
            return true
        end
    end

    return false
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE or status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_JEUNO] =
        {
            -- Any trade or onTrigger flags this quest.  Default action is handled
            -- in the NPC script (onTrigger).  All valid items are consumed until
            -- quest is completed.
            ['Zona_Shodhun'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.YELLOW_ROCK) then
                        return quest:progressEvent(10023, 1, 246, 2, 1, 0, 1, 5, 1)
                    elseif isTradeInTable(trade, invalidRocks) then
                        return quest:progressEvent(10023, 0, 246, 1, 1, 0, 1, 7, 1)
                    elseif isTradeInTable(trade, flowerItems) then
                        return quest:progressEvent(10023, 0, 246, 1, 1, 1, 0, 7, 0)
                    else
                        return quest:progressEvent(10023, 0, 246, 0, 0, 0, 0, 7, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [10023] = function(player, csid, option, npc)
                    -- Three possible event options are returned from the above triggers:
                    -- 0    : Invalid Item was traded
                    -- 1    : Valid Item was traded
                    -- 4002 : Yellow Rock was traded
                    if option > 0 then
                        player:confirmTrade()
                    end

                    if option == 4002 then
                        if quest:complete(player) then
                            player:confirmTrade()
                            local mhflag = player:getMoghouseFlag()
                            player:setMoghouseFlag(mhflag + 0x0008)
                            player:messageSpecial(portJeunoID.text.MOGHOUSE_EXIT)
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

        [xi.zone.PORT_JEUNO] =
        {
            ['Zona_Shodhun'] =
            {
                -- NOTE: No items are consumed after quest complete.
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.YELLOW_ROCK) then
                        return quest:progressEvent(10023, 0, 246, 4, 1, 0, 1, 7, 0)
                    elseif isTradeInTable(trade, invalidRocks) then
                        return quest:progressEvent(10023, 0, 246, 5, 1, 0, 1, 7, 0)
                    elseif isTradeInTable(trade, flowerItems) then
                        return quest:progressEvent(10023, 0, 246, 3, 1, 1, 0, 7, 0)
                    else
                        return quest:progressEvent(10023, 0, 246, 5, 0, 0, 0, 7, 0)
                    end
                end,
            },
        },
    },
}

return quest
