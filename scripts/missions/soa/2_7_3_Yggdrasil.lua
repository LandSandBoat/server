-----------------------------------
-- Yggdrasil
-- Seekers of Adoulin M2-7-3
-----------------------------------
-- !addmission 12 35
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/utils')
require('scripts/globals/zone')
require('scripts/settings/main')
require('scripts/missions/soa/helpers')
-----------------------------------
local ID = require('scripts/zones/Western_Adoulin/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.YGGDRASIL)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.RETURN_OF_THE_EXORCIST },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] =
            {
                -- TODO: One day wait
                onTrigger = function(player, npc)
                    if xi.soa.helpers.imprimaturGate(player, 30) then
                        return mission:progressEvent(129)
                    else
                        return mission:event(126)
                    end
                end,
            },

            onEventFinish =
            {
                [129] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
