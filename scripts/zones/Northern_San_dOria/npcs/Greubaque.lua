-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Greubaque
-- Type: Smithing Adv. Synthesis Image Support
-- !pos -179.400 10.999 150.000 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.crafting.oldImageSupportOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.crafting.oldImageSupportOnEventFinish(player, csid, option, npc)
end

return entity
