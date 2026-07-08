-----------------------------------
-- Project Shantottofication
-- A Shantotto Ascension M13
-----------------------------------
-- !addmission 11 12
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.PROJECT_SHANTOTTOFICATION)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.AN_UNEASY_PEACE },
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
