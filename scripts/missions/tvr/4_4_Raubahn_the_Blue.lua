-----------------------------------
-- Raubahn the Blue
-- The Voracious Resurgence M4-4
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.RAUBAHN_THE_BLUE)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.GHATSADS_QUANDARY },
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
