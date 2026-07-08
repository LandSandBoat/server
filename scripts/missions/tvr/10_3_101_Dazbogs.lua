-----------------------------------
-- 101 Dazbogs
-- The Voracious Resurgence M10-3
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.DAZBOGS_101)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.KIPDRIX_THE_FAITHFUL },
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
