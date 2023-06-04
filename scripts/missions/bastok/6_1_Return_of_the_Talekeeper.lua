-----------------------------------
-- Return of the Talekeeper
-- Bastok M6-1
-----------------------------------
-- !addmission 1 16
-- Argus          : !pos 132.157 7.496 -2.187 236
-- Cleades        : !pos -358 -10 -168 235
-- Malduc         : !pos 66.200 -14.999 4.426 237
-- Rashid         : !pos -8.444 -2 -123.575 234
-- Medicine Eagle : !pos -40 0 38 234
-- Drake Fang     : !pos -74 0.1 58 172
-- qm2 (W.Altepa) : !pos -325 0 -111 125
-- Tall Mountain  : !pos 71 7 -7 234
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local bastokMarketsID = require('scripts/zones/Bastok_Markets/IDs')
local bastokMinesID   = require('scripts/zones/Bastok_Mines/IDs')
local metalworksID    = require('scripts/zones/Metalworks/IDs')
local portBastokID    = require('scripts/zones/Port_Bastok/IDs')
local westernAltepaID = require('scripts/zones/Western_Altepa_Desert/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.RETURN_OF_THE_TALEKEEPER)

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
            ['Cleades'] = mission:messageSpecial(bastokMarketsID.text.EXTENDED_MISSION_OFFSET),
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Medicine_Eagle'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(180)
                    else
                        return mission:event(181)
                    end
                end,
            },

            ['Rashid'] = mission:messageSpecial(bastokMinesID.text.EXTENDED_MISSION_OFFSET),

            ['Tall_Mountain'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        return mission:progressEvent(182)
                    end
                end,
            },

            onEventFinish =
            {
                [180] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [182] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.ALTEPA_MOONPEBBLE)
                    end
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Malduc'] = mission:messageSpecial(metalworksID.text.EXTENDED_MISSION_OFFSET),
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] = mission:messageSpecial(portBastokID.text.EXTENDED_MISSION_OFFSET),
        },

        [xi.zone.ZERUHN_MINES] =
        {
            ['Drake_Fang'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus > 1 then
                        return mission:progressEvent(201)
                    elseif missionStatus == 1 then
                        return mission:progressEvent(200)
                    end
                end,
            },

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },

        [xi.zone.WESTERN_ALTEPA_DESERT] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    local mobEasternSphinx = GetMobByID(westernAltepaID.mob.EASTERN_SPHINX)
                    local mobWesternSphinx = GetMobByID(westernAltepaID.mob.WESTERN_SPHINX)

                    if mission:getLocalVar(player, 'nmDefeated') == 1 then
                        player:setMissionStatus(mission.areaId, 3)
                        return mission:keyItem(xi.ki.ALTEPA_MOONPEBBLE)
                    elseif
                        player:getMissionStatus(mission.areaId) == 2 and
                        (not mobEasternSphinx:isSpawned() or mobEasternSphinx:isDead()) and
                        (not mobWesternSphinx:isSpawned() or mobWesternSphinx:isDead())
                    then
                        SpawnMob(westernAltepaID.mob.EASTERN_SPHINX)
                        SpawnMob(westernAltepaID.mob.WESTERN_SPHINX)
                        return mission:messageSpecial(westernAltepaID.text.EVIL_LOOMING_ABOVE_YOU)
                    end
                end,
            },

            ['Eastern_Sphinx'] =
            {
                onMobDeath = function(mob, player, optParams)
                    local mobWesternSphinx = GetMobByID(westernAltepaID.mob.WESTERN_SPHINX)

                    if
                        player:getMissionStatus(mission.areaId) == 2 and
                        (mobWesternSphinx:isDead() or not mobWesternSphinx:isSpawned())
                    then
                        mission:setLocalVar(player, 'nmDefeated', 1)
                    end
                end,
            },

            ['Western_Sphinx'] =
            {
                onMobDeath = function(mob, player, optParams)
                    local mobEasternSphinx = GetMobByID(westernAltepaID.mob.EASTERN_SPHINX)

                    if
                        player:getMissionStatus(mission.areaId) == 2 and
                        (mobEasternSphinx:isDead() or not mobEasternSphinx:isSpawned())
                    then
                        mission:setLocalVar(player, 'nmDefeated', 1)
                    end
                end,
            },
        },
    },
}

return mission
