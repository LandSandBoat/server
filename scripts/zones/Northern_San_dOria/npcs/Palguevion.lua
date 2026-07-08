-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Palguevion
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.shop.handleRegionalShop(player, npc)
end

return entity
