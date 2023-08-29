-----------------------------------
-- Starting A Flame
-----------------------------------
-- Log ID: 0, Quest ID: 77
-- Legata : !pos 82 0 116 230
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.STARTING_A_FLAME)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    gil = 100,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Legata'] = quest:progressEvent(37),

            onEventFinish =
            {
                [37] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
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
            ['Legata'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.items.FLINT_STONE, 4 } }) then
                        return quest:progressEvent(36)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(35)
                end,
            },

            onEventFinish =
            {
                [36] = function(player, csid, option, npc)
                    player:confirmTrade()
                    if not player:hasCompletedQuest(quest.areaId, quest.questId) then
                        quest:complete(player)
                    else
                        player:addFame(xi.quest.fame_area.SANDORIA, 5)
                        npcUtil.giveCurrency(player, "gil", xi.settings.main.GIL_RATE * 100)
                    end
                end,
            },
        },
    },
}

return quest
