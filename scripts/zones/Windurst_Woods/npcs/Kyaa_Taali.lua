-----------------------------------
-- Area: Windurst Woods
--  NPC: Kyaa Taali
-- Type: Bonecraft Image Support
-- !pos -10.470 -6.25 -141.700 241
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
