-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Nembet
-- !pos 147 -3 110 80
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria_[S]/IDs")
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
