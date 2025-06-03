-----------------------------------
-- Area: Bastok Markets
--  NPC: Svana
-- Type: Weather Reporter
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(4, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

return entity
