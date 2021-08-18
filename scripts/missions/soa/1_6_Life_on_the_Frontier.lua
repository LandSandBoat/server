-----------------------------------
-- Life on the Frontier
-- Seekers of Adoulin M1-6
-----------------------------------
-- !addmission 12 7
-- Brenton : !pos -86.036 3.349 18.121 256
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.LIFE_ON_THE_FRONTIER)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.MEETING_OF_THE_MINDS },
}

local spentEnoughImprimaturs = function(player)
    -- TODO: All of this
    local imprimatursSpent = 0
    local fame = player:getFameLevel(ADOULIN)
    local gate = 50 - (fame * 5)
    return imprimatursSpent >= gate
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                   spentEnoughImprimaturs(player)
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Brenton'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(4)
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        npcUtil.giveKeyItem(player, xi.ki.DINNER_INVITATION)
                    end
                end,
            },
        },
    },
}

return mission
