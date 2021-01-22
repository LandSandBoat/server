-----------------------------------
-- Area: Bastok Markets [S]
--  NPC: Weldon
-- Type: Item Deliverer
-- !pos -191.575    -8    36.688 87
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets_[S]/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.WELDON_DELIVERY_DIALOG)
    player:openSendBox()
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
