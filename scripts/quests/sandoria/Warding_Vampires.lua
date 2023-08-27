-----------------------------------
-- Warding Vampires
-----------------------------------
-- Log ID: 0, Quest ID: 79
-- Maloquedil : !pos 35 0.1 60 231
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.WARDING_VAMPIRES)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    gil      = 900,
    title    = xi.title.VAMPIRE_HUNTER_D_MINUS,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 3
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Maloquedil'] = quest:progressEvent(24),

            onEventFinish =
            {
                [24] = function(player, csid, option, npc)
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

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Maloquedil'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.items.BULB_OF_SHAMAN_GARLIC, 2 } }) then
                        return quest:progressEvent(23)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(22)
                end,
            },

            onEventFinish =
            {
                [23] = function(player, csid, option, npc)
                    player:confirmTrade()
                    if not player:hasCompletedQuest(quest.areaId, quest.questId) then
                        quest:complete(player)
                    else
                        player:addFame(xi.quest.fame_area.SANDORIA, 5)
                        npcUtil.giveCurrency(player, "gil", xi.settings.main.GIL_RATE * 900)
                    end
                end,
            },
        },
    },
}

return quest
