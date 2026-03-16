-----------------------------------
-- Eddies of Despair (II)
-- Rhapsodies of Vana'diel Mission 2-35
-----------------------------------
-- !addmission 13 124
-- Escha - Ru'Aun portal exploration + ??? at Portal #15
-- NOTE: Retail requires traversing portals 1-15 collecting Eschan Droplets.
-- Stubbed to auto-complete on zone-in for now.
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.EDDIES_OF_DESPAIR_II)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.PRETENDER_TO_THE_THRONE },
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
                -- TODO: Retail requires portal traversal collecting Eschan Droplets.
                -- Auto-completing on zone-in for now.
                mission:complete(player)
            end,
        },
    },
}

return mission
