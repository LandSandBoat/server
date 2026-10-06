-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Perdric
-- !pos -84.007 -14.500 -133.451 70
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onStandsExitTrigger(player, 3)
end

return entity
