-----------------------------------
-- Area: Castle Zvahl Baileys [S]
--  NPC: Iron Bar Gate
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    npc:openDoor(18)
end

return entity
