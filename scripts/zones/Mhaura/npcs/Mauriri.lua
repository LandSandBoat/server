-----------------------------------
-- Area: Mhaura
--  NPC: Mauriri
-- Type: Item Deliverer
-- !pos 10.883    -15.99    66.186 249
-----------------------------------
local ID = zones[xi.zone.MHAURA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.MAURIRI_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
