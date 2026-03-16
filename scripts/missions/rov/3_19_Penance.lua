-----------------------------------
-- Penance
-- Rhapsodies of Vana'diel Mission 3-19
-----------------------------------
-- !addmission 13 188
-- Walk of Echoes
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.PENANCE)

mission.reward =
{
    keyItem     = xi.ki.RHAPSODY_IN_PUCE,
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.VESSEL_OF_LIGHT },
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
