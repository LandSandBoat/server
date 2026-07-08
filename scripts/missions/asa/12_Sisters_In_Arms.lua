-----------------------------------
-- Sisters In Arms
-- A Shantotto Ascension M12
-----------------------------------
-- !addmission 11 11
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.SISTERS_IN_ARMS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.PROJECT_SHANTOTTOFICATION },
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
