-----------------------------------
-- Battaru Royale
-- A Shantotto Ascension M10
-----------------------------------
-- !addmission 11 9
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.BATTARU_ROYALE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.ROMANCING_THE_CLONE },
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
