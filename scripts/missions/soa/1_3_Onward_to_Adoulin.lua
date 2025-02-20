-----------------------------------
-- Onward to Adoulin
-- Seekers of Adoulin M1-3
-----------------------------------
-- !addmission 12 3
-- Waypoint : !pos -34.922 0.000 -30.966 245
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.ONWARD_TO_ADOULIN)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.HEARTWINGS_AND_THE_KINDHEARTED },
}

mission.sections =
{
    -- 0: Inspect Waypoint
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Waypoint'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(10120)
                end,
            },

            onEventFinish =
            {
                [10120] = function(player, csid, option, npc)
                    if option == 1 then
                        player:setMissionStatus(mission.areaId, 1)
                    end
                end,
            },
        },
    },

    -- 1: Arrive in Ceizak Battlegrounds
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.CEIZAK_BATTLEGROUNDS] =
        {
            onZoneIn = function(player, prevZone)
                return 3
            end,

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
