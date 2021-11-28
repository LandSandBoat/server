-----------------------------------
-- Westerly Winds
-- Aht Uhrgan Mission 7
-----------------------------------
-- !addmission 4 6
-- Naja Salaheem : !pos 22.700 -8.804 -45.591 50
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/keyitems')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.WESTERLY_WINDS)

mission.reward =
{
    item        = xi.items.IMPERIAL_SILVER_PIECE,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.A_MERCENARY_LIFE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(3028, 0, 0, 0, 0, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onRegionEnter =
            {
                [5] = function(player, region)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(3027, 0, 0, 0, 0, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [3027] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.items.IMPERIAL_SILVER_PIECE) then
                        npcUtil.giveKeyItem(player, xi.ki.RAILLEFALS_NOTE)
                        player:setTitle(xi.title.AGENT_OF_THE_ALLIED_FORCES)
                        player:setMissionStatus(mission.areaId, 1)
                    end
                end,

                [3028] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:setLocalVar('Mission[4][7]mustZone', 1)
                    end
                end,
            },
        },
    },
}

return mission
