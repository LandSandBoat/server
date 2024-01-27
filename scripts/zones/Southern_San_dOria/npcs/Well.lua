-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Well
-- Involved in Quest: Grave Concerns
-- !pos -129 -6 92 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GRAVE_CONCERNS) == QUEST_ACCEPTED then
        if
            trade:hasItemQty(xi.item.TOMB_GUARDS_WATERSKIN, 1) and
            trade:getItemCount() == 1
        then
            player:tradeComplete()
            player:addItem(xi.item.SKIN_OF_WELL_WATER)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.SKIN_OF_WELL_WATER) -- Tomb Waterskin
        end
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
