-----------------------------------
-- Area: Bastok Markets
--  NPC: Horatius
-- Type: Quest Giver
-- Starts and Finishes: Breaking Stones
-- !pos -158 -6 -117 235
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BREAKING_STONES) >= QUEST_AVAILABLE and npcUtil.tradeHas(trade, 553)) then
        player:startEvent(101)
    end
end

entity.onTrigger = function(player, npc)
    local WildcatBastok = player:getCharVar("WildcatBastok")

    if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatBastok, 12)) then
        player:startEvent(428)
    elseif (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BREAKING_STONES) == QUEST_AVAILABLE and player:getFameLevel(BASTOK) >= 2) then
        player:startEvent(100)
    else
        player:startEvent(110)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 100 and option == 0) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BREAKING_STONES)
    elseif (csid == 101) then
        if (npcUtil.completeQuest(player, BASTOK, xi.quest.id.bastok.BREAKING_STONES, {gil=400})) then
            player:confirmTrade()
        end
    elseif (csid == 428) then
        player:setCharVar("WildcatBastok", utils.mask.setBit(player:getCharVar("WildcatBastok"), 12, true))
    end
end

return entity
