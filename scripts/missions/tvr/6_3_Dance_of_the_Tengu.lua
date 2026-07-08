-----------------------------------
-- Dance of the Tengu
-- The Voracious Resurgence M6-3
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.DANCE_OF_THE_TENGU)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.RAEBRIMMS_REBIRTH },
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
