-----------------------------------
-- Shield of Diplomacy
-- Aht Uhrgan Mission 22
-----------------------------------
-- !addmission 4 21
-- Decorative Bronze Gate : !pos -601 10 -100 64
-----------------------------------
require("scripts/globals/besieged")
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.SHIELD_OF_DIPLOMACY)

mission.reward =
{
    title       = xi.title.KARABABAS_BODYGUARD,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.SOCIAL_GRACES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NAVUKGO_EXECUTION_CHAMBER] =
        {
            ['_1s0'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(2)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return 1
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [2] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,

                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == 1124 then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
