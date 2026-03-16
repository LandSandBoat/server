-----------------------------------
-- Banishing the Darkness
-- Rhapsodies of Vana'diel Mission 2-32
-----------------------------------
-- !addmission 13 118
-- Oaken Door (_700) : !pos 97 -7 -12 252
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.BANISHING_THE_DARKNESS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.OVER_THE_RAINBOW },
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
                    return mission:progressEvent(287)
                end,
            },

            onEventFinish =
            {
                [287] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
