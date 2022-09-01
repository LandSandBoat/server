-----------------------------------
-- Somber Dreams
-- Rhapsodies of Vana'diel Mission 2-18
-----------------------------------
-- !addmission 13 86
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/rhapsodies')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.SOMBER_DREAMS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.OF_LIGHT_AND_DARKNESS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.GRAUBERG_S] =
        {
            ['qm_cetus'] =
            {
                onTrigger = function(player, npc)

                end,
            },

            ['Cetus'] =
            {
                onMobDeath = function(mob, player, isKiller, noKiller)
                    mission:setLocalVar(player, 'nmKilled', 1)
                end,
            },

            onEventFinish =
            {
                [] = function(player, csid, option, npc)

                end,
            },
        },
    },
}

return mission
