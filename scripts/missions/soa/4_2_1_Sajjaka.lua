-----------------------------------
-- Sajj'aka
-- Seekers of Adoulin M4-2-1
-----------------------------------
-- !addmission 12 78
-- Levil   : !pos -87.204 3.350 12.655 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.SAJJAKA)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.STUDYING_UP },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(165),
        },

        [xi.zone.CELENNIA_MEMORIAL_LIBRARY] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 5
                end,
            },

            onEventUpdate =
            {
                [5] = function(player, csid, option, npc)
                    -- TODO: Verify if this is necessary, or if there are other parameters
                    -- that could impact this event.
                    if option == 1 then
                        player:updateEvent(0, 2339983, 1756, 0, 0, 0, 0, 0)
                    elseif option == 4 then
                        player:updateEvent(3, 0, 1756, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
