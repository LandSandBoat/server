-----------------------------------
-- The Crystal Line
-- Bastok M2-1
-----------------------------------
-- !addmission 1 3
-- Argus   : !pos 132.157 7.496 -2.187 236
-- Cleades : !pos -358 -10 -168 235
-- Malduc  : !pos 66.200 -14.999 4.426 237
-- Rashid  : !pos -8.444 -2 -123.575 234
-- Cid     : !pos -12 -12 1 237
-- Naji    : !pos 64 -14 -4 237
-- Ayame   : !pos 133 -19 34 237
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

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_CRYSTAL_LINE)

mission.reward =
{
    rankPoints = 200,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 3 then
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
            ['Cleades'] = mission:messageSpecial(bastokMarketsID.text.ORIGINAL_MISSION_OFFSET + 19),
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Rashid'] = mission:messageSpecial(bastokMinesID.text.ORIGINAL_MISSION_OFFSET + 19),
        },

        [xi.zone.METALWORKS] =
        {
            ['Ayame'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.C_L_REPORT) then
                        return mission:progressEvent(712)
                    end
                end,
            },

            ['Cid'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        player:getMissionStatus(mission.areaId) == 1 and
                        npcUtil.tradeHasExactly(trade, xi.items.FADED_CRYSTAL)
                    then
                        return mission:progressEvent(506)
                    end
                end,

                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if player:hasKeyItem(xi.ki.C_L_REPORT) then
                        return mission:messageText(metalworksID.text.MISSION_DIALOG_CID_TO_AYAME)
                    elseif missionStatus == 0 then
                        return mission:progressEvent(505)
                    elseif missionStatus == 1 then
                        return mission:event(502)
                    end
                end,
            },

            ['Malduc'] = mission:messageSpecial(metalworksID.text.ORIGINAL_MISSION_OFFSET + 19),

            ['Naji'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.C_L_REPORT) then
                        return mission:progressEvent(711)
                    end
                end,
            },

            onEventFinish =
            {
                [505] = function(player, csid, option, npc)
                    if option == 0 then
                        local crystalItem = math.random(xi.items.FIRE_CRYSTAL, xi.items.DARK_CRYSTAL)

                        if npcUtil.giveItem(player, crystalItem) then
                            player:setMissionStatus(mission.areaId, 1)
                        end
                    end
                end,

                [506] = function(player, csid, option, npc)
                    if option == 0 then
                        player:confirmTrade()
                        npcUtil.giveKeyItem(player, xi.ki.C_L_REPORT)
                    end
                end,

                [712] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.C_L_REPORT)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] = mission:messageSpecial(portBastokID.text.ORIGINAL_MISSION_OFFSET + 19),
        },
    },
}

return mission
