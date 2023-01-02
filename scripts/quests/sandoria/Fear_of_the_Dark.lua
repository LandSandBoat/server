-----------------------------------
-- Fear of the Dark
-----------------------------------
-- Log ID: 0, Quest ID: 78
-- Secodiand : !pos -160 -0 137 231
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FEAR_OF_THE_DARK)

quest.reward =
{
    game = 30,
    gil = 200 * xi.settings.main.GIL_RATE,
    fameArea = xi.quest.fame_area.SANDORIA,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Secodiand'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(19)
                end,
            },

            onEventFinish =
            {
                [19] = function(player, csid, option, npc)
                    if(option == 1) then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status >= QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Secodiand'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.items.BAT_WING, 2 } }) then
                        return quest:progressEvent(18)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(17):replaceDefault()
                end,
            },

            onEventFinish =
            {
                [18] = function(player, csid, option, npc)
                    player:tradeComplete()
                    if player:getQuestStatus(quest.areaId, quest.questId) == QUEST_COMPLETED then
                        -- Quest is repeatable but only gives 5 fame per turn in instead of the 30 for the original completion
                        quest.reward.fame = 5
                    end
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
