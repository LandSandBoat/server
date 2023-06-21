-----------------------------------
-- The Three Kingdoms (Bastok)
-- Windurst M2-3 (Part 1)
-----------------------------------
-- !addmission 2 7
-- Grohm           : !pos -18 -11 -27 237
-- Pius            : !pos 99 -21 -12 237
-- Patt-Pott       : !pos 23 -17 42 237
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK)

mission.reward = {}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.METALWORKS] =
        {
            ['Grohm'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if mission:getVar(player, 'Option') == 1 then
                        return mission:progressEvent(425)
                    elseif missionStatus == 4 then
                        local onPathUntraveled = player:getCurrentMission(xi.mission.log_id.ROV) == xi.mission.id.rov.THE_PATH_UNTRAVELED and 1 or 0

                        return mission:progressEvent(423, { [7] = onPathUntraveled })
                    elseif missionStatus == 5 and not player:hasItem(xi.items.ONZ_OF_MYTHRIL_SAND) then
                        return mission:progressEvent(424)
                    else
                        return mission:progressEvent(422)
                    end
                end,
            },

            ['Pius'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 3 then
                        return mission:progressEvent(355, 1)
                    end
                end,
            },

            ['Patt-Pott'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        player:getMissionStatus(mission.areaId) == 5 and
                        npcUtil.tradeHasExactly(trade, xi.items.ONZ_OF_MYTHRIL_SAND)
                    then
                        return mission:progressEvent(255)
                    end
                end,
            },

            onEventFinish =
            {
                [255] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:confirmTrade()
                        player:setMissionStatus(mission.areaId, 7)
                        player:addMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS)
                    end
                end,

                [355] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                end,

                [423] = function(player, csid, option, npc)
                    if not npcUtil.giveItem(player, { { xi.items.PICKAXE, 5 } }) then
                        mission:setVar(player, 'Option', 1)
                    else
                        player:setMissionStatus(mission.areaId, 5)
                    end
                end,

                [425] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, { { xi.items.PICKAXE, 5 } }) then
                        player:setMissionStatus(mission.areaId, 5)
                        mission:setVar(player, 'Option', 0)
                    end
                end,
            },
        },
    }
}

return mission
