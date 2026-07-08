-----------------------------------
-- Sugar-Coated Subterfuge
-- A Shantotto Ascension M7
-----------------------------------
-- !addmission 11 6
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_SUBTERFUGE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.SHANTOTTO_IN_CHAINS },
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
