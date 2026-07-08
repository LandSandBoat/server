-----------------------------------
-- Those Who Lurk In Shadows I
-- A Crystalline Prophecy M5
-----------------------------------
-- !addmission 9 4
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ACP, xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_I)

mission.reward =
{
    nextMission = { xi.mission.log_id.ACP, xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_II },
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
