-----------------------------------
-- The Gift
-----------------------------------
-- Log ID: 4, Quest ID: 21
-- Oswald  : !pos 47.119 -15.273 7.989 248
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_GIFT)

quest.reward =
{
    item = xi.items.SLEEP_DAGGER,
    title = xi.title.SAVIOR_OF_LOVE
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.UNDER_THE_SEA) == QUEST_COMPLETED and
            player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_SAND_CHARM) >= QUEST_ACCEPTED
        end,

        [xi.zone.SELBINA] =
        {
            ['Oswald'] = quest:event(70, xi.items.DANCESHROOM),

            onEventFinish =
            {
                [70] = function(player, csid, option, npc)
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
                    if npcUtil.tradeHasExactly(trade, xi.items.DANCESHROOM) then
                        return quest:progressEvent(72, 0, xi.items.DANCESHROOM)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(71)
                end,
            },

            onEventFinish =
            {
                [72] = function(player, csid, option, npc)
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
                return status == QUEST_COMPLETED and
                player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_REAL_GIFT) == QUEST_AVAILABLE
            end,

            [xi.zone.SELBINA] =
            {
                ['Oswald'] = quest:event(78):replaceDefault(),
            },
        },
    },
}

return quest
