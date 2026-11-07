-----------------------------------
-- Area: Bastok Mines
--  NPC: Tibelda
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    xi.shop.handleRegionalShop(player, npc)
end

return entity
