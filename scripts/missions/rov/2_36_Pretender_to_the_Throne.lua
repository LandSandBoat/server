-----------------------------------
-- Pretender to the Throne
-- Rhapsodies of Vana'diel Mission 2-36
-----------------------------------
-- !addmission 13 126
-- Escha - Ru'Aun ??? (battle vs Balamor)
-- NOTE: Retail requires defeating Balamor. Stubbed to auto-complete on zone-in.
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.PRETENDER_TO_THE_THRONE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.BANISHED },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.ESCHA_RUAUN] =
        {
            onZoneIn = function(player, prevZone)
                -- TODO: Implement Balamor battlefield. Auto-completing for now.
                mission:complete(player)
            end,
        },
    },
}

return mission
