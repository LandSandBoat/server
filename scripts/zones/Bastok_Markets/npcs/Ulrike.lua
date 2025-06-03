-----------------------------------
-- Area: Bastok Markets
--  NPC: Ulrike
-- Type: Goldsmithing Synthesis Image Support
-- !pos -218.399 -7.824 -56.203 235
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
