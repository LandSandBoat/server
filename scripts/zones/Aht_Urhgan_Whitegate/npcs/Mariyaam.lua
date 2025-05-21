-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Mariyaam
-- Type: Item Deliverer
-- !pos -125 -6 90 50
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
