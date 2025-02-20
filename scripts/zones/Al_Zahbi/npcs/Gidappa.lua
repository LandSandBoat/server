-----------------------------------
-- Area: Al Zahbi
--  NPC: Gidappa
-- Type: Clothcraft Normal/Adv. Image Support
-- !pos 70.228 -7 -54.089 48
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
