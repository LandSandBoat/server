-----------------------------------
-- Cacophonous Discord
-- Rhapsodies of Vana'diel Mission 2-34
-----------------------------------
-- !addmission 13 122
-- Undulating Confluence (Misareaux) : !pos -48.908 -23.302 572.269 25
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.CACOPHONOUS_DISCORD)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.EDDIES_OF_DESPAIR_II },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.MISAREAUX_COAST] =
        {
            ['Undulating_Confluence'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: Verify event ID from packet captures
                    mission:complete(player)
                    return mission:noAction()
                end,
            },
        },
    },
}

return mission
