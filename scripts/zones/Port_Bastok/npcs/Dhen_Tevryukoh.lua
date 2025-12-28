-----------------------------------
-- Area: Port Bastok
--  NPC: Dhen Tevryukoh
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.shop.handleRegionalShop(player, npc)
end

return entity
