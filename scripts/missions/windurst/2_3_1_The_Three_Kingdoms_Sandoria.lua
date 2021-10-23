-----------------------------------
-- The Three Kingdoms San d'Oria
-- Windurst M2-3
-----------------------------------
-- !addmission 2 6
-- Halver  : !pos 2 0.1 0.1 233
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/settings/main')
require('scripts/globals/titles')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local chateauID          = require('scripts/zones/Chateau_dOraguille/IDs')
local northernSandoriaID = require('scripts/zones/Northern_San_dOria/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.bastok.THE_THREE_KINGDOMS_SANDORIA)

mission.reward = {}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 3 then
                        return mission:progressEvent(502)
                    else
                        return mission:messageText(chateauID.text.HALVER_OFFSET + 279)
                    end
                end,
            },

            onEventFinish =
            {
                [502] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                end,
            },
        },

        [xi.zone.GHELSBA_OUTPOST] =
        {
            ['Warchief_Vatgit'] =
            {
                onMobDeath = function(mob, player, isKiller, noKiller)
                    if player:getMissionStatus(mission.areaId) == 4 then
                        player:setMissionStatus(mission.areaId, 5)
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Kasaroro'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 3 then
                        player:showText(npc, northernSandoriaID.text.KASARORO_DIALOG)
                    elseif missionStatus == 4 then
                        player:startEvent(549)
                    elseif missionStatus == 5 then
                        player:startEvent(550)
                    end
                end,
            },


            onEventFinish =
            {
                [550] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:addMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS)
                        player:setMissionStatus(mission.areaId, 6)
                    end
                end,
            },
        },
    },
}

return mission
