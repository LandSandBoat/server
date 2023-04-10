-----------------------------------
-- Cries from the Deep
-- Seekers of Adoulin M4-4
-----------------------------------
-- !addmission 12 93
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.CRIES_FROM_THE_DEEP)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.SEEDS_OF_DOUBT },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(180),
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    return mission:progressEvent(1532, 0, 15827327, utils.MAX_UINT32 - 703, 579, 89, 207, 1998, 4)
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 1 then
                        return 1550
                    end
                end,
            },

            onEventFinish =
            {
                [1532] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                    player:setPos(91.751, -40, -63.998, 127, xi.zone.EASTERN_ADOULIN)
                end,

                [1550] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
