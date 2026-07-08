-----------------------------------
-- Area: Bastok_Mines
--  NPC: Rodellieux
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.shop.handleRegionalShop(player, npc)
end

return entity
