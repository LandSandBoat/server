-----------------------------------
-- Three Paths
-- Promathia 5-3
-----------------------------------
-- !addmission 6 530
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/missions')
require('scripts/globals/titles')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.THREE_PATHS)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG },
}

local eventArgOffset =
{
    [xi.mission.status.COP.LOUVERANCE] = 1,
    [xi.mission.status.COP.TENZEN]     = 2,
    [xi.mission.status.COP.ULMIA]      = 4,
}

local function getCidEventArg(player, completingPath)
    local eventArg = 0

    for pathArg = xi.mission.status.COP.LOUVERANCE, xi.mission.status.COP.ULMIA do
        if
            pathArg == completingPath or
            player:getMissionStatus(mission.areaId, pathArg) == 14
        then
            eventArg = eventArg + eventArgOffset[pathArg]
        end
    end

    return eventArg
end

local function isMissionComplete(player)
    for pathArg = xi.mission.status.COP.LOUVERANCE, xi.mission.status.COP.ULMIA do
        if player:getMissionStatus(mission.areaId, pathArg) ~= 14 then
            return false
        end
    end

    return true
end

mission.sections =
{
    -- Louverance's Path
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE) <= 14
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE) == 0 then
                        return mission:event(118):importantEvent()
                    else
                        return mission:event(134)
                    end
                end,
            },

            onEventFinish =
            {
                [118] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2, xi.mission.status.COP.LOUVERANCE)
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE) == 2 then
                        return mission:event(686):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [686] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3, xi.mission.status.COP.LOUVERANCE)
                end,
            },
        },

        [xi.zone.BIBIKI_BAY] =
        {
            ['Warmachine'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE) == 3 then
                        return mission:progressEvent(33)
                    end
                end,
            },

            onEventFinish =
            {
                [33] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 6, xi.mission.status.COP.LOUVERANCE)
                end,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Yoran-Oran'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE) == 6 then
                        return mission:event(481):importantEvent()
                    end
                end,
            },
        },

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['_0d0'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE) == 11 and
                        npcUtil.tradeHasExactly(trade, xi.items.GOLD_KEY)
                    then
                        return mission:progressEvent(3)
                    end
                end,
            },

            ['Tarnotik'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE) == 11 then
                        return mission:event(34):importantEvent() -- TODO: Verify, might be importantOnce
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE) == 6 then
                        return 1
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 8, xi.mission.status.COP.LOUVERANCE)
                end,

                [3] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:setMissionStatus(mission.areaId, 12, xi.mission.status.COP.LOUVERANCE)
                end,
            },
        },

        [xi.zone.MINE_SHAFT_2716] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == 736 and
                        player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE) == 8
                    then
                        player:setMissionStatus(mission.areaId, 9, xi.mission.status.COP.LOUVERANCE)
                    end
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE)

                    if missionStatus == 8 then
                        return mission:progressEvent(852)
                    elseif missionStatus == 12 then
                        return mission:progressEvent(853, getCidEventArg(player, xi.mission.status.COP.LOUVERANCE))
                    end
                end,
            },

            onEventFinish =
            {
                [852] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 11, xi.mission.status.COP.LOUVERANCE)
                end,

                [853] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 14, xi.mission.status.COP.LOUVERANCE)
                    player:addTitle(xi.title.COMPANION_OF_LOUVERANCE)

                    if isMissionComplete(player) then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
