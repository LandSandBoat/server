-----------------------------------
-- Sin
-- Rhapsodies of Vana'diel Mission 3-18
-----------------------------------
-- !addmission 13 184
-- Walk of Echoes
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.SIN)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.PENANCE },
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
