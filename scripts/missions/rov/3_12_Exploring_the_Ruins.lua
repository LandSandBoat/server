-----------------------------------
-- Exploring the Ruins
-- Rhapsodies of Vana'diel Mission 3-12
-----------------------------------
-- !addmission 13 166
-- Hall of the Gods - Cloud of Darkness prophecy (event 15)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.EXPLORING_THE_RUINS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.BECOME_SOMETHING_MORE },
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
                return 15
            end,

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
