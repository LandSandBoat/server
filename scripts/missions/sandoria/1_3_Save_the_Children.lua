-----------------------------------
-- Save the Children
-- San d'Oria M1-3
-----------------------------------
-- NOTE: This handles both the first completion and repeated
-- !addmission 0 2
-- Ambrotien  : !pos 93.419 -0.001 -57.347 230
-- Grilau     : !pos -241.987 6.999 57.887 231
-- Endracion  : !pos -110 1 -34 230
-- Arnau      : !pos 148 0 139 231
-- Hut_Door   : !pos -165.357 -11.672 77.771 140
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

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SAVE_THE_CHILDREN)

mission.reward =
{
    -- First Time Completion
    -- gil = 1000,
    -- rank = 2,

    -- Repeat Only
    -- rankPoints = 250,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 102 then
        mission:begin(player)
        player:setMissionStatus(mission.areaId, 1)
    end
end

local handleCompleteEventFinish = function(player, csid, option, npc)
    if not player:hasCompletedMission(mission.areaId, mission.missionId) then
        player:setRank(2)
        npcUtil.giveCurrency(player, 'gil', 1000)
    else
        player:addRankPoints(250)
    end

    if mission:complete(player) then
        mission:setVar(player, 'Option', 1)
    end
end

local function handleCompleteTrigger(player, firstId, repeatId)
    if not player:hasCompletedMission(mission.areaId, mission.missionId) then
        return mission:progressEvent(firstId)
    else
        return mission:progressEvent(repeatId)
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

    -- The Arnau CS is only required if the mission has not been completed before; however,
    -- it is still optional on repeat.  This is accounted for in the bcnm.lua
    -- entry requirements for the mission.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus < 3
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Arnau'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) < 2 then
                        return mission:progressEvent(693)
                    end
                end,
            },

            ['Grilau'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(1025)
                    else
                        return mission:messageText(northernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 24)
                    end
                end,
            },

            onEventFinish =
            {
                [693] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,
            }
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Ambrotien'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(2025)
                    else
                        return mission:messageText(southernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 24)
                    end
                end,
            },

            ['Endracion'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(1025)
                    else
                        return mission:messageText(southernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 24)
                    end
                end,
            },
        },

        [xi.zone.GHELSBA_OUTPOST] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == 32 then
                        npcUtil.giveKeyItem(player, xi.ki.ORCISH_HUT_KEY)
                        player:setTitle(xi.title.FODDERCHIEF_FLAYER)
                        player:setMissionStatus(mission.areaId, 3)
                    end
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 3 and
                player:hasKeyItem(xi.ki.ORCISH_HUT_KEY)
        end,

        [xi.zone.GHELSBA_OUTPOST] =
        {
            ['Hut_Door'] =
            {
                onTrigger = function(player, npc)
                    if player:hasCompletedMission(mission.areaId, mission.missionId) then
                        return mission:progressEvent(3)
                    else
                        return mission:progressEvent(55)
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.ORCISH_HUT_KEY)
                    player:setMissionStatus(mission.areaId, 4)
                end,

                [55] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.ORCISH_HUT_KEY)
                    player:setMissionStatus(mission.areaId, 4)
                end,
            },
        },
    },

    -- BCNM has been completed successfully, and Hut Door checked afterwards
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 4
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Ambrotien'] =
            {
                onTrigger = function(player, npc)
                    return handleCompleteTrigger(player, 2004, 2024)
                end,
            },

            ['Endracion'] =
            {
                onTrigger = function(player, npc)
                    return handleCompleteTrigger(player, 1004, 1024)
                end,
            },

            onEventFinish =
            {
                [1004] = handleCompleteEventFinish,
                [1024] = handleCompleteEventFinish,
                [2004] = handleCompleteEventFinish,
                [2024] = handleCompleteEventFinish,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Grilau'] =
            {
                onTrigger = function(player, npc)
                    return handleCompleteTrigger(player, 1004, 1024)
                end,
            },

            onEventFinish =
            {
                [1004] = handleCompleteEventFinish,
                [1024] = handleCompleteEventFinish,
            },
        },
    },

    -- Optional CS after completing this mission.  This var should persist until
    -- it is viewed, and is maintained after mission:complete()
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId) and
                mission:getVar(player, 'Option') == 1
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Arnau'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(694)
                end
            },

            onEventFinish =
            {
                [694] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 0)
                end,
            },
        },
    },
}

return mission
