-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Tek Lengyon
-- Type: Leathercraft Synthesis Image Support
-- !pos -190.120 -2.999 2.770 230
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
