-----------------------------------
-- The Lifestream of Reisenjima
-- Rhapsodies of Vana'diel Mission 3-21
-----------------------------------
-- !addmission 13 192
-- Reisenjima
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.THE_LIFESTREAM_OF_REISENJIMA)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.FROM_WEST_TO_EAST },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.REISENJIMA] =
        {
            onZoneIn = function(player, prevZone)
                -- TODO: Verify event ID from packet captures
                mission:complete(player)
            end,
        },
    },
}

return mission
