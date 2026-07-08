-----------------------------------
-- Area: Windurst Woods
--  NPC: Nya Labiccio
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.shop.handleRegionalShop(player, npc)
end

return entity
