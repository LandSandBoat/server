-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Beadurinc
-- Type: Smithing Synthesis Image Support
-- !pos -182.300 10.999 146.650 231
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
