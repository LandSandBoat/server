-----------------------------------
-- Delkfutt the Great
-- The Voracious Resurgence M8-3
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.DELKFUTT_THE_GREAT)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.OSHASHAS_VIOLATION },
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
