-----------------------------------
-- Calm After the Storm
-- Rhapsodies of Vana'diel Mission 3-27
-----------------------------------
-- !addmission 13 206
-- Walk of Echoes
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.CALM_AFTER_THE_STORM)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.NARY_A_CLOUD_IN_SIGHT },
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
