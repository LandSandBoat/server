-----------------------------------
-- Arciela's Promise
-- Seekers of Adoulin M2-6-2
-----------------------------------
-- !addmission 12 29
-- Ploh Trishbahk : !pos 100.580 -40.150 -63.830 257
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.ARCIELAS_PROMISE)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.PREDATOR_AND_PREY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Chalvava'] = mission:event(360, 258):oncePerZone(),
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Ploh_Trishbahk'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(1506, 257, 23, 2964)
                end,
            },

            onEventFinish =
            {
                [1506] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
