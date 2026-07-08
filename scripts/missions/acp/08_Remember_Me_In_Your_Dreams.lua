-----------------------------------
-- Remember Me In Your Dreams
-- A Crystalline Prophecy M8
-----------------------------------
-- !addmission 9 7
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ACP, xi.mission.id.acp.REMEMBER_ME_IN_YOUR_DREAMS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ACP, xi.mission.id.acp.BORN_OF_HER_NIGHTMARES },
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
