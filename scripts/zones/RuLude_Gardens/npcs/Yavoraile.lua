-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Yavoraile
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local path =
{
    26.778, 1.996, 70.493,
    26.778, 1.996, 70.493,
    26.778, 1.996, 70.493,
    26.778, 1.996, 70.493,
    26.778, 1.996, 70.493,
    26.778, 1.996, 70.493,
    26.778, 1.996, 70.493,
    26.778, 1.996, 70.493,
    26.778, 1.996, 70.493,
    29.529, 1.991, 66.675, -- Force turn.
    30.045, 1.991, 66.677,
    30.045, 1.991, 66.677,
    30.045, 1.991, 66.677,
    30.045, 1.991, 66.677,
    30.045, 1.991, 66.677,
    30.045, 1.991, 66.677,
    30.045, 1.991, 66.677,
    30.045, 1.991, 66.677,
    30.045, 1.991, 66.677,
    29.568, 1.991, 68.861, -- Force turn.
    30.173, 1.991, 68.864,
    30.173, 1.991, 68.864,
    30.173, 1.991, 68.864,
    30.173, 1.991, 68.864,
    30.173, 1.991, 68.864,
    30.173, 1.991, 68.864,
    30.173, 1.991, 68.864,
    30.173, 1.991, 68.864,
    30.173, 1.991, 68.864,
    27.243, 1.996, 70.500, -- Force turn.
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
        not utils.mask.getBit(wildcatJeuno, 4)
    then
        player:startEvent(10092)
    else
        player:startEvent(118)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10092 then
        player:setCharVar("WildcatJeuno", utils.mask.setBit(player:getCharVar("WildcatJeuno"), 4, true))
    end
end

return entity
