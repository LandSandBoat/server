-----------------------------------
-- Those Who Lurk In Shadows II
-- A Crystalline Prophecy M6
-----------------------------------
-- !addmission 9 5
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ACP, xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_II)

mission.reward =
{
    nextMission = { xi.mission.log_id.ACP, xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_III },
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
