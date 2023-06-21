-----------------------------------
-- Fetichism
-- Bastok M1-3
-----------------------------------
-- !addmission 1 2
-- Argus   : !pos 132.157 7.496 -2.187 236
-- Cleades : !pos -358 -10 -168 235
-- Malduc  : !pos 66.200 -14.999 4.426 237
-- Rashid  : !pos -8.444 -2 -123.575 234
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

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.FETICHISM)

-- npcUtil.completeMission will only award rank if less than player's current rank in
-- the nation.  Rank Points are cleared on rank up, which occurs after setting.
-- TODO: Verify gil reward occurs on repeat.
mission.reward =
{
    gil = 1000,
    rank = 2,
    rankPoints = 200,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 2 then
        mission:begin(player)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

local handleFetichTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, { xi.items.QUADAV_FETICH_HEAD, xi.items.QUADAV_FETICH_TORSO, xi.items.QUADAV_FETICH_ARMS, xi.items.QUADAV_FETICH_LEGS })
    then
        if not player:hasCompletedMission(mission.areaId, mission.missionId) then
            return mission:progressEvent(1008)
        else
            return mission:progressEvent(1005)
        end
    end
end

local handleCompleteEvent = function(player, csid, option, npc)
    if mission:complete(player) then
        player:confirmTrade()
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

    -- Handles both first time and repeated completions of this mission.  Should there be future findings
    -- that show differences between the two, this should be separated into different sections.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Cleades'] =
            {
                onTrade   = handleFetichTrade,
                onTrigger = mission:messageSpecial(bastokMarketsID.text.ORIGINAL_MISSION_OFFSET + 6),
            },

            onEventFinish =
            {
                [1005] = handleCompleteEvent,
                [1008] = handleCompleteEvent,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Rashid'] =
            {
                onTrade   = handleFetichTrade,
                onTrigger = mission:messageSpecial(bastokMinesID.text.ORIGINAL_MISSION_OFFSET + 6),
            },

            onEventFinish =
            {
                [1005] = handleCompleteEvent,
                [1008] = handleCompleteEvent,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Malduc'] =
            {
                onTrade   = handleFetichTrade,
                onTrigger = mission:messageSpecial(metalworksID.text.ORIGINAL_MISSION_OFFSET + 6),
            },

            onEventFinish =
            {
                [1005] = handleCompleteEvent,
                [1008] = handleCompleteEvent,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] =
            {
                onTrade   = handleFetichTrade,
                onTrigger = mission:messageSpecial(portBastokID.text.ORIGINAL_MISSION_OFFSET + 6),
            },

            onEventFinish =
            {
                [1005] = handleCompleteEvent,
                [1008] = handleCompleteEvent,
            },
        },
    },
}

return mission
