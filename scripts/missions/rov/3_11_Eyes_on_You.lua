-----------------------------------
-- Eyes on You
-- Rhapsodies of Vana'diel Mission 3-11
-----------------------------------
-- !addmission 13 164
-- Hall of the Gods - Esha'ntarl meets player (event 14)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.EYES_ON_YOU)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.EXPLORING_THE_RUINS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.HALL_OF_THE_GODS] =
        {
            onZoneIn = function(player, prevZone)
                return 14
            end,

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
