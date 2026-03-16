-----------------------------------
-- Become Something More
-- Rhapsodies of Vana'diel Mission 3-13
-----------------------------------
-- !addmission 13 170
-- Reisenjima Sanctorium - Iroha/Selh'teus crystal cutscene (event 1)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.BECOME_SOMETHING_MORE)

mission.reward =
{
    keyItem     = xi.ki.DIMENSIONAL_COMPASS,
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.UNSHAKABLE_NIGHTMARES },
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
                return 1
            end,

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
