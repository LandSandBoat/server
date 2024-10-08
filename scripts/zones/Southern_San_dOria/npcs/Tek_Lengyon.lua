-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Tek Lengyon
-- Type: Leathercraft Synthesis Image Support
-- !pos -190.120 -2.999 2.770 230
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
