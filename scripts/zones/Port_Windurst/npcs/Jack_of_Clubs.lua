-----------------------------------
-- Area: Port Windurst
--  NPC: Jack of Clubs
-- Adventurer's Assistant
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if trade:getItemCount() == 1 and trade:hasItemQty(536, 1) then
        player:startEvent(10008, xi.settings.main.GIL_RATE * 50)
        player:addGil(xi.settings.main.GIL_RATE * 50)
        player:tradeComplete()
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(10007, 0, 3)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
