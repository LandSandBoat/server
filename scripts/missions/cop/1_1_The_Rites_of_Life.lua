-----------------------------------
-- The Rites of Life
-- Promathia 1-1
-----------------------------------
-- NOTE: xi.mission.id.cop.THE_RITES_OF_LIFE is set when zoning into Lower Delkfutt's Tower from Qufim
--       ENABLE_COP must be set to 1 in scripts/globals/settings.lua
-- 1. Enter Lower Delkfutt: !pos -286 -20 320 126
-- 2. Enter Upper Jeuno:    !pos 2.2 -3.2 58.4 245
-- 3. Talk to Monberaux:    !pos -43 0 -1 244
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.THE_RITES_OF_LIFE)

mission.reward =
{
    keyItem     = xi.ki.MYSTERIOUS_AMULET,
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.BELOW_THE_ARKS },
}

mission.sections =
{
    -- 1. To start this mission, enter Lower Delkfutt's Tower for a cutscene after installing the Chains of Promathia expansion pack.
    {
        check = function(player, currentMission, missionStatus, vars)
            return ENABLE_COP == 1 and currentMission < xi.mission.id.cop.THE_RITES_OF_LIFE
        end,

        [xi.zone.LOWER_DELKFUTTS_TOWER] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if prevZone == xi.zone.QUFIM_ISLAND then
                        return 22
                    end
                end,
            },

            onEventFinish =
            {
                [22] = function(player, csid, option, npc)
                    return mission:event(36)
                end,

                [36] = function(player, csid, option, npc)
                    return mission:event(37)
                end,

                [37] = function(player, csid, option, npc)
                    return mission:event(38)
                end,

                [38] = function(player, csid, option, npc)
                    return mission:event(39)
                end,

                [39] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.COP, 0)
                    mission:begin(player)
                end,
            },
        },
    },

    -- 2. After the cutscene has finished, enter Upper Jeuno for another cutscene.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 2
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.COP, 1)
                end,
            },
        },
    },

    -- 3. After the second cutscene finishes, speak to Monberaux (G-10, inside the Infirmary) for final cutscene and a Mysterious Amulet.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Monberaux'] = mission:progressEvent(10),

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    return mission:event(206)
                end,

                [206] = function(player, csid, option, npc)
                    return mission:event(207)
                end,

                [207] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.COP, 0)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
