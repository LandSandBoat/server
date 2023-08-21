-----------------------------------
-- Returning to the Trees
-- Seekers of Adoulin M5-2-1
-----------------------------------
-- !addmission 12 113
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.RETURNING_TO_THE_TREES)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_KEY_TO_THE_TURRIS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(40, 256, 0, 5, 0, 0, 0, 0, 4),
        },

        [xi.zone.LEAFALLIA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 11
                end,
            },

            onEventFinish =
            {
                [11] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
