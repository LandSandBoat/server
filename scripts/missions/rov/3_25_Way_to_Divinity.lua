-----------------------------------
-- Way to Divinity
-- Rhapsodies of Vana'diel Mission 3-25
-----------------------------------
-- !addmission 13 200
-- Empyreal Paradox - Reckoning choice cutscene (event 14)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.WAY_TO_DIVINITY)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.THE_WINDS_OF_TIME },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.EMPYREAL_PARADOX] =
        {
            onZoneIn = function(player, prevZone)
                return 14
            end,

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
