-----------------------------------
-- What Remains of Hope
-- Rhapsodies of Vana'diel Mission 3-15
-----------------------------------
-- !addmission 13 174
-- Walk of Echoes
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.WHAT_REMAINS_OF_HOPE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.DEATH_CARES_NOT },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WALK_OF_ECHOES] =
        {
            onZoneIn = function(player, prevZone)
                -- TODO: Verify event ID from packet captures
                mission:complete(player)
            end,
        },
    },
}

return mission
