-----------------------------------
-- Ortharsyne
-- Seekers of Adoulin M2-2-1
-----------------------------------
-- !addmission 12 15
-- YORCIA_WEALD : !zone 264
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.ORTHARSYNE)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.IN_THE_PRESENCE_OF_ROYALTY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.YORCIA_WEALD] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 1
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
