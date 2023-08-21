-----------------------------------
-- ...Into the Fire
-- Seekers of Adoulin M4-1
-----------------------------------
-- !addmission 12 71
-- Levil   : !pos -87.204 3.350 12.655 256
-- Kipligg : !pos -32 0 22 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.INTO_THE_FIRE)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.MELVIEN_DE_MALECROIX },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Kipligg'] = mission:progressEvent(155, 256, 932, 256),
            ['Levil']   = mission:event(161),

            onEventFinish =
            {
                [155] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
