-----------------------------------
-- The Sealed Shrine
-- Zilart M15
-----------------------------------
-- !addmission 3 27
-- _700 (Oaken Door)       : !pos 97 -7 -12 252
-- Aldo                    : !pos 20 3 -58 245
-- Ru'Avitau Main Entrance : !pos -0.2171 -45.013 -119.7575
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_SEALED_SHRINE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CELESTIAL_NEXUS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['_700'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(172)
                    end
                end,
            },

            ['Gilgamesh'] = mission:event(173),

            onEventFinish =
            {
                [172] = function(player, csid, option, npc)
                    if option == 0 then
                        player:setMissionStatus(mission.areaId, 1)
                    end
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Option') == 0 then
                        return mission:progressEvent(111, 1, 1, 11, 0, 65339390, 899376, 4095, 0)
                    else
                        return mission:event(69, 0, 1, 5, 0, 0, 280, 4095, 4)
                    end
                end,
            },

            onEventFinish =
            {
                [111] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 1)
                end,
            },
        },

        [xi.zone.THE_SHRINE_OF_RUAVITAU] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 51
                    end
                end,
            },

            onEventFinish =
            {
                [51] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
