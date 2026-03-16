-----------------------------------
-- Death Cares Not
-- Rhapsodies of Vana'diel Mission 3-16
-----------------------------------
-- !addmission 13 178
-- Empyreal Paradox - Selh'teus ritual cutscene (event 9)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.DEATH_CARES_NOT)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.NO_TIME_LIKE_THE_FUTURE },
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
                return 9
            end,

            onEventFinish =
            {
                [9] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
