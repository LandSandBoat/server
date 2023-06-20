-----------------------------------
-- A New Journey
-- Windurst M3-3
-----------------------------------
-- !addmission 2 12
-- Rakoh Buuma      : !pos 106 -5 -23 241
-- Mokyokyo         : !pos -55 -8 227 238
-- Janshura-Rashura : !pos -227 -8 184 240
-- Zokima-Rokima    : !pos 0 -16 124 239
-- Vestal Chambers  : !pos 0.1 -49 37 242
-- Pakh Jatalfih    : !pos 34 8 -35 243
-- Embassy Door     : !pos 31 9 -22 243
-- Cermet Door      : !pos 636 16 59 184
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------
local lowerDelkfuttID = require("scripts/zones/Lower_Delkfutts_Tower/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.A_NEW_JOURNEY)

mission.reward =
{
    gil  = 5000,
    rank = 4,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 12 then
        mission:begin(player)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
        npcUtil.giveKeyItem(player, xi.ki.STAR_CRESTED_SUMMONS_1)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId
        end,

        [xi.zone.PORT_WINDURST] =
        {
            onEventFinish =
            {
                [78] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            onEventFinish =
            {
                [93] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            onEventFinish =
            {
                [111] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            onEventFinish =
            {
                [114] = handleAcceptMission,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.LOWER_DELKFUTTS_TOWER] =
        {
            ['_540'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        player:getMissionStatus(mission.areaId) == 2 and
                        npcUtil.tradeHasExactly(trade, xi.items.DELKFUTT_KEY)
                    then
                        return mission:progressEvent(2)
                    end
                end,

                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        if player:hasKeyItem(xi.ki.DELKFUTT_KEY) then
                            return mission:progressEvent(2)
                        else
                            return mission:messageSpecial(lowerDelkfuttID.text.THE_DOOR_IS_FIRMLY_SHUT_OPEN_KEY):setPriority(1000)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)

                    if not player:hasKeyItem(xi.ki.DELKFUTT_KEY) then
                        player:confirmTrade()
                        npcUtil.giveKeyItem(player, xi.ki.DELKFUTT_KEY)
                    end
                end,
            },
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            ['_6r8'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 4 then
                        return mission:progressEvent(40)
                    end
                end,
            },

            ['Pakh_Jatalfih'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 1 then
                        return mission:progressEvent(43)
                    elseif missionStatus == 2 then
                        return mission:progressEvent(68)
                    elseif missionStatus == 3 then
                        return mission:progressEvent(141)
                    end
                end,
            },

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [43] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                    player:delKeyItem(xi.ki.LETTER_TO_THE_AMBASSADOR)
                end,

                [141] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                end,
            },
        },

        [xi.zone.HEAVENS_TOWER] =
        {
            ['_6q2'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(153)
                    end
                end,
            },

            onEventFinish =
            {
                [153] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                    player:delKeyItem(xi.ki.STAR_CRESTED_SUMMONS_1)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_TO_THE_AMBASSADOR)
                end,
            },
        },
    },
}

return mission
