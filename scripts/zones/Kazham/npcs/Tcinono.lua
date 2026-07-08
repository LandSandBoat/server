-----------------------------------
-- Area: Kazham
--  NPC: Tcinono
-- Type: Weather Reporter
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(10011, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

return entity
