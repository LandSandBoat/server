-----------------------------------
-- Eddies of Despair (2)
-- Rhapsodies of Vana'diel Mission 2-35
-----------------------------------
-- !addmission 13 124
-- qm_rov2_35 : !pos -1.302 -54.038 -603.471 289
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/rhapsodies')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.EDDIES_OF_DESPAIR_II)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.PRETENDER_TO_THE_THRONE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.ESCHA_RUAUN] =
        {
            ['qm_rov2_35'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(6, 1, 300, 200, 100, utils.MAX_UINT32 - 179933, utils.MAX_UINT32 - 1934, 666668, 0)
                end,
            },

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
