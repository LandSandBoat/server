-----------------------------------
-- Awakening
-- Zilart M17
-----------------------------------
require('scripts/globals/interaction/mission')
require("scripts/globals/keyitems")
require('scripts/globals/missions')
require("scripts/globals/titles")
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.AWAKENING)

mission.reward =
{
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_LAST_VERSE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['Gilgamesh'] = mission:event(177),
        }
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus < 2
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            onRegionEnter =
            {
                [1] = mission:progressEvent(20)
            },

            onEventFinish =
            {
                [20] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.ZILART, player:getMissionStatus(xi.mission.log_id.ZILART) + 2)
                end,
            },
        }
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and (missionStatus == 0 or missionStatus == 2)
        end,

        [xi.zone.NORG] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 176
                end,
            },

            onEventFinish =
            {
                [176] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.ZILART, player:getMissionStatus(xi.mission.log_id.ZILART) + 1)
                end,
            },
        }
    },
}

return mission
