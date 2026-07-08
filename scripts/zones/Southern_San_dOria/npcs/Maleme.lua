-----------------------------------
-- Area: Southern San dOria
--  NPC: Maleme
-- Type: Weather Reporter
-- Involved in Quest: Flyers for Regine
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(632, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

return entity
