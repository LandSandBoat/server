-----------------------------------
-- Area: Port San d'Oria
--  NPC: Bonmaurieut
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.shop.handleRegionalShop(player, npc)
end

return entity
