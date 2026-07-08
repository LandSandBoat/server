-----------------------------------
-- Romancing The Clone
-- A Shantotto Ascension M11
-----------------------------------
-- !addmission 11 10
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.ROMANCING_THE_CLONE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.SISTERS_IN_ARMS },
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
