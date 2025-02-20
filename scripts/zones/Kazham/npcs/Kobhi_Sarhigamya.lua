-----------------------------------
-- Area: Kazham
--  NPC: Kobhi Sarhigamya
-- Type: Item Deliverer
-- !pos -115.29 -11 -22.609 250
-----------------------------------
local ID = zones[xi.zone.KAZHAM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
