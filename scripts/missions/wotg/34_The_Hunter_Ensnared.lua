-----------------------------------
-- The Hunter Ensnared
-- Wings of the Goddess Mission 34
-----------------------------------
-- !addmission 5 33
-- Rally Point: Red : !pos -106.071 -25.5 -52.841 137
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.THE_HUNTER_ENSNARED)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.FLIGHT_OF_THE_LION },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.XARCABARD_S] =
        {
            ['Rally_Point_Red'] = mission:progressEvent(24, 137, 23, 1756, 0, 65863679, 8553890, 4095, 0),

            onEventFinish =
            {
                [24] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
