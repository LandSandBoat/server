-----------------------------------
-- Darkness Beckons
-- Rhapsodies of Vana'diel Mission 3-1
-----------------------------------
-- !addmission 13 146
-- Reisenjima - Iroha reunion cutscene (event 2)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.DARKNESS_BECKONS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.THE_BREWING_STORM },
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
                return 2
            end,

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
