-----------------------------------
-- Area: Selbina
--  NPC: Boris
-- Type: Item Deliverer
-- !pos 61.074 -14.655 -7.1 248
-----------------------------------
local ID = zones[xi.zone.SELBINA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.BORIS_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
