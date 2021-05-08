-----------------------------------
-- The Gate of the Gods
-- Zilart M13
-----------------------------------
-- !addmission 3 24
-- Shimmering_Circle : !pos 0 -20 147 251
-- RuAun_Gardens     : !zone 130
-----------------------------------
require('scripts/globals/interaction/mission')
require("scripts/globals/keyitems")
require('scripts/globals/missions')
require("scripts/globals/titles")
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_GATE_OF_THE_GODS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.ARK_ANGELS },
}

mission.sections =
{
    -- Section: Mission Active, missionStatus == 0
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.HALL_OF_THE_GODS] =
        {
            ['Shimmering_Circle'] = mission:progressEvent(3),

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.ZILART, 1)
                end,
            },
        },
    },

    -- Section: Mission Active, missionStatus == 1
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.RUAUN_GARDENS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 51
                end,
            },

            onEventFinish =
            {
                [51] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.ZILART, 0)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
