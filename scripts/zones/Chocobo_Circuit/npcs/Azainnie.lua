-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Azainnie
-- !pos -60.623 -14.500 -133.451 70
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onStandsExitTrigger(player, 1)
end

return entity
