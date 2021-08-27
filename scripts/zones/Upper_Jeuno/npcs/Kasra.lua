-----------------------------------
-- Area: Upper Jeuno
--  NPC: Kasra
-- Type: Item Deliverer
-- !pos -34.555 7.999 90.702 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
