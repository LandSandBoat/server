-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Sajaaya
-- Type: Weather Reporter
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(502, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

return entity
