-----------------------------------
-- The Voracious Beast
-- The Voracious Resurgence M11-2
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.THE_VORACIOUS_BEAST)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.YOUR_DECISION },
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
