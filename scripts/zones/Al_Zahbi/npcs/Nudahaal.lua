-----------------------------------
-- Area: Al Zahbi
--  NPC: Nudahaal
-- Type: Bonecraft Normal/Adv. Image Support
-- !pos -57.056 -7 -88.377 48
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.ahtUhrganImageSupportOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.crafting.ahtUhrganImageSupportOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.crafting.ahtUhrganImageSupportOnEventFinish(player, csid, option, npc)
end

return entity
