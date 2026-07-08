-----------------------------------
-- Seeds of Doubt
-- Seekers of Adoulin M4-4-1
-----------------------------------
-- !addmission 12 94
-- Levil          : !pos -87.204 3.350 12.655 256
-- Ploh Trishbahk : !pos 100.580 -40.150 -63.830 257
-- Chalvava       : !pos -318.000 -1.000 -318.000 258
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.SEEDS_OF_DOUBT)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_TOMATOES_OF_WRATH },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(40, 256, 0, 1, 0, 0, 0, 4095, 4),
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Ploh_Trishbahk'] = mission:progressEvent(1540),
        },

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Chalvava'] = mission:progressEvent(367, 258, 3033627, 1756, utils.MAX_UINT32 - 6266, 20780, 121, 554049, 0),

            onEventFinish =
            {
                [367] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
