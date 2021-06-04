-----------------------------------
-- Shock! Arrant Abuse of Authority
-- A Moogle Kupo d'Etat M7
-- !addmission 10 6
-- Inconspicuous Door : !pos -15 1.300 68
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
local amkHelper = require("scripts/missions/amk/helpers")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.SHOCK_ARRANT_ABUSE_OF_AUTHORITY)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.LENDER_BEWARE_READ_THE_FINE_PRINT },
}

mission.sections =
{
    -- Digging minigame
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and not player:hasKeyItem(xi.ki.MOLDY_WORMEATEN_CHEST)
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Inconspicuous_Door'] =
            {
                -- Reminder
                onTrigger = function(player, npc)
                    local diggingZone = amkHelper.getDiggingZone(player)
                    return mission:progressEvent(10189, diggingZone)
                end,
            },
        },
    },

    -- Got the KI
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and player:hasKeyItem(xi.ki.MOLDY_WORMEATEN_CHEST)
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Inconspicuous_Door'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(10183)
                end,
            },
        },
    },
}

return mission
