-----------------------------------
-- Area: Mhaura
--  NPC: Mauriri
-- Type: Item Deliverer
-- !pos 10.883    -15.99    66.186 249
-----------------------------------
local ID = require("scripts/zones/Mhaura/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.MAURIRI_DELIVERY_DIALOG)
    player:openSendBox()
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
