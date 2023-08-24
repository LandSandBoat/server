-----------------------------------
-- The Merchants Bidding
-----------------------------------
-- Log ID: 0, Quest ID: 69
-- Parvipon : !pos -169 -1 13 230
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_MERCHANT_S_BIDDING)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    gil = 120,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Parvipon'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(90)
                end,
            },

            onEventFinish =
            {
                [90] = function(player, csid, option, npc)
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

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Parvipon'] = quest:progressEvent(88),
        },
    },

    -- These functions check the status of ~= QUEST_AVAILABLE to support repeating
    -- the quest.  Does not have to be flagged again to complete an additional time.
    {
        check = function(player, status, vars)
            return status ~= QUEST_AVAILABLE
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Parvipon'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.items.RABBIT_HIDE, 3 } }) then
                        return quest:progressEvent(89)
                    end
                end,
            },

            onEventFinish =
            {
                [89] = function(player, csid, option, npc)
                    player:confirmTrade()
                        if not player:hasCompletedQuest(quest.areaId, quest.questId) then
                            quest:complete(player)
                        else
                            player:addFame(xi.quest.fame_area.SANDORIA, 5)
                            npcUtil.giveCurrency(player, "gil", xi.settings.main.GIL_RATE * 120)
                        end
                end,
            },
        },
    },
}

return quest
