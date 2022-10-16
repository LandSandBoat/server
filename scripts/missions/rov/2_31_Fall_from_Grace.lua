-----------------------------------
-- Fall from Grace
-- Rhapsodies of Vana'diel Mission 2-31
-----------------------------------
-- !addmission 13 116
-- Shattered Telepoint (Konschtat) : !pos 135 19 220 108
-- Shattered Telepoint (La Theine) : !pos 334 19 -60 102
-- Shattered Telepoint (Tahrongi)  : !pos 179 35 255 117
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/utils')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.FALL_FROM_GRACE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.BANISHING_THE_DARKNESS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        -- NOTE: Event parameters use from character with full mission completion status.

        [xi.zone.KONSCHTAT_HIGHLANDS] =
        {
            ['Shattered_Telepoint'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(5, 1, 1, 0, 0, 108, 9, 1, 55)
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Shattered_Telepoint'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(16, 1, 1, 0, 0, 90963, 955, 1, 0)
                end,
            },

            onEventFinish =
            {
                [16] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.TAHRONGI_CANYON] =
        {
            ['Shattered_Telepoint'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(43, 1, 1, utils.MAX_UINT32 - 1, utils.MAX_UINT32 - 1, 0, 0, 1, 0)
                end,
            },

            onEventFinish =
            {
                [43] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
