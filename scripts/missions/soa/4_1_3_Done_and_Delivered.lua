-----------------------------------
-- Done and Delivered
-- Seekers of Adoulin M4-1-3
-----------------------------------
-- !addmission 12 74
-- Kipligg : !pos -32 0 22 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.DONE_AND_DELIVERED)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.MINISTERIAL_WHISPERS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil']   = mission:event(161),
            ['Kipligg'] = mission:progressEvent(157, 256, 99, 3, 0),

            onEventFinish =
            {
                [157] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
