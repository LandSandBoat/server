-----------------------------------
-- Slanderous Utterings
-- Promathia 4-4
-----------------------------------
-- !addmission 6 438
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/missions')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.SLANDEROUS_UTTERINGS)

mission.reward =
{
    title = xi.title.THE_LOST_ONE,
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] = mission:event(132):importantEvent(),

            onTriggerAreaEnter =
            {
                [2] = function(player, triggerArea)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(112)
                    end
                end,
            },

            onEventFinish =
            {
                [112] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,
            },
        },

        [xi.zone.SEALIONS_DEN] =
        {
            ['_0w0'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:progressEvent(13)
                    end
                end,
            },

            onEventFinish =
            {
                [13] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Arquil']       = mission:event(293):replaceDefault(),
            ['Despachiaire'] = mission:event(317):replaceDefault(),
        },
    },
}

return mission
