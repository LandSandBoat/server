-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Matildie
-- Adventurer's Assistant
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:getItemCount() == 1 and
        trade:hasItemQty(xi.item.ADVENTURER_COUPON, 1)
    then
        player:startEvent(631)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(587)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 631 then
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 50)
    end
end

return entity
