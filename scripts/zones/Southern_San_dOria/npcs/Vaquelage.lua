-----------------------------------
-- Area: Southern San dOria
--  NPC: Vaquelage
-- Type: Item Deliverer NPC
-- !pos 17.396 1.699 -29.357 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
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
