-----------------------------------
-- Guardians
-- Rhapsodies of Vana'diel Mission 3-31
-----------------------------------
-- !addmission 13 218
-- Reisenjima Sanctorium - Tenzen/crystal cutscene (event 10)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.GUARDIANS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.IROHA_IN_DISTRESS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.REISENJIMA_SANCTORIUM] =
        {
            onZoneIn = function(player, prevZone)
                return 10
            end,

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
