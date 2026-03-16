-----------------------------------
-- August Artifacts
-- Rhapsodies of Vana'diel Mission 3-9
-----------------------------------
-- !addmission 13 161
-- Celennia Memorial Library - Arciela/Balamor research cutscene (event 40)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.AUGUST_ARTIFACTS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.SOLEMNITY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CELENNIA_MEMORIAL_LIBRARY] =
        {
            onZoneIn = function(player, prevZone)
                return 40
            end,

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
