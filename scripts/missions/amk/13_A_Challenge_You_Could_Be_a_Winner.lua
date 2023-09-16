-----------------------------------
-- A Challenge! You Could Be a Winner
-- A Moogle Kupo d'Etat M13
-- !addmission 10 12
-- Inconspicuous Door : !pos -15 1.300 68 244
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.A_CHALLENGE_YOU_COULD_BE_A_WINNER)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.SMASH_A_MALEVOLENT_MENACE },
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
