-----------------------------------
-- The River Runs Red
-- Rhapsodies of Vana'diel Mission 3-3
-----------------------------------
-- !addmission 13 152
-- Reisenjima - Post-naraka cutscene (event 6)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.THE_RIVER_RUNS_RED)

mission.reward =
{
    keyItem     = xi.ki.RHAPSODY_IN_FUCHSIA,
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.THE_CRUCIBLE },
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
                return 6
            end,

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
