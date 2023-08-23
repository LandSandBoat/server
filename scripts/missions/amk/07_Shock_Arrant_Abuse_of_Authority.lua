-----------------------------------
-- Shock! Arrant Abuse of Authority
-- A Moogle Kupo d'Etat M7
-- !addmission 10 6
-- Inconspicuous Door : !pos -15 1.300 68 244
-- Note: KI aquisition is handled in chocobo_digging.lua
-- MOLDY_WORM_EATEN_CHEST : !addkeyitem 1144
-----------------------------------
require('scripts/missions/amk/helpers')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.SHOCK_ARRANT_ABUSE_OF_AUTHORITY)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.LENDER_BEWARE_READ_THE_FINE_PRINT },
}

mission.sections =
{
    -- Intro
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Inconspicuous_Door'] =
            {
                -- Reminder
                onTrigger = function(player, npc)
                    local diggingZone = xi.amk.helpers.getDiggingZone(player)
                    return mission:progressEvent(10182, diggingZone)
                end,
            },

            onEventFinish =
            {
                [10182] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.AMK, 1)
                end,
            },
        },
    },

    -- Digging minigame, handled in
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1 and
                not player:hasKeyItem(xi.ki.MOLDY_WORM_EATEN_CHEST)
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Inconspicuous_Door'] =
            {
                -- Reminder
                onTrigger = function(player, npc)
                    local diggingZone = xi.amk.helpers.getDiggingZone(player)
                    return mission:progressEvent(10189, diggingZone)
                end,
            },
        },
    },

    -- Got the KI
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:hasKeyItem(xi.ki.MOLDY_WORM_EATEN_CHEST)
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Inconspicuous_Door'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(10183)
                end,
            },

            onEventFinish =
            {
                [10183] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.MOLDY_WORM_EATEN_CHEST)
                    end
                end,
            },
        },
    },
}

return mission
