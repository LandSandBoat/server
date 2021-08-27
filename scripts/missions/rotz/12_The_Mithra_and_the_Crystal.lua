-----------------------------------
-- The Mithra and the Crystal
-- Zilart M12
-----------------------------------
-- !addmission 3 23
-- Gilgamesh       : !pos 122.452 -9.009 -12.052 252
-- Maryoh_Comyujah : !pos 0 8 73 247
-- qm7             : !pos -504 20 -419 208
-- _6z0            : !pos 0 -12 48 251
-----------------------------------
require('scripts/globals/interaction/mission')
require("scripts/globals/keyitems")
require('scripts/globals/missions')
require("scripts/globals/titles")
require('scripts/globals/zone')
-----------------------------------
local quicksandCavesID = require("scripts/zones/Quicksand_Caves/IDs")
local rabaoID          = require("scripts/zones/Rabao/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL)

mission.reward =
{
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_GATE_OF_THE_GODS },
}

mission.sections =
{
    -- Section: Mission Active
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['Gilgamesh'] = mission:event(170),
        },

        [xi.zone.RABAO] =
        {
            ['Maryoh_Comyujah'] = mission:event(82),
        },
    },

    -- Section: Mission Active, missionStatus == 0
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.RABAO] =
        {
            ['Maryoh_Comyujah'] = mission:progressEvent(81),

            onEventFinish =
            {
                [81] = function(player, csid, option, npc)
                    if option == 1 then
                        player:setMissionStatus(xi.mission.log_id.ZILART, 1)
                    end
                end,
            },
        },
    },

    -- Section: Mission Active, missionStatus == 1, does not have Scrap of Papyrus
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1 and not player:hasKeyItem(xi.ki.SCRAP_OF_PAPYRUS)
        end,

        [xi.zone.QUICKSAND_CAVES] =
        {
            ['qm7'] = {
                onTrigger = function(player, npc)
                    if player:needToZone() and player:getCharVar("AncientVesselKilled") == 1 then
                        player:setCharVar("AncientVesselKilled", 0)
                        player:addKeyItem(xi.ki.SCRAP_OF_PAPYRUS)
                        return mission:messageSpecial(quicksandCavesID.text.KEYITEM_OBTAINED, xi.ki.SCRAP_OF_PAPYRUS)
                    else
                        return mission:event(12)
                    end
                end,
            },

            onEventFinish =
            {
                [12] = function(player, csid, option, npc)
                    if option == 1 then
                        SpawnMob(quicksandCavesID.mob.ANCIENT_VESSEL):updateClaim(player)
                    end
                end,
            },
        },
    },

    -- Section: Mission Active, has Scrap of Papyrus
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and player:hasKeyItem(xi.ki.SCRAP_OF_PAPYRUS)
        end,

        [xi.zone.RABAO] =
        {
            ['Maryoh_Comyujah'] = mission:progressEvent(83),

            onEventFinish =
            {
                [83] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.ZILART, 2)
                    player:delKeyItem(xi.ki.SCRAP_OF_PAPYRUS)
                    player:addKeyItem(xi.ki.CERULEAN_CRYSTAL)
                    return mission:messageSpecial(rabaoID.text.KEYITEM_OBTAINED, xi.ki.CERULEAN_CRYSTAL)
                end,
            },
        },
    },

    -- Section: Mission Active, missionStatus == 2
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 2
        end,

        [xi.zone.RABAO] =
        {
            ['Maryoh_Comyujah'] = mission:progressEvent(84),
        },
    },

    -- Section: Mission Active, has Cerulean Crystal
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and player:hasKeyItem(xi.ki.CERULEAN_CRYSTAL)
        end,

        [xi.zone.HALL_OF_THE_GODS] =
        {
            ['_6z0'] = mission:progressEvent(4),

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.ZILART, 0)
                    mission:complete(player)
                end,
            },
        },
    },

    -- Section: Mission Completed or Papyrus KI has been obtained
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId) or player:hasKeyItem(xi.ki.SCRAP_OF_PAPYRUS)
        end,

        [xi.zone.QUICKSAND_CAVES] =
        {
            ['qm7'] = mission:messageSpecial(quicksandCavesID.text.YOU_FIND_NOTHING),
        },
    },

    -- Section: Mission Completed, Permanent Dialogue Change
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.RABAO] =
        {
            ['Maryoh_Comyujah'] = mission:progressEvent(85),
        },
    },
}

return mission
