-----------------------------------
-- A Shantotto Ascension
-- A Shantotto Ascension M1
-----------------------------------
-- !addmission 11 0
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.A_SHANTOTTO_ASCENSION)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                   ENABLE_ASA == 1 and
                   player:getMainLvl() >= 10
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if prevZone == xi.zone.WINDURST_WATERS or prevZone == xi.zone.WINDURST_WOODS then
                        return return mission:event(510)
                    end
                end,
            },

            onEventFinish =
            {
                [510] = function(player, csid, option, npc)
                    return mission:event(514)
                end,

                [514] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:setCharVar("ASA_Status", 0) -- Brought from original script
                    end
                end,
            },
        },
    },
}

return mission
