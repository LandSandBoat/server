-----------------------------------
-- An Errand! The Professor's Price
-- A Moogle Kupo d'Etat M6
-- !addmission 10 5
-- Inconspicuous Door : !pos -15 1.300 68
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.AN_ERRAND_THE_PROFESSORS_PRICE)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.SHOCK_ARRANT_ABUSE_OF_AUTHORITY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and vars.Prog == 2
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Inconspicuous_Door'] =
            {
                onTrigger = function(player, npc)
                    -- Randomly select zone for digging
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
                    local diggingZone = player:getCharVar("AMK6_DIGGING_ZONE")
                    if diggingZone == 0 then
                        diggingZone = math.random(1, 12)
                        player:setCharVar("AMK6_DIGGING_ZONE", diggingZone)
                    end
                    return mission:progressEvent(10182, diggingZone)
                end,
            },

            onEventFinish =
            {
                [10182] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
