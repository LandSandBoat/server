-----------------------------------
-- Area: Lower Jeuno
--  NPC: Subash
-- Type: Item Deliverer
-- !pos -19.84 -0.101 -38.081 245
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
