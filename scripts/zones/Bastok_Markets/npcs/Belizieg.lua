-----------------------------------
-- Area: Bastok Markets
--  NPC: Belizieg
-- Type: Item Deliverer
-- !zone
-- !pos -323.673 -16.001 -49.930 235
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
