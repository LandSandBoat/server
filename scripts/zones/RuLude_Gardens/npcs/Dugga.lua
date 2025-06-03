-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Dugga
-- Type: Item Deliverer
-- !pos -55.429 5.999 1.27 243
-----------------------------------
local ID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
