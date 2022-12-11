-----------------------------------
-- The Jester Who'd be King
-- Windurst M8-2
-----------------------------------
-- !addmission 2 21
-- Rakoh Buuma      : !pos 106 -5 -23 241
-- Mokyokyo         : !pos -55 -8 227 238
-- Janshura-Rashura : !pos -227 -8 184 240
-- Zokima-Rokima    : !pos 0 -16 124 239
-- Apururu          : !pos -11 -2 13 241
-- Cermet Door(Ruk) : !pos -183 0 190 204
-- Sedal-Godjal     : !pos 185 -3 -116 149
-- Tosuka-Porika    : !pos -26 -6 103 238
-- Kupipi           : !pos 2 0.1 30 242
-- Shantotto        : !pos 122 -2 112 239
-- _5e5 (Cr. Wall)  : !pos -424.255 -1.909 619.995 194
-- _5cb (Gate. Drk) : !pos -228 0 99 192
require('scripts/globals/interaction/mission')
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/zone')
-----------------------------------
local outerHorutotoID = require("scripts/zones/Outer_Horutoto_Ruins/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_JESTER_WHOD_BE_KING)

mission.reward =
{
    gil  = 80000,
    rank = 9,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 21 then
        mission:begin(player)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
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

        [xi.zone.DAVOI] =
        {
            ['Sedal-Godjal'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 1 and
                        not player:hasKeyItem(xi.ki.AURASTERY_RING)
                    then
                        return mission:progressEvent(122, 0, xi.ki.AURASTERY_RING)
                    end
                end,
            },

            onEventFinish =
            {
                [122] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.AURASTERY_RING)

                    if
                        player:hasKeyItem(xi.ki.RHINOSTERY_RING) and
                        player:hasKeyItem(xi.ki.OPTISTERY_RING)
                    then
                        player:setMissionStatus(mission.areaId, 2)
                    end
                end,
            },
        },

        [xi.zone.FEIYIN] =
        {
            ['_no4'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 1 and
                        not player:hasKeyItem(xi.ki.RHINOSTERY_RING)
                    then
                        return mission:progressEvent(22, 0, xi.ki.RHINOSTERY_RING)
                    end
                end,
            },

            onEventFinish =
            {
                [22] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.RHINOSTERY_RING)

                    if
                        player:hasKeyItem(xi.ki.AURASTERY_RING) and
                        player:hasKeyItem(xi.ki.OPTISTERY_RING)
                    then
                        player:setMissionStatus(mission.areaId, 2)
                    end
                end,
            },
        },

        [xi.zone.HEAVENS_TOWER] =
        {
            ['Kupipi'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        return mission:progressEvent(326, 0, xi.ki.ORASTERY_RING)
                    end
                end,
            },

            onEventFinish =
            {
                [326] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                end,
            },
        },

        [xi.zone.INNER_HORUTOTO_RUINS] =
        {
            ['_5cb'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 9 then
                        return mission:progressEvent(75)
                    end
                end,
            },

            onEventFinish =
            {
                [75] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 10)
                end,
            },
        },

        [xi.zone.OUTER_HORUTOTO_RUINS] =
        {
            ['_5e5'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if
                        missionStatus == 4 and
                        not GetMobByID(outerHorutotoID.mob.JESTER_WHOD_BE_KING_OFFSET + 0):isSpawned() and
                        not GetMobByID(outerHorutotoID.mob.JESTER_WHOD_BE_KING_OFFSET + 1):isSpawned()
                    then
                        SpawnMob(outerHorutotoID.mob.JESTER_WHOD_BE_KING_OFFSET + 0)
                        SpawnMob(outerHorutotoID.mob.JESTER_WHOD_BE_KING_OFFSET + 1)
                    elseif missionStatus == 5 then
                        return mission:progressEvent(71)
                    end
                end,
            },

            ['Queen_of_Coins'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        player:getMissionStatus(mission.areaId) == 4 and
                        GetMobByID(mob:getID() - 1):isDead()
                    then
                        player:setMissionStatus(mission.areaId, 5)
                    end
                end,
            },

            ['Queen_of_Swords'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        player:getMissionStatus(mission.areaId) == 4 and
                        GetMobByID(mob:getID() + 1):isDead()
                    then
                        player:setMissionStatus(mission.areaId, 5)
                    end
                end,
            },

            onEventFinish =
            {
                [71] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.ORASTERY_RING)
                    player:setMissionStatus(mission.areaId, 6)
                end,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 7 then
                        return mission:progressEvent(397, 0, 0, 0, 282)
                    end
                end,
            },

            onEventFinish =
            {
                [397] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.GLOVE_OF_PERPETUAL_TWILIGHT)
                    player:setMissionStatus(mission.areaId, 8)
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Tosuka-Porika'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 1 and
                        not player:hasKeyItem(xi.ki.OPTISTERY_RING)
                    then
                        return mission:progressEvent(801, 0, xi.ki.OPTISTERY_RING)
                    end
                end,
            },

            onEventFinish =
            {
                [801] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.OPTISTERY_RING)
                    if
                        player:hasKeyItem(xi.ki.RHINOSTERY_RING) and
                        player:hasKeyItem(xi.ki.AURASTERY_RING)
                    then
                        player:setMissionStatus(mission.areaId, 2)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Apururu'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(588, 0, xi.ki.MANUSTERY_RING)
                    elseif missionStatus == 2 then
                        return mission:progressEvent(601, 0, xi.ki.ORASTERY_RING)
                    elseif missionStatus == 6 then
                        return mission:progressEvent(590)
                    elseif missionStatus == 7 then
                        return mission:progressEvent(589)
                    elseif missionStatus == 8 then
                        return mission:progressEvent(592)
                    elseif missionStatus == 10 then
                        return mission:progressEvent(609)
                    end
                end,
            },

            onEventFinish =
            {
                [588] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                    npcUtil.giveKeyItem(player, xi.ki.MANUSTERY_RING)
                end,

                [590] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 7)
                end,

                [592] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 9)
                end,

                [601] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                end,

                [609] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        -- Optional CS with Shantotto
                        mission:setVar(player, 'Option', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId) and
                vars.Option == 1
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] = mission:progressEvent(399, 0, 0, 282),

            onEventFinish =
            {
                [399] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 0)
                end,
            },
        },
    },
}

return mission
