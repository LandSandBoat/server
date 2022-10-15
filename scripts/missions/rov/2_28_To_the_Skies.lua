-----------------------------------
-- To the Skies
-- Rhapsodies of Vana'diel Mission 2-28
-----------------------------------
-- !addmission 13 108
-- _700 (Oaken Door) : !pos 97 -7 -12 252
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.TO_THE_SKIES)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.ESCHA_RUAUN },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['_700'] =
            {
                onTrigger = function(player, npc)
                    -- All Missions Completed
                    return mission:progressEvent(287, 1, 16, 406127362, 692532992, 1883654212, 269943554, 814615041, 34884)
                end,
            },

            onEventFinish =
            {
                [287] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
