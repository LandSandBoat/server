-----------------------------------
-- A Crystalline Prophecy Fin
-- A Crystalline Prophecy M12
-----------------------------------
-- !addmission 9 11
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ACP, xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN)

mission.reward = {}

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
