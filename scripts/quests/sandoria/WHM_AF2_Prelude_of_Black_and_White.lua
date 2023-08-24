-----------------------------------
-- Prelude of Black and White
-- !addquest: 0 88
-- Prince Regent's Rm: !gotoid 17731625
-- Narcheral: !gotoid 17723585
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PRELUDE_OF_BLACK_AND_WHITE)

quest.reward =
{
    item     = xi.items.HEALERS_DUCKBILLS,
    fame     = 40,
    fameArea = xi.quest.fame_area.SANDORIA,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.WHM and
                player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL and
                player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.MESSENGER_FROM_BEYOND) == QUEST_COMPLETED
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['_6h1'] = quest:progressEvent(551), -- Prince Regent's Rm

            onEventFinish =
            {
                [551] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Narcheral'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.items.MOCCASINS, xi.items.CANTEEN_OF_YAGUDO_HOLY_WATER }) then
                        return quest:progressEvent(691)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(688)
                end,
            },

            onEventFinish =
            {
                [691] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
