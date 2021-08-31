-----------------------------------
-- Area: Bastok Markets
--  NPC: Aquillina
-- Starts & Finishes Repeatable Quest: A Flash In The Pan
-- Note: Reapeatable server-wide every 15 minutes.
-- !pos -97 -5 -81 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_FLASH_IN_THE_PAN) ~= QUEST_AVAILABLE and npcUtil.tradeHas(trade, {{768, 4}}) then
        if npc:getLocalVar("FlashInThePan") <= os.time() then
            player:startEvent(219)
        else
            player:startEvent(218)
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_FLASH_IN_THE_PAN) == QUEST_AVAILABLE then
        player:startEvent(217)
    else
        player:startEvent(116)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 217 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_FLASH_IN_THE_PAN)
    elseif csid == 219 then
        local fame = player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_FLASH_IN_THE_PAN) and 8 or 75
        if npcUtil.completeQuest(player, BASTOK, xi.quest.id.bastok.A_FLASH_IN_THE_PAN, {gil=100, fame=fame}) then
            player:confirmTrade()
            GetNPCByID(ID.npc.AQUILLINA):setLocalVar("FlashInThePan", os.time() + 900)
        end
    end
end
return entity
