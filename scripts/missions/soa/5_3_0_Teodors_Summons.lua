-----------------------------------
-- Teodor's Summons
-- Seekers of Adoulin M5-3
-----------------------------------
-- !addmission 12 116
-- Levil        : !pos -87.204 3.350 12.655 256
-- Alpine Trail : !pos -13.479 -1.047 488.863 267
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.TEODORS_SUMMONS)

mission.reward =
{
    keyItem     = xi.ki.ASH_RUNIC_BOARD,
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_SEVENTH_GUARDIAN },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(40, 256, 0, 5, 0, 0, 0, 0, 4),
        },

        [xi.zone.KAMIHR_DRIFTS] =
        {
            ['Alpine_Trail'] = mission:progressEvent(61, 267, 0, 0, 0, 144546, utils.MAX_UINT32 - 1728, 635049, 0),

            onEventFinish =
            {
                [61] = function(player, csid, option, npc)
                    if option == 1 then
                        mission:setVar(player, 'Status', 1)
                        player:setPos(306.42, -0.051, -24.974, 199, xi.zone.MOUNT_KAMIHR)
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
                        return 7
                    end
                end,
            },

            onEventUpdate =
            {
                [7] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(10, 23, 1756, 0, 0, 1, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    mission:complete(player)
                    player:setPos(-8.495, 0.454, 487.467, 12, xi.zone.KAMIHR_DRIFTS)
                end,
            },
        },
    },
}

return mission
