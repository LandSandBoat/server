-----------------------------------
-- A Shrouded Canopy
-- Seekers of Adoulin M4-3-5
-----------------------------------
-- !addmission 12 88
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.A_SHROUDED_CANOPY)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.LEAFALLIA },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:progressEvent(166),
        },

        [xi.zone.LEAFALLIA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 2
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
