-----------------------------------
-- The Winds of Time
-- Rhapsodies of Vana'diel Mission 3-26
-----------------------------------
-- !addmission 13 202
-- Empyreal Paradox - Defeat Metus
-- NOTE: Retail requires defeating Metus. Stubbed to auto-complete.
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.THE_WINDS_OF_TIME)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.CALM_AFTER_THE_STORM },
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
                -- TODO: Implement Metus battlefield. Auto-completing for now.
                mission:complete(player)
            end,
        },
    },
}

return mission
