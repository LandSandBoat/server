-----------------------------------
-- Area: Norg
--  NPC: Shidzue
-- Type: Weather Reporter
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(1005, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

return entity
