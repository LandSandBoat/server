-----------------------------------
-- Forward Thinking
-- Rhapsodies of Vana'diel Mission 3-5
-----------------------------------
-- !addmission 13 155
-- Eastern Adoulin
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.FORWARD_THINKING)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.TEARS_OF_THE_GENERALS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            onZoneIn = function(player, prevZone)
                -- TODO: Verify event ID from packet captures
                mission:complete(player)
            end,
        },
    },
}

return mission
