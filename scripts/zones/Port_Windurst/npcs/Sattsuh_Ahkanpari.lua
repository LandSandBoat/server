-----------------------------------
-- Area: Port Windurst
--  NPC: Sattsuh Ahkanpari
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.shop.handleRegionalShop(player, npc)
end

return entity
