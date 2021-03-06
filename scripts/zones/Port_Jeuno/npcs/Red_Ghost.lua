-----------------------------------
-- Area: Port Jeuno
--  NPC: Red Ghost
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local path =
{
-96.823616, 0.001000, -3.722488,
-96.761887, 0.001000, -2.632236,
-96.698341, 0.001000, -1.490001,
-96.636963, 0.001000, -0.363672,
-96.508736, 0.001000, 2.080966,
-96.290009, 0.001000, 6.895948,
-96.262505, 0.001000, 7.935584,
-96.282127, 0.001000, 6.815756,
-96.569176, 0.001000, -7.781419,
-96.256729, 0.001000, 8.059505,
-96.568405, 0.001000, -7.745419,
-96.254066, 0.001000, 8.195477,
-96.567200, 0.001000, -7.685426
}
entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
end

entity.onPath = function(npc)
    tpz.path.patrol(npc, path)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local WildcatJeuno = player:getCharVar("WildcatJeuno")

    if player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatJeuno, 15) then
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
