-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Millechuca
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.shop.handleRegionalShop(player, npc)
end

return entity
