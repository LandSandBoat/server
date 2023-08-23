-----------------------------------
-- Heartwings and the Kindhearted
-- Seekers of Adoulin M1-4
-----------------------------------
-- !addmission 12 5
-- WESTERN_ADOULIN : !zone 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.HEARTWINGS_AND_THE_KINDHEARTED)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.PIONEER_REGISTRATION },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
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
