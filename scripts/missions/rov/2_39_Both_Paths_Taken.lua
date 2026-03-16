-----------------------------------
-- Both Paths Taken
-- Rhapsodies of Vana'diel Mission 2-39
-----------------------------------
-- !addmission 13 136
-- Transcendental Radiance in Empyreal Paradox
-- NOTE: Retail requires defeating the Disjoined One. Stubbed to auto-complete.
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.BOTH_PATHS_TAKEN)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.THE_MAN_BEHIND_THE_MASK },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.EMPYREAL_PARADOX] =
        {
            onZoneIn = function(player, prevZone)
                -- TODO: Implement Disjoined One battlefield. Auto-completing for now.
                mission:complete(player)
            end,
        },
    },
}

return mission
