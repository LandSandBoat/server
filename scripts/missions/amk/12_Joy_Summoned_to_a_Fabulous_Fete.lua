-----------------------------------
-- Joy! Summoned to a Fabulous Fete
-- A Moogle Kupo d'Etat M12
-- !addmission 10 11
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.JOY_SUMMONED_TO_A_FABULOUS_FETE)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.A_CHALLENGE_YOU_COULD_BE_A_WINNER },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Inconspicuous_Door'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(10185)
                end,
            },

            onEventFinish =
            {
                [10185] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
