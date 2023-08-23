-----------------------------------
-- Area: GM Home
--  NPC: Trader
-- Type: Debug NPC for testing trades.
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if trade:hasItemQty(xi.item.FIRE_CRYSTAL, 1) and trade:getItemCount() == 1 then
        player:startEvent(126)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(127)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
