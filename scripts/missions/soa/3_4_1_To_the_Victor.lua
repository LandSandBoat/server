-----------------------------------
-- To the Victor
-- Seekers of Adoulin M3-4-1
-----------------------------------
-- !addmission 12 52
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
require('scripts/missions/soa/helpers')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.TO_THE_VICTOR)

mission.reward =
{
    title       = xi.title.BOOMY_AND_BUSTY,
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.AN_EXTRAORDINARY_GENTLEMAN },
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
                    if player:hasKeyItem(xi.ki.CARD_JAILER_TEODOR) then
                        return mission:progressEvent(153)
                    else
                        xi.soa.helpers.initGameRound(player)
                        player:setLocalVar('sessionScore', 0)

                        return mission:event(134, mission:getVar(player, 'Status'))
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
                    if option == 0 then
                        player:startEvent(153)
                    elseif option == 2 then
                        mission:setVar(player, 'Status', 2)
                    end
                end,

                [153] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
