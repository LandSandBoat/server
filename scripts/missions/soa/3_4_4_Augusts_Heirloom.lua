-----------------------------------
-- August's Heirloom
-- Seekers of Adoulin M3-4-4
-----------------------------------
-- !addmission 12 56
-- Ploh Trishbahk : !pos 100.580 -40.150 -63.830 257
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.AUGUSTS_HEIRLOOM)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.BEAUTY_AND_THE_BEAST },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Ploh_Trishbahk'] = mission:progressEvent(1514),

            onEventFinish =
            {
                [1514] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(143),
        },
    },
}

return mission
