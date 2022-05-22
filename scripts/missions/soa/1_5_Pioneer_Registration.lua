-----------------------------------
-- Pioneer Registration
-- Seekers of Adoulin M1-5
-----------------------------------
-- !addmission 12 6
-- Brenton : !pos -86.036 3.349 18.121 256
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.PIONEER_REGISTRATION)

mission.reward =
{
    bayld       = 1000,
    keyItem     = xi.ki.MAP_OF_ADOULIN,
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
                    if mission:complete(player) then
                        player:addKeyItem(xi.ki.PIONEERS_BADGE)
                    end
                end,
            },
        },
    },
}

return mission
