-----------------------------------
-- A Shantotto Ascension Fin
-- A Shantotto Ascension M15
-----------------------------------
-- !addmission 11 14
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.A_SHANTOTTO_ASCENSION_FIN)

mission.reward = {}

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
