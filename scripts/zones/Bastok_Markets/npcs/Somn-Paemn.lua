-----------------------------------
-- Area: Bastok Markets
--  NPC: Somn-Paemn
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.shop.handleRegionalShop(player, npc)
end

return entity
