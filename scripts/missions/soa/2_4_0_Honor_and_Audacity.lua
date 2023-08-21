-----------------------------------
-- Honor and Audacity
-- Seekers of Adoulin M2-4
-----------------------------------
-- !addmission 12 18
-- RALA_WATERWAYS : !zone 258
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.HONOR_AND_AUDACITY)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_WATERGARDEN_COLISEUM },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(127),
        },

        [xi.zone.RALA_WATERWAYS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 342
                end,
            },

            onEventFinish =
            {
                [342] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
