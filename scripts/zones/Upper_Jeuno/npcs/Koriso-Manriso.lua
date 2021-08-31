-----------------------------------
-- Area: Upper Jeuno
--  NPC: Koriso-Manriso
-- Type: Item Deliverer
-- !pos -64.39 1 23.704 244
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
