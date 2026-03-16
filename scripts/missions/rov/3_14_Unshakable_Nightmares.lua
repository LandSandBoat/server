-----------------------------------
-- Unshakable Nightmares
-- Rhapsodies of Vana'diel Mission 3-14
-----------------------------------
-- !addmission 13 172
-- Walk of Echoes - Cait Sith/Lilisette cutscene (event 28)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.UNSHAKABLE_NIGHTMARES)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.WHAT_REMAINS_OF_HOPE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WALK_OF_ECHOES] =
        {
            onZoneIn = function(player, prevZone)
                return 28
            end,

            onEventFinish =
            {
                [28] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
