-----------------------------------
-- The Path Untraveled
-- Rhapsodies of Vana'diel Mission 1-7
-----------------------------------
-- !addmission 13 12
-- Shattered Telepoint (Konschtat) : !pos 135 19 220 108
-- Shattered Telepoint (La Theine) : !pos 334 19 -60 102
-- Shattered Telepoint (Tahrongi)  : !pos 179 35 255 117
-- Gilgamesh                       : !pos 122.452 -9.009 -12.052 252
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.THE_PATH_UNTRAVELED)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.AT_THE_HEAVENS_DOOR },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:getRank(player:getNation()) >= 3
        end,

        [xi.zone.KONSCHTAT_HIGHLANDS] =
        {
            ['Shattered_Telepoint'] = mission:event(3):setPriority(1005),

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Shattered_Telepoint'] = mission:event(14):setPriority(1005),

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.TAHRONGI_CANYON] =
        {
            ['Shattered_Telepoint'] = mission:event(41):setPriority(1005),

            onEventFinish =
            {
                [41] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },

    -- Generic Messages
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['Gilgamesh'] = mission:event(263),
        },
    },
}

return mission
