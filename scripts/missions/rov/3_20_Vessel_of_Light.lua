-----------------------------------
-- Vessel of Light
-- Rhapsodies of Vana'diel Mission 3-20
-----------------------------------
-- !addmission 13 190
-- Reisenjima - Return after Penance, party reunion (event 7)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.VESSEL_OF_LIGHT)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.THE_LIFESTREAM_OF_REISENJIMA },
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
                return 7
            end,

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
