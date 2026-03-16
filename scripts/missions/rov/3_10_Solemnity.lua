-----------------------------------
-- Solemnity
-- Rhapsodies of Vana'diel Mission 3-10
-----------------------------------
-- !addmission 13 162
-- Eastern Adoulin
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.SOLEMNITY)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.EYES_ON_YOU },
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
