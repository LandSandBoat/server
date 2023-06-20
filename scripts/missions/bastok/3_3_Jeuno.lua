-----------------------------------
-- Jeuno
-- Bastok M3-3
-----------------------------------
-- !addmission 1 12
-- Argus   : !pos 132.157 7.496 -2.187 236
-- Cleades : !pos -358 -10 -168 235
-- Malduc  : !pos 66.200 -14.999 4.426 237
-- Rashid  : !pos -8.444 -2 -123.575 234
-- Lucius  : !pos 59.959 -17.39 -42.321 237
-- Goggehn : !pos 3 9 -76 243
-- _542    : !pos 596 16 -19 184
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local lowerDelkfuttID = require('scripts/zones/Lower_Delkfutts_Tower/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.JEUNO)

mission.reward =
{
    gil  = 5000,
    rank = 4,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 12 then
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
            ['Cleades'] = mission:progressEvent(1002),
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Rashid'] = mission:progressEvent(1002),
        },

        [xi.zone.METALWORKS] =
        {
            ['Lucius'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(322) -- NOTE: Trust Bastok, annoyingly, takes priority in retail, so priority should be lower. On the other hand, this is a mandatory step.
                    end
                end,
            },

            ['Malduc'] = mission:progressEvent(1002),

            onEventFinish =
            {
                [322] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_TO_THE_AMBASSADOR)
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] = mission:progressEvent(1002),
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            ['_6r2'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        return mission:progressEvent(38)
                    end
                end,
            },

            ['Goggehn'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 1 then
                        return mission:progressEvent(41)
                    elseif missionStatus == 2 then
                        return mission:event(66)
                    elseif missionStatus == 3 then
                        return mission:event(139)
                    end
                end,
            },

            onEventFinish =
            {
                [38] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [41] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                    player:delKeyItem(xi.ki.LETTER_TO_THE_AMBASSADOR)
                end,
            },
        },

        [xi.zone.LOWER_DELKFUTTS_TOWER] =
        {
            ['_542'] =
            {
                onTrade = function(player, npc, trade)
                    -- As of the April 2009 update, trading the key to any Cermet Door or the elevator will turn
                    -- the key into a key item, allowing the player to drop the inventory key for space.
                    if
                        player:getMissionStatus(mission.areaId) == 2 and
                        npcUtil.tradeHasExactly(trade, xi.items.DELKFUTT_KEY)
                    then
                        return mission:progressEvent(1)
                    end
                end,

                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        if player:hasKeyItem(xi.ki.DELKFUTT_KEY) then
                            return mission:progressEvent(1)
                        else
                            return mission:messageSpecial(lowerDelkfuttID.text.THE_DOOR_IS_FIRMLY_SHUT_OPEN_KEY):setPriority(1000)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)

                    if not player:hasKeyItem(xi.ki.DELKFUTT_KEY) then
                        npcUtil.giveKeyItem(player, xi.ki.DELKFUTT_KEY)
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return mission
