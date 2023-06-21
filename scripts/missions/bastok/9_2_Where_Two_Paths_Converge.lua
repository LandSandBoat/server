-----------------------------------
-- Where Two Paths Converge
-- Bastok M9-2
-----------------------------------
-- !addmission 1 23
-- Argus      : !pos 132.157 7.496 -2.187 236
-- Cleades    : !pos -358 -10 -168 235
-- Malduc     : !pos 66.200 -14.999 4.426 237
-- Rashid     : !pos -8.444 -2 -123.575 234
-- Iron Eater : !pos 92.936 -19.532 1.814 237
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
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE)

mission.reward =
{
    rank = 10,
    gil = 100000,
    title = xi.title.HERO_AMONG_HEROES,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 23 then
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
            ['Cleades'] = mission:messageSpecial(bastokMarketsID.text.EXTENDED_MISSION_OFFSET + 19),
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Rashid'] = mission:messageSpecial(bastokMinesID.text.EXTENDED_MISSION_OFFSET + 19),
        },

        [xi.zone.METALWORKS] =
        {
            ['Iron_Eater'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(780)
                    elseif missionStatus == 2 then
                        return mission:progressEvent(782)
                    end
                end,
            },

            ['Malduc'] = mission:messageSpecial(metalworksID.text.EXTENDED_MISSION_OFFSET + 19),

            onEventFinish =
            {
                [780] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                -- It is possible to obtain the Bastokan flag after completing this mission
                -- should inventory be full.  Set 'Flag' mission variable should this occur.
                [782] = function(player, csid, option, npc)
                    mission:complete(player)

                    if not npcUtil.giveItem(player, xi.items.BASTOKAN_FLAG) then
                        mission:setVar(player, 'Flag', 1)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] = mission:messageSpecial(portBastokID.text.EXTENDED_MISSION_OFFSET + 19),
        },

        [xi.zone.THRONE_ROOM] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 1 and
                        player:getLocalVar('battlefieldWin') == 161
                    then
                        player:setMissionStatus(mission.areaId, 2)
                    end
                end,
            },
        },
    },

    -- Player has completed this mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.METALWORKS] =
        {
            ['Iron_Eater'] =
            {
                -- If the player's inventory was full on mission complete, give them the
                -- nation flag, and clear the variable.  This could probably be short circuited
                -- with one conditional, but playing it safe.
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Flag') == 1 then
                        if npcUtil.giveItem(player, xi.items.BASTOKAN_FLAG) then
                            mission:setVar(player, 'Flag', 0)
                        end
                    end
                end,
            },
        },
    },
}

return mission
