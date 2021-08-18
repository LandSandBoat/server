-----------------------------------
-- Pioneer Registration
-- Seekers of Adoulin M1-5
-----------------------------------
-- !addmission 12 6
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

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.PIONEER_REGISTRATION)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.LIFE_ON_THE_FRONTIER },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Brenton'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(3)
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    player:addCurrency('bayld', 1000 * xi.settings.BAYLD_RATE)
                    player:messageSpecial(ID.text.BAYLD_OBTAINED, 1000 * xi.settings.BAYLD_RATE)

                    player:addKeyItem(xi.ki.PIONEERS_BADGE) -- Notification for this is shown in the CS, so hand over quietly
                    npcUtil.giveKeyItem(player, xi.ki.MAP_OF_ADOULIN)

                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
