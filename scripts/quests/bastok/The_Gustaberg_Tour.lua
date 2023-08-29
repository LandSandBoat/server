-----------------------------------
-- The Gustaberg Tour
-----------------------------------
-- Log ID: 1, Quest ID: 45
-- Gerbaum : !pos 183 630 -15
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_GUSTABERG_TOUR)

quest.reward =
{
    fame     = 20,
    fameArea = xi.quest.fame_area.BASTOK,
    gil      = 500,
    title    = xi.title.GUSTABERG_TOURIST,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.METALWORKS] =
        {
            ['Izabele'] = quest:progressEvent(745),

            onEventFinish =
            {
                [745] = function(player, csid, option, npc)
                    if option == 0 then
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
            return status == QUEST_COMPLETED
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
