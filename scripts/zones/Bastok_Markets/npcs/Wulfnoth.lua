-----------------------------------
-- Area: Bastok Markets
--  NPC: Wulfnoth
-- Type: Goldsmithing Synthesis Image Support
-- !pos -211.937 -7.814 -56.292 235
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
