-----------------------------------
-- Banishing The Echo
-- A Crystalline Prophecy M10
-----------------------------------
-- !addmission 9 9
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ACP, xi.mission.id.acp.BANISHING_THE_ECHO)

mission.reward =
{
    nextMission = { xi.mission.log_id.ACP, xi.mission.id.acp.ODE_OF_LIFE_BESTOWING },
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
