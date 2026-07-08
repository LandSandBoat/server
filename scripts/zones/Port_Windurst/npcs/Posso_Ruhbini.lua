-----------------------------------
-- Area: Port Windurst
--  NPC: Posso Ruhbini
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.shop.handleRegionalShop(player, npc)
end

return entity
