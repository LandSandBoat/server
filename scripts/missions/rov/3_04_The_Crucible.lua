-----------------------------------
-- The Crucible
-- Rhapsodies of Vana'diel Mission 3-4
-----------------------------------
-- !addmission 13 154
-- Ceizak Battlegrounds - Arciela cutscene (event 33)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.THE_CRUCIBLE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.FORWARD_THINKING },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CEIZAK_BATTLEGROUNDS] =
        {
            onZoneIn = function(player, prevZone)
                return 33
            end,

            onEventFinish =
            {
                [33] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
