-----------------------------------
-- Over the Rainbow
-- Rhapsodies of Vana'diel Mission 2-33
-----------------------------------
-- !addmission 13 120
-- Shantotto : !pos 122 -2 112 239 (Windurst Walls K-7)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.OVER_THE_RAINBOW)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.CACOPHONOUS_DISCORD },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] =
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
