-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Ghye Dachanthu
-- Type: Item Deliverer
-- !pos -62.789 11.999 -25.959 243
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
