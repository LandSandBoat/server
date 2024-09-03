-----------------------------------
-- Area: King Ranperre's Tomb
--  NPC: Tombstone (Upper)
-- Involved in Quest: Grave Concerns
-- !pos 1 0.1 -101 190
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.GRAVE_CONCERNS) == xi.questStatus.QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, xi.item.SKIN_OF_WELL_WATER) -- Well Water
    then
        player:startEvent(3)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(2)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 2 and
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.GRAVE_CONCERNS) == xi.questStatus.QUEST_ACCEPTED and
        not player:hasItem(xi.item.TOMB_GUARDS_WATERSKIN) and
        not player:hasItem(xi.item.SKIN_OF_WELL_WATER) and
        npcUtil.giveItem(player, xi.item.TOMB_GUARDS_WATERSKIN) -- Tomb Waterskin
    then
        -- no further action needed
    elseif csid == 3 and npcUtil.giveItem(player, xi.item.TOMB_GUARDS_WATERSKIN) then
        player:confirmTrade()
        player:setCharVar('OfferingWaterOK', 1)
    end
end

return entity
