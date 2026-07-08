-----------------------------------
-- The Echo Awakens
-- A Crystalline Prophecy M2
-----------------------------------
-- !addmission 9 1
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ACP, xi.mission.id.acp.THE_ECHO_AWAKENS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ACP, xi.mission.id.acp.GATHERER_OF_LIGHT_I },
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
