-----------------------------------
-- The Crystal Spring
-- San d'Oria M3-2
-----------------------------------
-- !addmission 0 11
-- Ambrotien            : !pos 93.419 -0.001 -57.347 230
-- Grilau               : !pos -241.987 6.999 57.887 231
-- Endracion            : !pos -110 1 -34 230
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local southernSandoriaID = require('scripts/zones/Southern_San_dOria/IDs')
local northernSandoriaID = require('scripts/zones/Northern_San_dOria/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_CRYSTAL_SPRING)

mission.reward =
{
    rankPoints = 400,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 111 then
        mission:begin(player)
    end
end

mission.sections =
{
    -- Player has no active missions
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            onEventFinish =
            {
                [1009] = handleAcceptMission,
                [2009] = handleAcceptMission,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            onEventFinish =
            {
                [1009] = handleAcceptMission,
            },
        },
    },

    -- First time the player has accepted this mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and not player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Chalvatot'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        return mission:progressEvent(556)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if
                        prevZone == xi.zone.NORTHERN_SAN_DORIA and
                        player:getMissionStatus(mission.areaId) == 2
                    then
                        return 555
                    end
                end,
            },

            onEventFinish =
            {
                [555] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                end,

                [556] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Ambrotien'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:messageText(southernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 68):setPriority(1000)
                    elseif missionStatus == 2 then
                        return mission:progressEvent(2031)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.CRYSTAL_BASS) then
                        return mission:progressEvent(2030)
                    end
                end,
            },

            ['Endracion'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:messageText(southernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 68):setPriority(1000)
                    elseif missionStatus == 2 then
                        return mission:progressEvent(1031)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.CRYSTAL_BASS) then
                        return mission:progressEvent(1030)
                    end
                end,
            },

            onEventFinish =
            {
                [1030] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:setMissionStatus(mission.areaId, 2)
                end,

                [2030] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Grilau'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:messageText(northernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 68):setPriority(1000)
                    elseif missionStatus == 2 then
                        return mission:progressEvent(1031)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.CRYSTAL_BASS) then
                        return mission:progressEvent(1030)
                    end
                end,
            },

            onEventFinish =
            {
                [1030] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },
    },

    -- Player is repeating this mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Ambrotien'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:messageText(southernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 68):setPriority(1000)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.CRYSTAL_BASS) then
                        return mission:progressEvent(2013)
                    end
                end,
            },

            ['Endracion'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:messageText(southernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 68):setPriority(1000)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.CRYSTAL_BASS) then
                        return mission:progressEvent(1013)
                    end
                end,
            },

            onEventFinish =
            {
                [1013] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:confirmTrade()
                    end
                end,

                [2013] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Grilau'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:messageText(northernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 68):setPriority(1000)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.CRYSTAL_BASS) then
                        return mission:progressEvent(1013)
                    end
                end,
            },

            onEventFinish =
            {
                [1013] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return mission
