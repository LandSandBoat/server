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

-- The fight is scripts/battlefields/Full_Moon_Fountain/battaru_royale.lua.
mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.FULL_MOON_FOUNTAIN] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.BATTARU_ROYALE then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
