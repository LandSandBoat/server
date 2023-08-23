-----------------------------------
-- Darrcuiln
-- Seekers of Adoulin M4-2-4
-----------------------------------
-- !addmission 12 81
-- Levil            : !pos -87.204 3.350 12.655 256
-- Darkened Crevice : !pos 185.752 27.311 240.72 273
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.DARRCUILN)

mission.reward =
{
    keyItem     = xi.ki.TUFT_OF_GOLDEN_FUR,
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_GATES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(165),
        },

        [xi.zone.WOH_GATES] =
        {
            ['Darkened_Crevice'] = mission:progressEvent(8),

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
