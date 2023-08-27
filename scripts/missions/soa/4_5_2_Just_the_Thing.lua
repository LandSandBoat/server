-----------------------------------
-- Just the Thing
-- Seekers of Adoulin M4-5-2
-----------------------------------
-- !addmission 12 101
-- Levil    : !pos -87.204 3.350 12.655 256
-- Andreine : !pos -91.944 -2.14 -91.538 284
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.JUST_THE_THING)

mission.reward =
{
    keyItem     = xi.ki.SUFFERING_SACCHARIFEROUS,
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.SUGARCOATED_SALVATION },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(40, 256, 0, 255, 0, 0, 26018, 4095, 4),
        },

        [xi.zone.CELENNIA_MEMORIAL_LIBRARY] =
        {
            ['Andreine'] = mission:progressEvent(7, 284, 1316886, 2963, 28635, 0, 0, 0, 0),

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
