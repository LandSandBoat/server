-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Auction Counter
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:sendMenu(xi.menuType.AUCTION)
end

return entity
