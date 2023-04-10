-----------------------------------
-- Brushing Up
-- Rhapsodies of Vana'diel Mission 2-21
-----------------------------------
-- !addmission 13 96
-- qm_rov2_20 : !pos -44.741 -23.753 568.504 25
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/rhapsodies')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.BRUSHING_UP)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.KEEP_ON_GIVING },
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

            ['qm_rov2_20'] = mission:progressEvent(16, 25),

            onEventFinish =
            {
                [16] = function(player, csid, option, npc)
                    if option ~= 0 then
                        mission:complete(player)
                        xi.mission.setVar(player, xi.mission.log_id.ROV, xi.mission.id.rov.KEEP_ON_GIVING, 'Option', option - 1)
                    end
                end,
            },
        },
    },
}

return mission
