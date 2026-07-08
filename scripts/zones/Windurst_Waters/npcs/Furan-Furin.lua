-----------------------------------
-- Area: Windurst Waters
--  NPC: Furan-Furin
-- Type: Weather Reporter
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(10002, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

return entity
