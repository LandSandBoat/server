-----------------------------------
-- The Princess's Dilemma
-- Seekers of Adoulin M3-2-0
-----------------------------------
-- !addmission 12 42
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_PRINCESSS_DILEMMA)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.DARK_CLOUDS_AHEAD },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(140),
        },

        [xi.zone.CELENNIA_MEMORIAL_LIBRARY] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 2
                end,
            },

            onEventUpdate =
            {
                [2] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(0, 0, 1756)
                    elseif option == 2 then
                        player:updateEvent(3, 0, 1756)
                    elseif option == 3 then
                        player:updateEvent(5, 1, 1756)
                    elseif option == 4 then
                        player:updateEvent(0, 511900, 1756)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    if option == 2 then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
