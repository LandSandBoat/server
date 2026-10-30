-----------------------------------
-- Battaru Royale
-- A Shantotto Ascension M10
-----------------------------------
-- !addmission 11 9
-- Moon Spiral : !pos -303.257 9.5 -260.069 170
-- CHOCOBO_KEY : !addkeyitem 1188
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.BATTARU_ROYALE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.ROMANCING_THE_CLONE },
}

-- The fight is scripts/battlefields/Full_Moon_Fountain/battaru_royale.lua, which completes the mission on a win.
mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,
    },
}

return mission
