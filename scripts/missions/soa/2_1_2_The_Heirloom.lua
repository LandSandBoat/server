-----------------------------------
-- The Heirloom
-- Seekers of Adoulin M2-1-2
-----------------------------------
-- !addmission 12 13
-- Ploh Trishbahk (trigger area) : !pos 100.580 -40.150 -63.830 257
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_HEIRLOOM)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.AN_AIMLESS_JOURNEY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            onRegionEnter =
            {
                [1] = function(player, region)
                    return mission:progressEvent(1502)
                end,
            },

            onEventFinish =
            {
                [1502] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
