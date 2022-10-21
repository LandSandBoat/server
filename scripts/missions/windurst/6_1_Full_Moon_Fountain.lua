-----------------------------------
-- Full Moon Fountain
-- Windurst M6-1
-----------------------------------
-- !addmission 2 16
-- Rakoh Buuma         : !pos 106 -5 -23 241
-- Mokyokyo            : !pos -55 -8 227 238
-- Janshura-Rashura    : !pos -227 -8 184 240
-- Zokima-Rokima       : !pos 0 -16 124 239
-- Hakkuru-Rinkuru     : !pos -111 -4 101 240
-- Gate: Magical Gizmo : !pos -291 0 -659 194
require('scripts/globals/interaction/mission')
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/zone')
-----------------------------------
local outerHorutotoID = require("scripts/zones/Outer_Horutoto_Ruins/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.FULL_MOON_FOUNTAIN)

mission.reward =
{
    rankPoints = 650,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 16 then
        mission:begin(player)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

local function areJacksSpawned()
    for mobIdOffset = 0, 3 do
        local mobObj = GetMobByID(outerHorutotoID.mob.FULL_MOON_FOUNTAIN_OFFSET + mobIdOffset)

        if mobObj:isSpawned() then
            return true
        end
    end

    return false
end

local jackOnMobDeath = function(mob, player, optParams)
    local areMobsDefeated = true

    if player:getMissionStatus(mission.areaId) ~= 1 then
        return
    end

    for mobIdOffset = 0, 3 do
        local mobObj = GetMobByID(outerHorutotoID.mob.FULL_MOON_FOUNTAIN_OFFSET + mobIdOffset)

        if
            not mobObj:isDead() and
            mobObj:isSpawned()
        then
            areMobsDefeated = false
        end
    end

    if areMobsDefeated then
        player:setMissionStatus(mission.areaId, 2)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId
        end,

        [xi.zone.PORT_WINDURST] =
        {
            onEventFinish =
            {
                [78] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            onEventFinish =
            {
                [93] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            onEventFinish =
            {
                [111] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            onEventFinish =
            {
                [114] = handleAcceptMission,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Hakkuru-Rinkuru'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(456, 0, xi.ki.SOUTHWESTERN_STAR_CHARM)
                    elseif missionStatus == 3 then
                        return mission:progressEvent(457)
                    end
                end,
            },

            onEventFinish =
            {
                [456] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                    npcUtil.giveKeyItem(player, xi.ki.SOUTHWESTERN_STAR_CHARM)
                end,
            },
        },

        [xi.zone.OUTER_HORUTOTO_RUINS] =
        {
            ['_5eb'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if not areJacksSpawned() then
                        if missionStatus == 1 then
                            for mobId = outerHorutotoID.mob.FULL_MOON_FOUNTAIN_OFFSET, outerHorutotoID.mob.FULL_MOON_FOUNTAIN_OFFSET + 3 do
                                SpawnMob(mobId)
                            end

                            return mission:messageSpecial(outerHorutotoID.text.GUARDIAN_BLOCKING_WAY)
                        elseif missionStatus == 2 then
                            return mission:progressEvent(68)
                        end
                    end
                end,
            },

            ['Jack_of_Batons'] =
            {
                onMobDeath = jackOnMobDeath,
            },

            ['Jack_of_Coins'] =
            {
                onMobDeath = jackOnMobDeath,
            },

            ['Jack_of_Cups'] =
            {
                onMobDeath = jackOnMobDeath,
            },

            ['Jack_of_Swords'] =
            {
                onMobDeath = jackOnMobDeath,
            },

            onEventFinish =
            {
                [68] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                    player:delKeyItem(xi.ki.SOUTHWESTERN_STAR_CHARM)
                end,
            },
        },

        [xi.zone.FULL_MOON_FOUNTAIN] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        return 50
                    end
                end,
            },

            onEventFinish =
            {
                [50] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
