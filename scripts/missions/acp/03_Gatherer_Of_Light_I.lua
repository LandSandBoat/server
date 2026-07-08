-----------------------------------
-- Gatherer Of Light I
-- A Crystalline Prophecy M3
-----------------------------------
-- !addmission 9 2
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ACP, xi.mission.id.acp.GATHERER_OF_LIGHT_I)

mission.reward =
{
    nextMission = { xi.mission.log_id.ACP, xi.mission.id.acp.GATHERER_OF_LIGHT_II },
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
