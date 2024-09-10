-----------------------------------
-- By the Fading Light
-- Wings of the Goddess Mission 39
-----------------------------------
-- !addmission 5 38
-- Rally Point: Red : !pos -106.071 -25.5 -52.841 137
-----------------------------------
require('scripts/missions/wotg/helpers')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.BY_THE_FADING_LIGHT)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.EDGE_OF_EXISTENCE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.XARCABARD_S] =
        {
            ['Rally_Point_Red'] = mission:progressEvent(41, 137, 0, 0, 7),

            onEventFinish =
            {
                [41] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
