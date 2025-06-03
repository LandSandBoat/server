-----------------------------------
-- Area: Port Jeuno
--  NPC: Leffquen
-- Type: Weather Reporter
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(10022, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

return entity
