-----------------------------------
-- Area: Bastok Markets
--  NPC: Fatimah
-- Type: Goldsmithing Adv. Synthesis Image Support
-- !pos -193.849 -7.824 -56.372 235
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
