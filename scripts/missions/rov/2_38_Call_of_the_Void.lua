-----------------------------------
-- Call of the Void
-- Rhapsodies of Vana'diel Mission 2-38
-----------------------------------
-- !addmission 13 132
-- Dimensional Portal at Crags (Holla/Dem/Mea)
-- Konschtat Highlands : !pos 220 19 300 108
-- La Theine Plateau   : !pos 420 19 20 102
-- Tahrongi Canyon     : !pos 100 35 340 117
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.CALL_OF_THE_VOID)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.BOTH_PATHS_TAKEN },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.KONSCHTAT_HIGHLANDS] =
        {
            ['Telepoint'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: Verify event ID from packet captures
                    mission:complete(player)
                    return mission:noAction()
                end,
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Telepoint'] =
            {
                onTrigger = function(player, npc)
                    mission:complete(player)
                    return mission:noAction()
                end,
            },
        },

        [xi.zone.TAHRONGI_CANYON] =
        {
            ['Telepoint'] =
            {
                onTrigger = function(player, npc)
                    mission:complete(player)
                    return mission:noAction()
                end,
            },
        },
    },
}

return mission
