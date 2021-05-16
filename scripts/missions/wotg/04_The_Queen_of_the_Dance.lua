-----------------------------------
-- The Queen of the Dance
-- Wings of the Goddess Mission 4
-----------------------------------
-- TODO:
-- !addmission 4 0
-- Cavernous Maws:
-- Batallia Downs       : !pos -48 0.1 435 105
-- Rolanberry Fields    : !pos -198 8 361 110
-- Sauromugue Champaign : !pos 369 8 -227 120
-----------------------------------
require("scripts/globals/keyitems")
require('scripts/globals/maws')
require('scripts/globals/missions')
require('scripts/globals/quests')
require('scripts/globals/settings')
require('scripts/globals/titles')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.THE_QUEEN_OF_THE_DANCE)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.WHILE_THE_CAT_IS_AWAY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and and missionStatus == 0
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Lion_Springs'] = mission:progressEvent(500),

            onEventFinish =
            {
                [510] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.WOTG, 1)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and and missionStatus == 1
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Turlough'] = mission:progressEvent(500),

            onEventFinish =
            {
                [510] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.WOTG, 2)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and and missionStatus == 2
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Lion_Springs'] = mission:progressEvent(500),

            onEventFinish =
            {
                [510] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
