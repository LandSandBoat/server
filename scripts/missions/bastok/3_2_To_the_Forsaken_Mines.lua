-----------------------------------
-- To the Forsaken Mines
-- Bastok M3-2
-----------------------------------
-- !addmission 1 11
-- Argus        : !pos 132.157 7.496 -2.187 236
-- Cleades      : !pos -358 -10 -168 235
-- Malduc       : !pos 66.200 -14.999 4.426 237
-- Rashid       : !pos -8.444 -2 -123.575 234
-- Davyad       : !pos 83 0 30 234
-- qm2 (Gusgen) : !pos 206 -60 -101 196
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local bastokMarketsID = require("scripts/zones/Bastok_Markets/IDs")
local bastokMinesID   = require("scripts/zones/Bastok_Mines/IDs")
local gusgenID        = require("scripts/zones/Gusgen_Mines/IDs")
local metalworksID    = require("scripts/zones/Metalworks/IDs")
local portBastokID    = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.TO_THE_FORSAKEN_MINES)

mission.reward =
{
    rankPoints = 400,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 11 then
        mission:begin(player)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

local handleMissionTrade = function(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, xi.items.GLOCOLITE) then
        if player:hasCompletedMission(mission.areaId, mission.missionId) then
            return mission:progressEvent(1006)
        else
            return mission:progressEvent(1010)
        end
    end
end

local handleTradeEventFinish = function(player, csid, option, npc)
    player:confirmTrade()
    mission:complete(player)
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
            ['Cleades'] =
            {
                onTrade = handleMissionTrade,
                onTrigger = mission:messageSpecial(bastokMarketsID.text.ORIGINAL_MISSION_OFFSET + 30),
            },

            onEventFinish =
            {
                [1006] = handleTradeEventFinish,
                [1010] = handleTradeEventFinish,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Davyad'] = mission:progressEvent(54),
            ['Rashid'] =
            {
                onTrade = handleMissionTrade,
                onTrigger = mission:messageSpecial(bastokMinesID.text.ORIGINAL_MISSION_OFFSET + 30),
            },

            onEventFinish =
            {
                [1006] = handleTradeEventFinish,
                [1010] = handleTradeEventFinish,
            },
        },

        [xi.zone.GUSGEN_MINES] =
        {
            ['qm2'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        player:checkDistance(npc) <= 1.6 and
                        npcUtil.tradeHasExactly(trade, xi.items.SLICE_OF_HARE_MEAT) and
                        not player:findItem(xi.items.GLOCOLITE) and
                        npcUtil.popFromQM(player, npc, gusgenID.mob.BLIND_MOBY, { hide = 180 })
                    then
                        player:confirmTrade()
                        return mission:messageSpecial(gusgenID.text.YOU_PUT_ITEM_DOWN, xi.items.SLICE_OF_HARE_MEAT)
                    else
                        return mission:messageSpecial(gusgenID.text.NOTHING_SEEMS_HAPPENING)
                    end
                end,

                onTrigger = mission:messageSpecial(gusgenID.text.FRESH_MONSTER_TRACKS),
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Malduc'] =
            {
                onTrade = handleMissionTrade,
                onTrigger = mission:messageSpecial(metalworksID.text.ORIGINAL_MISSION_OFFSET + 30),
            },

            onEventFinish =
            {
                [1006] = handleTradeEventFinish,
                [1010] = handleTradeEventFinish,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] =
            {
                onTrade = handleMissionTrade,
                onTrigger = mission:messageSpecial(portBastokID.text.ORIGINAL_MISSION_OFFSET + 30),
            },

            onEventFinish =
            {
                [1006] = handleTradeEventFinish,
                [1010] = handleTradeEventFinish,
            },
        },
    },
}

return mission
