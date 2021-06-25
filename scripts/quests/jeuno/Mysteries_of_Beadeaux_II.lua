-----------------------------------
-- Mysteries of Beadeaux II
-----------------------------------
-- Log ID: 3, Quest ID: 32
-- Sattal-Mansal : !pos 40 3 -53 245
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/zone")
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.otherAreas.MYSTERIES_OF_BEADEAUX_II)

quest.rewards =
{
    fame = 30,
    keyItem = xi.ki.BLACK_MATINEE_NECKLACE,
},

quest.sections =
{
    -- This quest is flagged at the same time that Mysteries of Beadeaux I is
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Sattal-Mansal'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.QUADAV_AUGURY_SHELL) then
                        return quest:progressEvent(92)
                    end
                end,
            },

            onEventFinish =
            {
                [92] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    }
}

return quest
