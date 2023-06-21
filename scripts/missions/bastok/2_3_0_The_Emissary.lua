-----------------------------------
-- The Emissary
-- Bastok M2-3
-----------------------------------
-- !addmission 1 5
-- Argus   : !pos 132.157 7.496 -2.187 236
-- Cleades : !pos -358 -10 -168 235
-- Malduc  : !pos 66.200 -14.999 4.426 237
-- Rashid  : !pos -8.444 -2 -123.575 234
-- Naji    : !pos 64 -14 -4 237
-- Baraka  : !pos 36 -2 -2 231
-- Helaku  : !pos 49 -2 -12 231
-- Melek   : !pos -80.6 -5.5 157.3 240
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/titles')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local bastokMarketsID = require('scripts/zones/Bastok_Markets/IDs')
local bastokMinesID   = require('scripts/zones/Bastok_Mines/IDs')
local metalworksID    = require('scripts/zones/Metalworks/IDs')
local portBastokID    = require('scripts/zones/Port_Bastok/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY)

mission.reward =
{
    gil     = 3000,
    keyItem = xi.ki.ADVENTURERS_CERTIFICATE,
    rank    = 3,
    title   = xi.title.CERTIFIED_ADVENTURER,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 5 then
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
            ['Cleades'] = mission:messageSpecial(bastokMarketsID.text.ORIGINAL_MISSION_OFFSET + 23),
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Rashid'] = mission:messageSpecial(bastokMinesID.text.ORIGINAL_MISSION_OFFSET + 23),
        },

        [xi.zone.METALWORKS] =
        {
            ['Malduc'] = mission:messageSpecial(metalworksID.text.ORIGINAL_MISSION_OFFSET + 23),

            ['Naji'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.KINDRED_REPORT) then
                        return mission:progressEvent(714)
                    elseif
                        not player:hasKeyItem(xi.ki.LETTER_TO_THE_CONSULS_BASTOK) and
                        player:getMissionStatus(mission.areaId) == 0
                    then
                        local isFirst23 =
                        (
                            not player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_ABROAD) and
                            not player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS)
                        ) and 1 or 0

                        return mission:progressEvent(713, 0, 0, 0, 0, 0, 0, 0, isFirst23) -- Contains variation for Lion mention.
                    else
                        return mission:messageText(metalworksID.text.GOOD_LUCK)
                    end
                end,
            },

            onEventFinish =
            {
                [713] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_TO_THE_CONSULS_BASTOK)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [714] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.KINDRED_REPORT)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] = mission:messageSpecial(portBastokID.text.ORIGINAL_MISSION_OFFSET + 23),
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Baraka'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then -- Start Sandoria path first.
                        return mission:progressEvent(581)
                    end
                end,
            },

            ['Helaku'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 1 then -- Placeholder before starting first path.
                        return mission:progressEvent(676)
                    elseif missionStatus == 7 then -- Start Sandoria path second.
                        return mission:progressEvent(537)
                    elseif
                        missionStatus == 11 and
                        player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY_SANDORIA2)
                    then -- Both paths completed, with Sandoria last.
                        return mission:progressEvent(557)
                    end
                end,
            },

            ['Shakir'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if
                        missionStatus == 1 or
                        missionStatus == 7
                    then -- TODO: Default dialog and status 1 need confirmation.
                        return mission:event(556)
                    end
                end,
            },

            onEventFinish =
            {
                [537] = function(player, csid, option, npc)
                    if option == 0 then
                        player:delMission(mission.areaId, mission.missionId)
                        player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY_SANDORIA2)
                        player:delKeyItem(xi.ki.LETTER_TO_THE_CONSULS_BASTOK) -- Key item deleted when starting second path.
                        player:setMissionStatus(mission.areaId, 8)
                    end
                end,

                [581] = function(player, csid, option, npc)
                    player:delMission(mission.areaId, mission.missionId)
                    player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY_SANDORIA)
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Ada'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 7 then -- Windurst path completed. Sandoria path not started.
                        return mission:event(58)
                    elseif
                        player:hasKeyItem(xi.ki.KINDRED_REPORT) and
                        player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY_WINDURST2)
                    then -- Both paths completed, with Windurst last.
                        return mission:event(69)
                    end
                end,
            },

            ['Gold_Skull'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 7 then -- Windurst path completed. Sandoria path not started.
                        return mission:event(57)
                    elseif
                        player:hasKeyItem(xi.ki.KINDRED_REPORT) and
                        player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY_WINDURST2)
                    then -- Both paths completed, with Windurst last.
                        return mission:event(68)
                    end
                end,
            },

            ['Josef'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 7 then -- Windurst path completed. Sandoria path not started.
                        return mission:event(59)
                    elseif
                        player:hasKeyItem(xi.ki.KINDRED_REPORT) and
                        player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY_WINDURST2)
                    then -- Both paths completed, with Windurst last.
                        return mission:event(70)
                    end
                end,
            },

            ['Melek'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 1 then -- Start Windurst path first.
                        return mission:progressEvent(48)
                    elseif missionStatus == 6 then -- Start Windurst path second.
                        return mission:progressEvent(61)
                    elseif missionStatus == 7 then -- Windurst path completed. Sandoria path not started.
                        return mission:event(56)
                    elseif
                        player:hasKeyItem(xi.ki.KINDRED_REPORT) and
                        player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY_WINDURST2)
                    then -- Both paths completed, with Windurst last.
                        return mission:progressEvent(67)
                    end
                end,
            },

            onEventFinish =
            {
                [48] = function(player, csid, option, npc)
                    player:delMission(mission.areaId, mission.missionId)
                    player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY_WINDURST)
                    player:setMissionStatus(mission.areaId, 2)
                end,

                [61] = function(player, csid, option, npc)
                    player:delMission(mission.areaId, mission.missionId)
                    player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY_WINDURST2)
                    player:delKeyItem(xi.ki.LETTER_TO_THE_CONSULS_BASTOK) -- Key item deleted when starting second path.
                    player:setMissionStatus(mission.areaId, 7)
                end,
            },
        },
    },
}

return mission
