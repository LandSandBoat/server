-----------------------------------
-- Absolute Trust
-- Rhapsodies of Vana'diel Mission 3-33
-----------------------------------
-- !addmission 13 222
-- Empyreal Paradox - Volto Oscuro philosophy cutscene (event 17)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.ABSOLUTE_TRUST)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.THE_ORBS_RADIANCE },
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
                return 17
            end,

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
