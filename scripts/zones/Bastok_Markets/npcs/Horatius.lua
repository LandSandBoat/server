-----------------------------------
-- Area: Bastok Markets
--  NPC: Horatius
-- Starts and Finishes: Breaking Stones
-- !pos -158 -6 -117 235
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BREAKING_STONES) >= QUEST_AVAILABLE and npcUtil.tradeHas(trade, 553) then
        player:startEvent(101)
    end
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BREAKING_STONES) == QUEST_AVAILABLE and player:getFameLevel(xi.quest.fame_area.BASTOK) >= 2 then
        player:startEvent(100)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 100 and option == 0 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BREAKING_STONES)
    elseif csid == 101 then
        if (npcUtil.completeQuest(player, xi.quest.log_id.BASTOK, xi.quest.id.bastok.BREAKING_STONES, {gil=400})) then
            player:confirmTrade()
        end
    end
end

return entity
