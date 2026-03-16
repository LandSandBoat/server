-----------------------------------
-- To the Skies
-- Rhapsodies of Vana'diel Mission 2-28
-----------------------------------
-- !addmission 13 108
-- Oaken Door (_700) : !pos 97 -7 -12 252
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.TO_THE_SKIES)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.ESCHA_RUAUN },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['_700'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(285)
                end,
            },

            onEventFinish =
            {
                [285] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
