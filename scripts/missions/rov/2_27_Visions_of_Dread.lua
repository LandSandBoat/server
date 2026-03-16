-----------------------------------
-- Visions of Dread
-- Rhapsodies of Vana'diel Mission 2-27
-----------------------------------
-- !addmission 13 106
-- Hall of Transference : zone 14
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.VISIONS_OF_DREAD)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.TO_THE_SKIES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.HALL_OF_TRANSFERENCE] =
        {
            onZoneIn = function(player, prevZone)
                -- TODO: Verify event ID from packet captures
                mission:complete(player)
            end,
        },
    },
}

return mission
