-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Kazween
-- Type: Item Deliverer
-- !pos -130 -6 95 50
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
