-----------------------------------
-- Area: Port Windurst
--  NPC: Erabu-Fumulubu
-- Type: Fishing Synthesis Image Support
-- !pos -178.900 -2.789 76.200 240
-----------------------------------
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
