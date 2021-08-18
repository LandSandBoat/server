-----------------------------------
-- Friction and Fissures
-- Seekers of Adoulin M2-5
-----------------------------------
-- !addmission 12 20
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.FRICTION_AND_FISSURES)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_CELENNIA_MEMORIAL_LIBRARY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] =
            {
                -- TODO: Wait until next day
                onTrigger = function(player, npc)
                    return mission:progressEvent(123)
                end,
            },

            onEventFinish =
            {
                [123] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
