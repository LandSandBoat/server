-----------------------------------
-- The Ruins of Fei'Yin
-- San d'Oria M5-1
-----------------------------------
-- No active missions, Rank 4, !addkeyitem 69
-- Ambrotien : !pos 93.419 -0.001 -57.347 230
-- Grilau    : !pos -241.987 6.999 57.887 231
-- Endracion : !pos -110 1 -34 230
-- Halver    : !pos 2 0.1 0.1 233
-- _6h0      : !pos -38 -3 73 233
-- Curilla   : !pos 27 0.1 0.1 233
-- Rahal     : !pos -28 0.1 -6 233
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/titles')
require('scripts/settings/main')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local chateauID = require('scripts/zones/Chateau_dOraguille/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_RUINS_OF_FEI_YIN)

mission.reward =
{
    rankPoints = 400,
}

-- The message KI is removed here to still preserve this mission should a player decline and
-- then choose to change nations.  By retaining it until this point, we'll still have a point
-- of reference to return to should missionStatus be reset.
local handleAcceptMission = function(player, csid, option, npc)
    if option == 14 then
        mission:begin(player)
        player:setMissionStatus(mission.areaId, 9)
        player:delKeyItem(xi.ki.MESSAGE_TO_JEUNO_SANDORIA)
    end
end

mission.sections =
{
    -- Player meets requirements, but has not started the mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId and
                player:getRank(player:getNation()) == 5 and
                not player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Ambrotien'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(62)
                    end
                end,
            },

            ['Endracion'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(61)
                    end
                end,
            },

            onEventFinish =
            {
                [1009] = handleAcceptMission,
                [2009] = handleAcceptMission,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Grilau'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(61)
                    end
                end,
            },

            onEventFinish =
            {
                [1009] = handleAcceptMission,
            },
        },

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if
                        prevZone == xi.zone.NORTHERN_SAN_DORIA and
                        player:getMissionStatus(mission.areaId) == 0
                    then
                        return 509
                    end
                end,
            },

            onEventFinish =
            {
                [509] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 8)
                end,
            },
        },
    },

    -- Mission has been accepted
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

                    if missionStatus == 9 then
                        return mission:progressEvent(533)
                    elseif missionStatus == 10 then
                        return mission:messageText(chateauID.text.HALVER_OFFSET + 334):setPriority(1000)
                    elseif missionStatus == 12 and player:hasKeyItem(xi.ki.BURNT_SEAL) then
                        return mission:progressEvent(534)
                    end
                end,
            },

            onEventFinish =
            {
                [533] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.NEW_FEIYIN_SEAL)
                    player:setMissionStatus(mission.areaId, 10)
                end,

                [534] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.BURNT_SEAL)
                    end
                end,
            },
        },

        [xi.zone.FEIYIN] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 10 then
                        return 1
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 11)
                end,
            },
        },

        [xi.zone.QUBIA_ARENA] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 11 and
                        player:getLocalVar('battlefieldWin') == 512
                    then
                        npcUtil.giveKeyItem(player, xi.ki.BURNT_SEAL)
                        player:setMissionStatus(mission.areaId, 12)
                        player:delKeyItem(xi.ki.NEW_FEIYIN_SEAL)
                    end
                end,
            },
        },
    },

    -- Optional Dialogue after Completion
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId) and
                currentMission ~= xi.mission.id.sandoria.THE_SHADOW_LORD and
                player:getRank(mission.areaId) == 5
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['_6h0']    = mission:progressEvent(115),
            ['Curilla'] = mission:progressEvent(545),
            ['Rahal']   = mission:progressEvent(544),
        },
    },
}

return mission
