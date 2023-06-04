-----------------------------------
-- Bat Hunt
-- San d'Oria M1-2
-----------------------------------
-- NOTE: This handles both the first completion and repeated
-- !addmission 0 1
-- Ambrotien  : !pos 93.419 -0.001 -57.347 230
-- Grilau     : !pos -241.987 6.999 57.887 231
-- Endracion  : !pos -110 1 -34 230
-- Tombstone  : !pos 1 0.1 -101 190
-----------------------------------
-- Orcish Scale Mail : ItemID 1112
-- Bat Fang          : ItemID 891
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.BAT_HUNT)

mission.reward =
{
    rankPoints = 200,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 101 then
        mission:begin(player)
    end
end

local function handleTradeEvent(player, trade, firstId, repeatId)
    local isRepeated = player:hasCompletedMission(mission.areaId, mission.missionId)

    if
        not isRepeated and
        npcUtil.tradeHasExactly(trade, xi.items.ORCISH_MAIL_SCALES)
    then
        return mission:progressEvent(firstId)
    elseif
        isRepeated and
        npcUtil.tradeHasExactly(trade, xi.items.BAT_FANG)
    then
        return mission:progressEvent(repeatId)
    end
end

local handleTradeEventFinish = function(player, csid, option, npc)
    if mission:complete(player) then
        player:confirmTrade()
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

    -- Mission has been accepted, but Tomb has not been investigated
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus < 2
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Ambrotien'] = mission:progressEvent(2021),
            ['Endracion'] = mission:progressEvent(1021),
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Grilau'] = mission:progressEvent(1021),
        },

        [xi.zone.KING_RANPERRES_TOMB] =
        {
            ['Tombstone'] =
            {
                onTrigger = function(player, npc)
                    local xPos = npc:getXPos()
                    local zPos = npc:getZPos()

                    if xPos >= -1 and xPos <= 1 and zPos >= -106 and zPos <= -102 then
                        return mission:progressEvent(4)
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.SANDORIA, 2)
                end,
            },
        }
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 2
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Ambrotien'] =
            {
                onTrade = function(player, npc, trade)
                    return handleTradeEvent(player, trade, 2023, 2003)
                end,

                onTrigger = mission:progressEvent(2022),
            },

            ['Endracion'] =
            {
                onTrade = function(player, npc, trade)
                    return handleTradeEvent(player, trade, 1023, 1003)
                end,

                onTrigger = mission:progressEvent(1022),
            },

            onEventFinish =
            {
                [1003] = handleTradeEventFinish,
                [1023] = handleTradeEventFinish,
                [2003] = handleTradeEventFinish,
                [2023] = handleTradeEventFinish,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Grilau'] =
            {
                onTrade = function(player, npc, trade)
                    return handleTradeEvent(player, trade, 1023, 1003)
                end,

                onTrigger = mission:progressEvent(1022),
            },

            onEventFinish =
            {
                [1003] = handleTradeEventFinish,
                [1023] = handleTradeEventFinish,
            },
        },
    },
}

return mission
