-----------------------------------
-- The Decisive Heroine
-- Rhapsodies of Vana'diel Mission 2-30
-----------------------------------
-- !addmission 13 114
-- Blue ??? in Escha - Ru'Aun (H-10)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.THE_DECISIVE_HEROINE)

mission.reward =
{
    keyItem     = xi.ki.RHAPSODY_IN_EMERALD,
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.FALL_FROM_GRACE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.ESCHA_RUAUN] =
        {
            onZoneIn = function(player, prevZone)
                -- TODO: Verify event ID from packet captures
                mission:complete(player)
            end,
        },
    },
}

return mission
