-----------------------------------
-- Area: Bastok Markets
--  NPC: Foss
-- Starts & Finishes Repeatable Quest: Buckets of Gold
-- !pos -283 -12 -37 235
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BUCKETS_OF_GOLD) >= QUEST_ACCEPTED and npcUtil.tradeHas(trade, {{90, 5}})) then
        player:startEvent(272)
    end
end

entity.onTrigger = function(player, npc)
    if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BUCKETS_OF_GOLD) == QUEST_AVAILABLE) then
        player:startEvent(271)
    else
        player:startEvent(270)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 271 and option == 0) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BUCKETS_OF_GOLD)
    elseif (csid == 272) then
        local fame = player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BUCKETS_OF_GOLD) and 8 or 75
        if (npcUtil.completeQuest(player, BASTOK, xi.quest.id.bastok.BUCKETS_OF_GOLD, {title=xi.title.BUCKET_FISHER, gil=300, fame=fame})) then
            player:confirmTrade()
        end
    end
end

return entity
