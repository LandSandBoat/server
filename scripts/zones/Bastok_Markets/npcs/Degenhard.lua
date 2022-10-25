-----------------------------------
-- Area: Bastok Markets
--  NPC: Degenhard
-- Starts & Ends Quest: The Bare Bones
-- Involved in Quests: Beat Around the Bushin
-- !pos -175 2 -135 235
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY) >= QUEST_ACCEPTED and
        npcUtil.tradeHasExactly(trade, { xi.items.SEASONING_STONE, xi.items.FOSSILIZED_BONE, xi.items.FOSSILIZED_FANG })
    then
        player:startEvent(15)
    end
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY) == QUEST_ACCEPTED then
        player:startEvent(14)
    elseif player:getCharVar("BeatAroundTheBushin") == 3 then
        player:startEvent(342)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 15 then
        npcUtil.giveItem(player, xi.items.OLDE_RARAB_TAIL)
        player:confirmTrade()
    elseif csid == 342 then
        player:setCharVar("BeatAroundTheBushin", 4)
    end
end

return entity
