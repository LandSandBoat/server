-----------------------------------
-- Magh Bihu on the Prowl
-- The Voracious Resurgence M10-2
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.MAGH_BIHU_ON_THE_PROWL)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.DAZBOGS_101 },
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
