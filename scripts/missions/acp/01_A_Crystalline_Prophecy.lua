-----------------------------------
-- A Crystalline Prophecy
-- A Crystalline Prophecy M1
-----------------------------------
-- !addmission 9 0
-----------------------------------
require('scripts/globals/missions')
require('scripts/settings/main')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ACP, xi.mission.id.acp.A_CRYSTALLINE_PROPHECY)

mission.reward =
{
    nextMission = { xi.mission.log_id.ACP, xi.mission.id.acp.THE_ECHO_AWAKENS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                   xi.settings.ENABLE_ACP == 1 and
                   player:getMainLvl() >= 10
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 10094
                end,
            },

            onEventFinish =
            {
                [10094] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
