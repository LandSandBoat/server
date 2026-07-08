-----------------------------------
-- An Uneasy Peace
-- A Shantotto Ascension M14
-----------------------------------
-- !addmission 11 13
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.AN_UNEASY_PEACE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.A_SHANTOTTO_ASCENSION_FIN },
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
