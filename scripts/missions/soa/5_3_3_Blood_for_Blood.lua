-----------------------------------
-- Blood for Blood
-- Seekers of Adoulin M5-3-3
-----------------------------------
-- !addmission 12 120
-- Ominous Postern : !pos 118 37.5 20 277
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.BLOOD_FOR_BLOOD)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.RECKONING },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.RAKAZNAR_TURRIS] =
        {
            ['Ominous_Postern'] = mission:progressEvent(2, 277, 3823678, 1756, 0, 277, 1, 0, 0),

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
