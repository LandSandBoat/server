-----------------------------------
-- The Celennia Memorial Library
-- Seekers of Adoulin M2-5-1
-----------------------------------
-- !addmission 12 21
-- Yefafa  : !pos -115.639 -2.150 -95.024 284
-- History : !pos -116.250 -3.650 -90.147 284
-- Levil   : !pos -87.204 3.350 12.655 256
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
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, mission.missionId) == 0 then
                        return mission:event(124)
                    else
                        return mission:progressEvent(125)
                    end
                end,
            },

            onEventFinish =
            {
                [125] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.CELENNIA_MEMORIAL_LIBRARY] =
        {
            ['Yefafa'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(1, 284)
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
                        player:updateEvent(284)
                    end
                end,
            },
        },
    },
}

return mission
