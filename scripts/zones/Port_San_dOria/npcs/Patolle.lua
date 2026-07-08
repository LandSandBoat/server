-----------------------------------
-- Area: Port San d'Oria
--  NPC: Patolle
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.shop.handleRegionalShop(player, npc)
end

return entity
