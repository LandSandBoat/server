-----------------------------------
-- Sleepless Nights
-----------------------------------
-- Log ID: 0, Quest ID: 80
-- Paouala : !gotoid 17719497
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SLEEPLESS_NIGHTS)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    gil = 5000,
    title = xi.title.SHEEPS_MILK_DELIVERER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 2
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Paouala'] = quest:progressEvent(85),

            onEventFinish =
            {
                [85] = function(player, csid, option, npc)
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
            ['Paouala'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.items.JUG_OF_MARY_S_MILK, 1 } }) then
                        return quest:progressEvent(84)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(83)
                end,

            },

            onEventFinish =
            {
                [84] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Paouala'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(81):replaceDefault()
                end,
            },
        },
    },
}

return quest
