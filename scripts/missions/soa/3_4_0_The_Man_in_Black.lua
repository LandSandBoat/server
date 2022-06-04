-----------------------------------
-- The Man in Black
-- Seekers of Adoulin M3-4
-----------------------------------
-- !addmission 12 51
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
require('scripts/missions/soa/helpers')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_MAN_IN_BLACK)

mission.reward =
{
    bayld       = 100,
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.TO_THE_VICTOR },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(142),

            ['Masad'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki) then
                        return mission:progressEvent(153)
                    else
                        xi.soa.helpers.initGameRound(player)
                        player:setLocalVar('sessionScore', 0)

                        return mission:event(134, 0) -- 1 is first time on To the Victor, 2 is after loss
                    end
                end,
            },

            onEventUpdate =
            {
                [134] = function(player, csid, option, npc)
                    xi.soa.helpers.updateMinigameEvent(player, csid, option, npc)
                end,
            },

            onEventFinish =
            {
                [134] = function(player, csid, option, npc)
                    mission:complete(player)

                    if option == 0 then
                        player:completeMission(xi.mission.log_id.SOA, xi.mission.id.soa.TO_THE_VICTOR)
                        player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.AN_EXTRAORDINARY_GENTLEMAN)

                        player:startEvent(153)
                    end
                end,

                [153] = function(player, csid, option, npc)
                    mission:complete(player)

                    player:completeMission(xi.mission.log_id.SOA, xi.mission.id.soa.TO_THE_VICTOR)
                    player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.AN_EXTRAORDINARY_GENTLEMAN)
                end,
            },
        },
    },
}

return mission
