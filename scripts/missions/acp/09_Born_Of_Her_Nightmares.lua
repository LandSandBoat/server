-----------------------------------
-- Born Of Her Nightmares
-- A Crystalline Prophecy M9
-----------------------------------
-- !addmission 9 8
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ACP, xi.mission.id.acp.BORN_OF_HER_NIGHTMARES)

mission.reward =
{
    nextMission = { xi.mission.log_id.ACP, xi.mission.id.acp.BANISHING_THE_ECHO },
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
