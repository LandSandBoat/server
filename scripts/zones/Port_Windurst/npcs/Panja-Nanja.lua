-----------------------------------
-- Area: Port Windurst
--  NPC: Panja-Nanja
-- Type: Fishing Adv. Image Support
-- !pos -194.499 -3 58.692 240
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
