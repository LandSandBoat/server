-----------------------------------
-- Area: Southern_San_dOria
--  NPC: Valeriano
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.shop.handleValerianoShop(player, npc)
end

return entity
