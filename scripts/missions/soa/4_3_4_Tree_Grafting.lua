-----------------------------------
-- Tree Grafting
-- Seekers of Adoulin M4-3-4
-----------------------------------
-- !addmission 12 87
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.TREE_GRAFTING)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.A_SHROUDED_CANOPY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Ploh_Trishbahk'] = mission:progressEvent(1530),
        },

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:progressEvent(160, 256, 0, 1, 1, 0, 0, 0, 4),

            onEventFinish =
            {
                [160] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
