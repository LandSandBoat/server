-----------------------------------
-- The Destiny Destroyers
-- The Voracious Resurgence M1-4
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.THE_DESTINY_DESTROYERS)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.KUPIPIS_DILEMMA },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        -- TODO: Add zones and interactions
    },
}

return mission
