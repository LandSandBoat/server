-----------------------------------
-- Ode Of Life Bestowing
-- A Crystalline Prophecy M11
-----------------------------------
-- !addmission 9 10
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ACP, xi.mission.id.acp.ODE_OF_LIFE_BESTOWING)

mission.reward =
{
    nextMission = { xi.mission.log_id.ACP, xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN },
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
