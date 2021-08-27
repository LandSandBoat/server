-----------------------------------
-- Area: Bastok Markets
--  NPC: Khonzon
-- Type: Item Deliverer
-- !pos -323.744 -16.001 -88.698 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
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
