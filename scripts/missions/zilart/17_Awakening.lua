-----------------------------------
-- Awakening
-- Zilart M17
-----------------------------------
-- !addmission 3 30
-- Gilgamesh   : !pos 122.452 -9.009 -12.052 252
-- Lower Jeuno : !zone 245
-- Norg        : !zone 252
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
            return currentMission == mission.missionId and missionStatus < 3
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            onRegionEnter =
            {
                [1] = function(player, csid, option, npc)
                    return mission:event(20)
                end,
            },

            onEventFinish =
            {
                [20] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, player:getMissionStatus(mission.areaId) + 2)
                end,
            },
        },

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
                    player:setMissionStatus(mission.areaId, player:getMissionStatus(mission.areaId) + 1)
                end,
            },
        }
    },
}

return mission
