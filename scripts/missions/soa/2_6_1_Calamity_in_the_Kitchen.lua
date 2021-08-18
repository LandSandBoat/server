-----------------------------------
-- Calamity in the Kitchen
-- Seekers of Adoulin M2-6-1
-----------------------------------
-- !addmission 12 27
-- Chalvava : !pos -318.000 -1.000 -318.000 258
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.CALAMITY_IN_THE_KITCHEN)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.ARCIELAS_PROMISE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Chalvava'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(344)
                end,
            },

            onEventFinish =
            {
                [344] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        npcUtil.giveKeyItem(player, xi.ki.BOX_OF_ADOULINIAN_TOMATOES)
                    end
                end,
            },
        },
    },
}

return mission
