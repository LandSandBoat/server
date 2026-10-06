-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Couzanne
-- !pos -107.947 -14.500 -133.451 70
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onStandsExitTrigger(player, 5)
end

return entity
