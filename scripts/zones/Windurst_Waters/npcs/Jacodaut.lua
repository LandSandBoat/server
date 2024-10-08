-----------------------------------
-- Area: Windurst Waters
--  NPC: Jacodaut
-- Type: Cooking Image Support
-- !pos -125.890 -2.999 62.499 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.crafting.oldImageSupportOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.crafting.oldImageSupportOnEventFinish(player, csid, option, npc)
end

return entity
