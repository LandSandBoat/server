-----------------------------------
-- Area: Windurst Walls
--  NPC: Jack of Diamonds
-- Adventurer's Assistant
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:getItemCount() == 1 and
        trade:hasItemQty(xi.item.ADVENTURER_COUPON, 1)
    then
        player:startEvent(10002, xi.settings.main.GIL_RATE * 50)
        player:addGil(xi.settings.main.GIL_RATE * 50)
        player:tradeComplete()
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(10001, 0, 2)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
