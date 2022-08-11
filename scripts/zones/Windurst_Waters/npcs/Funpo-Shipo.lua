-----------------------------------
-- Area: Windurst Waters
--  NPC: Funpo-Shipo
-- Type: Standard NPC
-- !pos -44.091 -4.499 41.728 238
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -27.810, -3.500, 40.957,
    -27.810, -3.500, 40.957,
    -27.810, -3.500, 40.957,
    -27.810, -3.500, 40.957,
    -27.810, -3.500, 40.957,
    -27.810, -3.500, 40.957,
    -27.810, -3.500, 40.957,
    -27.810, -3.500, 40.957,
    -46.663, -3.500, 41.850,
    -46.663, -3.500, 41.850,
    -46.663, -3.500, 41.850,
    -46.663, -3.500, 41.850,
    -46.663, -3.500, 41.850,
    -46.663, -3.500, 41.850,
    -46.663, -3.500, 41.850,
    -46.663, -3.500, 41.850,
    -46.663, -3.500, 41.850,
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
end

entity.onPath = function(npc)
    xi.path.patrol(npc, path)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local wildcatWindurst = player:getCharVar("WildcatWindurst")

    if (player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(wildcatWindurst, 13)) then
        player:startEvent(938)
    else
        player:startEvent(576)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 938) then
        player:setCharVar("WildcatWindurst", utils.mask.setBit(player:getCharVar("WildcatWindurst"), 13, true))
    end
end

return entity
