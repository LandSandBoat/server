-----------------------------------
-- Area: Upper Jeuno
--  NPC: Sibila-Mobla
-- Standard Info NPC
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local path =
{
    -53.229, 0.000, 123.029,
    -53.801, 0.000, 123.204,
    -54.386, 0.000, 123.118,
    -54.762, 0.000, 122.991,
    -55.098, 0.000, 122.685,
    -55.285, 0.000, 122.347,
    -55.579, 0.000, 121.500,
    -55.470, 0.000, 120.768,
    -55.073, 0.000, 119.928,
    -54.497, 0.000, 119.663,
    -53.861, 0.000, 119.481,
    -53.027, 0.000, 119.519,
    -52.351, 0.000, 120.075,
    -52.146, 0.000, 120.675,
    -52.048, 0.000, 121.196,
    -52.135, 0.000, 121.740,
    -52.441, 0.000, 122.405,
    -53.149, 0.000, 122.905,
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
    local wildcatJeuno = player:getCharVar("WildcatJeuno")

    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatJeuno, 5)
    then
        player:startEvent(10083)
    else
        player:startEvent(98)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10083 then
        player:setCharVar("WildcatJeuno", utils.mask.setBit(player:getCharVar("WildcatJeuno"), 5, true))
    end
end

return entity
