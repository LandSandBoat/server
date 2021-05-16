-----------------------------------
-- The Queen of the Dance
-- Wings of the Goddess Mission 4
-----------------------------------
-- !addmission 5 3
-- Lion Springs Door : !pos 96 0 106 80
-- Turlough          : !pos -58.697 0.000 103.553 244
-----------------------------------
require("scripts/globals/keyitems")
require('scripts/globals/maws')
require('scripts/globals/missions')
require("scripts/globals/npc_util")
require('scripts/globals/quests')
require('scripts/globals/settings')
require('scripts/globals/titles')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
local UJ_ID = require("scripts/zones/Upper_Jeuno/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.THE_QUEEN_OF_THE_DANCE)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.WHILE_THE_CAT_IS_AWAY },
}

mission.sections =
{
    -- 0: Try to enter without a ticket
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Lion_Springs'] = mission:progressEvent(68),

            onEventFinish =
            {
                [68] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.WOTG, 1)
                end,
            },
        },
    },

    -- 1: Go to the future to get a ticket
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Turlough'] = mission:progressEvent(10172),

            onEventFinish =
            {
                [10172] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.MAYAKOV_SHOW_TICKET)
                    player:setMissionStatus(xi.mission.log_id.WOTG, 2)
                end,
            },
        },
    },

    -- 2: Come back and use your ticket
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 2
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Lion_Springs'] = mission:progressEvent(70),

            onEventFinish =
            {
                [70] = function(player, csid, option, npc)
                    return mission:event(152)
                end,

                [152] = function(player, csid, option, npc)
                    return mission:event(153)
                end,

                [153] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MAYAKOV_SHOW_TICKET)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
