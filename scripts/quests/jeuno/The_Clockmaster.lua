-----------------------------------
-- The Clockmaster
-----------------------------------
-- Log ID: 3, Quest ID: 21
-- _6s2   : !pos -80 0 104 244
-- Collet : !pos -44 0 107 244
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_CLOCKMASTER)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    item     = xi.item.TIME_HAMMER,
    title    = xi.title.THE_CLOCKMASTER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_THE_CLOCK_TOWER) and
                player:getFameLevel(xi.quest.fame_area.JEUNO) >= 5
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['_6s2'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(152)
                end,
            },

            onEventFinish =
            {
                [152] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['_6s2']   = quest:event(110):replaceDefault(),
            ['Collet'] = quest:event(163):replaceDefault(),
        },
    },
}

return quest
