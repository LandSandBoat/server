    -----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Gennoue
-- Type: Weather Reporter
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(509, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

return entity
