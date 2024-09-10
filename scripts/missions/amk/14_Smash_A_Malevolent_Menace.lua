-----------------------------------
-- Smash! A Malevolent Menace
-- A Moogle Kupo d'Etat M14
-- !addmission 10 13
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.SMASH_A_MALEVOLENT_MENACE)

mission.reward =
{
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
