-----------------------------------
-- Area: Castle Zvahl Baileys [S]
--  NPC: Iron Bar Gate
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    npc:openDoor(18)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
