-----------------------------------
-- Storms of Fate
-----------------------------------
-- Log ID: 3, Quest ID: 86
-- Rulude: !pos -0.3 3.0 23.1 243
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE)

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.DAWN and
            player:getCharVar("Mission[6][840]Status") >= 8
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, region)
                    if player:getCharVar("Mission[6][840]Status") == 8 then
                        return quest:progressEvent(142)
                    end
                end,
            },

            onEventFinish =
            {
                [142] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.MISAREAUX_COAST] =
        {
            ['_0p2'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Status') == 0 then
                        return quest:event(559)
                    end
                end,
            },

            onEventFinish =
            {
                [559] = function(player, csid, option, npc)
                    quest:setVar(player, 'Status', 1)
                end,
            },
        },

        [xi.zone.RIVERNE_SITE_B01] =
        {
            ['Unstable_Displacement'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Status') == 1 then
                        return quest:event(1)
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    quest:setVar(player, 'Status', 2)
                end,
            },
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, region)
                    if quest:getVar(player, 'Status') == 3 then
                        return quest:progressEvent(143)
                    end
                end,
            },

            onEventFinish =
            {
                [143] = function(player, csid, option, npc)
                    quest:complete(player)
                    player:setCharVar("StormsOfFateWait", getConquestTally())
                end,
            },
        },
    }
}

return quest
