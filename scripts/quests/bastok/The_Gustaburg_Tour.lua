-----------------------------------
-- The Gustaberg Tour
-----------------------------------
-- Log ID      : 1, Quest ID: 45
-- Izabele     : !pos -43.9 -10 -2.4 237
-- Hunting Bear: !pos -235.7 40 424.5 106
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.THE_GUSTABERG_TOUR)

quest.reward =
{
    fame     = 20,
    fameArea = xi.fameArea.BASTOK,
    gil      = 500,
    title    = xi.title.GUSTABERG_TOURIST,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.METALWORKS] =
        {
            ['Izabele'] = quest:progressEvent(745),

            onEventFinish =
            {
                [745] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.METALWORKS] =
        {
            ['Izabele'] = quest:progressEvent(746)
        },

        [xi.zone.NORTH_GUSTABERG] =
        {
            ['Hunting_Bear'] =
            {
                onTrigger = function(player, npc)
                    local flag = true

                    for _, member in pairs(player:getAlliance()) do
                        if
                            member:getMainLvl() > 15 or
                            member:checkDistance(player) > 15
                        then
                            flag = false
                        end
                    end

                    if flag and #player:getParty() > 1 then
                        return quest:progressEvent(22)
                    else
                        return quest:progressEvent(21)
                    end
                end,
            },

            onEventFinish =
            {
                [22] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.METALWORKS] =
        {
            ['Izabele'] = quest:event(747):replaceDefault()
        },
        [xi.zone.NORTH_GUSTABERG] =
        {
            ['Hunting_Bear'] = quest:event(23):replaceDefault()
        },
    },
}

return quest
