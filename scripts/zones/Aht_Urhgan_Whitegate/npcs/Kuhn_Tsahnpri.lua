-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Kuhn Tsahnpri
-- !pos 12.08 2 143.39 50
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.transport.onDockTimekeeperTrigger(player, npc)
end

return entity
