-----------------------------------
-- Enemy Of The Empire II
-- A Shantotto Ascension M6
-----------------------------------
-- !addmission 11 5
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_II)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_SUBTERFUGE },
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
