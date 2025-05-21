-----------------------------------
-- Area: Port Jeuno
--  NPC: Digaga
-- Type: Item Deliverer
-- !pos -52.865 7.999 1.134 246
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
