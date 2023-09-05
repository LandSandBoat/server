-----------------------------------
-- The Three Kingdoms Bastok
-- Windurst M2-3 (Part 2)
-----------------------------------
-- !addmission 2 9
-- Grohm     : !pos -18 -11 -27 237
-- Pius      : !pos 99 -21 -12 237
-- Patt-Pott : !pos 23 -17 42 237
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2)

mission.reward = {}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.METALWORKS] =
        {
            ['Grohm'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 9 then
                        return mission:progressEvent(426, 1)
                    else
                        return mission:progressEvent(427, 1)
                    end
                end,
            },

            ['Pius'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 8 then
                        return mission:progressEvent(355, 1)
                    elseif missionStatus < 11 then
                        return mission:progressEvent(356)
                    end
                end,
            },

            ['Patt-Pott'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 11 then
                        return mission:progressEvent(257)
                    else
                        return mission:progressEvent(258)
                    end
                end,
            },

            onEventFinish =
            {
                [257] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:addMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS)
                        player:delKeyItem(xi.ki.KINDRED_CREST)
                        npcUtil.giveKeyItem(player, xi.ki.KINDRED_REPORT)
                        player:setMissionStatus(mission.areaId, 11)
                    end
                end,

                [355] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 9)
                end,

                [426] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 10)
                end,
            },
        },

        [xi.zone.WAUGHROON_SHRINE] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 10 and
                        player:getLocalVar('battlefieldWin') == 64
                    then
                        npcUtil.giveKeyItem(player, xi.ki.KINDRED_CREST)
                        player:delKeyItem(xi.ki.DARK_KEY)
                        player:setMissionStatus(mission.areaId, 11)
                    end
                end,
            },
        },
    },
}

return mission
