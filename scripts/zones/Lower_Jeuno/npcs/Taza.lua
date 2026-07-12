-----------------------------------
-- Area: Lower Jeuno
--  NPC: Taza
--  Basic lua script is kept for utilization in the lower_jeuno_vendors module
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.WAAG_DEEG_SHOP_DIALOG)
end

return entity
