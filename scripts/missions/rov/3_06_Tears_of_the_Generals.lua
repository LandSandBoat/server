-----------------------------------
-- Tears of the Generals
-- Rhapsodies of Vana'diel Mission 3-6
-----------------------------------
-- !addmission 13 156
-- Ceizak Battlegrounds - Iroha/Ambassador cutscene (event 34)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.TEARS_OF_THE_GENERALS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.WHAT_HE_LEFT_BEHIND },
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
                return 34
            end,

            onEventFinish =
            {
                [34] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
