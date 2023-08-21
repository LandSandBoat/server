-----------------------------------
-- The Sacred Sapling
-- Seekers of Adoulin M4-3-3
-----------------------------------
-- !addmission 12 86
-- Levil          : !pos -87.204 3.350 12.655 256
-- Ploh Trishbahk : !pos 100.580 -40.150 -63.830 257
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_SACRED_SAPLING)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.TREE_GRAFTING },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Ploh_Trishbahk'] = mission:progressEvent(1528, 257, 0, 3, 0, 25163255, 6221159, 4095, 0),

            onEventFinish =
            {
                [1528] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(165),
        },
    },
}

return mission
