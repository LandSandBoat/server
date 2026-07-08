-----------------------------------
-- To Movalpolos!
-- The Voracious Resurgence M10-1
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.TO_MOVALPOLOS)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.MAGH_BIHU_ON_THE_PROWL },
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
