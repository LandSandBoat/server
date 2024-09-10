-----------------------------------
-- Hasten! In a Jam in Jeuno?
-- A Moogle Kupo d'Etat M3
-- !addmission 10 2
-- Inconspicuous Door : !pos -15 1.300 68 244
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.HASTEN_IN_A_JAM_IN_JEUNO)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.WELCOME_TO_MY_DECREPIT_DOMICILE },
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
                    return mission:progressEvent(10178)
                end,
            },

            onEventFinish =
            {
                [10178] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
