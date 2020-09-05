-----------------------------------
-- Area: Port Jeuno
--  NPC: Red Ghost
-- Standard Info NPC
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/pathfind")
-----------------------------------

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
function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrol(npc, path)
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local WildcatJeuno = player:getCharVar("WildcatJeuno")
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatJeuno, 15) == false) then
        player:startEvent(314)
    else
        player:startEvent(34)
    end

    -- wait until event is over
    npc:wait()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    if (csid == 314) then
        player:setMaskBit(player:getCharVar("WildcatJeuno"), "WildcatJeuno", 15, true)
    end

    npc:wait(0)

end
