-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Flige
-- !pos -35.647 -14.500 -133.451 70
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onStandsExitTrigger(player, 2)
end

return entity
