-----------------------------------
-- The Man Behind the Mask
-- Rhapsodies of Vana'diel Mission 2-40
-----------------------------------
-- !addmission 13 142
-- Oaken Door (_700) : !pos 97 -7 -12 252
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.THE_MAN_BEHIND_THE_MASK)

mission.reward =
{
    keyItem     = xi.ki.RHAPSODY_IN_MAUVE,
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.UNCERTAIN_FUTURES },
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
                    return mission:progressEvent(290)
                end,
            },

            onEventFinish =
            {
                [290] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
