-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Ghye Dachanthu
-- Type: Item Deliverer
-- !pos -62.789 11.999 -25.959 243
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
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
