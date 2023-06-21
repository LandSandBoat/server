-----------------------------------
-- Wading Beasts
-- Bastok M2-2
-----------------------------------
-- !addmission 1 4
-- Argus   : !pos 132.157 7.496 -2.187 236
-- Cleades : !pos -358 -10 -168 235
-- Malduc  : !pos 66.200 -14.999 4.426 237
-- Rashid  : !pos -8.444 -2 -123.575 234
-- Alois   : !pos 96 -20 14 237
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

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.WADING_BEASTS)

mission.reward =
{
    rankPoints = 250,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 4 then
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
            ['Cleades'] = mission:messageSpecial(bastokMarketsID.text.ORIGINAL_MISSION_OFFSET + 21),
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Rashid'] = mission:messageSpecial(bastokMinesID.text.ORIGINAL_MISSION_OFFSET + 21),
        },

        [xi.zone.METALWORKS] =
        {
            ['Alois'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.LIZARD_EGG) then
                        if not player:hasCompletedMission(mission.areaId, mission.missionId) then
                            return mission:progressEvent(372)
                        else
                            return mission:progressEvent(373)
                        end
                    end
                end,
            },

            ['Malduc'] = mission:messageSpecial(metalworksID.text.ORIGINAL_MISSION_OFFSET + 21),

            onEventFinish =
            {
                [372] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:confirmTrade()
                    end
                end,

                [373] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] = mission:messageSpecial(portBastokID.text.ORIGINAL_MISSION_OFFSET + 21),
        },
    },
}

return mission
