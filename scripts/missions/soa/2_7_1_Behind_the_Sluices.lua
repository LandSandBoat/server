-----------------------------------
-- Behind the Sluices
-- Seekers of Adoulin M2-7-1
-----------------------------------
-- !addmission 12 31
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.BEHIND_THE_SLUICES)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_LEAFKIN_MONARCH },
}

mission.sections =
{
    -- Get entry KI
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                   not player:hasKeyItem(xi.ki.WATERWAY_FACILITY_CRANK) and
                   missionStatus == 0
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Storage_Container'] =
            {
                onTrigger = function(player, npc)
                    return mission:keyItem(xi.ki.WATERWAY_FACILITY_CRANK)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                   player:hasKeyItem(xi.ki.WATERWAY_FACILITY_CRANK) and
                   missionStatus == 0
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Sluice_Gate_6'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(359)
                end,
            },

            onEventFinish =
            {
                [359] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                   player:hasKeyItem(xi.ki.WATERWAY_FACILITY_CRANK) and
                   missionStatus == 1
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Sluice_Gate_6'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(361)
                end,
            },

            onEventFinish =
            {
                [361] = function(player, csid, option, npc)
                    if option == 1 then
                        player:setPos(-554, -5.7, 60, 0)
                        player:setMissionStatus(mission.areaId, 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                   player:hasKeyItem(xi.ki.WATERWAY_FACILITY_CRANK) and
                   missionStatus == 2
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Antiquated_Sluice_Gate'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: Instance battle
                    return mission:progressEvent(5511)
                end,
            },

            onEventFinish =
            {
                [361] = function(player, csid, option, npc)
                    -- TODO
                end,
            },
        },
    },

    -- Returning from instanced battle (missionStatus == 3)
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                   player:hasKeyItem(xi.ki.WATERWAY_FACILITY_CRANK) and
                   missionStatus == 3
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return mission:progressEvent(353)
                end,
            },

            onEventFinish =
            {
                [353] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
