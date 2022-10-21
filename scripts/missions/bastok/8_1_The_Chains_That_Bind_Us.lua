-----------------------------------
-- The Chains That Bind Us
-- Bastok M8-1
-----------------------------------
-- !addmission 1 20
-- Argus      : !pos 132.157 7.496 -2.187 236
-- Cleades    : !pos -358 -10 -168 235
-- Malduc     : !pos 66.200 -14.999 4.426 237
-- Rashid     : !pos -8.444 -2 -123.575 234
-- Iron Eater : !pos 92.936 -19.532 1.814 237
-- qm6        : !pos -469 0 620 208
-- qm4        : !pos -533 -0.851 -415
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local bastokMarketsID = require('scripts/zones/Bastok_Markets/IDs')
local bastokMinesID   = require('scripts/zones/Bastok_Mines/IDs')
local metalworksID    = require('scripts/zones/Metalworks/IDs')
local portBastokID    = require('scripts/zones/Port_Bastok/IDs')
local quicksandID     = require('scripts/zones/Quicksand_Caves/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_CHAINS_THAT_BIND_US)

mission.reward =
{
    rankPoints = 1133,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 20 then
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
            ['Cleades'] = mission:messageSpecial(bastokMarketsID.text.EXTENDED_MISSION_OFFSET + 10),
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Rashid'] = mission:messageSpecial(bastokMinesID.text.EXTENDED_MISSION_OFFSET + 10),
        },

        [xi.zone.METALWORKS] =
        {
            ['Iron_Eater'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(767)
                    elseif missionStatus == 3 then
                        -- TODO: This needs to move to IDs.lua, and de-magic-number it
                        return mission:messageText(8596)
                    elseif missionStatus == 4 then
                        return mission:progressEvent(768)
                    end
                end,
            },

            ['Malduc'] = mission:messageSpecial(metalworksID.text.EXTENDED_MISSION_OFFSET + 10),

            onEventFinish =
            {
                [767] = function(player, csid, option, npc)
                    if option == 0 then
                        player:setMissionStatus(mission.areaId, 1)
                    end
                end,

                [768] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] = mission:messageSpecial(portBastokID.text.EXTENDED_MISSION_OFFSET + 10),
        },

        [xi.zone.QUICKSAND_CAVES] =
        {
            ['qm4'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        return mission:progressEvent(10)
                    end
                end,
            },

            ['qm6'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if
                        missionStatus == 1 and
                        not GetMobByID(quicksandID.mob.CENTURIO_IV_VII):isSpawned() and
                        not GetMobByID(quicksandID.mob.TRIARIUS_IV_XIV):isSpawned() and
                        not GetMobByID(quicksandID.mob.PRINCEPS_IV_XLV):isSpawned()
                    then
                        SpawnMob(quicksandID.mob.CENTURIO_IV_VII):updateClaim(player)
                        SpawnMob(quicksandID.mob.TRIARIUS_IV_XIV):updateClaim(player)
                        SpawnMob(quicksandID.mob.PRINCEPS_IV_XLV):updateClaim(player)
                        return mission:messageSpecial(quicksandID.text.SENSE_OF_FOREBODING)
                    elseif missionStatus == 2 then
                        return mission:progressEvent(11)
                    end
                end,
            },

            ['Centurio_IV-VII'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        player:getMissionStatus(mission.areaId) == 1 and
                        (GetMobByID(quicksandID.mob.TRIARIUS_IV_XIV):isDead() or not GetMobByID(quicksandID.mob.TRIARIUS_IV_XIV):isSpawned()) and
                        (GetMobByID(quicksandID.mob.PRINCEPS_IV_XLV):isDead() or not GetMobByID(quicksandID.mob.PRINCEPS_IV_XLV):isSpawned())
                    then
                        player:setMissionStatus(mission.areaId, 2)
                    end
                end,
            },

            ['Princeps_IV-XLV'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        player:getMissionStatus(mission.areaId) == 1 and
                        (GetMobByID(quicksandID.mob.CENTURIO_IV_VII):isDead() or not GetMobByID(quicksandID.mob.CENTURIO_IV_VII):isSpawned()) and
                        (GetMobByID(quicksandID.mob.TRIARIUS_IV_XIV):isDead() or not GetMobByID(quicksandID.mob.TRIARIUS_IV_XIV):isSpawned())
                    then
                        player:setMissionStatus(mission.areaId, 2)
                    end
                end,
            },

            ['Triarius_IV-XIV'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        player:getMissionStatus(mission.areaId) == 1 and
                        (GetMobByID(quicksandID.mob.CENTURIO_IV_VII):isDead() or not GetMobByID(quicksandID.mob.CENTURIO_IV_VII):isSpawned()) and
                        (GetMobByID(quicksandID.mob.PRINCEPS_IV_XLV):isDead() or not GetMobByID(quicksandID.mob.PRINCEPS_IV_XLV):isSpawned())
                    then
                        player:setMissionStatus(mission.areaId, 2)
                    end
                end,
            },

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                end,

                [11] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                end,
            },
        },
    },
}

return mission
