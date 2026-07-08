-----------------------------------
-- Naja the Ambitious
-- The Voracious Resurgence M4-3
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.NAJA_THE_AMBITIOUS)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.RAUBAHN_THE_BLUE },
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
