-----------------------------------
-- A Rhapsody for the Ages
-- Rhapsodies of Vana'diel Mission 3-35
-----------------------------------
-- !addmission 13 226
-- La Theine Plateau - Avatar convergence finale (event 19)
-- Final mission of Rhapsodies of Vana'diel
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.A_RHAPSODY_FOR_THE_AGES)

mission.reward =
{
    -- Final mission - no nextMission
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            onZoneIn = function(player, prevZone)
                return 19
            end,

            onEventFinish =
            {
                [19] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
