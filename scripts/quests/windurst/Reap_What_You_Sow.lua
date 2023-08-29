-----------------------------------
-- Reap What You sow
-----------------------------------
-- !addquest 2 29
-- Mashuu-Ajuu 130 -5 167
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require('scripts/zones/Windurst_Waters/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.REAP_WHAT_YOU_SOW)

quest.reward =
{
    item = xi.items.STATIONERY_SET,
    gil = 700,
    fame = 75,
    fameArea = xi.quest.fame_area.WINDURST,
}

quest.sections =
{
    {
        -- Players can only start the quest if they are below rank 4 fame
        -- else they must complete let sleeping dogs lie
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            (player:getFameLevel(xi.quest.fame_area.WINDURST) < 4 or
            player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.LET_SLEEPING_DOGS_LIE))
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Mashuu-Ajuu'] =
            {
                onTrigger = function(player, npc)
                    if player:getFameLevel(xi.quest.fame_area.WINDURST) >= 4 then
                        return quest:progressEvent(483)
                    else
                        return quest:progressEvent(463, 0, xi.items.SOBBING_FUNGUS, xi.items.BAG_OF_HERB_SEEDS)
                    end
                end,
            },

            onEventFinish =
            {
                [463] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.items.BAG_OF_HERB_SEEDS) and option == 3 then
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

        [xi.zone.WINDURST_WATERS] =
        {
            ['Mashuu-Ajuu'] =
            {
                onTrigger = function(player, npc)
                    local rand = math.random()

                    if rand > 0.5 then
                        return quest:progressEvent(464, 0, xi.items.SOBBING_FUNGUS, xi.items.BAG_OF_HERB_SEEDS)
                    else
                        return quest:progressEvent(476)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.SOBBING_FUNGUS) then
                        return quest:progressEvent(475, 500, 131)
                    elseif npcUtil.tradeHasExactly(trade, xi.items.DEATHBALL) then
                        return quest:progressEvent(477, 700)
                    end
                end,
            },

            onEventFinish =
            {
                [475] = function(player, csid, option, npc)
                    player:confirmTrade()
                    -- player:addGil over npcUtil:giveCurrency to avoid duplicate
                    -- 'Obtained X gil' messages.
                    player:addGil(500)
                end,

                [477] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
