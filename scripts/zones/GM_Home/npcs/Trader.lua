-----------------------------------
-- Area: GM Home
--  NPC: Trader
-- Type: Debug NPC for testing trades.
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if trade:hasItemQty(4096, 1) and trade:getItemCount() == 1 then
        player:startEvent(126)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(127)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
