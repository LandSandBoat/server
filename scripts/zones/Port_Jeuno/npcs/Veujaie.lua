-----------------------------------
-- Area: Port Jeuno
--  NPC: Veujaie
-- Type: Item Deliverer
-- !pos -20.349 7.999 -2.888 246
-----------------------------------
local ID = zones[xi.zone.PORT_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
