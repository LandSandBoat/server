-----------------------------------
-- Area: GM Home
--  NPC: Trader
-- Type: Debug NPC for testing trades.
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if trade:hasItemQty(xi.item.FIRE_CRYSTAL, 1) and trade:getItemCount() == 1 then
        player:startEvent(126)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(127)
end

return entity
