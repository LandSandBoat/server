-----------------------------------
-- The Zeruhn Report
-- Bastok M1-1
-----------------------------------
-- !addmission 1 0
-- Argus   : !pos 132.157 7.496 -2.187 236
-- Cleades : !pos -358 -10 -168 235
-- Malduc  : !pos 66.200 -14.999 4.426 237
-- Rashid  : !pos -8.444 -2 -123.575 234
-- Makarim : !pos -58 8 -333 172
-- Naji    : !pos 64 -14 -4 237
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
local zeruhnID        = require('scripts/zones/Zeruhn_Mines/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_ZERUHN_REPORT)

local handleAcceptMission = function(player, csid, option, npc)
    if option == 0 then
        mission:begin(player)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId and
                not player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Cleades'] = mission:progressEvent(1000),

            onEventFinish =
            {
                [1000] = handleAcceptMission,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Rashid'] = mission:progressEvent(1000),

            onEventFinish =
            {
                [1000] = handleAcceptMission,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Malduc'] = mission:progressEvent(1000),

            onEventFinish =
            {
                [1000] = handleAcceptMission,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] = mission:progressEvent(1000),

            onEventFinish =
            {
                [1000] = handleAcceptMission,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Cleades'] = mission:messageSpecial(bastokMarketsID.text.ORIGINAL_MISSION_OFFSET),
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Rashid'] = mission:messageSpecial(bastokMinesID.text.ORIGINAL_MISSION_OFFSET),
        },

        [xi.zone.METALWORKS] =
        {
            ['Malduc'] = mission:messageSpecial(metalworksID.text.ORIGINAL_MISSION_OFFSET),

            ['Naji'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ZERUHN_REPORT) then
                        return mission:progressEvent(710, not player:seenKeyItem(xi.ki.ZERUHN_REPORT) and 1 or 0)
                    end
                end,
            },

            onEventFinish =
            {
                [710] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.ZERUHN_REPORT)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] = mission:messageSpecial(portBastokID.text.ORIGINAL_MISSION_OFFSET),
        },

        [xi.zone.ZERUHN_MINES] =
        {
            ['Makarim'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ZERUHN_REPORT) then
                        return mission:messageSpecial(zeruhnID.text.MAKARIM_DIALOG_I)
                    else
                        return mission:progressEvent(121)
                    end
                end,
            },

            ['Rasmus'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.ZERUHN_REPORT) then
                        return mission:progressEvent(120)
                    end
                end,
            },

            onEventFinish =
            {
                [121] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.ZERUHN_REPORT)
                end,
            },
        },
    },
}

return mission
