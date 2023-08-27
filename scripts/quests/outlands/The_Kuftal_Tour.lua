-----------------------------------
-- The Kuftal Tour
-----------------------------------
-- Log ID: 5, Quest ID: 195
--  Datta: !pos -6 -25 5
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_KUFTAL_TOUR)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.SELBINA_RABAO,
    gil      = 8000,
    title    = xi.title.KUFTAL_TOURIST,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getFameLevel(xi.quest.fame_area.SELBINA_RABAO) >= 3
        end,

        [xi.zone.RABAO] =
        {
            ['Datta'] = quest:progressEvent(74),

            onEventFinish =
            {
                [74] = function(player, csid, option, npc)
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

        [xi.zone.RABAO] =
        {
            ['Datta'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(75)
                    end
                end,
            },

            onEventFinish =
            {
                [75] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.KUFTAL_TUNNEL] =
        {
            ['qm5'] =
            {
                onTrigger = function(player, npc)
                    local flag = true

                    for _, member in pairs(player:getParty()) do
                        if
                            member:getMainLvl() > 40 or
                            member:checkDistance(player) > 15
                        then
                            flag = false
                        end
                    end

                    if
                        flag and
                        quest:getVar(player, 'Prog') == 0 and
                        #player:getParty() >= 6
                    then
                        return quest:progressEvent(14)
                    end
                end,
            },

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    for _, member in pairs(player:getParty()) do
                        quest:setVar(member, 'Prog', 1)
                    end
                end,
            },
        },
    },
}

return quest
