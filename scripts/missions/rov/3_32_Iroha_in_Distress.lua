-----------------------------------
-- Iroha in Distress
-- Rhapsodies of Vana'diel Mission 3-32
-----------------------------------
-- !addmission 13 220
-- Empyreal Paradox - Iroha/Volto Oscuro cutscene (event 13)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.IROHA_IN_DISTRESS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.ABSOLUTE_TRUST },
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
                return 13
            end,

            onEventFinish =
            {
                [13] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
