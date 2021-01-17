-----------------------------------
-- Area: Bastok Markets [S]
--  NPC: Karlotte
-- Type: Item Deliverer
-- !pos -191.646 -8 -36.349 87
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets_[S]/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.KARLOTTE_DELIVERY_DIALOG)
    player:openSendBox()
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
