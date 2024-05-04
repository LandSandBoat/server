-----------------------------------
-- Shock! Arrant Abuse of Authority
-- A Moogle Kupo d'Etat M7
-- !addmission 10 6
-- Inconspicuous Door : !pos -15 1.300 68 244
-- Note: KI aquisition is handled in chocobo_digging.lua
-- MOLDY_WORM_EATEN_CHEST : !addkeyitem 1144
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.SHOCK_ARRANT_ABUSE_OF_AUTHORITY)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.LENDER_BEWARE_READ_THE_FINE_PRINT },
}

mission.sections =
{
    -- Digging minigame, handled in xi.amk.helpers and chocobo_digging.lua
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                not player:hasKeyItem(xi.ki.MOLDY_WORM_EATEN_CHEST)
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Inconspicuous_Door'] =
            {
                -- Reminder
                onTrigger = function(player, npc)
                    -- Variable is stored as 1-indexed zone offset, cutscenes are 0-indexed
                    local diggingZone = xi.amk.helpers.getDiggingZone(player)
                    local diggingZoneCsId = xi.amk.helpers.digSites[diggingZone].eventID
                    return mission:progressEvent(10189, diggingZoneCsId)
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
