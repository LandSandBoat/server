-----------------------------------
-- The Watergarden Coliseum
-- Seekers of Adoulin M2-4-1
-----------------------------------
-- !addmission 12 19
-- Yeggha_Dolashi : !pos 260.000 -5.768 60.000 258
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_WATERGARDEN_COLISEUM)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.FRICTION_AND_FISSURES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Yeggha_Dolashi'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(0)
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
