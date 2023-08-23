-----------------------------------
-- The Order's Treasures
-- Seekers of Adoulin M3-4-3
-----------------------------------
-- !addmission 12 55
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_ORDERS_TREASURES)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.AUGUSTS_HEIRLOOM },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(143),
        },

        [xi.zone.CELENNIA_MEMORIAL_LIBRARY] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 4
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
