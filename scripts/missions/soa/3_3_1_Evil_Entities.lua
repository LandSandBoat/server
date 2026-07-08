-----------------------------------
-- Evil Entities
-- Seekers of Adoulin M3-3-1
-----------------------------------
-- !addmission 12 46
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.EVIL_ENTITIES)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.ADOULIN_CALLING },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(141),
        },

        [xi.zone.CEIZAK_BATTLEGROUNDS] =
        {
            ['Elmric'] = mission:progressEvent(23),

            onEventFinish =
            {
                [23] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
