-----------------------------------
-- Yggdrasil
-- Seekers of Adoulin M2-7-3
-----------------------------------
-- !addmission 12 35
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

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.YGGDRASIL)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.RETURN_OF_THE_EXORCIST },
}

local spentEnoughImprimaturs = function(player)
    -- TODO: All of this
    local imprimatursSpent = 0
    local fame = player:getFameLevel(ADOULIN)
    local gate = 100 - (fame * 10)
    return imprimatursSpent >= gate
end

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
                    if spentEnoughImprimaturs(player) then
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
