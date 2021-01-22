-----------------------------------
-- Area: Selbina
--  NPC: Boris
-- Type: Item Deliverer
-- !pos 61.074 -14.655 -7.1 248
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.BORIS_DELIVERY_DIALOG)
    player:openSendBox()
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
