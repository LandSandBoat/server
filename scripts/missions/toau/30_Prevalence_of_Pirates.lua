-----------------------------------
-- Prevalence of Pirates
-- Aht Uhrgan Mission 30
-----------------------------------
-- !addmission 4 29
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/keyitems')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.PREVALENCE_OF_PIRATES)

mission.reward =
{
    keyItem     = xi.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.SHADES_OF_VENGEANCE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.ARRAPAGO_REEF] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if
                        prevZone == xi.zone.CAEDARVA_MIRE and
                        player:getMissionStatus(mission.areaId) == 0
                    then
                        return 13
                    end
                end,
            },

            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(14)
                    end
                end,
            },

            onEventFinish =
            {
                [13] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [14] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
