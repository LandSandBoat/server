-----------------------------------
-- Area: Lower Jeuno
--  NPC: Mesukiki
-- Type: Item Deliverer
-- !pos -19.832 -0.101 -39.075 245
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
