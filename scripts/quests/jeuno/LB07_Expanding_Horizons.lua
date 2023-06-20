-----------------------------------
-- Expanding Horizons
-----------------------------------
-- Log ID: 3, Quest ID: 134
-- Nomad Moogle : !pos 10.012 1.453 121.883 243
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local ruludeID = require('scripts/zones/RuLude_Gardens/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.EXPANDING_HORIZONS)

quest.reward =
{
    fame = 50,
    fameArea = xi.quest.fame_area.JEUNO,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= 76 and
                player:getLevelCap() == 80 and
                xi.settings.main.MAX_LEVEL >= 85
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(10045, 0, 1, 2, 0) -- Confirmed.
                end,
            },

            onEventFinish =
            {
                [10045] = function(player, csid, option, npc)
                    if option == 7 then -- Accept quest option.
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(10045, 0, 1, 2, 1)
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { { xi.items.KINDREDS_CREST, 5 } }) and
                        player:getMeritCount() > 3
                    then
                        return quest:progressEvent(10136)
                    end
                end,
            },

            onEventFinish =
            {
                [10136] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        player:setMerits(player:getMeritCount() - 4)
                        player:setLevelCap(85)
                        player:messageSpecial(ruludeID.text.YOUR_LEVEL_LIMIT_IS_NOW_85)
                    end
                end,
            },
        },
    },
}

return quest
