-----------------------------------
-- The Celennia Memorial Library
-- Seekers of Adoulin M2-5-1
-----------------------------------
-- !addmission 12 21
-- Yefafa  : !pos -115.639 -2.150 -95.024 284
-- History : !pos -116.250 -3.650 -90.147 284
-- Levil   : !pos -87.204 3.350 12.655 256
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/utils')
require('scripts/globals/zone')
require('scripts/settings/main')
-----------------------------------
local ID = require('scripts/zones/Western_Adoulin/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_CELENNIA_MEMORIAL_LIBRARY)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.FOR_WHOM_DO_WE_TOIL },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.CELENNIA_MEMORIAL_LIBRARY] =
        {
            ['Yefafa'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(1)
                end,
            },

            ['History'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(1003, 1)
                end,
            },

            onEventUpdate =
            {
                [1003] = function(player, csid, option, npc)
                    -- Was shown the password
                    if option == 1 then
                        player:setMissionStatus(mission.areaId, 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.CELENNIA_MEMORIAL_LIBRARY] =
        {
            ['Yefafa'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(1)
                end,
            },

            ['History'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(1003, 1)
                end,
            },
        },

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(125)
                end,
            },

            onEventFinish =
            {
                [125] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
