-----------------------------------
-- Cornelia's Call to Action
-- The Voracious Resurgence M4-2
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.CORNELIAS_CALL_TO_ACTION)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.NAJA_THE_AMBITIOUS },
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
