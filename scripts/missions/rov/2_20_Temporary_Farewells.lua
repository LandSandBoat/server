-----------------------------------
-- Temporary Farewells
-- Rhapsodies of Vana'diel Mission 2-20
-----------------------------------
-- !addmission 13 94
-- qm_rov2_20 : !pos -44.741 -23.753 568.504 25
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/rhapsodies')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.TEMPORARY_FAREWELLS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.BRUSHING_UP },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.MISAREAUX_COAST] =
        {
            -- NOTE: No observed impact between minimal requirements vs fully completed for
            -- the below event.

            ['qm_rov2_20'] = mission:progressEvent(15, 25, 23, 2964),

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
