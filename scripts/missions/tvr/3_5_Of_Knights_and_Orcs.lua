-----------------------------------
-- Of Knights and Orcs
-- The Voracious Resurgence M3-5
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.OF_KNIGHTS_AND_ORCS)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.BEST_SERVED_COLD },
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
