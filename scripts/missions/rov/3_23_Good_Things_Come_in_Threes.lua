-----------------------------------
-- Good Things Come in Threes
-- Rhapsodies of Vana'diel Mission 3-23
-----------------------------------
-- !addmission 13 196
-- Reisenjima
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.GOOD_THINGS_COME_IN_THREES)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.TACKLING_THE_PROBLEM },
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
