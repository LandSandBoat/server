-----------------------------------
-- Those Who Lurk In Shadows III
-- A Crystalline Prophecy M7
-----------------------------------
-- !addmission 9 6
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ACP, xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_III)

mission.reward =
{
    nextMission = { xi.mission.log_id.ACP, xi.mission.id.acp.REMEMBER_ME_IN_YOUR_DREAMS },
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
