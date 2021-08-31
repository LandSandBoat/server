-----------------------------------
-- Area: Nashmau
--  NPC: Neneroon
-- Type: Item Deliverer
-- !pos -0.866    -5.999    36.942 53
-----------------------------------
local ID = require("scripts/zones/Nashmau/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.NENE_DELIVERY_DIALOG)
    player:openSendBox()
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
