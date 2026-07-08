-----------------------------------
-- Shantotto In Chains
-- A Shantotto Ascension M8
-----------------------------------
-- !addmission 11 7
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.SHANTOTTO_IN_CHAINS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.FOUNTAIN_OF_TROUBLE },
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
