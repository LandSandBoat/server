-----------------------------------
-- Area: Upper Jeuno
--  NPC: Kasra
-- Type: Item Deliverer
-- !pos -34.555 7.999 90.702 244
-----------------------------------
local ID = zones[xi.zone.UPPER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
