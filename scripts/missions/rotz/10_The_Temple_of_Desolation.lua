-----------------------------------
-- The Temple of Desolation
-- Zilart M10
-----------------------------------
-- !addmission 3 20
-- Kamui : !pos 120.121 -8.009 -7.298 252
-- _6z0  : !pos 0 -12 48 251
-----------------------------------
require('scripts/globals/interaction/mission')
require("scripts/globals/keyitems")
require('scripts/globals/missions')
require("scripts/globals/titles")
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_DESOLATION)

mission.reward =
{
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_HALL_OF_THE_GODS },
    title = xi.title.SEALER_OF_THE_PORTAL_OF_THE_GODS,
}

mission.sections =
{
    -- Section: Mission Active
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['Kamui'] = mission:progressEvent(11),
        },

        [xi.zone.HALL_OF_THE_GODS] =
        {
            ['_6z0'] = mission:progressEvent(1),

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
