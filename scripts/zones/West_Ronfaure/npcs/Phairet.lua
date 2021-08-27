-----------------------------------
-- Area: West Ronfaure
--  NPC: Phairet
-- Involved in Quest: The Trader in the Forest
-- !pos -57 -1 -501 100
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local theTraderInTheforest = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_TRADER_IN_THE_FOREST)

    if theTraderInTheforest == QUEST_ACCEPTED and npcUtil.tradeHas(trade, xi.items.SUPPLIES_ORDER) then -- Trade Supplies Order
        player:startEvent(124)
    elseif theTraderInTheforest == QUEST_COMPLETED and npcUtil.tradeHas(trade, {{"gil", 50}}) and npcUtil.giveItem(player, xi.items.CLUMP_OF_BATAGREENS) then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    local theTraderInTheforest = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_TRADER_IN_THE_FOREST)
    local hasBatagreens = player:hasItem(xi.items.CLUMP_OF_BATAGREENS) -- Clump of Batagreens

    if theTraderInTheforest == QUEST_ACCEPTED then
        if hasBatagreens then
            player:startEvent(125)
        else
            player:startEvent(117)
        end
    elseif theTraderInTheforest == QUEST_COMPLETED or not hasBatagreens then
        player:startEvent(127, xi.items.CLUMP_OF_BATAGREENS)
    else
        player:startEvent(117)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 124 and npcUtil.giveItem(player, xi.items.CLUMP_OF_BATAGREENS) then
        player:confirmTrade()
    end
end

return entity
