-----------------------------------
-- Relief! A Triumphant Return
-- A Moogle Kupo d'Etat M11
-- !addmission 10 10
-- Inconspicuous Door : !pos -15 1.300 68 244
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.RELIEF_A_TRIUMPHANT_RETURN)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.JOY_SUMMONED_TO_A_FABULOUS_FETE },
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
