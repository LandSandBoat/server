-----------------------------------
-- Enter the Talekeeper
-- Bastok M8-2
-----------------------------------
-- !addmission 1 21
-- Argus      : !pos 132.157 7.496 -2.187 236
-- Cleades    : !pos -358 -10 -168 235
-- Malduc     : !pos 66.200 -14.999 4.426 237
-- Rashid     : !pos -8.444 -2 -123.575 234
-- Drake Fang : !pos -74 0.1 58 172
-- qm5        : !pos -29.195 -22.159 -183.716 174
-- qm6        : !pos -27.964 -10.358 -185.768 174
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local bastokMarketsID = require('scripts/zones/Bastok_Markets/IDs')
local bastokMinesID   = require('scripts/zones/Bastok_Mines/IDs')
local metalworksID    = require('scripts/zones/Metalworks/IDs')
local portBastokID    = require('scripts/zones/Port_Bastok/IDs')
local kuftalID        = require('scripts/zones/Kuftal_Tunnel/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.ENTER_THE_TALEKEEPER)

mission.reward =
{
    gil = 80000,
    rank = 9,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 21 then
        mission:begin(player)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

local isGhostsAlive = function()
    for i = 0, 2 do
        local ghostMob = GetMobByID(kuftalID.mob.TALEKEEPER_OFFSET + i)
        if
            ghostMob:isSpawned() and
            not ghostMob:isDead()
        then
            return true
        end
    end

    return false
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.METALWORKS] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Cleades'] = mission:messageSpecial(bastokMarketsID.text.EXTENDED_MISSION_OFFSET + 12),
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Rashid'] = mission:messageSpecial(bastokMinesID.text.EXTENDED_MISSION_OFFSET + 12),

            onZoneIn =
            {
                function(player, prevZone)
                    -- This is a continuation of event 204 from Zeruhn Mines.  Player is teleported
                    -- here automatically, and this event will finish the sequence and complete the
                    -- mission.
                    if
                        prevZone == xi.zone.ZERUHN_MINES and
                        player:getMissionStatus(mission.areaId) == 5
                    then
                        return 176
                    end
                end,
            },

            onEventFinish =
            {
                [176] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.OLD_PIECE_OF_WOOD)
                    end
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Malduc'] = mission:messageSpecial(metalworksID.text.EXTENDED_MISSION_OFFSET + 12),
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] = mission:messageSpecial(portBastokID.text.EXTENDED_MISSION_OFFSET + 12),
        },

        [xi.zone.ZERUHN_MINES] =
        {
            ['Drake_Fang'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(202)
                    elseif missionStatus >= 1 and missionStatus < 4 then
                        return mission:event(203)
                    elseif missionStatus == 4 then
                        return mission:progressEvent(204)
                    end
                end,
            },

            onEventFinish =
            {
                [202] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [204] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 5)
                    player:setPos(23, 0, 4)
                end,
            },
        },

        [xi.zone.KUFTAL_TUNNEL] =
        {
            ['qm5'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(12)
                    end
                end,
            },

            ['qm6'] =
            {
                onTrigger = function(player, npc)
                    local anyGhostsAlive = isGhostsAlive()

                    if
                        player:getMissionStatus(player:getNation()) == 2 and
                        not anyGhostsAlive
                    then
                        for i = 0, 2 do
                            SpawnMob(kuftalID.mob.TALEKEEPER_OFFSET + i)
                        end

                        return mission:messageSpecial(kuftalID.text.EVIL)
                    elseif
                        player:getMissionStatus(player:getNation()) == 3 and
                        not anyGhostsAlive
                    then
                        return mission:progressEvent(13)
                    end
                end,
            },

            ['Dervos_Ghost'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        player:getMissionStatus(mission.areaId) == 2 and
                        not isGhostsAlive()
                    then
                        player:setMissionStatus(mission.areaId, 3)
                    end
                end,
            },

            ['Gizerls_Ghost'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        player:getMissionStatus(mission.areaId) == 2 and
                        not isGhostsAlive()
                    then
                        player:setMissionStatus(mission.areaId, 3)
                    end
                end,
            },

            ['Gordovs_Ghost'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        player:getMissionStatus(mission.areaId) == 2 and
                        not isGhostsAlive()
                    then
                        player:setMissionStatus(mission.areaId, 3)
                    end
                end,
            },

            onEventFinish =
            {
                [12] = function(player, csid, option, npc)
                    if option == 0 then
                        player:setMissionStatus(mission.areaId, 2)
                        player:messageSpecial(kuftalID.text.FELL)
                    end
                end,

                [13] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                    npcUtil.giveKeyItem(player, xi.ki.OLD_PIECE_OF_WOOD)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:getNation() == xi.nation.BASTOK and
                player:getCurrentMission(mission.areaId) == xi.mission.id.bastok.NONE and
                player:hasCompletedMission(mission.areaId, mission.missionId) and
                not player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_SALT_OF_THE_EARTH)
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Detzo']  = mission:event(184):importantOnce(),
            ['Gumbah'] = mission:event(183):importantOnce(),
            ['Pavvke'] = mission:event(76, 1):importantOnce(),
        },

        [xi.zone.METALWORKS] =
        {
            ['Iron_Eater'] = mission:event(769):importantOnce(),
        },
    },
}

return mission
