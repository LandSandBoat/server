-----------------------------------
-- Area: Bastok Mines
--  NPC: Galdeo
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.shop.handleRegionalShop(player, npc)
end

return entity
