-----------------------------------
-- Area: Port Jeuno
--  NPC: Red Ghost
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local path =
{
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.519, 0.001, -7.582,
    -96.587, 0.001, -8.522, -- Forces turn.
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.241, 0.001, 7.794,
    -96.244, 0.001, 8.875, -- Forces turn.
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
        not utils.mask.getBit(wildcatJeuno, 15)
    then
        player:startEvent(314)
    else
        player:startEvent(34)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 314 then
        player:setCharVar("WildcatJeuno", utils.mask.setBit(player:getCharVar("WildcatJeuno"), 15, true))
    end
end

return entity
