-----------------------------------
-- Area: Valkurm Dunes
--  NPC: Barnacled Box
-- Part of Pirate's chart miniquest fight
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    return xi.piratesChart.barnacledBoxOnTrigger(player, npc)
end

return entity
