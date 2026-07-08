-----------------------------------
-- Gatherer Of Light II
-- A Crystalline Prophecy M4
-----------------------------------
-- !addmission 9 3
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ACP, xi.mission.id.acp.GATHERER_OF_LIGHT_II)

mission.reward =
{
    nextMission = { xi.mission.log_id.ACP, xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_I },
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
