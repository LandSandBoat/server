-----------------------------------
-- The Smallest of Favors
-- Seekers of Adoulin M3-2-2
-----------------------------------
-- !addmission 12 44
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_SMALLEST_OF_FAVORS)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.SUMMONED_BY_SPIRITS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(141),
        },

        [xi.zone.CEIZAK_BATTLEGROUNDS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    -- TODO: Do not include Waypoint teleports to Ceizak

                    if
                        prevZone == xi.zone.WESTERN_ADOULIN and
                        mission:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
                        return 20
                    end
                end,
            },

            onEventFinish =
            {
                [20] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
