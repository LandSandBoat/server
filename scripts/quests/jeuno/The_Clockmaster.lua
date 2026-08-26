-----------------------------------
-- The Clockmaster
-----------------------------------
-- Log ID: 3, Quest ID: 21
-- _6s2   : !pos -80 0 104 244
-- Collet : !pos -44 0 107 244
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_CLOCKMASTER)

quest.reward =
{
    item     = xi.item.TIME_HAMMER,
    gil      = 1200,
    title    = xi.title.TIMEKEEPER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.SAVE_THE_CLOCK_TOWER) and
                player:getFameLevel(xi.fameArea.JEUNO) >= 5
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
                    if quest:complete(player) then
                        player:addFame(xi.fameArea.SANDORIA, 17)
                        player:addFame(xi.fameArea.BASTOK, 17)
                        player:addFame(xi.fameArea.WINDURST, 17)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['_6s2']   = quest:event(110):replaceDefault(),
            ['Collet'] = quest:event(163):replaceDefault(),
        },
    },
}

return quest
