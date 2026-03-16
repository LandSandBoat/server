-----------------------------------
-- No Time Like the Future
-- Rhapsodies of Vana'diel Mission 3-17
-----------------------------------
-- !addmission 13 180
-- Empyreal Paradox - Defeat Sempurne
-- NOTE: Retail requires defeating Sempurne. Stubbed to auto-complete.
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.NO_TIME_LIKE_THE_FUTURE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.SIN },
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
                -- TODO: Implement Sempurne battlefield. Auto-completing for now.
                mission:complete(player)
            end,
        },
    },
}

return mission
