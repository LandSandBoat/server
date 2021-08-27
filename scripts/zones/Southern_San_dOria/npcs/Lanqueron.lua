-----------------------------------
-- Area: Southern San dOria
--  NPC: Lanqueron
-- Type: Item Deliverer NPC
-- Involved in Quest: Lost Chick
-- !pos 0.335 1.199 -28.404 230
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
