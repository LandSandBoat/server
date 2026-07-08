-----------------------------------
-- Area: Port Bastok
--  NPC: Zoby Quhyo
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.shop.handleRegionalShop(player, npc)
end

return entity
