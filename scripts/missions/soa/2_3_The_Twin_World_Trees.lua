-----------------------------------
-- The Twin World Trees
-- Seekers of Adoulin M2-3
-----------------------------------
-- !addmission 12 17
-- Oscairn : !pos -80.214 -0.150 30.717 257
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_TWIN_WORLD_TREES)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.HONOR_AND_AUDACITY },
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
                -- TODO: One day wait
                [2] = function(player, region)
                    return mission:progressEvent(1503)
                end,
            },

            onEventFinish =
            {
                [1503] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
