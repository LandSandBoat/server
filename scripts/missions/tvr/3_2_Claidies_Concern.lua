-----------------------------------
-- Claidie's Concern
-- The Voracious Resurgence M3-2
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.CLAIDIES_CONCERN)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.CURILLA_UNLEASHED },
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
