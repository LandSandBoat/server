-----------------------------------
-- Shock! Arrant Abuse of Authority
-- A Moogle Kupo d'Etat M7
-- !addmission 10 6
-- Inconspicuous Door : !pos -15 1.300 68
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
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
                -- 1 = Valkurm Dunes
                -- 2 = Jugner Forest
                -- 3 = Knoschtat Highlands
                -- 4 = Pashhow Marshlands
                -- 5 = Tahrongi Canyon
                -- 6 = Buburimu Peninsula
                -- 7 = Meriphataud Mountains
                -- 8 = The Sanctuary of Zi'tah
                -- 9 = Yuhtunga Jungle
                -- 10 = Yhoator_Jungle
                -- 11 = Western Altepa Desert
                -- 12 = Eastern Altepa Desert
                onTrigger = function(player, npc)
                    local diggingZone = player:getCharVar("AMK6_DIGGING_ZONE")
                    if diggingZone == 0 then
                        diggingZone = math.random(1, 12)
                        player:setCharVar("AMK6_DIGGING_ZONE", diggingZone)
                    end
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
