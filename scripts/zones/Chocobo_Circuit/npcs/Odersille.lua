-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Odersille
-- !pos -11.523 -14.500 -133.451 70
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onStandsExitTrigger(player, 4)
end

return entity
