-----------------------------------
-- Fountain Of Trouble
-- A Shantotto Ascension M9
-----------------------------------
-- !addmission 11 8
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.FOUNTAIN_OF_TROUBLE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.BATTARU_ROYALE },
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
