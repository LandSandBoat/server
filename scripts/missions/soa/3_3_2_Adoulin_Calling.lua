-----------------------------------
-- Adoulin Calling
-- Seekers of Adoulin M3-3-2
-----------------------------------
-- !addmission 12 47
-- Levil          : !pos -87.204 3.350 12.655 256
-- Boarding House : !pos -41.693 -0.15 -38.29 257
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.ADOULIN_CALLING)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_DISAPPEARANCE_OF_NYLINE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CEIZAK_BATTLEGROUNDS] =
        {
            ['Elmric'] = mission:event(24),
        },

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(141),
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Door_Boarding_House'] = mission:progressEvent(1511),

            onEventFinish =
            {
                [1511] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
