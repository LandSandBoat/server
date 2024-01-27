-----------------------------------
-- Summoned by Spirits
-- Seekers of Adoulin M3-3
-----------------------------------
-- !addmission 12 45
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.SUMMONED_BY_SPIRITS)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.EVIL_ENTITIES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(141),
        },

        [xi.zone.CELENNIA_MEMORIAL_LIBRARY] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 3
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
