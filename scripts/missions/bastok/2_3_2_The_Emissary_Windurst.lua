-----------------------------------
-- The Emissary Windurst
-- Bastok M2-3 (Part 1)
-----------------------------------
-- !addmission 1 7
-- Kupipi    : !pos 2 0.1 30 242
-- Melek     : !pos -80 -5 158 240
-- Uu Zhoumo : !pos -179 16 155 145
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local portWindurstID = require('scripts/zones/Port_Windurst/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY_WINDURST)

mission.reward = {}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.GIDDEUS] =
        {
            ['Uu_Zhoumo'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.ASPIR_KNIFE) then
                        return mission:progressEvent(41)
                    end
                end,

                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.DULL_SWORD) then
                        player:startEvent(40)
                    elseif player:getMissionStatus(player:getNation()) == 5 then
                        player:startEvent(43)
                    else
                        player:startEvent(44)
                    end
                end,
            },

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 5)
                    player:delKeyItem(xi.ki.DULL_SWORD)
                end,

                [41] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:setMissionStatus(mission.areaId, 6)
                end,
            },
        },

        [xi.zone.HEAVENS_TOWER] =
        {
            ['Kupipi'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 3 then
                        return mission:progressEvent(238, 1, 1, 1, 1, xi.nation.BASTOK)
                    elseif missionStatus == 5 then
                        return mission:event(240)
                    elseif missionStatus == 6 then
                        return mission:event(241)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        return 42
                    end
                end,
            },

            onEventFinish =
            {
                [ 42] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                end,

                [238] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                    npcUtil.giveKeyItem(player, xi.ki.SWORD_OFFERING)
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Gold_Skull'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if
                        player:hasKeyItem(xi.ki.SWORD_OFFERING) and
                        not player:hasKeyItem(xi.ki.DULL_SWORD)
                    then
                        return mission:progressEvent(53)
                    elseif missionStatus == 2 then
                        return mission:progressEvent(50)
                    elseif missionStatus == 12 then -- TODO: Find out what the below does, this is dead code
                        return mission:progressEvent(54)
                    elseif missionStatus == 14 then
                        return mission:messageText(npc, portWindurstID.text.GOLD_SKULL_DIALOG)
                    elseif missionStatus == 15 then
                        return mission:progressEvent(57)
                    end
                end,
            },

            ['Melek'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 2 then
                        return mission:progressEvent(49)
                    elseif missionStatus <= 5 then
                        return mission:messageText(portWindurstID.text.MELEK_DIALOG_B)
                    elseif missionStatus == 6 then
                        return mission:progressEvent(55)
                    end
                end,
            },

            onEventFinish =
            {
                [53] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(xi.ki.DULL_SWORD)
                end,

                [55] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:confirmTrade()
                        player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY)
                        player:setMissionStatus(mission.areaId, 7)
                    end
                end,
            },
        },
    },
}

return mission
