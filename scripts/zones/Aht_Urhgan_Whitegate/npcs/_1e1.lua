-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Salaheem's Sentinels (Door)
-- !pos 23 -6 -63 50
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    npc:openDoor()
end

return entity
