-----------------------------------
-- Area: Port Windurst
--  NPC: Degong
-- Type: Fishing Synthesis Image Support
-- !pos -178.400 -3.835 60.480 240
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
