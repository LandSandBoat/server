-----------------------------------
-- Tackling the Problem
-- Rhapsodies of Vana'diel Mission 3-24
-----------------------------------
-- !addmission 13 198
-- Reisenjima Sanctorium - Post-panopt victory cutscene (event 6)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.TACKLING_THE_PROBLEM)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.WAY_TO_DIVINITY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.REISENJIMA_SANCTORIUM] =
        {
            onZoneIn = function(player, prevZone)
                return 6
            end,

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
