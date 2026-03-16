-----------------------------------
-- What He Left Behind
-- Rhapsodies of Vana'diel Mission 3-7
-----------------------------------
-- !addmission 13 158
-- Eastern Adoulin
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.WHAT_HE_LEFT_BEHIND)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.GONE_BUT_NOT_FORGOTTEN },
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
