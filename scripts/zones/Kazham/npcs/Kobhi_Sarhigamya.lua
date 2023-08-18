-----------------------------------
-- Area: Kazham
--  NPC: Kobhi Sarhigamya
-- Type: Item Deliverer
-- !pos -115.29 -11 -22.609 250
-----------------------------------
local ID = zones[xi.zone.KAZHAM]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
