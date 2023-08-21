-----------------------------------
-- Heroes, Unite!
-- Seekers of Adoulin M5-1-2
-----------------------------------
-- !addmission 12 110
-- Levil        : !pos -87.204 3.350 12.655 256
-- Alpine Trail : !pos -13.479 -1.047 488.863 267
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.HEROES_UNITE)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.A_PORTENT_MOST_OMINOUS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(40),
        },

        [xi.zone.KAMIHR_DRIFTS] =
        {
            ['Alpine_Trail'] = mission:progressEvent(60, 267, 300, 200, 100, 4063, 1999, 1999, 0),

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 2 then
                        mission:complete(player)
                    end
                end,
            },

            onEventFinish =
            {
                [60] = function(player, csid, option, npc)
                    if option == 1 then
                        mission:setVar(player, 'Status', 1)
                        player:setPos(306.42, -0.073, -24.974, 199, xi.zone.MOUNT_KAMIHR)
                    end
                end,
            },
        },

        [xi.zone.MOUNT_KAMIHR] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 1 then
                        return 6
                    end
                end,
            },

            onEventUpdate =
            {
                [6] = function(player, csid, option, npc)
                    if
                        csid == 6 and
                        option == 1
                    then
                        player:updateEvent(10, 23, 1756, 0, 0, 1, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                    player:setPos(-8.495, 0.454, 487.467, 12, xi.zone.KAMIHR_DRIFTS)
                end,
            },
        },
    },
}

return mission
