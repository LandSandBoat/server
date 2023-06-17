-----------------------------------
-- Mysteries of Beadeaux I
-----------------------------------
-- Log ID: 3, Quest ID: 31
-- Sattal-Mansal : !pos 40 3 -53 245
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.MYSTERIES_OF_BEADEAUX_I)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    keyItem = xi.ki.CORUSCANT_ROSARY,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasKeyItem(xi.ki.SILVER_BELL)
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Sattal-Mansal'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(89)
                end,
            },

            onEventFinish =
            {
                -- This event flags both Mysteries of Beadeaux I and II
                [89] = function(player, csid, option, npc)
                    quest:begin(player)
                    player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.MYSTERIES_OF_BEADEAUX_II)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Sattal-Mansal'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.QUADAV_CHARM) then
                        return quest:progressEvent(91)
                    end
                end,
            },

            onEventFinish =
            {
                [91] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    }
}

return quest
