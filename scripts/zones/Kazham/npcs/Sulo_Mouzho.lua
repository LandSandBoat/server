-----------------------------------
-- Area: Kazham
--  NPC: Sulo Mouzho
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:sendMenu(xi.menuType.AUCTION)
end

return entity
