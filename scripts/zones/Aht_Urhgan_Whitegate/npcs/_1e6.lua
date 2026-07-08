-----------------------------------
-- Area: Aht Urhgan Whitegate
-- Door: Kokba Hostel
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(70)
end

return entity
