-----------------------------------
-- A Deep Sleep
-- Rhapsodies of Vana'diel Mission 3-30
-----------------------------------
-- !addmission 13 216
-- Reisenjima - Iroha farewell cutscene (event 9)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.A_DEEP_SLEEP)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.GUARDIANS },
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
