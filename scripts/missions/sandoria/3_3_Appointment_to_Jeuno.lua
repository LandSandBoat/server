-----------------------------------
-- Appointment to Jeuno
-- San d'Oria M3-3
-----------------------------------
-- !addmission 0 12
-- Ambrotien            : !pos 93.419 -0.001 -57.347 230
-- Grilau               : !pos -241.987 6.999 57.887 231
-- Endracion            : !pos -110 1 -34 230
-- Halver               : !pos 2 0.1 0.1 233
-- _6h4 (Great Hall)    : !pos 0 -1 13 233
-- Nelcabrit            : !pos -32 9 -49 243
-- _541 (Cermet Door)   : !pos 636 16 20 184
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local southernSandoriaID = require('scripts/zones/Southern_San_dOria/IDs')
local northernSandoriaID = require('scripts/zones/Northern_San_dOria/IDs')
local lowerDelkfuttID    = require('scripts/zones/Lower_Delkfutts_Tower/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.APPOINTMENT_TO_JEUNO)

mission.reward =
{
    gil = 5000,
    rank = 4,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 12 then
        mission:begin(player)
    end
end

mission.sections =
{
    -- Player has no active missions
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            onEventFinish =
            {
                [1009] = handleAcceptMission,
                [2009] = handleAcceptMission,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            onEventFinish =
            {
                [1009] = handleAcceptMission,
            },
        },
    },

    -- Player has accepted the mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Grilau'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:messageText(northernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 74):setPriority(1000)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Ambrotien'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:messageText(southernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 74):setPriority(1000)
                    end
                end,
            },

            ['Endracion'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:messageText(southernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 74):setPriority(1000)
                    end
                end,
            },
        },

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Arsha'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        return mission:progressEvent(85)
                    end
                end,
            },

            ['Chupaile'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        return mission:progressEvent(86)
                    end
                end,
            },

            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(508)
                    end
                end,
            },

            ['_6h4'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        return mission:progressEvent(537)
                    end
                end,
            },

            onEventFinish =
            {
                [508] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                    -- 7092 Here: You have been granted an audience with the king
                end,

                [537] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_TO_THE_AMBASSADOR)
                end,
            },
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nelcabrit'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 3 then
                        return mission:progressEvent(42)
                    elseif missionStatus == 4 then
                        return mission:progressEvent(67)
                    elseif missionStatus == 5 then
                        return mission:progressEvent(140)
                    end
                end,
            },

            ['_6r5'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 5 then
                        return mission:progressEvent(39)
                    end
                end,
            },

            onEventFinish =
            {
                [39] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [42] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                    player:delKeyItem(xi.ki.LETTER_TO_THE_AMBASSADOR)
                end,
            },
        },

        [xi.zone.LOWER_DELKFUTTS_TOWER] =
        {
            ['_541'] =
            {
                onTrade = function(player, npc, trade)
                    -- TODO: As of the April 2009 update, trading the key to any Cermet Door or the elevator will turn
                    -- the key into a key item, allowing the player to drop the inventory key for space.
                    if
                        player:getMissionStatus(mission.areaId) == 4 and
                        npcUtil.tradeHasExactly(trade, xi.items.DELKFUTT_KEY)
                    then
                        return mission:progressEvent(0)
                    end
                end,

                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 4 then
                        if player:hasKeyItem(xi.ki.DELKFUTT_KEY) then
                            return mission:progressEvent(0)
                        else
                            return mission:messageSpecial(lowerDelkfuttID.text.THE_DOOR_IS_FIRMLY_SHUT_OPEN_KEY):setPriority(1000)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 5)

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
