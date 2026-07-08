-----------------------------------
-- An Extraordinary Gentleman
-- Seekers of Adoulin M3-4-2
-----------------------------------
-- !addmission 12 53
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------
require('scripts/missions/soa/helpers')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.AN_EXTRAORDINARY_GENTLEMAN)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_ORDERS_TREASURES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:progressEvent(135, 256),

            onEventFinish =
            {
                [135] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
