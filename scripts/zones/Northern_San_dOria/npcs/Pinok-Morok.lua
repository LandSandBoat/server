-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Pinok-Morok
-- Type: Smithing Synthesis Image Support
-- !pos -186.650 10.25 148.380 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.crafting.freeImageSupportOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.crafting.freeImageSupportOnEventFinish(player, csid, option, npc)
end

return entity
