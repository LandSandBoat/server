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
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------
local quicksandCavesID = require('scripts/zones/Quicksand_Caves/IDs')
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
            ['Maryoh_Comyujah'] =
            {
                onTrigger = function(player, npc)
                    local hasDeclined = mission:getVar(player, 'Option')

                    return mission:progressEvent(81, 247, 1, 0, 708, 5, 1, 279, hasDeclined)
                end,
            },

            onEventFinish =
            {
                [81] = function(player, csid, option, npc)
                    if option == 1 then
                        player:setMissionStatus(xi.mission.log_id.ZILART, 1)
                    else
                        mission:setVar(player, 'Option', 1)
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
            ['qm7'] =
            {
                onTrigger = function(player, npc)
                    if mission:getLocalVar(player, 'nmDefeated') == 1 then
                        return mission:progressEvent(13)
                    else
                        return mission:progressEvent(12)
                    end
                end,
            },

            ['Ancient_Vessel'] =
            {
                onMobDeath = function(mob, player, optParams)
                    mission:setLocalVar(player, 'nmDefeated', 1)
                end,
            },

            onEventFinish =
            {
                [12] = function(player, csid, option, npc)
                    if option == 1 then
                        player:messageSpecial(quicksandCavesID.text.SOMETHING_ATTACKING_YOU)

                        SpawnMob(quicksandCavesID.mob.ANCIENT_VESSEL):updateClaim(player)
                    end
                end,

                [13] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.SCRAP_OF_PAPYRUS)
                    end
                end,
            },
        },
    },

    -- Section: Mission Active, has Scrap of Papyrus
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:hasKeyItem(xi.ki.SCRAP_OF_PAPYRUS)
        end,

        [xi.zone.RABAO] =
        {
            ['Maryoh_Comyujah'] = mission:progressEvent(83),

            onEventFinish =
            {
                [83] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.SCRAP_OF_PAPYRUS)
                    npcUtil.giveKeyItem(player, xi.ki.CERULEAN_CRYSTAL)
                    player:setMissionStatus(xi.mission.log_id.ZILART, 2)
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
            ['_6z0']              = mission:progressEvent(4),
            ['Shimmering_Circle'] = mission:progressEvent(3),

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },

    -- Section: Mission Completed or Papyrus KI has been obtained
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId) or
                player:hasKeyItem(xi.ki.SCRAP_OF_PAPYRUS)
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
