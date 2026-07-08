-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Shahau
-- Type: Alchemy Image Support
-- !pos -10.470 -6.25 -141.700 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.crafting.ahtUhrganImageSupportOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.crafting.ahtUhrganImageSupportOnEventFinish(player, csid, option, npc)
end

return entity
