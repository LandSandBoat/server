-----------------------------------
-- Area: Rabao
--  NPC: Pakhi Churhebi
-- Type: Item Deliverer
-- !pos 158.428 7.999 78.009 247
-----------------------------------
local ID = zones[xi.zone.RABAO]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.PAKHI_DELIVERY_DIALOG)
    player:openSendBox()
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
