-----------------------------------
-- Path of Blood
-- Aht Uhrgan Mission 37
-----------------------------------
-- !addmission 4 36
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/keyitems')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.PATH_OF_BLOOD)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.STIRRINGS_OF_WAR },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            onRegionEnter =
            {
                [3] = function(player, region)
                    return mission:progressEvent(3131, 1, 1, 1, 1, 1, 1, 1, 1)
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 3220
                    end
                end,
            },

            onEventFinish =
            {
                [3131] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)

                    -- TODO: Verify this setPos changes zone/Downloading Data
                    player:setPos(-97.936, 0, 0.109, 0, 50)
                end,

                [3220] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:setLocalVar('Mission[4][37]mustZone', 1)
                        player:setCharVar('Mission[4][37]Timer', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },
    },
}

return mission
