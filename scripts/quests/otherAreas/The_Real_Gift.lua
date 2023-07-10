-----------------------------------
-- The Real Gift
-----------------------------------
-- Log ID: 4, Quest ID: 22
-- Oswald  : !pos 47.119 -15.273 7.989 248
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_REAL_GIFT)

quest.reward =
{
    item = xi.items.GLASS_FIBER_FISHING_ROD,
    title = xi.title.THE_LOVE_DOCTOR
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_GIFT) == QUEST_COMPLETED and
            player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_SAND_CHARM) == QUEST_COMPLETED
        end,

        [xi.zone.SELBINA] =
        {
            ['Oswald'] = quest:event(73, xi.items.SHALL_SHELL),

            onEventFinish =
            {
                [73] = function(player, csid, option, npc)
                    if option == 50 then
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

        [xi.zone.SELBINA] =
        {
            ['Oswald'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.SHALL_SHELL) then
                        return quest:progressEvent(75)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(74, xi.items.SHALL_SHELL)
                end,
            },

            onEventFinish =
            {
                [75] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
    {
        {
            check = function(player, status, vars)
                return status == QUEST_COMPLETED
            end,

            [xi.zone.SELBINA] =
            {
                ['Oswald'] = quest:event(76):replaceDefault(),
            },
        },
    },
}

return quest
