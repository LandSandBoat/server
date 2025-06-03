-----------------------------------
-- Area: Rabao
--  NPC: Pakhi Churhebi
-- Type: Item Deliverer
-- !pos 158.428 7.999 78.009 247
-----------------------------------
local ID = zones[xi.zone.RABAO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.PAKHI_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
