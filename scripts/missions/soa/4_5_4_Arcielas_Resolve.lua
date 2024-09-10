-----------------------------------
-- Arciela's Resolve
-- Seekers of Adoulin M4-5-4
-----------------------------------
-- !addmission 12 103
-- Levil           : !pos -87.204 3.350 12.655 256
-- Ploh Trishbahk  : !pos 100.580 -40.150 -63.830 257
-- Royal Sepulcher : !pos 319 -7.5 -300 258
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.ARCIELAS_RESOLVE)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.BALAMORS_RUSE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(40, 256, 0, 127, 0, 0, 0, 1999, 4),
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Ploh_Trishbahk'] = mission:progressEvent(1546, 257, 8192, 127, 0, 66977791, 2875743, 4095, 0),
        },

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Royal_Sepulcher'] = mission:progressEvent(368, 258, 3223117, 1756, 0, 20558, 1452, 309278, 8),

            onEventFinish =
            {
                [368] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
