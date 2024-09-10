-----------------------------------
-- Predators and Prey
-- Seekers of Adoulin M2-7
-----------------------------------
-- !addmission 12 30
-- Sluice_Gate_6 : !pos -561.522 -7.500 60.002 258
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.PREDATOR_AND_PREY)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.BEHIND_THE_SLUICES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(126),
        },

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Sluice_Gate_6'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(352)
                end,
            },

            onEventFinish =
            {
                [352] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
